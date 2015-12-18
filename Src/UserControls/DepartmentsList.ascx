<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DepartmentsList.ascx.cs" Inherits="DepartmentsList" %>


<style type="text/css">
    .auto-style1 {
        width: 26px;
        height: 26px;
        vertical-align: middle;
    }
</style>


<div id="topMenu">
    <div style="width: 100%; text-align: center; vertical-align: middle">
    <table>
        <tr>
            <td><span class="menuLink"><a href="AboutUs.aspx">About us</a></span></td>
            <td>
            <asp:DataList ID="list" runat="server" style="width:auto;" CssClass="DepartmentListContent" RepeatDirection="Horizontal">
                <ItemTemplate>
                <asp:HyperLink 
                  ID="menuLink" 
                  Runat="server" 
                  NavigateUrl='<%# "../Catalog.aspx?DepartmentID=" + Eval("DepartmentID")%>'
                  Text='<%# Eval("Name") %>'
                  ToolTip='<%# Eval("Description") %>'
                  CssClass='menuLink'>
                </asp:HyperLink>
                </ItemTemplate>
            </asp:DataList>
            </td>
            <td><span class="menuLink">Contract us</span></td>
            <td><span class="wishList">
                <a href="WishList.aspx">
                <img class="auto-style1" src="../Images/Wishlist-128.png" /> Wish List </a> </span></td>
            </tr>   
    </table>
        </div>
</div>