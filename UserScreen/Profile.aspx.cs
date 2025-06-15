using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserScreen_Profile : System.Web.UI.Page
{
    DBConnect dbcon = new DBConnect();
    SqlCommand cmd;
    DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userId"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                getProfileDetails();
                getPurchaseHistory();
            }
        }
    }

    void getProfileDetails()
    {
        cmd = new SqlCommand("User_Crud", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", "SELECT4PROFILE");
        cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
        cmd.CommandType = CommandType.StoredProcedure;
        dt = dbcon.Load_Data(cmd);
        rptrUserProfile.DataSource = dt;
        rptrUserProfile.DataBind();
        if (dt.Rows.Count == 1)
        {
            Session["name"] = dt.Rows[0]["Name"].ToString();
            Session["username"] = dt.Rows[0]["Username"].ToString();
            Session["email"] = dt.Rows[0]["Email"].ToString();
            Session["imageUrl"] = dt.Rows[0]["ImageUrl"].ToString();
            Session["creationdate"] = dt.Rows[0]["OpeningDate"].ToString();
        }
    }


    void getPurchaseHistory()
    {
        int sr = 1;
        cmd = new SqlCommand("Invoice", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", "ORDHISTORY");
        cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
        cmd.CommandType = CommandType.StoredProcedure;
        dt = dbcon.Load_Data(cmd);
        dt.Columns.Add("Srno", typeof(Int32));
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dataRow in dt.Rows)
            {
                dataRow["Srno"] = sr;
                sr++;
            }
        }

        if (dt.Rows.Count == 0)
        {
            rPurchaseHistory.FooterTemplate = null;
            rPurchaseHistory.FooterTemplate = new CustomTemplate(ListItemType.Footer);
        }
        rPurchaseHistory.DataSource = dt;
        rPurchaseHistory.DataBind();
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
                var footer = new LiteralControl("<tr><td><b>Feeling Hungry?</b> </br> <a href='Menu.aspx' class='badge badge-info ml-2' style=' margin-top: 10px; padding: 8px 16px; font-size: 14px;'>Order Now</a></td></tr></tbody></table>");

                container.Controls.Add(footer);
            }
        }
    }

    protected void rPurchaseHistory_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            double grandTotal = 0;
            HiddenField paymentId = e.Item.FindControl("hdnPaymentId") as HiddenField;
            Repeater repOrders = e.Item.FindControl("rOrders") as Repeater;

            cmd = new SqlCommand("Invoice", dbcon.GetCon());
            cmd.Parameters.AddWithValue("@Action", "INVOICEBYID");
            cmd.Parameters.AddWithValue("@PaymentId", Convert.ToInt32(paymentId.Value));
            cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
            cmd.CommandType = CommandType.StoredProcedure;
            dt = dbcon.Load_Data(cmd);
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dataRow in dt.Rows)
                {
                    grandTotal += Convert.ToDouble(dataRow["TotalPrice"]);
                }
            }
            DataRow dr = dt.NewRow();
            dr["TotalPrice"] = grandTotal;
            dt.Rows.Add(dr);

            repOrders.DataSource = dt;
            repOrders.DataBind();
        }
    }
}