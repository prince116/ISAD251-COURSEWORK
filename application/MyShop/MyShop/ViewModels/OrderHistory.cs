using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyShop.ViewModels
{
    public class OrderHistory
    {
        public DateTime OrderDateTime { get; set; }
        public int OrderID { get; set; }
        public string InvoiceNo { get; set; }
        public string OrderStatus { get; set; }
        public decimal TotalAmount { get; set; }
    }
}