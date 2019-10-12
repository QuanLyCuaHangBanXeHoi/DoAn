--Tạo "ShowroomAudi" database
USE master;
--Nếu có tên database trong máy chủ, xóa nó
IF DB_ID(N'ShowroomAudi') IS NOT NULL DROP DATABASE ShowroomAudi; 
--Nếu database đó không được tạo do đang có kết nối, hủy nó
IF @@ERROR = 3702 
	RAISERROR(N'Database cannot be dropped because there are still open connections.', 127, 127) WITH NOWAIT, LOG;

--Tạo Database
CREATE DATABASE ShowroomAudi;
GO

USE ShowroomAudi;
GO

--Tạo Schemas
CREATE SCHEMA Employee AUTHORIZATION dbo;
GO
CREATE SCHEMA Production AUTHORIZATION dbo;
GO
CREATE SCHEMA Sales AUTHORIZATION dbo;
GO

--Tạo Tables
CREATE TABLE Employee.NhanSu
(
	MaNV		int				not null,
	Ho			nvarchar(20)	not null,
	Ten			nvarchar(20)	not null,
	GioiTinh	nvarchar(4)		not null,
	ChucVu		nvarchar(20)	not null,
	NgaySinh	date			not null,
	DiaChi		nvarchar(60)	not null,
	SDT			nvarchar(10)	not null,
	Luong		money			not null,
	CONSTRAINT PK_NhanSu PRIMARY KEY(MaNV)
);

CREATE TABLE Employee.PhanCong
(
	MaNV				int				unique not null,
	NgayBatDauLam		date			not null,
	NgayKetThuc			date			not null,
	CaLam				nvarchar(10)	not null,
	CONSTRAINT FK_PhanCong_NhanVien	FOREIGN KEY(MaNV)
		REFERENCES Employee.NhanSu(MaNV)
);

CREATE TABLE Employee.DangNhap
(
	UserName	int				unique not null,
	Pass		nvarchar(20)	not null,
	CONSTRAINT FK_LogIn_Information FOREIGN KEY(UserName)
		REFERENCES Employee.NhanSu(MaNV)
);

CREATE TABLE Production.Xe
(
	MaXe			nvarchar(10)	not null,
	KieuXe			nvarchar(60)	not null,
	TenXe			nvarchar(60)	not null,
	SoLuong			int				not null,
	Mau				nvarchar(20)	not null,
	LoaiDongCo		nvarchar(60)	not null,
	MaLuc			int				not null,
	MomenXoan		int				not null,
	TocDoToiDa		nvarchar(60)	not null,
	SuTangToc		nvarchar(20)	not null,
	NgayNhap		date			not null,
	GiaXe			money			not null,
	CONSTRAINT PK_Xe PRIMARY KEY(MaXe)
);

CREATE TABLE Production.KhoXe
(
	MaChiec		nvarchar(10)	not null,
	MaXe		nvarchar(10)	not null,
	CONSTRAINT PK_KhoXe PRIMARY KEY(MaChiec),
	CONSTRAINT FK_KhoXe_Xe FOREIGN KEY(MaXe)
		REFERENCES Production.Xe(MaXe)
);

CREATE TABLE Production.PhuTung
(
	MaPhuTung		nvarchar(10)	not null,
	LoaiPhuTung		nvarchar(100)	not null,
	TenPhuTung		nvarchar(100)	not null,
	SoLuong			int				not null,
	GiaPhuTung		money			not null,
	CONSTRAINT PK_PhuTung PRIMARY KEY(MaPhuTung)
);

CREATE TABLE Sales.KhachHang
(
	MaKH		int				not null,
	Ho			nvarchar(20)	not null,
	Ten			nvarchar(20)	not null,
	NgaySinh	date			not null,
	SoCMND		int				not null,
	SDT			int				not null,
	DiaChi		nvarchar(60)	not null,
	CONSTRAINT PK_KhachHang PRIMARY KEY(MaKH)
);

