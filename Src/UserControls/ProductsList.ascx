<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductsList.ascx.cs" Inherits="ProductsList" %>

<div class="ProductContent1">

<asp:Label ID="pagingLabel" runat="server" CssClass="PagingText" Visible="false" />
&nbsp;&nbsp;
<asp:HyperLink ID="previousLink" runat="server" CssClass="PagingText" Visible="false">Previous</asp:HyperLink>
&nbsp;&nbsp;
<asp:HyperLink ID="nextLink" runat="server" CssClass="PagingText" Visible="false">Next</asp:HyperLink>

<asp:DataList ID="list" Runat="server" Width="100%" RepeatColumns="3" EnableViewState="False" OnItemCommand="list_ItemCommand" OnSelectedIndexChanged="list_SelectedIndexChanged">
  <ItemTemplate>
      <div style="text-align:center;">
      <div style="width:50%; margin: 0 auto; text-align:left;">
          <table style="width:100%;">
              <tr>
                  <td style="width: 200px;">
                      <a href='Product.aspx?ProductID=<%# Eval("ProductID")%>'>
                      <img width="100" src='ProductImages/<%# Eval("Image1FileName") %>' border="0"/>
                      </a>
                  </td>
              </tr>
              <tr>
                  <td style="width: 200px;">
                      <span class="ProductName"> <%# Eval("Name") %> </span>
                  </td>
              </tr>
              <tr>
                  <td>
                      <span class="ProductDescription"> <%# Eval("Description") %> </span>
                  </td>
              </tr>
              <tr>
                  <td style="padding-left: 15px;">
                      <span class="ProductPrice"> Price: <%# Eval("Price", "{0:c}") %> </span>
                  </td>
              </tr>
          </table>
          <table style="width: 100%;">
              <tr>
                  <td>
                      <%--
                      Qty :
                      --%>
                  </td>
                  <td>
                  </td>
                  <td>
                      <asp:Button ID="addToCartButton" runat="server" Text="Add to Cart" CommandArgument='<%# Eval("ProductID") %>' CssClass="SmallButtonText" />
                   
                  </td>
              </tr>
          </table>
      </div>
      </div>
 </ItemTemplate>

</asp:DataList>
</div>
