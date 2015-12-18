using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.Common;
using System.Collections.Specialized;

/// <summary>
/// Summary description for WishListItem
/// </summary>
public class WishListItem
{
    private static string WishListId
    {
        get
        {
            // get the current HttpContext
            HttpContext context = HttpContext.Current;
            // try to retrieve the cart ID from the user session object
            string wishId = "";
            object wishListIdSession = context.Session["BalloonShop_WishListID"];
            if (wishListIdSession != null)
                wishListIdSession = wishId.ToString();
            // if the ID exists in the current session...
            if (wishId != "")
                // return its value
                return wishId;
            else
            // if the cart ID isn't in the session...
            {
                // check if the cart ID exists as a cookie
                if (context.Request.Cookies["BalloonShop_WishListID"] != null)
                {
                    // if the cart exists as a cookie, use the cookie to get its value
                    wishListIdSession = context.Request.Cookies["BalloonShop_WishListID"].Value;
                    // save the id to the session, to avoid reading the cookie next time
                    context.Session["BalloonShop_WishListID"] = wishId;
                    // return the id
                    return wishId;
                }
                else
                // if the cart ID doesn't exist in the cookie as well, generate a new ID
                {
                    // generate a new GUID
                    wishId = Guid.NewGuid().ToString();
                    // create the cookie object and set its value
                    HttpCookie cookie = new HttpCookie("BalloonShop_WishListID", wishId.ToString());
                    // set the cookie's expiration date 
                    int howManyDays = BalloonShopConfiguration.CartPersistDays;
                    DateTime currentDate = DateTime.Now;
                    TimeSpan timeSpan = new TimeSpan(howManyDays, 0, 0, 0);
                    DateTime expirationDate = currentDate.Add(timeSpan);
                    cookie.Expires = expirationDate;
                    // set the cookie on client's browser
                    context.Response.Cookies.Add(cookie);
                    // save the ID to the Session as well
                    context.Session["BalloonShop_WishListID"] = wishId;
                    // return the CartID
                    return wishId.ToString();
                }
            }
        }
    }
    public static bool AddItem(string productId)
    {
        DbCommand comm = GenericDataAccess.CreateCommand();
        comm.CommandText = "WishListAddItem";

        DbParameter param = comm.CreateParameter();
        param.ParameterName = "@WishListID";
        param.Value = WishListId;
        param.DbType = DbType.String;
        param.Size = 36;
        comm.Parameters.Add(param);

        param = comm.CreateParameter();
        param.ParameterName = "@ProductID";
         param.Value = productId;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);
        
        try{
        return (GenericDataAccess.ExecuteNonQuery(comm) != -1);
        }
        catch{
        return false;
        }
    }

    public static bool RemoveItemWishList(string productId, int quantity)
    {
        DbCommand comm = GenericDataAccess.CreateCommand();
        comm.CommandText = "WishListRemoveItem";
        DbParameter param = comm.CreateParameter();
        param.ParameterName = "@WishListID";
        param.Value = WishListId;
        param.DbType = DbType.String;
        param.Size = 36;
        comm.Parameters.Add(param);        
        
        param = comm.CreateParameter();
        param.ParameterName = "@ProductID";
        param.Value = productId;
        param.DbType = DbType.Int32;
        comm.Parameters.Add(param);

        try{
        return (GenericDataAccess.ExecuteNonQuery(comm) != -1);
        }
        catch
        {
        return false;
        }
    }

    // Retrieve shopping cart items
    public static DataTable GetItems()
    {
        // get a configured DbCommand object
        DbCommand comm = GenericDataAccess.CreateCommand();
        // set the stored procedure name
        comm.CommandText = "WishListGetItems";
        // create a new parameter
        DbParameter param = comm.CreateParameter();
        param.ParameterName = "@WishListID";
        param.Value = WishListId;
        param.DbType = DbType.String;
        param.Size = 36;
        comm.Parameters.Add(param);
        // return the result table
        DataTable table = GenericDataAccess.ExecuteSelectCommand(comm);
        return table;
    }




}
