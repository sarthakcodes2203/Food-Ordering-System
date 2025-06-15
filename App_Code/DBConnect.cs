using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

public class DBConnect
{
    private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cn"].ConnectionString);

    public SqlConnection GetCon()
    {
        return con;
    }

    public void OpenCon()
    {
        if (con.State == ConnectionState.Closed)
            con.Open();
    }
    public void CloseCon()
    {
        if (con.State == ConnectionState.Open)
            con.Close();
    }

    public DataTable Load_Data(SqlCommand cmd)
    {
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        try
        {
            da.Fill(dt);
            return dt;
        }
        catch
        {
            throw;
        }
        finally
        {
            dt.Dispose();
            da.Dispose();
            CloseCon();
        }
    }

    public Boolean InsertUpdateData(SqlCommand cmd)
    {
        bool recordSaved;
        try
        {
            OpenCon();
            cmd.ExecuteNonQuery();
            recordSaved = true;
        }
        catch
        {
            recordSaved = false;
        }
        finally
        {
            CloseCon();
        }

        return recordSaved;
    }
}

public class Utils
{
    DBConnect dbcon = new DBConnect();
    SqlCommand cmd;
    DataTable dt;

    public static bool IsValidExtension(string fileName)
    {
        bool isValid = false;
        string[] fileExtension = { ".jpg", ".png", ".jpeg", ".PNG" };
        for (int i = 0; i <= fileExtension.Length - 1; i++)
        {
            if (fileName.Contains(fileExtension[i]))
            {
                isValid = true;
                break;
            }
        }
        return isValid;
    }

    public static string GetImageUrl(Object url)
    {
        string url1 = "";
        if (string.IsNullOrEmpty(url.ToString()) || url == DBNull.Value)
        {
            url1 = "../Images/NoImage.png";
        }
        else
        {
            url1 = string.Format("../{0}", url);
        }
        return url1;
    }


    public bool updateCartQuantity(int quantity, int productId, int userId)
    {
        bool isUpdated = false;
        cmd = new SqlCommand("Cart_Crud", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", "UPDATE");
        cmd.Parameters.AddWithValue("@ProductId", productId);
        cmd.Parameters.AddWithValue("@Quantity", quantity);
        cmd.Parameters.AddWithValue("@UserId", userId);
        cmd.CommandType = CommandType.StoredProcedure;
        try
        {
            dbcon.OpenCon();
            cmd.ExecuteNonQuery();
            isUpdated = true;
        }
        catch (Exception ex)
        {
            isUpdated = false;
            System.Web.HttpContext.Current.Response.Write("<script>alert('Error - " + ex.Message + " ');</script>");
        }
        finally
        {
            dbcon.CloseCon();
        }
        return isUpdated;
    }


    public int cartCount(int userId)
    {
        cmd = new SqlCommand("Cart_Crud", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action", "SELECT");
        cmd.Parameters.AddWithValue("@UserId", userId);
        cmd.CommandType = CommandType.StoredProcedure;
        dt = dbcon.Load_Data(cmd);
        return dt.Rows.Count;
    }

    public static string GetUniqueId()
    {
        //Guid guid = Guid.NewGuid();
        //string uniqueId = guid.ToString();
        //return uniqueId;

        return DateTime.Now.ToString("yyyyMMddHHmmssfff");
    }
}


public class DashboardCount
{
    DBConnect dbcon = new DBConnect();
    SqlCommand cmd;
    SqlDataReader sdr;

    public int Count(String tableName)
    {
        int count = 0;
        cmd = new SqlCommand("Dashboard", dbcon.GetCon());
        cmd.Parameters.AddWithValue("@Action",tableName);
        cmd.CommandType = CommandType.StoredProcedure;
        dbcon.OpenCon();
        sdr = cmd.ExecuteReader();
        while (sdr.Read())
        {
            if (sdr[0] == DBNull.Value)
            {
                count = 0;
            }
            else
            {
                count = Convert.ToInt32(sdr[0]);
            }
        }
        dbcon.CloseCon();
        return count;

    }
}