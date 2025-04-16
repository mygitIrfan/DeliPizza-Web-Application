using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DeliPizza
{
    public partial class WebPizzaForm : System.Web.UI.Page
    {
        static double totalAmount;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null)
                Response.Redirect("Default.aspx");

            if (!IsPostBack)
            {
                GenerateSalesId();
            }
        }

        void GenerateSalesId()
        {
            string hexTicks = DateTime.Now.Ticks.ToString("X");
            lblSalesId.Text = hexTicks.Substring(hexTicks.Length - 15, 9);
            lblDateTime.Text = DateTime.Now.ToString();
        }

        protected void GridViewItems_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblItemId.Text = GridViewItems.SelectedRow.Cells[1].Text;
            lblItemTitle.Text = GridViewItems.SelectedRow.Cells[2].Text;
            lblItemPrice.Text = GridViewItems.SelectedRow.Cells[3].Text;
        }

        void SalesAddItem()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("spSalesAddItem", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@salesid", lblSalesId.Text);
                cmd.Parameters.AddWithValue("@itemid", lblItemId.Text);
                cmd.Parameters.AddWithValue("@quantity", txtQuantity.Text);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    lblMessage1.Text = ex.Message;
                }
            }

            txtQuantity.Text = "1";
        }

        void SalesGetTotalAmount()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("spSalesGetTotalAmount", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@salesid", lblSalesId.Text);

                try
                {
                    conn.Open();
                    totalAmount = (double)cmd.ExecuteScalar();
                    lblTotalAmountCart.Text = totalAmount.ToString("c2");
                }
                catch (SqlException ex)
                {
                    lblMessage2.Text = ex.Message;
                }
            }
        }

        void SalesConfirm()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("spSalesConfirm", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@salesid", lblSalesId.Text);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    lblMessage2.Text = "Sales confirmed!";
                }
                catch (SqlException ex)
                {
                    lblMessage2.Text = ex.Message;
                }
            }
            txtQuantity.Text = "1";
        }

        void DisplayInvoice()
        {
            double serviceTax, amountAfterTax, amountRounded, rounding;
            serviceTax = totalAmount * 0.06;
            amountAfterTax = totalAmount + serviceTax;
            amountRounded = Math.Round(amountAfterTax / 0.05) * 0.05;
            rounding = amountRounded - amountAfterTax;

            lblTotalAmount.Text = "Total amount: " + totalAmount.ToString("c2");
            lblServiceTax.Text = "Service tax (6%): " + serviceTax.ToString("c2");
            lblAmountAfterTax.Text = "Amount after tax: " + amountAfterTax.ToString("c2");
            lblRounding.Text = "Rounding: " + rounding.ToString("c2");
            lblAmountRounded.Text = "Amount to pay: " + amountRounded.ToString("c2");
        }

        void ClearAll()
        {
            lblItemId.Text = "";
            lblItemTitle.Text = "";
            lblItemPrice.Text = "";
            lblTotalAmountCart.Text = "RM0.00";
            lblTotalAmount.Text = "";
            lblServiceTax.Text = "";
            lblAmountAfterTax.Text = "";
            lblRounding.Text = "";
            lblAmountRounded.Text = "";
            lblMessage1.Text = "";
            lblMessage2.Text = "";
        }

        void SalesRemoveNotConfirmed()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("spSalesRemoveNotConfirmed", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@salesid", lblSalesId.Text);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    lblMessage2.Text = ex.Message;
                }
            }
        }

        protected void btnAddItem_Click(object sender, EventArgs e)
        {
            SalesAddItem();
            GridViewCart.DataBind();
            SalesGetTotalAmount();
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewItems.PageIndex = 0;
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            SalesConfirm();
            DisplayInvoice();
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            ClearAll();
            GenerateSalesId();
            ddlCategories.DataBind();
            GridViewItems.PageIndex = 0;
            GridViewItems.DataBind();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            SalesRemoveNotConfirmed();
            ClearAll();
            GenerateSalesId();
            ddlCategories.DataBind();
            GridViewItems.PageIndex = 0;
            GridViewItems.DataBind();
        }
    }
}
