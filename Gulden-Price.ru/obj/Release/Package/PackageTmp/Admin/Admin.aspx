<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Gulden_Price.ru.Admin.Admin" %>

<%@ Register Src="AdminMenu.ascx" TagName="AdminMenu" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <uc1:AdminMenu ID="AdminMenu1" runat="server" />
    <hgroup class="title">
        <h1><%: Title %></h1>
    </hgroup>
    <div>
        Управление системой
    </div>
    <ul>
        <li>
            <asp:HyperLink ID="HyperLinkUsers" NavigateUrl="Users.aspx" runat="server">Пользователи</asp:HyperLink>
        </li>
        <li>
            <asp:HyperLink ID="HyperLink10" NavigateUrl="News.aspx" runat="server">Новости</asp:HyperLink>
        </li>
        <li>
            <asp:HyperLink ID="HyperLink2" NavigateUrl="Settings.aspx" runat="server">Настройки</asp:HyperLink>
        </li>
    </ul>
</asp:Content>
