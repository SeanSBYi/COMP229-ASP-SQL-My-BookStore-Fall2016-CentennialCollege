using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WishList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            PopulateControls();
    }

    // fill wishlist controls with data
    private void PopulateControls()
    {
        // set the title of the page
        this.Title = BalloonShopConfiguration.SiteName + " :Wish List";

        DataTable dt = WishListItem.GetItems();

        // populate the list with the shopping cart contents
        GridView1.DataSource = dt;
        GridView1.DataBind();
        GridView1.Visible = true;
    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        // Index of the row being deleted
        int rowIndex = e.RowIndex;
        // The ID of the product being deleted
        string productId = GridView1.DataKeys[rowIndex].Value.ToString();

        WishListItem.RemoveItemWishList(productId, 1);

        // Repopulate the control
        PopulateControls();
    }
}