using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminScreen_Report : System.Web.UI.Page
{
    DBConnect dbcon = new DBConnect();
    SqlCommand cmd;
    DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["breadCrumb"] = "Sales Report";
            if (Session["Admin"] == null)
            {
                Response.Redirect("../UserScreen/UserHome.aspx");
            }
        }
    }
    private void getReportData( DateTime fromDate, DateTime toDate)
    {
        double grandTotal = 0;
        cmd = new SqlCommand("Sale_Report", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@FromDate", fromDate);
        cmd.Parameters.AddWithValue("@ToDate", toDate);
        cmd.CommandType = CommandType.StoredProcedure;
        dt = dbcon.Load_Data(cmd);
        if (dt.Rows.Count>0)
        {
            foreach(DataRow dr in dt.Rows)
            {
                grandTotal += Convert.ToDouble( dr["TotalPrice"]);
            }
            lblTotal.Text = "Sold Cost: ₹" + grandTotal;
            lblTotal.CssClass = "badge badge-primary";
        }
        rReport.DataSource = dt;
        rReport.DataBind();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        DateTime fromDate = Convert.ToDateTime(txtFromDate.Text);
        DateTime toDate = Convert.ToDateTime(txtToDate.Text);
        if (toDate > DateTime.Now)
        {
            Response.Write("<script> alert('Todate cannot be greater than Current date!'); </script>");
        }
        else if (fromDate > toDate)
        {
            Response.Write("<script> alert('Start date cannot be greater than End date!'); </script>");
        }
        else
        {
            getReportData(fromDate,toDate);
        }

    }
}