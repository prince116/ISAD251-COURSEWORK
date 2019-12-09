USE [ISAD251_2019]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 2019/12/9 上午 11:44:55 ******/
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
/****** Object:  Table [dbo].[Orders]    Script Date: 2019/12/9 上午 11:44:55 ******/
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
/****** Object:  Table [dbo].[OrderItems]    Script Date: 2019/12/9 上午 11:44:55 ******/
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
/****** Object:  View [dbo].[ViewSales]    Script Date: 2019/12/9 上午 11:44:55 ******/
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
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 2019/12/9 上午 11:44:55 ******/
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
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 2019/12/9 上午 11:44:55 ******/
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
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 2019/12/9 上午 11:44:55 ******/
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
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 2019/12/9 上午 11:44:55 ******/
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
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 2019/12/9 上午 11:44:55 ******/
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
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 2019/12/9 上午 11:44:55 ******/
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
/****** Object:  Table [dbo].[Contacts]    Script Date: 2019/12/9 上午 11:44:55 ******/
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
/****** Object:  Table [dbo].[ProductCategories]    Script Date: 2019/12/9 上午 11:44:55 ******/
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
/****** Object:  StoredProcedure [dbo].[SPGetOrderDetailsById]    Script Date: 2019/12/9 上午 11:44:55 ******/
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
/****** Object:  StoredProcedure [dbo].[SPGetProducts]    Script Date: 2019/12/9 上午 11:44:55 ******/
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
/****** Object:  StoredProcedure [dbo].[SPGetProductStockStatus]    Script Date: 2019/12/9 上午 11:44:55 ******/
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
