using System;
using System.Collections.Generic;
using Gulden_Price.ru.Model;

namespace Gulden_Price.ru.VendorPages
{
    public partial class Vendors : System.Web.UI.Page
    {
        public List<User> list;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                list = DataHelper.GetVendors();
            }
        }
    }
}