CREATE TABLE Sales.BaoHiem
(
	MaBH				nvarchar(10)	not null,
	GoiBaoHiem			nvarchar(20)	not null,
	GiaBaoHiem			money			not null,
	CONSTRAINT PK_BaoHiem PRIMARY KEY(MaBH)
);

CREATE TABLE Sales.HopDong
(
	MaHD		nvarchar(10)	not null,
	MaKH		int				not null,
	MaNV		int				not null,
	NgayLapHD	date			not null,
	NgayHetHan  date			null,
	CONSTRAINT PK_HopDong PRIMARY KEY(MaHD),
	CONSTRAINT FK_HopDong_KhachHang FOREIGN KEY(MaKH)
		REFERENCES Sales.KhachHang(MaKH),
	CONSTRAINT FK_HopDong_NhanSu FOREIGN KEY(MaNV)
		REFERENCES Employee.NhanSu(MaNV)
);

CREATE TABLE Sales.ChiTietHopDong
(
	MaHD			nvarchar(10)	not null,
	MaChiec			nvarchar(10)	not null,
	MaBH			nvarchar(10)				not null,
	TongGiaTien		money			null,
	CONSTRAINT PK_ChiTietHopDong PRIMARY KEY(MaHD, MaChiec, MaBH),
	CONSTRAINT FK_ChiTietHopDong_HopDong FOREIGN KEY(MaHD)
		REFERENCES Sales.HopDong(MaHD),
	CONSTRAINT FK_ChiTietHopDong_KhoXe FOREIGN KEY(MaChiec)
		REFERENCES Production.KhoXe(MaChiec),
	CONSTRAINT FK_ChiTietHopDong_BaoHiem FOREIGN KEY(MaBH)
		REFERENCES Sales.BaoHiem(MaBH)
);

CREATE TABLE Sales.GiamGia
(
	MaGiamGia		nvarchar(10)	not null,
	MaXe			nvarchar(10)	not null,
	PhanTramGiam	decimal			not null,
	CONSTRAINT PK_GiamGia PRIMARY KEY(MaGiamGia),
	CONSTRAINT FK_GiamGia_Xe FOREIGN KEY(MaXe)
		REFERENCES Production.Xe(MaXe)
);

CREATE TABLE Sales.HoaDon
(
	MaHoaDon	nvarchar(10)	not null,
	MaHD		nvarchar(10)	not null,
	Gia			money			not null,
	Thue		decimal			not null,
	MaGiamGia	nvarchar(10)	null,
	TongCong	money			null,
	CONSTRAINT PK_HoaDon PRIMARY KEY(MaHoaDon),
	CONSTRAINT FK_HoaDon_HopDong FOREIGN KEY(MaHD)
		REFERENCES Sales.HopDong(MaHD)
);

CREATE TABLE Sales.BaoTri
(
	MaBaoTri			nvarchar(10)	not null,
	MaHD				int				not null,
	DongCo				nvarchar(5)		null,
	HeThongDanhLua		nvarchar(5)		null,
	GamVaThanXe			nvarchar(5)		null,
	CapDo				int				not null,
	ThoiGianHenLay		nvarchar(10)	null,
	CONSTRAINT PK_BaoTri PRIMARY KEY(MaBaoTri),
	CONSTRAINT FK_BaoTri_HopDong FOREIGN KEY(MaHD)
		REFERENCES Sales.HopDong(MaHD)
);

CREATE TABLE Sales.NangCap
(
	MaXe			nvarchar(10)	not null,
	MaPhuTung		nvarchar(10)	not null,
	MaKH			int				not null,
	CONSTRAINT PK_NangCap PRIMARY KEY(MaXe, MaPhuTung),
	CONSTRAINT FK_NangCap_Xe FOREIGN KEY(MaXe)
		REFERENCES Production.Xe(MaXe),
	CONSTRAINT FK_NangCap_PhuTung FOREIGN KEY(MaPhuTung)
		REFERENCES Production.PhuTung(MaPhuTung),
	CONSTRAINT FK_NangCap_KhachHang FOREIGN KEY(MaKH)
		REFERENCES Sales.KhachHang(MaKH)
);

SET NOCOUNT ON; --Không hiện message (X row(s) affected) khi execute

