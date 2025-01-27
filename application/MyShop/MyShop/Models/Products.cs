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
    
    public partial class Products
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Products()
        {
            this.OrderItems = new HashSet<OrderItems>();
            this.Products1 = new HashSet<Products>();
        }
    
        public int ProductID { get; set; }
        public string ProductName { get; set; }
        public int CategoryID { get; set; }
        public string ProductDescription { get; set; }
        public decimal Price { get; set; }
        public decimal DiscountedPrice { get; set; }
        public System.DateTime SalesPeriodStartAt { get; set; }
        public System.DateTime SalesPeriodEndAt { get; set; }
        public int StockQuantity { get; set; }
        public System.DateTime CreatedAt { get; set; }
        public System.DateTime LastModifiedAt { get; set; }
        public string FilePath { get; set; }
        public Nullable<int> product_ProductID { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderItems> OrderItems { get; set; }
        public virtual ProductCategories ProductCategories { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Products> Products1 { get; set; }
        public virtual Products Products2 { get; set; }
    }
}
