-- A list of all the students
SELECT * FROM students;

-- A list of all the trainers 
SELECT * FROM trainers;

-- A list of all the assignments
SELECT * FROM assignments;

-- A list of all the courses
SELECT * FROM courses;

-- All the students per course
SELECT c_language, c_type, first_name, last_name FROM students_per_course spc
INNER JOIN students s
ON spc.student_id = s.student_id
INNER JOIN courses c
ON spc.course_id = c.course_id
ORDER BY c_language;

-- All the trainers per course
SELECT c_language, c_type, first_name, last_name FROM trainers_per_course tpc
INNER JOIN trainers t
ON tpc.trainer_id = t.trainer_id
INNER JOIN courses c
ON tpc.course_id = c.course_id
ORDER BY c_language;

-- All the assignments per course
SELECT c_language, c_type, a_description FROM assignments a
INNER JOIN courses c
ON a.course_id = c.course_id;

-- All the assignments per course per student
SELECT c_language, last_name, first_name, a_description
FROM assignments_per_student_per_course apspc
INNER JOIN courses c
ON apspc.course_id = c.course_id
INNER JOIN students s
ON apspc.student_id = s.student_id
INNER JOIN assignments a
ON apspc.assignment_id = a.assignment_id
ORDER BY c_language, last_name;

























