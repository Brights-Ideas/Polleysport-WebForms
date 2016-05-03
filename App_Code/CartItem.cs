using System;
using System.Configuration;

/**
 * The CartItem Class
 * 
 * Basically a structure for holding item data
 */
public class CartItem : IEquatable<CartItem> {
	#region Properties

	// A place to store the quantity in the cart
	// This property has an implicit getter and setter.
	public int Quantity { get; set; }
    public decimal Price { get; set; }
    public string Size { get; set; }
    public int SizeId { get; set; }

	private int _productId;
	public int ProductId {
		get { return _productId; }
		set {
			// To ensure that the Prod object will be re-created
			_product = null;
			_productId = value;
		}
	}

	private Product _product = null;
	public Product Prod {
		get {
			// Lazy initialization - the object won't be created until it is needed
			if (_product == null) {
				_product = new Product(ProductId, Price, Size, Quantity, SizeId);
			}
			return _product;
		}
	}

    public decimal Vat {
        get { return decimal.Parse(ConfigurationManager.AppSettings["VatRate"]); }
    }

	public string Name {
		get { return Prod.Name; }
	}

	public decimal UnitPrice {
		get { return Prod.Price; }
	}

	public decimal TotalPrice {
		get { return UnitPrice * Quantity; }
	}

    public decimal VATPrice {
        get { return TotalPrice * Vat; }
    }

    public decimal ShippingPrice {
        get { return Prod.Shipping; } //*Quantity; }
    }

    public int Category {
        get { return Prod.Category; }
    }

	#endregion

	// CartItem constructor just needs a productId
	public CartItem(int productId , int sizeId) {
		this.ProductId = productId;
        this.SizeId = sizeId;
	}

	/**
	 * Equals() - Needed to implement the IEquatable interface
	 *    Tests whether or not this item is equal to the parameter
	 *    This method is called by the Contains() method in the List class
	 *    We used this Contains() method in the ShoppingCart AddItem() method
	 */
	public bool Equals(CartItem item) {
		return item.ProductId == this.ProductId && item.SizeId == this.SizeId;

	}
}
