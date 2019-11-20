using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;

namespace MyShop.Models
{
    public class Product
    {
        [Key]
        public int ProductID { get; set; }
        [DisplayName("Product Name")]
        public string ProductName { get; set; }
        [DisplayName("Category")]
        public int CategoryID { get; set; }
        [DisplayName("Product Description")]
        public string ProductDescription { get; set; }
        [DisplayName("Price")]
        [DataType(DataType.Currency)]
        public decimal Price { get; set; }
        [DisplayName("Discounted Price")]
        [DataType(DataType.Currency)]
        public decimal DiscountedPrice { get; set; }
        [DisplayName("Sales Period Start At")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime SalesPeriodStartAt { get; set; }
        [DisplayName("Sales Period End At")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime SalesPeriodEndAt { get; set; }
        [DisplayName("Stock Quantity")]
        public int StockQuantity { get; set; }

        public virtual ICollection<OrderItem> OrderItems { get; set; }
        public virtual ProductCategory ProductCategories { get; set; }
    }
}