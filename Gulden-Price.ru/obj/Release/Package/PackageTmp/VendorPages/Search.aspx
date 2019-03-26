<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="Gulden_Price.ru.VendorPages.Search" %>

<%@ Import Namespace="Gulden_Price.ru.Model" %>
<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
    <script type="text/javascript">
        function ClickSerch() {
            window.location.href = "Search.aspx?search=" + $("#TextBoxSearch").val();
        }

        function SelectPage(value) {
            window.location.href = getUrlWithoutParameter("p") + "&p=" + value;
        }

        $(document).ready(function () {

            $("#selectRowCount option").filter(function () {
                return $(this).text() == getParameterByName("size");
            }).prop('selected', true);
            $('#selectRowCount').trigger('update');

            $(document).on('change', '#selectRowCount', function () {
                window.location.href = getUrlWithoutParameter("size") + "&size=" + $('#selectRowCount option:selected').val();
            });

            $("a.sortColumn").each(function () {
                var sortColumn = getParameterByName("sort");

                if (!sortColumn.length && this.id == "name") {
                    $(this).attr("href", getUrlWithoutParameter("sort") + "&sort=" + this.id + "&dir=desc");
                } else {
                    $(this).attr("href", getUrlWithoutParameter("sort") + "&sort=" + this.id);
                }
            });

            var sortColumn = getParameterByName("sort");
            if (sortColumn.length) {
                var sortDirection = getParameterByName("dir");
                if (sortDirection == "desc") {
                    $("#" + sortColumn).attr("href", getUrlWithoutParameter("dir"));
                    $("#" + sortColumn).append("<img src='/Images/arrowSortAsc.png' class='sortArrow' alt='' />");
                } else {
                    $("#" + sortColumn).attr("href", getUrlWithoutParameter("dir") + "&dir=desc");
                    $("#" + sortColumn).append("<img src='/Images/arrowSortDesc.png' class='sortArrow' alt='' />");
                }
            } else {
                $("#name").append("<img src='/Images/arrowSortDesc.png' class='sortArrow' alt='' />");
            }
        });
    </script>
    <link href="/Content/Buttons.css" type="text/css" rel="stylesheet">
</asp:Content>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
        <div class="content-wrapper">
            <hgroup class="title">
                <h1><%: Title %>.</h1>
                <br />
                <h2>Всего поставщиков зарегистрировано: <%=DataHelper.GetVendorsCount()%></h2>
                <br />
                <h2>Всего пользователей зарегистрировано: <%=DataHelper.GetUsersCount()%></h2>
                <br />
                <span>Всего товаров: <%=DataHelper.GetAllProductsCount(string.Empty)%></span>
            </hgroup>
        </div>
    </section>

</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div>
        <table>
            <tr>
                <td>
                    <input id="TextBoxSearch" placeholder="Поиск.." value="<%=Filter%>" type="text" />
                </td>
                <td>
                    <input type="button" id="SubmitSearch" value="Поиск" onclick="ClickSerch()">
                </td>
            </tr>
        </table>
    </div>
    <h3>Список позиций (<%=ProductsCount%>):</h3>
    <table class="suppliers">
        <tr>
            <th colspan="6">
                <div class="navigator">
                    <div class="selectRowCount">
                        <select id="selectRowCount">
                            <option value="20" selected="selected">20</option>
                            <option value="50">50</option>
                            <option value="100">100</option>
                        </select>
                    </div>
                    <div class="navigatorBtns">
                        <a class="btnFirst" style="float: left" title="В начало" onclick="SelectPage(0)" href="#">&nbsp;</a>
                        <a class="btnPrev" style="float: left" title="На предыдущую" onclick="SelectPage(<%=PriorPage%>)" href="#">&nbsp;</a>
                        <a class="btnLast" style="float: right" title="В конец" onclick="SelectPage(<%=LastPage%>)" href="#">&nbsp;</a>
                        <a class="btnNext" style="float: right" title="На следующую" onclick="SelectPage(<%=NextPage%>)" href="#">&nbsp;</a>
                        <span class="pageNumbers"><span title="Текущая страница"><%=PageNum + 1%></span> / <span title="Всего страниц"><%=PageCount%></span></span>
                    </div>
                </div>
            </th>
        </tr>
        <tr>
            <th>№</th>
            <th><a href="#" title="Наименование товара" class="sortColumn" id="name"><span title="Наименование товара">Наименование</span></a></th>
            <th><a href="#" title="Стоимость $" class="sortColumn" id="price"><span title="Стоимость $">Стоимость $</span></a></th>
            <th><a href="#" title="Поставщик" class="sortColumn" id="vendor"><span title="Поставщик">Поставщик</span></a></th>
            <th>Обновлен</th>
            <th>Телефон</th>
        </tr>
        <% for (int i = 0; i < List.Count; i++)
           { %>
        <tr>
            <td><%=i + 1%></td>
            <td><%=List[i].Name%></td>
            <td><%=List[i].Price%></td>
            <td><a class="vendor" href="Vendor.aspx?id=<%=List[i].UserID%>"><%= string.IsNullOrEmpty(List[i].VendorName) ? List[i].UserName : List[i].VendorName%></a></td>
            <td><%=List[i].WhenDate.ToString("dd-MM-yyyy")%></td>
            <td><%=List[i].Phone%></td>
        </tr>
        <% } %>
    </table>

</asp:Content>
