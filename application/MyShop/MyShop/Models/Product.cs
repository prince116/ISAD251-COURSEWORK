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
        [Required(AllowEmptyStrings = false)]
        public string ProductName { get; set; }

        [DisplayName("Category")]
        [Required(AllowEmptyStrings = false)]
        public int CategoryID { get; set; }

        [DisplayName("Product Description")]
        [Required(AllowEmptyStrings = false)]
        public string ProductDescription { get; set; }

        [DisplayName("Price")]
        [Required(AllowEmptyStrings = false)]
        [Range(0, int.MaxValue)]
        [DataType(DataType.Currency)]
        public decimal Price { get; set; }

        [DisplayName("Discounted Price")]
        [Required(AllowEmptyStrings = false)]
        [Range(0, int.MaxValue)]
        [DataType(DataType.Currency)]
        public decimal DiscountedPrice { get; set; }

        [DisplayName("Sales Period Start At")]
        [Required(AllowEmptyStrings = false)]
        [DataType(DataType.Date)]
        [Column(TypeName = "Date")]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime SalesPeriodStartAt { get; set; }

        [DisplayName("Sales Period End At")]
        [Required(AllowEmptyStrings = false)]
        [DataType(DataType.Date)]
        [Column(TypeName = "Date")]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime SalesPeriodEndAt { get; set; }

        [DisplayName("Stock Quantity")]
        [Required(AllowEmptyStrings = false)]
        [Range(0, int.MaxValue)]
        public int StockQuantity { get; set; }

        [DisplayName("Created At")]
        public DateTime CreatedAt { get; set; }

        [DisplayName("Last Modified At")]
        public DateTime LastModifiedAt { get; set; }

        [DisplayName("Thumbnail")]
        public string FilePath { get; set; }

        public virtual ICollection<OrderItem> OrderItems { get; set; }
        public virtual ProductCategory ProductCategories { get; set; }

        public Product product { get; set; }
    }
}