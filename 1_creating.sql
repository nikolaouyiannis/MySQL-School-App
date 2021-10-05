-- creating the database
CREATE DATABASE IF NOT EXISTS project_school;

-- creating courses table
USE project_school;
CREATE TABLE IF NOT EXISTS courses (
	course_id 		INT AUTO_INCREMENT,
    c_title 			VARCHAR(45) NOT NULL,
    c_language 		VARCHAR(45) NOT NULL,
    c_description 	VARCHAR(45) NOT NULL,
    c_type 			VARCHAR(45) NOT NULL,
    PRIMARY KEY (course_id)
);

-- creating students table
CREATE TABLE IF NOT EXISTS students (
	student_id 		INT AUTO_INCREMENT,
    first_name 		VARCHAR(45) NOT NULL,
    last_name 		VARCHAR(45) NOT NULL,
    birthdate		DATE NOT NULL,
    PRIMARY KEY (student_id)
);

-- creating trainers table
CREATE TABLE IF NOT EXISTS trainers (
	trainer_id 		INT AUTO_INCREMENT,
    first_name 		VARCHAR(45) NOT NULL,
    last_name 		VARCHAR(45) NOT NULL,
    PRIMARY KEY (trainer_id)
);

-- creating assignments table
CREATE TABLE IF NOT EXISTS assignments (
	assignment_id 	INT AUTO_INCREMENT,
    course_id 		INT NOT NULL,
    a_description 	VARCHAR(45),
    deadline 		DATETIME,
    PRIMARY KEY (assignment_id),
	CONSTRAINT fk_assignments_courses FOREIGN KEY (course_id)
		REFERENCES courses (course_id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

-- creating students per course table
CREATE TABLE IF NOT EXISTS students_per_course (
	student_id 	INT NOT NULL,
    course_id 	INT NOT NULL,
    enrollment_date DATE NOT NULL,
    PRIMARY KEY (student_id, course_id),
	CONSTRAINT fk_students_per_course_students FOREIGN KEY (student_id)
		REFERENCES students (student_id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
	CONSTRAINT fk_students_per_course_courses FOREIGN KEY (course_id)
		REFERENCES courses (course_id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

-- creating fees table
CREATE TABLE IF NOT EXISTS fees (
	fee_id		INT NOT NULL,
	student_id 	INT NOT NULL,
    course_id 	INT NOT NULL,
    price 		DECIMAL(5,2),
    PRIMARY KEY (fee_id)
);
    

-- creating trainers per course table
CREATE TABLE IF NOT EXISTS trainers_per_course (
	trainer_id 	INT NOT NULL,
    course_id 	INT NOT NULL,
    PRIMARY KEY (trainer_id, course_id),
	CONSTRAINT fk_trainers_per_course_trainers FOREIGN KEY (trainer_id)
		REFERENCES trainers (trainer_id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
	CONSTRAINT fk_trainers_per_course_courses FOREIGN KEY (course_id)
		REFERENCES courses (course_id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

	
	































    