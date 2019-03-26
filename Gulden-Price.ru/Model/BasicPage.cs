using System;
using System.Web.Security;
using System.Web.UI;

namespace Gulden_Price.ru.Model
{
    public class BasicPage : Page
    {
        protected User User
        {
            get
            {
                User user = (User)Session["User"];

                if (user != null)
                    return user;

                MembershipUser membershipUser = Membership.GetUser();

                if (!membershipUser.IsApproved)
                    FormsAuthentication.SignOut();

                if (membershipUser == null
                    || membershipUser.ProviderUserKey == null)
                {
                    return null;
                }

                user = DataHelper.GetUser(new Guid(membershipUser.ProviderUserKey.ToString()));

                Session["User"] = user;

                return user;
            }
        }
    }
}