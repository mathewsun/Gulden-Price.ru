using System;
using System.Collections.Generic;
using Gulden_Price.ru.Model;

namespace Gulden_Price.ru.VendorPages
{
    public partial class Search : BasicPage
    {
        public int ProductsCount;

        public int PageCount;

        public int PageNum;

        public int NextPage;

        public int PriorPage;

        public int LastPage;

        public List<fnGetAllProductsResult> List = new List<fnGetAllProductsResult>();

        public string Filter = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Filter = Request.Params["search"];

                string dir = Request.Params["dir"];

                string sort = Request.Params["sort"];

                int size;

                Int32.TryParse(Request.Params["size"], out size);

                if (size == 0) size = 20;

                Int32.TryParse(Request.Params["p"], out PageNum);

                List = DataHelper.GetAllProducts(Filter, sort, dir, size, PageNum);

                ProductsCount = DataHelper.GetAllProductsCount(Filter);

                PageCount = ProductsCount / size + 1;

                PriorPage = PageNum > 0 ? PageNum - 1 : 0;

                NextPage = PageNum < PageCount - 1 ? PageNum + 1 : PageNum;

                LastPage = PageCount - 1;

            }
        }
    }
}