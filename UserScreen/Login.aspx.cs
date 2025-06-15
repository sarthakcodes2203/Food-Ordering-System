using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserScreen_Login : System.Web.UI.Page
{
    DBConnect dbcon = new DBConnect();
    SqlCommand cmd;
    DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userId"] != null)
            {
                Response.Redirect("UserHome.aspx");
            }
	    }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (txtUsername.Text.Trim() == "Admin" && txtPassword.Text.Trim() == "123")
        {
            Session["Admin"] = txtUsername.Text.Trim();
            Response.Redirect("../AdminScreen/AdminHome.aspx");
        }
        else
        {
            cmd = new SqlCommand("User_Crud", dbcon.GetCon());
            cmd.Parameters.AddWithValue("@Action", "SELECT4LOGIN");
            cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
            cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
            cmd.CommandType = CommandType.StoredProcedure;
            dt = dbcon.Load_Data(cmd);
            if (dt.Rows.Count == 1){
                Session["name"] = dt.Rows[0]["Name"];
                Session["username"] = txtUsername.Text.Trim();
                Session["userId"] = dt.Rows[0]["UserId"];
		        Session["mailId"] = dt.Rows[0]["Email"].ToString();
                Response.Redirect("UserHome.aspx");
            }else{
                lblMsg.Visible = true;
                lblMsg.Text = "Invalid Credentials..!";
                lblMsg.CssClass = "alert alert-danger";
            }
        }
    }
}