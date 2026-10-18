create database UniversityDB

use UniversityDB

-- 1. students table
create table students (
	StudentID int primary key,
    FirstName varchar(50),
    LastName varchar(50),
    Email varchar(100),
    BirthDate date,
    EnrollmentDate date
)
insert into students
(StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate)
Values
(1, 'John', 'Doe', 'john.doe@email.com', '2000-01-15', '2022-08-01'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '1999-05-25', '2021-08-01');

SELECT * FROM Students;

-- 2.  Courses table
create table courses (
	CourseID int primary key,
    CourseName varchar(100),
    DepartmentID int,
    Credits int
)
insert into courses
(CourseID, CourseName, DepartmentID, Credits)
values
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures', 2, 4);

SELECT * FROM courses;

-- 3.  Instructors Table
create table Instructors (
	InstructorID int primary key,
    FirstName varchar(50),
	LastName varchar(50),
    Email varchar(100),
    DepartmentID int
)
insert into instructors
(InstructorID, FirstName, LastName, Email, DepartmentID)
values
(1, 'Alice', 'Johnson', 'alice@university.com', 1),
(2, 'Bob', 'Smith', 'bob@university.com', 2);

SELECT * FROM Instructors;

-- 4. Enrollments table 
create table Enrollments (
	EnrollmentID int primary key,
    StudentID int,
    CourseID int,
    EnrollmentDate date,
    foreign key(StudentID) references Students(StudentID),
    foreign key(CourseID) references Courses(CourseID)
)
insert into Enrollments
(EnrollmentID, StudentID, CourseID, EnrollmentDate)
values
(1, 1, 101, '2022-08-01'),
(2, 2, 102, '2022-08-02');

SELECT * FROM Enrollments

-- 5. Departments table
create table Departments (
	DepartmentID int primary key,
    DepartmentName varchar(100)
)
insert into Departments
(DepartmentID, DepartmentName)
values
(1, 'Computer Science'),
(2, 'Mathematics');

SELECT * FROM Departments;

-- 1. Perform CRUD Operations on all tables
-- 1(A) students table

-- create 
insert into Students
(StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate)
values
(3, 'David', 'Brown', 'david@email.com', '2001-03-12', '2023-08-01')
    
-- Read
select * from students 

-- Update
update students
set FirstName = 'dave'
where studentID = 3 

select * from students 

--  Delete
delete from students
where studentID = 3

-- 1(B) Courses Table

-- Create 
insert into Courses
(CourseID, CourseName, DepartmentID, Credits)
values
(103, 'Python Programming', 1, 4);

-- Read
select * from Courses 

-- Update
update courses
set credits = 6
where CourseID = 103 

select * from Courses 

-- Delete
delete from courses
where CourseID = 103 

-- 1(C) Instructors Table

-- Create
insert into Instructors
(InstructorID, FirstName, LastName, Email, DepartmentID)
values
(3, 'Carol', 'Davis', 'carol@email.com', 1);

-- Read
SELECT * FROM Instructors;

-- UPDATE
update Instructors
set LastName = 'Patel'
where InstructorID = 3;

SELECT * FROM Instructors

-- DELETE
delete from Instructors
where InstructorID = 3;

-- 1(D) Enrollments Table

-- Create 
insert into Enrollments
(EnrollmentID, StudentID, CourseID, EnrollmentDate)
values
(3, 1, 102, '2022-08-03')

-- Read
select * from  Enrollments

-- Update
update Enrollments
set EnrollmentDate = '2022-09-01'
where EnrollmentID = 3

select * from  Enrollments

-- Delete
delete from  Enrollments
where EnrollmentID = 3 

-- 1(E) Departments Table

-- create
insert into Departments
(DepartmentID, DepartmentName)
values
(3, 'Information Technology')

-- Read
select * from  Departments

-- Update
update Departments
set departmentName = 'IT Department'
where departmentID = 3

select * from  Departments

-- Delete
delete from departments
where departmentID = 3

-- 2. Retrieve students who enrolled after 2022
select * from students
where EnrollmentDate >= '2023-01-01'

-- 3. Retrieve courses offered by the Mathematics department, limited to 5 results.
select * from courses 
where DepartmentID = (
	select DepartmentID
    from Departments
    where DepartmentName = 'Mathematics'
)
limit 5

-- 4. Count students enrolled in each course, having more than 5 students. 

select CourseID , count(StudentID) as Total_Students
from Enrollments
group by CourseID
having count(StudentID) > 5

-- 5. Students enrolled in both SQL and Data Structures courses.
select studentID
from Enrollments
where CourseID = (
	select courseID
    from courses
    where courseName = 'Introduction to SQL'
)
AND StudentID in (
	select studentID
    from enrollments
    where courseID = (
		select courseID
        from courses
        where courseName = 'Data Structures')
)

-- 6.  Students enrolled in either SQL or Data Structures.
select studentID
from enrollments
where courseID in (
	select courseID
    from courses 
    where courseName in ('Introduction to SQL', 'Data Structures')
)

-- 7.  Find the average credits of all courses.

select avg(credits) as Average_Credits
from courses 

-- 8.  Find the maximum salary among instructors in the Computer Science department.

alter table instructors
add salary decimal(10,2)

update instructors
set salary = 50000
where instructorID = 1

update instructors
set salary = 60000
where instructorID = 2

select max(i.salary) as Maximum_salary
from Instructors i
join Departments d
	on i.departmentID = d.departmentID
where d.departmentName = 'Computer Science'

-- 9.  Count students enrolled in each department.
select d.departmentName,
	count(e.StudentID) as Total_Students
from Departments d
join Courses c
	on d.DepartmentID = c.DepartmentID
left join Enrollments e
    On c.CourseID = e.CourseID
group by d.DepartmentID, d.DepartmentName

-- 10. INNER JOIN: Retrieve students and their corresponding courses

select students.firstname , courses.courseName
from students
inner join Enrollments
on students.studentID = Enrollments.studentID
inner join courses
on enrollments.courseID = courses.courseID

-- 11.  LEFT JOIN — Retrieve all students and their corresponding courses, if any.

select students.firstname , courses.courseName
from students
left join enrollments
on students.studentID = enrollments.studentID
left join courses
on enrollments.courseID = courses.courseID

-- 12.  Subquery — Find students enrolled in courses that have more than 10 students

select FirstName, LastName
from Students
where StudentID IN (
    select StudentID
    from Enrollments
    where CourseID IN (
        select CourseID
        from Enrollments
        group by CourseID
        HAVING COUNT(StudentID) > 10
    )
)

-- 13.  Extract the year from EnrollmentDate

select StudentID, year(EnrollmentDate) as Enrollment_Year
from Enrollments

-- 14.  Concatenate instructor first and last names

select concat(firstname, ' ' , lastname) as FullName
from instructors

-- 15.  Calculate a running total of students enrolled in courses

select enrollmentID , studentID,
	count(*) over (order by enrollmentID) as Running_Total
from enrollments

-- 16.  Use CASE to label students as Senior or Junior

select firstname, lastname, enrollmentDate,
case
	when EnrollmentDate < '2023-01-01' then 'Senior'
    else 'Junior'
end as Student_Level
from students
