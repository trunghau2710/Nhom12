USE [master]
GO
/****** Object:  Database [Webtailieu]    Script Date: 4/22/2024 1:31:35 PM ******/
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
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 4/22/2024 1:31:35 PM ******/
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
/****** Object:  Table [dbo].[AdminUser]    Script Date: 4/22/2024 1:31:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Email] [varchar](255) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[Role] [varchar](50) NULL,
	[Avatar] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 4/22/2024 1:31:35 PM ******/
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
/****** Object:  Table [dbo].[Comment]    Script Date: 4/22/2024 1:31:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[productId] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[Content] [ntext] NULL,
	[TimeCreate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice_Coin]    Script Date: 4/22/2024 1:31:35 PM ******/
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
/****** Object:  Table [dbo].[Invoice_Product]    Script Date: 4/22/2024 1:31:35 PM ******/
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
/****** Object:  Table [dbo].[Methods_Payment]    Script Date: 4/22/2024 1:31:35 PM ******/
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
/****** Object:  Table [dbo].[Product]    Script Date: 4/22/2024 1:31:35 PM ******/
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
/****** Object:  Table [dbo].[Report]    Script Date: 4/22/2024 1:31:35 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 4/22/2024 1:31:35 PM ******/
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
SET IDENTITY_INSERT [dbo].[AdminUser] ON 

