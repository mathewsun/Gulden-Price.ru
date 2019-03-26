<%@ Page Title="Главная" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Gulden_Price.ru._Default" %>

<%@ Import Namespace="Gulden_Price.ru.Model" %>
<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="HeadContent">
    <script type="text/javascript">
        function ClickSerch() {
            window.location.href = "Default.aspx?search=" + $("#TextBoxSearch").val();
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
    <link href="Content/Buttons.css" type="text/css" rel="stylesheet">
</asp:Content>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
        <div class="content-wrapper">
            <hgroup class="title">
                <h1><%: Title %>.</h1>
                <br />
                Добро пожаловать
                <%--<h2>Всего поставщиков зарегистрировано: <%=DataHelper.GetVendorsCount()%></h2>
                <br />
                <h2>Всего пользователей зарегистрировано: <%=DataHelper.GetUsersCount()%></h2>
                <br />
                <span>Всего товаров: <%=DataHelper.GetAllProductsCount(string.Empty)%></span>--%>
            </hgroup>
        </div>
    </section>

</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    

</asp:Content>
