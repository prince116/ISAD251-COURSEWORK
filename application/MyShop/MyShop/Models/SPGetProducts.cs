using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MyShop.Models
{
    public class SPGetProducts
    {
        [Key]
        public int ProductID { get; set; }
        public string ProductName { get; set; }
        public string ProductDescription { get; set; }
        public int CategoryID { get; set; }
        public string CategoryName { get; set; }
        public decimal Price { get; set; }
        public decimal DiscountedPrice { get; set; }
        public int StockQuantity { get; set; }
        public string FilePath { get; set; }
        public DateTime LastModifiedAt { get; set; }
    }

    public class SPGetProductStockStatus
    {
        public int ProductID { get; set; }
        public int Stock { get; set; }
        public int RemainStock { get; set; }
    }

    public class QuerySetting
    {
        public Boolean is_admin { get; set; }
        public Boolean admin_as_user { get; set; }
        public Boolean query_by_keyword { get; set; }
        public Boolean query_by_category { get; set; }
        public string keywords { get; set; }
        public int category_id { get; set; }
        public Boolean is_admin_panel { get; set; }
    }
}