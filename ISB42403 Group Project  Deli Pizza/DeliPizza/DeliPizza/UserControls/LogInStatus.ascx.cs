using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DeliPizza.UserControls
{
    public partial class LogInStatus : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserName"] != null && Session["Role"] != null)
            {
                // user has logged in
                HyperLinkLogIn.Visible = false;
                HyperLinkSignUp.Visible = false;
                btnLogOut.Visible = true;
                lblLogInStatus.Text = "You are logged in as " + Session["UserName"].ToString();
            }
            else
            {
                // user has not logged in
                HyperLinkLogIn.Visible = true;
                HyperLinkSignUp.Visible = true;
                btnLogOut.Visible = false;
                lblLogInStatus.Text = "You are not logged in.";
            }
        }

        protected void btnLogOut_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Default.aspx");
        }
    }
}
