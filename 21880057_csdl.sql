-- MSSV: 21880057 
-- Họ và tên: Dương Hoài Hương
-- Ngày: 11/09/2022


-- create a database
--CREATE DATABASE QLDA_21880057;
--USE QLDA_21880057;

-- create a table
CREATE TABLE PHONGBAN (
    TenPHG nvarchar(15) NOT NULL,
    MaPHG int NOT NULL,
    TrPHG char(9) NOT NULL,
    Ng_NhanChuc date NOT NULL,
    PRIMARY KEY (MaPHG)
);

CREATE TABLE NHANVIEN (
    HoNV nvarchar(15) NOT NULL,
    TenLot nvarchar(15) NOT NULL,
    TenNV nvarchar(15) NOT NULL,
    MaNV char(9) NOT NULL,
    NgSinh date NOT NULL,
    DChi nvarchar(30) NOT NULL,
    Phai char(3) NOT NULL,
    Luong float NOT NULL,
    Ma_NQL char(9) NOT NULL,
    PHG int NOT NULL,
    PRIMARY KEY (MaNV)
    
);

CREATE TABLE DIADIEM_PHG(
    MaPHG int NOT NULL,
    DiaDiem nvarchar(15) NOT NULL,
    PRIMARY KEY (MaPHG, DiaDiem)
);

CREATE TABLE DEAN (
    TenDA nvarchar(15) NOT NULL,
    MaDA int NOT NULL,
    Ddiem_DA nvarchar(15) NOT NULL,
    Phong int NOT NULL,
    PRIMARY KEY (MaDA)
);

CREATE TABLE CONGVIEC (
    MaDA int NOT NULL,
    STT int NOT NULL,
    Ten_Cong_Viec NOT NULL,
    PRIMARY KEY (MaDA, STT)
);

CREATE TABLE PHANCONG (
    Ma_NVien char(9) NOT NULL,
    MaDA int NOT NULL,
    STT int NOT NULL,
    ThoiGian float(5,1) NOT NULL,
    PRIMARY KEY (Ma_NVien, MaDA, STT)
);

CREATE TABLE THANNHAN (
    Ma_NVien char(9) NOT NULL,
    TenTN nvarchar(15) NOT NULL,
    Phai char(3) NOT NULL,
    NgSinh date NOT NULL,
    QuanHe nvarchar(15) NOT NULL,
    PRIMARY KEY (Ma_NVien, TenTN)
);

-- check constraint
ALTER TABLE NHANVIEN
    ADD CONSTRAINT CK_NHANVIEN_PHAI
    CHECK (Phai IN ('Nam', N'Nữ'));

ALTER TABLE THANNHAN
    ADD CONSTRAINT CK_THANNHAN_PHAI
    CHECK (Phai IN ('Nam', N'Nữ'));

-- foreign key 
ALTER TABLE NHANVIEN
    ADD CONSTRAINT FK_NHANVIEN
    FOREIGN KEY (Ma_NQL)
    REFERENCES NHANVIEN(MaNV);
    
ALTER TABLE NHANVIEN
    ADD CONSTRAINT FK_NHANVIEN_PHONGBAN
    FOREIGN KEY (PHG)
    REFERENCES PHONGBAN(MaPHG);

ALTER TABLE PHONGBAN
    ADD CONSTRAINT FK_PHONGBAN_NHANVIEN
    FOREIGN KEY (TrPHG)
    REFERENCES NHANVIEN(MaNV);

ALTER TABLE DIADIEM_PHG
	ADD CONSTRAINT FK_DIADIEM_PHONGBAN
	FOREIGN KEY (MaPHG)
	REFERENCES PHONGBAN(MaPHG);
	
ALTER TABLE THANNHAN
	ADD CONSTRAINT FK_THANNHAN_NHANVIEN
	FOREIGN KEY (Ma_Nvien)
	REFERENCES NHANVIEN(MaNV);
	
