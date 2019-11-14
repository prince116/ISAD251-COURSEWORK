using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;

namespace MyShop.Models
{
    public class OrderItem
    {
        [Key]
        public int ItemID { get; set; }
        [DisplayName("Order ID")]
        public int OrderID { get; set; }
        [DisplayName("Product ID")]
        public int ProductID { get; set; }
        [DisplayName("Unit Price")]
        public int UnitPrice { get; set; }
        [DisplayName("Quantity")]
        public int Quantiy { get; set; }

        public virtual Order Order { get; set; }
        public virtual Product Product { get; set; }
    }
}