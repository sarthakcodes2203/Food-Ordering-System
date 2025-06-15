using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminScreen_Contacts : System.Web.UI.Page
{
    DBConnect dbcon = new DBConnect();
    SqlCommand cmd;
    DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["breadCrumb"] = "Contact Users";
            if (Session["Admin"] == null)
            {
                Response.Redirect("../UserScreen/UserHome.aspx");
            }
            else
            {
                getContacts();
            }
        }
    }

    private void getContacts()
    {
        cmd = new SqlCommand("Contacts", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", "SELECT");
        cmd.CommandType = CommandType.StoredProcedure;
        rContacts.DataSource = dbcon.Load_Data(cmd);
        rContacts.DataBind();
    }

    protected void rContacts_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        lblMsg.Visible = false;
        if (e.CommandName == "delete")
        {
            cmd = new SqlCommand("Contacts", dbcon.GetCon());
            cmd.Parameters.AddWithValue("@Action", "DELETE");
            cmd.Parameters.AddWithValue("@ContactId", e.CommandArgument);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                dbcon.OpenCon();
                cmd.ExecuteNonQuery();
                lblMsg.Visible = true;
                lblMsg.Text = "Record deleted Successfully!";
                lblMsg.CssClass = "alert alert-success";
                getContacts();
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