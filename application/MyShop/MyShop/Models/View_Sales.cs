//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MyShop.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class View_Sales
    {
        public int OrderID { get; set; }
        public string CustomerID { get; set; }
        public System.DateTime OrderDate { get; set; }
        public string OrderStatus { get; set; }
        public Nullable<decimal> TotalAmount { get; set; }
    }
}
