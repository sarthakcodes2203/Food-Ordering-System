using QRCoder;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserScreen_Payment : System.Web.UI.Page
{
    DBConnect dbcon = new DBConnect();
    SqlConnection con;
    SqlCommand cmd;
    DataTable dt;
    SqlDataReader dr, dr1;
    SqlTransaction transaction = null;

    string _name, _cardNo, _expiryDate, _address, _paymentMode, _payStatus = null;
    int _cvv;
    long _transactNo, _amount;

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
                upiQR();
            }
        }
    }

    protected void upiQR()
    {
        string upiid = "8293839892@yapl", name = "ARCHISMAN CHATTERJEE", amt = Session["grandTotalPrice"].ToString();
        QRCodeGenerator qrgen = new QRCodeGenerator();
        var qrcodedata = qrgen.CreateQrCode($"upi://pay?pa={upiid}&pn={name}&am={amt}", QRCodeGenerator.ECCLevel.Q);
        QRCode qrcode = new QRCode(qrcodedata);
        var qrCodeImage = qrcode.GetGraphic(20);
        MemoryStream ms = new MemoryStream();
        qrCodeImage.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
        string base64String = Convert.ToBase64String(ms.ToArray());

        imgQRCode.ImageUrl = "data:image/png;base64," + base64String;
        lupino.Text = "8293839892";
        lupiid.Text = upiid;
    }

    protected void lblCardSubmit_Click(object sender, EventArgs e)
    {
        _name = txtName.Text.Trim();
        _cardNo = txtCardNo.Text.Trim();
        _cardNo = string.Format("************{0}", txtCardNo.Text.Trim().Substring(12, 4));
        _expiryDate = txtExpMonth.Text.Trim() +"/"+ txtExpYear.Text.Trim();
        _cvv = Convert.ToInt32(txtCvv.Text.Trim());
        _address = txtAddress.Text.Trim();
        _paymentMode = "CARD";
        _payStatus = "Paid";
        _amount = Convert.ToInt64(Session["grandTotalPrice"]);
        if (Session["userId"] != null)
        {
            OrderPayment(_name, _cardNo, _expiryDate, _cvv, _address, _transactNo, _amount, _paymentMode, _payStatus);
        }
        else
        {
            Response.Redirect("Login.aspx");
        }

    }

    protected void lbCodSubmit_Click(object sender, EventArgs e)
    {
        _address = txtCODAddress.Text.Trim();
        _paymentMode = "COD";
        _payStatus = "Paid";
        _amount = Convert.ToInt64(Session["grandTotalPrice"]);
        if (Session["userId"] != null)
        {
            OrderPayment(_name, _cardNo, _expiryDate, _cvv, _address, _transactNo, _amount, _paymentMode, _payStatus);
        }
        else
        {
            Response.Redirect("Login.aspx");
        }
    }

    protected void lnkupiSubmit_Click(object sender, EventArgs e)
    {
        _address = txtupiAddress.Text.Trim();
        _transactNo = Convert.ToInt64(txttransid.Text.Trim());
        _paymentMode = "UPI";
        _payStatus = "Paid";
        _amount = Convert.ToInt64(Session["grandTotalPrice"]);
        if (Session["userId"] != null)
        {
            OrderPayment(_name, _cardNo, _expiryDate, _cvv, _address, _transactNo, _amount, _paymentMode, _payStatus);
        }
        else
        {
            Response.Redirect("Login.aspx");
        }
    }


    void OrderPayment(string name, string cardNo, string expiryDate, int cvv, string address, long transactNo, long amount, string paymentMode, string payStatus)
    {
        int paymentId, productId, quantity;
        dt = new DataTable();
        dt.Columns.AddRange(new DataColumn[7]
        {
            new DataColumn("OrderNo",typeof(string)),
            new DataColumn("ProductId",typeof(int)),
            new DataColumn("Quantity",typeof(int)),
            new DataColumn("UserId",typeof(int)),
            new DataColumn("Status",typeof(string)),
            new DataColumn("PaymentId",typeof(int)),
            new DataColumn("OrderDate",typeof(DateTime)),
        });
        con = dbcon.GetCon();
        dbcon.OpenCon();
        #region Sql Transaction
        transaction=con.BeginTransaction();

        cmd = new SqlCommand("Save_Payment", dbcon.GetCon(), transaction);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(Session["userId"]));
        cmd.Parameters.AddWithValue("@Name", name);
        cmd.Parameters.AddWithValue("@CardNo", cardNo);
        cmd.Parameters.AddWithValue("@ExpiryDate", expiryDate);
        cmd.Parameters.AddWithValue("@Cvv", cvv);
        cmd.Parameters.AddWithValue("@Address", address);
        cmd.Parameters.AddWithValue("@TrnsctNo", transactNo);
        cmd.Parameters.AddWithValue("@Amount", amount);
        cmd.Parameters.AddWithValue("@PaymentMode", paymentMode);
        cmd.Parameters.AddWithValue("@PayStatus", payStatus);
        cmd.Parameters.Add("@InsertedId", SqlDbType.Int);
        cmd.Parameters["@InsertedId"].Direction = ParameterDirection.Output;

        try
        {
            cmd.ExecuteNonQuery();
            //paymentId = Convert.ToInt32(cmd.Parameters["@PaymentId"].Value);

            paymentId = Convert.ToInt32(cmd.Parameters["@InsertedId"].Value);
            #region Getting Cart Items
            cmd = new SqlCommand("Cart_Crud", dbcon.GetCon(),transaction);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
            cmd.CommandType = CommandType.StoredProcedure;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                productId = (int)dr["ProductId"];
                quantity = (int)dr["Quantity"];
                // update product quantity 
                UpdateQuantity(productId, quantity, transaction, con);

                //delete cart item
                DeleteCartItem(productId, transaction, con);

                dt.Rows.Add(Utils.GetUniqueId(), productId, quantity, (int)Session["userId"],"Pending", paymentId, Convert.ToDateTime(DateTime.Now));
            }
            dr.Close();
            #endregion Getting Cart Items

            #region Order details
            if (dt.Rows.Count > 0)
            {
                cmd = new SqlCommand("Save_Orders", dbcon.GetCon(), transaction);
                cmd.Parameters.AddWithValue("@tblOrders", dt);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteNonQuery();
            }
            #endregion Order details
            transaction.Commit();
            lblMsg.Visible = true;
            lblMsg.Text = "Your order is placed successfully!";
            lblMsg.CssClass = "alert alert-success";
            Response.AddHeader("REFRESH", "1;URL=Invoice.aspx?id="+paymentId);
            Email.SendEmail(Session["mailId"].ToString(), Session["name"].ToString(), "Placed");
        }
        catch (Exception e)
        {
            try
            {
                transaction.Rollback();
            }
            catch (Exception rollbackEx)
            {
                Response.Write("<script>alert('Transaction rollback failed: " + rollbackEx.Message + "');</script>");
            }
            Response.Write("<script>alert('Error occurred: " + e.Message + "');</script>");
        }
        #endregion Sql Transaction
        finally
        {
            con.Close();
        }
    }

    void UpdateQuantity(int _productId, int _quantity, SqlTransaction sqlTransaction, SqlConnection sqlConnection)
    {
        int dbQuantity;
        SqlCommand cmd = new SqlCommand("Product_Crud", sqlConnection, sqlTransaction);
        cmd.Parameters.AddWithValue("@Action", "GETBYID");
        cmd.Parameters.AddWithValue("@ProductId", _productId);
        cmd.CommandType = CommandType.StoredProcedure;
        try
        {
            dr1 = cmd.ExecuteReader();
            while (dr1.Read())
            {
                dbQuantity = (int)dr1["Quantity"];
                if (dbQuantity > _quantity && dbQuantity > 2)
                {
                    dbQuantity = dbQuantity - _quantity;
                    cmd = new SqlCommand("Product_Crud", sqlConnection, sqlTransaction);
                    cmd.Parameters.AddWithValue("@Action", "QTYUPDATE");
                    cmd.Parameters.AddWithValue("@Quantity", dbQuantity);
                    cmd.Parameters.AddWithValue("@ProductId", _productId);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                }
            }
            dr1.Close();
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('Error in UpdateQuantity():" + ex.Message + "');</script>");
        }
    }

    void DeleteCartItem(int _productId, SqlTransaction sqlTransaction, SqlConnection sqlConnection)
    {
        SqlCommand cmd = new SqlCommand("Cart_Crud", sqlConnection, sqlTransaction);
        cmd.Parameters.AddWithValue("@Action", "DELETE");
        cmd.Parameters.AddWithValue("@ProductId", _productId);
        cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
        cmd.CommandType = CommandType.StoredProcedure;
        try
        {
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('Error in DeleteCartItem():" + ex.Message + "');</script>");
        }
    }
}