<%@ Page Title="" Language="C#" MasterPageFile="~/rotipizza.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="DeliPizza.Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Style/admin.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Admin Page</h2>

    <div class="admin-container">
        <div class="manage-gridview">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                DeleteCommand="DELETE FROM [UserAccounts] WHERE [Id] = @Id"
                InsertCommand="INSERT INTO [UserAccounts] ([UserName], [PasswordHash], [Role], [Enabled]) VALUES (@UserName, @PasswordHash, @Role, @Enabled)"
                SelectCommand="SELECT * FROM [UserAccounts]"
                UpdateCommand="UPDATE [UserAccounts] SET [UserName] = @UserName, [PasswordHash] = @PasswordHash, [Role] = @Role, [Enabled] = @Enabled WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="UserName" Type="String" />
                    <asp:Parameter Name="PasswordHash" Type="String" />
                    <asp:Parameter Name="Role" Type="String" />
                    <asp:Parameter Name="Enabled" Type="Boolean" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="UserName" Type="String" />
                    <asp:Parameter Name="PasswordHash" Type="String" />
                    <asp:Parameter Name="Role" Type="String" />
                    <asp:Parameter Name="Enabled" Type="Boolean" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1" PageSize="5" CssClass="gridview">
                <Columns>
                    <asp:CommandField ShowEditButton="True" HeaderStyle-CssClass="gridview-header" ShowDeleteButton="True">
                        <HeaderStyle CssClass="gridview-header"></HeaderStyle>
                    </asp:CommandField>
                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" HeaderStyle-CssClass="gridview-header">
                        <HeaderStyle CssClass="gridview-header" />
                        <ItemStyle Width="50px" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="UserName" SortExpression="UserName">
                        <HeaderStyle CssClass="gridview-header" />
                        <ItemTemplate>
                            <%# Eval("UserName") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtUserName" runat="server" Text='<%# Bind("UserName") %>' TextMode="MultiLine" Rows="2" Wrap="True" Width="100%"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemStyle Width="150px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="PasswordHash" SortExpression="PasswordHash">
                        <HeaderStyle CssClass="gridview-header" />
                        <ItemTemplate>
                            <%# Eval("PasswordHash") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPasswordHash" runat="server" Text='<%# Bind("PasswordHash") %>' TextMode="MultiLine" Rows="3" Wrap="True" Width="100%"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemStyle Width="200px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Role" SortExpression="Role">
                        <HeaderStyle CssClass="gridview-header" />
                        <ItemTemplate>
                            <%# Eval("Role") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtRole" runat="server" Text='<%# Bind("Role") %>' TextMode="MultiLine" Rows="1" Wrap="True" Width="100%"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Enabled" SortExpression="Enabled">
                        <HeaderStyle CssClass="gridview-header" />
                        <ItemTemplate>
                            <asp:CheckBox ID="chkEnabled" runat="server" Checked='<%# Convert.ToBoolean(Eval("Enabled")) %>' Enabled="false" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox ID="chkEnabledEdit" runat="server" Checked='<%# Bind("Enabled") %>' />
                        </EditItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div class="sales-report">
            <h1>Sales Report</h1>
            <asp:Label ID="lblTotalSalesAmount" runat="server" Text="Total Sales Amount: " Font-Bold="True" Font-Size="Large"></asp:Label>
            <br />
            <br />
            <div class="summary">
                <h2>Monthly Sales Summary</h2>
                <asp:GridView ID="gvMonthlySalesSummary" runat="server" DataSourceID="MonthlySalesSummaryDataSource" CssClass="gridview" AutoGenerateColumns="False" PageSize="5">
                    <Columns>
                        <asp:BoundField DataField="Year" HeaderText="Year" ReadOnly="True" SortExpression="Year" />
                        <asp:BoundField DataField="Month" HeaderText="Month" ReadOnly="True" SortExpression="Month" />
                        <asp:BoundField DataField="TotalAmount" DataFormatString="RM {0:F2}" HeaderText="Total Amount" ReadOnly="True" SortExpression="TotalAmount" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="MonthlySalesSummaryDataSource" runat="server"
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    SelectCommand="spGetMonthlySalesSummary"
                    SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </div>
            <br />
            <br />
            <div class="by-product">
                <h2>Sales by Product</h2>
                <asp:GridView ID="gvSalesByProduct" runat="server" DataSourceID="SalesByProductDataSource" AllowPaging="True" CssClass="gridview" AllowSorting="True" AutoGenerateColumns="False" PageSize="5">
                    <Columns>
                        <asp:BoundField DataField="FoodName" HeaderText="Food Name" SortExpression="FoodName" />
                        <asp:BoundField DataField="TotalQuantity" HeaderText="Total Quantity" ReadOnly="True" SortExpression="TotalQuantity" />
                        <asp:BoundField DataField="TotalAmount" DataFormatString="RM {0:F2}" HeaderText="Total Amount" ReadOnly="True" SortExpression="TotalAmount" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SalesByProductDataSource" runat="server"
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    SelectCommand="spGetSalesByProduct"
                    SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </div>
            <div class="sales-table">
                <h2>All Sales</h2>
                <asp:GridView ID="gvAllSales" runat="server" DataSourceID="AllSalesDataSource" AllowPaging="True" CssClass="gridview" AllowSorting="True" AutoGenerateColumns="False" PageSize="5" DataKeyNames="SalesID,ItemID">
                    <Columns>
                        <asp:BoundField DataField="SalesID" HeaderText="SalesID" ReadOnly="True" SortExpression="SalesID" />
                        <asp:BoundField DataField="ItemID" HeaderText="ItemID" ReadOnly="True" SortExpression="ItemID" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                        <asp:BoundField DataField="SalesDate" HeaderText="SalesDate" SortExpression="SalesDate" />
                        <asp:CheckBoxField DataField="Confirmed" HeaderText="Confirmed" SortExpression="Confirmed" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="AllSalesDataSource" runat="server"
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    SelectCommand="SELECT * FROM [Sales]"></asp:SqlDataSource>
            </div>
        </div>
    </div>
</asp:Content>
