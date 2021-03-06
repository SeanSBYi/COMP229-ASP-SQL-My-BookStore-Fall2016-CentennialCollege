USE [master]
GO
/****** Object:  Database [BalloonShop]    Script Date: 12/18/2015 2:19:22 PM ******/
CREATE DATABASE [BalloonShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BalloonShop', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\BalloonShop.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BalloonShop_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\BalloonShop_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BalloonShop] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BalloonShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BalloonShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BalloonShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BalloonShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BalloonShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BalloonShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [BalloonShop] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [BalloonShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BalloonShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BalloonShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BalloonShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BalloonShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BalloonShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BalloonShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BalloonShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BalloonShop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BalloonShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BalloonShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BalloonShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BalloonShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BalloonShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BalloonShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BalloonShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BalloonShop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BalloonShop] SET  MULTI_USER 
GO
ALTER DATABASE [BalloonShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BalloonShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BalloonShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BalloonShop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [BalloonShop] SET DELAYED_DURABILITY = DISABLED 
GO
USE [BalloonShop]
GO
/****** Object:  User [balloonshop]    Script Date: 12/18/2015 2:19:22 PM ******/
CREATE USER [balloonshop] FOR LOGIN [balloonshop] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [balloonshop]
GO
/****** Object:  UserDefinedFunction [dbo].[WordCount]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[WordCount]
(@Word VARCHAR(15), 
@Phrase VARCHAR(1000))
RETURNS SMALLINT
AS
BEGIN

/* If @Word or @Phrase is NULL the function returns 0 */
IF @Word IS NULL OR @Phrase IS NULL RETURN 0

/* @BiggerWord is a string one character longer than @Word */
DECLARE @BiggerWord VARCHAR(21)
SELECT @BiggerWord = @Word + 'x'

/* Replace @Word with @BiggerWord in @Phrase */
DECLARE @BiggerPhrase VARCHAR(2000)
SELECT @BiggerPhrase = REPLACE (@Phrase, @Word, @BiggerWord)

/* The length difference between @BiggerPhrase and @phrase
   is the number we''re looking for */
RETURN LEN(@BiggerPhrase) - LEN(@Phrase)
END


GO
/****** Object:  Table [dbo].[Account]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Account](
	[Id] [uniqueidentifier] NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[Address1] [varchar](255) NULL,
	[Address2] [varchar](255) NULL,
	[City] [varchar](255) NULL,
	[Country] [varchar](255) NULL,
	[PostalCode] [varchar](255) NULL,
	[Region] [varchar](255) NULL,
	[DaytimePhone] [varchar](255) NULL,
	[EveningPhone] [varchar](255) NULL,
	[MobilePhone] [varchar](255) NULL,
	[CreditCard] [varchar](255) NULL,
	[ShippingRegion] [int] NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AuditLogs]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AuditLogs](
	[LogID] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[ACTION] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AuditLogs] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Category]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](1000) NULL,
 CONSTRAINT [PK_Category_1] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Department]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](1000) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductName] [varchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitCost] [money] NOT NULL,
	[Subtotal]  AS ([Quantity]*[UnitCost]),
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[DateCreated] [smalldatetime] NOT NULL,
	[DateShipped] [smalldatetime] NULL,
	[Verified] [bit] NOT NULL,
	[Completed] [bit] NOT NULL,
	[Canceled] [bit] NOT NULL,
	[Comments] [varchar](1000) NULL,
	[CustomerName] [varchar](50) NULL,
	[CustomerEmail] [varchar](50) NULL,
	[ShippingAddress] [varchar](500) NULL,
	[TaxID] [int] NULL,
	[ShippingID] [int] NULL,
	[CustomerID] [uniqueidentifier] NULL,
	[Status] [int] NULL,
	[AuthCode] [varchar](50) NULL,
	[Reference] [varchar](50) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](5000) NOT NULL,
	[Price] [money] NOT NULL,
	[Image1FileName] [varchar](50) NULL,
	[Image2FileName] [varchar](50) NULL,
	[OnCatalogPromotion] [bit] NOT NULL,
	[OnDepartmentPromotion] [bit] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product2]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product2](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](5000) NOT NULL,
	[Price] [money] NOT NULL,
	[Image1FileName] [varchar](50) NULL,
	[Image2FileName] [varchar](50) NULL,
	[OnCatalogPromotion] [bit] NOT NULL,
	[OnDepartmentPromotion] [bit] NOT NULL,
 CONSTRAINT [PK_Product1] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[ProductID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_ProductCategory] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Shipping]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Shipping](
	[ShippingID] [int] NOT NULL,
	[ShippingType] [varchar](100) NOT NULL,
	[ShippingCost] [money] NOT NULL,
	[ShippingRegionID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ShippingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ShippingRegion]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShippingRegion](
	[ShippingRegionID] [int] IDENTITY(1,1) NOT NULL,
	[ShippingRegion] [nvarchar](100) NULL,
 CONSTRAINT [PK_ShippingRegion_1] PRIMARY KEY CLUSTERED 
(
	[ShippingRegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShoppingCart]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShoppingCart](
	[CartID] [char](36) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[DateAdded] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_ShoppingCart] PRIMARY KEY CLUSTERED 
(
	[CartID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tax]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tax](
	[TaxID] [int] NOT NULL,
	[TaxType] [varchar](100) NOT NULL,
	[TaxPercentage] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TaxID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[trigtest]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[trigtest](
	[i] [int] NOT NULL,
	[j] [int] NOT NULL,
	[s] [varchar](10) NULL,
	[t] [varchar](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WishList]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WishList](
	[WishListId] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[DateAdded] [smalldatetime] NULL,
 CONSTRAINT [PK_WishList] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[WishListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (1, 1, N'Love & Romance', N'This collection of books is written for the lover at heart')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (2, 1, N'Comedy', N'These will make you laugh your pants off')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (3, 1, N'Sci-Fi', N'Space, aliens, futuristic planets all packed into these books!')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (4, 2, N'Young Readers 9-12', N'These books are a fun way to pass the time children ages 9-12')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (5, 2, N'Graphic Novels', N'The latest and greatest in graphic novels')
INSERT [dbo].[Category] ([CategoryID], [DepartmentID], [Name], [Description]) VALUES (6, 2, N'Teen', N'The latest books your teen will love!')
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([DepartmentID], [Name], [Description]) VALUES (1, N'Adult Books', N'Books for all adults ')
INSERT [dbo].[Department] ([DepartmentID], [Name], [Description]) VALUES (2, N'Childrens Books', N'Books written specifically for children to enjoy and learn!')
SET IDENTITY_INSERT [dbo].[Department] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (1, N'Grey: Fifty Shades Of Grey As Told By Christian', N'In Christian''s own words, and through his thoughts, reflections, and dreams, E L James offers a fresh perspective on the love story that has enthralled millions of readers around the world', 12.9900, N'Grey.jpg', N'Grey.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (2, N'Captivated By You', N'The vows we''d exchanged should have bound us tighter than blood and flesh. Instead they opened old wounds, exposed pain and insecurities, and lured bitter enemies out of the shadows. I felt him slipping from my grasp, my greatest fears becoming my reality, my love tested in ways I wasn’t sure I was strong enough to bear.', 20.9900, N'Captivated.jpg', N'Captivated.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (3, N'The Shadows', N'Two brothers bound by more than blood fight to change a brutal destiny in the heart-wrenching new novel of the Black Dagger Brotherhood.', 11.9900, N'Shadows.jpg', N'Shadows.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (4, N'Stars Of Fortune', N'From the #1 New York Times bestselling author Nora Roberts comes a trilogy about three couples who join together to create their own family and solve an ancient mystery through the powers of timeless love', 14.9900, N'Stars.jpg', N'Stars.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (5, N'Entwined with You', N'The worldwide phenomenon continues as Eva and Gideon face the demons of their pasts and accept the consequences of their obsessive desires…', 12.9900, N'Entwined.jpg', N'Entwined.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (6, N'Reflected In You', N'The hotly anticipated second book of the Crossfire Trilogy continues the sensual saga of Eva and Gideon that began in Bared to You…the New York Times bestselling novel of “EROTIC ROMANCE THAT SHOULD NOT BE MISSED”', 9.9900, N'Reflected.jpg', N'Reflected.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (7, N'Nuts', N'The New York Times bestselling author of Wallbanger and Rusty Nailed is back with Nuts, the first in a brand new series set in New York’s beautiful Hudson Valley.', 22.9900, N'nuts.jpg', N'nuts.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (8, N'Born of Betrayal', N'Years ago, family loyalty caused Fain Hauk to give up everything he loved: His military career. His planet. His fiancée. Even his name.
Now decades later, everything has changed. He''s built a new life out of the ashes of his old, and he''s vowed to never let anything threaten his loved ones again.', 13.7500, N'born.jpg', N'born.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (9, N'After Ever Happy', N'Book Four of the After series—now newly revised and expanded, Anna Todd’s After fanfiction racked up 1 billion reads online and captivated readers across the globe. Experience the Internet’s most talked-about book for yourself!', 24.2300, N'after.jpg', N'after.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (10, N'Dragonbane', N'Out of all the mysterious boarders who call Sanctuary home, no one is more antisocial or withdrawn than Maxis Drago. But then, it''s hard to blend in with the modern world when you have a fifty foot wingspan.
Centuries ago, he was cursed by an enemy who swore to see him fall. An enemy who took everything from him and left him forever secluded.', 33.9900, N'dragon.jpg', N'dragon.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (11, N'Why Not Me?', N'From the author of the beloved New York Times bestselling book Is Everyone Hanging Out Without Me? and the creator and star of The Mindy Project comes a collection of essays that are as hilarious and insightful as they are deeply personal.', 17.9900, N'why.jpg', N'why.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (12, N'Furiously Happy', N'In Furiously Happy, #1 New York Times bestselling author Jenny Lawson explores her lifelong battle with mental illness. A hysterical, ridiculous book about crippling depression and anxiety? That sounds like a terrible idea.
But terrible ideas are what Jenny does best.', 29.9900, N'furiously.jpg', N'furiously.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (13, N'Binge', N'Pop-culture phenomenon, social rights advocate, and the most prominent LGBTQ+ voice on YouTube, Tyler Oakley brings you his first collection of witty, personal, and hilarious essays.', 24.9900, N'binge.jpg', N'binge.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (14, N'Yes Please', N'In a perfect world . . .
We’d get to hang out with Amy Poehler, watching dumb movies, listening to music, and swapping tales about our coworkers and difficult childhoods. Unfortunately, between her Golden Globe?winning role on Parks and Recreation, work as a producer and director, place as one of the most beloved SNL alumni and cofounder of the Upright Citizens Brigade, involvement with the website Smart Girls at the Party, frequent turns as acting double for Meryl Streep,.', 11.9900, N'yes.jpg', N'yes.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (15, N'The Bassoon King', N'For nine seasons Rainn Wilson played Dwight Schrute, everyone''s favorite work nemesis and beet farmer. Viewers of The Office fell in love with the character and grew to love the actor who played him even more. Rainn founded a website and media company, SoulPancake, that eventually became a bestselling book of the same name. He also started a hilarious Twitter feed (sample tweet: “I''m not on Facebook” is the new “I don''t even own a TV”) that now has more than four million followers.', 34.9900, N'bassoon.jpg', N'bassoon.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (16, N'So Anyway...', N'John Cleese''s huge comedic influence has stretched across generations; his sharp irreverent eye and the unique brand of physical comedy he perfected with Monty Python, on Fawlty Towers, and beyond now seem written into comedy''s DNA.', 15.9900, N'so.jpg', N'so.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (17, N'Sick In The Head', N'NEW YORK TIMES BESTSELLER • From the writer and director of Knocked Up and the producer of Freaks and Geeks comes a collection of intimate, hilarious conversations with the biggest names in comedy from the past thirty years—including Mel Brooks, Jerry Seinfeld, Jon Stewart, Roseanne Barr, Harold Ramis, Louis C.K., Chris Rock, and Lena Dunham.', 22.9900, N'sick.jpg', N'sick.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (18, N'Dad Is Fat', N'In Dad is Fat, stand-up comedian Jim Gaffigan, who’s best known for his legendary riffs on Hot Pockets, bacon, manatees, and McDonald''s, expresses all the joys and horrors of life with five young children—everything from cousins ("celebrities for little kids") to toddlers’ communication skills (“they always sound like they have traveled by horseback for hours to deliver important news”), to the eating habits of four year olds (“there is no difference between a four year old eating a taco and throwing a taco on the floor”).', 18.9900, N'dad.jpg', N'dad.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (19, N'Uganda Be Kidding Me', N'Wherever Chelsea Handler travels, one thing is certain: she always ends up in the land of the ridiculous. Now, in this uproarious collection, she sneaks her sharp wit through airport security and delivers her most absurd and hilarious stories ever.', 10.9900, N'uganda.jpg', N'uganda.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (20, N'F In Exams', N'The ultimate compendium of the international and New York Times bestselling series, this fun omnibus features the complete content from all four books- F in Exams , F for Effort , F this Test , and F in Exams: Pop Quiz -plus more than 100 brand-new, sadly real, hilariously wrong student answers (Q: What is the role of a catalyst in a chemical reaction? A: It lists the cats involved).', 29.9900, N'exams.jpg', N'exams.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (21, N'How to Tell If Your Cat Is Plotting to Kill You', N'TheOatmeal.com’s most popular cat jokes, including “How to Pet a Kitty” and “The Bobcats,” plus 15 new and never-before-seen catthemed comics, are presented in this hilarious collection from New York Times best-selling author Matthew Inman, a.k.a. TheOatmeal.com. Includes pull-out poster!', 32.9900, N'cat.jpg', N'cat.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (22, N'The Martian: A Novel', N'After a dust storm nearly kills him and forces his crew to evacuate while thinking him dead, Mark finds himself stranded and completely alone with no way to even signal Earth that he’s alive—and even if he could get word out, his supplies would be gone long before a rescue could arrive. ', 19.9900, N'martian.jpg', N'martian.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (23, N'A Knight Of The Seven Kingdoms', N'Taking place nearly a century before the events of A Game of Thrones, A Knight of the Seven Kingdoms compiles the first three official prequel novellas to George R. R. Martin’s ongoing masterwork, A Song of Ice and Fire. These never-before-collected adventures recount an age when the Targaryen line still holds the Iron Throne, and the memory of the last dragon has not yet passed from living consciousness.', 8.9900, N'knight.jpg', N'knight.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (24, N'The Bazaar of Bad Dreams: Stories', N'A master storyteller at his best—the O. Henry Prize winner Stephen King delivers a generous collection of stories, several of them brand-new, featuring revelatory autobiographical comments on when, why, and how he came to write (or rewrite) each story.', 16.9900, N'bazaar.jpg', N'bazaar.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (25, N'Aftermath: Star Wars: Journey  ', N'As the Empire reels from its critical defeats at the Battle of Endor, the Rebel Alliance—now a fledgling New Republic—presses its advantage by hunting down the enemy’s scattered forces before they can regroup and retaliate. But above the remote planet Akiva, an ominous show of the enemy’s strength is unfolding. ', 12.9900, N'starwars.jpg', N'starwars.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (26, N'Welcome to Night Vale: A Novel', N'From the creators of the wildly popular Welcome to Night Vale podcast comes an imaginative mystery of appearances and disappearances that is also a poignant look at the ways in which we all struggle to find ourselves...no matter where we live.', 29.9900, N'welcome.jpg', N'welcome.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (27, N'Golden Son', N'With shades of The Hunger Games, Ender’s Game, and Game of Thrones, debut author Pierce Brown’s genre-defying epic Red Rising hit the ground running and wasted no time becoming a sensation. Golden Son continues the stunning saga of Darrow, a rebel forged by tragedy, battling to lead his oppressed people to freedom.', 6.9900, N'golden.jpg', N'golden.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (28, N'The Story of Kullervo', N'The world first publication of a previously unknown work of fantasy by J.R.R. Tolkien, which tells the powerful story of a doomed young man who is sold into slavery and who swears revenge on the magician who killed his father.Kullervo son of Kalervo is perhaps the darkest and most tragic of all J.R.R. Tolkien''s characters. ''Hapless Kullervo'', as Tolkien called him, is a luckless orphan boy with supernatural powers and a tragic destiny.', 23.9900, N'kullervo.jpg', N'kullervo.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (29, N'Seveneves: A Novel', N'From the #1 New York Times bestselling author of Anathem, Reamde, and Cryptonomicon comes an exciting and thought-provoking science fiction epic—a grand story of annihilation and survival spanning five thousand years
What would happen if the world were ending?
A catastrophic event renders the earth a ticking time bomb. In a feverish race against the inevitable, nations around the globe band together to devise an ambitious plan to ensure the survival of humanity far beyond our atmosphere, in outer space.', 37.9900, N'seveneves.jpg', N'seveneves.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (30, N'Sword Of Destiny', N'Geralt is a witcher, a man whose magic powers, enhanced by long training and a mysterious elixir, have made him a brilliant fighter and a merciless assassin. Yet he is no ordinary murderer: his targets are the multifarious monsters and vile fiends that ravage the land and attack the innocent.', 18.9900, N'sword.jpg', N'sword.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (31, N'
Warheart', N'All is lost. Evil will soon consume the D''Haran Empire. Richard Rahl lies on his funeral bier. It is the end of everything.
Except what isn''t lost is Kahlan Amnell. Following an inner prompting beyond all reason, the last Confessor will wager everything on a final desperate gambit, and in so doing, she will change the world forever.', 19.9900, N'warheart.jpg', N'warheart.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (32, N'Leviathan Wakes', N'Two hundred years after migrating into space, mankind is in turmoil. When a reluctant ship''s captain and washed-up detective find themselves involved in the case of a missing girl, what they discover brings our solar system to the brink of civil war, and exposes the greatest conspiracy in human history.', 17.8900, N'wake.jpg', N'wake.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (33, N'Trigger Warning: Short Fictions and Disturbances', N'In this wide-ranging collection of short fiction, Neil Gaiman pierces the veil of reality to reveal the enigmatic, shadowy world that lies beneath. This rich compendium includes previously published stories, poetry, and a very special Dr. Who tale that was written for the fiftieth anniversary of the beloved series, as well as the never-before-published American Gods novella "Black Dog," in which Shadow Moon stops at a village pub on his way back to America. Horror and ghost stories, speculative fiction and fairy tales, fabulism and verse—all combine to illustrate the strength and breadth of Gaiman''s storytelling mastery and cement his reputation as one of the finest writers at work today.', 39.9900, N'trigger.jpg', N'trigger.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (34, N'Diary Of A Wimpy Kid #10: Old School', N'Life was better in the old days. Or was it? 
That’s the question Greg Heffley is asking as his town voluntarily unplugs and goes electronics-free. But modern life has its conveniences, and Greg isn’t cut out for an old-fashioned world.', 9.9900, N'diary.jpg', N'diary.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (35, N'Harry Potter And The Philosopher''s Stone', N'Prepare to be spellbound by Jim Kay''s dazzling depiction of the wizarding world and much loved characters in this full-colour illustrated hardback edition of the nation''s favourite children''s book -- Harry Potter and the Philosopher''s Stone. Brimming with rich detail and humour that perfectly complements J.K. Rowling''s timeless classic, Jim Kay''s glorious illustrations will captivate fans and new readers alike.', 31.9900, N'harry.jpg', N'harry.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (36, N'Magnus Chase And The Gods Of Asgard', N'Magnus Chase has seen his share of trouble. Ever since that terrible night two years ago when his mother told him to run, he has lived alone on the streets of Boston, surviving by his wits, staying one step ahead of the police and truant officers.', 16.9900, N'magnus.jpg', N'magnus.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (37, N'Wonder', N'August Pullman was born with a facial difference that, up until now, has prevented him from going to a mainstream school. Starting 5th grade at Beecher Prep, he wants nothing more than to be treated as an ordinary kid—but his new classmates can’t get past Auggie’s extraordinary face.', 7.9900, N'wonder.jpg', N'wonder.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (38, N'Dork Diaries 10', N'Nikki has to hide seven ADORKABLE puppies from two parents, one nosy little sister, an entire middle school, and…one mean girl out for revenge, Mackenzie Hollister. If anyone can do it, it’s Nikki…but not without some hilarious challenges along the way!', 9.9900, N'dork.jpg', N'dork.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (39, N'Auggie & Me: Three Wonder Stories', N'These stories are an extra peek at Auggie before he started at Beecher Prep and during his first year there. Readers get to see him through the eyes of Julian, the bully; Christopher, Auggie’s oldest friend; and Charlotte, Auggie’s new friend at school. Together, these three stories are a treasure for readers who don’t want to leave Auggie behind when they finish Wonder.', 13.9900, N'auggie.jpg', N'auggie.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (40, N'The Baby-Sitters Club Graphic Novel', N'Kristy, Mary Anne, Claudia, and Stacey are best friends and founding members of The Baby-Sitters Club. Whatever comes up - cranky toddlers, huge dogs, scary neighbors, prank calls - you can count on them to save the day. But baby-sitting isn''t always easy, and neither is dealing with strict parents, new families, fashion emergencies, and mysterious secrets. But no matter what, the BSC have what they need most: friendship.
Raina Telgemeier, using the signature style featured in her acclaimed graphic novels Smile and Sisters, perfectly captures all the drama and humour of the original novel!', 14.7900, N'babysitter.jpg', N'babysitter.jpg', 0, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (41, N'Smile', N'Eleven-year-old Raina just wants to be a normal sixth grader. But one night after a trip-and-fall mishap, she injures her two front teeth, and what follows is a long and frustrating journey with on-again, off-again braces, corrective surgery, embarrassing headgear, and even a retainer with fake teeth attached. And on top of all that, there''s still more to deal with: a major earthquake, boy confusion, and friends who turn out to be not so friendly.
This coming-of-age true story is sure to resonate with anyone who has ever been in middle school, and especially those who have had a bit of their own dental drama.', 12.9900, N'smile.jpg', N'smile.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (42, N'Charlotte''s Web', N'This beloved book by E. B. White, author of Stuart Little and The Trumpet of the Swan, is a classic of children''s literature that is "just about perfect."', 5.9900, N'web.jpg', N'web.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (43, N'Big Nate: Welcome to My World', N'Nate Wright’s life is just like his locker--it’s full of surprises.  The monstrous Mrs. Godfrey springs a pop quiz on Nate AND his grandparents.  His horoscope predicts bad news for Nate’s soccer career.  And worst of all, he’s forced to cut back on his beloved Cheez Doodles.  It’s enough to drive any kid crazy.  Luckily, Nate’s not just any kid.  He’s the ultimate sixth-grade survivor.  When everything’s falling apart, he finds a way to hold it together … but nobody said it would be easy.', 17.6500, N'big.jpg', N'big.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (44, N'Saga Volume 5', N'Multiple storylines collide in this cosmos-spanning new volume. While Gwendolyn and Lying Cat risk everything to find a cure for The Will, Marko makes an uneasy alliance with Prince Robot IV to find their missing children, who are trapped on a strange world with terrifying new enemies. Collects Saga #25-30.', 22.9900, N'saga.jpg', N'saga.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (45, N'The Sandman: Overture Deluxe Edition', N'THE SANDMAN: OVERTURE heralds New York Times best-selling writer Neil Gaiman''s return to the art form that made him famous, ably abetted by artistic luminary JH Williams III (BATWOMAN, PROMETHEA), whose lush, widescreen images provide an epic scope to The Sandman''s origin story.', 23.9900, N'sandman.jpg', N'sandman.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (46, N'Tokyo Ghoul, Vol. 1', N'Ghouls live among us, the same as normal people in every way—except their craving for human flesh. Ken Kaneki is an ordinary college student until a violent encounter turns him into the first half-human half-ghoul hybrid. Trapped between two worlds, he must survive Ghoul turf wars, learn more about Ghoul society and master his new powers.', 13.5400, N'tokyo.jpg', N'tkyo.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (47, N'Username: Evie', N'Despite his failing health, Evie''s father comes close to creating such a virtual idyll. Passing away before it''s finished, he leaves her the key in the form of an app, and Evie finds herself transported to a world where the population is influenced by her personality. Everyone shines in her presence, until her devious cousin, Mallory, discovers the app... and the power to cause trouble in paradise', 18.9500, N'evie.jpg', N'evie.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (48, N'Batman: Killing Joke (deluxe)', N'Presented for the first time with stark, stunning new coloring by Bolland, BATMAN: THE KILLING JOKE is Alan Moore''s unforgettable meditation on the razor-thin line between sanity and insanity, heroism and villainy, comedy and tragedy.', 27.9900, N'batman.jpg', N'batman.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (49, N'One-Punch Man, Vol. 1', N'Nothing about Saitama passes the eyeball test when it comes to superheroes, from his lifeless expression to his bald head to his unimpressive physique. However, this average-looking guy has a not-so-average problem—he just can’t seem to find an opponent strong enough to take on! Every time a promising villain appears, he beats the snot out of ’em with one punch! Can Saitama finally find an opponent who can go toe-to-toe with him and give his life some meaning? Or is he doomed to a life of superpowered boredom?', 33.9500, N'one.jpg', N'one.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (50, N'Orphan Black Volume 1', N'Sarah''s life was changed dramatically after witnessing the suicide of a woman who looked just like her. Sarah learned that, not only were she and the woman clones, but there were others just like them, and dangerous factions at work set on capturing them all. Now, the mysterious world of Orphan Black widens, with new layers of the conspiracy being peeled back in this series by co-creators John Fawcett and Graeme Manson! Based on the hit BBC America TV Show!', 11.8900, N'orphan.jpg', N'orphan.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (51, N'Jessica Jones: Alias Vol. 1', N'Meet Jessica Jones. Once upon a time, she was a costumed super hero...but not a very good one. Her powers were unremarkable compared to the amazing abilities of the costumed icons that populate the Marvel Universe. In a city of Marvels, Jessica Jones never found her niche. Now a chain-smoking, self-destructive alcoholic with a mean inferiority complex, Jones is the owner and sole employee of Alias Investigations - a small, private-investigative firm specializing in superhuman cases.', 18.9900, N'jessica.jpg', N'jessica.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (52, N'Democracy', N'Democracy opens in 490 B.C., with Athens at war. The hero of the story, Leander, is trying to rouse his comrades for the morrow''s battle against a far mightier enemy, and begins to recount his own life, having borne direct witness to the evils of the old tyrannical regimes and to the emergence of a new political system. The tale that emerges is one of daring, danger, and big ideas, of the death of the gods and the tortuous birth of democracy. We see that democracy originated through a combination of chance and historical contingency--but also through the cunning, courage, and willful action of a group of remarkably talented and driven individuals.', 9.9500, N'demo.jpg', N'demo.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (53, N'Star Wars: Princess Leia', N'When Princess Leia Organa was captured by the Empire, she never betrayed her convictions - even after the complete destruction of her home world, Alderaan. When her rescue came, Leia grabbed a blaster and joined the fight, escaping back to the Rebel Alliance and helping strike the biggest blow against the Empire - the destruction of the Death Star! But in the aftermath of that victory, the question remains...what is a princess without a world? As Leia comes to grips with her loss, a new mission leads her to the underground world of Sullust. The Empire is rounding up fugitive Alderaanians, and that doesn''t sit well with their Princess! But what can one woman do against the Galactic Empire? They''re about to find out! Join the galaxy''s toughest Princess on a quest to save her people and rebuild her life!', 39.9900, N'princess.jpg', N'princess.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (54, N'Winter', N'Princess Winter is admired by the Lunar people for her grace and kindness, and despite the scars that mar her face, her beauty is said to be even more breathtaking than that of her stepmother, Queen Levana.
Winter despises her stepmother, and knows Levana won''t approve of her feelings for her childhood friend--the handsome palace guard, Jacin. But Winter isn''t as weak as Levana believes her to be and she''s been undermining her stepmother''s wishes for years. Together with the cyborg mechanic, Cinder, and her allies, Winter might even have the power to launch a revolution and win a war that''s been raging for far too long.', 15.9500, N'teen.jpg', N'teen.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (55, N'
Nimona', N'The graphic novel debut from rising star Noelle Stevenson, based on her beloved and critically acclaimed web comic, which Slate awarded its Cartoonist Studio Prize, calling it "a deadpan epic."
Nemeses! Dragons! Science! Symbolism! All these and more await in this brilliantly subversive, sharply irreverent epic from Noelle Stevenson. Featuring an exclusive epilogue not seen in the web comic, along with bonus conceptual sketches and revised pages throughout, this gorgeous full-color graphic novel is perfect for the legions of fans of the web comic and is sure to win Noelle many new ones.', 11.9500, N'nim.jpg', N'nim.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (56, N'Dumplin''', N'For fans of John Green and Rainbow Rowell comes this powerful novel with the most fearless heroine—self-proclaimed fat girl Willowdean Dickson—from Julie Murphy, the acclaimed author of Side Effects May Vary. With starry Texas nights, red candy suckers, Dolly Parton songs, and a wildly unforgettable heroine—Dumplin’ is guaranteed to steal your heart.', 11.9900, N'dump.jpg', N'dump.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (57, N'The Scorpion Rules', N'Greta is the Crown Princess of the Pan Polar Confederacy, a superpower formed of modern-day Canada. She is also a Child of Peace, a hostage held by the de facto ruler of the world, the great Artificial Intelligence, Talis. The hostages are Talis’s strategy to keep the peace: if her country enters a war, Greta dies', 9.9900, N'scorpian.jpg', N'scorpian.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (58, N'An Ember In The Ashes', N'Sabaa Tahir‘s AN EMBER IN THE ASHES is a thought-provoking, heart-wrenching and pulse-pounding read. Set in a rich, high-fantasy world with echoes of ancient Rome, it tells the story of a slave fighting for her family and a young soldier fighting for his freedom.
Laia is a slave. Elias is a soldier. Neither is free.', 12.9900, N'ember.jpg', N'ember.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (59, N'Wolf By Wolf', N'The year is 1956, and the Axis powers of the Third Reich and Imperial Japan rule. To commemorate their Great Victory, they host the Axis Tour: an annual motorcycle race across their conjoined continents. The prize? An audience with the highly reclusive Adolf Hitler at the Victor''s ball in Tokyo.', 7.9900, N'wolf.jpg', N'wolf.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (60, N'Mosquitoland', N'After the sudden collapse of her family, Mim Malone is dragged from her home in northern Ohio to the “wastelands” of Mississippi, where she lives in a medicated milieu with her dad and new stepmom. Before the dust has a chance to settle, she learns her mother is sick back in Cleveland.', 18.9500, N'mosq.jpg', N'mosq.jpg', 1, 1)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (61, N'The Heir', N'Twenty years ago, America Singer entered the Selection and won Prince Maxon’s heart. Now the time has come for Princess Eadlyn to hold a Selection of her own. Eadlyn doesn’t expect anything like her parents’ fairy-tale love story...but as the competition begins, she may discover that finding her own happily ever after isn’t as impossible as she’s always thought
', 10.9900, N'heir.jpg', N'heir.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (62, N'
Traffick', N'In her bestselling novel, Tricks, Ellen Hopkins introduced us to five memorable characters tackling these enormous questions: Eden, the preacher’s daughter who turns tricks in Vegas and is helped into a child prostitution rescue; Seth, the gay farm boy disowned by his father who finds himself without money or resources other than his own body; Whitney, the privileged kid coaxed into the life by a pimp and whose dreams are ruined in a heroin haz
', 19.9900, N'traffick.jpg', N'traffick.jpg', 1, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (63, N'Red QueenRed Queen', N'Graceling meets The Selection in debut novelist Victoria Aveyard''s sweeping tale of seventeen-year-old Mare, a common girl whose once-latent magical power draws her into the dangerous intrigue of the king''s palace. Will her power save her or condemn her?
Mare Barrow''s world is divided by blood—those with common, Red blood serve the Silver- blooded elite, who are gifted with superhuman abilities. Mare is a Red, scraping by as a thief in a poor, rural village, until a twist of fate throws her in front of the Silver court. Before the king, princes, and all the nobles, she discovers she has an ability of her own.
', 11.9900, N'red.jpg', N'red.jpg', 0, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [Description], [Price], [Image1FileName], [Image2FileName], [OnCatalogPromotion], [OnDepartmentPromotion]) VALUES (64, N'Half Wild', N'In a modern-day England where two warring factions of witches live amongst humans, seventeen-year-old Nathan is an abomination, the illegitimate son of the world''s most powerful and violent witch. Nathan is hunted from all sides: nowhere is safe and no one can be trusted. Now, Nathan has come into his own unique magical Gift, and he''s on the run--but the Hunters are close behind, and they will stop at nothing until they have captured Nathan and destroyed his father.
', 13.9500, N'half.jpg', N'half.jpg', 0, 0)
SET IDENTITY_INSERT [dbo].[Product] OFF
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (1, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (2, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (3, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (4, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (5, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (6, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (7, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (8, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (9, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (10, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (11, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (13, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (14, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (14, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (15, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (16, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (17, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (18, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (19, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (20, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (21, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (22, 1)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (22, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (23, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (24, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (25, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (26, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (27, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (28, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (29, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (30, 2)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (30, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (31, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (32, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (33, 3)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (34, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (35, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (36, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (37, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (38, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (39, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (40, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (40, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (41, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (42, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (43, 4)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (44, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (45, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (46, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (47, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (48, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (49, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (50, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (51, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (52, 5)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (53, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (54, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (55, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (56, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (57, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (58, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (59, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (60, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (61, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (62, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (63, 6)
INSERT [dbo].[ProductCategory] ([ProductID], [CategoryID]) VALUES (64, 6)
INSERT [dbo].[Shipping] ([ShippingID], [ShippingType], [ShippingCost], [ShippingRegionID]) VALUES (1, N'Next Day Delivery ($20)', 20.0000, 2)
INSERT [dbo].[Shipping] ([ShippingID], [ShippingType], [ShippingCost], [ShippingRegionID]) VALUES (2, N'3-4 Days ($10)', 10.0000, 2)
INSERT [dbo].[Shipping] ([ShippingID], [ShippingType], [ShippingCost], [ShippingRegionID]) VALUES (3, N'7 Days ($5)', 5.0000, 2)
INSERT [dbo].[Shipping] ([ShippingID], [ShippingType], [ShippingCost], [ShippingRegionID]) VALUES (4, N'By Air (7 Days, $25)', 25.0000, 3)
INSERT [dbo].[Shipping] ([ShippingID], [ShippingType], [ShippingCost], [ShippingRegionID]) VALUES (5, N'By Sea (28 days, $10)', 10.0000, 3)
INSERT [dbo].[Shipping] ([ShippingID], [ShippingType], [ShippingCost], [ShippingRegionID]) VALUES (6, N'By Air (10 days, $35)', 35.0000, 4)
INSERT [dbo].[Shipping] ([ShippingID], [ShippingType], [ShippingCost], [ShippingRegionID]) VALUES (7, N'By Sea (38 days, $30)', 30.0000, 4)
SET IDENTITY_INSERT [dbo].[ShippingRegion] ON 

INSERT [dbo].[ShippingRegion] ([ShippingRegionID], [ShippingRegion]) VALUES (1, N'Please Select')
INSERT [dbo].[ShippingRegion] ([ShippingRegionID], [ShippingRegion]) VALUES (2, N'US / Canada')
INSERT [dbo].[ShippingRegion] ([ShippingRegionID], [ShippingRegion]) VALUES (3, N'Europe')
INSERT [dbo].[ShippingRegion] ([ShippingRegionID], [ShippingRegion]) VALUES (4, N'Rest of World')
SET IDENTITY_INSERT [dbo].[ShippingRegion] OFF
INSERT [dbo].[ShoppingCart] ([CartID], [ProductID], [Quantity], [DateAdded]) VALUES (N'a0b497a9-013f-403c-a7a3-363de4a4ae17', 2, 1, CAST(N'2015-12-02 11:31:00' AS SmallDateTime))
INSERT [dbo].[ShoppingCart] ([CartID], [ProductID], [Quantity], [DateAdded]) VALUES (N'f9d1f322-bf71-449e-990e-78ef5627d41a', 1, 3, CAST(N'2015-12-15 17:15:00' AS SmallDateTime))
INSERT [dbo].[ShoppingCart] ([CartID], [ProductID], [Quantity], [DateAdded]) VALUES (N'f9d1f322-bf71-449e-990e-78ef5627d41a', 14, 1, CAST(N'2015-12-15 17:16:00' AS SmallDateTime))
INSERT [dbo].[Tax] ([TaxID], [TaxType], [TaxPercentage]) VALUES (1, N'Sales Tax at 8.5%', 8.5)
INSERT [dbo].[Tax] ([TaxID], [TaxType], [TaxPercentage]) VALUES (2, N'No Tax', 0)
INSERT [dbo].[WishList] ([WishListId], [ProductID], [Quantity], [DateAdded]) VALUES (0, 1, 1, CAST(N'2015-12-17 18:56:00' AS SmallDateTime))
INSERT [dbo].[WishList] ([WishListId], [ProductID], [Quantity], [DateAdded]) VALUES (0, 2, 1, CAST(N'2015-12-15 19:11:00' AS SmallDateTime))
INSERT [dbo].[WishList] ([WishListId], [ProductID], [Quantity], [DateAdded]) VALUES (0, 7, 1, CAST(N'2015-12-15 17:28:00' AS SmallDateTime))
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_Verified]  DEFAULT ((0)) FOR [Verified]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_Completed]  DEFAULT ((0)) FOR [Completed]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_Canceled]  DEFAULT ((0)) FOR [Canceled]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Department] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_Department]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Orders]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Shipping] FOREIGN KEY([ShippingID])
REFERENCES [dbo].[Shipping] ([ShippingID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Shipping]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Tax] FOREIGN KEY([TaxID])
REFERENCES [dbo].[Tax] ([TaxID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Tax]
GO
ALTER TABLE [dbo].[ProductCategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategory_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[ProductCategory] CHECK CONSTRAINT [FK_ProductCategory_Category]
GO
ALTER TABLE [dbo].[ProductCategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategory_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ProductCategory] CHECK CONSTRAINT [FK_ProductCategory_Product]
GO
ALTER TABLE [dbo].[ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ShoppingCart] CHECK CONSTRAINT [FK_ShoppingCart_Product]
GO
ALTER TABLE [dbo].[WishList]  WITH CHECK ADD  CONSTRAINT [FK_WishList_ToTable] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[WishList] CHECK CONSTRAINT [FK_WishList_ToTable]
GO
/****** Object:  StoredProcedure [dbo].[AddDepartment]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddDepartment]
(@DepartmentName VARCHAR(50),
@DepartmentDescription VARCHAR(1000))
AS
INSERT INTO Department (Name, Description)
VALUES (@DepartmentName, @DepartmentDescription)


GO
/****** Object:  StoredProcedure [dbo].[AssignProductToCategory]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AssignProductToCategory]
(@ProductID INT, @CategoryID INT)
AS
INSERT INTO ProductCategory (ProductID, CategoryID)
VALUES (@ProductID, @CategoryID)


GO
/****** Object:  StoredProcedure [dbo].[CreateCategory]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateCategory]
(@DepartmentID INT,
@CategoryName VARCHAR(50),
@CategoryDescription VARCHAR(50))
AS
INSERT INTO Category (DepartmentID, Name, Description)
VALUES (@DepartmentID, @CategoryName, @CategoryDescription)


GO
/****** Object:  StoredProcedure [dbo].[CreateOrder]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateOrder] 
(@CartID char(36))
AS
/* Insert a new record INTo Orders */
DECLARE @OrderID INT
INSERT INTO Orders DEFAULT VALUES
/* Save the new Order ID */
SET @OrderID = @@IDENTITY
/* Add the order details to OrderDetail */
INSERT INTO OrderDetail 
     (OrderID, ProductID, ProductName, Quantity, UnitCost)
SELECT 
     @OrderID, Product.ProductID, Product.Name, 
     ShoppingCart.Quantity, Product.Price
FROM Product JOIN ShoppingCart
ON Product.ProductID = ShoppingCart.ProductID
WHERE ShoppingCart.CartID = @CartID
/* Clear the shopping cart */
DELETE FROM ShoppingCart
WHERE CartID = @CartID
/* Return the Order ID */
SELECT @OrderID


GO
/****** Object:  StoredProcedure [dbo].[CreateProduct]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateProduct]
(@CategoryID INT,
 @ProductName VARCHAR(50),
 @ProductDescription VARCHAR(1000),
 @ProductPrice MONEY,
 @Image1FileName VARCHAR(50),
 @Image2FileName VARCHAR(50),
 @OnDepartmentPromotion BIT,
 @OnCatalogPromotion BIT)
AS
-- Declare a variable to hold the generated product ID
DECLARE @ProductID INT
-- Create the new product entry
INSERT INTO Product 
    (Name, 
     Description, 
     Price, 
     Image1FileName, 
     Image2FileName,
     OnDepartmentPromotion, 
     OnCatalogPromotion )
VALUES 
    (@ProductName, 
     @ProductDescription, 
     @ProductPrice, 
     @Image1FileName, 
     @Image2FileName,
     @OnDepartmentPromotion, 
     @OnCatalogPromotion)
-- Save the generated product ID to a variable
SELECT @ProductID = @@Identity
-- Associate the product with a category
INSERT INTO ProductCategory (ProductID, CategoryID)
VALUES (@ProductID, @CategoryID)


GO
/****** Object:  StoredProcedure [dbo].[DeleteCategory]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteCategory]
(@CategoryID INT)
AS
DELETE FROM Category
WHERE CategoryID = @CategoryID


GO
/****** Object:  StoredProcedure [dbo].[DeleteDepartment]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteDepartment]
(@DepartmentID INT)
AS
DELETE FROM Department
WHERE DepartmentID = @DepartmentID


GO
/****** Object:  StoredProcedure [dbo].[DeleteProduct]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteProduct]
(@ProductID INT)
AS
DELETE FROM ShoppingCart WHERE ProductID=@ProductID
DELETE FROM ProductCategory WHERE ProductID=@ProductID
DELETE FROM Product where ProductID=@ProductID


GO
/****** Object:  StoredProcedure [dbo].[GetAllProductsInCategory]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAllProductsInCategory]
(@CategoryID INT)
AS
SELECT Product.ProductID, Name, Description, Price, Image1FileName, 
       Image2FileName, OnDepartmentPromotion, OnCatalogPromotion
FROM Product INNER JOIN ProductCategory
  ON Product.ProductID = ProductCategory.ProductID
WHERE ProductCategory.CategoryID = @CategoryID


GO
/****** Object:  StoredProcedure [dbo].[GetCategoriesInDepartment]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetCategoriesInDepartment]
(@DepartmentID INT)
AS
SELECT CategoryID, Name, Description
FROM Category
WHERE DepartmentID = @DepartmentID


GO
/****** Object:  StoredProcedure [dbo].[GetCategoriesWithoutProduct]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetCategoriesWithoutProduct]
(@ProductID INT)
AS
SELECT CategoryID, Name
FROM Category
WHERE CategoryID NOT IN
   (SELECT Category.CategoryID
    FROM Category INNER JOIN ProductCategory
    ON Category.CategoryID = ProductCategory.CategoryID
    WHERE ProductCategory.ProductID = @ProductID)


GO
/****** Object:  StoredProcedure [dbo].[GetCategoriesWithProduct]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetCategoriesWithProduct]
(@ProductID INT)
AS
SELECT Category.CategoryID, Name
FROM Category INNER JOIN ProductCategory
ON Category.CategoryID = ProductCategory.CategoryID
WHERE ProductCategory.ProductID = @ProductID


GO
/****** Object:  StoredProcedure [dbo].[GetCategoryDetails]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetCategoryDetails] 
(@CategoryID INT)
AS
SELECT DepartmentID, Name, Description
FROM Category
WHERE CategoryID = @CategoryID


GO
/****** Object:  StoredProcedure [dbo].[GetDepartmentDetails]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetDepartmentDetails]
(@DepartmentID INT)
AS
SELECT Name, Description
FROM Department
WHERE DepartmentID = @DepartmentID


GO
/****** Object:  StoredProcedure [dbo].[GetDepartments]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetDepartments] AS
SELECT DepartmentID, Name, Description
FROM Department


GO
/****** Object:  StoredProcedure [dbo].[GetProductDetails]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProductDetails] 
(@ProductID INT)
AS
SELECT Name, Description, Price, Image1FileName, Image2FileName, OnDepartmentPromotion, OnCatalogPromotion
FROM Product
WHERE ProductID = @ProductID
RETURN


GO
/****** Object:  StoredProcedure [dbo].[GetProductRecommendations]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProductRecommendations]
(@ProductID INT,
 @DescriptionLength INT)
AS
SELECT ProductID, 
       Name, 
       SUBSTRING(Description, 1, @DescriptionLength) + '...' AS Description
FROM Product
WHERE ProductID IN
    (
    SELECT TOP 5 od2.ProductID
    FROM OrderDetail od1
    JOIN OrderDetail od2 ON od1.OrderID = od2.OrderID
    WHERE od1.ProductID = @ProductID AND od2.ProductID != @ProductID
    GROUP BY od2.ProductID
    ORDER BY COUNT(od2.ProductID) DESC
    )


GO
/****** Object:  StoredProcedure [dbo].[GetProductRecommendations2]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProductRecommendations2]
(@ProductID INT,
 @DescriptionLength INT)
AS
--- Returns the product recommendations
SELECT ProductID,
       Name,
       SUBSTRING(Description, 1, @DescriptionLength) + '...' AS Description
FROM Product
WHERE ProductID IN
   (
   -- Returns the products that were ordered together with @ProductID
   SELECT TOP 5 ProductID
   FROM OrderDetail
   WHERE OrderID IN
      (
      -- Returns the orders that contain @ProductID
      SELECT DISTINCT OrderID
      FROM OrderDetail
      WHERE ProductID = @ProductID
      )
   -- Must not include products that already exist in the visitor''s cart
   AND ProductID <> @ProductID
   -- Group the ProductID so we can calculate the rank
   GROUP BY ProductID
   -- Order descending by rank
   ORDER BY COUNT(ProductID) DESC
   )


GO
/****** Object:  StoredProcedure [dbo].[GetProductsInCategory]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProductsInCategory]
(@CategoryID INT,
@DescriptionLength INT,
@PageNumber INT,
@ProductsPerPage INT,
@HowManyProducts INT OUTPUT)
AS

-- declare a new TABLE variable
DECLARE @Products TABLE
(RowNumber INT,
 ProductID INT,
 Name VARCHAR(50),
 Description VARCHAR(5000),
 Price MONEY,
 Image1FileName VARCHAR(50),
 Image2FileName VARCHAR(50),
 OnDepartmentPromotion BIT,
 OnCatalogPromotion BIT)

-- populate the table variable with the complete list of products
INSERT INTO @Products
SELECT ROW_NUMBER() OVER (ORDER BY Product.ProductID),
       Product.ProductID, Name, 
       SUBSTRING(Description, 1, @DescriptionLength) + '...' AS Description,
       Price, Image1FileName, Image2FileName, OnDepartmentPromotion, OnCatalogPromotion
FROM Product INNER JOIN ProductCategory
  ON Product.ProductID = ProductCategory.ProductID
WHERE ProductCategory.CategoryID = @CategoryID

-- return the total number of products using an OUTPUT variable
SELECT @HowManyProducts = COUNT(ProductID) FROM @Products

-- extract the requested page of products
SELECT ProductID, Name, Description, Price, Image1FileName,
       Image2FileName, OnDepartmentPromotion, OnCatalogPromotion
FROM @Products
WHERE RowNumber > (@PageNumber - 1) * @ProductsPerPage
  AND RowNumber <= @PageNumber * @ProductsPerPage


GO
/****** Object:  StoredProcedure [dbo].[GetProductsOnCatalogPromotion]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProductsOnCatalogPromotion]
(@DescriptionLength INT,
@PageNumber INT,
@ProductsPerPage INT,
@HowManyProducts INT OUTPUT)
AS

-- declare a new TABLE variable
DECLARE @Products TABLE
(RowNumber INT,
 ProductID INT,
 Name VARCHAR(50),
 Description VARCHAR(5000),
 Price MONEY,
 Image1FileName VARCHAR(50),
 Image2FileName VARCHAR(50),
 OnDepartmentPromotion BIT,
 OnCatalogPromotion BIT)

-- populate the table variable with the complete list of products
INSERT INTO @Products
SELECT ROW_NUMBER() OVER (ORDER BY Product.ProductID),
       ProductID, Name, 
       SUBSTRING(Description, 1, @DescriptionLength) + '...' AS Description,
       Price, Image1FileName, Image2FileName, OnDepartmentPromotion, OnCatalogPromotion
FROM Product
WHERE OnCatalogPromotion = 1

-- return the total number of products using an OUTPUT variable
SELECT @HowManyProducts = COUNT(ProductID) FROM @Products

-- extract the requested page of products
SELECT ProductID, Name, Description, Price, Image1FileName,
       Image2FileName, OnDepartmentPromotion, OnCatalogPromotion
FROM @Products
WHERE RowNumber > (@PageNumber - 1) * @ProductsPerPage
  AND RowNumber <= @PageNumber * @ProductsPerPage


GO
/****** Object:  StoredProcedure [dbo].[GetProductsOnDepartmentPromotion]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetProductsOnDepartmentPromotion]
(@DepartmentID INT,
@DescriptionLength INT,
@PageNumber INT,
@ProductsPerPage INT,
@HowManyProducts INT OUTPUT)
AS

-- declare a new TABLE variable
DECLARE @Products TABLE
(RowNumber INT,
 ProductID INT,
 Name VARCHAR(50),
 Description VARCHAR(5000),
 Price MONEY,
 Image1FileName VARCHAR(50),
 Image2FileName VARCHAR(50),
 OnDepartmentPromotion BIT,
 OnCatalogPromotion BIT)

-- populate the table variable with the complete list of products
INSERT INTO @Products    
SELECT ROW_NUMBER() OVER (ORDER BY ProductID) AS Row, 
       ProductID, Name, SUBSTRING(Description, 1, @DescriptionLength) + '...' AS Description,
       Price, Image1FileName, Image2FileName, OnDepartmentPromotion, OnCatalogPromotion
FROM 
(SELECT DISTINCT Product.ProductID, Product.Name, 
  SUBSTRING(Product.Description, 1, @DescriptionLength) + '...' AS Description,
  Price, Image1FileName, Image2FileName, OnDepartmentPromotion, OnCatalogPromotion
  FROM Product INNER JOIN ProductCategory
                      ON Product.ProductID = ProductCategory.ProductID
              INNER JOIN Category
                      ON ProductCategory.CategoryID = Category.CategoryID
  WHERE Product.OnDepartmentPromotion = 1 
   AND Category.DepartmentID = @DepartmentID
) AS ProductOnDepPr

-- return the total number of products using an OUTPUT variable
SELECT @HowManyProducts = COUNT(ProductID) FROM @Products

-- extract the requested page of products
SELECT ProductID, Name, Description, Price, Image1FileName,
       Image2FileName, OnDepartmentPromotion, OnCatalogPromotion
FROM @Products
WHERE RowNumber > (@PageNumber - 1) * @ProductsPerPage
  AND RowNumber <= @PageNumber * @ProductsPerPage


GO
/****** Object:  StoredProcedure [dbo].[GetShoppingCartRecommendations]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetShoppingCartRecommendations]
(@CartID CHAR(36),
 @DescriptionLength INT)
AS
--- Returns the product recommendations
SELECT ProductID,
       Name,
       SUBSTRING(Description, 1, @DescriptionLength) + '...' AS Description
FROM Product
WHERE ProductID IN
   (
   -- Returns the products that exist in a list of orders
   SELECT TOP 5 od1.ProductID AS Rank
   FROM OrderDetail od1 
     JOIN OrderDetail od2
       ON od1.OrderID=od2.OrderID
     JOIN ShoppingCart sp
       ON od2.ProductID = sp.ProductID
   WHERE sp.CartID = @CartID
        -- Must not include products that already exist in the visitor''s cart
      AND od1.ProductID NOT IN
      (
      -- Returns the products in the specified shopping cart
      SELECT ProductID 
      FROM ShoppingCart
      WHERE CartID = @CartID
      )
   -- Group the ProductID so we can calculate the rank
   GROUP BY od1.ProductID
   -- Order descending by rank
   ORDER BY COUNT(od1.ProductID) DESC
   )


GO
/****** Object:  StoredProcedure [dbo].[GetShoppingCartRecommendations2]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetShoppingCartRecommendations2]
(@CartID CHAR(36),
 @DescriptionLength INT)
AS
--- Returns the product recommendations
SELECT ProductID,
       Name,
       SUBSTRING(Description, 1, @DescriptionLength) + '...' AS Description
FROM Product
WHERE ProductID IN
   (
   -- Returns the products that exist in a list of orders
   SELECT TOP 5 ProductID
   FROM OrderDetail
   WHERE OrderID IN
      (
      -- Returns the orders that contain certain products
      SELECT DISTINCT OrderID 
      FROM OrderDetail 
      WHERE ProductID IN
         (
         -- Returns the products in the specified shopping cart
         SELECT ProductID 
         FROM ShoppingCart
         WHERE CartID = @CartID
         )
      )
   -- Must not include products that already exist in the visitor''s cart
   AND ProductID NOT IN
      (
      -- Returns the products in the specified shopping cart
      SELECT ProductID 
      FROM ShoppingCart
      WHERE CartID = @CartID
      )
   -- Group the ProductID so we can calculate the rank
   GROUP BY ProductID
   -- Order descending by rank
   ORDER BY COUNT(ProductID) DESC
   )


GO
/****** Object:  StoredProcedure [dbo].[MoveProductToCategory]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MoveProductToCategory]
(@ProductID INT, @OldCategoryID INT, @NewCategoryID INT)
AS
UPDATE ProductCategory
SET CategoryID = @NewCategoryID
WHERE CategoryID = @OldCategoryID
  AND ProductID = @ProductID


GO
/****** Object:  StoredProcedure [dbo].[OrderGetDetails]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[OrderGetDetails]
(@OrderID INT)
AS
SELECT Orders.OrderID, 
       ProductID, 
       ProductName, 
       Quantity, 
       UnitCost, 
       Subtotal
FROM OrderDetail JOIN Orders
ON Orders.OrderID = OrderDetail.OrderID
WHERE Orders.OrderID = @OrderID


GO
/****** Object:  StoredProcedure [dbo].[OrderGetInfo]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[OrderGetInfo]
(@OrderID INT)
AS
SELECT OrderID, 
      (SELECT ISNULL(SUM(Subtotal), 0) FROM OrderDetail WHERE OrderID = @OrderID) 
       AS TotalAmount, 
       DateCreated, 
       DateShipped, 
       Verified, 
       Completed, 
       Canceled, 
       Comments, 
       CustomerName, 
       ShippingAddress, 
       CustomerEmail
FROM Orders
WHERE OrderID = @OrderID


GO
/****** Object:  StoredProcedure [dbo].[OrderMarkCanceled]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[OrderMarkCanceled]
(@OrderID INT)
AS
UPDATE Orders
SET Canceled = 1
WHERE OrderID = @OrderID


GO
/****** Object:  StoredProcedure [dbo].[OrderMarkCompleted]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[OrderMarkCompleted]
(@OrderID INT)
AS
UPDATE Orders
SET Completed = 1,
    DateShipped = GETDATE()
WHERE OrderID = @OrderID


GO
/****** Object:  StoredProcedure [dbo].[OrderMarkVerified]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[OrderMarkVerified]
(@OrderID INT)
AS
UPDATE Orders
SET Verified = 1
WHERE OrderID = @OrderID


GO
/****** Object:  StoredProcedure [dbo].[OrdersGetByDate]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[OrdersGetByDate] 
(@StartDate SMALLDATETIME,
 @EndDate SMALLDATETIME)
AS
SELECT OrderID, DateCreated, DateShipped, 
       Verified, Completed, Canceled, CustomerName
FROM Orders
WHERE DateCreated BETWEEN @StartDate AND @EndDate
ORDER BY DateCreated DESC


GO
/****** Object:  StoredProcedure [dbo].[OrdersGetByRecent]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[OrdersGetByRecent] 
(@Count smallINT)
AS
-- Set the number of rows to be returned
SET ROWCOUNT @Count
-- Get list of orders
SELECT OrderID, DateCreated, DateShipped, 
       Verified, Completed, Canceled, CustomerName
FROM Orders
ORDER BY DateCreated DESC
-- Reset rowcount value
SET ROWCOUNT 0


GO
/****** Object:  StoredProcedure [dbo].[OrdersGetUnverifiedUncanceled]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[OrdersGetUnverifiedUncanceled]
AS
SELECT OrderID, DateCreated, DateShipped, 
       Verified, Completed, Canceled, CustomerName
FROM Orders
WHERE Verified=0 AND Canceled=0
ORDER BY DateCreated DESC


GO
/****** Object:  StoredProcedure [dbo].[OrdersGetVerifiedUncompleted]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[OrdersGetVerifiedUncompleted]
AS
SELECT OrderID, DateCreated, DateShipped, 
       Verified, Completed, Canceled, CustomerName
FROM Orders
WHERE Verified=1 AND Completed=0
ORDER BY DateCreated DESC


GO
/****** Object:  StoredProcedure [dbo].[OrderUpdate]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[OrderUpdate]
(@OrderID INT,
 @DateCreated SMALLDATETIME,
 @DateShipped SMALLDATETIME = NULL,
 @Verified BIT,
 @Completed BIT,
 @Canceled BIT,
 @Comments VARCHAR(200),
 @CustomerName VARCHAR(50),
 @ShippingAddress VARCHAR(200),
 @CustomerEmail VARCHAR(50))
AS
UPDATE Orders
SET DateCreated=@DateCreated,
    DateShipped=@DateShipped,
    Verified=@Verified,
    Completed=@Completed,
    Canceled=@Canceled,
    Comments=@Comments,
    CustomerName=@CustomerName,
    ShippingAddress=@ShippingAddress,
    CustomerEmail=@CustomerEmail
WHERE OrderID = @OrderID


GO
/****** Object:  StoredProcedure [dbo].[RemoveProductFromCategory]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RemoveProductFromCategory]
(@ProductID INT, @CategoryID INT)
AS
DELETE FROM ProductCategory
WHERE CategoryID = @CategoryID AND ProductID = @ProductID


GO
/****** Object:  StoredProcedure [dbo].[SearchCatalog]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SearchCatalog] 
(@DescriptionLength INT,
 @PageNumber TINYINT,
 @ProductsPerPage TINYINT,
 @HowManyResults SMALLINT OUTPUT,
 @AllWords BIT,
 @Word1 VARCHAR(15) = NULL,
 @Word2 VARCHAR(15) = NULL,
 @Word3 VARCHAR(15) = NULL,
 @Word4 VARCHAR(15) = NULL,
 @Word5 VARCHAR(15) = NULL)
AS

/* Create the table variable that will contain the search results */
DECLARE @Products TABLE
(RowNumber SMALLINT IDENTITY (1,1) NOT NULL,
 ProductID INT,
 Name VARCHAR(50),
 Description VARCHAR(1000),
 Price MONEY,
 Image1FileName VARCHAR(50),
 Image2FileName VARCHAR(50),
 Rank INT)

/* Populate @Products for an any-words search */
IF @AllWords = 0 
   INSERT INTO @Products           
   SELECT ProductID, Name, 
          SUBSTRING(Description, 1, @DescriptionLength) + '...' AS Description, 
          Price, Image1FileName, Image2FileName,
          3 * dbo.WordCount(@Word1, Name) + dbo.WordCount(@Word1, Description) +
          3 * dbo.WordCount(@Word2, Name) + dbo.WordCount(@Word2, Description) +
          3 * dbo.WordCount(@Word3, Name) + dbo.WordCount(@Word3, Description) +
          3 * dbo.WordCount(@Word4, Name) + dbo.WordCount(@Word4, Description) +
          3 * dbo.WordCount(@Word5, Name) + dbo.WordCount(@Word5, Description) 
          AS Rank
   FROM Product
   ORDER BY Rank DESC
   
/* Populate @Products for an all-words search */
IF @AllWords = 1 
   INSERT INTO @Products           
   SELECT ProductID, Name, 
          SUBSTRING(Description, 1, @DescriptionLength) + '...' AS Description, 
          Price, Image1FileName, Image2FileName,
          (3 * dbo.WordCount(@Word1, Name) + dbo.WordCount(@Word1, Description)) *
          CASE 
            WHEN @Word2 IS NULL THEN 1 
            ELSE 3 * dbo.WordCount(@Word2, Name) + dbo.WordCount(@Word2, Description)
          END *
          CASE 
            WHEN @Word3 IS NULL THEN 1 
            ELSE 3 * dbo.WordCount(@Word3, Name) + dbo.WordCount(@Word3, Description)
          END *
          CASE 
            WHEN @Word4 IS NULL THEN 1 
            ELSE 3 * dbo.WordCount(@Word4, Name) + dbo.WordCount(@Word4, Description)
          END *
          CASE 
            WHEN @Word5 IS NULL THEN 1 
            ELSE 3 * dbo.WordCount(@Word5, Name) + dbo.WordCount(@Word5, Description)
          END
          AS Rank
   FROM Product
   ORDER BY Rank DESC

/* Save the number of searched products in an output variable */
SELECT @HowManyResults = COUNT(*) 
FROM @Products 
WHERE Rank > 0

/* Send back the requested products */
SELECT ProductID, Name, Description, Price, Image1FileName, Image2FileName, Rank
FROM @Products
WHERE Rank > 0
  AND RowNumber BETWEEN (@PageNumber-1) * @ProductsPerPage + 1 
                    AND @PageNumber * @ProductsPerPage
ORDER BY Rank DESC


GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartAddItem]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ShoppingCartAddItem]
(@CartID char(36),
 @ProductID INT)
