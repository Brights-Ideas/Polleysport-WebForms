using System.Collections.Generic;
using System.Web;
using System.Configuration;
using System.Linq;

/**
 * The ShoppingCart class
 * 
 * Holds the items that are in the cart and provides methods for their manipulation
 */
public class ShoppingCart
{
    #region Properties

    public List<CartItem> Items { get; private set; }

    #endregion

    #region Singleton Implementation

    /// <summary>
    /// If the cart is not in the session, create one and put it there, Otherwise, get it from the session
    /// </summary>
    /// <returns></returns>
    public static ShoppingCart GetInstance()
    {
        ShoppingCart cart = (ShoppingCart)HttpContext.Current.Session["ASPNETShoppingCart"];

        if (cart == null)
        {
            HttpContext.Current.Session["ASPNETShoppingCart"] = cart = new ShoppingCart();
        }

        return cart;
    }

    // A protected constructor ensures that an object can't be created from outside
    protected ShoppingCart()
    {
        Items = new List<CartItem>();
    }

    #endregion

    #region Item Modification Methods
    /**
	 * AddItem() - Adds an item to the shopping 
	 */
    public void AddItem(int productId, decimal price, string size, int quantity, int sizeId)
    {
        // Create a new item to add to the cart
        CartItem newItem = new CartItem(productId, sizeId);

        // If this item already exists in our list of items, increase the quantity
        // Otherwise, add the new item to the list
        if (Items.Contains(newItem))
        {
            foreach (CartItem item in Items)
            {
                if (item.Equals(newItem))
                {
                    item.Quantity++;
                    return;
                }
            }
        }
        else
        {
            newItem.Quantity = quantity; //1;
            newItem.Price = price;
            newItem.Size = size;
            newItem.SizeId = sizeId;
            Items.Add(newItem);
        }
    }

    /**
	 * SetItemPrice() - Changes the price of an item in the cart
	 */
    //public void SetItemPrice(int productId, decimal price) {

    //    // Find the item and update the price
    //    CartItem updatedItem = new CartItem(productId, size);

    //    foreach (CartItem item in Items) {
    //        if (item.Equals(updatedItem)) {
    //            item.Price = price;
    //            return;
    //        }
    //    }
    //}

    /**
    * SetItemSize() - Changes the size of an item in the cart
    */
    public void SetItemSize(int productId, int sizeId)
    {
        // Find the item and update the price
        CartItem updatedItem = new CartItem(productId, sizeId);

        foreach (CartItem item in Items)
        {
            if (item.Equals(updatedItem))
            {
                item.SizeId = sizeId;
                return;
            }
        }
    }

    /**
	 * SetItemQuantity() - Changes the quantity of an item in the cart
	 */
    public void SetItemQuantity(int productId, int quantity, int sizeId)
    {
        // If we are setting the quantity to 0, remove the item entirely
        if (quantity == 0)
        {
            RemoveItem(productId, sizeId);
            return;
        }

        // Find the item and update the quantity
        CartItem updatedItem = new CartItem(productId, sizeId);

        foreach (CartItem item in Items)
        {
            if (item.Equals(updatedItem))
            {
                item.Quantity = quantity;
                //item.Price = price;
                return;
            }
        }
    }

    /**
     * RemoveItem() - Removes an item from the shopping cart
     */
    public void RemoveItem(int productId, int sizeId)
    {
        CartItem removedItem = new CartItem(productId, sizeId);
        Items.Remove(removedItem);
    }

    /**
	 * RemoveAll() - Removes all items from the shopping cart
	 */
    public void RemoveAll()
    {
        Items.Clear();
    }

    #endregion

    #region Reporting Methods

    /// <summary>
    /// GetSubTotal() - returns the total price of all of the items before tax, shipping, etc.
    /// </summary>
    /// <returns></returns>
    public decimal GetSubTotal()
    {
        decimal subTotal = 0;
        foreach (CartItem item in Items)
            subTotal += item.TotalPrice;

        return subTotal;
    }

    /// <summary>
    ///  
    /// </summary>
    /// <returns>VAT price of all the items.</returns>
    public decimal ReturnItemVatTotal()
    {
        decimal vatTotal = 0;
        var cart = ShoppingCart.GetInstance().Items;
        var vat = decimal.Parse(ConfigurationManager.AppSettings["VatRate"]);
        foreach (CartItem item in Items)
        {
            //decimal afterTax= (item.TotalPrice + item.ShippingPrice) * (1+vat);
            //decimal xvat = -(1- afterTax / (item.TotalPrice + item.ShippingPrice));
            vatTotal += item.TotalPrice;// + item.ShippingPrice) * (vat);
        }
        if (cart.Count > 0)
            return (vatTotal + cart[0].ShippingPrice + cart.Count - 1) * (vat);
        else
            return vatTotal;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <returns>Total price of all items after VAT.</returns>
    public decimal ReturnItemTotal()
    {
        decimal Total = 0;
        var cart = ShoppingCart.GetInstance().Items.ToList();
        var vat = decimal.Parse(ConfigurationManager.AppSettings["VatRate"]);
        foreach (CartItem item in Items)
        Total += item.TotalPrice;//(item.TotalPrice + GetShippingCosts()) * (1+vat); //item.TotalPrice * vat + item.TotalPrice + item.ShippingPrice * vat + item.ShippingPrice;

        if (cart.Count > 0)
            return (Total + cart[0].ShippingPrice + cart.Count() - 1) * (1 + vat);
        else
            return Total;
    }

    /// <summary>
    /// Tyre shipping is £10.42 for up to 4 tyres then an additional £1 after that
    /// </summary>
    /// <returns>Tyre shipping/delivery costs</returns>
    public decimal GetShippingCosts()
    {
        decimal ShippingCost = 0;
        var cart = ShoppingCart.GetInstance().Items.ToList();
        var vat = decimal.Parse(ConfigurationManager.AppSettings["VatRate"]);
        
        foreach (CartItem item in Items)
        {
           // if (item.Quantity > 1)
            //{
                ShippingCost += item.Quantity;
          //  }
        }
        if (cart.Count > 0)
            return ShippingCost + cart[0].ShippingPrice - 1;
        else
            return ShippingCost;
    }
    #endregion

}
