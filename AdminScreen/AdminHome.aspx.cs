using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminScreen_AdminHome : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["breadCrumb"] = "";
            if (Session["Admin"] == null)
            {
                Response.Redirect("../UserScreen/UserHome.aspx");
            }
            else
            {
                DashboardCount dashboard = new DashboardCount();
                Session["category"] = dashboard.Count("CATEGORY");
                Session["product"] = dashboard.Count("PRODUCT");
                Session["order"] = dashboard.Count("ORDER");
                Session["delivered"] = dashboard.Count("DELIVERED");
                Session["pending"] = dashboard.Count("PENDING");
                Session["user"] = dashboard.Count("USER");
                Session["reservations"] = dashboard.Count("RESERVATIONS");
                Session["soldAmount"] = dashboard.Count("SOLDAMOUNT");
                Session["contact"] = dashboard.Count("CONTACT");
            }
        }
    }
}