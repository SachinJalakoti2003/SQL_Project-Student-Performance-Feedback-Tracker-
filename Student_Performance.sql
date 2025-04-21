create database student_performance;

use student_performance;

/* Creating the student table */
create table student(student_id int primary key,
name varchar(100),
age int,
gender varchar(10),
department varchar(50),
semester int);

/* Creating the Faculty table */
create table faculty(faculty_id int primary key, 
name varchar(100),
department varchar(50));

/* Creating the Subjects table */
create table subjects(subject_id int primary key,
subject_name varchar(100),
department varchar(50),
semester int,
faculty_id int,
foreign key(faculty_id) references faculty(faculty_id));

/* Creating the marks table */
create table marks(marks_id int primary key,
student_id int, 
subject_id int, 
marks_obtained int, 
foreign key(student_id) references student(student_id),
foreign key(subject_id) references subjects(subject_id));

/* Creating the Attendance table */
create table attendance(attendance_id int primary key,
student_id int, 
subject_id int,
attendance_percentage decimal(5,2),
foreign key(student_id) references student(student_id),
foreign key(subject_id) references subjects(subject_id));

/* Creating the Feedback table */
CREATE TABLE feedback (
    feedback_id INT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    faculty_id INT,
    feedback_score INT,  
    feedback_text TEXT,
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

                   /*Queries*/
/* Check the all subjects have valid faculty assigned*/
SELECT s.subject_id, s.subject_name, f.faculty_id, f.name AS faculty_name
FROM subjects s
LEFT JOIN faculty f ON s.faculty_id = f.faculty_id
WHERE f.faculty_id IS NULL;


/*check the all records in marks table reference valid students and subjects*/
SELECT m.*
FROM marks m
LEFT JOIN student s ON m.student_id = s.student_id
LEFT JOIN subjects sub ON m.subject_id = sub.subject_id
WHERE s.student_id IS NULL OR sub.subject_id IS NULL;


/*Ensure all attendance entries match existing students and subjects */
SELECT a.*
FROM attendance a
LEFT JOIN student s ON a.student_id = s.student_id
LEFT JOIN subjects sub ON a.subject_id = sub.subject_id
WHERE s.student_id IS NULL OR sub.subject_id IS NULL;

/*Make sure feedback entries are valid for students, subjects, and faculty */
SELECT f.*
FROM feedback f
LEFT JOIN student s ON f.student_id = s.student_id
LEFT JOIN subjects sub ON f.subject_id = sub.subject_id
LEFT JOIN faculty fac ON f.faculty_id = fac.faculty_id
WHERE s.student_id IS NULL OR sub.subject_id IS NULL OR fac.faculty_id IS NULL;

/* Ensuring that subjects and faculty in the same department are aligned*/
SELECT sub.subject_id, sub.subject_name, sub.department AS subject_dept, f.department AS faculty_dept
FROM subjects sub
JOIN faculty f ON sub.faculty_id = f.faculty_id
WHERE sub.department != f.department;


/* checking that any students don't have any marks or attendance*/
-- Students without marks
SELECT s.student_id, s.name
FROM student s
LEFT JOIN marks m ON s.student_id = m.student_id
WHERE m.student_id IS NULL;

-- Students without attendance
SELECT s.student_id, s.name
FROM student s
LEFT JOIN attendance a ON s.student_id = a.student_id
WHERE a.student_id IS NULL;


/* Top 5 Students Based on Average Marks (Department-wise)*/ 
SELECT 
    s.student_id,
    s.name AS student_name,
    s.department,
    ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM 
    student s
JOIN 
    marks m ON s.student_id = m.student_id
GROUP BY 
    s.student_id, s.name, s.department
ORDER BY 
    s.department, average_marks DESC
LIMIT 5;


/*Faculty-wise Average Feedback Score and Student Count per Subject */ 
SELECT 
    f.name AS faculty_name,
    sub.subject_name,
    COUNT(DISTINCT fb.student_id) AS total_students,
    ROUND(AVG(fb.feedback_score), 2) AS avg_feedback_score
FROM 
    feedback fb
JOIN 
    faculty f ON fb.faculty_id = f.faculty_id
JOIN 
    subjects sub ON fb.subject_id = sub.subject_id
GROUP BY 
    f.name, sub.subject_name
ORDER BY 
    avg_feedback_score DESC;


/*List of Students At Risk (Attendance < 75% or Marks < 40 in any Subject) */ 
SELECT DISTINCT 
    s.student_id,
    s.name AS student_name,
    s.department,
    s.semester
FROM 
    student s
LEFT JOIN 
    attendance a ON s.student_id = a.student_id
LEFT JOIN 
    marks m ON s.student_id = m.student_id
WHERE 
    a.attendance_percentage < 75
    OR m.marks_obtained < 40
ORDER BY 
    s.department, s.semester;


/*Department-wise Subject Difficulty Index (Average Marks per Subject) */
SELECT 
    sub.department,
    sub.subject_name,
    ROUND(AVG(m.marks_obtained), 2) AS avg_marks
FROM 
    subjects sub
JOIN 
    marks m ON sub.subject_id = m.subject_id
GROUP BY 
    sub.department, sub.subject_name
ORDER BY 
    avg_marks ASC;
