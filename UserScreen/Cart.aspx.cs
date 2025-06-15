﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserScreen_Cart : System.Web.UI.Page
{
    DBConnect dbcon = new DBConnect();
    SqlCommand cmd;
    DataTable dt;

    decimal grandTotal = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if(Session["userId"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                getCartItems();
            }
        }
    }

    void getCartItems()
    {
        cmd = new SqlCommand("Cart_Crud", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", "SELECT");
        cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
        cmd.CommandType = CommandType.StoredProcedure;
        dt = dbcon.Load_Data(cmd);
        rCartItem.DataSource = dt;
        if (dt.Rows.Count == 0)
        {
            rCartItem.FooterTemplate = null;
            rCartItem.FooterTemplate = new CustomTemplate(ListItemType.Footer);
        }
        rCartItem.DataBind();
    }

    protected void rCartItem_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        Utils utils = new Utils();
        if (e.CommandName == "remove")
        {
            cmd = new SqlCommand("Cart_Crud", dbcon.GetCon());
            cmd.Parameters.AddWithValue("@Action", "DELETE");
            cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
            cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                dbcon.OpenCon();
                cmd.ExecuteNonQuery();
                getCartItems();
                Session["cartCount"] = utils.cartCount(Convert.ToInt32(Session["userId"]));
            }
            catch (Exception ex)
            {
                System.Web.HttpContext.Current.Response.Write("<script>alert('Error - " + ex.Message + " ');</script>");
            }
            finally
            {
                dbcon.CloseCon();
            }
        }
        if(e.CommandName == "updateCart")
        {
            bool isCartUpdated = false;
            for(int item = 0; item < rCartItem.Items.Count; item++)
            {
                if (rCartItem.Items[item].ItemType == ListItemType.Item || rCartItem.Items[item].ItemType == ListItemType.AlternatingItem)
                {
                    TextBox quantity = rCartItem.Items[item].FindControl("txtQuantity") as TextBox;
                    HiddenField _productId = rCartItem.Items[item].FindControl("hdnProductId") as HiddenField;
                    HiddenField _quantity= rCartItem.Items[item].FindControl("hdnQuantity") as HiddenField;
                    int quantityFromCart = Convert.ToInt32(quantity.Text);
                    int productId = Convert.ToInt32(_productId.Value);
                    int quantityFromDB = Convert.ToInt32(_quantity.Value);
                    bool isTrue = false;
                    int updatedQuantity = 1;
                    if (quantityFromCart > quantityFromDB)
                    {
                        updatedQuantity = quantityFromCart;
                        isTrue = true;
                    }
                    else if (quantityFromCart < quantityFromDB)
                    {
                        updatedQuantity = quantityFromCart;
                        isTrue = true;
                    }
                    if (isTrue)
                    {
                        //update cart items quantity items in db
                        isCartUpdated = utils.updateCartQuantity(updatedQuantity, productId, Convert.ToInt32(Session["userId"]));
                    }
                }

            }
            getCartItems();
        }
        if (e.CommandName == "checkout")
        {
            bool isTrue = false;
            string pName = string.Empty;
            for (int item = 0; item < rCartItem.Items.Count; item++)
            {
                if (rCartItem.Items[item].ItemType == ListItemType.Item || rCartItem.Items[item].ItemType == ListItemType.AlternatingItem)
                {
                    HiddenField _productId = rCartItem.Items[item].FindControl("hdnProductId") as HiddenField;
                    HiddenField _cartQuantity = rCartItem.Items[item].FindControl("hdnQuantity") as HiddenField;
                    HiddenField _productQuantity = rCartItem.Items[item].FindControl("hdnPrdQuantity") as HiddenField;
                    Label productName = rCartItem.Items[item].FindControl("lblName") as Label;
                    int productId = Convert.ToInt32(_productId.Value);
                    int cartQuantity = Convert.ToInt32(_cartQuantity.Value);
                    int productQuantity = Convert.ToInt32(_productQuantity.Value);
                    if (productQuantity > cartQuantity && productQuantity > 2)
                    {
                        isTrue = true;
                    }
                    else
                    {
                        isTrue = false;
                        pName = productName.Text.ToString();
                        break;
                    }
                }

            }
            if (isTrue)
            {
                Response.Redirect("Payment.aspx");
            }
            else
            {
                lblMsg.Visible = true;
                lblMsg.Text = "UhOh! Item <b>'" + pName + "'</b> out of stock :(";
                lblMsg.CssClass = "alert alert-warning";
            }
        }

    }

    protected void rCartItem_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if(e.Item.ItemType==ListItemType.Item || e.Item.ItemType==ListItemType.AlternatingItem)
        {
            Label totalPrice = e.Item.FindControl("lblTotalPrice") as Label;
            Label productPrice = e.Item.FindControl("lblPrice") as Label;
            TextBox quantity = e.Item.FindControl("txtQuantity") as TextBox;
            decimal calTotapPrice = Convert.ToDecimal(productPrice.Text) * Convert.ToDecimal(quantity.Text);
            totalPrice.Text = calTotapPrice.ToString();
            grandTotal += calTotapPrice;
        }
        Session["grandTotalPrice"] = grandTotal;
    }

    private sealed class CustomTemplate : ITemplate
    {
        private ListItemType ListItemType { get; set; }

        public CustomTemplate(ListItemType type)
        {
            ListItemType = type;
        }

        public void InstantiateIn(Control container)
        {
            if (ListItemType == ListItemType.Footer)
            {
                var footer = new LiteralControl("<tr><td colspan='5'><b>Your basket is all empty!</b> </br> <a href='Menu.aspx' class='badge badge-info ml-2' style=' margin-top: 10px; padding: 8px 16px; font-size: 14px;'>Add items to order.</a></td></tr></tbody></table>");

                container.Controls.Add(footer);
            }
        }
    }

}
