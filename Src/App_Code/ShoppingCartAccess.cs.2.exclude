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
using Oracle.ManagedDataAccess.Client;
using Oracle.ManagedDataAccess.Types;

/// <summary>
/// Supports Shopping Cart functionality
/// </summary>
public class ShoppingCartAccess
{
  public ShoppingCartAccess()
  {
    //
    // TODO: Add constructor logic here
    //
  }

  // returns the shopping cart ID for the current user
  private static string shoppingCartId
  {
    get
    {
      // get the current HttpContext
      HttpContext context = HttpContext.Current;
      // try to retrieve the cart ID from the user session object
      string cartId = "";
      object cartIdSession = context.Session["BalloonShop_CartID"];
      if (cartIdSession != null)
        cartId = cartIdSession.ToString();
      // if the ID exists in the current session...
      if (cartId != "")
        // return its value
        return cartId;
      else
      // if the cart ID isn't in the session...
      {
        // check if the cart ID exists as a cookie
        if (context.Request.Cookies["BalloonShop_CartID"] != null)
        {
          // if the cart exists as a cookie, use the cookie to get its value
          cartId = context.Request.Cookies["BalloonShop_CartID"].Value;
          // save the id to the session, to avoid reading the cookie next time
          context.Session["BalloonShop_CartID"] = cartId;
          // return the id
          return cartId;
        }
        else
        // if the cart ID doesn't exist in the cookie as well, generate a new ID
        {
          // generate a new GUID
          cartId = Guid.NewGuid().ToString();
          // create the cookie object and set its value
          HttpCookie cookie = new HttpCookie("BalloonShop_CartID", cartId.ToString());
          // set the cookie's expiration date 
          int howManyDays = BalloonShopConfiguration.CartPersistDays;
          DateTime currentDate = DateTime.Now;
          TimeSpan timeSpan = new TimeSpan(howManyDays, 0, 0, 0);
          DateTime expirationDate = currentDate.Add(timeSpan);
          cookie.Expires = expirationDate;
          // set the cookie on client's browser
          context.Response.Cookies.Add(cookie);
          // save the ID to the Session as well
          context.Session["BalloonShop_CartID"] = cartId;
          // return the CartID
          return cartId.ToString();
        }
      }
    }
  }

  // Add a new shopping cart item
  public static  bool AddItem(string productId)
  {
    // get a configured OracleCommand object
    OracleCommand comm = GenericDataAccess.CreateCommand();
    // set the stored procedure name
    comm.CommandText = "ShoppingCartAddItem";
    // create a new parameter
    OracleParameter param = comm.Parameters.Add("v_cartid", OracleDbType.Varchar2);
      param.Direction = ParameterDirection.Input;

      param.Value = shoppingCartId;
    
    // create a new parameter
    OracleParameter param1 = comm.Parameters.Add("v_prodid", OracleDbType.Int32);
    param1.Direction = ParameterDirection.Input;
   
    param1.Value = Int32.Parse(productId);
   comm.CommandType = CommandType.StoredProcedure;
   //changed for compatibility
    // create a new parameter
   // OracleParameter param2 = comm.Parameters.Add("v_attributes", OracleDbType.Varchar2);
    //param2.Direction = ParameterDirection.Input;
    //param2.Value = "attributes";
    //OracleParameter param3 = comm.Parameters.Add("result", OracleDbType.Int32);
    //param3.Direction = ParameterDirection.ReturnValue;
    //comm.CommandType = CommandType.StoredProcedure;
    // returns true in case of success or false in case of an error
    try
    {
      // execute the stored procedure and return true if it executes
      // successfully, or false otherwise
       GenericDataAccess.ExecuteNonQuery(comm);
       return true;
    }
    catch
    {
      // prevent the exception from propagating, but return false to 
      // signal the error
        return true;
    }
  }

  // Update the quantity of a shopping cart item
  public static bool UpdateItem(string productId, int quantity)
  {
    // get a configured OracleCommand object
    OracleCommand comm = GenericDataAccess.CreateCommand();
    // set the stored procedure name
    comm.CommandText = "ShoppingCartUpdateItem";
    // create a new parameter
    OracleParameter param = comm.Parameters.Add("v_cartid", OracleDbType.Char);
    param.Direction = ParameterDirection.Input;
   
    param.Value = shoppingCartId;
    
    // create a new parameter
      OracleParameter  param1 = comm.Parameters.Add("v_prodid", OracleDbType.Int32);
      param1.Direction = ParameterDirection.Input;
   
    param1.Value = Int32.Parse(productId);
   
    // create a new parameter
    OracleParameter param2 = comm.Parameters.Add("v_quantity", OracleDbType.Int32);
    param2.Direction = ParameterDirection.Input;
    param2.Value = quantity;
    comm.CommandType = CommandType.StoredProcedure;
    // returns true in case of success or false in case of an error
    try
    {
      // execute the stored procedure and return true if it executes
      // successfully, or false otherwise
        GenericDataAccess.ExecuteNonQuery(comm);
      return (true);
    }
    catch
    {
      // prevent the exception from propagating, but return false to 
      // signal the error
      return false;
    }
  }

  // Remove a shopping cart item
  public static bool RemoveItem(string productId)
  {
    // get a configured OracleCommand object
    OracleCommand comm = GenericDataAccess.CreateCommand();
    // set the stored procedure name
    comm.CommandText = "ShoppingCartRemoveItem";
    // create a new parameter
    OracleParameter param = comm.Parameters.Add("v_shoppingcart", OracleDbType.Varchar2);
    param.Direction = ParameterDirection.Input;
    param.Value = shoppingCartId;
   
    // create a new parameter
    OracleParameter param1 = comm.Parameters.Add("v_prodid", OracleDbType.Int32);
    param1.Direction = ParameterDirection.Input;
    param1.Value = Int32.Parse(productId);
    
    comm.CommandType = CommandType.StoredProcedure;
    // returns true in case of success or false in case of an error
    try
    {
      // execute the stored procedure and return true if it executes
      // successfully, or false otherwise
        GenericDataAccess.ExecuteNonQuery(comm);
      return (true);
    }
    catch
    {
      // prevent the exception from propagating, but return false to 
      // signal the error
      return false;
    }
  }

