USE [ISAD251_2019]
GO
/****** Object:  StoredProcedure [dbo].[SPGetProductStockStatus]    Script Date: 2019/12/12 上午 11:22:23 ******/
DROP PROCEDURE [dbo].[SPGetProductStockStatus]
GO
/****** Object:  StoredProcedure [dbo].[SPGetProducts]    Script Date: 2019/12/12 上午 11:22:23 ******/
DROP PROCEDURE [dbo].[SPGetProducts]
GO
/****** Object:  StoredProcedure [dbo].[SPGetOrderDetailsById]    Script Date: 2019/12/12 上午 11:22:23 ******/
DROP PROCEDURE [dbo].[SPGetOrderDetailsById]
GO
ALTER TABLE [dbo].[Products] DROP CONSTRAINT [FK_dbo.Products_dbo.ProductCategories_CategoryID]
GO
ALTER TABLE [dbo].[OrderItems] DROP CONSTRAINT [FK_dbo.OrderItems_dbo.Products_ProductID]
GO
ALTER TABLE [dbo].[OrderItems] DROP CONSTRAINT [FK_dbo.OrderItems_dbo.Orders_OrderID]
GO
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserLogins] DROP CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserClaims] DROP CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Products] DROP CONSTRAINT [DF__Products__IsPubl__2334397B]
GO
/****** Object:  Table [dbo].[ProductCategories]    Script Date: 2019/12/12 上午 11:22:23 ******/
DROP TABLE [dbo].[ProductCategories]
GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 2019/12/12 上午 11:22:23 ******/
DROP TABLE [dbo].[Contacts]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 2019/12/12 上午 11:22:23 ******/
DROP TABLE [dbo].[AspNetUsers]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 2019/12/12 上午 11:22:23 ******/
DROP TABLE [dbo].[AspNetUserRoles]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 2019/12/12 上午 11:22:23 ******/
DROP TABLE [dbo].[AspNetUserLogins]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 2019/12/12 上午 11:22:23 ******/
DROP TABLE [dbo].[AspNetUserClaims]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 2019/12/12 上午 11:22:23 ******/
DROP TABLE [dbo].[AspNetRoles]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 2019/12/12 上午 11:22:23 ******/
DROP TABLE [dbo].[__MigrationHistory]
GO
/****** Object:  View [dbo].[ViewSales]    Script Date: 2019/12/12 上午 11:22:23 ******/
DROP VIEW [dbo].[ViewSales]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 2019/12/12 上午 11:22:23 ******/
DROP TABLE [dbo].[Products]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2019/12/12 上午 11:22:23 ******/
DROP TABLE [dbo].[Orders]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 2019/12/12 上午 11:22:23 ******/
DROP TABLE [dbo].[OrderItems]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 2019/12/12 上午 11:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_dbo.OrderItems] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2019/12/12 上午 11:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [nvarchar](max) NULL,
	[OrderStatus] [nvarchar](max) NULL,
	[OrderDate] [datetime] NOT NULL,
	[DeliveryType] [nvarchar](max) NULL,
	[TableNo] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 2019/12/12 上午 11:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](max) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[ProductDescription] [nvarchar](max) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[DiscountedPrice] [decimal](18, 2) NOT NULL,
	[SalesPeriodStartAt] [date] NOT NULL,
	[SalesPeriodEndAt] [date] NOT NULL,
	[StockQuantity] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[LastModifiedAt] [datetime] NOT NULL,
	[FilePath] [nvarchar](max) NULL,
	[IsPublish] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewSales]    Script Date: 2019/12/12 上午 11:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewSales] AS
SELECT
    o.OrderID,
    o.OrderStatus,
    o.OrderDate,
    o.CustomerID,
	CASE o.DeliveryType
		WHEN 'dinn_in' THEN 'Dinn In'
		ELSE 'Take Away' END AS DeliveryType,
	CASE o.DeliveryType
		WHEN 'dinn_in' THEN o.TableNo
		ELSE 0 END AS TableNo,
    SUM(CASE p.DiscountedPrice
        WHEN 0 THEN p.Price * i.Quantity
        ELSE p.DiscountedPrice * i.Quantity END) AS TotalAmount
FROM
    dbo.OrderItems i
INNER JOIN
    dbo.Products p ON i.ProductID = p.ProductID
INNER JOIN
    dbo.Orders o ON i.OrderID = o.OrderID
