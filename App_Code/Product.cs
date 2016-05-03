
/**
 * The Product class
 * 
 * This is just to simulate some way of accessing data about  our products
 */
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
public class Product
{

    public int Id { get; set; }
    public decimal Price { get; set; }
    public string Name { get; set; }
    public decimal Shipping { get; set; }
    public int Category { get; set; }
    public string Size { get; set; }
    public int Quantity { get; set; }
    public int SizeId { get; set; }

    public Product(int id, decimal price, string size, int quantity, int sizeId)
    {
        this.Id = id;
        this.Price = price;
        this.Size = size;
        this.Quantity = quantity;
        this.SizeId = sizeId;
        //this.Description = descritpion;
        //this.Shipping = shipping;

            // create a connection object
            using(var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                // open the connection
                conn.Open();
                
                // create a command object
                SqlCommand cmd = new SqlCommand("SELECT ProductName, ShippingCost FROM Products WHERE ProductID = '" + id + "'", conn);

                // 1. get an instance of the SqlDataReader
                using(var rdr = cmd.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        //this.Price = rdr.GetDecimal(0);
                        this.Name = rdr.GetString(0);
                        this.Shipping = rdr.GetDecimal(1);
                        //this.Category = rdr.GetInt32(2);
                    }
                }
                    
            }
                 
       }

}