using System;

namespace Gulden_Price.ru
{
    public partial class Vendors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("/VendorPages/Vendors.aspx");
        }
    }
}