INSERT [dbo].[AdminUser] ([Id], [Name], [Email], [Password], [Role], [Avatar]) VALUES (6, N'Admin', N'admin@gmail.com', N'6E-D5-83-3C-F3-52-86-EB-F8-66-2B-7B-59-49-F0-D7-42-BB-EC-3F', N'Admin', NULL)
SET IDENTITY_INSERT [dbo].[AdminUser] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [Name], [NumberOfProduct], [Image]) VALUES (1, N'Điện tử', 10, NULL)
INSERT [dbo].[Category] ([Id], [Name], [NumberOfProduct], [Image]) VALUES (2, N'Khoa Học - Công Nghệ', 2, N'/Images/Thong tin truyen.png')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([Id], [productId], [userId], [Content], [TimeCreate]) VALUES (3, 13, 1, N'Comment 1', CAST(N'2024-04-21' AS Date))
INSERT [dbo].[Comment] ([Id], [productId], [userId], [Content], [TimeCreate]) VALUES (4, 3, 1, N'Tư tuong', CAST(N'2024-04-21' AS Date))
INSERT [dbo].[Comment] ([Id], [productId], [userId], [Content], [TimeCreate]) VALUES (5, 3, 1, N'Hello', CAST(N'2024-04-21' AS Date))
INSERT [dbo].[Comment] ([Id], [productId], [userId], [Content], [TimeCreate]) VALUES (6, 13, 1, N'Wer 
Hello
Vơr', CAST(N'2024-04-21' AS Date))
INSERT [dbo].[Comment] ([Id], [productId], [userId], [Content], [TimeCreate]) VALUES (8, 13, 1, N'Jh
sa
kkk
222
saa.
55 <br>
555', CAST(N'2024-04-21' AS Date))
INSERT [dbo].[Comment] ([Id], [productId], [userId], [Content], [TimeCreate]) VALUES (24, 13, 1, N'000000', CAST(N'2024-04-21' AS Date))
INSERT [dbo].[Comment] ([Id], [productId], [userId], [Content], [TimeCreate]) VALUES (25, 13, 1, N'444', CAST(N'2024-04-21' AS Date))
INSERT [dbo].[Comment] ([Id], [productId], [userId], [Content], [TimeCreate]) VALUES (28, 13, 1, N'000000000000000000000000', CAST(N'2024-04-21' AS Date))
INSERT [dbo].[Comment] ([Id], [productId], [userId], [Content], [TimeCreate]) VALUES (36, 13, 2, N'0000', CAST(N'2024-04-21' AS Date))
INSERT [dbo].[Comment] ([Id], [productId], [userId], [Content], [TimeCreate]) VALUES (46, 13, 2, N'aaaaaaaaaaaaaaaaaaaaaaa', CAST(N'2024-04-22' AS Date))
SET IDENTITY_INSERT [dbo].[Comment] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [File], [FileImage], [TimeCreate], [TimePost], [TypeFile], [CategoryId], [UserId], [Views], [Downloads], [Likes], [Status]) VALUES (2, N'Tam Ly Hoc 3', N'jjj', 123, N'/file/Nội dung tóm tắt tuần 2.docx', N'/Images/1835326728.jpg', CAST(N'2024-04-07T18:34:46.000' AS DateTime), CAST(N'2024-04-22T13:26:56.887' AS DateTime), NULL, 1, 1, 7602, 352, 886, N'Confirmed')
INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [File], [FileImage], [TimeCreate], [TimePost], [TypeFile], [CategoryId], [UserId], [Views], [Downloads], [Likes], [Status]) VALUES (3, N'Tam Ly Hoc', N'123', 0, N'/file/Báo-cáo-tuần-3.docx', N'/Images/1835326728.jpg', CAST(N'2024-04-08T02:34:23.777' AS DateTime), CAST(N'2024-04-08T02:34:38.253' AS DateTime), N'.docx', 1, 1, 8637, 402, 20, N'Confirmed')
INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [File], [FileImage], [TimeCreate], [TimePost], [TypeFile], [CategoryId], [UserId], [Views], [Downloads], [Likes], [Status]) VALUES (4, N'Tam Ly Hoc 1', N'000', 0, N'/file/Báo-cáo-tuần-3.docx', N'/Images/Index.png', CAST(N'2024-04-08T13:12:35.787' AS DateTime), CAST(N'2024-04-08T13:12:43.510' AS DateTime), N'.docx', 1, 1, 3507, 128, 671, N'Confirmed')
INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [File], [FileImage], [TimeCreate], [TimePost], [TypeFile], [CategoryId], [UserId], [Views], [Downloads], [Likes], [Status]) VALUES (8, N'Tai Lieu Bach Khoa', N's', 0, N'/file/course-v1_HUTECH+ML_NDD0010876_POS105_N26+HK2A-2023-2024-members-638472339020576397-course-v1_HUTECH+ML_NDD0010876_POS105_N26+HK2A-2023-2024.pdf', N'/Images/depositphotos_652763588-stock-photo-one-man-young-adult-caucasian.jpg', CAST(N'2024-04-11T23:43:26.167' AS DateTime), CAST(N'2024-04-18T01:09:37.413' AS DateTime), N'.pdf', 2, 1, 4534, 183, 752, N'Confirmed')
INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [File], [FileImage], [TimeCreate], [TimePost], [TypeFile], [CategoryId], [UserId], [Views], [Downloads], [Likes], [Status]) VALUES (9, N'Reload_product(1);', N'1', 10, N'/file/Phieu-theo-doi-tien-doDACS.doc', N'/Images/b75ad619d59762d999a9c340a2590bfc.jpg', CAST(N'2024-04-18T01:09:24.320' AS DateTime), CAST(N'2024-04-18T01:09:44.833' AS DateTime), N'.doc', 1, 1, 8509, 428, 550, N'Confirmed')
INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [File], [FileImage], [TimeCreate], [TimePost], [TypeFile], [CategoryId], [UserId], [Views], [Downloads], [Likes], [Status]) VALUES (10, N'Reload_product(2);', N'2', 0, N'/file/Nội-dung-tóm-tắt-tuần-4_Nguyễn-Lộc-Xuân-Sang_7959.docx', N'/Images/ed0e10a0f37f24c6d8a621ce276a5b8a.jpg', CAST(N'2024-04-18T01:10:51.170' AS DateTime), CAST(N'2024-04-18T01:10:56.793' AS DateTime), N'.docx', 1, 1, 9295, 94, 932, N'Confirmed')
INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [File], [FileImage], [TimeCreate], [TimePost], [TypeFile], [CategoryId], [UserId], [Views], [Downloads], [Likes], [Status]) VALUES (11, N'Reload_product(3);', N'3', 0, N'/file/Nội-dung-tóm-tắt-tuần-4.docx', N'/Images/48d2088a53accec1ef38d5f736de56d9.jpg', CAST(N'2024-04-18T01:11:35.517' AS DateTime), CAST(N'2024-04-18T01:11:44.820' AS DateTime), N'.docx', 1, 1, 5135, 387, 259, N'Confirmed')
INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [File], [FileImage], [TimeCreate], [TimePost], [TypeFile], [CategoryId], [UserId], [Views], [Downloads], [Likes], [Status]) VALUES (12, N' Sử dụng Callback:', N'as', 0, N'/file/[CMP376] Giáo trình HP Thực hành Lập trình we_12b.docx', N'/Images/71e8c4cff047f32b6edcef32c87de79_124.jpg', CAST(N'2024-04-18T01:42:31.593' AS DateTime), CAST(N'2024-04-18T01:42:36.310' AS DateTime), N'.docx', 1, 1, 4647, 352, 929, N'Confirmed')
INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [File], [FileImage], [TimeCreate], [TimePost], [TypeFile], [CategoryId], [UserId], [Views], [Downloads], [Likes], [Status]) VALUES (13, N'Lap Trinh Web', N'Huong dan ky thuat lap trinh ưweb', 0, N'/file/Lab0_133.WebBanVali Core MVC5 (Sanpham&ChitietSP).pdf', N'/Images/48d2088a53accec1ef38d5f736de56d_139.jpg', CAST(N'2024-04-19T12:11:48.980' AS DateTime), CAST(N'2024-04-19T12:11:54.123' AS DateTime), N'.pdf', 1, 1, 1543, 21, 569, N'Confirmed')
INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [File], [FileImage], [TimeCreate], [TimePost], [TypeFile], [CategoryId], [UserId], [Views], [Downloads], [Likes], [Status]) VALUES (14, N'Lap Trinh Web1 ', N'Ko co gi', 0, N'/file/DEMO CÔNG CỤ THIẾT KẾ GIAO DIỆN_14.docx', N'/Images/index_1_14.png', CAST(N'2024-04-22T10:59:41.797' AS DateTime), CAST(N'2024-04-22T11:52:34.920' AS DateTime), N'.docx', 1, 1, 9889, 434, 2, N'Confirmed')
INSERT [dbo].[Product] ([Id], [Name], [Description], [Price], [File], [FileImage], [TimeCreate], [TimePost], [TypeFile], [CategoryId], [UserId], [Views], [Downloads], [Likes], [Status]) VALUES (15, N'Tam Ly Hoc 1', N'Test', 15, N'/file/Lab0_133_15.WebBanVali Core MVC5 (Sanpham&ChitietSP).pdf', N'/Images/Thiết kế trang chủ web tài liệu (figma)_15.png', CAST(N'2024-04-22T13:08:22.110' AS DateTime), CAST(N'2024-04-22T13:08:30.030' AS DateTime), N'.pdf', 2, 1, 1332, 486, 569, N'Confirmed')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [Name], [Email], [Password], [Role], [Avatar], [BirthDay], [Coin]) VALUES (1, N'Admin', N'admin@gmail.com', N'123456', N'admin', NULL, CAST(N'2020-11-12T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[User] ([Id], [Name], [Email], [Password], [Role], [Avatar], [BirthDay], [Coin]) VALUES (2, N'Ly Trung Hau', N'user@gmail.com', N'E1-8D-B2-8D-D5-CB-56-DF-AE-D1-2A-2E-FB-BD-DD-1C-E5-E8-00-6B', N'user', NULL, CAST(N'2003-01-01T00:00:00.000' AS DateTime), 10)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__AdminUse__A9D105346F58C6DD]    Script Date: 4/22/2024 1:31:35 PM ******/
ALTER TABLE [dbo].[AdminUser] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__User__A9D105348203CF45]    Script Date: 4/22/2024 1:31:35 PM ******/
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
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([Id])
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
