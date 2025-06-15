using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class User : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Request.Url.AbsoluteUri.ToString().Contains("UserHome.aspx"))
        {
            form1.Attributes.Add("class", "sub_page");
        }
        else
        {
            form1.Attributes.Remove("class");
            //Load the control
            Control sliderUserControl = (Control)Page.LoadControl("SliderUserControl.ascx");
            // Add the control to the panel
            pnlSliderUC.Controls.Add(sliderUserControl);
        }

        if (Session["userId"] != null)
        {
            lblLoginOrLogout.Text = "Logout";
            Utils utils = new Utils();
           Session["cartCount"] = utils.cartCount(Convert.ToInt32(Session["userId"])).ToString();
        }
        else
        {
            lblLoginOrLogout.Text = "Login";
            Session["cartCount"] = "0";
        }
    }

    protected void lblLoginOrLogout_Click(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            Session.Abandon();
            Response.Redirect("UserHome.aspx");
        }
    }

    protected void lbRegisterOrProfile_Click(object sender, EventArgs e)
    {
        if (Session["userId"] != null)
        {
            lbRegisterOrProfile.ToolTip = "User Profile";
            Response.Redirect("Profile.aspx");
        }
        else
        {
            lbRegisterOrProfile.ToolTip = "User Registration";
            Response.Redirect("SignUp.aspx");
        }
    }
}