ALTER TABLE DEAN
	ADD CONSTRAINT FK_DEAN_PHONGBAN
	FOREIGN KEY (Phong)
	REFERENCES PHONGBAN(MaPHG);

ALTER TABLE CONGVIEC
	ADD CONSTRAINT FK_CONGVIEC_DEAN
	FOREIGN KEY (MaDA)
	REFERENCES DEAN(MaDA);

ALTER TABLE PHANCONG
	ADD CONSTRAINT FK_PHANCONG_NHANVIEN
	FOREIGN KEY (Ma_NVien)
	REFERENCES NHANVIEN(MaNV);

ALTER TABLE PHANCONG
	ADD CONSTRAINT FK_PHANCONG_CONGVIEC
	FOREIGN KEY (MaDA, STT)
	REFERENCES CONGVIEC(MaDA, STT);

-- insert some values
INSERT PHONGBAN VALUES
	(N'Nghiên cứu',5,'005','1978-05-22'),
	(N'Điều hành',4,'008','1985-01-01'),
	(N'Quản lý',1,'006','1971-06-19');
	
INSERT NHANVIEN VALUES
	(N'Đinh', N'Bá', N'Tiên', '009', CAST('1960-02-11' AS Date), N'119 Cống Quỳnh', N'Nam', 30000, '005', 5),
	(N'Nguyễn', N'Thanh', N'Tùng', '005', CAST('1962-08-20' AS Date), N'222 Nguyễn Văn Cừ, Tp HCM', N'Nam', 40000, '006', 5),
	(N'Bùi', N'Ngọc', N'Hằng', '007', CAST('1954-03-11' AS Date), N'332 Nguyễn Thái Học', N'Nam', 25000, '001', 4),
	(N'Lê', N'Quỳnh', N'Như', '001', CAST('1967-02-01' AS Date), N'291 Hồ Văn Huê, Tp HCM', N'Nữ', 43000, '006', 4),
	(N'Nguyễn', N'Mạnh', N'Hùng', '004', CAST('1967-03-04' AS Date), N'95 Bà Rịa, Vũng Tàu', N'Nam', 38000, '005', 5),
	(N'Trần', N'Thanh', N'Tâm', '003', CAST('1957-05-04' AS Date), N'34 Mai Thị Lựu, Tp HCM', N'Nam', 25000, '005', 5),
	(N'Trần', N'Hồng', N'Quang', N'008', CAST('1967-09-01' AS Date), N'80 Lê Hồng Phong, Tp HCM', N'Nam', 25000, '001', 4),
	(N'Phạm', N'Văn', N'Vinh', N'006', CAST('1965-01-01' AS Date), N'45 Trưng Vương, Hà Nội', N'Nữ', 55000, NULL, 1);

INSERT DIADIEM_PHG VALUES
	(1,N'Tp HCM'),
	(4,N'Hà Nội'),
	(5,N'TAU'),
	(5,N'NHA TRANG'),
	(5,N'TP HCM');

INSERT THANNHAN VALUES
	('005',N'Trinh',N'Nữ','1976-04-05',N'Con gái'),
	('005',N'Khang',N'Nam','1973-10-25',N'Con trai'),
	('005',N'Phương',N'Nữ','1948-05-03',N'Vợ chồng'),
	('001',N'Minh',N'Nam','1932-02-29',N'Vợ chồng'),
	('009',N'Tiến',N'Nam','1978-01-01',N'Con trai'),
	('009',N'Châu',N'Nữ','1978-12-30',N'Con gái'),
	('009',N'Phương',N'Nữ','1957-05-05',N'Vợ chồng');
	
INSERT DEAN VALUES
	(N'San pham X',1,N'Vũng Tàu',5),
	(N'San pham Y',2,N'Nha Trang',5),
	(N'San pham Z',3,N'TP HCM',5),
	(N'Tin hoc hoa',10,N'Hà Nội',4),
	(N'Cáp quang',20,N'TP HCM',1),
	(N'Đào tạo',30,N'Hà Nội',4);

