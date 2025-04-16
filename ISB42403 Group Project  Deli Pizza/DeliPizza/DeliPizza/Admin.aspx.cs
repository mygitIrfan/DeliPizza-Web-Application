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
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "admin")
                Response.Redirect("Default.aspx");

            if (!IsPostBack)
            {
                LoadTotalSalesAmount();
            }
        }

        private void LoadTotalSalesAmount()
        {
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand("spGetTotalSalesAmount", conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        lblTotalSalesAmount.Text = "Total Sales Amount: RM" + Convert.ToDecimal(result).ToString("F2");
                    }
                }
            }
        }
    }
}