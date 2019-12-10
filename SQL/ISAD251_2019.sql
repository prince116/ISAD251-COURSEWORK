USE [ISAD251_2019]
GO
/****** Object:  StoredProcedure [dbo].[SPGetProductStockStatus]    Script Date: 2019/12/10 下午 04:29:08 ******/
DROP PROCEDURE [dbo].[SPGetProductStockStatus]
GO
/****** Object:  StoredProcedure [dbo].[SPGetProducts]    Script Date: 2019/12/10 下午 04:29:08 ******/
DROP PROCEDURE [dbo].[SPGetProducts]
GO
/****** Object:  StoredProcedure [dbo].[SPGetOrderDetailsById]    Script Date: 2019/12/10 下午 04:29:08 ******/
DROP PROCEDURE [dbo].[SPGetOrderDetailsById]
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
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [DF__Orders__TableNo__6FE99F9F]
GO
/****** Object:  Table [dbo].[ProductCategories]    Script Date: 2019/12/10 下午 04:29:08 ******/
DROP TABLE [dbo].[ProductCategories]
GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 2019/12/10 下午 04:29:08 ******/
DROP TABLE [dbo].[Contacts]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 2019/12/10 下午 04:29:08 ******/
DROP TABLE [dbo].[AspNetUsers]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 2019/12/10 下午 04:29:08 ******/
DROP TABLE [dbo].[AspNetUserRoles]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 2019/12/10 下午 04:29:08 ******/
DROP TABLE [dbo].[AspNetUserLogins]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 2019/12/10 下午 04:29:08 ******/
DROP TABLE [dbo].[AspNetUserClaims]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 2019/12/10 下午 04:29:08 ******/
DROP TABLE [dbo].[AspNetRoles]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 2019/12/10 下午 04:29:08 ******/
DROP TABLE [dbo].[__MigrationHistory]
GO
/****** Object:  View [dbo].[ViewSales]    Script Date: 2019/12/10 下午 04:29:08 ******/
DROP VIEW [dbo].[ViewSales]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 2019/12/10 下午 04:29:08 ******/
DROP TABLE [dbo].[OrderItems]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2019/12/10 下午 04:29:08 ******/
DROP TABLE [dbo].[Orders]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 2019/12/10 下午 04:29:08 ******/
DROP TABLE [dbo].[Products]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 2019/12/10 下午 04:29:08 ******/
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
	[product_ProductID] [int] NULL,
 CONSTRAINT [PK_dbo.Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2019/12/10 下午 04:29:08 ******/
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
/****** Object:  Table [dbo].[OrderItems]    Script Date: 2019/12/10 下午 04:29:08 ******/
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
/****** Object:  View [dbo].[ViewSales]    Script Date: 2019/12/10 下午 04:29:08 ******/
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
		ELSE 'N/A' END AS TableNo,
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
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 2019/12/10 下午 04:29:08 ******/
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
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 2019/12/10 下午 04:29:08 ******/
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
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 2019/12/10 下午 04:29:08 ******/
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
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 2019/12/10 下午 04:29:08 ******/
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
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 2019/12/10 下午 04:29:08 ******/
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
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 2019/12/10 下午 04:29:08 ******/
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
/****** Object:  Table [dbo].[Contacts]    Script Date: 2019/12/10 下午 04:29:08 ******/
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
/****** Object:  Table [dbo].[ProductCategories]    Script Date: 2019/12/10 下午 04:29:08 ******/
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
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'f07977f8-e819-4bc3-bf05-470178ee761c', N'Administrator')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'578ac2ed-3b99-4054-b2c0-c03bc3f4d1ab', N'Contributor')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'05613234-f784-4a3d-9788-d5a1c108fb9b', N'Reader')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'3de8fbfc-c03a-42d8-bbcb-4d9fb20b50e8', N'f07977f8-e819-4bc3-bf05-470178ee761c')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'3de8fbfc-c03a-42d8-bbcb-4d9fb20b50e8', N'admin@myshop.com', 1, N'AM7l0nYPuvqdxiH6e9DK+rgz4g0BWSz5pHgNopTj2S8vD+kZ+l4f+z2QxiWERF1VoA==', N'4997840e-b3af-4d9a-8630-dc60a615ec75', NULL, 0, 0, NULL, 0, 0, N'admin@myshop.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'4560feb6-1d69-4819-a4e1-a4ecc73c4ec7', N'prince@gmail.com', 0, N'AOc5caOBPTCW1GpHXl2u2GoN0GiUUTF78STMzHXc3fH/kFGWHhnrlGr9QkcPkwLuJw==', N'279a3732-d164-4cbb-833f-f01ab1cac5cb', NULL, 0, 0, NULL, 1, 0, N'prince@gmail.com')
SET IDENTITY_INSERT [dbo].[OrderItems] ON 

INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [Quantity]) VALUES (8, 1, 5, 4)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [Quantity]) VALUES (9, 2, 4, 3)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [Quantity]) VALUES (10, 3, 5, 6)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [Quantity]) VALUES (11, 4, 1, 1)
SET IDENTITY_INSERT [dbo].[OrderItems] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderStatus], [OrderDate], [DeliveryType], [TableNo]) VALUES (1, N'4560feb6-1d69-4819-a4e1-a4ecc73c4ec7', N'checkout', CAST(N'2019-12-05T20:18:57.167' AS DateTime), N'dinn_in', 3)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderStatus], [OrderDate], [DeliveryType], [TableNo]) VALUES (2, N'4560feb6-1d69-4819-a4e1-a4ecc73c4ec7', N'checkout', CAST(N'2019-12-06T23:19:34.463' AS DateTime), N'dinn_in', 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderStatus], [OrderDate], [DeliveryType], [TableNo]) VALUES (3, N'4560feb6-1d69-4819-a4e1-a4ecc73c4ec7', N'checkout', CAST(N'2019-12-09T11:08:49.960' AS DateTime), N'dinn_in', 0)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderStatus], [OrderDate], [DeliveryType], [TableNo]) VALUES (4, N'4560feb6-1d69-4819-a4e1-a4ecc73c4ec7', N'pending', CAST(N'2019-12-09T15:58:30.683' AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[ProductCategories] ON 

INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName]) VALUES (1, N'Cake')
INSERT [dbo].[ProductCategories] ([CategoryID], [CategoryName]) VALUES (2, N'Drink')
SET IDENTITY_INSERT [dbo].[ProductCategories] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [product_ProductID]) VALUES (1, N'Cream Brulee au Fromage', 1, N'Aromatic cream cheese paired with a caramelized sugar top, a combination of the classic Creme Brulee and baked cheesecake, it''s freshly baked daily, simply divine! ', CAST(100.00 AS Decimal(18, 2)), CAST(50.00 AS Decimal(18, 2)), CAST(N'2019-06-06' AS Date), CAST(N'2020-06-06' AS Date), 30, CAST(N'2019-12-06T23:14:24.403' AS DateTime), CAST(N'2019-12-06T23:14:24.403' AS DateTime), N'sample.png', NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [product_ProductID]) VALUES (2, N'Fruity Paradise', 1, N'Surrounded by sponge cake, with fresh cream and mixed fruit.', CAST(100.00 AS Decimal(18, 2)), CAST(50.00 AS Decimal(18, 2)), CAST(N'2019-06-06' AS Date), CAST(N'2020-06-06' AS Date), 40, CAST(N'2019-12-06T23:14:24.403' AS DateTime), CAST(N'2019-12-06T23:14:24.403' AS DateTime), N'sample.png', NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [product_ProductID]) VALUES (3, N'Mango Lovers', 1, N'Sponge cake with mango mousse, loads of fresh mango, specially introduce to any mango''s lovers.', CAST(100.00 AS Decimal(18, 2)), CAST(50.00 AS Decimal(18, 2)), CAST(N'2019-06-06' AS Date), CAST(N'2019-06-06' AS Date), 30, CAST(N'2019-12-06T23:14:24.403' AS DateTime), CAST(N'2019-12-06T23:14:24.403' AS DateTime), N'sample.png', NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [product_ProductID]) VALUES (4, N'Rocky Road', 1, N'Soft Chocolate sponge cake with chocolate cream, filled with marshmallow and almonds.', CAST(100.00 AS Decimal(18, 2)), CAST(50.00 AS Decimal(18, 2)), CAST(N'2019-06-06' AS Date), CAST(N'2020-06-06' AS Date), 30, CAST(N'2019-12-06T23:14:24.403' AS DateTime), CAST(N'2019-12-06T23:14:24.403' AS DateTime), N'sample.png', NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [product_ProductID]) VALUES (5, N'Souffle Cheese Cake', 1, N'Freshly baked souffle cake is spongy and soft, giving you the best enjoyment from taste to texture.', CAST(100.00 AS Decimal(18, 2)), CAST(50.00 AS Decimal(18, 2)), CAST(N'2019-06-06' AS Date), CAST(N'2020-06-06' AS Date), 30, CAST(N'2019-12-06T23:14:24.403' AS DateTime), CAST(N'2019-12-06T23:14:24.403' AS DateTime), N'sample.png', NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [product_ProductID]) VALUES (6, N'Nagano Kyoho Grape Drink', 2, N'AAA BBB', CAST(100.00 AS Decimal(18, 2)), CAST(50.00 AS Decimal(18, 2)), CAST(N'2019-06-06' AS Date), CAST(N'2020-06-06' AS Date), 30, CAST(N'2019-12-06T23:14:24.403' AS DateTime), CAST(N'2019-12-06T23:14:24.403' AS DateTime), N'sample.png', NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [product_ProductID]) VALUES (7, N'Mexico salsa', 2, N'Pour plenty of this sauce on taco shells with lettuce, sliced onions and roasted beef. It’s also delicious with sliced pickled jalapenos.', CAST(100.00 AS Decimal(18, 2)), CAST(50.00 AS Decimal(18, 2)), CAST(N'2017-06-06' AS Date), CAST(N'2017-06-15' AS Date), 30, CAST(N'2019-12-06T23:14:24.403' AS DateTime), CAST(N'2019-12-06T23:14:24.403' AS DateTime), N'sample.png', NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [product_ProductID]) VALUES (8, N'Kenya Coffee', 2, N'Kenyan coffees have a huge range of flavors and nuances depending on the region, varietal and processing methods used. It’s a huge country with a wide variety of cultures and customs and has a lot to offer to those who want to dive into separate regions. The best Kenyan coffees can have a full spectrum of flavors to those with a well developed palate.', CAST(130.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(N'2019-06-11' AS Date), CAST(N'2020-06-11' AS Date), 30, CAST(N'2019-12-10T15:38:10.100' AS DateTime), CAST(N'2019-12-10T15:43:16.183' AS DateTime), N'file_20191210034316.png', NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [product_ProductID]) VALUES (9, N'Columbia Coffee', 2, N'Colombian coffee is renowned the world over for its quality and delicious taste; in fact, along with a couple of other countries, Colombia’s coffee is generally seen as some of the best in the world.', CAST(122.00 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), CAST(N'2019-06-11' AS Date), CAST(N'2020-06-11' AS Date), 30, CAST(N'2019-12-10T15:38:20.073' AS DateTime), CAST(N'2019-12-10T15:38:20.073' AS DateTime), N'file_20191210033820.png', NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [product_ProductID]) VALUES (10, N'Indonesia Coffee', 2, N'The best farm-to-cup Indonesian coffees come from three regions: Sulawesi, Sumatra, and Java. Of the three regions, Java is the most productive and noted for Arabica coffee with bright acidity and a clean, fruity profile. Today, about 90% of Indonesian coffee is from the Robusta species, now commonly used for commercial-grade coffee.', CAST(130.00 AS Decimal(18, 2)), CAST(88.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2022-11-11' AS Date), 40, CAST(N'2019-12-10T15:57:47.653' AS DateTime), CAST(N'2019-12-10T15:59:45.790' AS DateTime), N'file_20191210035945.png', NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [product_ProductID]) VALUES (11, N'Ethiopia Coffee', 2, N'Ethiopian Coffee is among the worlds most unusual, offering a range of flavors from winey to fruity. Ethiopian Yirgacheffe is soft, with floral tones and is one of the best choices for iced coffee. Coffee from Ethiopia is a delight that shouldn''t be missed!', CAST(130.00 AS Decimal(18, 2)), CAST(88.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2022-11-11' AS Date), 40, CAST(N'2019-12-10T15:57:53.020' AS DateTime), CAST(N'2019-12-10T15:57:53.020' AS DateTime), N'file_20191210035753.png', NULL)
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [ProductDescription], [Price], [DiscountedPrice], [SalesPeriodStartAt], [SalesPeriodEndAt], [StockQuantity], [CreatedAt], [LastModifiedAt], [FilePath], [product_ProductID]) VALUES (12, N'Brazil Coffee', 2, N'The best Brazilian coffees have a relatively low acidity, and exhibits a nutty sweet flavor, often bittersweet with a chocolaty roast taste. Most unroasted Brazilian green coffee is dry processed (unwashed; natural).', CAST(150.00 AS Decimal(18, 2)), CAST(120.00 AS Decimal(18, 2)), CAST(N'2019-11-11' AS Date), CAST(N'2222-11-11' AS Date), 30, CAST(N'2019-12-10T16:04:44.377' AS DateTime), CAST(N'2019-12-10T16:04:44.377' AS DateTime), N'file_20191210040444.png', NULL)
SET IDENTITY_INSERT [dbo].[Products] OFF
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [TableNo]
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
/****** Object:  StoredProcedure [dbo].[SPGetOrderDetailsById]    Script Date: 2019/12/10 下午 04:29:08 ******/
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
/****** Object:  StoredProcedure [dbo].[SPGetProducts]    Script Date: 2019/12/10 下午 04:29:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPGetProducts] (@IS_ADMIN AS BIT, @ADMIN_AS_USER AS BIT, @QUERY_BY_KEYWORD AS BIT, @QUERY_BY_CATEGORY AS BIT, @KEYWORDS AS NVARCHAR(255), @CATEGORY_ID AS INT)
AS

DECLARE @CUR_DATETIME DATETIME2
SET @CUR_DATETIME = CURRENT_TIMESTAMP

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
                p.FilePath
            FROM
                dbo.Products p
            INNER JOIN
                dbo.ProductCategories c ON p.CategoryID = c.CategoryID
            WHERE
                p.ProductName LIKE '%' + @KEYWORDS + '%' OR
                p.ProductDescription LIKE '%' + @KEYWORDS + '%'
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
                p.FilePath
            FROM
                dbo.Products p
            INNER JOIN
                dbo.ProductCategories c ON p.CategoryID = c.CategoryID
            WHERE
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
                p.FilePath
            FROM
                dbo.Products p
            INNER JOIN
                dbo.ProductCategories c ON p.CategoryID = c.CategoryID
            WHERE
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
                p.FilePath
            FROM
                dbo.Products p
            INNER JOIN
                dbo.ProductCategories c ON p.CategoryID = c.CategoryID
            WHERE
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
                p.FilePath
            FROM
                dbo.Products p
            INNER JOIN
                dbo.ProductCategories c ON p.CategoryID = c.CategoryID
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
                p.FilePath
            FROM
                dbo.Products p
            INNER JOIN
                dbo.ProductCategories c ON p.CategoryID = c.CategoryID
            WHERE
                p.SalesPeriodStartAt <= @CUR_DATETIME AND
                p.SalesPeriodEndAt >= @CUR_DATETIME
            ORDER BY
                p.ProductID DESC
        END
GO
/****** Object:  StoredProcedure [dbo].[SPGetProductStockStatus]    Script Date: 2019/12/10 下午 04:29:08 ******/
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
