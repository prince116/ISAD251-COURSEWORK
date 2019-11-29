using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using MyShop.Models;
using System.Data.Entity.Validation;

namespace MyShop.DAL
{
    public class ShopInitializer : System.Data.Entity.DropCreateDatabaseAlways<ShopContext>
//    public class ShopInitializer : System.Data.Entity.DropCreateDatabaseIfModelChanges<ShopContext>
    {
        protected override void Seed(ShopContext context)
        {
            var productcategories = new List<ProductCategory>
            {
                new ProductCategory{CategoryName="Cake"},
                new ProductCategory{CategoryName="Drink"}
            };

            productcategories.ForEach(s => context.productCategories.Add(s));
            context.SaveChanges();

            var products = new List<Product>
            {
                new Product{
                    ProductID = 1,
                    ProductName = "Cream Brulee au Fromage",
                    CategoryID = 1,
                    Price = 100,
                    DiscountedPrice = 50, 
                    ProductDescription = "Aromatic cream cheese paired with a caramelized sugar top, a combination of the classic Creme Brulee and baked cheesecake, it's freshly baked daily, simply divine! ", 
                    SalesPeriodStartAt = DateTime.Parse("2019-06-06"), SalesPeriodEndAt = DateTime.Parse("2020-06-06"), 
                    StockQuantity = 30, 
                    CreatedAt = DateTime.Now, 
                    LastModifiedAt = DateTime.Now,
                    FilePath = "sample.png"
                },
                new Product{
                    ProductID = 2,
                    ProductName = "Fruity Paradise", 
                    CategoryID = 1, 
                    Price = 100, 
                    DiscountedPrice = 50, 
                    ProductDescription = "Surrounded by sponge cake, with fresh cream and mixed fruit.", 
                    SalesPeriodStartAt = DateTime.Parse("2019-06-06"), 
                    SalesPeriodEndAt = DateTime.Parse("2020-06-06"), 
                    StockQuantity = 40, 
                    CreatedAt = DateTime.Now, 
                    LastModifiedAt = DateTime.Now,
                    FilePath = "sample.png"
                },
                new Product{
                    ProductID = 3,
                    ProductName = "Mango Lovers", 
                    CategoryID = 1, 
                    Price = 100, 
                    DiscountedPrice = 50, 
                    ProductDescription = "Sponge cake with mango mousse, loads of fresh mango, specially introduce to any mango's lovers.", 
                    SalesPeriodStartAt = DateTime.Parse("2019-06-06"), 
                    SalesPeriodEndAt = DateTime.Parse("2019-06-06"), 
                    StockQuantity = 30, 
                    CreatedAt = DateTime.Now, 
                    LastModifiedAt = DateTime.Now,
                    FilePath = "sample.png"
                },
                new Product{
                    ProductID = 4,
                    ProductName = "Rocky Road", 
                    CategoryID = 1, 
                    Price = 100, 
                    DiscountedPrice = 50, 
                    ProductDescription = "Soft Chocolate sponge cake with chocolate cream, filled with marshmallow and almonds.", 
                    SalesPeriodStartAt = DateTime.Parse("2019-06-06"), 
                    SalesPeriodEndAt = DateTime.Parse("2020-06-06"), 
                    StockQuantity = 30, 
                    CreatedAt = DateTime.Now, 
                    LastModifiedAt = DateTime.Now,
                    FilePath = "sample.png"
                },
                new Product{
                    ProductID = 5,
                    ProductName = "Souffle Cheese Cake", 
                    CategoryID = 1, 
                    Price = 100, 
                    DiscountedPrice = 50, 
                    ProductDescription = "Freshly baked souffle cake is spongy and soft, giving you the best enjoyment from taste to texture.", 
                    SalesPeriodStartAt = DateTime.Parse("2019-06-06"), 
                    SalesPeriodEndAt = DateTime.Parse("2020-06-06"), 
                    StockQuantity = 30, 
                    CreatedAt = DateTime.Now, 
                    LastModifiedAt = DateTime.Now,
                    FilePath = "sample.png"
                },
                new Product{
                    ProductID = 6,
                    ProductName = "Nagano Kyoho Grape Drink", 
                    CategoryID = 2, 
                    Price = 100, 
                    DiscountedPrice = 50, 
                    ProductDescription = "AAA BBB", 
                    SalesPeriodStartAt = DateTime.Parse("2019-06-06"), 
                    SalesPeriodEndAt = DateTime.Parse("2020-06-06"), 
                    StockQuantity = 30, 
                    CreatedAt = DateTime.Now, 
                    LastModifiedAt = DateTime.Now,
                    FilePath = "sample.png"
                },
                new Product{
                    ProductID = 7,
                    ProductName = "Mexico salsa", 
                    CategoryID = 2, 
                    Price = 100, 
                    DiscountedPrice = 50, 
                    ProductDescription = "Pour plenty of this sauce on taco shells with lettuce, sliced onions and roasted beef. It’s also delicious with sliced pickled jalapenos.", 
                    SalesPeriodStartAt = DateTime.Parse("2017-06-06"), 
                    SalesPeriodEndAt = DateTime.Parse("2017-06-15"), 
                    StockQuantity = 30, 
                    CreatedAt = DateTime.Now, 
                    LastModifiedAt = DateTime.Now,
                    FilePath = "sample.png"
                }
            };

            {
                products.ForEach(s => context.products.Add(s));
                context.SaveChanges();
            }
            
        }
    }
}