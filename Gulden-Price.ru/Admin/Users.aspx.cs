using System;
using System.Collections.Generic;
using Gulden_Price.ru.Model;

namespace Gulden_Price.ru.Admin
{
    public partial class Users : System.Web.UI.Page
    {
        public List<fnGetAllUsersResult> List;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillGrid();
            }
        }

        public void FillGrid()
        {
            List = DataHelper.GetAllUsers();

            GridViewUsers.DataSource = List;
            GridViewUsers.DataBind();
        }


        protected void GridView1_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            Guid userId = Guid.Parse(((System.Web.UI.WebControls.HiddenField)GridViewUsers.Rows[e.RowIndex].FindControl("HiddenField1")).Value);

            //DataHelper.DeleteUser(userId);

            FillGrid();
        }

        protected void GridView1_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            GridViewUsers.EditIndex = e.NewEditIndex;

            FillGrid();
        }

        protected void GridView1_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            GridViewUsers.EditIndex = -1;

            FillGrid();
        }

        protected void GridView1_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
            Model.User item = new Model.User();

            item.UserId = Guid.Parse(((System.Web.UI.WebControls.HiddenField)GridViewUsers.Rows[e.RowIndex].FindControl("HiddenField2")).Value);

            DataHelper.UpdateUserRole(item.UserId, "Vendor");

            GridViewUsers.EditIndex = -1;

            FillGrid();
        }
    }
}