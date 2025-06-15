using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminScreen_Reservations : System.Web.UI.Page
{

    DBConnect dbcon = new DBConnect();
    SqlCommand cmd;
    DataTable dt;
    string mailid, name, persons, contact, date, time;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["breadCrumb"] = "Order Status";
            if (Session["Admin"] == null)
            {
                Response.Redirect("../UserScreen/UserHome.aspx");
            }
            else
            {
                getReservationStatus();
            }
        }
        lblMsg.Visible = false;
        pUpdateReservationStatus.Visible = false;
    }

    //protected  void getReservation()
    //{
    //    cmd = new SqlCommand("Reservations", dbcon.GetCon());
    //    cmd.Parameters.AddWithValue("@Action", "SELECT");
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    rptrReservations.DataSource = dbcon.Load_Data(cmd);
    //    rptrReservations.DataBind();
    //}

    //protected void rptrReservations_ItemCommand(object source, RepeaterCommandEventArgs e)
    //{
    //    lblMsg.Visible = false;
    //    if (e.CommandName == "delete")
    //    {
    //        cmd = new SqlCommand("Reservations", dbcon.GetCon());
    //        cmd.Parameters.AddWithValue("@Action", "DELETE");
    //        cmd.Parameters.AddWithValue("@ReservationId", e.CommandArgument);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        try
    //        {
    //            dbcon.OpenCon();
    //            cmd.ExecuteNonQuery();
    //            lblMsg.Visible = true;
    //            lblMsg.Text = "Reservation deleted Successfully!";
    //            lblMsg.CssClass = "alert alert-success";
    //            getReservation();
    //        }
    //        catch (Exception ex)
    //        {
    //            lblMsg.Visible = true;
    //            lblMsg.Text = "Error - " + ex.Message;
    //            lblMsg.CssClass = "alert alert-danger";
    //        }
    //        finally
    //        {
    //            dbcon.CloseCon();
    //        }
    //    }
    //}


    private void getReservationStatus()
    {
        cmd = new SqlCommand("Reservations", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", "GETSTATUS");
        cmd.CommandType = CommandType.StoredProcedure;
        rReservationStatus.DataSource = dbcon.Load_Data(cmd);
        rReservationStatus.DataBind();
    }

    protected void rReservationStatus_ItemCommand(Object source, RepeaterCommandEventArgs e)
    {
        lblMsg.Visible = false;
        if (e.CommandName == "edit")
        {
            cmd = new SqlCommand("Reservations", dbcon.GetCon());
            cmd.Parameters.AddWithValue("@Action", "STATUSBYID");
            cmd.Parameters.AddWithValue("@ReservationId", e.CommandArgument);
            cmd.CommandType = CommandType.StoredProcedure;
            dt = dbcon.Load_Data(cmd);
            ddlReservationStatus.SelectedValue = dt.Rows[0]["Status"].ToString();
            hdnId.Value = dt.Rows[0]["ReservationId"].ToString();
            pUpdateReservationStatus.Visible = true;
            LinkButton btn = e.Item.FindControl("lnkEdit") as LinkButton;
            btn.CssClass = "badge badge-warning";
        }
    }

    protected void btnUpdate_Click(Object sender, EventArgs e)
    {
        int ReservationId = Convert.ToInt32(hdnId.Value);
        cmd = new SqlCommand("Reservations", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", "UPDTSTATUS");
        cmd.Parameters.AddWithValue("@ReservationId", ReservationId);
        cmd.Parameters.AddWithValue("@Status", ddlReservationStatus.SelectedValue);

        cmd.CommandType = CommandType.StoredProcedure;
        try
        {
            dbcon.OpenCon();
            cmd.ExecuteNonQuery();

            {
                cmd = new SqlCommand("Reservations", dbcon.GetCon());
                cmd.Parameters.AddWithValue("@Action", "EMAIL");
                cmd.Parameters.AddWithValue("@ReservationId", ReservationId);
                cmd.CommandType = CommandType.StoredProcedure;

                dt = dbcon.Load_Data(cmd);
                if (dt.Rows.Count > 0)
                {
                    name = dt.Rows[0]["Name"].ToString();
                    mailid = dt.Rows[0]["Email"].ToString();
                    persons = dt.Rows[0]["NumOfPersons"].ToString();
                    contact = dt.Rows[0]["PhoneNo"].ToString();
                    date = dt.Rows[0]["ForDate"].ToString();
                    time = dt.Rows[0]["ForTime"].ToString();
                    Email.SendEmail(mailid, name, ddlReservationStatus.SelectedValue, date, time, persons, contact);
                }
            }

            lblMsg.Visible = true;
            lblMsg.Text = "Reservation Status Updated Successfully!";
            lblMsg.CssClass = "alert alert-success";
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
            getReservationStatus();
        }
    }

    protected void btnCancel_Click(Object sender, EventArgs e)
    {
        pUpdateReservationStatus.Visible = false;
    }
}