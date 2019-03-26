<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Price.aspx.cs" Inherits="Gulden_Price.ru.VendorPages.Price" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script>
        $body = $("body");

        $(function () {
            $("#dialogUpdatePrice").dialog({
                autoOpen: false,
                resizable: false,
                height: 500,
                width: 700,
                modal: true,
                open: function (type, data) {
                    $(this).parent().appendTo("form");
                },
                buttons: {
                    Cancel: function () {
                        $(this).dialog("close");
                    }
                }
            });

            $(".updatePrice").on("click", function () {
                $("#dialogUpdatePrice").dialog("open");
            });
        });

        $(document).ready(function () {
            $("#loading-div-background").css({ opacity: 0.8 });

            $("#imgHide").click(function () {
                $("#imgHide").hide();
            });
            $("#imgShow").click(function () {
                $("#imgHide").show();
            });

        });

        function ShowProgressAnimation() {

            $("#dialogUpdatePrice").dialog("close");
            $("#loading-div-background").show();

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%: Title %>.</h1>
    <div>
        Всего в прайсе товаров: <%=ProductsCount%>
    </div>
    <br />
    <div id="result">
        <asp:Label ID="LabelResult" runat="server" Text=""></asp:Label>
    </div>
    <br />
    <div id="rightPanel">
        <div class="updatePrice">
            <input id="Button1" type="button" value="Загрузить прайс" />
        </div>
        <asp:Button ID="ButtonDeleteAll" runat="server" Text="Удалить все записи" OnClick="ButtonDeleteAll_Click" />
        <asp:Button ID="ButtonDeleteOldProducts" runat="server" Text="Удалить старые продукты" OnClick="ButtonDeleteOldProducts_Click" />

    </div>


    <br />

    <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:TemplateField HeaderText="Название позиции">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("Name") %>'></asp:TextBox>
                    <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Eval("Id") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                    <br />
                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("Id") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Цена $">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Eval("Price") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Обновлено">
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Convert.ToDateTime(Eval("WhenDate")).ToString("dd-MM-yyyy") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField HeaderText="Редактировать" ShowEditButton="True" />
            <asp:CommandField HeaderText="Удалить" ShowDeleteButton="True" />
        </Columns>
        <EditRowStyle BackColor="#7C6F57" />
        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#E3EAEB" />
        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F8FAFA" />
        <SortedAscendingHeaderStyle BackColor="#246B61" />
        <SortedDescendingCellStyle BackColor="#D4DFE1" />
        <SortedDescendingHeaderStyle BackColor="#15524A" />
    </asp:GridView>
    <br />
    <br />

    <div id="dialogUpdatePrice" title="Загрузить прайс">
        <span id="imgShow" style="cursor: pointer;">Для того, что бы корректно загрузить прайс - удалите в файле строки перед таблицей!</span>
        <br />
        <div id="imgHide" style="display: none; cursor: pointer;">
            <img class="example-image" src="../Images/deleteRows2.jpg" height="350px" alt="" />
        </div>
        <br />
        Укажите нормер столбца с названием товара и номер столбца с ценой.
        <br />
        <br />
        <table>
            <tr>
                <td>Прайс:
                </td>
                <td>
                    <asp:FileUpload ID="FileUploadExcel" runat="server" />
                </td>
            </tr>
            <tr>
                <td>Название в столбце №:
                </td>
                <td>
                    <asp:TextBox ID="TextBoxColumnNumber" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Цена в столбце №:
                </td>
                <td>
                    <asp:TextBox ID="TextBoxPriceNumber" runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>
        <br />
        Если в прайсе название совпадает, то обновляется только цена. 
        <br />
        Новые позиции добавляются.
        <br />
        <asp:Button ID="ButtonUpdate" runat="server" Text="Загрузить" OnClientClick="ShowProgressAnimation()" OnClick="ButtonUpdate_Click" />
    </div>

    <div id="loading-div-background">
        <div id="loading-div" class="ui-corner-all">
            <img style="height: 80px; margin: 30px;" src="/Images/waiting.gif" alt="Loading.." />
            <h2 style="color: gray; font-weight: normal;">Прайс загружается..</h2>
        </div>
    </div>
</asp:Content>
