USE [master]
GO
/****** Object:  Database [ShowroomAudi]    Script Date: 12/9/2019 9:02:04 AM ******/
CREATE DATABASE [ShowroomAudi]
 CONTAINMENT = NONE
GO
ALTER DATABASE [ShowroomAudi] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ShowroomAudi].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ShowroomAudi] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ShowroomAudi] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ShowroomAudi] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ShowroomAudi] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ShowroomAudi] SET ARITHABORT OFF 
GO
ALTER DATABASE [ShowroomAudi] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ShowroomAudi] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ShowroomAudi] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ShowroomAudi] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ShowroomAudi] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ShowroomAudi] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ShowroomAudi] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ShowroomAudi] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ShowroomAudi] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ShowroomAudi] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ShowroomAudi] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ShowroomAudi] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ShowroomAudi] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ShowroomAudi] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ShowroomAudi] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ShowroomAudi] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ShowroomAudi] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ShowroomAudi] SET RECOVERY FULL 
GO
ALTER DATABASE [ShowroomAudi] SET  MULTI_USER 
GO
ALTER DATABASE [ShowroomAudi] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ShowroomAudi] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ShowroomAudi] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ShowroomAudi] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ShowroomAudi] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ShowroomAudi', N'ON'
GO
ALTER DATABASE [ShowroomAudi] SET QUERY_STORE = OFF
GO
USE [ShowroomAudi]
GO
/****** Object:  Schema [Employee]    Script Date: 12/9/2019 9:02:04 AM ******/
CREATE SCHEMA [Employee]
GO
/****** Object:  Schema [Production]    Script Date: 12/9/2019 9:02:04 AM ******/
CREATE SCHEMA [Production]
GO
/****** Object:  Schema [Sales]    Script Date: 12/9/2019 9:02:04 AM ******/
CREATE SCHEMA [Sales]
GO
/****** Object:  UserDefinedFunction [dbo].[fnLayDaBan]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy thuộc tính đã bán trong kho xe----------*/
CREATE FUNCTION [dbo].[fnLayDaBan](@machiec nvarchar(10)) RETURNS nvarchar(10)
BEGIN
	RETURN (SELECT DaBan
			FROM Production.KhoXe WHERE MaChiec = @machiec)
END;
GO
/****** Object:  UserDefinedFunction [dbo].[fnLayGiaBaoHiem]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy giá bảo hiểm----------*/
CREATE FUNCTION [dbo].[fnLayGiaBaoHiem](@mabaohiem nvarchar(10)) RETURNS money
BEGIN
	RETURN (SELECT GiaBaoHiem
			FROM Sales.BaoHiem WHERE MaBH = @mabaohiem)
END;
GO
/****** Object:  UserDefinedFunction [dbo].[fnLayGiaTienXe]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy giá xe----------*/
CREATE FUNCTION [dbo].[fnLayGiaTienXe](@machiec nvarchar(10)) RETURNS money
BEGIN
	RETURN (SELECT TOP 1 GiaXe
			FROM Production.Xe AS x JOIN Production.KhoXe AS kx ON x.MaXe = kx.MaXe
			WHERE MaChiec = @machiec)
END;
GO
/****** Object:  UserDefinedFunction [dbo].[fnLayMaChiec]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	


------------------------------BÁN HÀNG------------------------------
/*----------Lấy mã chiếc----------*/
CREATE FUNCTION [dbo].[fnLayMaChiec](@maxe nvarchar(10)) RETURNS nvarchar(10)
BEGIN
	RETURN (SELECT TOP 1 MaChiec
			FROM Production.KhoXe WHERE MaXe = @maxe AND DaBan = N'Còn hàng')
END;
GO
/****** Object:  UserDefinedFunction [dbo].[fnLayMaXe]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy mã xe----------*/
CREATE FUNCTION [dbo].[fnLayMaXe](@machiec nvarchar(10)) RETURNS nvarchar(10)
BEGIN
	RETURN (SELECT MaXe
			FROM Production.KhoXe WHERE MaChiec = @machiec)
END;
GO
/****** Object:  UserDefinedFunction [dbo].[fnLayTenGoiBaoHiem]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy tên gói bảo hiểm----------*/
CREATE FUNCTION [dbo].[fnLayTenGoiBaoHiem](@mabaohiem nvarchar(10)) RETURNS nvarchar(60)
BEGIN
	RETURN (SELECT GoiBaoHiem
			FROM Sales.BaoHiem WHERE MaBH = @mabaohiem)
END;
GO
/****** Object:  UserDefinedFunction [dbo].[fnLayTenNhanVien]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy tên nhân viên----------*/
CREATE FUNCTION [dbo].[fnLayTenNhanVien](@manv nvarchar(10)) RETURNS nvarchar(60)
BEGIN
	RETURN (SELECT HoTen
			FROM Employee.NhanSu WHERE MaNV = @manv)
END;
GO
/****** Object:  UserDefinedFunction [dbo].[fnLayTenSanPham]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy tên sản phẩm----------*/
CREATE FUNCTION [dbo].[fnLayTenSanPham](@machiec nvarchar(10)) RETURNS nvarchar(60)
BEGIN
	RETURN (SELECT TenXe
			FROM Production.Xe AS x JOIN Production.KhoXe AS kx ON x.MaXe = kx.MaXe
			WHERE MaChiec = @machiec)
END;
GO
/****** Object:  Table [Sales].[BaoHiem]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[BaoHiem](
	[MaBH] [nvarchar](10) NOT NULL,
	[GoiBaoHiem] [nvarchar](60) NOT NULL,
	[GiaBaoHiem] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaBH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vBaoHiem]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy thuộc tính mã bảo hiểm, tên bảo hiểm----------*/
CREATE VIEW [dbo].[vBaoHiem]
AS
	SELECT MaBH, GoiBaoHiem
	FROM Sales.BaoHiem
GO
/****** Object:  Table [Employee].[NhanSu]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Employee].[NhanSu](
	[MaNV] [nvarchar](10) NOT NULL,
	[HoTen] [nvarchar](60) NOT NULL,
	[HinhAnh] [nvarchar](100) NULL,
	[GioiTinh] [nvarchar](4) NOT NULL,
	[ChucVu] [nvarchar](20) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[DiaChi] [nvarchar](60) NOT NULL,
	[SDT] [nvarchar](10) NOT NULL,
	[Luong] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vNhanSu]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy thuộc tính mã nhân viên, tên nhân viên----------*/
CREATE VIEW [dbo].[vNhanSu]
AS
	SELECT MaNV, HoTen
	FROM Employee.NhanSu
