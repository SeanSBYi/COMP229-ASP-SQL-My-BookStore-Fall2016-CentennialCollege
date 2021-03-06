<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CategoriesList.ascx.cs" Inherits="CategoriesList" %>
<asp:DataList ID="list" runat="server" CssClass="CategoryListContent" Width="200 px" RepeatLayout="Flow">
  <ItemTemplate>
    &raquo;
    <asp:HyperLink 
      ID="HyperLink1" 
      Runat="server" 
      NavigateUrl='<%# "../Catalog.aspx?DepartmentID=" + Request.QueryString["DepartmentID"] + "&CategoryID=" + Eval("CategoryID")  %>'
      Text='<%# Eval("Name") %>' 
      ToolTip='<%# Eval("Description") %>' 
      CssClass='<%# Eval("CategoryID").ToString() == Request.QueryString["CategoryID"] ? "CategorySelected" : "CategoryUnselected" %>'>>
    </asp:HyperLink>
    &laquo;
  </ItemTemplate>
  <HeaderTemplate>
      Genre
  </HeaderTemplate>
  <HeaderStyle CssClass="CategoryListHead" />
</asp:DataList><asp:Label ID="brLabel" runat="server" Text="" />
  