GROUP BY
    o.OrderID,
    o.OrderStatus,
    o.OrderDate,
    o.CustomerID,
	o.DeliveryType,
	o.TableNo
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 2019/12/12 上午 11:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 2019/12/12 上午 11:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 2019/12/12 上午 11:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 2019/12/12 上午 11:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 2019/12/12 上午 11:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 2019/12/12 上午 11:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 2019/12/12 上午 11:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[Subject] [nvarchar](max) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[LastModifiedAt] [datetime] NOT NULL,
	[UserID] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Contacts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategories]    Script Date: 2019/12/12 上午 11:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.ProductCategories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201912110841327_InitialCreate', N'MyShop.Models.ApplicationDbContext', 0x1F8B0800000000000400ED5D5B6FDCB8157E2FD0FF20CC535B643DB1DD5DA481BD0BEF386E8DC68E9B7182BE05B4448FD5E832AB4B62A3D85FD687FEA4FE85921225F12A911275F122F08B8797EF1C1E9E7378D5E1FFFEF3DF939F1EC3C0F90293D48FA3D3D5E1C1CB95032337F6FC6877BACAB3FBEF5EAD7EFAF1F7BF3B79E3858FCEC7AADC312E876A46E9E9EA21CBF6AFD7EBD47D8021480F42DF4DE234BECF0EDC385C032F5E1FBD7CF997F5E1E11A228815C2729C93F77994F9212C7EA09F9B3872E13ECB4170157B3048493ACAD916A8CE350861BA072E3C5D5D3D6D1FE2FD415970E59C053E404C6C6170BF724014C519C8108BAF3FA4709B2571B4DBEE5102086E9FF61095BB07410A09EBAF9BE2BAAD7879845BB16E2A56506E9E6671680878784CC4B2E6ABF712EEAA161B12DC1B24E0EC09B7BA10DEE90AC938036EB672785AAF374182CB71A23D20155E3865F28BBAF79192E0BF17CE260FB23C81A711CCB304042F9C9BFC2EF0DDBFC3A7DBF8338C4EA33C0868A6105B288F4940493749BC8749F6F41EDE13562FCF57CE9AADB7E62BD6D5A83A652B2EA3ECF868E55C23E2E02E80759F532DDE667102FF0A2398800C7A3720CB6082BAECD28385D404EA1CAD0B3F4933FC6F4512691AB2979573051EDFC268973D205982C79573E13F42AF4A216C7C887C645EA85296E450C2663BE9B7602ECA6F42E007D393DDE677FF82586DA7267C05D314EC6610F42681582BCFEA369FA39FB77ED84F599031FBF7BE1538E45293C6CC0608842673B26E3C55ABFF7A9778887C06437D0F565799C38721B2BDFC18A937952F2B65D449B01D04FDF472371B0AF38F1C109E8D50AEC1177F570843D6B695F31E06456EFAE0EFCB9942A9199F6AFD40F3888B240EDFC741558BCAFB740B921DC4E6132B0A6CE33C710DF822E2927246F214BC89B90277922232FECCECCED0E666B0B75A8F4D0D4ED300EC59DCA690E408AE54D1B62D623B4FA7A185C796C1E3CC390C7CB42229947074B66F3163D7B1559743CC76A8DFA9CC56E9772AD3EF65D7B513D2B56C526106DBA6861753EBD61E99ECD9372139CF2C7D8358DEC5C993A511FD1CA66EE2EFCB25E9D46DB9497CB7F126D0F5438016203709FA8FEC56BC5A395B176040F3169EFBA91BE711EEE151E96C51BDF406267EEC214F9C641626E214E49BC8C6CC1E69BCFBB9E7ECEBB9AC5E2EFC00225B7E187D44B94C0BB7973E4C34A618CF18F971A565526938A325DEC787AD9C563EEA13F92DE35728A39AE78A0507CD763954E3D1B1AA38C32849BB7ED361527FD8B0380F26342D0D9486AA3A82862AEC4AADCABD34B4122FA6D1AA9EF556F159BABF86D94155F1A084BC4810DCD738F97C402322BDD5ADD7A8F691AE6A1F1FDEDD1FBFFAFE07E01DFFF06778FC7DAF8D15AFC7A68AD7A2608747AFC698BD74A8F5D1F73F58A1AAD473BC5B275772BABF3F91628D7A8BB982624B8A5851690C655FAD2BD4E5AB76B1C12AA8B7B4286E501F4BA8484C6D0D15BFE3D2D5D6B8B3FD1E755EA15A5822FAC33C57718E8DE567E2FFBACE8B741DA006954D1CDDFB4908EB56FE1C23750391F98A13A429B27FEF6F201D7F9DB0856E9E20B544ABC2703F3AB59B873882D7797887B57D3A5AD6BAE6F66B7C015C34E37C13E15A83F1DEA2156F9C6768FD8C57941F32575C606A025861E7CC75619A5E206586DE066F4B0C5B8563DF34F7046413005FB164E5BCE8A7AA68330B91971066228A62A6CBD7B7F1CE8FF458AD8AAA592D4B74B24A8A99B28AC1F4382525D58C16053AF92C4B599BDF153D647F8257C02E7F86376CF01E7F4D3ED7F4B0E8BE49CE7B0A4A1F4190DB26D5CB1A0A2760DF1A0AD8E55B43C1264AFEE21747CC1ACB9EAA3082D72A2F5F5175DB1CC7D9D4E6C034736AE2D3F8006D73F9E8C3AFC58187C6220D97250BB5BADAB7BB080BBA8B60E57EC094B71A6E91A083B3909E91DB3F895CF87D0795A99EA569ECFA851ED23D431F44B1ACA0C596D375D7A16C7D7D5702490019A98FA7A4880324E8156F7EEF22243F9841E7CC2D2F5E6F40EA024F14046A85A7CD4F7DDAC4F1535E406479FA93400AB90298600B04786F2245CEC58F32D16FF891EBEF41D02113AE9E89C7C1ADAEC9F039E7700F23EC273A6430907E4D86EB8D2E199DAC29FD6A573BC909A8AAA3DB8E439BAEAEEFC64CA27C6D97FAA6533FB5647414407945C74805D59218CCC3746A281E1E76747CCB49A2A092CDC1F494AAD9721ADF693476D553292B1D05519F90F7D152A55086B33281B24A0E01554AD07622D8743F7B2E3D8976B69C434A186B4E17475150B59474F4417AECA7AF926A49E810971F264EA4888ABD60559F776D0C37FD2E9CF14DA2931D3BD20ABD24BBA2A32866BBC42650CE7691E830A03C189F4341C90980AE02F0C7014B5350EE1C42A1A064A37212056525368382B22279760A5A1EFCE8F63F770AB434F5648F9FA61FD65BC535836E32F258986A96DB44C577E37E0413513DCFEF70267C947D7582F824DBB929D9C9E25504836F614660DDF2F3F474E534BB534435EA4FDDD7ED103175635A00A1D6DB3A304A88CEEAFBFA8EA900502FA9F420E8EBD72AAC6601D981498E8F051C769EDF01C21B691B6063C81DA0E4CAA20024382C03E6AA1B08ADDC91599A016C755BA015968CAD1DB05F9A7310018D3A23E150284B6DA0C4AFD0A862AA2FD578F7A1B1995B37A1B111C10B69ECC1F23084677E50619BAA2106D98713A220BA361775B717A9563416DF228E965DC1910522B9FDAE144BC76697D976972822DAA375CB4ABD4DA521FC1EF2925DA41625D5B5D3A2BBD742B581B8D21689B46C8D503812F73C5828AABB5DA2607456FE266B7FAA61A4335A04D4B14E5708A96A8C7529550345B79464CB4F9305E82029718B458594AAC6589712D1D16E21499640068BA0412262172C968CAD3A82ADE7D675DEC9BA0C9145124ED68A585A275760BFF7A31D155B8BA438DB32B0D6E6BBAD79D8A9B0C458BB8CB4F995404D298B13B0835C2E8E4DE5C122A8D239C8C01DC007D01B2F148A4957128A595345925B2C88FD584DA5AA0AF8FFB292341C9664CD456A5EA0A68578E156DCC9A03A5E59D3C1F1CD400012FEC6DF396A7F1CE461D4FCE635505D9B8A4E458350C9FA584DB8291AAA49D547229F03D03024491FA38E0545A3D489FA387568271AA74ED4C7A1BE75A691A8643349D35F3BF3F2A6F3F451AB904D345A9526A29CAC395516B60C047311367658F3D332CEB86D66AD6B9ECD72DDDC405BEA2A4D94846962CC541AF2A90DA5BE3641C328EF52A871A8936F1AA9E5405C8DD58401A0A19AD465A9CD6095E9AB2EFAAA62AB93E9BB7A8CBBA1D20D55AFBA442770566518E295D7FB04B432591F8BBD1047C3B139FA88F5AD371AAC4E5C8C4AEFD58B685DA5AEB60CCDD55A59730AAF734307CD91A0994E37E8FB158CB1B4DCBBE8E48E8986236192C937412FE2CFB080BE1850AE0D438866C3580D9F6930E59244AF61665F92FC5EE824908D029BE41A20B3116D185836EBB734DD6B62DCB033FF2A551F890A62C34C719AE4A5394D6AAB70B0F7AC0F497A7B5135C2341E8B0DAE22C35379D4997A51B563A3DB73CCB19479B7B557575A89C79987E49C555D5BEC9B85F589B86335BC7FEA53BEFE7DA486685D067B9265B0517F55D7E46814D5D5B9D9FA4C75C0A0DB4FFC21AA793775228C634D363698F868120218956730BF63A24A30D33C26C76076C3868E6066376C96019774800886493AA3179E42A2F212068B3A212404B3BA13720D666762700866822666F7C096F0CCE7E9A34AE247D0C0926CB34D4471AC6A5217E3FB2427757606ACF2E2C7B0114B81318E33B433E0515FE53333C826D9108B7C772F8091F4452A92F2BCB58F2295577D8629920243ED6F984FD95977D3FAFDBD1AF386FE3E9DDB08517F9FAFC63353D79994A2B980D55F173EAA303474A0A5EE33DC7AB6B4556C7B1B9BF9DE9B994ED019DFB6B2B94CFEA4BF2E52532729F5EFFA5E02B913D0FDF0977049A02C82BFC32F9D0E9AFC3EA5190C0F708183ED2FC126F021EEAEAAC01588FC7B9866657487D5D1CBC323EE01B1E53CE6B54E538F093EA17ED18BEDAE095ED8F2B1503B234F18C7E7E61ED58ABE80C47D00C91F42F0F8C7C10F650D436382190E83E21EB41A06C63D52350C4C08DDEEA19F99BDD0EDBDE1D887A7948DB4F2B8541F63B2F2D4D32846C505942968085F5E5C461E7C3C5DFDBBA8F3DAB9FC27B9737CFEC229FE79EDBC747E1DFE26942EF1BAE220F2FC6B0605753B118924E7FFD3C6051A4555C450400686A660990DD2331C8F0E1FD4DB9BC8C2ED0C628D0BA96351D3A447F2D3BF99338ABE3107FB56862FE10D035D8FD3D4B4E1F1246FE60C6B18F33E8D37D13B38D6E9A8DFC1F10AABB6F4064E3F30D9FB37DD76FC8CA650FCEB37831C9EF0C28D7D97273F3F9FE3219471065BC9DB2763CC6BD5C7DA53C4ABAD5A24468F1CF0964603DAE5D971A3F17F45F20BE732FD10F9BFE428E3160914FB773E1AB61D0DD678CDA266F4D767F14C84BEC8D1605A566507D281DDCF3E1E61C44D59750037BD9F9478BED626DDEC68B396FE0F35DCF9E663ACEC918641C399F42186418892C7166CE15911A1EA31853E58CA87146473159DC6CA1F56E8C39AF251853E533BFE49057D3754D59C711C921C3E4FE19246993B2D6B6C1222D70F3274313AFD98B3C2B608F4C3A628CF2CB2BBB5A1F3460CDC6E0D7B4EBDEF11ADFDDBFEE844FB99B6775A2521CFED6F3A2D760F766850F379439897F1AA780EC60E5A3E6D8872C547BE46141719947CC610E4F3288FF47843D199CAF38C1115A895E6330828BE9C00E2F3050A9F2130F86F3A00F852627E37BBAB127E260CF53D6574EF966FA774B77E2752AE6141BD1710865612F651A1671386EE9E5AD7549F3D181C492C3F40F7C2948DECC728946DC230DC532B9BEAD388852B9B51B0ED85E9DA5CE3E7CC9AA63D84CE1E3A5B8C8BC7772BB999CFDD086F09895D5E9A3F5D797778B3A4DC1ED9D4A1B4D7EDF8D48250A040E5C968D0417675A8A8C3692BD1BB91EB9587805DE7C8D0EB7597267EB3C652D1694AB4D05307BF55C69C2E8D56A0CA66CB48960FC4CAC352AA88355E4249B029A226AA8E87C913163CA6405728D14ED6ACAD64A6D7DA5852A69DAC228A6C1B6D32F0B7D22665DA692B62B3F2B43FEA451B97D15A40307226EEAA340ABF6AF78BAF277D006049A1C61996EBB4253476A230E23201A81E39E82BC0E5C50697461696BD9ED031F993A028DF6158722C70A6251D0F41742DF4153291BFFEB0E4D0DF5684C28C3C8A8FD1ED0B65AC48DF564462D3740C227B8B5FCAA205471EE143E3F2D7394CFD5D0371823023E8324B8DBACC65741F572B1E8EA3AA0877C47A0533E0A175C85992F9F768B980B2F1F5AAE299EAE2CA0ABEE47707BDCBE85D9EEDF30C3519867701E384F1CAA98D7E11BE9CE5F9E45DF129456AA309884D1F9FB3BF8B7ECEFDC0ABF9BE909C0F2B20F0928CDC2AC07D99E1DB05BBA71AE93A8E348188F8EA95E42D0CF701024BDF455BF005F6E10DA9DF5BB803EE5373BF4505D2DD11ACD84FCE7DB04B4098128CA63EFA8974D80B1F7FFC3FB4544EB54FAA0000, N'6.2.0-61023')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'942b1102-2c64-4336-b0b1-b58a22cc3307', N'Administrator')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'6b3a1335-20f6-406e-9988-8b7c6791078f', N'Contributor')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'f693da73-a6c2-4ed4-936b-a52470b3e13d', N'Reader')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'cf32769c-abc4-47af-a034-f50a417de7ab', N'942b1102-2c64-4336-b0b1-b58a22cc3307')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'15b4fdf8-27f2-43ed-a56e-98897acc1fab', N'prince@gmail.com', 0, N'AJIhUgRedofQLy6ZTw4yddGbvbJjQfbM+ufGLUPjj1EwmGv7PNAI/ft/OWUCxl4+Wg==', N'92beb386-0a2a-4de4-9362-77ca4fe4bab4', NULL, 0, 0, NULL, 1, 0, N'prince@gmail.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'cf32769c-abc4-47af-a034-f50a417de7ab', N'admin@myshop.com', 1, N'AANc5wz6wpLnHjjhvNXHYchR1d5FMWkiHtwyaez1VQrgRlvzRo+UPHCVhQFwLLOqpg==', N'333a6438-4458-4514-b810-10c9e81529f9', NULL, 0, 0, NULL, 0, 0, N'admin@myshop.com')
