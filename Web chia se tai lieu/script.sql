USE [master]
GO
/****** Object:  Database [Webtailieu]    Script Date: 4/15/2024 2:49:46 PM ******/
CREATE DATABASE [Webtailieu]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Webtailieu', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Webtailieu.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Webtailieu_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Webtailieu_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Webtailieu] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Webtailieu].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Webtailieu] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Webtailieu] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Webtailieu] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Webtailieu] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Webtailieu] SET ARITHABORT OFF 
GO
ALTER DATABASE [Webtailieu] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Webtailieu] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Webtailieu] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Webtailieu] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Webtailieu] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Webtailieu] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Webtailieu] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Webtailieu] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Webtailieu] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Webtailieu] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Webtailieu] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Webtailieu] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Webtailieu] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Webtailieu] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Webtailieu] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Webtailieu] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Webtailieu] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Webtailieu] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Webtailieu] SET  MULTI_USER 
GO
ALTER DATABASE [Webtailieu] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Webtailieu] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Webtailieu] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Webtailieu] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Webtailieu] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Webtailieu] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Webtailieu] SET QUERY_STORE = OFF
GO
USE [Webtailieu]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 4/15/2024 2:49:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 4/15/2024 2:49:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[NumberOfProduct] [int] NULL,
	[Image] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 4/15/2024 2:49:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[UserId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[TimeCreate] [datetime] NULL,
	[Content] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice_Coin]    Script Date: 4/15/2024 2:49:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice_Coin](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TimeCreate] [datetime] NOT NULL,
	[Price] [money] NOT NULL,
	[Coins] [int] NOT NULL,
	[MPId] [int] NULL,
	[UserId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice_Product]    Script Date: 4/15/2024 2:49:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice_Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TimeCreate] [datetime] NOT NULL,
	[Total] [int] NULL,
	[EmailUser] [nvarchar](1000) NOT NULL,
	[NameProduct] [nvarchar](512) NOT NULL,
	[UserId] [int] NULL,
	[ProductId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Methods_Payment]    Script Date: 4/15/2024 2:49:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Methods_Payment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Detail] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 4/15/2024 2:49:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](512) NOT NULL,
	[Description] [ntext] NULL,
	[Price] [int] NULL,
	[File] [nvarchar](1000) NOT NULL,
	[FileImage] [nvarchar](1000) NULL,
	[TimeCreate] [datetime] NULL,
	[TimePost] [datetime] NULL,
	[TypeFile] [varchar](50) NULL,
	[CategoryId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Views] [int] NULL,
	[Downloads] [int] NULL,
	[Likes] [int] NULL,
	[Status] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report]    Script Date: 4/15/2024 2:49:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report](
	[UserId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Content] [ntext] NULL,
	[TimeCreate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 4/15/2024 2:49:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[Role] [varchar](255) NOT NULL,
	[Avatar] [nvarchar](1000) NULL,
	[BirthDay] [datetime] NULL,
	[Coin] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [Name], [NumberOfProduct], [Image]) VALUES (1, N'Điện tử', 0, NULL)
INSERT [dbo].[Category] ([Id], [Name], [NumberOfProduct], [Image]) VALUES (2, N'Khoa Học - Công Nghệ', 0, N'/Images/Thong tin truyen.png')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [File], [FileImage], [TimeCreate], [TimePost], [TypeFile], [CategoryId], [UserId], [Views], [Downloads], [Likes], [Status]) VALUES (2, N'Tam Ly Hoc', N'jjj', 123, N'/file/Nội dung tóm tắt tuần 2.docx', N'/Images/1835326728.jpg', CAST(N'2024-04-07T18:34:46.207' AS DateTime), CAST(N'2024-04-07T19:25:40.700' AS DateTime), N'.docx', 1, 1, 7602, 352, 886, N'Confirmed')
INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [File], [FileImage], [TimeCreate], [TimePost], [TypeFile], [CategoryId], [UserId], [Views], [Downloads], [Likes], [Status]) VALUES (3, N'Tam Ly Hoc', N'123', 0, N'/file/Báo-cáo-tuần-3.docx', N'/Images/1835326728.jpg', CAST(N'2024-04-08T02:34:23.777' AS DateTime), CAST(N'2024-04-08T02:34:38.253' AS DateTime), N'.docx', 1, 1, 8637, 402, 20, N'Confirmed')
INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [File], [FileImage], [TimeCreate], [TimePost], [TypeFile], [CategoryId], [UserId], [Views], [Downloads], [Likes], [Status]) VALUES (4, N'Tam Ly Hoc 1', N'000', 0, N'/file/Báo-cáo-tuần-3.docx', N'/Images/Index.png', CAST(N'2024-04-08T13:12:35.787' AS DateTime), CAST(N'2024-04-08T13:12:43.510' AS DateTime), N'.docx', 1, 1, 3507, 128, 671, N'Confirmed')
INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [File], [FileImage], [TimeCreate], [TimePost], [TypeFile], [CategoryId], [UserId], [Views], [Downloads], [Likes], [Status]) VALUES (8, N'Tai Lieu Bach Khoa', N's', 0, N'/file/course-v1_HUTECH+ML_NDD0010876_POS105_N26+HK2A-2023-2024-members-638472339020576397-course-v1_HUTECH+ML_NDD0010876_POS105_N26+HK2A-2023-2024.pdf', N'/Images/depositphotos_652763588-stock-photo-one-man-young-adult-caucasian.jpg', CAST(N'2024-04-11T23:43:26.167' AS DateTime), NULL, N'.pdf', 2, 1, 4534, 183, 752, N'No Confirm')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [Name], [Email], [Password], [Role], [Avatar], [BirthDay], [Coin]) VALUES (1, N'Admin', N'admin@gmail.com', N'123456', N'admin', NULL, CAST(N'2020-11-12T00:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__User__A9D105348203CF45]    Script Date: 4/15/2024 2:49:46 PM ******/
ALTER TABLE [dbo].[User] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Category] ADD  DEFAULT ((0)) FOR [NumberOfProduct]
GO
ALTER TABLE [dbo].[Invoice_Coin] ADD  DEFAULT ((0)) FOR [Coins]
GO
ALTER TABLE [dbo].[Invoice_Product] ADD  DEFAULT ((0)) FOR [Total]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [Views]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [Downloads]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [Likes]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF__Product__Status__01142BA1]  DEFAULT ('Chua Duy?t') FOR [Status]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT ((0)) FOR [Coin]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Invoice_Coin]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Invoice_Coin]  WITH CHECK ADD FOREIGN KEY([MPId])
REFERENCES [dbo].[Methods_Payment] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Invoice_Product]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Invoice_Product]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD CHECK  (([Downloads]>=(0)))
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD CHECK  (([Likes]>=(0)))
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD CHECK  (([Price]>=(0)))
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD CHECK  (([Views]>=(0)))
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD CHECK  (([BirthDay]<getdate()))
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD CHECK  (([Coin]>=(0)))
GO
USE [master]
GO
ALTER DATABASE [Webtailieu] SET  READ_WRITE 
GO
