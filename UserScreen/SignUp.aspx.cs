using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserScreen_SignUp : System.Web.UI.Page
{
    DBConnect dbcon = new DBConnect();
    SqlCommand cmd;
    DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["id"] != null) /*&& Session["userId"] l= null*/
            {
                getUserDetails();
            }
            else if (Session["userId"] != null)
            {
                Response.Redirect("../UserScreen/UserHome.aspx");
            }
	}
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
        bool isValidToExecute = false;
        int userId = Convert.ToInt32(Request.QueryString["id"]);
        cmd = new SqlCommand("User_Crud", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", userId == 0 ? "INSERT" : "UPDATE");
        cmd.Parameters.AddWithValue("@UserId", userId);
        cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
        cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
        cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
        cmd.Parameters.AddWithValue("@PinCode", txtPostCode.Text.Trim());
        cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
        if (fuUserImage.HasFile)
        {
            if (Utils.IsValidExtension(fuUserImage.FileName))
            {
                Guid obj = Guid.NewGuid();
                fileExtension = Path.GetExtension(fuUserImage.FileName);
                string folderPath = Server.MapPath("../Images/");

                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(Path.Combine(folderPath, "User"));

                imagePath = "Images/User/" + obj.ToString() + fileExtension;
                fuUserImage.PostedFile.SaveAs(Server.MapPath("~/Images/User/") + obj.ToString() + fileExtension);
                cmd.Parameters.AddWithValue("@ImageUrl", imagePath);
                isValidToExecute = true;
            }
            else
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Please select .jpg, .jpeg or .png image";
                lblMsg.CssClass = "alert alert-danger";
                isValidToExecute = false;
            }
        }
        else
        {
            isValidToExecute = true;
        }

        if (isValidToExecute)
        {
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                dbcon.OpenCon();
                cmd.ExecuteNonQuery();
                actionName = userId == 0 ?
                    "Registration is Successful! <b><a href='Login.aspx'>Click here</a></b> to login" :
                    "Details Updated Successfully! <b><a href='Profile.aspx'>Can check here</a></b>";
                lblMsg.Visible = true;
                lblMsg.Text = "<b>" + txtUsername.Text.Trim() + "</b>, " + actionName;
                lblMsg.CssClass = "alert alert-success";
                if (userId != 0)
                {
                    Response.AddHeader("REFRESH", "1;URL=Profile.aspx");
                    Email.SendEmail(txtEmail.Text.ToString().Trim(), txtName.Text.ToString().Trim(), "Update Details");
                }
                else
                {
                    Email.SendEmail(txtEmail.Text.ToString().Trim(), txtName.Text.ToString().Trim(), "Welcome");
                }
                clear();
            }
            catch (SqlException ex)
            {
                if (ex.Message.Contains("Violation of UNIQUE KEY constraint"))
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "<b>" + txtUsername.Text + "</b> Username already exists, try new one..!";
                    lblMsg.CssClass = "alert alert-danger";
                }
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

    void getUserDetails()
    {
        cmd = new SqlCommand("User_Crud", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", "SELECT4PROFILE");
        cmd.Parameters.AddWithValue("@UserId", Request.QueryString["id"]);
        cmd.CommandType = CommandType.StoredProcedure;
        dt = dbcon.Load_Data(cmd);
        if (dt.Rows.Count == 1)
        {
            txtName.Text = dt.Rows[0]["Name"].ToString();
            txtUsername.Text = dt.Rows[0]["Username"].ToString();
            txtMobile.Text = dt.Rows[0]["Mobile"].ToString();
            txtEmail.Text = dt.Rows[0]["Email"].ToString();
            txtAddress.Text = dt.Rows[0]["Address"].ToString();
            txtPostCode.Text = dt.Rows[0]["PinCode"].ToString();
            imgUser.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ImageUrl"].ToString())
                   ? "../Images/NoImage.png" : "../" + dt.Rows[0]["ImageUrl"].ToString();
            imgUser.Height = 200;
            imgUser.Width = 200;
            txtPassword.TextMode = TextBoxMode.SingleLine;
            txtPassword.ReadOnly = true;
            txtPassword.Text = dt.Rows[0]["Password"].ToString();
            lblHeaderMsg.Text = "<h2>Edit Profile</h2>";
            btnRegister.Text = "Update";
            lblAlreadyUser.Text = "";
        }
    }

    private void clear()
    {
        txtName.Text = txtUsername.Text = txtMobile.Text = txtEmail.Text = txtAddress.Text = txtPostCode.Text = txtAddress.Text = string.Empty;
    }
}