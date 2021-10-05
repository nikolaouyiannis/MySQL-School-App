USE project_school;

-- populating the tables
INSERT INTO courses (c_title, c_language, c_description, c_type)
VALUES  ('CB13FTCS', 'C#', '12 weeks', 'Full Time'),
		('CB13PTCS', 'C#', '24 weeks', 'Part Time'),
        ('CB13FTJA', 'Java', '12 weeks', 'Full Time'),
        ('CB13PTJA', 'Java', '24 weeks', 'Part Time'),
        ('CB13FTJS', 'Javascript', '12 weeks', 'Full Time'),
        ('CB13PTJS', 'Javascript', '24 weeks', 'Part Time'),
        ('CB13FTPY', 'Python', '12 weeks', 'Full Time'),
        ('CB13PTPY', 'Python', '24 weeks', 'Part Time')
;

INSERT INTO students (first_name, last_name, birthdate)
VALUES 	('Joe', 'Gatto', '2000-1-1'),
		('Sal', 'Vulcano', '2001-1-1'),
        ('Andrew', 'Lincoln', '2002-1-1'),
        ('Christian', 'Serratos', '2003-1-1'),
        ('Jeffrey Dean', 'Morgan', '2004-1-1'),
        ('Danai', 'Gurira', '2005-1-1'),
        ('Lauren', 'Cohan', '1999-1-1'),
        ('James', 'Murray', '2006-1-1'),
        ('Brian', 'Quinn', '2007-1-1')
;

INSERT INTO trainers (first_name, last_name)
VALUES 	('Georges', 'St-Pierre'),
		('Jon', 'Jones'),
        ('Khabib', 'Nurmagomedov'),
        ('Anderson', 'Silva'),
        ('Francis', 'Ngannou'),
        ('Amanda', 'Nunes'),
        ('Nick', 'Diaz'),
        ('Robert', 'Whittaker'),
        ('Ronda', 'Rousey'),
        ('Valentina', 'Shevchenko')
;

INSERT INTO assignments (course_id, a_description, deadline)
VALUES	 ('1', 'Brief', '2021-03-03'),
		 ('2', 'Brief', '2021-03-04'),
         ('3', 'Brief', '2021-03-05'),
         ('4', 'Brief', '2021-03-06'),
         ('5', 'Brief', '2021-03-07'),
         ('6', 'Brief', '2021-03-09'),
         ('7', 'Brief', '2021-03-10'),
         ('8', 'Brief', '2021-03-11'),
         ('1', 'Part A', '2021-04-15'),
         ('2', 'Part A', '2021-04-16'),
         ('3', 'Part A', '2021-04-17'),
         ('4', 'Part A', '2021-04-18'),
         ('5', 'Part A', '2021-04-19'),
         ('6', 'Part A', '2021-04-02'),
         ('7', 'Part A', '2021-04-21'),
         ('8', 'Part A', '2021-04-22'),
         ('1', 'Part B', NULL),
         ('2', 'Part B', NULL),
         ('3', 'Part B', NULL),
         ('4', 'Part B', NULL),
         ('5', 'Part B', NULL),
         ('6', 'Part B', NULL),
         ('7', 'Part B', NULL),
         ('8', 'Part B', NULL)
;

INSERT INTO students_per_course (student_id, course_id, enrollment_date)
VALUES 	(1, 1, '2021-01-31'),
		(2, 1, '2020-12-29'),
        (3, 8, '2021-01-22'),
        (4, 8, '2021-01-20'),
        (5, 2, '2021-01-15'),
        (6, 2, '2021-02-01'),
        (7, 3, '2021-02-01'),
        (8, 3, '2020-11-11'),
        (1, 4, '2021-04-30'),
        (8, 4, '2021-04-29'),
        (3, 5, '2021-05-01')
;

INSERT INTO trainers_per_course (trainer_id, course_id)
VALUES 	(1, 1),
		(1, 2),
        (1, 3),
        (1, 4),
        (1, 5),
        (1, 6),
        (2, 3),
        (2, 4),
        (3, 3),
        (3, 4),
        (3, 5),
        (3, 6),
        (4, 7),
        (4, 8),
        (5, 1),
        (5, 2),
        (6, 5),
        (6, 6),
        (7, 3),
        (7, 4),
        (8, 7),
        (8, 8),
        (8, 1),
        (8, 2),
        (9, 5),
        (9, 6),
        (10, 1),
        (10, 2),
        (10, 8),
        (10, 7)
;
-- creating assignments per students per course table
CREATE TABLE IF NOT EXISTS assignments_per_student_per_course AS
SELECT student_id, spc.course_id, assignment_id
FROM students_per_course spc
JOIN assignments a
ON spc.course_id = a.course_id
ORDER BY student_id;