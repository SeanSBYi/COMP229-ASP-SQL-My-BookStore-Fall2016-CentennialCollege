<%@ Page Language="C#" MasterPageFile="~/MyBookStore.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" Title="Welcome to Allied Books!" %>

<%@ Register Src="UserControls/ProductsList.ascx" TagName="ProductsList" TagPrefix="uc1" %>
<asp:Content ID="content" ContentPlaceHolderID="contentPlaceHolder" Runat="server">

     <div style="width: 100%; text-align: center; vertical-align: middle">
         <span class="CatalogTitle">Welcome to Allied Books! </span>
         <table id="MainContent">
                <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td colspan="3">
                    <img src="Images/main_img_01.jpg" />
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td colspan="3" style="text-align: center;">
                    <uc1:ProductsList ID="ProductsList1" runat="server" />
                </td>
            </tr>
             <tr>
                 <td></td>
                 <td></td>
                 <td></td>
             </tr>
            <tr>
                <td class="align_center">
                    <img src="Images/main_img_11.png" />
                </td>
                <td class="align_center">
                    <img src="Images/main_img_12.jpg" />
                </td>
                <td class="align_center">
                    <img src="Images/main_img_13.jpg" />
                </td>
            </tr>
        </table>
    </div>
    
</asp:Content>

