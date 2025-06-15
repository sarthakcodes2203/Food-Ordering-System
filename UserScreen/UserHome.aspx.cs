using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserHome : System.Web.UI.Page
{
    DBConnect dbcon = new DBConnect();
    SqlCommand cmd;
    DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getCategories();
        }
    }

    private void getCategories()
    {
        cmd = new SqlCommand("Category_Crud", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", "ACTIVECAT");
        cmd.CommandType = CommandType.StoredProcedure;
        rCategory.DataSource = dbcon.Load_Data(cmd);
        rCategory.DataBind();
    }


}