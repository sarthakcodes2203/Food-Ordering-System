using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminScreen_OrderStatus : System.Web.UI.Page
{
    DBConnect dbcon = new DBConnect();
    SqlCommand cmd, cmd1;
    DataTable dt;

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
                getOrderStatus();
            }
        }
        lblMsg.Visible = false;
        pUpdateOrderStatus.Visible = false;
    }

    private void getOrderStatus()
    {
        cmd = new SqlCommand("Invoice", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", "GETSTATUS");
        cmd.CommandType = CommandType.StoredProcedure;
        rOrderStatus.DataSource = dbcon.Load_Data(cmd);
        rOrderStatus.DataBind();
    }

    protected void rOrderStatus_ItemCommand(Object source,RepeaterCommandEventArgs e)
    {
        lblMsg.Visible = false;
        if (e.CommandName == "edit")
        {
            cmd = new SqlCommand("Invoice", dbcon.GetCon());
            cmd.Parameters.AddWithValue("@Action", "STATUSBYID");
            cmd.Parameters.AddWithValue("@OrderDetailsId", e.CommandArgument);
            cmd.CommandType = CommandType.StoredProcedure;
            dt = dbcon.Load_Data(cmd);
            ddlOrderStatus.SelectedValue = dt.Rows[0]["Status"].ToString();
            hdnId.Value = dt.Rows[0]["OrderDetailsId"].ToString();
            hdnUserId.Value = dt.Rows[0]["UserId"].ToString();
            pUpdateOrderStatus.Visible = true;
            LinkButton btn = e.Item.FindControl("lnkEdit") as LinkButton;
            btn.CssClass = "badge badge-warning";
        }
    }

    protected void btnUpdate_Click(Object sender, EventArgs e)
    {
        int orderDetailsId = Convert.ToInt32(hdnId.Value);
        cmd = new SqlCommand("Invoice", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action",  "UPDTSTATUS" );
        cmd.Parameters.AddWithValue("@OrderDetailsId", orderDetailsId);
        cmd.Parameters.AddWithValue("@Status", ddlOrderStatus.SelectedValue);
        cmd.CommandType = CommandType.StoredProcedure;
        try
        {
            dbcon.OpenCon();
            cmd.ExecuteNonQuery();

            {
                int uid = Convert.ToInt32(hdnUserId.Value);
                cmd = new SqlCommand("User_Crud", dbcon.GetCon());
                cmd.Parameters.AddWithValue("@Action", "EMAIL");
                cmd.Parameters.AddWithValue("@UserId", uid);
                cmd.CommandType = CommandType.StoredProcedure;

                dt = dbcon.Load_Data(cmd);
                if (dt.Rows.Count > 0)
                {
                    string name = dt.Rows[0]["Name"].ToString();
                    string username = dt.Rows[0]["Username"].ToString();
                    string email = dt.Rows[0]["Email"].ToString();
                    Email.SendEmail(email, name, ddlOrderStatus.SelectedValue);
                }
            }

            lblMsg.Visible = true;
            lblMsg.Text = "Order Status Updated Successfully!";
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
            getOrderStatus();
        }
    }

    protected void btnCancel_Click(Object sender, EventArgs e)
    {
        pUpdateOrderStatus.Visible = false;
    }
}