AS
IF EXISTS 
        (SELECT CartID 
         FROM ShoppingCart 
         WHERE ProductID = @ProductID AND CartID = @CartID)
    UPDATE ShoppingCart
    SET Quantity = Quantity + 1
    WHERE ProductID = @ProductID AND CartID = @CartID
ELSE
    IF EXISTS (SELECT Name FROM Product WHERE ProductID=@ProductID)
        INSERT INTO ShoppingCart (CartID, ProductID, Quantity, DateAdded)
        VALUES (@CartID, @ProductID, 1, GETDATE())


GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartCountOldCarts]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ShoppingCartCountOldCarts]
(@Days smallINT)
AS
SELECT COUNT(CartID) 
FROM ShoppingCart
WHERE CartID IN
  (SELECT CartID
   FROM ShoppingCart
   GROUP BY CartID
   HAVING MIN(DATEDIFF(dd,DateAdded,GETDATE())) >= @Days)


GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartDeleteOldCarts]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ShoppingCartDeleteOldCarts]
(@Days smallINT)
AS
DELETE FROM ShoppingCart
WHERE CartID IN
  (SELECT CartID
   FROM ShoppingCart
   GROUP BY CartID
   HAVING MIN(DATEDIFF(dd,DateAdded,GETDATE())) >= @Days)


GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartGetItems]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ShoppingCartGetItems]
(@CartID char(36))
AS
SELECT Product.ProductID, Product.Name, Product.Price, ShoppingCart.Quantity, 
       Product.Price * ShoppingCart.Quantity AS Subtotal
FROM ShoppingCart INNER JOIN Product
ON ShoppingCart.ProductID = Product.ProductID
WHERE ShoppingCart.CartID = @CartID


GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartGetTotalAmount]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ShoppingCartGetTotalAmount]
(@CartID char(36))
AS
SELECT ISNULL(SUM(Product.Price * ShoppingCart.Quantity), 0)
FROM ShoppingCart INNER JOIN Product
ON ShoppingCart.ProductID = Product.ProductID
WHERE ShoppingCart.CartID = @CartID


GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartRemoveItem]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ShoppingCartRemoveItem]
(@CartID char(36),
 @ProductID INT)
AS
DELETE FROM ShoppingCart
WHERE CartID = @CartID and ProductID = @ProductID


GO
/****** Object:  StoredProcedure [dbo].[ShoppingCartUpdateItem]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[ShoppingCartUpdateItem]
(@CartID char(36),
 @ProductID INT,
 @Quantity INT)
As
IF @Quantity <= 0 
  EXEC ShoppingCartRemoveItem @CartID, @ProductID
ELSE
  UPDATE ShoppingCart
  SET Quantity = @Quantity, DateAdded = GETDATE()
  WHERE ProductID = @ProductID AND CartID = @CartID


GO
/****** Object:  StoredProcedure [dbo].[UpdateCategory]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateCategory]
(@CategoryID INT,
@CategoryName VARCHAR(50),
@CategoryDescription VARCHAR(1000))
AS
UPDATE Category
SET Name = @CategoryName, Description = @CategoryDescription
WHERE CategoryID = @CategoryID


GO
/****** Object:  StoredProcedure [dbo].[UpdateDepartment]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateDepartment]
(@DepartmentID INT,
@DepartmentName VARCHAR(50),
@DepartmentDescription VARCHAR(1000))
AS
UPDATE Department
SET Name = @DepartmentName, Description = @DepartmentDescription
WHERE DepartmentID = @DepartmentID


GO
/****** Object:  StoredProcedure [dbo].[UpdateProduct]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateProduct]
(@ProductID INT,
 @ProductName VARCHAR(50),
 @ProductDescription VARCHAR(5000),
 @ProductPrice MONEY,
 @Image1FileName VARCHAR(50),
 @Image2FileName VARCHAR(50),
 @OnDepartmentPromotion BIT,
 @OnCatalogPromotion BIT)
AS
UPDATE Product
SET Name = @ProductName,
    Description = @ProductDescription,
    Price = @ProductPrice,
    Image1FileName = @Image1FileName,
    Image2FileName = @Image2FileName,
    OnDepartmentPromotion = @OnDepartmentPromotion,
    OnCatalogPromotion = @OnCatalogPromotion
WHERE ProductID = @ProductID


GO
/****** Object:  StoredProcedure [dbo].[WishListAddItem]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[WishListAddItem]
(@WishListId INT,
 @ProductID INT)
AS
IF EXISTS 
        (SELECT WishListId
         FROM WishList 
         WHERE ProductID = @ProductID AND ProductID = @WishListId)
    UPDATE WishList
    SET Quantity = Quantity + 1
    WHERE ProductID = @ProductID AND WishListId = @WishListId
ELSE
    IF EXISTS (SELECT Name FROM Product WHERE ProductID=@ProductID)
        INSERT INTO WishList(WishListId, ProductID, Quantity, DateAdded)
        VALUES (@WishListId, @ProductID, 1, GETDATE())

GO
/****** Object:  StoredProcedure [dbo].[WishListGetItems]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[WishListGetItems]
(@WishListID char(36))
AS
SELECT Product.ProductID, Product.Image1FileName, Product.Name, Product.Price, WishList.Quantity, 
       Product.Price * WishList.Quantity AS Subtotal
FROM WishList INNER JOIN Product
ON WishList.ProductID = Product.ProductID
WHERE WishList.WishListId = @WishListID

GO
/****** Object:  StoredProcedure [dbo].[WishListRemoveItem]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[WishListRemoveItem]
(@WishListId char(36),
 @ProductID INT)
AS
DELETE FROM WishList
WHERE WishListID = @WishListID and ProductID = @ProductID
GO
/****** Object:  StoredProcedure [dbo].[WishListUpdate]    Script Date: 12/18/2015 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[WishListUpdate]
(@WishListID char(36),
 @ProductID INT,
 @Quantity INT)
As
IF @Quantity <= 0 
  EXEC ShoppingCartRemoveItem @WishListId, @ProductID
ELSE
  UPDATE WishList
  SET Quantity = @Quantity, DateAdded = GETDATE()
  WHERE ProductID = @ProductID AND WishListId = @WishListID
GO
USE [master]
GO
ALTER DATABASE [BalloonShop] SET  READ_WRITE 
GO


/****** Object:  StoredProcedure [dbo].[AuditLog]    Script Date: 12/18/2015 2:19:22 PM ******/

USE BalloonShop
GO

CREATE TRIGGER AuditLog
On [dbo].[Product]
AFTER INSERT
AS 
BEGIN
SET NOCOUNT ON;
insert dbo.Product2
Select Name, Description, Price, Image1FileName, Image2FileName, OnCatalogPromotion, OnDepartmentPromotion from inserted
END
GO
