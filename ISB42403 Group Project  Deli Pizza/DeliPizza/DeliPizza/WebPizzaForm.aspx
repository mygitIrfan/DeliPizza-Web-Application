<%@ Page Title="" Language="C#" MasterPageFile="~/rotipizza.Master" AutoEventWireup="true" CodeBehind="WebPizzaForm.aspx.cs" Inherits="DeliPizza.WebPizzaForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Style/order.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="leftColumn">
        <p>
            <asp:DropDownList ID="ddlCategories" runat="server" DataSourceID="SqlDataSourceCategories" DataTextField="CatTitle" DataValueField="CatID" AutoPostBack="True"></asp:DropDownList>
        </p>

        <p>
            <asp:GridView ID="GridViewItems" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ItemID" DataSourceID="SqlDataSourceItems" PageSize="3" OnSelectedIndexChanged="GridViewItems_SelectedIndexChanged" CssClass="grid-view">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="ItemID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ItemID" />
                    <asp:BoundField DataField="FoodName" HeaderText="Food Name" SortExpression="FoodName" />
                    <asp:BoundField DataField="FoodPrice" HeaderText="Price" SortExpression="FoodPrice" DataFormatString="RM {0:F2}" />
                    <asp:BoundField DataField="About" HeaderText="About" SortExpression="About" />
                    <asp:ImageField DataImageUrlField="ItemImage" DataImageUrlFormatString="ImagesPizza/{0}" HeaderText="Variety of Food">
                        <ControlStyle Width="60px" />
                    </asp:ImageField>
                </Columns>
            </asp:GridView>
        </p>
        <asp:SqlDataSource ID="SqlDataSourceCategories" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [FoodCategories] ORDER BY [CatID]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceItems" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Items] WHERE ([CatID] = @CatID)" DeleteCommand="DELETE FROM [Items] WHERE [ItemID] = @ItemID" InsertCommand="INSERT INTO [Items] ([CatID], [FoodName], [FoodPrice], [About], [ItemImage]) VALUES (@CatID, @FoodName, @FoodPrice, @About, @ItemImage)" UpdateCommand="UPDATE [Items] SET [CatID] = @CatID, [FoodName] = @FoodName, [FoodPrice] = @FoodPrice, [About] = @About, [ItemImage] = @ItemImage WHERE [ItemID] = @ItemID">
            <DeleteParameters>
                <asp:Parameter Name="ItemID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="CatID" Type="Int32" />
                <asp:Parameter Name="FoodName" Type="String" />
                <asp:Parameter Name="FoodPrice" Type="Double" />
                <asp:Parameter Name="About" Type="String" />
                <asp:Parameter Name="ItemImage" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlCategories" Name="CatID" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="CatID" Type="Int32" />
                <asp:Parameter Name="FoodName" Type="String" />
                <asp:Parameter Name="FoodPrice" Type="Double" />
                <asp:Parameter Name="About" Type="String" />
                <asp:Parameter Name="ItemImage" Type="String" />
                <asp:Parameter Name="ItemID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <p>
            Item id:
            <asp:Label ID="lblItemId" runat="server"></asp:Label>&nbsp;|
            Item title:
            <asp:Label ID="lblItemTitle" runat="server"></asp:Label>&nbsp;|
            Item price:
            <asp:Label ID="lblItemPrice" runat="server"></asp:Label>
        </p>
        <p>
            Quantity:
            <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number" Width="50px">1</asp:TextBox>&nbsp;
            <asp:Button ID="btnAddItem" runat="server" Text="Add" OnClick="btnAddItem_Click" CssClass="small-round-button" />
        </p>
        <p>
            <asp:Label ID="lblMessage1" runat="server"></asp:Label>
        </p>
    </div>

    <div class="rightColumn">
        <h4>Sales Cart</h4>
        <p>
            Sales id:
            <asp:Label ID="lblSalesId" runat="server"></asp:Label>&nbsp;|
            Date and time:
            <asp:Label ID="lblDateTime" runat="server"></asp:Label>
        </p>

        <p>
            <asp:GridView ID="GridViewCart" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceCart" CssClass="grid-view">
                <Columns>
                    <asp:BoundField DataField="ItemID" HeaderText="ID" SortExpression="ItemID" />
                    <asp:BoundField DataField="FoodName" HeaderText="Food Name" SortExpression="FoodName" />
                    <asp:BoundField DataField="FoodPrice" HeaderText="Price" SortExpression="FoodPrice" DataFormatString="RM {0:F2}" />
                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                    <asp:BoundField DataField="SubTotal" HeaderText="SubTotal" ReadOnly="True" SortExpression="SubTotal" DataFormatString="RM {0:F2}" />
                </Columns>
            </asp:GridView>
        </p>

        <p>
            Total amount:
            <asp:Label ID="lblTotalAmountCart" runat="server" Text="RM0.00"></asp:Label>
        </p>
        <div class="button-group">
            <asp:Button ID="btnConfirm" runat="server" Text="Confirm" OnClick="btnConfirm_Click" CssClass="small-round-button" />&nbsp;
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" CssClass="small-round-button" />&nbsp;
            <asp:Button ID="btnNew" runat="server" Text="New" OnClick="btnNew_Click" CssClass="small-round-button" />
        </div>
        <div class="receipt">
            <p>
                <asp:Label ID="lblMessage2" runat="server"></asp:Label>
            </p>
            <p>
                <asp:Label ID="lblTotalAmount" runat="server"></asp:Label><br />
                <asp:Label ID="lblServiceTax" runat="server"></asp:Label><br />
                <asp:Label ID="lblAmountAfterTax" runat="server"></asp:Label><br />
                <asp:Label ID="lblRounding" runat="server"></asp:Label><br />
                <asp:Label ID="lblAmountRounded" runat="server"></asp:Label><br />
            </p>
        </div>

        <asp:SqlDataSource ID="SqlDataSourceCart" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="spSalesGetItems" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblSalesId" Name="SalesID" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
