namespace MyShop.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddDeliveryType : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Orders", "DeliveryType", c => c.String());
            AddColumn("dbo.Orders", "TableNo", c => c.Int(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Orders", "TableNo");
            DropColumn("dbo.Orders", "DeliveryType");
        }
    }
}
