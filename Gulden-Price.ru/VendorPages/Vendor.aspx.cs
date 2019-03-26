using System;
using System.Collections.Generic;
using Gulden_Price.ru.Model;

namespace Gulden_Price.ru.VendorPages
{
    public partial class Vendor : System.Web.UI.Page
    {
        public User VendorInfo = new User();

        public List<Product> VenorProducts = new List<Product>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    Guid vendorId = Guid.Parse(Request.Params["id"]);

                    if (vendorId != Guid.Empty)
                    {
                        VendorInfo = DataHelper.GetUser(vendorId);

                        TextBoxName.Text = VendorInfo.VendorName;

                        TextBoxPhone.Text = VendorInfo.Phone;

                        TextBoxAddress.Text = VendorInfo.Address;

                        TextBoxDescription.Text = VendorInfo.Description;

                        VenorProducts = DataHelper.GetProductsByUser(vendorId);

                        LabelProductsCount.Text = VenorProducts.Count.ToString();
                    }
                }
                catch { }
            }
        }
    }
}