  // Retrieve shopping cart items
  public static DataTable GetItems()
  {
    // get a configured OracleCommand object
    OracleCommand comm = GenericDataAccess.CreateCommand();
    // set the stored procedure name
    comm.CommandText = "ShoppingCartGetItems";
    // create a new parameter
    OracleParameter param = comm.Parameters.Add("v_shoppingcart", OracleDbType.Char);
    param.Direction = ParameterDirection.Input;
    param.Value = shoppingCartId;
    OracleParameter param2 = comm.Parameters.Add("all_out", OracleDbType.RefCursor);
    param2.Direction = ParameterDirection.Output;
    // return the result table
    comm.CommandType = CommandType.StoredProcedure;
    DataTable table = GenericDataAccess.ExecuteSelectCommand(comm);
    return table;
  }

  // Retrieve shopping cart items
  public static decimal GetTotalAmount()
  {
      decimal shopTotal = 0;
    // get a configured OracleCommand object
    OracleCommand comm = GenericDataAccess.CreateCommand();
    // set the stored procedure name
    comm.CommandText = "ShoppingCartGetTotalAmount";
    // create a new parameter
    OracleParameter param = comm.Parameters.Add("v_shoppingcart", OracleDbType.Char);
    param.Direction = ParameterDirection.Input;
    param.Value = shoppingCartId;
    OracleParameter param1 = comm.Parameters.Add("all_out", OracleDbType.Decimal);
    param1.Direction = ParameterDirection.Output;
    comm.CommandType = CommandType.StoredProcedure;
    // return the result table
   

    GenericDataAccess.ExecuteNonQuery(comm);
    shopTotal = Decimal.Parse(comm.Parameters["all_out"].Value.ToString());
      return shopTotal; 
  }

  // Counts old shopping carts
  public static int CountOldCarts(int days)
  {
    // get a configured OracleCommand object
    OracleCommand comm = GenericDataAccess.CreateCommand();
    // set the stored procedure name
    comm.CommandText = "ShoppingCartCountOldCarts";
    // create a new parameter
    OracleParameter param = comm.Parameters.Add("days", OracleDbType.Int32);
    param.Direction = ParameterDirection.Input;
    param.Value = days;
    OracleParameter param2 = comm.Parameters.Add("cartcount", OracleDbType.Int32);
    param2.Direction = ParameterDirection.Output;
    comm.CommandType = CommandType.StoredProcedure;
    // execute the procedure and return number of old shopping carts
    try
    {
        GenericDataAccess.ExecuteScalar(comm);
      return Int32.Parse(comm.Parameters["cartcount"].Value.ToString());
    }
    catch
    {
      return -1;
    }
  }

  // Deletes old shopping carts
  public static bool DeleteOldCarts(int days)
  {
    // get a configured OracleCommand object
    OracleCommand comm = GenericDataAccess.CreateCommand();
    // set the stored procedure name
    comm.CommandText = "ShoppingCartDeleteOldCarts";
    // create a new parameter
    OracleParameter param = comm.Parameters.Add("days", OracleDbType.Int32);
    param.Direction = ParameterDirection.Input;
    param.Value = days;
    comm.CommandType = CommandType.StoredProcedure;
    // execute the procedure and return true if no problem occurs
    try
    {
      GenericDataAccess.ExecuteNonQuery(comm);
      return true;
    }
    catch
    {
      return false;
    }
  }

  // Create a new order from the shopping cart
  public static string CreateOrder()
  {
    // get a configured OracleCommand object
    OracleCommand comm = GenericDataAccess.CreateCommand();
    // set the stored procedure name
    comm.CommandText = "CreateOrder";
    // create a new parameter
    OracleParameter param = comm.Parameters.Add("v_shoppingcartid", OracleDbType.Char);
    param.Direction = ParameterDirection.Input;
    param.Value = shoppingCartId;
    OracleParameter param1 = comm.Parameters.Add("v_orderid", OracleDbType.Int32);
    param1.Direction = ParameterDirection.Output;
    comm.CommandType = CommandType.StoredProcedure;
    // return the result table
    GenericDataAccess.ExecuteNonQuery(comm);
    return (comm.Parameters["v_orderid"].Value.ToString());
  }

  // gets product recommendations for the shopping cart
  public static DataTable GetRecommendations()
  {
    // get a configured OracleCommand object
    OracleCommand comm = GenericDataAccess.CreateCommand();
    // set the stored procedure name
    comm.CommandText = "CatalogGetCartRecommendations";
    // create a new parameter
    OracleParameter param = comm.Parameters.Add("v_cartid", OracleDbType.Char);
    param.Direction = ParameterDirection.Input;
    param.Value = shoppingCartId;
     // create a new parameter
   OracleParameter param1 = comm.Parameters.Add("descriptionlength", OracleDbType.Int32);
   param1.Direction = ParameterDirection.Input;
    param1.Value = BalloonShopConfiguration.ProductDescriptionLength;
    OracleParameter param2 = comm.Parameters.Add("all_out", OracleDbType.RefCursor);
    param2.Direction = ParameterDirection.Output;
    comm.CommandType = CommandType.StoredProcedure;
    // execute the stored procedure
    return GenericDataAccess.ExecuteSelectCommand(comm);
  }
}
