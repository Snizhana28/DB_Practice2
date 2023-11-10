--create database Hospital1
--go
--use Hospital1
--go

--CREATE TABLE [Departments] (
--  [Id] INT PRIMARY KEY IDENTITY,
--  [Building] INT NOT NULL,
--  [Financing] MONEY NOT NULL DEFAULT 0,
--  [Floor] INT NOT NULL,
--  [Name] NVARCHAR(100) NOT NULL UNIQUE,

--  constraint chk_Building CHECK (Building >= 1 AND Building <= 5),
--  constraint chk_Floor CHECK (Floor >= 1),
--);

--CREATE TABLE [Diseases](
--  [Id] INT PRIMARY KEY IDENTITY,
--  [Name] NVARCHAR(100) NOT NULL UNIQUE,
--  [Severity] INT NOT NULL DEFAULT 1,

--  constraint chk_Severity CHECK (Severity >= 1),
--);

--CREATE TABLE [Doctors](
--  [Id] INT PRIMARY KEY IDENTITY,
--  [Name] NVARCHAR(MAX) NOT NULL,
--  [Phone] CHAR(10) NOT NULL,
--  [Premium] MONEY NOT NULL DEFAULT 0,
--  [Salary] MONEY NOT NULL,
--  [Surname] NVARCHAR(MAX) NOT NULL,
  
--  constraint chk_Salary CHECK (Salary > 0),
--);

--CREATE TABLE [Examinations] (
--  [Id] INT PRIMARY KEY IDENTITY,
--  [DayOfWeek] INT NOT NULL,
--  [EndTime] TIME NOT NULL,
--  [Name] NVARCHAR(100) NOT NULL UNIQUE,
--  [StartTime] TIME NOT NULL,

--  constraint chk_DayOfWeek CHECK (DayOfWeek >= 1 AND DayOfWeek <= 7),
--  constraint chk_StartTime CHECK (StartTime >= '08:00:00' AND StartTime <= '18:00:00'),
--);

--CREATE TABLE [Wards] (
--  [Id] INT PRIMARY KEY IDENTITY,
--  [Building] INT NOT NULL,
--  [Floor] INT NOT NULL,
--  [Name] NVARCHAR(20) NOT NULL UNIQUE,

--  constraint chk_Building1 CHECK (Building >= 1 AND Building <= 5),
--  constraint chk_Floor1 CHECK (Floor >= 1),
--);

INSERT INTO [Departments] ([Building], [Financing], [Floor], [Name]) VALUES
(1, 1000.00, 1, 'Cardiology'),
(2, 13000.00, 3, 'Orthopedics'),
(3, 10000.00, 2, 'Pediatrics'),
(4, 14000.00, 5, 'Stomatology'),
(5, 1200.00, 4, 'Oncology');

INSERT INTO [Diseases] ([Name], [Severity]) VALUES
('Flu', 2),
('Migraine', 3),
('Diabetes', 4),
('Hypertension', 2);

INSERT INTO [Doctors] ([Name], [Phone], [Premium], [Salary], [Surname]) VALUES
('Alex', '1234567890', 500.00, 7000.00, 'Smith'),
('Mary', '9876543210', 300.00, 6000.00, 'Johnson'),
('David', '5555555555', 200.00, 5500.00, 'Brown'),
('Mriy', '7777777777', 400.00, 6500.00, 'Navis');


INSERT INTO [Examinations] ([DayOfWeek], [EndTime], [Name], [StartTime]) VALUES
(1, '09:00', 'Blood Test', '08:30'),
(3, '14:00', 'X-ray', '13:30'),
(5, '16:30', 'MRI', '16:00'),
(2, '11:00', 'lung examination', '10:30');

INSERT INTO [Wards] ([Building], [Floor], [Name]) VALUES
(1, 1, 'General Ward A'),
(2, 3, 'Pediatric Ward B'),
(4, 1, 'Cardiology Ward C'),
(3, 4, 'Orthopedic Ward D');

--1. ������� ���� ������� �����.
select * from [Wards];

--2. ������� ������� �� �������� ��� �����.
select [Surname], [Phone] from [Doctors];

--3. ������� �� ������� ��� ���������, �� ���� ����������� ������.
select distinct [Floor] from [Wards];

--4. ������� ����� ����������� �� ���� �Name of Disease� �� ������ ����� ������� �� ���� �Severity of Disease�.
select [Name] as 'Name of Disease' , [Severity] 'Severity of Disease' from [Diseases];

--5. ��������������� ����� FROM ��� ����-���� ����� ������� ���� �����, �������������� ��� ��� ���������.
select [Name] as '����� ��������' from [Departments];

--6. ������� ����� �������, ������������ � ������ 5 �� �� ����� ���� ������������ ����� 30000.
select [Name] from [Departments] where [Building] = 5 and [Financing] < 30000;

--7. ������� ����� �������, ������������ � 3-�� ������ � ������ ������������ � ������� �� 12000 �� 15000.
select [Name] from [Departments] where [Building] = 3 and [Financing] > 12000 and [Financing] < 15000;

--8. ������� ����� �����, ������������ � �������� 4 �� 5 �� 1-�� ������.
select [Name] from [Wards] where [Building] in(4,5) and [Floor] = 1;

--9. ������� �����, ������� �� ����� ������������ �������, ������������ � �������� 3 ��� 6 �� �� ����� ���� ������������ ����� 11000 ��� ����� 25000.
select [Name], [Building], [Financing] from [Departments] where [Building] in(3,6) and [Financing] < 11000 or [Financing] > 25000;

--10. ������� ������� �����, ��� �������� (���� ������ �� ��������) �������� 1500.
select distinct [Surname] from [Doctors] where [Salary] + [Premium] > 1500;

--11. ������� ������� �����, � ���� �������� �������� �������� ��������� ��������.
select distinct [Surname] from [Doctors] where ([Salary]/2) > 3 * [Premium];

--12. ������� ����� ��������� ��� ���������, �� ����������� � ����� ��� �� ����� � 12:00 �� 15:00.
select [Name] from [Examinations] where [DayOfWeek] in(2,3,4) and [StartTime] >= '12:00' and [EndTime] <= '15:00';

--13. ������� ����� �� ������ ������� �������, ������������ � �������� 1, 3, 8 ��� 10.
select [Name], [Building] from [Departments] where [Building] in(1,3,8,10);

--14. ������� ����� ����������� ��� ������� �������, ��� 1-�� �� 2-��.
select [Name] from [Diseases] where [Severity] not in(1,2);

--15. ������� ����� �������, �� �� �������������� � 1-�� �� 3-�� ������.
select [Name] from [Departments] where [Building] not in(1,3);

--16. ������� ����� �������, �� �������������� � 1-�� ��� 3-�� ������.
select [Name] from [Departments] where [Building] in(1,3);

--17. ������� ������� �����, �� ����������� �� ����� �N�
select distinct [Surname] from [Doctors] where [Surname] LIKE 'N%';

