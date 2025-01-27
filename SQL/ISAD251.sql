USE [ISAD251]
GO
DROP PROCEDURE IF EXISTS [dbo].[SPGetProductStockStatus]
GO
DROP PROCEDURE IF EXISTS [dbo].[SPGetProducts]
GO
DROP PROCEDURE IF EXISTS [dbo].[SPGetOrderDetailsById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Products]') AND type in (N'U'))
ALTER TABLE [dbo].[Products] DROP CONSTRAINT IF EXISTS [FK_dbo.Products_dbo.ProductCategories_CategoryID]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderItems]') AND type in (N'U'))
ALTER TABLE [dbo].[OrderItems] DROP CONSTRAINT IF EXISTS [FK_dbo.OrderItems_dbo.Products_ProductID]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderItems]') AND type in (N'U'))
ALTER TABLE [dbo].[OrderItems] DROP CONSTRAINT IF EXISTS [FK_dbo.OrderItems_dbo.Orders_OrderID]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]') AND type in (N'U'))
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT IF EXISTS [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]') AND type in (N'U'))
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT IF EXISTS [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]') AND type in (N'U'))
ALTER TABLE [dbo].[AspNetUserLogins] DROP CONSTRAINT IF EXISTS [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]') AND type in (N'U'))
ALTER TABLE [dbo].[AspNetUserClaims] DROP CONSTRAINT IF EXISTS [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
DROP TABLE IF EXISTS [dbo].[_MigrationHistory]
GO
DROP TABLE IF EXISTS [dbo].[UserInfoes]
GO
DROP TABLE IF EXISTS [dbo].[ProductCategories]
GO
DROP TABLE IF EXISTS [dbo].[Contacts]
GO
DROP TABLE IF EXISTS [dbo].[AspNetUsers]
GO
DROP TABLE IF EXISTS [dbo].[AspNetUserRoles]
GO
DROP TABLE IF EXISTS [dbo].[AspNetUserLogins]
GO
DROP TABLE IF EXISTS [dbo].[AspNetUserClaims]
GO
DROP TABLE IF EXISTS [dbo].[AspNetRoles]
GO
DROP VIEW IF EXISTS [dbo].[ViewSales]
GO
DROP TABLE IF EXISTS [dbo].[Products]
GO
DROP TABLE IF EXISTS [dbo].[Orders]
GO
DROP TABLE IF EXISTS [dbo].[OrderItems]
GO
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInfoes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](max) NULL,
	[FirstName] [nvarchar](max) NULL,
	[LastName] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[JoinAt] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.UserInfoes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'6b3a1335-20f6-406e-9988-8b7c6791078f', N'Contributor')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'942b1102-2c64-4336-b0b1-b58a22cc3307', N'Administrator')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'f693da73-a6c2-4ed4-936b-a52470b3e13d', N'Reader')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'cf32769c-abc4-47af-a034-f50a417de7ab', N'942b1102-2c64-4336-b0b1-b58a22cc3307')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'15b4fdf8-27f2-43ed-a56e-98897acc1fab', N'prince@gmail.com', 0, N'AJIhUgRedofQLy6ZTw4yddGbvbJjQfbM+ufGLUPjj1EwmGv7PNAI/ft/OWUCxl4+Wg==', N'92beb386-0a2a-4de4-9362-77ca4fe4bab4', NULL, 0, 0, NULL, 1, 0, N'prince@gmail.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'1f5b89cb-271f-465d-9e26-023f853c94d4', N'jennifer@gmail.com', 0, N'AINtB7dkEIY2aicddAwW6me0RBUpp+1A/R6du/CUvH+hEcw8zfV2+hOcaw2zKTk1tw==', N'a2077ecf-0cd6-4b98-93b0-2b82cde79ca3', NULL, 0, 0, NULL, 1, 0, N'jennifer@gmail.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'cf32769c-abc4-47af-a034-f50a417de7ab', N'admin@myshop.com', 1, N'AANc5wz6wpLnHjjhvNXHYchR1d5FMWkiHtwyaez1VQrgRlvzRo+UPHCVhQFwLLOqpg==', N'333a6438-4458-4514-b810-10c9e81529f9', NULL, 0, 0, NULL, 0, 0, N'admin@myshop.com')
SET IDENTITY_INSERT [dbo].[Contacts] ON 