GO
/****** Object:  Table [Employee].[DangNhap]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Employee].[DangNhap](
	[UserName] [nvarchar](10) NOT NULL,
	[Pass] [nvarchar](20) NOT NULL,
	[ChucVu] [nvarchar](20) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Employee].[PhanCong]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Employee].[PhanCong](
	[MaNV] [nvarchar](10) NOT NULL,
	[NgayBatDauLam] [datetime] NOT NULL,
	[NgayKetThuc] [datetime] NOT NULL,
	[CaLam] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_PhanCong] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC,
	[NgayBatDauLam] ASC,
	[NgayKetThuc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Production].[KhoXe]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[KhoXe](
	[MaChiec] [nvarchar](10) NOT NULL,
	[MaXe] [nvarchar](10) NOT NULL,
	[DaBan] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChiec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Production].[PhuTung]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[PhuTung](
	[MaPhuTung] [nvarchar](10) NOT NULL,
	[LoaiPhuTung] [nvarchar](100) NOT NULL,
	[TenPhuTung] [nvarchar](100) NOT NULL,
	[SoLuong] [int] NOT NULL,
	[GiaPhuTung] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhuTung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Production].[Xe]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[Xe](
	[MaXe] [nvarchar](10) NOT NULL,
	[KieuXe] [nvarchar](60) NOT NULL,
	[TenXe] [nvarchar](60) NOT NULL,
	[HinhAnh] [nvarchar](100) NULL,
	[SoLuong] [int] NOT NULL,
	[Mau] [nvarchar](20) NOT NULL,
	[LoaiDongCo] [nvarchar](60) NOT NULL,
	[MaLuc] [int] NOT NULL,
	[MomenXoan] [int] NOT NULL,
	[TocDoToiDa] [nvarchar](60) NOT NULL,
	[SuTangToc] [nvarchar](20) NOT NULL,
	[NgayNhap] [date] NOT NULL,
	[GiaXe] [money] NOT NULL,
	[MaGiamGia] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaXe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Sales].[BaoTri]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[BaoTri](
	[MaBaoTri] [nvarchar](10) NOT NULL,
	[MaPhuTung] [nvarchar](10) NULL,
	[DongCo] [nvarchar](5) NULL,
	[HeThongDanhLua] [nvarchar](5) NULL,
	[GamVaThanXe] [nvarchar](5) NULL,
	[CapDo] [int] NULL,
	[ThoiGianHenLay] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaBaoTri] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Sales].[ChiTietHopDong]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[ChiTietHopDong](
	[MaHD] [nvarchar](10) NOT NULL,
	[MaChiec] [nvarchar](10) NOT NULL,
	[MaBH] [nvarchar](10) NOT NULL,
	[ThoiHanBaoHiem] [nvarchar](10) NOT NULL,
	[MaBaoTri] [nvarchar](10) NULL,
 CONSTRAINT [PK_ChiTietHopDong] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC,
	[MaChiec] ASC,
	[MaBH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Sales].[GiamGia]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[GiamGia](
	[MaGiamGia] [nvarchar](10) NOT NULL,
	[PhanTramGiam] [decimal](18, 0) NOT NULL,
	[NgayBatDau] [date] NOT NULL,
	[NgayKetThuc] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaGiamGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Sales].[HoaDon]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[HoaDon](
	[MaHoaDon] [nvarchar](10) NOT NULL,
	[MaHD] [nvarchar](10) NOT NULL,
	[ThanhTien] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHoaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Sales].[HopDong]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[HopDong](
	[MaHD] [nvarchar](10) NOT NULL,
	[MaKH] [int] NOT NULL,
	[MaNV] [nvarchar](10) NOT NULL,
	[TongGiaTien] [money] NOT NULL,
	[NgayLapHD] [date] NOT NULL,
	[NgayHetHan] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Sales].[KhachHang]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[KhachHang](
	[MaKH] [int] IDENTITY(1,1) NOT NULL,
	[HoTen] [nvarchar](60) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[SoCMND] [nvarchar](12) NOT NULL,
	[SDT] [nvarchar](10) NOT NULL,
	[DiaChi] [nvarchar](60) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Sales].[XeBaoTri]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[XeBaoTri](
	[MaBaoTri] [nvarchar](10) NOT NULL,
	[MaChiec] [nvarchar](10) NOT NULL,
	[MaKH] [int] NOT NULL
) ON [PRIMARY]
GO
INSERT [Employee].[DangNhap] ([UserName], [Pass], [ChucVu]) VALUES (N'17110184', N'QL1234', N'Quản lý')
INSERT [Employee].[DangNhap] ([UserName], [Pass], [ChucVu]) VALUES (N'17110124', N'NV1234', N'Nhân viên bán hàng')
INSERT [Employee].[DangNhap] ([UserName], [Pass], [ChucVu]) VALUES (N'17110214', N'NV1234', N'Nhân viên bán hàng')
INSERT [Employee].[DangNhap] ([UserName], [Pass], [ChucVu]) VALUES (N'17110134', N'NV1234', N'Lễ tân')
INSERT [Employee].[DangNhap] ([UserName], [Pass], [ChucVu]) VALUES (N'17110160', N'NV1234', N'Cố vấn dịch vụ')
INSERT [Employee].[DangNhap] ([UserName], [Pass], [ChucVu]) VALUES (N'17110164', N'NV1234', N'Kỹ thuật viên')
INSERT [Employee].[DangNhap] ([UserName], [Pass], [ChucVu]) VALUES (N'17110105', N'NV1234', N'Kỹ thuật viên')
INSERT [Employee].[DangNhap] ([UserName], [Pass], [ChucVu]) VALUES (N'17110227', N'NV1234', N'Kế toán')
INSERT [Employee].[DangNhap] ([UserName], [Pass], [ChucVu]) VALUES (N'17110114', N'NV1234', N'Quản lý kho')
INSERT [Employee].[NhanSu] ([MaNV], [HoTen], [HinhAnh], [GioiTinh], [ChucVu], [NgaySinh], [DiaChi], [SDT], [Luong]) VALUES (N'17110105', N'Trần Bình Cơ', NULL, N'Nam', N'Kỹ thuật viên', CAST(N'1999-07-16' AS Date), N'35 Đường Đặng Văn Bi Quận Thủ Đức', N'0340389422', 50000000.0000)
INSERT [Employee].[NhanSu] ([MaNV], [HoTen], [HinhAnh], [GioiTinh], [ChucVu], [NgaySinh], [DiaChi], [SDT], [Luong]) VALUES (N'17110114', N'Nguyễn Văn Khoa', NULL, N'Nam', N'Quản lý kho', CAST(N'1999-01-01' AS Date), N'45A Đường Số 8 Quận Thủ Đức', N'0814482349', 20000000.0000)
INSERT [Employee].[NhanSu] ([MaNV], [HoTen], [HinhAnh], [GioiTinh], [ChucVu], [NgaySinh], [DiaChi], [SDT], [Luong]) VALUES (N'17110124', N'Nguyễn Thể Đoàn', NULL, N'Nam', N'Nhân viên bán hàng', CAST(N'1999-05-29' AS Date), N'15A Đường Đặng Văn Bi Quận Thủ Đức', N'0813424859', 30000000.0000)
INSERT [Employee].[NhanSu] ([MaNV], [HoTen], [HinhAnh], [GioiTinh], [ChucVu], [NgaySinh], [DiaChi], [SDT], [Luong]) VALUES (N'17110134', N'Võ Nguyễn Minh Hiền', NULL, N'Nữ', N'Lễ tân', CAST(N'1999-05-24' AS Date), N'325 Đường Trường Chinh Quận 12', N'0261739428', 20000000.0000)
INSERT [Employee].[NhanSu] ([MaNV], [HoTen], [HinhAnh], [GioiTinh], [ChucVu], [NgaySinh], [DiaChi], [SDT], [Luong]) VALUES (N'17110160', N'Lâm Gia Khánh', NULL, N'Nam', N'Cố vấn dịch vụ', CAST(N'1999-12-27' AS Date), N'16D Đường Nguyễn Thị Huỳnh Quận Phú Nhuận', N'0856681237', 25000000.0000)
INSERT [Employee].[NhanSu] ([MaNV], [HoTen], [HinhAnh], [GioiTinh], [ChucVu], [NgaySinh], [DiaChi], [SDT], [Luong]) VALUES (N'17110164', N'Nguyễn Hữu Huân', NULL, N'Nam', N'Kỹ thuật viên', CAST(N'1999-03-19' AS Date), N'67 Đường Linh Trung Quận Thủ Đức', N'0283119248', 50000000.0000)
INSERT [Employee].[NhanSu] ([MaNV], [HoTen], [HinhAnh], [GioiTinh], [ChucVu], [NgaySinh], [DiaChi], [SDT], [Luong]) VALUES (N'17110184', N'Nguyễn Thị Xuân Mai', NULL, N'Nữ', N'Quản lý', CAST(N'1999-06-23' AS Date), N'30B Đường Số 3 Quận Thủ Đức', N'0817882173', 50000000.0000)
INSERT [Employee].[NhanSu] ([MaNV], [HoTen], [HinhAnh], [GioiTinh], [ChucVu], [NgaySinh], [DiaChi], [SDT], [Luong]) VALUES (N'17110189', N'Đoàn Hữu Hùng', NULL, N'Nam', N'Bảo vệ', CAST(N'1999-02-01' AS Date), N'78C Đường Số 6 Quận Thủ Đức', N'0167038459', 10000000.0000)
INSERT [Employee].[NhanSu] ([MaNV], [HoTen], [HinhAnh], [GioiTinh], [ChucVu], [NgaySinh], [DiaChi], [SDT], [Luong]) VALUES (N'17110214', N'Tôn Nữ Như Quỳnh', NULL, N'Nữ', N'Nhân viên bán hàng', CAST(N'1999-06-12' AS Date), N'60A Lý Chính Thắng Quận Quận 3', N'0167463871', 30000000.0000)
INSERT [Employee].[NhanSu] ([MaNV], [HoTen], [HinhAnh], [GioiTinh], [ChucVu], [NgaySinh], [DiaChi], [SDT], [Luong]) VALUES (N'17110227', N'Nguyễn Thái Phương Thảo', NULL, N'Nữ', N'Kế toán', CAST(N'1999-08-10' AS Date), N'168 Đường Đặng Văn Bi Quận Thủ Đức', N'0374297781', 15000000.0000)
INSERT [Employee].[PhanCong] ([MaNV], [NgayBatDauLam], [NgayKetThuc], [CaLam]) VALUES (N'17110105', CAST(N'2019-10-13T00:00:00.000' AS DateTime), CAST(N'2019-10-20T00:00:00.000' AS DateTime), N'Ca 2')
INSERT [Employee].[PhanCong] ([MaNV], [NgayBatDauLam], [NgayKetThuc], [CaLam]) VALUES (N'17110114', CAST(N'2019-10-13T00:00:00.000' AS DateTime), CAST(N'2019-10-20T00:00:00.000' AS DateTime), N'Full')
INSERT [Employee].[PhanCong] ([MaNV], [NgayBatDauLam], [NgayKetThuc], [CaLam]) VALUES (N'17110124', CAST(N'2019-10-13T00:00:00.000' AS DateTime), CAST(N'2019-10-20T00:00:00.000' AS DateTime), N'Ca 1')
INSERT [Employee].[PhanCong] ([MaNV], [NgayBatDauLam], [NgayKetThuc], [CaLam]) VALUES (N'17110134', CAST(N'2019-10-13T00:00:00.000' AS DateTime), CAST(N'2019-10-20T00:00:00.000' AS DateTime), N'Full')
INSERT [Employee].[PhanCong] ([MaNV], [NgayBatDauLam], [NgayKetThuc], [CaLam]) VALUES (N'17110160', CAST(N'2019-10-13T00:00:00.000' AS DateTime), CAST(N'2019-10-20T00:00:00.000' AS DateTime), N'Full')
INSERT [Employee].[PhanCong] ([MaNV], [NgayBatDauLam], [NgayKetThuc], [CaLam]) VALUES (N'17110164', CAST(N'2019-10-13T00:00:00.000' AS DateTime), CAST(N'2019-10-20T00:00:00.000' AS DateTime), N'Ca 1')
INSERT [Employee].[PhanCong] ([MaNV], [NgayBatDauLam], [NgayKetThuc], [CaLam]) VALUES (N'17110189', CAST(N'2019-10-13T00:00:00.000' AS DateTime), CAST(N'2019-10-20T00:00:00.000' AS DateTime), N'Full')
INSERT [Employee].[PhanCong] ([MaNV], [NgayBatDauLam], [NgayKetThuc], [CaLam]) VALUES (N'17110214', CAST(N'2019-10-13T00:00:00.000' AS DateTime), CAST(N'2019-10-20T00:00:00.000' AS DateTime), N'Ca 2')
INSERT [Employee].[PhanCong] ([MaNV], [NgayBatDauLam], [NgayKetThuc], [CaLam]) VALUES (N'17110227', CAST(N'2019-10-13T00:00:00.000' AS DateTime), CAST(N'2019-10-20T00:00:00.000' AS DateTime), N'Full')
INSERT [Production].[KhoXe] ([MaChiec], [MaXe], [DaBan]) VALUES (N'SSA3B1', N'SSA3B', N'Đã bán')
INSERT [Production].[KhoXe] ([MaChiec], [MaXe], [DaBan]) VALUES (N'SSA3B2', N'SSA3B', N'Đã bán')
INSERT [Production].[KhoXe] ([MaChiec], [MaXe], [DaBan]) VALUES (N'SSA4B1', N'SSA4B', N'Đã bán')
INSERT [Production].[KhoXe] ([MaChiec], [MaXe], [DaBan]) VALUES (N'SSA4B2', N'SSA4B', N'Đã bán')
INSERT [Production].[KhoXe] ([MaChiec], [MaXe], [DaBan]) VALUES (N'SSRS5B1', N'SSRS5B', N'Đã bán')
INSERT [Production].[KhoXe] ([MaChiec], [MaXe], [DaBan]) VALUES (N'SSRS5B2', N'SSRS5B', N'Đã bán')
INSERT [Production].[PhuTung] ([MaPhuTung], [LoaiPhuTung], [TenPhuTung], [SoLuong], [GiaPhuTung]) VALUES (N'BN', N'Hệ thống làm mát, nhiên liệu', N'Bơm nước', 5, 2000000.0000)
INSERT [Production].[PhuTung] ([MaPhuTung], [LoaiPhuTung], [TenPhuTung], [SoLuong], [GiaPhuTung]) VALUES (N'CB', N'Hệ thống điện, điều hòa', N'Cảm biến', 6, 3000000.0000)
INSERT [Production].[PhuTung] ([MaPhuTung], [LoaiPhuTung], [TenPhuTung], [SoLuong], [GiaPhuTung]) VALUES (N'CX', N'Hệ thống gầm, phanh', N'Càng', 3, 500000.0000)
INSERT [Production].[PhuTung] ([MaPhuTung], [LoaiPhuTung], [TenPhuTung], [SoLuong], [GiaPhuTung]) VALUES (N'MB', N'Hệ thống động cơ, hộp số', N'Mô bin', 10, 5000000.0000)
INSERT [Production].[Xe] ([MaXe], [KieuXe], [TenXe], [HinhAnh], [SoLuong], [Mau], [LoaiDongCo], [MaLuc], [MomenXoan], [TocDoToiDa], [SuTangToc], [NgayNhap], [GiaXe], [MaGiamGia]) VALUES (N'CCA3B', N'Coupes & Convertibles', N'A3 Cabriolet', NULL, 2, N'Black', N'2.0-liter four-cylinder', 184, 221, N'130 mph2', N'6.9 seconds', CAST(N'2018-05-08' AS Date), 902667380.0000, NULL)
INSERT [Production].[Xe] ([MaXe], [KieuXe], [TenXe], [HinhAnh], [SoLuong], [Mau], [LoaiDongCo], [MaLuc], [MomenXoan], [TocDoToiDa], [SuTangToc], [NgayNhap], [GiaXe], [MaGiamGia]) VALUES (N'CCTTSB', N'Coupes & Convertibles', N'TTS Coupe', NULL, 2, N'Black', N'2.0-liter four-cylinder', 288, 280, N'155 mph6', N'4.4 seconds', CAST(N'2018-05-09' AS Date), 1248419153.0000, NULL)
INSERT [Production].[Xe] ([MaXe], [KieuXe], [TenXe], [HinhAnh], [SoLuong], [Mau], [LoaiDongCo], [MaLuc], [MomenXoan], [TocDoToiDa], [SuTangToc], [NgayNhap], [GiaXe], [MaGiamGia]) VALUES (N'SSA3B', N'Sedans & Sportbacks', N'A3 Sedan', NULL, 0, N'Black', N'2.0-liter four-cylinder', 184, 222, N'130 mph8', N'6.6 seconds', CAST(N'2018-05-01' AS Date), 772720405.0000, NULL)
INSERT [Production].[Xe] ([MaXe], [KieuXe], [TenXe], [HinhAnh], [SoLuong], [Mau], [LoaiDongCo], [MaLuc], [MomenXoan], [TocDoToiDa], [SuTangToc], [NgayNhap], [GiaXe], [MaGiamGia]) VALUES (N'SSA4B', N'Sedans & Sportbacks', N'A4', NULL, 0, N'Black', N'2.0-liter four-cylinder', 188, 236, N'130 mph6', N'7.1 seconds', CAST(N'2018-05-02' AS Date), 909628825.0000, NULL)
INSERT [Production].[Xe] ([MaXe], [KieuXe], [TenXe], [HinhAnh], [SoLuong], [Mau], [LoaiDongCo], [MaLuc], [MomenXoan], [TocDoToiDa], [SuTangToc], [NgayNhap], [GiaXe], [MaGiamGia]) VALUES (N'SSA8B', N'Sedans & Sportbacks', N'A8', NULL, 2, N'Black', N'3.0-liter six-cylinder', 335, 369, N'130 mph15', N'5.6 seconds', CAST(N'2018-05-04' AS Date), 1944563663.0000, NULL)
INSERT [Production].[Xe] ([MaXe], [KieuXe], [TenXe], [HinhAnh], [SoLuong], [Mau], [LoaiDongCo], [MaLuc], [MomenXoan], [TocDoToiDa], [SuTangToc], [NgayNhap], [GiaXe], [MaGiamGia]) VALUES (N'SSRS5B', N'Sedans & Sportbacks', N'RS 5 Sportback', NULL, 0, N'Black', N'2.9-liter six-cylinder', 444, 443, N'155 mph/Optional 174 mph8', N'3.8 seconds', CAST(N'2018-05-03' AS Date), 1721797420.0000, NULL)
INSERT [Production].[Xe] ([MaXe], [KieuXe], [TenXe], [HinhAnh], [SoLuong], [Mau], [LoaiDongCo], [MaLuc], [MomenXoan], [TocDoToiDa], [SuTangToc], [NgayNhap], [GiaXe], [MaGiamGia]) VALUES (N'SWA4B', N'SUVs & Wagons', N'A4 allroad', NULL, 2, N'Black', N'2.0-liter four-cylinder', 248, 273, N'130 mph8', N'5.9 seconds', CAST(N'2018-05-05' AS Date), 1060460136.0000, NULL)
INSERT [Production].[Xe] ([MaXe], [KieuXe], [TenXe], [HinhAnh], [SoLuong], [Mau], [LoaiDongCo], [MaLuc], [MomenXoan], [TocDoToiDa], [SuTangToc], [NgayNhap], [GiaXe], [MaGiamGia]) VALUES (N'SWQ7B', N'SUVs & Wagons', N'Q7', NULL, 2, N'Black', N'3.0-liter six-cylinder', 329, 325, N'130 mph2', N'5.7 seconds', CAST(N'2018-05-07' AS Date), 1215932410.0000, NULL)
INSERT [Production].[Xe] ([MaXe], [KieuXe], [TenXe], [HinhAnh], [SoLuong], [Mau], [LoaiDongCo], [MaLuc], [MomenXoan], [TocDoToiDa], [SuTangToc], [NgayNhap], [GiaXe], [MaGiamGia]) VALUES (N'SWSQ5B', N'SUVs & Wagons', N'SQ5', NULL, 2, N'Black', N'3.0-liter six-cylinder', 349, 369, N'155 mph2', N'5.1 seconds', CAST(N'2018-05-06' AS Date), 1215932410.0000, NULL)
INSERT [Sales].[BaoHiem] ([MaBH], [GoiBaoHiem], [GiaBaoHiem]) VALUES (N'BHTNDS', N'Bảo hiểm trách nhiệm dân sự', 30000000.0000)
INSERT [Sales].[BaoHiem] ([MaBH], [GoiBaoHiem], [GiaBaoHiem]) VALUES (N'BHXH', N'Bảo hiểm xe hơi', 50000000.0000)
INSERT [Sales].[BaoHiem] ([MaBH], [GoiBaoHiem], [GiaBaoHiem]) VALUES (N'PBH', N'Phí bảo hiểm', 5000000.0000)
INSERT [Sales].[BaoHiem] ([MaBH], [GoiBaoHiem], [GiaBaoHiem]) VALUES (N'PBTDB', N'Phí bảo trì đường bộ', 30000000.0000)
INSERT [Sales].[BaoTri] ([MaBaoTri], [MaPhuTung], [DongCo], [HeThongDanhLua], [GamVaThanXe], [CapDo], [ThoiGianHenLay]) VALUES (N'BT01', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [Sales].[BaoTri] ([MaBaoTri], [MaPhuTung], [DongCo], [HeThongDanhLua], [GamVaThanXe], [CapDo], [ThoiGianHenLay]) VALUES (N'BT02', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [Sales].[BaoTri] ([MaBaoTri], [MaPhuTung], [DongCo], [HeThongDanhLua], [GamVaThanXe], [CapDo], [ThoiGianHenLay]) VALUES (N'BT03', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [Sales].[BaoTri] ([MaBaoTri], [MaPhuTung], [DongCo], [HeThongDanhLua], [GamVaThanXe], [CapDo], [ThoiGianHenLay]) VALUES (N'BT04', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [Sales].[ChiTietHopDong] ([MaHD], [MaChiec], [MaBH], [ThoiHanBaoHiem], [MaBaoTri]) VALUES (N'HD01', N'SSA3B1', N'BHXH', N'1', N'BT01')
INSERT [Sales].[ChiTietHopDong] ([MaHD], [MaChiec], [MaBH], [ThoiHanBaoHiem], [MaBaoTri]) VALUES (N'HD01', N'SSA3B1', N'PBH', N'1', N'BT01')
INSERT [Sales].[ChiTietHopDong] ([MaHD], [MaChiec], [MaBH], [ThoiHanBaoHiem], [MaBaoTri]) VALUES (N'HD02', N'SSA3B2', N'BHXH', N'1', N'BT02')
INSERT [Sales].[ChiTietHopDong] ([MaHD], [MaChiec], [MaBH], [ThoiHanBaoHiem], [MaBaoTri]) VALUES (N'HD02', N'SSA4B1', N'BHXH', N'1', N'BT02')
INSERT [Sales].[ChiTietHopDong] ([MaHD], [MaChiec], [MaBH], [ThoiHanBaoHiem], [MaBaoTri]) VALUES (N'HD03', N'SSA4B2', N'BHXH', N'1', N'BT03')
INSERT [Sales].[ChiTietHopDong] ([MaHD], [MaChiec], [MaBH], [ThoiHanBaoHiem], [MaBaoTri]) VALUES (N'HD03', N'SSRS5B1', N'BHXH', N'1', N'BT03')
INSERT [Sales].[ChiTietHopDong] ([MaHD], [MaChiec], [MaBH], [ThoiHanBaoHiem], [MaBaoTri]) VALUES (N'HD04', N'SSRS5B2', N'BHXH', N'1', N'BT04')
INSERT [Sales].[ChiTietHopDong] ([MaHD], [MaChiec], [MaBH], [ThoiHanBaoHiem], [MaBaoTri]) VALUES (N'HD04', N'SSRS5B2', N'PBH', N'1', N'BT04')
INSERT [Sales].[HoaDon] ([MaHoaDon], [MaHD], [ThanhTien]) VALUES (N'01', N'HD01', 855492445.5000)
INSERT [Sales].[HoaDon] ([MaHoaDon], [MaHD], [ThanhTien]) VALUES (N'02', N'HD02', 1055591707.5000)
INSERT [Sales].[HoaDon] ([MaHoaDon], [MaHD], [ThanhTien]) VALUES (N'03', N'HD03', 1948977162.0000)
INSERT [Sales].[HopDong] ([MaHD], [MaKH], [MaNV], [TongGiaTien], [NgayLapHD], [NgayHetHan]) VALUES (N'HD01', 4, N'17110227', 777720405.0000, CAST(N'2019-12-08' AS Date), CAST(N'2019-12-08' AS Date))
INSERT [Sales].[HopDong] ([MaHD], [MaKH], [MaNV], [TongGiaTien], [NgayLapHD], [NgayHetHan]) VALUES (N'HD02', 5, N'17110184', 959628825.0000, CAST(N'2019-12-08' AS Date), CAST(N'2019-12-08' AS Date))
INSERT [Sales].[HopDong] ([MaHD], [MaKH], [MaNV], [TongGiaTien], [NgayLapHD], [NgayHetHan]) VALUES (N'HD03', 6, N'17110227', 1771797420.0000, CAST(N'2019-12-08' AS Date), CAST(N'2019-12-08' AS Date))
INSERT [Sales].[HopDong] ([MaHD], [MaKH], [MaNV], [TongGiaTien], [NgayLapHD], [NgayHetHan]) VALUES (N'HD04', 7, N'17110184', 1726797420.0000, CAST(N'2019-12-09' AS Date), CAST(N'2019-12-09' AS Date))
SET IDENTITY_INSERT [Sales].[KhachHang] ON 

INSERT [Sales].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [SoCMND], [SDT], [DiaChi]) VALUES (4, N'A', CAST(N'2019-12-08' AS Date), N'A', N'A', N'A')
INSERT [Sales].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [SoCMND], [SDT], [DiaChi]) VALUES (5, N'A', CAST(N'2019-12-08' AS Date), N'A', N'A', N'A')
INSERT [Sales].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [SoCMND], [SDT], [DiaChi]) VALUES (6, N'A', CAST(N'2019-12-08' AS Date), N'A', N'A', N'A')
INSERT [Sales].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [SoCMND], [SDT], [DiaChi]) VALUES (7, N'A', CAST(N'2019-12-09' AS Date), N'A', N'A', N'A')
SET IDENTITY_INSERT [Sales].[KhachHang] OFF
INSERT [Sales].[XeBaoTri] ([MaBaoTri], [MaChiec], [MaKH]) VALUES (N'BT01', N'SSA3B1', 4)
INSERT [Sales].[XeBaoTri] ([MaBaoTri], [MaChiec], [MaKH]) VALUES (N'BT02', N'SSA4B1', 5)
INSERT [Sales].[XeBaoTri] ([MaBaoTri], [MaChiec], [MaKH]) VALUES (N'BT03', N'SSRS5B1', 6)
INSERT [Sales].[XeBaoTri] ([MaBaoTri], [MaChiec], [MaKH]) VALUES (N'BT04', N'SSRS5B2', 7)
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__DangNhap__C9F2845652FF592C]    Script Date: 12/9/2019 9:02:04 AM ******/
ALTER TABLE [Employee].[DangNhap] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IndexNhanSu_SelectID]    Script Date: 12/9/2019 9:02:04 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IndexNhanSu_SelectID] ON [Employee].[NhanSu]
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IndexNhanSu_SelectName]    Script Date: 12/9/2019 9:02:04 AM ******/
CREATE NONCLUSTERED INDEX [IndexNhanSu_SelectName] ON [Employee].[NhanSu]
(
	[HoTen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__XeBaoTri__51A9CA500006100C]    Script Date: 12/9/2019 9:02:04 AM ******/
ALTER TABLE [Sales].[XeBaoTri] ADD UNIQUE NONCLUSTERED 
(
	[MaBaoTri] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [Employee].[DangNhap]  WITH CHECK ADD  CONSTRAINT [FK_DangNhap_NhanSu] FOREIGN KEY([UserName])
REFERENCES [Employee].[NhanSu] ([MaNV])
GO
ALTER TABLE [Employee].[DangNhap] CHECK CONSTRAINT [FK_DangNhap_NhanSu]
GO
ALTER TABLE [Employee].[PhanCong]  WITH CHECK ADD  CONSTRAINT [FK_PhanCong_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [Employee].[NhanSu] ([MaNV])
GO
ALTER TABLE [Employee].[PhanCong] CHECK CONSTRAINT [FK_PhanCong_NhanVien]
GO
ALTER TABLE [Production].[KhoXe]  WITH CHECK ADD  CONSTRAINT [FK_KhoXe_Xe] FOREIGN KEY([MaXe])
REFERENCES [Production].[Xe] ([MaXe])
GO
ALTER TABLE [Production].[KhoXe] CHECK CONSTRAINT [FK_KhoXe_Xe]
GO
ALTER TABLE [Production].[Xe]  WITH CHECK ADD  CONSTRAINT [FK_Xe_GiamGia] FOREIGN KEY([MaGiamGia])
REFERENCES [Sales].[GiamGia] ([MaGiamGia])
GO
ALTER TABLE [Production].[Xe] CHECK CONSTRAINT [FK_Xe_GiamGia]
GO
ALTER TABLE [Sales].[BaoTri]  WITH CHECK ADD  CONSTRAINT [FK_BaoTri_PhuTung] FOREIGN KEY([MaPhuTung])
REFERENCES [Production].[PhuTung] ([MaPhuTung])
GO
ALTER TABLE [Sales].[BaoTri] CHECK CONSTRAINT [FK_BaoTri_PhuTung]
GO
ALTER TABLE [Sales].[ChiTietHopDong]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHopDong_BaoHiem] FOREIGN KEY([MaBH])
REFERENCES [Sales].[BaoHiem] ([MaBH])
GO
ALTER TABLE [Sales].[ChiTietHopDong] CHECK CONSTRAINT [FK_ChiTietHopDong_BaoHiem]
GO
ALTER TABLE [Sales].[ChiTietHopDong]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHopDong_BaoTri] FOREIGN KEY([MaBaoTri])
REFERENCES [Sales].[BaoTri] ([MaBaoTri])
GO
ALTER TABLE [Sales].[ChiTietHopDong] CHECK CONSTRAINT [FK_ChiTietHopDong_BaoTri]
GO
ALTER TABLE [Sales].[ChiTietHopDong]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHopDong_HopDong] FOREIGN KEY([MaHD])
REFERENCES [Sales].[HopDong] ([MaHD])
GO
ALTER TABLE [Sales].[ChiTietHopDong] CHECK CONSTRAINT [FK_ChiTietHopDong_HopDong]
GO
ALTER TABLE [Sales].[ChiTietHopDong]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHopDong_KhoXe] FOREIGN KEY([MaChiec])
REFERENCES [Production].[KhoXe] ([MaChiec])
GO
ALTER TABLE [Sales].[ChiTietHopDong] CHECK CONSTRAINT [FK_ChiTietHopDong_KhoXe]
GO
ALTER TABLE [Sales].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_HopDong] FOREIGN KEY([MaHD])
REFERENCES [Sales].[HopDong] ([MaHD])
GO
ALTER TABLE [Sales].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_HopDong]
GO
ALTER TABLE [Sales].[HopDong]  WITH CHECK ADD  CONSTRAINT [FK_HopDong_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [Sales].[KhachHang] ([MaKH])
GO
ALTER TABLE [Sales].[HopDong] CHECK CONSTRAINT [FK_HopDong_KhachHang]
GO
ALTER TABLE [Sales].[HopDong]  WITH CHECK ADD  CONSTRAINT [FK_HopDong_NhanSu] FOREIGN KEY([MaNV])
REFERENCES [Employee].[NhanSu] ([MaNV])
GO
ALTER TABLE [Sales].[HopDong] CHECK CONSTRAINT [FK_HopDong_NhanSu]
GO
ALTER TABLE [Sales].[XeBaoTri]  WITH CHECK ADD  CONSTRAINT [FK_XeBaoTri_BaoTri] FOREIGN KEY([MaBaoTri])
REFERENCES [Sales].[BaoTri] ([MaBaoTri])
GO
ALTER TABLE [Sales].[XeBaoTri] CHECK CONSTRAINT [FK_XeBaoTri_BaoTri]
GO
ALTER TABLE [Sales].[XeBaoTri]  WITH CHECK ADD  CONSTRAINT [FK_XeBaoTri_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [Sales].[KhachHang] ([MaKH])
GO
ALTER TABLE [Sales].[XeBaoTri] CHECK CONSTRAINT [FK_XeBaoTri_KhachHang]
GO
/****** Object:  StoredProcedure [dbo].[spBaoHiem_Delete]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Xóa bảo hiểm----------*/
CREATE PROC [dbo].[spBaoHiem_Delete]
	@mabaohiem nvarchar(10)
AS
	DELETE Sales.BaoHiem WHERE MaBH = @mabaohiem;
GO
/****** Object:  StoredProcedure [dbo].[spBaoHiem_Insert]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Thêm bảo hiểm----------*/
CREATE PROC [dbo].[spBaoHiem_Insert]
	@mabaohiem nvarchar(10),
	@goibaohiem nvarchar(60),
	@giabaohiem money
AS
	INSERT INTO Sales.BaoHiem(MaBH, GoiBaoHiem, GiaBaoHiem) VALUES(@mabaohiem, @goibaohiem, @giabaohiem);
GO
/****** Object:  StoredProcedure [dbo].[spBaoHiem_SelectAll]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy danh sách bảo hiểm----------*/
CREATE PROC [dbo].[spBaoHiem_SelectAll]
AS
	SELECT * FROM Sales.BaoHiem
GO
/****** Object:  StoredProcedure [dbo].[spBaoHiem_Update]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Sửa thông tin bảo hiểm----------*/
CREATE PROC [dbo].[spBaoHiem_Update]
	@mabaohiem nvarchar(10),
	@goibaohiem nvarchar(60),
	@giabaohiem money
AS
	UPDATE Sales.BaoHiem SET GoiBaoHiem = @goibaohiem, GiaBaoHiem = @giabaohiem
	WHERE MaBH = @mabaohiem;
GO
/****** Object:  StoredProcedure [dbo].[spBaoTri_Delete]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Xóa bảo trì----------*/
CREATE PROC [dbo].[spBaoTri_Delete]
	@mabaotri nvarchar(10)
AS
	DELETE Sales.BaoTri WHERE MaBaoTri = @mabaotri;
GO
/****** Object:  StoredProcedure [dbo].[spBaoTri_InsertID]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Thêm mã bảo trì----------*/
CREATE PROC [dbo].[spBaoTri_InsertID]
	@mabaotri nvarchar(10)
AS
	INSERT INTO Sales.BaoTri(MaBaoTri) VALUES(@mabaotri);
GO
/****** Object:  StoredProcedure [dbo].[spBaoTri_SelectAll]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy danh sách bảo trì----------*/
CREATE PROC [dbo].[spBaoTri_SelectAll]
AS
	SELECT * FROM Sales.BaoTri
GO
/****** Object:  StoredProcedure [dbo].[spBaoTri_Update]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Cập nhật mã bảo trì----------*/
CREATE PROC [dbo].[spBaoTri_Update]
	@mabaotri nvarchar(10),
	@maphutung nvarchar(10),
	@dongco nvarchar(5),
	@hethongdanhlua nvarchar(5),
	@gamvathanxe nvarchar(5),
	@capdo int,
	@thoigianhenlay date
AS
	UPDATE Sales.BaoTri SET MaPhuTung = @maphutung, DongCo = @dongco, HeThongDanhLua = @hethongdanhlua, GamVaThanXe = @gamvathanxe, CapDo = @capdo, ThoiGianHenLay = @thoigianhenlay
	WHERE MaBaoTri = @mabaotri;
GO
/****** Object:  StoredProcedure [dbo].[spChiTietHD_Insert]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Thêm chi tiết hợp đồng----------*/
CREATE PROC [dbo].[spChiTietHD_Insert]
	@mahopdong nvarchar(10),
	@machiec nvarchar(10),
	@mabaohiem nvarchar(10),
	@thoihanbaohiem nvarchar(10),
	@mabaotri nvarchar(10)
AS
	INSERT INTO Sales.ChiTietHopDong(MaHD, MaChiec, MaBH, ThoiHanBaoHiem, MaBaoTri)
		VALUES(@mahopdong, @machiec, @mabaohiem, @thoihanbaohiem, @mabaotri);
	EXEC [dbo].[spKhoXe_Check] @machiec;
GO
/****** Object:  StoredProcedure [dbo].[spChiTietHD_SelectAll]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy chi tiết hợp đồng----------*/
CREATE PROC [dbo].[spChiTietHD_SelectAll]
AS
	SELECT * FROM Sales.ChiTietHopDong
GO
/****** Object:  StoredProcedure [dbo].[spGiamGia_Delete]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Xóa thông tin giảm giá----------*/
CREATE PROC [dbo].[spGiamGia_Delete]
	@magg nvarchar(10)
AS 
	DELETE Sales.GiamGia WHERE MaGiamGia = @magg;
GO
/****** Object:  StoredProcedure [dbo].[spGiamGia_Insert]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Thêm thông tin giảm giá----------*/
CREATE PROC [dbo].[spGiamGia_Insert]
	@magg nvarchar(10),
	@phantramgiam decimal,
	@ngaybatdau date,
	@ngayketthuc date
AS
	INSERT INTO Sales.GiamGia(MaGiamGia, PhanTramGiam, NgayBatDau, NgayKetThuc)
	VALUES(@magg, @phantramgiam, @ngaybatdau, @ngayketthuc);
GO
/****** Object:  StoredProcedure [dbo].[spGiamGia_SelectAll]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy thông tin giảm giá----------*/
CREATE PROC [dbo].[spGiamGia_SelectAll]
AS
	SELECT * FROM Sales.GiamGia
GO
/****** Object:  StoredProcedure [dbo].[spGiamGia_Update]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Sửa thông tin giảm giá----------*/
CREATE PROC [dbo].[spGiamGia_Update]
	@magg nvarchar(10),
	@phantramgiam decimal,
	@ngaybatdau date,
	@ngayketthuc date
AS
	UPDATE Sales.GiamGia SET MaGiamGia = @magg, PhanTramGiam = @phantramgiam, NgayBatDau = @ngaybatdau, NgayKetThuc = @ngayketthuc
	WHERE MaGiamGia = @magg;
GO
/****** Object:  StoredProcedure [dbo].[spHoaDon_Insert]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Thêm hóa đơn----------*/
CREATE PROC [dbo].[spHoaDon_Insert]
	@mahoadon nvarchar(10),
	@mahopdong nvarchar(10),
	@thanhtien money
AS
	INSERT INTO Sales.HoaDon(MaHoaDon, MaHD, ThanhTien)
		VALUES(@mahoadon, @mahopdong, @thanhtien);
GO
/****** Object:  StoredProcedure [dbo].[spHoaDon_SelectAll]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy hóa đơn----------*/
CREATE PROC [dbo].[spHoaDon_SelectAll]
AS
	SELECT * FROM Sales.HoaDon
GO
/****** Object:  StoredProcedure [dbo].[spHopDong_Insert]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Thêm hợp đồng----------*/
CREATE PROC [dbo].[spHopDong_Insert]
	@mahopdong nvarchar(10),
	@makhachhang int,
	@manhanvien nvarchar(10),
	@tonggiatien money,
	@ngaylaphd date,
	@ngayhethan date
AS
	INSERT INTO Sales.HopDong(MaHD, MaKH, MaNV, TongGiaTien, NgayLapHD, NgayHetHan)
		VALUES(@mahopdong, @makhachhang, @manhanvien, @tonggiatien, @ngaylaphd, @ngayhethan);
GO
/****** Object:  StoredProcedure [dbo].[spHopDong_SelectAll]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy hợp đồng----------*/
CREATE PROC [dbo].[spHopDong_SelectAll]
AS
	SELECT * FROM Sales.HopDong
GO
/****** Object:  StoredProcedure [dbo].[spKhachHang_Delete]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Xóa thông tin khách hàng----------*/
CREATE PROC [dbo].[spKhachHang_Delete]
	@makhachhang int
AS
	DELETE Sales.KhachHang WHERE MaKH = @makhachhang;
GO
/****** Object:  StoredProcedure [dbo].[spKhachHang_Insert]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Thêm khách hàng----------*/
CREATE PROC [dbo].[spKhachHang_Insert]
	@tenkhachhang nvarchar(60),
	@ngaysinh date,
	@socmnd nvarchar(12),
	@sdt nvarchar(10),
	@diachi nvarchar(60)
AS
	INSERT INTO Sales.KhachHang(HoTen, NgaySinh, SoCMND, SDT, DiaChi)
		VALUES(@tenkhachhang, @ngaysinh, @socmnd, @sdt, @diachi);
GO
/****** Object:  StoredProcedure [dbo].[spKhachHang_SelectAll]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy danh sách khách hàng----------*/
CREATE PROC [dbo].[spKhachHang_SelectAll]
AS
	SELECT * FROM Sales.KhachHang
GO
/****** Object:  StoredProcedure [dbo].[spKhachHang_SelectPhone]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy danh sách khách hàng theo SDT----------*/
CREATE PROC [dbo].[spKhachHang_SelectPhone]
	@sdt nvarchar(10)
AS
	SELECT * FROM Sales.KhachHang WHERE SDT = @sdt;
GO
/****** Object:  StoredProcedure [dbo].[spKhachHang_Update]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Sửa thông tin khách hàng----------*/
CREATE PROC [dbo].[spKhachHang_Update]
	@makhachhang int,
	@tenkhachhang nvarchar(60),
	@ngaysinh date,
	@socmnd nvarchar(12),
	@sdt nvarchar(10),
	@diachi nvarchar(60)
AS
	UPDATE Sales.KhachHang SET HoTen = @tenkhachhang, NgaySinh = @ngaysinh, SoCMND = @socmnd, SDT = @sdt, DiaChi = @diachi
	WHERE MaKH = @makhachhang;
GO
/****** Object:  StoredProcedure [dbo].[spKhoXe_Check]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Check đã bán----------*/
CREATE PROC [dbo].[spKhoXe_Check]
	@machiec nvarchar(10)
AS
	DECLARE @daban nvarchar(10);
	SELECT @daban = DaBan FROM Production.KhoXe;
	SET @daban = N'Đã bán';
	UPDATE Production.KhoXe SET DaBan = @daban WHERE MaChiec = @machiec;
GO
/****** Object:  StoredProcedure [dbo].[spKhoXe_Delete]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Xóa xe trong kho----------*/
CREATE PROC [dbo].[spKhoXe_Delete]
	@machiec nvarchar(10)
AS
	DELETE Production.KhoXe WHERE MaChiec = @machiec;
GO
/****** Object:  StoredProcedure [dbo].[spKhoXe_Insert]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Thêm xe vào kho----------*/
CREATE PROC [dbo].[spKhoXe_Insert]
	@machiec nvarchar(10),
	@maxe nvarchar(10)
AS
	INSERT INTO Production.KhoXe(MaChiec, MaXe) VALUES(@machiec, @maxe);
GO
/****** Object:  StoredProcedure [dbo].[spKhoXe_SelectAll]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy kho xe----------*/
CREATE PROC [dbo].[spKhoXe_SelectAll]
AS
	SELECT * FROM Production.KhoXe
GO
/****** Object:  StoredProcedure [dbo].[spKhoXe_Update]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Sửa xe trong kho----------*/
CREATE PROC [dbo].[spKhoXe_Update]
	@machiec nvarchar(10),
	@maxe nvarchar(10)
AS
	UPDATE Production.KhoXe SET MaChiec = @machiec, MaXe = @maxe WHERE MaChiec = @machiec;
GO
/****** Object:  StoredProcedure [dbo].[spLogin]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------STORE PROCEDURE------------------------------
/*----------Lấy chức vụ----------*/
CREATE PROC [dbo].[spLogin]
	@username NVARCHAR(10),
	@pass NVARCHAR (20)
AS
	SELECT ChucVu
	FROM Employee.DangNhap
	WHERE UserName = @username and Pass = @pass;
GO
/****** Object:  StoredProcedure [dbo].[spLogin_Insert]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Thêm tài khoản đăng nhập---------*/
CREATE PROC [dbo].[spLogin_Insert]
	@username nvarchar(10),
	@pass nvarchar(20),
	@chucvu nvarchar(20)
AS
	INSERT INTO Employee.DangNhap(UserName, Pass, ChucVu)
	VALUES (@username, @pass, @chucvu);
GO
/****** Object:  StoredProcedure [dbo].[spLogin_SelectUser]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy Username---------*/
CREATE PROC [dbo].[spLogin_SelectUser]
	@username NVARCHAR(10)
AS
	SELECT * FROM Employee.DangNhap WHERE UserName = @username;
GO
/****** Object:  StoredProcedure [dbo].[spLogin_Update]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Sửa Pass---------*/
CREATE PROC [dbo].[spLogin_Update]
	@username NVARCHAR(10),
	@pass NVARCHAR (20)
AS
	UPDATE Employee.DangNhap SET Pass = @pass WHERE UserName = @username;
GO
/****** Object:  StoredProcedure [dbo].[spNhanSu_Delete]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Xóa nhân viên đã nghỉ làm----------*/
CREATE PROC [dbo].[spNhanSu_Delete]
	@manv nvarchar(10)
AS
	DELETE Employee.NhanSu WHERE MaNV = @manv;
GO
/****** Object:  StoredProcedure [dbo].[spNhanSu_Insert]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Thêm nhân viên---------*/
CREATE PROC [dbo].[spNhanSu_Insert]
	@manv nvarchar(10),
	@hoten nvarchar(60),
	@hinhanh nvarchar(100),
	@gioitinh nvarchar(4),
	@chucvu nvarchar(20),
	@ngaysinh date,
	@diachi nvarchar(60),
	@sdt nvarchar(10),
	@luong money
AS
	INSERT INTO Employee.NhanSu(MaNV, HoTen, HinhAnh, GioiTinh, ChucVu, NgaySinh, DiaChi, SDT, Luong)
	VALUES (@manv, @hoten, @hinhanh, @gioitinh, @chucvu, @ngaysinh, @diachi, @sdt, @luong);
GO
/****** Object:  StoredProcedure [dbo].[spNhanSu_SelectAll]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy danh sách nhân viên----------*/
CREATE PROC [dbo].[spNhanSu_SelectAll]
AS
	SELECT * FROM Employee.NhanSu
GO
/****** Object:  StoredProcedure [dbo].[spNhanSu_SelectID]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy danh sách nhân viên theo ID----------*/
CREATE PROC [dbo].[spNhanSu_SelectID]
	@manv nvarchar(10)
AS
	SELECT * FROM Employee.NhanSu WHERE MaNV = @manv;
GO
/****** Object:  StoredProcedure [dbo].[spNhanSu_SelectName]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy danh sách nhân sự theo tên----------*/
CREATE PROC [dbo].[spNhanSu_SelectName]
	@tennv nvarchar(60)
AS
	SELECT * FROM Employee.NhanSu WHERE HoTen LIKE @tennv + N'%';
GO
/****** Object:  StoredProcedure [dbo].[spNhanSu_Update]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Sửa thông tin nhân viên----------*/
CREATE PROC [dbo].[spNhanSu_Update]
	@manv nvarchar(10),
	@hoten nvarchar(60),
	@hinhanh nvarchar(100),
	@gioitinh nvarchar(4),
	@chucvu nvarchar(20),
	@ngaysinh date,
	@diachi nvarchar(60),
	@sdt nvarchar(10),
	@luong money
AS
	UPDATE Employee.NhanSu SET HoTen = @hoten, HinhAnh = @hinhanh, GioiTinh = @gioitinh, ChucVu = @chucvu, NgaySinh = @ngaysinh, DiaChi = @diachi,
		SDT = @sdt, Luong = @luong
	WHERE MaNV = @manv;
GO
/****** Object:  StoredProcedure [dbo].[spPhanCong_Delete]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Xóa lịch làm việc---------*/
CREATE PROC [dbo].[spPhanCong_Delete]
	@manv nvarchar(10),
	@ngaybatdaulam datetime,
	@ngayketthuc datetime
AS
	DELETE Employee.PhanCong WHERE MaNV = @manv AND NgayBatDauLam = @ngaybatdaulam AND NgayKetThuc = @ngayketthuc;
GO
/****** Object:  StoredProcedure [dbo].[spPhanCong_Insert]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Thêm lịch làm việc---------*/
CREATE PROC [dbo].[spPhanCong_Insert]
	@manv nvarchar(10),
	@ngaybatdaulam datetime,
	@ngayketthuc datetime,
	@calam nvarchar(10)
AS
	INSERT INTO Employee.PhanCong(MaNV, NgayBatDauLam, NgayKetThuc, CaLam)
	VALUES(@manv, @ngaybatdaulam, @ngayketthuc, @calam);
GO
/****** Object:  StoredProcedure [dbo].[spPhanCong_SelectAll]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy lịch làm việc---------*/
CREATE PROC [dbo].[spPhanCong_SelectAll]
AS
	SELECT * FROM Employee.PhanCong
GO
/****** Object:  StoredProcedure [dbo].[spPhanCong_SelectID]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy lịch làm theo ID---------*/
CREATE PROC [dbo].[spPhanCong_SelectID]
	@manv nvarchar(10)
AS
	SELECT * FROM Employee.PhanCong WHERE MaNV = @manv;
GO
/****** Object:  StoredProcedure [dbo].[spPhanCong_SelectShift]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Chọn lịch làm việc theo ca---------*/
CREATE PROC [dbo].[spPhanCong_SelectShift]
	@manv nvarchar(10),
	@ngaybatdaulam datetime,
	@ngayketthuc datetime,
	@calam nvarchar(10)
AS
	SELECT * FROM Employee.PhanCong WHERE MaNV = @manv AND NgayBatDauLam = @ngaybatdaulam AND NgayKetThuc = @ngayketthuc AND CaLam = @calam;
GO
/****** Object:  StoredProcedure [dbo].[spPhanCong_Update]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Sửa lịch làm việc---------*/
CREATE PROC [dbo].[spPhanCong_Update]
	@manv nvarchar(10),
	@ngaybatdaulam datetime,
	@ngayketthuc datetime,
	@calam nvarchar(10)
AS
	UPDATE Employee.PhanCong SET MaNV = @manv, NgayBatDauLam = @ngaybatdaulam, NgayKetThuc = @ngayketthuc, CaLam = @calam
	WHERE MaNV = @manv;
GO
/****** Object:  StoredProcedure [dbo].[spPhuTung_Delete]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Xóa phụ tùng----------*/
CREATE PROC [dbo].[spPhuTung_Delete]
	@maphutung nvarchar(10)
AS
	DELETE Production.PhuTung WHERE MaPhuTung = @maphutung;
GO
/****** Object:  StoredProcedure [dbo].[spPhuTung_Insert]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Thêm phụ tùng----------*/
CREATE PROC [dbo].[spPhuTung_Insert]
	@maphutung nvarchar(10),
	@loaiphutung nvarchar(100),
	@tenphutung nvarchar(100),
	@soluong int,
	@giaphutung money
AS
	INSERT INTO Production.PhuTung(MaPhuTung, LoaiPhuTung, TenPhuTung, SoLuong, GiaPhuTung)
		VALUES(@maphutung, @loaiphutung, @tenphutung, @soluong, @giaphutung);
GO
/****** Object:  StoredProcedure [dbo].[spPhuTung_SelectAll]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy danh sách phụ tùng----------*/
CREATE PROC [dbo].[spPhuTung_SelectAll]
AS
	SELECT * FROM Production.PhuTung
GO
/****** Object:  StoredProcedure [dbo].[spPhuTung_Update]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Sửa thông tin phụ tùng----------*/
CREATE PROC [dbo].[spPhuTung_Update]
	@maphutung nvarchar(10),
	@loaiphutung nvarchar(100),
	@tenphutung nvarchar(100),
	@soluong int,
	@giaphutung money
AS
	UPDATE Production.PhuTung SET LoaiPhuTung = @loaiphutung, TenPhuTung = @tenphutung, SoLuong = @soluong, GiaPhuTung = @giaphutung
	WHERE MaPhuTung = @maphutung;
GO
/****** Object:  StoredProcedure [dbo].[spXe_CheckSoLuong]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Trừ số lượng trong kho----------*/
CREATE PROC [dbo].[spXe_CheckSoLuong]
	@maxe nvarchar(10)
AS
	UPDATE Production.Xe SET SoLuong = SoLuong - 1 WHERE MaXe = @maxe;
GO
/****** Object:  StoredProcedure [dbo].[spXe_Delete]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Xóa xe----------*/
CREATE PROC [dbo].[spXe_Delete]
	@maxe nvarchar(10)
AS
	DELETE Production.Xe WHERE MaXe = @maxe;
GO
/****** Object:  StoredProcedure [dbo].[spXe_Insert]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Thêm xe----------*/
CREATE PROC [dbo].[spXe_Insert]
	@maxe nvarchar(10),
	@kieuxe nvarchar(60),
	@tenxe nvarchar(60),
	@hinhanh nvarchar(100),
	@soluong int,
	@mau nvarchar(20),
	@loaidongco nvarchar(60),
	@maluc int,
	@momenxoan int,
	@tocdotoida nvarchar(60),
	@sutangtoc nvarchar(20),
	@ngaynhap date,
	@giaxe money,
	@magiamgia nvarchar(10)
AS
	INSERT INTO Production.Xe(MaXe, KieuXe, TenXe, HinhAnh, SoLuong, Mau, LoaiDongCo, MaLuc, MomenXoan, TocDoToiDa, SuTangToc, NgayNhap, GiaXe, MaGiamGia)
		VALUES(@maxe, @kieuxe, @tenxe, @hinhanh, @soluong, @mau, @loaidongco, @maluc, @momenxoan, @tocdotoida, @sutangtoc, @ngaynhap, @giaxe, @magiamgia);
GO
/****** Object:  StoredProcedure [dbo].[spXe_SelectAll]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------In danh sách xe----------*/
CREATE PROC [dbo].[spXe_SelectAll]
AS
	SELECT * FROM Production.Xe
GO
/****** Object:  StoredProcedure [dbo].[spXe_SelectID]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------In danh sách xe theo ID----------*/
CREATE PROC [dbo].[spXe_SelectID]
	@maxe nvarchar(10)
AS
	SELECT * FROM Production.Xe WHERE MaXe = @maxe;
GO
/****** Object:  StoredProcedure [dbo].[spXe_SelectName]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------In danh sách xe theo tên----------*/
CREATE PROC [dbo].[spXe_SelectName]
	@tenxe nvarchar(60)
AS
	SELECT * FROM Production.Xe WHERE TenXe LIKE @tenxe + N'%';
GO
/****** Object:  StoredProcedure [dbo].[spXe_Update]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Sửa thông tin xe----------*/
CREATE PROC [dbo].[spXe_Update]
	@maxe nvarchar(10),
	@kieuxe nvarchar(60),
	@tenxe nvarchar(60),
	@hinhanh nvarchar(100),
	@soluong int,
	@mau nvarchar(20),
	@loaidongco nvarchar(60),
	@maluc int,
	@momenxoan int,
	@tocdotoida nvarchar(60),
	@sutangtoc nvarchar(20),
	@ngaynhap date,
	@giaxe money,
	@magiamgia nvarchar(10)
AS
	UPDATE Production.Xe SET KieuXe = @kieuxe, TenXe = @kieuxe, HinhAnh = @hinhanh, SoLuong = @soluong, Mau = @mau, LoaiDongCo = @loaidongco,
						MaLuc = @maluc, MomenXoan = @momenxoan, TocDoToiDa = @tocdotoida, SuTangToc = @sutangtoc, NgayNhap = @ngaynhap, GiaXe = @giaxe, MaGiamGia = @magiamgia
	WHERE MaXe = @maxe;
GO
/****** Object:  StoredProcedure [dbo].[spXeBaoTri_Insert]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Thêm xe bảo trì----------*/
CREATE PROC [dbo].[spXeBaoTri_Insert]
	@mabaotri nvarchar(10),
	@machiec nvarchar(10),
	@makhachhang int
AS
	INSERT INTO Sales.XeBaoTri(MaBaoTri, MaChiec, MaKH) VALUES(@mabaotri, @machiec, @makhachhang);
GO
/****** Object:  StoredProcedure [dbo].[spXeBaoTri_SelectAll]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Lấy xe bảo trì----------*/
CREATE PROC [dbo].[spXeBaoTri_SelectAll]
AS
	SELECT * FROM Sales.XeBaoTri
GO
/****** Object:  Trigger [Employee].[tgThemDN]    Script Date: 12/9/2019 9:02:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Trừ số lượng trong kho----------*/
--CREATE TRIGGER tgTruSoLuongXe ON Sales.ChiTietHopDong AFTER INSERT
--AS
--	DECLARE @machiec nvarchar(10), @maxe nvarchar(10);
--	SET @machiec = (SELECT MaChiec FROM inserted);
--	SET @maxe = dbo.fnLayMaXe(@machiec);
--	UPDATE Production.Xe SET SoLuong = SoLuong - 1 WHERE MaXe = @maxe;
--GO

/*----------Trigger----------*/
/*----------Thêm tài khoản nhân viên----------*/
CREATE TRIGGER [Employee].[tgThemDN] ON [Employee].[NhanSu] AFTER INSERT
AS
	DECLARE @user nvarchar(10), @chucvu nvarchar(20);
	SELECT @user=MaNV, @chucvu=ChucVu FROM inserted;
	INSERT INTO Employee.DangNhap VALUES (@user, @user, @chucvu);
GO
ALTER TABLE [Employee].[NhanSu] ENABLE TRIGGER [tgThemDN]
GO
/****** Object:  Trigger [Employee].[tgXoaDN]    Script Date: 12/9/2019 9:02:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Xóa tài khoản nhân viên(xóa luôn tài khoản, lịch làm)----------*/
CREATE TRIGGER [Employee].[tgXoaDN] ON [Employee].[NhanSu] INSTEAD OF DELETE
AS 
	DECLARE @user nvarchar(10);
	SELECT @user = MaNV FROM deleted;
	DELETE Employee.DangNhap WHERE UserName = @user;	
	DELETE Employee.NhanSu WHERE MaNV = @user;
GO
ALTER TABLE [Employee].[NhanSu] ENABLE TRIGGER [tgXoaDN]
GO
/****** Object:  Trigger [Production].[tgXoaMaChiec]    Script Date: 12/9/2019 9:02:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Xóa mã chiếc (xóa luôn trong chi tiết hợp đồng)----------*/
CREATE TRIGGER [Production].[tgXoaMaChiec] ON [Production].[KhoXe] INSTEAD OF DELETE
AS
	DECLARE @mac nvarchar(10);
	SELECT @mac = MaChiec FROM deleted;
	DELETE Sales.ChiTietHopDong WHERE MaChiec = @mac;
	DELETE Production.KhoXe WHERE MaChiec = @mac;
GO
ALTER TABLE [Production].[KhoXe] ENABLE TRIGGER [tgXoaMaChiec]
GO
/****** Object:  Trigger [Sales].[tgXoaBaoTri]    Script Date: 12/9/2019 9:02:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------Xóa mã bảo trì----------*/
CREATE TRIGGER [Sales].[tgXoaBaoTri] ON [Sales].[BaoTri] INSTEAD OF DELETE
AS
	DECLARE @mabaotri nvarchar(10);
	SELECT @mabaotri = MaBaoTri FROM deleted;
	DELETE Sales.XeBaoTri WHERE MaBaoTri = @mabaotri;
	DELETE Sales.BaoTri WHERE MaBaoTri = @mabaotri;
GO
ALTER TABLE [Sales].[BaoTri] ENABLE TRIGGER [tgXoaBaoTri]
GO
USE [master]
GO
ALTER DATABASE [ShowroomAudi] SET  READ_WRITE 
GO
