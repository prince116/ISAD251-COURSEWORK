using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace MyShop.ViewModels
{
    public class ProductViewModels
    {
        public int ProductId { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "Empty")]
        public string ProductName { get; set; }
        public string ProductDescription { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "Required")]
        public decimal Price { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "Required")]
        public decimal DiscountedPrice { get; set; }

        ProductViewModels productViewModels { get; set; }
    }
}