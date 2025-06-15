using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminScreen_Category : System.Web.UI.Page
{
    DBConnect dbcon = new DBConnect();
    SqlCommand cmd;
    DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["breadCrumb"] = "Categories";
            if (Session["Admin"] == null)
            {
                Response.Redirect("../UserScreen/UserHome.aspx");
            }
            else
            {
                getCategories();
            }
        }
    }

    protected void btnAddOrUpdate_Click(object sender, EventArgs e)
    {
        string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
        bool isValidToExecute = false;
        int categoryId = Convert.ToInt32(hdnId.Value);
        cmd = new SqlCommand("Category_Crud", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", categoryId == 0 ? "INSERT" : "UPDATE");
        cmd.Parameters.AddWithValue("@CategoryId", categoryId);
        cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
        cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);
        if (fuCategoryImage.HasFile)
        {
            if (Utils.IsValidExtension(fuCategoryImage.FileName))
            {
                Guid obj = Guid.NewGuid();
                fileExtension = Path.GetExtension(fuCategoryImage.FileName);
                string folderPath = Server.MapPath("../Images/");

                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(Path.Combine(folderPath, "Category"));

                imagePath = "Images/Category/" + obj.ToString() + fileExtension;
                fuCategoryImage.PostedFile.SaveAs(Server.MapPath("~/Images/Category/") + obj.ToString() + fileExtension);
                cmd.Parameters.AddWithValue("@ImageUrl", imagePath);
                isValidToExecute = true;
            }
            else
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Please select -jpg, -jpeg or .png image";
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
                actionName = categoryId == 0 ? "inserted" : "updated";
                lblMsg.Visible = true;
                lblMsg.Text = "Category " + actionName + " Successfully!";
                lblMsg.CssClass = "alert alert-success";
                getCategories();
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

    private void getCategories()
    {
        cmd = new SqlCommand("Category_Crud", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", "SELECT");
        cmd.CommandType = CommandType.StoredProcedure;
        rptrCategory.DataSource = dbcon.Load_Data(cmd);
        rptrCategory.DataBind();
    }

    private void clear()
    {
        txtName.Text = imgCategory.ImageUrl = string.Empty;
        imgCategory.Visible = false;
        cbIsActive.Checked = false;
        hdnId.Value = "0";
        btnAddOrUpdate.Text = "Add";
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        clear();
    }

    protected void rptrCategory_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        lblMsg.Visible = false;
        if (e.CommandName == "edit")
        {
            imgCategory.Visible = true;
            cmd = new SqlCommand("Category_Crud", dbcon.GetCon());
            cmd.Parameters.AddWithValue("@Action", "GETBYID");
            cmd.Parameters.AddWithValue("@CategoryId", e.CommandArgument);
            cmd.CommandType = CommandType.StoredProcedure;
            dt = dbcon.Load_Data(cmd);
            txtName.Text = dt.Rows[0]["Name"].ToString();
            cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["IsActive"]);
            imgCategory.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ImageUrl"].ToString()) ? "../Images/NoImage.png" : "../" + dt.Rows[0]["ImageUrl"].ToString();
            imgCategory.Height = 200;
            imgCategory.Width = 200;
            hdnId.Value = dt.Rows[0]["CategoryId"].ToString();
            btnAddOrUpdate.Text = "Update";
            LinkButton btn = e.Item.FindControl("lnkEdit") as LinkButton;
            btn.CssClass = "badge badge-warning";
        }
        else if (e.CommandName == "delete")
        {
            cmd = new SqlCommand("Category_Crud", dbcon.GetCon());
            cmd.Parameters.AddWithValue("@Action", "DELETE");
            cmd.Parameters.AddWithValue("@CategoryId", e.CommandArgument);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                dbcon.OpenCon();
                cmd.ExecuteNonQuery();
                lblMsg.Visible = true;
                lblMsg.Text = "Category deleted Successfully!";
                lblMsg.CssClass = "alert alert-success";
                getCategories();
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

    protected void rptrCategory_ItemDataBound(object source, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label lbl = e.Item.FindControl("lblIsActive") as Label;
            if (lbl.Text == "True")
            {
                lbl.Text = "Active";
                lbl.CssClass = "badge badge-success";
            }
            else
            {
                lbl.Text = "In-Active";
                lbl.CssClass = "badge badge-danger";
            }
        }
    }
}