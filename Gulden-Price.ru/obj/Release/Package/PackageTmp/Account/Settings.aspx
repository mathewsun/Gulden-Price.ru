<%@ Page Title="Настройки" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="Gulden_Price.ru.Account.Settings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <table>
        <tr>
            <td>
                <asp:Label ID="LabelName" runat="server" Text="Ваше имя"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="TextBoxName" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelPhone" runat="server" Text="Телефон"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="TextBoxPhone" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelAddress" runat="server" Text="Адрес"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="TextBoxAddress" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelDescription" runat="server" Text="Описание вашего магазина"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="TextBoxDescription" runat="server" TextMode="MultiLine" Rows="10"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                
            </td>
            <td>
                <asp:Button ID="ButtonSave" runat="server" Text="Сохранить" OnClick="ButtonSave_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