--Chèn dữ liệu vào bảng Employee.NhanSu
INSERT INTO Employee.NhanSu VALUES(17110184, N'Nguyễn Thị Xuân', N'Mai', N'Nữ', N'Quản lý', '19990623', N'30B Đường Số 3 Quận Thủ Đức', N'0817882173', 50000000);
INSERT INTO Employee.NhanSu VALUES(17110124, N'Nguyễn Thể', N'Đoàn', N'Nam', N'Nhân viên bán hàng', '19990529', N'15A Đường Đặng Văn Bi Quận Thủ Đức', N'0813424859', 30000000);
INSERT INTO Employee.NhanSu VALUES(17110214, N'Tôn Nữ Như', N'Quỳnh', N'Nữ', N'Nhân viên bán hàng', '19990612', N'60A Lý Chính Thắng Quận Quận 3', N'0167463871', 30000000);
INSERT INTO Employee.NhanSu VALUES(17110134, N'Võ Nguyễn Minh', N'Hiền', N'Nữ', N'Lễ tân', '19990524', N'325 Đường Trường Chinh Quận 12', N'0261739428', 20000000);
INSERT INTO Employee.NhanSu VALUES(17110160, N'Lâm Gia', N'Khánh', N'Nam', N'Cố vấn dịch vụ', '19991227', N'16D Đường Nguyễn Thị Huỳnh Quận Phú Nhuận', N'0856681237', 25000000);
INSERT INTO Employee.NhanSu VALUES(17110164, N'Nguyễn Hữu', N'Huân', N'Nam', N'Kỹ thuật viên', '19990319', N'67 Đường Linh Trung Quận Thủ Đức', N'0283119248', 50000000);
INSERT INTO Employee.NhanSu VALUES(17110105, N'Trần Bình', N'Cơ', N'Nam', N'Kỹ thuật viên', '19990716', N'35 Đường Đặng Văn Bi Quận Thủ Đức', N'0340389422', 50000000);
INSERT INTO Employee.NhanSu VALUES(17110227, N'Nguyễn Thái Phương', N'Thảo', N'Nữ', N'Kế toán', '19990810', N'168 Đường Đặng Văn Bi Quận Thủ Đức', N'0374297781', 15000000);
INSERT INTO Employee.NhanSu VALUES(17110114, N'Nguyễn Văn', N'Khoa', N'Nam', N'Quản lý kho', '19990101', N'45A Đường Số 8 Quận Thủ Đức', N'0814482349', 20000000);
INSERT INTO Employee.NhanSu VALUES(17110189, N'Đoàn Hữu', N'Hùng', N'Nam', N'Bảo vệ', '19990201', N'78C Đường Số 6 Quận Thủ Đức', N'0167038459', 10000000);

--Chèn dữ liệu vào bảng Employee.PhanCong
INSERT INTO Employee.PhanCong VALUES(17110124, '20191013', '20191020', N'Ca 1');
INSERT INTO Employee.PhanCong VALUES(17110214, '20191013', '20191020', N'Ca 2');
INSERT INTO Employee.PhanCong VALUES(17110134, '20191013', '20191020', N'Full');
INSERT INTO Employee.PhanCong VALUES(17110160, '20191013', '20191020', N'Full');
INSERT INTO Employee.PhanCong VALUES(17110164, '20191013', '20191020', N'Ca 1');
INSERT INTO Employee.PhanCong VALUES(17110105, '20191013', '20191020', N'Ca 2');
INSERT INTO Employee.PhanCong VALUES(17110227, '20191013', '20191020', N'Full');
INSERT INTO Employee.PhanCong VALUES(17110114, '20191013', '20191020', N'Full');
INSERT INTO Employee.PhanCong VALUES(17110189, '20191013', '20191020', N'Full');

