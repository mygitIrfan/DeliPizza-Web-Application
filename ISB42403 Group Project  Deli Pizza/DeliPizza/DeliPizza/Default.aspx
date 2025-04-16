<%@ Page Title="" Language="C#" MasterPageFile="~/rotipizza.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DeliPizza.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Style/home.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="header-section">
        <h1 class="tagline"><span class="deli">DELI</span> Pizza - Taste the Best, Forget the Rest!</h1>
        <div class="centered-dropdown">
            <p>Food:</p>
            <asp:DropDownList ID="ddlCategories" runat="server" DataSourceID="SqlDataSource1" DataTextField="CatTitle" DataValueField="CatID" AutoPostBack="True"></asp:DropDownList>
        </div>
    </div>
    <p>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ItemID" DataSourceID="SqlDataSource2" PageSize="4" CssClass="GridViewStyle">
            <Columns>
                <asp:BoundField DataField="ItemID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ItemID" />
                <asp:BoundField DataField="FoodName" HeaderText="Food Name" SortExpression="FoodName" />
                <asp:BoundField DataField="FoodPrice" HeaderText="Price" SortExpression="FoodPrice" DataFormatString="RM {0:F2}" />
                <asp:BoundField DataField="About" HeaderText="About" SortExpression="About" />
                <asp:ImageField DataImageUrlField="ItemImage" DataImageUrlFormatString="ImagesPizza/{0}" HeaderText="Variety of Food">
                    <ControlStyle Width="80px" />
                </asp:ImageField>
            </Columns>
        </asp:GridView>
    </p>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [FoodCategories] ORDER BY [CatID]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Items] WHERE ([CatID] = @CatID) ORDER BY [ItemID]">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlCategories" Name="CatID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
