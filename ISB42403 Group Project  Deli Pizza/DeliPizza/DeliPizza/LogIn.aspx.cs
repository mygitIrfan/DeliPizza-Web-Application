using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DeliPizza
{
    public partial class LogIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {



        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string sql = @"SELECT * FROM UserAccounts WHERE UserName = @username";

            SqlConnection conn = new SqlConnection(ConfigurationManager.
                ConnectionStrings["ConnectionString"].ConnectionString);

            SqlCommand cmd = new SqlCommand(sql, conn);

            cmd.Parameters.AddWithValue("@username", txtUsername.Text);


            SqlDataAdapter sda = new SqlDataAdapter(cmd);

            // TO COPY THE CONTENT OF TABLE AND PUT IN A MEMORY IN A FORM OF TABLE ITSELF
            DataTable dt = new DataTable();

            //THIS ONE NAK FILL
            sda.Fill(dt);


            if (dt.Rows.Count > 0)
            {
                //Username found
                Object objPasswordHash = dt.Rows[0]["PasswordHash"];
                Object objRole = dt.Rows[0]["Role"];
                Object objEnabled = dt.Rows[0]["Enabled"];
                string password = txtPassword.Text;
                string storedPasswordHash = objPasswordHash.ToString();

                PBKDF2Hash hash = new PBKDF2Hash(password, storedPasswordHash);
                bool check = hash.PasswordCheck;
                bool enabled = Convert.ToBoolean(objEnabled);

                if (check == true && enabled == true)
                {
                    Session["UserName"] = txtUsername.Text;
                    Session["Role"] = objRole;

                    if (Session["Role"].ToString() == "user")
                        Response.Redirect("WebPizzaForm.aspx");
                    else if (Session["Role"].ToString() == "admin")
                        Response.Redirect("Admin.aspx");
                }
                else
                {
                    // Display the "Incorrect password or account disabled" message
                    lblStatus.Text = "Incorrect password or account disabled.";
                }
            }
            else
            {
                // Display the "Incorrect username" message
                lblStatus.Text = "Incorrect username.";
            }

        }
    }
}