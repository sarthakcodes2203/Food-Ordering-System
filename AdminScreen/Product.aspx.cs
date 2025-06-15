﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminScreen_Product : System.Web.UI.Page
{
    DBConnect dbcon = new DBConnect();
    SqlCommand cmd;
    DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["breadCrumb"] = "Products";
            if (Session["Admin"] == null)
            {
                Response.Redirect("../UserScreen/UserHome.aspx");
            }
            else
            {
                getProducts();
            }
        }
    }

    protected void btnAddOrUpdate_Click(object sender, EventArgs e)
    {
        string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
        bool isValidToExecute = false;
        int productId = Convert.ToInt32(hdnId.Value);
        cmd = new SqlCommand("Product_Crud", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", productId == 0 ? "INSERT" : "UPDATE");
        cmd.Parameters.AddWithValue("@ProductId", productId);
        cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
        cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
        cmd.Parameters.AddWithValue("@Price", txtPrice.Text);
        cmd.Parameters.AddWithValue("@Quantity", txtQuantity.Text);
        cmd.Parameters.AddWithValue("@CategoryId", ddlCategory.SelectedValue);
        cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);
        if (fuProductImage.HasFile)
        {
            if (Utils.IsValidExtension(fuProductImage.FileName))
            {
                Guid obj = Guid.NewGuid();
                fileExtension = Path.GetExtension(fuProductImage.FileName);
                string folderPath = Server.MapPath("../Images/");

                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(Path.Combine(folderPath, "Product"));

                imagePath = "Images/Product/" + obj.ToString() + fileExtension;
                fuProductImage.PostedFile.SaveAs(Server.MapPath("~/Images/Product/") + obj.ToString() + fileExtension);
                cmd.Parameters.AddWithValue("@ImageUrl", imagePath);
                isValidToExecute = true;
            }
            else
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Please select .jpg, .jpeg or .png image";
                lblMsg.CssClass = "alert alert-danger";
                isValidToExecute = false;
            }
        }
        else
        {
            isValidToExecute = true;
        }

        if (isValidToExecute)
        {
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                dbcon.OpenCon();
                cmd.ExecuteNonQuery();
                actionName = productId == 0 ? "inserted" : "updated";
                lblMsg.Visible = true;
                lblMsg.Text = "Product " + actionName + " Successfully!";
                lblMsg.CssClass = "alert alert-success";
                getProducts();
                clear();
            }
            catch (Exception ex)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Error - " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
            finally
            {
                dbcon.CloseCon();
            }
        }
    }

    private void getProducts()
    {
        cmd = new SqlCommand("Product_Crud", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", "SELECT");
        cmd.CommandType = CommandType.StoredProcedure;
        rptrProduct.DataSource = dbcon.Load_Data(cmd);
        rptrProduct.DataBind();
    }

    private void clear()
    {
        txtName.Text = imgProduct.ImageUrl = txtDescription.Text = txtPrice.Text = txtQuantity.Text = string.Empty;
        ddlCategory.ClearSelection();
        imgProduct.Visible = false;
        cbIsActive.Checked = false;
        hdnId.Value = "0";
        btnAddOrUpdate.Text = "Add";
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        clear();
    }

    protected void rptrProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        lblMsg.Visible = false;
        if (e.CommandName == "edit")
        {
            imgProduct.Visible = true;
            cmd = new SqlCommand("Product_Crud", dbcon.GetCon());
            cmd.Parameters.AddWithValue("@Action", "GETBYID");
            cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
            cmd.CommandType = CommandType.StoredProcedure;
            dt = dbcon.Load_Data(cmd);
            txtName.Text = dt.Rows[0]["Name"].ToString();
            cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["IsActive"]);
            imgProduct.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ImageUrl"].ToString()) ? "../Images/NoImage.png" : "../" + dt.Rows[0]["ImageUrl"].ToString();
            imgProduct.Height = 200;
            imgProduct.Width = 200;
            hdnId.Value = dt.Rows[0]["ProductId"].ToString();
            btnAddOrUpdate.Text = "Update";
            LinkButton btn = e.Item.FindControl("lnkEdit") as LinkButton;
            btn.CssClass = "badge badge-warning";
        }
        else if (e.CommandName == "delete")
        {
            cmd = new SqlCommand("Product_Crud", dbcon.GetCon());
            cmd.Parameters.AddWithValue("@Action", "DELETE");
            cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                dbcon.OpenCon();
                cmd.ExecuteNonQuery();
                lblMsg.Visible = true;
                lblMsg.Text = "Category deleted Successfully!";
                lblMsg.CssClass = "alert alert-success";
                getProducts();
            }
            catch (Exception ex)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Error - " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
            finally
            {
                dbcon.CloseCon();
            }
        }
    }

    protected void rptrProduct_ItemDataBound(object source, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label lblIsActive = e.Item.FindControl("lblIsActive") as Label;
            Label lblQuantity = e.Item.FindControl("lblQuantity") as Label;
            if (lblIsActive.Text == "True")
            {
                lblIsActive.Text = "Active";
                lblIsActive.CssClass = "badge badge-success";
            }
            else
            {
                lblIsActive.Text = "In-Active";
                lblIsActive.CssClass = "badge badge-danger";
            }

            if (Convert.ToInt32(lblQuantity.Text) <= 5)
            {
                lblQuantity.CssClass = "badge badge-danger";
                lblQuantity.ToolTip = "Item about to be 'Out of Stock'!";
            }
        }
    }
}