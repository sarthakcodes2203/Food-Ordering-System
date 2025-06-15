using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminScreen_User : System.Web.UI.Page
{
    DBConnect dbcon = new DBConnect();
    SqlCommand cmd;
    DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["breadCrumb"] = "Users";
            if (Session["Admin"] == null)
            {
                Response.Redirect("../UserScreen/UserHome.aspx");
            }
            else
            {
                getUsers();
            }
        }
    }

    private void getUsers()
    {
        cmd = new SqlCommand("User_Crud", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", "SELECT4ADMIN");
        cmd.CommandType = CommandType.StoredProcedure;
        rptrUser.DataSource = dbcon.Load_Data(cmd);
        rptrUser.DataBind();
    }

    protected void rptrUser_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        lblMsg.Visible = false;
        if (e.CommandName == "delete")
        {
            cmd = new SqlCommand("User_Crud", dbcon.GetCon());
            cmd.Parameters.AddWithValue("@Action", "DELETE");
            cmd.Parameters.AddWithValue("@CategoryId", e.CommandArgument);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                dbcon.OpenCon();
                cmd.ExecuteNonQuery();
                lblMsg.Visible = true;
                lblMsg.Text = "User deleted Successfully!";
                lblMsg.CssClass = "alert alert-success";
                getUsers();
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
}