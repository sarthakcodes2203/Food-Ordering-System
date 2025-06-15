using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserScreen_Menu : System.Web.UI.Page
{
    DBConnect dbcon = new DBConnect();
    SqlCommand cmd;
    DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getCategories();
            getProducts();
        }
    }

    private void getProducts()
    {
        cmd = new SqlCommand("Product_Crud", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", "ACTIVEPROD");
        cmd.CommandType = CommandType.StoredProcedure;
        rProducts.DataSource = dbcon.Load_Data(cmd);
        rProducts.DataBind();
        //cmd = new SqlCommand("Product_Crud", dbcon.GetCon());
        //cmd.Parameters.AddWithValue("@Action", "ACTPRODUCT");
        //cmd.CommandType = CommandType.StoredProcedure;
        //rProducts.DataSource = dbcon.Load_Data(cmd);
        //rProducts.DataBind();
    }

    private void getCategories()
    {
        cmd = new SqlCommand("Category_Crud", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", "ACTIVECAT");
        cmd.CommandType = CommandType.StoredProcedure;
        rCategory.DataSource = dbcon.Load_Data(cmd);
        rCategory.DataBind();
    }

    int isItemExistInCart(int productId)
    {
        cmd = new SqlCommand("Cart_Crud", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", "GETBYID");
        cmd.Parameters.AddWithValue("@ProductId", productId);
        cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
        cmd.CommandType = CommandType.StoredProcedure;
        dt = dbcon.Load_Data(cmd);

        int quantity = 0;
        if (dt.Rows.Count > 0)
        {
            quantity = Convert.ToInt32(dt.Rows[0]["Quantity"]);
        }
        return quantity;
    }

    protected void rProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (Session["userId"] != null)
        {
            bool isCartItemUpdated = false;
            int i = isItemExistInCart(Convert.ToInt32(e.CommandArgument));
            if (i == 0)
            {
                //Adding new item to cart
                cmd = new SqlCommand("Cart_Crud", dbcon.GetCon());
                cmd.Parameters.AddWithValue("@Action", "INSERT");
                cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                cmd.Parameters.AddWithValue("@Quantity", 1);
                cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    dbcon.OpenCon();
                    cmd.ExecuteNonQuery();
                }
                catch(Exception ex)
                {
                    Response.Write("<script>alert('Error - "+ ex.Message +" ');</script>");
                }
                finally
                {
                    dbcon.CloseCon();
                }
            }
            else
            {
                //Updating the existing cart
                Utils utils = new Utils();
                isCartItemUpdated = utils.updateCartQuantity(i+1, Convert.ToInt32(e.CommandArgument),Convert.ToInt32(Session["userId"]));
            }
            //lblMsg.Visible = true;
            //lblMsg.Text = "Item added successfully in basket!";
            //lblMsg.CssClass = "alert alert-success";
            //Response.AddHeader("REFRESH", "1;URL=Cart.aspx");

            lblMsg.Visible = true;
            lblMsg.Text = "Item added successfully in basket!";
            lblMsg.CssClass = "notification-message alert alert-success";

            string script = @"
                    document.getElementById('notification-container').style.display = 'block';
                    setTimeout(function() {
                        var notification = document.getElementById('" + lblMsg.ClientID + @"');
                        notification.classList.add('fade-out');
                        setTimeout(function() {
                            window.location = 'Cart.aspx';
                        }, 500); // Wait for fade-out animation to complete
                    }, 1000); // Show notification for 1 second
                ";

            ClientScript.RegisterStartupScript(this.GetType(), "ShowNotification", script, true);
        }
        else
        {
            Response.Redirect("Login.aspx");
        }
    }

}   