INSERT CONGVIEC VALUES
	(1,1,N'Thiet ke san pham X'),
	(1,2,N'Thu nghiem san pham X'),
	(2,1,N'San xuat san pham Y'),
	(2,2,N'Quang cáo sản phẩm Y'),
	(3,1,N'Khuyến mãi sản phẩm Z'),
	(10,1,N'Tin hoc hoa nhan su tien luong'),
	(10,2,N'Tin hoc hoa phong kinh doanh'),
	(20,1,N'Lắp đặt cáp quang'),
	(30,1,N'Đào tạo nhân viên Marketting'),
	(30,2,N'Đào tạo chuyên viên thiết kế');

INSERT PHANCONG VALUES
	('009',1,1,32),
	('009',2,2,8),
	('004',3,1,40),
	('003',1,2,20.0),
	('003',2,1,20.0),
	('008',10,1,35),
	('008',30,2,5),
	('001',30,1,20),
	('001',20,1,15),
	('006',20,1,30),
	('005',3,1,10),
	('005',10,2,10),
	('005',20,1,10),
	('007',30,2,30),
	('007',10,2,10);

-- Câu 1:
SELECT * FROM NHANVIEN WHERE NHANVIEN.PHG=4

-- Câu 2: 
SELECT *
FROM NHANVIEN
WHERE NHANVIEN.LUONG>25000 and NHANVIEN.PHG=4 or NHANVIEN.LUONG>30000 and NHANVIEN.PHG=5

-- Câu 3:
SELECT HoNV+ ' ' +TenLot+ ' ' +TenNV as 'Họ Và Tên'
FROM NHANVIEN
WHERE NHANVIEN.HoNV like N'N%'

-- Câu 4: 
SELECT nv.*
FROM NHANVIEN nv
WHERE (DATEDIFF(d,nv.NgSinh, '04/30/1975') > 0)
    OR (nv.DChi LIKE N'%Tp HCM')
    OR (nv.PHG = 4)

-- Câu 5:
SELECT MaDA,MaPHG,HoNV,TenLot,TenNV,DChi,NgSinh
FROM NHANVIEN,PHONGBAN,DEAN
WHERE NHANVIEN.MaNV = PHONGBAN.TrPHG and PHONGBAN.MaPHG = DEAN.Phong and DEAN.Ddiem_DA like N'Hà Nội'

-- Câu 6:
SELECT TenPHG,AVG(Luong)
FROM PHONGBAN,NHANVIEN
WHERE MaPHG=PHG
GROUP BY TenPHG

-- Câu 7: 
SELECT AVG(LUONG) as 'Lương Trung Bình của các NV nữ'
FROM NHANVIEN
WHERE Phai like N'Nữ'

-- Câu 8: 
SELECT Ma_NQL,count(*)
FROM NHANVIEN
WHERE Ma_NQL is not null
GROUP BY Ma_NQL

-- Câu 9:
SELECT TenPHG,AVG(Luong)
FROM PHONGBAN,NHANVIEN
WHERE MaPHG=PHG
GROUP BY TenPHG

-- Câu 10:
SELECT AVG(LUONG) as 'Lương Trung Bình của các NV nữ'
FROM NHANVIEN
WHERE Phai like N'Nữ'


--2.1 TRUY VẤN CƠ BẢN
--2.1.1 Truy vấn đơn giản
--1. Tìm các nhân viên làm việc ở phòng số 4
go
	select *
	from nhanvien
	where nhanvien.phg=4
go
--2. Tìm các nhân viên có mức lương trên 30000
go
	select*
	from NHANVIEN
	where NHANVIEN.LUONG>30000
go

--3. Tìm các nhân viên có mức lương trên 25,000 ở phòng 4 hoặc các nhân viên có mức lương trên 30,000 ở phòng 5
go
	select *
	from nhanvien
	where NHANVIEN.LUONG>25000 and NHANVIEN.PHG=4 or NHANVIEN.LUONG>30000 and NHANVIEN.PHG=5
