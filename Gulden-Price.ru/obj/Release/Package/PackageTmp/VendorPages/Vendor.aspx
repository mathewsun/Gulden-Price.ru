<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Vendor.aspx.cs" Inherits="Gulden_Price.ru.VendorPages.Vendor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h1><%= string.Format("{0}: {1}", Title, !String.IsNullOrEmpty(VendorInfo.VendorName) ? VendorInfo.VendorName : VendorInfo.UserName)  %></h1>
    </hgroup>
    <table>
        <tr>
            <td>
                <asp:Label ID="LabelProductsCountlbl" runat="server" Text="Позиций"></asp:Label>
            </td>
            <td>
                <asp:Label ID="LabelProductsCount" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelName" runat="server" Text="Имя поставщика"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="TextBoxName" ReadOnly="True" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelPhone" runat="server" Text="Телефон"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="TextBoxPhone" ReadOnly="True" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelAddress" runat="server" Text="Адрес"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="TextBoxAddress" ReadOnly="True" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelDescription" runat="server" Text="Описание"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="TextBoxDescription" ReadOnly="True" runat="server" TextMode="MultiLine" Rows="10"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <h3>Список позиций:</h3>
                <table class="suppliers">
                    <tr>
                        <th>№</th>
                        <th>Наименование</th>
                        <th>Стоимость $</th>
                    </tr>
                    <% for (int i = 0; i < VenorProducts.Count; i++)
                       { %>
                    <tr>
                        <td><%=i + 1%></td>
                        <td><%=VenorProducts[i].Name%></td>
                        <td><%=VenorProducts[i].Price%></td>
                    </tr>
                    <% } %>
                </table>
            </td>
        </tr>
    </table>

</asp:Content>
