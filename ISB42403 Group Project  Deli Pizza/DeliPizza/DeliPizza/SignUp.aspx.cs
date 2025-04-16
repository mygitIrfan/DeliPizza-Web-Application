using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DeliPizza
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string password = txtPassword.Text;
            PBKDF2Hash hash = new PBKDF2Hash(password);
            //password ni nanti dia akan  convert ke hash type
            //HashedPassword ni property
            string passwordHash = hash.HashedPassword;
            //whenever we create a new account, it will enable by default
            bool enabled = true;


            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

            string sql = @"INSERT INTO UserAccounts VALUES (@username, @passwordhash, @role, @enabled)";

            //this is a text not a stored procedure
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@username", txtUsername.Text);
            cmd.Parameters.AddWithValue("@passwordhash", passwordHash);
            cmd.Parameters.AddWithValue("@role", "user");
            cmd.Parameters.AddWithValue("@enabled", enabled);

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                lblStatus.Text = "Status: Data successfully saved.";
            }
            catch (SqlException ex)
            {//error message keluar
                lblStatus.Text = ex.Message;
            }
            finally
            {
                conn.Close();
            }

        }
    }
}

