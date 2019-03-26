<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Vendors.aspx.cs" Inherits="Gulden_Price.ru.VendorPages.Vendors" %>
<%@ Import Namespace="Gulden_Price.ru.Model" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <table>
        <tr>
            <th>№</th>
            <th>Имя</th>
            <th>Товаров</th>
            <th>Телефон</th>
            <th>Адрес</th>
            <th>Описание</th>
            <th>Прайс</th>
        </tr>

        <% for
           (
           int i = 0; i < list.Count; i++)
           { %>
        <tr>
            <td><%=i+1%></td>
            <td><a class="vendor" href="Vendor.aspx?id=<%=list[i].UserId%>"><%= string.IsNullOrEmpty(list[i].VendorName) ? list[i].UserName : list[i].VendorName%></a></td>
            <td><%=DataHelper.GetProductsByUserCount(list[i].UserId)%></td>
            <td><%=list[i].Phone%></td>
            <td><%=list[i].Address%></td>
            <td><%=list[i].Description%></td>
            <td>Скачать прайс</td>
        </tr>
        <% } %>
    </table>
</asp:Content>
