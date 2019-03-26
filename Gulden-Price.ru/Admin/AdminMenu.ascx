<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AdminMenu.ascx.cs" Inherits="Gulden_Price.ru.Admin.AdminMenu" %>

<div id="accountLinks">
    <div>
        <asp:HyperLink ID="HyperLink7" NavigateUrl="Admin.aspx" runat="server">Управление</asp:HyperLink>
    </div>
    <div>|</div>
    <div>
        <asp:HyperLink ID="HyperLink2" NavigateUrl="Users.aspx" runat="server">Пользователи</asp:HyperLink>
    </div>
    <div>|</div>
    <div>
        <asp:HyperLink ID="HyperLink10" NavigateUrl="News.aspx" runat="server">Новости</asp:HyperLink>
    </div>
    <div>|</div>
    <div>
        <asp:HyperLink ID="HyperLink9" NavigateUrl="Settings.aspx" runat="server">Настройки</asp:HyperLink>
    </div>
    <div class="clear"></div>
</div>