INSERT [dbo].[Contacts] ([ID], [FirstName], [LastName], [Email], [Subject], [Message], [CreatedAt], [LastModifiedAt], [UserID]) VALUES (1, N'Peter', N'Wong', N'peter@gmail.com', N'Hello World', N'This is the message', CAST(N'2020-01-05T13:21:39.373' AS DateTime), CAST(N'2020-01-05T13:21:39.373' AS DateTime), N'15b4fdf8-27f2-43ed-a56e-98897acc1fab')
INSERT [dbo].[Contacts] ([ID], [FirstName], [LastName], [Email], [Subject], [Message], [CreatedAt], [LastModifiedAt], [UserID]) VALUES (2, N'Yuet Yung', N'Mak', N'jenniferyy123@gmail.com', N'Feedback', N'Good', CAST(N'2020-02-07T13:53:30.567' AS DateTime), CAST(N'2020-02-07T13:53:30.567' AS DateTime), N'1f5b89cb-271f-465d-9e26-023f853c94d4')
SET IDENTITY_INSERT [dbo].[Contacts] OFF
SET IDENTITY_INSERT [dbo].[OrderItems] ON 

INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [Quantity]) VALUES (1, 1, 20, 5)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [Quantity]) VALUES (2, 2, 20, 1)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [Quantity]) VALUES (3, 3, 20, 3)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [Quantity]) VALUES (4, 4, 20, 2)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [Quantity]) VALUES (5, 4, 15, 1)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [Quantity]) VALUES (6, 5, 21, 3)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [Quantity]) VALUES (7, 6, 7, 4)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [Quantity]) VALUES (8, 7, 18, 1)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [Quantity]) VALUES (9, 7, 12, 1)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [Quantity]) VALUES (10, 7, 8, 2)
INSERT [dbo].[OrderItems] ([ItemID], [OrderID], [ProductID], [Quantity]) VALUES (13, 8, 11, 2)
SET IDENTITY_INSERT [dbo].[OrderItems] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderStatus], [OrderDate], [DeliveryType], [TableNo]) VALUES (1, N'15b4fdf8-27f2-43ed-a56e-98897acc1fab', N'checkout', CAST(N'2019-12-11T23:48:06.217' AS DateTime), N'dine_in', 1)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderStatus], [OrderDate], [DeliveryType], [TableNo]) VALUES (2, N'15b4fdf8-27f2-43ed-a56e-98897acc1fab', N'checkout', CAST(N'2019-12-12T00:08:49.400' AS DateTime), N'dine_in', 5)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderStatus], [OrderDate], [DeliveryType], [TableNo]) VALUES (3, N'15b4fdf8-27f2-43ed-a56e-98897acc1fab', N'checkout', CAST(N'2020-01-03T11:53:21.590' AS DateTime), N'dine_in', 4)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderStatus], [OrderDate], [DeliveryType], [TableNo]) VALUES (4, N'1f5b89cb-271f-465d-9e26-023f853c94d4', N'checkout', CAST(N'2020-01-09T13:05:46.493' AS DateTime), N'dine_in', 4)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderStatus], [OrderDate], [DeliveryType], [TableNo]) VALUES (5, N'15b4fdf8-27f2-43ed-a56e-98897acc1fab', N'checkout', CAST(N'2020-02-07T01:21:42.657' AS DateTime), N'take_away', 0)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderStatus], [OrderDate], [DeliveryType], [TableNo]) VALUES (6, N'15b4fdf8-27f2-43ed-a56e-98897acc1fab', N'checkout', CAST(N'2020-02-07T13:39:32.323' AS DateTime), N'take_away', 0)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderStatus], [OrderDate], [DeliveryType], [TableNo]) VALUES (7, N'1f5b89cb-271f-465d-9e26-023f853c94d4', N'checkout', CAST(N'2020-02-07T13:43:53.083' AS DateTime), N'dine_in', 1)
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderStatus], [OrderDate], [DeliveryType], [TableNo]) VALUES (8, N'15b4fdf8-27f2-43ed-a56e-98897acc1fab', N'checkout', CAST(N'2020-02-08T16:58:15.760' AS DateTime), N'take_away', 0)
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
SET IDENTITY_INSERT [dbo].[UserInfoes] ON 

INSERT [dbo].[UserInfoes] ([Id], [UserId], [FirstName], [LastName], [Email], [PhoneNumber], [JoinAt]) VALUES (1, N'1f5b89cb-271f-465d-9e26-023f853c94d4', N'Jennifer', N'Mak', N'jennifer@gmail.com', N'99956789', CAST(N'2020-01-09T13:05:18.977' AS DateTime))
INSERT [dbo].[UserInfoes] ([Id], [UserId], [FirstName], [LastName], [Email], [PhoneNumber], [JoinAt]) VALUES (4, N'15b4fdf8-27f2-43ed-a56e-98897acc1fab', N'Prince', N'Wong', N'prince@gmail.com', N'99991111', CAST(N'2020-01-09T13:05:18.977' AS DateTime))
SET IDENTITY_INSERT [dbo].[UserInfoes] OFF
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