go

--4. Cho biết họ tên đầy đủ của các nhân viên ở TP HCM
go
	select HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ Và Tên'
	from NHANVIEN 
	where Nhanvien.DCHI like N'%TP.HCM'

	select *
	from NHANVIEN
go

--5. Cho biết họ tên đầy đủ của các nhân viên có họ bắt đầu bằng ký tự 'N'
go
	select HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ Và Tên'
	from NHANVIEN
	where NHANVIEN.HONV like N'N%'
go
--6. Cho biết ngày sinh và địa chỉ của nhân viên Dinh Ba Tien
go
	select NGSINH,DCHI
	from NHANVIEN
	where HONV = N'Đinh' and TENLOT=N'Bá' and TENNV=N'Tiến'
go

--7. Cho biết các nhân viên có năm sinh trong khoảng 1960 đến 1965
go
	select *
	from NHANVIEN
	where Year(NGSINH) Between 1960 and 1965
go
--8. Cho biết các nhân viên và năm sinh của nhân viên
go
	select TENNV,Year(NGSINH) as 'Năm sinh'
	from NHANVIEN
go
--9. Cho biết các nhân viên và tuổi của nhân viên
go	
	select TENNV,Year(getdate())-Year(NGSINH) as 'Tuổi'
	from NHANVIEN
go
--2.1.2 Truy vấn có sử dụng phép kết
--10. Với mỗi phòng ban, cho biết tên phòng ban và địa điểm phòng
go
	select PHONGBAN.TENPHG,DIADIEM_PHG.DIADIEM
	from PHONGBAN,DIADIEM_PHG
	where PHONGBAN.MAPHG=DIADIEM_PHG.MAPHG
go
--11. Tìm tên những người trưởng phòng của từng phòng ban
go
	select HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ Và Tên Trưởng Phòng'
	from PHONGBAN,NHANVIEN
	where PHONGBAN.TRPHG=NHANVIEN.MANV
go

--12. Tìm tên và địa chỉ của tất cả các nhân viên của phòng "Nghiên cứu".
go
	select TENNV,DCHI
	from PHONGBAN,NHANVIEN
	where PHONGBAN.MAPHG = NHANVIEN.PHG and TENPHG like N'Nghiên cứu'

	select*
	from phongban
	
go
--13. Với mỗi đề án ở Hà Nội, cho biết tên đề án, tên phòng ban, họ tên và ngày nhận chức của trưởng phòng của phòng ban chủ trì đề án đó.
go
	--Ý tưởng 
	select TENDA,TENPHG,HONV,TENNV
	from NHANVIEN,PHONGBAN,DEAN
	where NHANVIEN.MANV = PHONGBAN.TRPHG and PHONGBAN.MAPHG = DEAN.PHONG and DEAN.DDIEM_DA like N'Hà Nội'

	select*
	from phongban
	select*
	from DEAN
go
--14. Tìm tên những nữ nhân viên và tên người thân của họ
go
	select TENNV,TENTN
	from NHANVIEN,THANNHAN
	where NHANVIEN.MANV = THANNHAN.MA_NVIEN and NHANVIEN.PHAI like N'Nữ'
go
--15. Với mỗi nhân viên, cho biết họ tên nhân viên và họ tên người quản lý trực tiếp của nhân viên đó.
go
	select nv.HONV+ ' ' +nv.TENLOT+ ' ' +nv.TENNV as 'Họ Và Tên nv',ql.HONV+ ' ' +ql.TENLOT+ ' ' +ql.TENNV as 'Họ Và Tên Quản Lí'
	from NHANVIEN nv,NHANVIEN ql
	where nv.MA_NQL=ql.MANV
