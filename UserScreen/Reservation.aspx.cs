using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserScreen_Reservation : System.Web.UI.Page
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
                cmd = new SqlCommand("Reservations", dbcon.GetCon());
                cmd.Parameters.AddWithValue("@Action", "INSERT");
                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@PhoneNo", txtMobile.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Status", "Pending");
                cmd.Parameters.AddWithValue("@NumOfPersons", ddlPersons.SelectedValue);
                //cmd.Parameters.AddWithValue("@Restaurant", ddlRestaurants.SelectedValue);
                cmd.Parameters.AddWithValue("@ForDate", Convert.ToDateTime(txtDate.Text));
                cmd.Parameters.AddWithValue("@ForTime", Convert.ToDateTime(txtTimeSlot.Text));

                cmd.CommandType = CommandType.StoredProcedure;
                dbcon.OpenCon();
                cmd.ExecuteNonQuery();

                DateTime date = DateTime.Parse(txtDate.Text);
                DateTime time = DateTime.Parse(txtTimeSlot.Text);
                Email.SendEmail(txtEmail.Text.Trim(), txtName.Text.Trim(), "New Request", date.ToString("dd/MMM/yy"), time.ToString("hh:mm tt"), ddlPersons.SelectedValue, txtMobile.Text.Trim());

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
        txtMobile.Text = string.Empty;
        txtEmail.Text = string.Empty;
        ddlPersons.ClearSelection(); // clears dropdown selection
        //ddlRestaurants.ClearSelection();
        txtDate.Text = string.Empty;
        txtTimeSlot.Text = string.Empty;
    }

}