<%@ Page Language="C#" MasterPageFile="~/MyBookStore.master" AutoEventWireup="true" CodeFile="WishList.aspx.cs"  Inherits="WishList" Title="Wish List"%>

<%@ Register Src="UserControls/ProductsList.ascx" TagName="ProductsList" TagPrefix="uc1" %>

<asp:Content ID="content" ContentPlaceHolderID="contentPlaceHolder" Runat="server">
    
<div class="ProductContent">
    <span class="commonTitle">My WishList</span>
    <p />
    <div style="width: 100%; text-align: center; vertical-align: middle">

        <asp:GridView ID="GridView1"  Width="100%" runat="server" AutoGenerateColumns="False" DataKeyNames="ProductID"
            EnableModelValidation="True"
            BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px"
            CellPadding="4" CellSpacing="2" ForeColor="Black" CssClass="auto-style2"
            OnRowDeleting="GridView1_RowDeleting">
            <Columns>
                <asp:ImageField DataImageUrlField="Image1FileName" HeaderText="Book Cover" DataImageUrlFormatString="~/ProductImages/{0}" ItemStyle-Width="60px" ControlStyle-Width="100" ControlStyle-Height = "100" >
                    <ControlStyle Height="100px" Width="100px"></ControlStyle>
                    <ItemStyle Width="60px"></ItemStyle>
                </asp:ImageField>
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:c}" SortExpression="Price" />
                <asp:HyperLinkField DataNavigateUrlFields="ProductID" HeaderText="Detail" DataNavigateUrlFormatString="Product.aspx?ProductID={0}"
                Text="View Product" />
                <asp:ButtonField CommandName="Delete" HeaderText="Delete Item" Text="Delete" />
            </Columns>

            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
        </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSourceWishList" runat="server" ConnectionString="<%$ ConnectionStrings:BalloonShopConnectionString %>" SelectCommand="WishListGetItems" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:CookieParameter CookieName="BallonShop_WishListID" DefaultValue="0" Name="WishListID" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

    </div>
</div>
</asp:Content>

<asp:Content ID="Content1" runat="server" contentplaceholderid="head">
    <style type="text/css">
        .commonTitle {
            font-family: Verdana, Helvetica, sans-serif;
            text-decoration: none;
            font-size: 28px;
            font-weight: bold;
            line-height: 15px;
        }
        .auto-style2 {
            margin-right: 2px;
        }
    </style>
</asp:Content>

