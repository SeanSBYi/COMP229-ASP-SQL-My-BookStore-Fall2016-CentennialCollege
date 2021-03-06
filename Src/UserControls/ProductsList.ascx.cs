using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;

public partial class ProductsList : System.Web.UI.UserControl
{
  protected void Page_Load(object sender, EventArgs e)
  {
    PopulateControls();
  }

  private void PopulateControls()
  {
    // Retrieve DepartmentID from the query string
    string departmentId = Request.QueryString["DepartmentID"];
    // Retrieve CategoryID from the query string
    string categoryId = Request.QueryString["CategoryID"];
    // Retrieve Page from the query string
    string page = Request.QueryString["Page"];
    if (page == null) page = "1";
    // Retrieve Search string from query string
    string searchString = Request.QueryString["Search"];
    // How many pages of products?
    int howManyPages = 1;
    // If performing a product search
    if (searchString != null)
    {
      // Retrieve AllWords from query string
      string allWords = Request.QueryString["AllWords"];
      // Perform search
      list.DataSource = CatalogAccess.Search(searchString, allWords, page, out howManyPages);
      list.DataBind();
    }
    // If browsing a category...
    else if (categoryId != null)
    {
      // Retrieve list of products in a category
      list.DataSource = CatalogAccess.GetProductsInCategory(categoryId, page, out howManyPages);
      list.DataBind();
    }
    else if (departmentId != null)
    {
      // Retrieve list of products on department promotion
      list.DataSource = CatalogAccess.GetProductsOnDepartmentPromotion(departmentId, page, out howManyPages);
      list.DataBind();
    }
    else
    {
      // Retrieve list of products on catalog promotion
      list.DataSource = CatalogAccess.GetProductsOnCatalogPromotion(page, out howManyPages);
      list.DataBind();
    }
    // display paging controls
    if (howManyPages > 1)
    {
      // have the current page as integer
      int currentPage = Int32.Parse(page);
      // make controls visible
      pagingLabel.Visible = true;
      previousLink.Visible = true;
      nextLink.Visible = true;
      // set the paging text
      pagingLabel.Text = "Page " + page + " of " + howManyPages.ToString();
      // create the Previous link
      if (currentPage == 1)
        previousLink.Enabled = false;
      else
      {
        NameValueCollection query = Request.QueryString;
        string paramName, newQueryString = "?";
        for (int i = 0; i < query.Count; i++)
          if (query.AllKeys[i] != null)
            if ((paramName = query.AllKeys[i].ToString()).ToUpper() != "PAGE")
              newQueryString += paramName + "=" + query[i] + "&";
        previousLink.NavigateUrl = Request.Url.AbsolutePath + newQueryString + "Page=" + (currentPage - 1).ToString();
      }
      // create the Next link
      if (currentPage == howManyPages)
        nextLink.Enabled = false;
      else
      {
        NameValueCollection query = Request.QueryString;
        string paramName, newQueryString = "?";
        for (int i = 0; i < query.Count; i++)
          if (query.AllKeys[i] != null)
            if ((paramName = query.AllKeys[i].ToString()).ToUpper() != "PAGE")
              newQueryString += paramName + "=" + query[i] + "&";
        nextLink.NavigateUrl = Request.Url.AbsolutePath + newQueryString + "Page=" + (currentPage + 1).ToString();
      }
    }
  }

  // fires when an Add to Cart button is clicked
  protected void list_ItemCommand(object source, DataListCommandEventArgs e)
  {
    // The CommandArgument of the clicked Button contains the ProductID 
    string productId = e.CommandArgument.ToString();
    // Add the product to the shopping cart
    ShoppingCartAccess.AddItem(productId);
  }

    protected void list_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void addWishlist_Click(object sender, EventArgs e)
    {
        string productId = Request.QueryString["ProductID"];
        WishListItem.AddItem(productId);
    }


}