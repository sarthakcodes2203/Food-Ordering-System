using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserScreen_Contact : System.Web.UI.Page
{
    DBConnect dbcon = new DBConnect();
    SqlCommand cmd;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            try
            {
                cmd = new SqlCommand("Contacts", dbcon.GetCon());
                cmd.Parameters.AddWithValue("@Action", "INSERT");
                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Subject", txtSubject.Text.Trim());
                cmd.Parameters.AddWithValue("@Message", txtMessage.Text.Trim());
                cmd.CommandType = CommandType.StoredProcedure;
                dbcon.OpenCon();
                cmd.ExecuteNonQuery();
                lblMsg.Visible = true;
                lblMsg.Text = "Thanks for letting us know!";
                lblMsg.CssClass = "alert alert-success";
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + " ');</script>");
            }
            finally
            {
                dbcon.CloseCon();
                clear();
            }
        }
    }

    private void clear()
    {
        txtName.Text = string.Empty;
        txtEmail.Text = string.Empty;
        txtSubject.Text = string.Empty;
        txtMessage.Text = string.Empty;
    }
}