--Chèn dữ liệu vào bảng Employee.DangNhap
INSERT INTO Employee.DangNhap VALUES(17110184, N'QL1234');
INSERT INTO Employee.DangNhap VALUES(17110124, N'NV1234');
INSERT INTO Employee.DangNhap VALUES(17110214, N'NV1234');
INSERT INTO Employee.DangNhap VALUES(17110134, N'NV1234');
INSERT INTO Employee.DangNhap VALUES(17110160, N'NV1234');
INSERT INTO Employee.DangNhap VALUES(17110164, N'NV1234');
INSERT INTO Employee.DangNhap VALUES(17110105, N'NV1234');
INSERT INTO Employee.DangNhap VALUES(17110227, N'NV1234');
INSERT INTO Employee.DangNhap VALUES(17110114, N'NV1234');

--Chèn dữ liệu vào bảng Production.Xe
INSERT INTO Production.Xe VALUES(N'SSA3B', N'Sedans & Sportbacks', N'A3 Sedan', 2, N'Black', N'2.0-liter four-cylinder', 184, 222, N'130 mph8', N'6.6 seconds', '20180501', 772720405);
INSERT INTO Production.Xe VALUES(N'SSA4B', N'Sedans & Sportbacks', N'A4', 2, N'Black', N'2.0-liter four-cylinder', 188, 236, N'130 mph6', N'7.1 seconds', '20180502', 909628825);
INSERT INTO Production.Xe VALUES(N'SSRS5B', N'Sedans & Sportbacks', N'RS 5 Sportback', 2, N'Black', N'2.9-liter six-cylinder', 444, 443, N'155 mph/Optional 174 mph8', N'3.8 seconds', '20180503', 1721797420);
INSERT INTO Production.Xe VALUES(N'SSA8B', N'Sedans & Sportbacks', N'A8', 2, N'Black', N'3.0-liter six-cylinder', 335, 369, N'130 mph15', N'5.6 seconds', '20180504', 1944563663);
INSERT INTO Production.Xe VALUES(N'SWA4B', N'SUVs & Wagons', N'A4 allroad', 2, N'Black', N'2.0-liter four-cylinder', 248, 273, N'130 mph8', N'5.9 seconds', '20180505', 1060460136);
INSERT INTO Production.Xe VALUES(N'SWSQ5B', N'SUVs & Wagons', N'SQ5', 2, N'Black', N'3.0-liter six-cylinder', 349, 369, N'155 mph2', N'5.1 seconds', '20180506', 1215932410);
INSERT INTO Production.Xe VALUES(N'SWQ7B', N'SUVs & Wagons', N'Q7', 2, N'Black', N'3.0-liter six-cylinder', 329, 325, N'130 mph2', N'5.7 seconds', '20180507', 1215932410);
INSERT INTO Production.Xe VALUES(N'CCA3B', N'Coupes & Convertibles', N'A3 Cabriolet', 2, N'Black', N'2.0-liter four-cylinder', 184, 221, N'130 mph2', N'6.9 seconds', '20180508', 902667380);
INSERT INTO Production.Xe VALUES(N'CCTTSB', N'Coupes & Convertibles', N'TTS Coupe', 2, N'Black', N'2.0-liter four-cylinder', 288, 280, N'155 mph6', N'4.4 seconds', '20180509', 1248419153);

--Chèn dữ liệu vào bảng Production.KhoXe
INSERT INTO Production.KhoXe VALUES(N'SSA3B1', N'SSA3B');
INSERT INTO Production.KhoXe VALUES(N'SSA3B2', N'SSA3B');
INSERT INTO Production.KhoXe VALUES(N'SSA4B1', N'SSA4B');
INSERT INTO Production.KhoXe VALUES(N'SSA4B2', N'SSA4B');
INSERT INTO Production.KhoXe VALUES(N'SSRS5B1', N'SSRS5B');
INSERT INTO Production.KhoXe VALUES(N'SSRS5B2', N'SSRS5B');

--Chèn dữ liệu vào bảng Production.PhuTung
INSERT INTO Production.PhuTung VALUES(N'BN', N'Hệ thống làm mát, nhiên liệu', N'Bơm nước', 5, 2000000);
INSERT INTO Production.PhuTung VALUES(N'MB', N'Hệ thống động cơ, hộp số', N'Mô bin', 10, 5000000);
INSERT INTO Production.PhuTung VALUES(N'CX', N'Hệ thống gầm, phanh', N'Càng', 3, 500000);
INSERT INTO Production.PhuTung VALUES(N'CB', N'Hệ thống điện, điều hòa', N'Cảm biến', 6, 3000000);