go
--16. Với mỗi nhân viên, cho biết họ tên của nhân viên đó, họ tên người trưởng phòng và họ tên người quản lý trực tiếp của nhân viên đó.
go
	select nv.HONV+ ' ' +nv.TENLOT+ ' ' +nv.TENNV as 'Họ Và Tên nv',ql.HONV+ ' ' +ql.TENLOT+ ' ' +ql.TENNV as 'Họ Và Tên Quản Lí',
	tp.HONV+ ' ' +tp.TENLOT+ ' ' +tp.TENNV as 'Họ Và Tên Trưởng Phòng'
	from NHANVIEN nv,NHANVIEN ql,NHANVIEN tp,PHONGBAN pb
	where nv.MA_NQL = ql.MANV and tp.manv = pb.TRPHG and nv.phg = tp.phg

--làm lại
	select nv.HONV+ ' ' +nv.TENLOT+ ' ' +nv.TENNV as 'Họ Và Tên nv',ql.HONV+ ' ' +ql.TENLOT+ ' ' +ql.TENNV as 'Họ Và Tên Quản Lí',
	tp.HONV+ ' ' +tp.TENLOT+ ' ' +tp.TENNV as 'Họ Và Tên Trưởng Phòng'
	from NHANVIEN nv,NHANVIEN ql,NHANVIEN tp , PHONGBAN pb
	where nv.MA_NQL=ql.MANV and tp.MANV= pb.TRPHG and pb.MAPHG=nv.PHG

go
--17. Tên những nhân viên phòng số 5 có tham gia vào đề án "Sản phẩm X" và nhân viên này do "Nguyễn Thanh Tùng" quản lý trực tiếp.
go
	select nv.HONV , nv.TENLOT,nv.TENNV
	from NHANVIEN nv, NHANVIEN ql,DEAN da
	where nv.MA_NQL= ql.MANV and nv.PHG = da.PHONG and nv.PHG = 5 and ql.HONV = N'Nguyễn' and ql.TENLOT=N'Thanh' and ql.TENNV=N'Tùng' and
	da.TENDA like N'Sản Phẩm X'
go
--18. Cho biết tên các đề án mà nhân viên Đinh Bá Tiến đã tham gia.
go
	select DEAN.TENDA
	from NHANVIEN,PHANCONG,DEAN
	where NHANVIEN.MANV = PHANCONG.MA_NVIEN and PHANCONG.MADA= DEAN.MADA and HONV = N'Đinh' and TENLOT=N'Bá' and TENNV=N'Tiến'
go--Xong Lần 1--
--2.2 GOM NHÓM
--19. Cho biết số lượng đề án của công ty
go
	select count(*)
	from dean
go
--20. Cho biết số lượng đề án do phòng 'Nghiên Cứu' chủ trì
go
	select count(*)
	from PHONGBAN,DEAN
	where PHONG=MAPHG and TENPHG like N'Nghiên cứu'

	--dean
	select *
	from dean
	--phancong
	select *
	from PHANCONG
	--nhanvien
	select*
	from NHANVIEN

go
--21. Cho biết lương trung bình của các nữ nhân viên
go
	select avg(LUONG) as 'Lương Trung Bình của các NV nữ'
	from NHANVIEN
	where phai like N'Nữ'
go
--22. Cho biết số thân nhân của nhân viên 'Đinh Bá Tiến'
go
	select count(*) as 'Số thân nhân của tiến'
	from NHANVIEN,THANNHAN
	where MANV=MA_NVIEN and HONV = N'Đinh' and TENLOT=N'Bá' and TENNV=N'Tiến'
go
--23. Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên tham dự đề án đó.
go
	select dean.TENDA,sum(PHANCONG.THOIGIAN) as 'Tổng giờ làm'
	from PHANCONG,DEAN
	where PHANCONG.MADA = DEAN.MADA
	group by DEAN.TENDA
go
--24. Với mỗi đề án, cho biết có bao nhiêu nhân viên tham gia đề án đó.
go
	select MADA, count(*)
	from PHANCONG,NHANVIEN
	where MANV=MA_NVIEN
	group by MADA

