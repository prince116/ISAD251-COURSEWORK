namespace MyShop.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class InitialCreate1 : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Contacts",
                c => new
                    {
                        ID = c.Int(nullable: false, identity: true),
                        FirstName = c.String(nullable: false),
                        LastName = c.String(nullable: false),
                        Email = c.String(nullable: false),
                        Subject = c.String(nullable: false),
                        Message = c.String(nullable: false),
                        CreatedAt = c.DateTime(nullable: false),
                        LastModifiedAt = c.DateTime(nullable: false),
                        UserID = c.String(),
                    })
                .PrimaryKey(t => t.ID);
            
            CreateTable(
                "dbo.OrderItems",
                c => new
                    {
                        ItemID = c.Int(nullable: false, identity: true),
                        OrderID = c.Int(nullable: false),
                        ProductID = c.Int(nullable: false),
                        UnitPrice = c.Int(nullable: false),
                        Quantity = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.ItemID)
                .ForeignKey("dbo.Orders", t => t.OrderID, cascadeDelete: true)
                .ForeignKey("dbo.Products", t => t.ProductID, cascadeDelete: true)
                .Index(t => t.OrderID)
                .Index(t => t.ProductID);
            
            CreateTable(
                "dbo.Orders",
                c => new
                    {
                        OrderID = c.Int(nullable: false, identity: true),
                        CustomerID = c.String(),
                        OrderStatus = c.String(),
                        OrderDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.OrderID);
            
            CreateTable(
                "dbo.Products",
                c => new
                    {
                        ProductID = c.Int(nullable: false, identity: true),
                        ProductName = c.String(nullable: false),
                        CategoryID = c.Int(nullable: false),
                        ProductDescription = c.String(nullable: false),
                        Price = c.Decimal(nullable: false, precision: 18, scale: 2),
                        DiscountedPrice = c.Decimal(nullable: false, precision: 18, scale: 2),
                        SalesPeriodStartAt = c.DateTime(nullable: false, storeType: "date"),
                        SalesPeriodEndAt = c.DateTime(nullable: false, storeType: "date"),
                        StockQuantity = c.Int(nullable: false),
                        CreatedAt = c.DateTime(nullable: false),
                        LastModifiedAt = c.DateTime(nullable: false),
                        FilePath = c.String(),
                        product_ProductID = c.Int(),
                    })
                .PrimaryKey(t => t.ProductID)
                .ForeignKey("dbo.Products", t => t.product_ProductID)
                .ForeignKey("dbo.ProductCategories", t => t.CategoryID, cascadeDelete: true)
                .Index(t => t.CategoryID)
                .Index(t => t.product_ProductID);
            
            CreateTable(
                "dbo.ProductCategories",
                c => new
                    {
                        CategoryID = c.Int(nullable: false, identity: true),
                        CategoryName = c.String(),
                    })
                .PrimaryKey(t => t.CategoryID);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Products", "CategoryID", "dbo.ProductCategories");
            DropForeignKey("dbo.Products", "product_ProductID", "dbo.Products");
            DropForeignKey("dbo.OrderItems", "ProductID", "dbo.Products");
            DropForeignKey("dbo.OrderItems", "OrderID", "dbo.Orders");
            DropIndex("dbo.Products", new[] { "product_ProductID" });
            DropIndex("dbo.Products", new[] { "CategoryID" });
            DropIndex("dbo.OrderItems", new[] { "ProductID" });
            DropIndex("dbo.OrderItems", new[] { "OrderID" });
            DropTable("dbo.ProductCategories");
            DropTable("dbo.Products");
            DropTable("dbo.Orders");
            DropTable("dbo.OrderItems");
            DropTable("dbo.Contacts");
        }
    }
}
