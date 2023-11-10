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

--1. Вивести вміст таблиці палат.
select * from [Wards];

--2. Вивести прізвища та телефони всіх лікарів.
select [Surname], [Phone] from [Doctors];

--3. Вивести всі поверхи без повторень, на яких розміщуються палати.
select distinct [Floor] from [Wards];

--4. Вивести назви захворювань під ім’ям “Name of Disease” та ступінь їхньої тяжкості під ім’ям “Severity of Disease”.
select [Name] as 'Name of Disease' , [Severity] 'Severity of Disease' from [Diseases];

--5. Використовувати вираз FROM для будь-яких трьох таблиць бази даних, використовуючи для них псевдоніми.
select [Name] as 'Назва відділення' from [Departments];

--6. Вивести назви відділень, розташованих у корпусі 5 та які мають фонд фінансування менше 30000.
select [Name] from [Departments] where [Building] = 5 and [Financing] < 30000;

--7. Вивести назви відділень, розташованих у 3-му корпусі з фондом фінансування у діапазоні від 12000 до 15000.
select [Name] from [Departments] where [Building] = 3 and [Financing] > 12000 and [Financing] < 15000;

--8. Вивести назви палат, розташованих у корпусах 4 та 5 на 1-му поверсі.
select [Name] from [Wards] where [Building] in(4,5) and [Floor] = 1;

--9. Вивести назви, корпуси та фонди фінансування відділень, розташованих у корпусах 3 або 6 та які мають фонд фінансування менше 11000 або більше 25000.
select [Name], [Building], [Financing] from [Departments] where [Building] in(3,6) and [Financing] < 11000 or [Financing] > 25000;

--10. Вивести прізвища лікарів, чия зарплата (сума ставки та надбавки) перевищує 1500.
select distinct [Surname] from [Doctors] where [Salary] + [Premium] > 1500;

--11. Вивести прізвища лікарів, у яких половина зарплати перевищує триразову надбавку.
select distinct [Surname] from [Doctors] where ([Salary]/2) > 3 * [Premium];

--12. Вивести назви обстежень без повторень, які проводяться у перші три дні тижня з 12:00 до 15:00.
select [Name] from [Examinations] where [DayOfWeek] in(2,3,4) and [StartTime] >= '12:00' and [EndTime] <= '15:00';

--13. Вивести назви та номери корпусів відділень, розташованих у корпусах 1, 3, 8 або 10.
select [Name], [Building] from [Departments] where [Building] in(1,3,8,10);

--14. Вивести назви захворювань всіх ступенів тяжкості, крім 1-го та 2-го.
select [Name] from [Diseases] where [Severity] not in(1,2);

--15. Вивести назви відділень, які не розташовуються в 1-му чи 3-му корпусі.
select [Name] from [Departments] where [Building] not in(1,3);

--16. Вивести назви відділень, що розташовуються в 1-му або 3-му корпусі.
select [Name] from [Departments] where [Building] in(1,3);

--17. Вивести прізвища лікарів, що починаються на літеру «N»
select distinct [Surname] from [Doctors] where [Surname] LIKE 'N%';