--Chèn dữ liệu vào bảng Sales.KhachHang
INSERT INTO Sales.KhachHang VALUES(100, N'Lê Thị Như', N'Ý', '19890923', 346789109, 0228719284, N'22B Đường Phạm Văn Đồng Quận Thủ Đức');
INSERT INTO Sales.KhachHang VALUES(101, N'Nguyễn Ngọc', N'Châu', '19971109', 321409761, 0364785884, N'245 Đường Lê Văn Sĩ Quận 3');
INSERT INTO Sales.KhachHang VALUES(102, N'Võ Đăng', N'Khoa', '19870322', 267679293, 0483891561, N'77A Đường Trần Hưng Đạo Quận 1');
INSERT INTO Sales.KhachHang VALUES(103, N'Vũ Đức', N'Thịnh', '19910416', 299028910, 0223884841, N'09 Đường Đặng Văn Bi Quận Thủ Đức');

--Chèn dữ liệu vào bảng Sales.BaoHiem
INSERT INTO Sales.BaoHiem VALUES(N'PBH', N'Phí bảo hiểm', 5000000);
INSERT INTO Sales.BaoHiem VALUES(N'PBTDB', N'Phí bảo trì đường bộ',30000000);
INSERT INTO Sales.BaoHiem VALUES(N'BHXH', N'Bảo hiểm xe hơi',50000000);
INSERT INTO Sales.BaoHiem VALUES(N'BHTNDS', N'Bảo hiểm trách nhiệm dân sự',30000000);

--Chèn dữ liệu vào bảng Sales.HopDong
INSERT INTO Sales.HopDong VALUES(N'A101', 100, 17110124, '20191012', '20211012');
INSERT INTO Sales.HopDong VALUES(N'A102', 101, 17110214, '20191212', '20211212');
INSERT INTO Sales.HopDong VALUES(N'A103', 102, 17110124, '20190214', '20210214');

--Chèn dữ liệu vào bảng Sales.ChiTietHopDong
INSERT INTO Sales.ChiTietHopDong VALUES(N'A101', N'SSA3B1', 'PBH', null);
INSERT INTO Sales.ChiTietHopDong VALUES(N'A101', N'SSA3B1', 'PBTDB', null);
INSERT INTO Sales.ChiTietHopDong VALUES(N'A102', N'SSA3B2', 'PBH', null);
INSERT INTO Sales.ChiTietHopDong VALUES(N'A103', N'SSRS5B1', 'BHTNDS', null);

--Chèn dữ liệu vào bảng Sales.GiamGia
INSERT INTO Sales.GiamGia VALUES(N'B01', N'SSA3B', 0.1);
INSERT INTO Sales.GiamGia VALUES(N'B02', N'SSRS5B', 0.1);
INSERT INTO Sales.GiamGia VALUES(N'B03', N'CCA3B', 0.2);

--Chèn dữ liệu vào bảng Sales.HoaDon
INSERT INTO Sales.HoaDon VALUES(N'HD1', N'A101', null, 0.1, N'B01', null);
INSERT INTO Sales.HoaDon VALUES(N'HD2', N'A102', null, 0.1, N'B02', null);

--Chèn dữ liệu vào bảng Sales.BaoTri
INSERT INTO Sales.BaoTri VALUES(N'BT01', N'HD1', N'Có', N'Không', N'Không', 2, N'2 Ngày');
INSERT INTO Sales.BaoTri VALUES(N'BT02', N'HD2', N'Có', N'Có', N'Không', 2, N'4 Ngày');

--Chèn dữ liệu vào bảng Sales.NangCap
INSERT INTO Sales.NangCap VALUES(N'SSA3B', N'BN', 100);
INSERT INTO Sales.NangCap VALUES(N'SSRS5B', N'MB', 101);