go
--25. Với mỗi nhân viên, cho biết họ và tên nhân viên và số lượng thân nhân của nhân viên đó.
go
	select HONV+' '+TENNV as 'Họ Và Tên',count(*) as 'Số lượng thân nhân'
	from NHANVIEN,THANNHAN
	where MANV = MA_NVIEN
	group by HONV,TENNV

go
--26. Với mỗi nhân viên, cho biết họ tên của nhân viên và số lượng đề án mà nhân viên đó đã tham gia.
go
	select honv,tennv,count(*)
	from NHANVIEN,PHANCONG
	where MANV=MA_NVIEN
	group by honv,tennv
go
--27. Với mỗi nhân viên, cho biết số lượng nhân viên mà nhân viên đó quản lý trực tiếp.
go
	select MA_NQL,count(*)
	from NHANVIEN
	where MA_NQL is not null
	group by MA_NQL
go
--28. Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên làm việc cho phòng ban đó.
go
	select TENPHG,AVG(LUONG)
	from PHONGBAN,NHANVIEN
	where maphg=PHG
	group by TENPHG
go
--29. Với các phòng ban có mức lương trung bình trên 30,000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó.
go
	select TENPHG,COUNT(*) as 'Số lượng nhân viên làm việc'
	from PHONGBAN,NHANVIEN
	where MAPHG=PHG
	group by TENPHG
	having avg(LUONG)>30000
go
--30. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì
go	
	select TENPHG,count(*)
	from PHONGBAN,DEAN
	where maphg=phong
	group by TENPHG
	--dean
	select*
	from DEAN
go
--31. Với mỗi phòng ban, cho biết tên phòng ban, họ tên người trưởng phòng và số lượng đề án mà phòng ban đó chủ trì
go
	select TENPHG,HONV,TENLOT,TENNV,count(*) as 'Số lượng đề án'
	from PHONGBAN,NHANVIEN,DEAN
	where MANV=TRPHG and MAPHG=PHONG
	group by TENPHG,HONV,TENLOT,TENNV
go
--32. Với mỗi phòng ban có mức lương trung bình lớn hơn 40,000, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì.
go
	select TENPHG,count(*)
	from PHONGBAN,NHANVIEN,DEAN
	where MAPHG=PHG and MAPHG=PHONG
	group by TENPHG
	having AVG(LUONG)>40000
go
--33. Cho biết số đề án diễn ra tại từng địa điểm
go
	select DDIEM_DA,count(*) as 'Số đề án'
	from DEAN
	group by DDIEM_DA

	--dean
	select*
	from DEAN
go
--34. Với mỗi đề án, cho biết tên đề án và số lượng công việc của đề án này.
go
	select DEAN.TENDA,count(TEN_CONG_VIEC) as 'Số lượng CV'
	from DEAN,CONGVIEC
	where dean.MADA = CONGVIEC.MADA
	group by DEAN.TENDA

	select*
	from CONGVIEC
go
--35. Với mỗi công việc trong đề án có mã đề án là 30, cho biết số lượng nhân viên được phân công.
go
	select CONGVIEC.TEN_CONG_VIEC,count(*) as 'Số lượng nv phân công'
	from CONGVIEC,PHANCONG
	where CONGVIEC.MADA = PHANCONG.MADA and CONGVIEC.MADA = 30
	group by CONGVIEC.TEN_CONG_VIEC
go
--36. Với mỗi công việc trong đề án có mã đề án là 'Dao Tao', cho biết số lượng nhân viên được phân công.
go
	select CONGVIEC.TEN_CONG_VIEC,count(*) as 'Số lượng nv phân công'
	from CONGVIEC,PHANCONG,DEAN
	where CONGVIEC.MADA = PHANCONG.MADA and CONGVIEC.MADA = DEAN.MADA and DEAN.TENDA like N'%Đào Tạo'
	group by CONGVIEC.TEN_CONG_VIEC
go
--END--
