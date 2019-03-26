using System;
using Gulden_Price.ru.Model;

namespace Gulden_Price.ru.Account
{
    public partial class Settings : BasicPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                User user = DataHelper.GetUser(User.UserId);

                TextBoxName.Text = user.VendorName;

                TextBoxPhone.Text = user.Phone;

                TextBoxAddress.Text = user.Address;

                TextBoxDescription.Text = user.Description;
            }
        }

        protected void ButtonSave_Click(object sender, EventArgs e)
        {
            User user = new User();

            user.UserId = User.UserId;

            user.VendorName = TextBoxName.Text;

            user.Phone = TextBoxPhone.Text;

            user.Address = TextBoxAddress.Text;

            user.Description = TextBoxDescription.Text;

            DataHelper.UpdateUser(user);

            Response.Redirect("/");
        }
    }
}