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
    
    public partial class GetOrderDetailsById_Result
    {
        public int ItemID { get; set; }
        public int OrderID { get; set; }
        public string CategoryName { get; set; }
        public int ProductID { get; set; }
        public string ProductName { get; set; }
        public string ProductDescription { get; set; }
        public string FilePath { get; set; }
        public decimal Price { get; set; }
        public int Quantity { get; set; }
        public Nullable<decimal> SubTotal { get; set; }
    }
}
