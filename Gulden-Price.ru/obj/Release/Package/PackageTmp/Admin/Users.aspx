<%@ Page Title="Пользователи" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="Gulden_Price.ru.Admin.Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:GridView ID="GridViewUsers" runat="server" AutoGenerateColumns="False" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating">
        <Columns>
            <asp:TemplateField HeaderText="Имя">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Телефон">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("Phone") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Поставщик">
                <EditItemTemplate>
                    <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Eval("UserId") %>' />
                    <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Eval("IsVendor") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("UserId") %>' />
                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("IsVendor") %>' Enabled="False" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField HeaderText="Редактировать" ShowEditButton="True" />
            <asp:CommandField HeaderText="Удалить" ShowDeleteButton="True" />
        </Columns>
    </asp:GridView>
</asp:Content>
