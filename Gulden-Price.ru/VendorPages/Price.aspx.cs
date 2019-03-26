using System;
using System.Data;
using System.Data.OleDb;
using System.Text.RegularExpressions;
using System.Xml;
using Gulden_Price.ru.Model;

namespace Gulden_Price.ru.VendorPages
{
    public partial class Price : BasicPage
    {
        public int ProductsCount;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillGrid();
            }
        }

        public void FillGrid()
        {
            GridView1.DataSource = DataHelper.GetProductsByUser(User.UserId);
            GridView1.DataBind();

            ProductsCount = DataHelper.GetProductsByUserCount(User.UserId);
        }

        protected void ButtonUpdate_Click(object sender, EventArgs e)
        {
            int countNewProducts = 0;
            int countUpdateProducts = 0;
            int countBadProducts = 0;
            int result = 0;

            if (FileUploadExcel.HasFile)
            {
                DataSet ds = new DataSet();

                string fileLocation = string.Concat((Server.MapPath("~/temp/" + FileUploadExcel.FileName)));
                FileUploadExcel.PostedFile.SaveAs(fileLocation);

                string excelConnectionString = string.Empty;
                excelConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" +
                fileLocation + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";

                string fileExtension =
                                     System.IO.Path.GetExtension(FileUploadExcel.FileName);


                //connection String for xls file format.
                if (fileExtension == ".xls")
                {
                    excelConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" +
                    fileLocation + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
                }
                //connection String for xlsx file format.
                else if (fileExtension == ".xlsx")
                {
                    excelConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" +
                    fileLocation + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                }
                //Create Connection to Excel work book and add oledb namespace
                OleDbConnection excelConnection = new OleDbConnection(excelConnectionString);
                excelConnection.Open();
                DataTable dt = new DataTable();

                dt = excelConnection.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                if (dt == null)
                {
                    return;
                }

                String[] excelSheets = new String[dt.Rows.Count];
                int t = 0;
                //excel data saves in temp file here.
                foreach (DataRow row in dt.Rows)
                {
                    excelSheets[t] = row["TABLE_NAME"].ToString();
                    t++;
                }
                OleDbConnection excelConnection1 = new OleDbConnection(excelConnectionString);

                string query = string.Format("Select * from [{0}]", excelSheets[0]);
                using (OleDbDataAdapter dataAdapter = new OleDbDataAdapter(query, excelConnection1))
                {
                    dataAdapter.Fill(ds);
                }

                if (fileExtension.ToString().ToLower().Equals(".xml"))
                {
                    FileUploadExcel.SaveAs(fileLocation);
                    XmlTextReader xmlreader = new XmlTextReader(fileLocation);
                    // DataSet ds = new DataSet();
                    ds.ReadXml(xmlreader);
                    xmlreader.Close();
                }

                int columnNameNumber = Convert.ToInt32(TextBoxColumnNumber.Text) - 1;
                int columnPriceNumber = Convert.ToInt32(TextBoxPriceNumber.Text) - 1;

                RegexOptions options = RegexOptions.None;
                Regex regex = new Regex(@"[ ]{2,}", options);

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    Product item = new Product();

                    try
                    {
                        item.Name = ds.Tables[0].Rows[i][columnNameNumber].ToString().Trim().TrimStart('+').TrimStart('*');

                        item.Name = regex.Replace(item.Name, @" ");

                        item.Price = Convert.ToDouble(ds.Tables[0].Rows[i][columnPriceNumber].ToString());
                        item.UserID = User.UserId;
                        item.WhenDate = DateTime.Now;

                        result = DataHelper.UpdateProduct(item);

                        if (result == 0) countBadProducts++;
                        if (result == 1) countNewProducts++;
                        if (result == 2) countUpdateProducts++;
                    }
                    catch { }
                }
            }

            LabelResult.Text = string.Format("Добавлено новых: {0}, обновлено старых: {1}, не загрузилось {2}", countNewProducts,
                countUpdateProducts, countBadProducts);

            FillGrid();
        }

        protected void GridView1_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(((System.Web.UI.WebControls.HiddenField)GridView1.Rows[e.RowIndex].FindControl("HiddenField1")).Value);

            DataHelper.DeleteProduct(id);

            FillGrid();
        }

        protected void GridView1_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;

            FillGrid();
        }

        protected void GridView1_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;

            FillGrid();
        }

        protected void GridView1_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
            Product item = new Product();

            item.Id = Convert.ToInt32(((System.Web.UI.WebControls.HiddenField)GridView1.Rows[e.RowIndex].FindControl("HiddenField2")).Value);
            item.Name = ((System.Web.UI.WebControls.TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox1")).Text.Trim().TrimStart('+').TrimStart('*');
            item.Price = Convert.ToDouble(((System.Web.UI.WebControls.TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox2")).Text);
            item.UserID = User.UserId;

            DataHelper.UpdateProduct(item);

            GridView1.EditIndex = -1;

            FillGrid();
        }

        protected void ButtonDeleteAll_Click(object sender, EventArgs e)
        {
            DataHelper.DeleteProductsByUser(User.UserId);

            FillGrid();
        }

        protected void ButtonDeleteOldProducts_Click(object sender, EventArgs e)
        {
            DataHelper.DeleteOldProducts(User.UserId);

            FillGrid();
        }
    }
}