SET IDENTITY_INSERT [dbo].[OrderItems] ON 

INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [Quantity]) VALUES (1, 1, 20, 5)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [Quantity]) VALUES (2, 2, 20, 1)
SET IDENTITY_INSERT [dbo].[OrderItems] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderStatus], [OrderDate], [DeliveryType], [TableNo]) VALUES (1, N'15b4fdf8-27f2-43ed-a56e-98897acc1fab', N'checkout', CAST(N'2019-12-11T23:48:06.217' AS DateTime), N'dinn_in', 0)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderStatus], [OrderDate], [DeliveryType], [TableNo]) VALUES (2, N'15b4fdf8-27f2-43ed-a56e-98897acc1fab', N'checkout', CAST(N'2019-12-12T00:08:49.400' AS DateTime), N'dinn_in', 5)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[ProductCategories] ON 

INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName]) VALUES (1, N'Food')
INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName]) VALUES (2, N'Drink')
SET IDENTITY_INSERT [dbo].[ProductCategories] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (1, N'Butter Croissant', 1, N'Golden pastry with soft, flaky layers and a rich buttery flavour.', CAST(50.00 AS Decimal(18, 2)), CAST(40.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 40, CAST(N'2019-12-11T16:49:04.140' AS DateTime), CAST(N'2019-12-12T10:52:27.227' AS DateTime), N'file_20191212105227.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (2, N'Vegan roasted vegetable salad', 1, N'Vegan roasted vegetable salad'', 1, N''Roasted sweet potato and roasted spiced cauliflower, roasted red cabbage, mixed grains and spinach with a chipotle dressing.', CAST(50.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 30, CAST(N'2019-12-11T17:41:21.430' AS DateTime), CAST(N'2019-12-12T10:52:01.697' AS DateTime), N'file_20191212105201.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (3, N'Pain au Chocolat', 1, N'Golden pastry made from free range eggs and butter, with a rich dark chocolate filling.', CAST(60.00 AS Decimal(18, 2)), CAST(50.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 30, CAST(N'2019-12-11T17:43:54.430' AS DateTime), CAST(N'2019-12-11T17:43:54.430' AS DateTime), N'file_20191211054354.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (4, N'Cran-merry Cheesecake Muffin', 1, N'Vanilla sponge muffin with cranberries and white chocolate pieces filled with Mascarpone cheese.', CAST(77.00 AS Decimal(18, 2)), CAST(66.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 40, CAST(N'2019-12-11T17:45:19.860' AS DateTime), CAST(N'2019-12-12T10:51:24.357' AS DateTime), N'file_20191212105124.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (5, N'Triple Chocolate Muffin', 1, N'A chocolate flavoured batter with dark, milk and white chocolate filled with chocolate fudge.', CAST(77.00 AS Decimal(18, 2)), CAST(66.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 50, CAST(N'2019-12-11T17:46:18.280' AS DateTime), CAST(N'2019-12-12T10:50:09.313' AS DateTime), N'file_20191212105009.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (6, N'Cinnamon Swirl', 1, N'Sweet dough with cinnamon filling, sultanas and topped with a cream cheese style icing.', CAST(55.00 AS Decimal(18, 2)), CAST(44.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 30, CAST(N'2019-12-11T17:49:37.443' AS DateTime), CAST(N'2019-12-11T17:49:37.443' AS DateTime), N'file_20191211054937.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (7, N'Luxury Fruit Toast', 1, N'Add a dash of decadence to your breakfast. Swap your usual routine for a slice or two of luxury fruit bread. Made with cranberries, raisins and sultanas, it’s toasted to perfection and best enjoyed with butter and jam. A friendly warning: this could be habit-forming.', CAST(66.00 AS Decimal(18, 2)), CAST(60.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 40, CAST(N'2019-12-11T17:50:26.860' AS DateTime), CAST(N'2019-12-12T10:49:23.890' AS DateTime), N'file_20191212104923.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (8, N'Gingerbread cookies', 1, N'Gingerbread biscuit with a sugar icing jumper hand decorated.', CAST(60.00 AS Decimal(18, 2)), CAST(50.00 AS Decimal(18, 2)), CAST(N'1998-11-11' AS Date), CAST(N'2023-11-11' AS Date), 30, CAST(N'2019-12-11T17:51:10.733' AS DateTime), CAST(N'2019-12-11T17:51:10.733' AS DateTime), N'file_20191211055110.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (9, N'Christmas Tree Brownie', 1, N'Chocolate brownie with a layer of chocolate buttercream and finished with a sprinkling of gold dust', CAST(80.00 AS Decimal(18, 2)), CAST(70.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 60, CAST(N'2019-12-11T17:52:43.107' AS DateTime), CAST(N'2019-12-12T10:48:30.943' AS DateTime), N'file_20191212104830.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (10, N'Chocolate Caramel Shortbread', 1, N'A buttery shortbread base, topped with oozing caramel and a thick layer of milk chocolate drizzled with white chocolate.', CAST(77.00 AS Decimal(18, 2)), CAST(66.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 20, CAST(N'2019-12-11T17:53:36.693' AS DateTime), CAST(N'2019-12-11T17:53:36.693' AS DateTime), N'file_20191211055336.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (11, N'Salted Caramel Cupcake', 1, N'Butterscotch cupcake, caramel sauce filling, salted caramel buttercream topping', CAST(80.00 AS Decimal(18, 2)), CAST(70.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 60, CAST(N'2019-12-11T17:54:50.557' AS DateTime), CAST(N'2019-12-12T10:47:31.453' AS DateTime), N'file_20191212104731.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (12, N'Mini Valentine''s Cake', 1, N'A red sponge cake with cream cheese buttercream topped with chocolate drizzle and a chocolate heart decoration on top.', CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 60, CAST(N'2019-12-11T17:55:42.637' AS DateTime), CAST(N'2019-12-12T10:46:17.967' AS DateTime), N'file_20191212104617.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (13, N'Espresso', 2, N'A shot of espresso with a rich flavour and caramel-like sweetness.', CAST(66.00 AS Decimal(18, 2)), CAST(60.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 60, CAST(N'2019-12-11T17:56:45.473' AS DateTime), CAST(N'2019-12-12T10:45:10.767' AS DateTime), N'file_20191212104510.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (14, N'Caffè Latte', 2, N'Our dark, rich espresso is balanced with steamed milk and topped with a light layer of foam. A perfect milk-forward warm up.', CAST(50.00 AS Decimal(18, 2)), CAST(40.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 60, CAST(N'2019-12-11T17:57:53.923' AS DateTime), CAST(N'2019-12-11T17:58:01.037' AS DateTime), N'file_20191211055753.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (15, N'Cappuccino', 2, N'Dark, rich espresso combined with steamed milk, topped with a deep layer of foam.', CAST(60.00 AS Decimal(18, 2)), CAST(50.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 80, CAST(N'2019-12-11T17:58:53.203' AS DateTime), CAST(N'2019-12-11T17:58:53.203' AS DateTime), N'file_20191211055853.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (16, N'Flat White', 2, N'Expertly steamed milk poured over two shots of espresso and finished with delicate Rosetta art.', CAST(80.00 AS Decimal(18, 2)), CAST(75.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 60, CAST(N'2019-12-11T17:59:36.173' AS DateTime), CAST(N'2019-12-11T17:59:36.173' AS DateTime), N'file_20191211055936.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (17, N'Latte Macchiato', 2, N'We have taken a modern turn on a Classic Coffee house beverage. This espresso classic has espresso shots slowly poured over lightly aerated milk for a bold and roasty new way to sip. Deliciously good with any of our dairy alternative options.', CAST(50.00 AS Decimal(18, 2)), CAST(40.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 60, CAST(N'2019-12-11T18:01:23.357' AS DateTime), CAST(N'2019-12-12T10:31:39.470' AS DateTime), N'file_20191212103139.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (18, N'Caramel Macchiato', 2, N'A mix of vanilla flavour and steamed milk marked with espresso, topped with foam and caramel sauce.', CAST(60.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 44, CAST(N'2019-12-11T18:02:10.037' AS DateTime), CAST(N'2019-12-11T18:02:10.037' AS DateTime), N'file_20191211060210.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (19, N'Caffè Americano', 2, N'Espresso shots are topped with hot water to produce a light layer of crema in true European style.', CAST(50.00 AS Decimal(18, 2)), CAST(40.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 30, CAST(N'2019-12-11T18:03:25.303' AS DateTime), CAST(N'2019-12-11T18:03:25.303' AS DateTime), N'file_20191211060325.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (20, N'Caffè Mocha', 2, N'Espresso combined with mocha syrup and steamed milk, topped with whipped cream.', CAST(60.00 AS Decimal(18, 2)), CAST(55.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 60, CAST(N'2019-12-11T18:04:09.660' AS DateTime), CAST(N'2019-12-11T18:04:09.660' AS DateTime), N'file_20191211060409.jpg', 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [IsPublish]) VALUES (21, N'Caffè Misto', 2, N'A one-to-one mix of fresh brewed coffee and steamed milk add up to one distinctly delicious coffee drink.', CAST(33.00 AS Decimal(18, 2)), CAST(22.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2023-11-11' AS Date), 30, CAST(N'2019-12-11T18:05:00.333' AS DateTime), CAST(N'2019-12-11T18:05:00.333' AS DateTime), N'file_20191211060500.jpg', 1)
SET IDENTITY_INSERT [dbo].[Products] OFF
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [IsPublish]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_dbo.OrderItems_dbo.Orders_OrderID] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_dbo.OrderItems_dbo.Orders_OrderID]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_dbo.OrderItems_dbo.Products_ProductID] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_dbo.OrderItems_dbo.Products_ProductID]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Products_dbo.ProductCategories_CategoryID] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProductCategories] ([CategoryID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_dbo.Products_dbo.ProductCategories_CategoryID]
GO
/****** Object:  StoredProcedure [dbo].[SPGetOrderDetailsById]    Script Date: 2019/12/12 上午 11:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPGetOrderDetailsById](@OrderID AS INT)
AS
    SELECT
        i.ItemID,
        c.CategoryID,
        c.CategoryName,
        p.ProductID,
        p.ProductName,
        p.ProductDescription,
        CASE p.DiscountedPrice
            WHEN 0 THEN p.Price
            ELSE p.DiscountedPrice END AS Price,
        i.Quantity,
        CASE p.DiscountedPrice
            WHEN 0 THEN p.Price * i.Quantity
            ELSE p.DiscountedPrice * i.Quantity END AS SubTotal,
        p.FilePath
    FROM
        dbo.OrderItems i
    INNER JOIN
        dbo.Products p ON i.ProductID = p.ProductID
    INNER JOIN
        dbo.ProductCategories c ON p.CategoryID = c.CategoryID
    WHERE
        i.OrderID = @OrderID
    GROUP BY
        i.ItemID,
        i.OrderID,
        i.Quantity,
        c.CategoryID,
        c.CategoryName,
        p.ProductName,
        p.ProductID,
        p.ProductDescription,
        p.Price,
        p.DiscountedPrice,
        p.FilePath
GO
/****** Object:  StoredProcedure [dbo].[SPGetProducts]    Script Date: 2019/12/12 上午 11:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPGetProducts] (@IS_ADMIN AS BIT, @ADMIN_AS_USER AS BIT, @QUERY_BY_KEYWORD AS BIT, @QUERY_BY_CATEGORY AS BIT, @KEYWORDS AS NVARCHAR(255), @CATEGORY_ID AS INT, @IS_ADMIN_PANEL AS BIT)
AS

DECLARE @CUR_DATETIME DATETIME2
SET @CUR_DATETIME = CURRENT_TIMESTAMP

IF(@IS_ADMIN_PANEL = 1)

	BEGIN
		-- Query products by keywords without date time limitation
		SELECT
			p.ProductID,
			c.CategoryID,
			c.CategoryName,
			p.ProductName,
			p.ProductDescription,
			p.price,
			p.DiscountedPrice,
			p.StockQuantity,
			p.FilePath,
			p.LastModifiedAt,
			p.IsPublish
		FROM
			dbo.Products p
		INNER JOIN
			dbo.ProductCategories c ON p.CategoryID = c.CategoryID
		ORDER BY
			p.ProductID DESC
	END

ELSE

	IF(@QUERY_BY_KEYWORD = 1)
		IF(@IS_ADMIN = 1 AND @ADMIN_AS_USER = 0)
			BEGIN
				-- Query products by keywords without date time limitation
				SELECT
					p.ProductID,
					c.CategoryID,
					c.CategoryName,
					p.ProductName,
					p.ProductDescription,
					p.price,
					p.DiscountedPrice,
					p.StockQuantity,
					p.FilePath,
					p.LastModifiedAt
				FROM
					dbo.Products p
				INNER JOIN
					dbo.ProductCategories c ON p.CategoryID = c.CategoryID
				WHERE
					p.IsPublish = 1 AND
					(p.ProductName LIKE '%' + @KEYWORDS + '%' OR
					p.ProductDescription LIKE '%' + @KEYWORDS + '%')
				ORDER BY
					p.ProductID DESC
			END
		ELSE
			BEGIN
				-- Query products by keywords with date time limitation
				SELECT
					p.ProductID,
					c.CategoryID,
					c.CategoryName,
					p.ProductName,
					p.ProductDescription,
					p.price,
					p.DiscountedPrice,
					p.StockQuantity,
					p.FilePath,
					p.LastModifiedAt
				FROM
					dbo.Products p
				INNER JOIN
					dbo.ProductCategories c ON p.CategoryID = c.CategoryID
				WHERE
					p.IsPublish = 1 AND
					p.SalesPeriodStartAt <= @CUR_DATETIME AND
					p.SalesPeriodEndAt >= @CUR_DATETIME AND
					(p.ProductName LIKE '%' + @KEYWORDS + '%' OR
					p.ProductDescription LIKE '%' + @KEYWORDS + '%')
				ORDER BY
					p.ProductID DESC
			END
	ELSE IF(@QUERY_BY_CATEGORY = 1)
		IF(@IS_ADMIN = 1 AND @ADMIN_AS_USER = 0)
			BEGIN
				-- Query products by category without date time limitation
				SELECT
					p.ProductID,
					c.CategoryID,
					c.CategoryName,
					p.ProductName,
					p.ProductDescription,
					p.price,
					p.DiscountedPrice,
					p.StockQuantity,
					p.FilePath,
					p.LastModifiedAt
				FROM
					dbo.Products p
				INNER JOIN
					dbo.ProductCategories c ON p.CategoryID = c.CategoryID
				WHERE
					p.IsPublish = 1 AND
					p.CategoryID = @CATEGORY_ID
				ORDER BY
					p.ProductID DESC
			END
		ELSE
			BEGIN
				-- Query products by category with date time limitation
				SELECT
					p.ProductID,
					c.CategoryID,
					c.CategoryName,
					p.ProductName,
					p.ProductDescription,
					p.price,
					p.DiscountedPrice,
					p.StockQuantity,
					p.FilePath,
					p.LastModifiedAt
				FROM
					dbo.Products p
				INNER JOIN
					dbo.ProductCategories c ON p.CategoryID = c.CategoryID
				WHERE
					p.IsPublish = 1 AND
					p.SalesPeriodStartAt <= @CUR_DATETIME AND
					p.SalesPeriodEndAt >= @CUR_DATETIME AND
					p.CategoryID = @CATEGORY_ID
				ORDER BY
					p.ProductID DESC
			END
	ELSE
		IF(@IS_ADMIN = 1)
			BEGIN
				-- Query products by default without date time limitation
				SELECT
					p.ProductID,
					c.CategoryID,
					c.CategoryName,
					p.ProductName,
					p.ProductDescription,
					p.price,
					p.DiscountedPrice,
					p.StockQuantity,
					p.FilePath,
					p.LastModifiedAt
				FROM
					dbo.Products p
				INNER JOIN
					dbo.ProductCategories c ON p.CategoryID = c.CategoryID
				WHERE
					p.IsPublish = 1
				ORDER BY
					p.ProductID DESC
			END
		ELSE
			BEGIN
				-- Query products by default with date time limitation
				SELECT
					p.ProductID,
					c.CategoryID,
					c.CategoryName,
					p.ProductName,
					p.ProductDescription,
					p.price,
					p.DiscountedPrice,
					p.StockQuantity,
					p.FilePath,
					p.LastModifiedAt
				FROM
					dbo.Products p
				INNER JOIN
					dbo.ProductCategories c ON p.CategoryID = c.CategoryID
				WHERE
					p.IsPublish = 1 AND
					p.SalesPeriodStartAt <= @CUR_DATETIME AND
					p.SalesPeriodEndAt >= @CUR_DATETIME
				ORDER BY
					p.ProductID DESC
			END
GO
/****** Object:  StoredProcedure [dbo].[SPGetProductStockStatus]    Script Date: 2019/12/12 上午 11:22:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPGetProductStockStatus]
(
    @ProductID AS INT
) AS

SELECT
    p.StockQuantity as Stock,
    p.StockQuantity - SUM(i.Quantity) AS RemainStock
FROM
    dbo.OrderItems i
INNER JOIN
    dbo.Products p ON i.ProductID = @ProductID
WHERE
    p.ProductID = @ProductID
GROUP BY
    p.StockQuantity,
    i.Quantity
GO
