DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS instructor;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS teaching_assistant;
DROP TABLE IF EXISTS tutorial_section;
DROP TABLE IF EXISTS lab_assistant;
DROP TABLE IF EXISTS lab_section;
DROP TABLE IF EXISTS course_prerequisite;
DROP TABLE IF EXISTS course_antirequisite;
DROP TABLE IF EXISTS course_registration;

CREATE TABLE student(
    student_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    year_of_study INT,
    CONSTRAINT chk_course_year CHECK (year_of_study BETWEEN 1 AND 4) --To ensure only 1st - 4th years students are eligible for  registration for the semester
);

INSERT INTO student (student_id, name, year_of_study)
VALUES 
  ('STU-1', 'John Doe', 1),
  ('STU-2', 'Jane Smith', 2),
  ('STU-3', 'Ligma Johnson', 3),
  ('STU-4', 'Glen Kinyua', 4),
  ('STU-6', 'Alex Kim', 2),
  ('STU-5', 'Eddie Kinuthia', 1),
  ('STU-7', 'Onyango opiyo', 4),
  ('STU-8', 'Jacyres Tagaeryan', 2),
  ('STU-9', 'Playboi Carti', 3),
  ('STU-10', 'Jon Snow', 4);

SELECT * FROM student;

DROP TABLE instructor;
CREATE TABLE instructor(
    instructor_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    department VARCHAR(20),
    office_room VARCHAR(20),
    phone_extension INT,
    email VARCHAR(55) UNIQUE
);

INSERT INTO instructor (instructor_id, name, department, office_room, phone_extension, email)
VALUES 
  ('INS-1', 'Jordan Carter', 'COPAS', 'SCC-100', 0112123243, 'jordanCarter67@gmail.com'),
  ('INS-2', 'Juliet Wangoi', 'COHRED', 'COH-100', 0777923243, 'JulietWangoi@gmail.com'),
  ('INS-3', 'Samuel Kiptoo', 'COHRED', 'EMB-100', 0789234992, 'SamuelKiptoo007@gmail.com'),
  ('INS-4', 'Alvin Munene', 'COHES', 'PHA-100', 0531455992, 'alvinMunene2433@gmail.com'),
  ('INS-5', 'Sean Carter', 'COPAS', 'SCC-100', 0112123243, 'SeanCarter67@gmail.com'),
  ('INS-6', 'Nancy Wanji', 'COHRED', 'COH-100', 0777923243, 'NancyWanji@gmail.com'),
  ('INS-7', 'Jason Kamau', 'COHRED', 'EMB-100', 0789234992, 'JsonKAmau007@gmail.com');

SELECT * FROM instructor;

DROP TABLE course;
CREATE TABLE course(
    course_id VARCHAR(20) PRIMARY KEY,
    title VARCHAR(20) NOT NULL,
    description TEXT,
    year_of_study INT,
    classroom VARCHAR(50),
    instructor_id VARCHAR(20),
    CONSTRAINT check_course_year CHECK (year_of_study BETWEEN 1 AND 4),
    FOREIGN KEY(instructor_id) REFERENCES instructor(instructor_id)
);

INSERT INTO course (course_id, title, description, year_of_study, classroom, instructor_id)
VALUES 
  ('CS101', 'Computer Science', 'Programming and Coding', 2, "SCC-108", 'INS-1'),
  ('CVE202', 'Civil Engineering', 'Construction', 2, "EMB-108", 'INS-2'),
  ('BIO301', 'Biology', 'Study of Living Things', 3, "BIc-108", 'INS-3'),
  ('PHAR401', 'Pharmacy', 'Study of drugs and medicine', 4, 'MED-108', 'INS-4'),
  ('MED402', 'Medicical Science', 'Study of the human body, diseases, diagnosis, treatment, and prevention of illnesses', 4, 'MED-208', 'INS-4'),
  ('ELEC102', 'Electric Engineering', 'study, design, and application of equipment, devices, and systems which use electricity, electronics, and electromagnetism.', 1, "EMB-108", 'INS-5'),
  ('AGR302', 'Agriculture Studies', 'Study of Agriculture', 3, "BIc-108", 'INS-6'),
  ('REAL401', 'Real Estate', 'Study of drugs and medicine', 4, 'OCP-108', 'INS-6'),
  ('COMM101', 'Journalism', 'Study of journalism and communications', 1, "EMB-108", 'INS-7'),
  ('ARCH101', 'Archeology', 'Study of the human past using material remains', 1, "BIc-108", 'INS-7');

SELECT * FROM course;

DROP TABLE teaching_assistant;
CREATE TABLE teaching_assistant(
    ta_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    department VARCHAR(20),
    office_room VARCHAR(10),
    phone_extension INT,
    email VARCHAR(55) UNIQUE,
    student_id VARCHAR(10),
    FOREIGN KEY(student_id) REFERENCES student(student_id)
);

INSERT INTO teaching_assistant (ta_id, name, department, office_room, phone_extension, email, student_id)
VALUES 
  ('TA-1', 'John Doe', 'COPAS', 'SCC-100', 0987654322, 'JohnDoe67@gmail.com', 'STU-1'),
  ('TA-2', 'Jane Smith', 'COHRED', 'COH-100', 0722863792, 'Janesmith@gmail.com','STU-2'),
  ('TA-3', 'Glen Kinyua', 'COHRED', 'EMB-100', 0770059322, 'GlenKinyua007@gmail.com', 'STU-4'),
  ('TA-4', 'Eddie Kinya', 'COHES', 'SCC-100', 0987654322, 'EddieKinyua67@gmail.com', 'STU-5'),
  ('TA-5', 'Jacyres Tagaeryan', 'COHRED', 'COH-100', 0722863792, 'JacerysTagaeryan@gmail.com','STU-8'),
  ('TA-6', 'Onyango opiyo', 'COHRED', 'EMB-100', 0770059322, 'OnyangoOpiyo007@gmail.com', 'STU-7'),
  ('TA-7', 'Jon Snow', 'COHRED', 'EMB-100', 0735548942, 'JohnSnow@gmail.com', 'STU-10');

SELECT * FROM teaching_assistant;

DROP TABLE tutorial_section;
CREATE TABLE tutorial_section(
    ts_id VARCHAR(10) PRIMARY KEY,
    course_id VARCHAR(10),
    ta_id VARCHAR(10),
    FOREIGN KEY(ta_id) REFERENCES teaching_assistant(ta_id),
    FOREIGN KEY(course_id) REFERENCES course(course_id)
);

INSERT INTO tutorial_section (ts_id, course_id, ta_id)
VALUES 
  ('CS101-5', 'CS101', 'TA-1'),
  ('CVE202-5', 'CVE202', 'TA-2'),
  ('BIO301-5', 'BIO301', 'TA-3'),
  ('PHAR401-5', 'PHAR401', 'TA-4'),
  ('ELEC102-5', 'BIO301', 'TA-5'),
  ('AGR302-5', 'PHAR401', 'TA-6'),
  ('MED402-5', 'MED402', 'TA-7');

SELECT * FROM tutorial_section;

DROP TABLE lab_assistant;
CREATE TABLE lab_assistant(
    la_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    department VARCHAR(20),
    office_room VARCHAR(10),
    phone_extension INT,
    student_id VARCHAR(10),
    FOREIGN KEY(student_id) REFERENCES student(student_id)
);

INSERT INTO lab_assistant (la_id, name, department, office_room, phone_extension, student_id)
VALUES 
  ('LA-1', 'John Doe', 'COPAS', 'SCC-100', 0987654322, 'STU-1'),
  ('LA-2', 'Jane Smith', 'COHRED', 'COH-100', 0722863792,'STU-2'),
  ('LA-3', 'Eddie Kinuthia', 'COHRED', 'EMB-100', 0770059322, 'STU-5'),
  ('LA-4', 'Ligma Johnson', 'COPAS', 'SCC-100', 0987654322, 'STU-3'),
  ('LA-5', 'Glen Kinyua', 'COHRED', 'COH-100', 0722863792,'STU-4'),
  ('LA-6', 'Glen Kinyua', 'COHRED', 'EMB-100', 0770059322, 'STU-4'),
  ('LA-7', 'Onyango opiyo', 'COHRED', 'EMB-100', 0735548942, 'STU-7');

SELECT * FROM lab_assistant;

DROP TABLE lab_section;
CREATE TABLE lab_section(
    ls_id VARCHAR(20) PRIMARY KEY,
    course_id VARCHAR(10),
    la_id VARCHAR(10),
    FOREIGN KEY(la_id) REFERENCES lab_assistant(la_id),
    FOREIGN KEY(course_id) REFERENCES course(course_id)
);

INSERT INTO lab_section (ls_id, course_id, la_id)
VALUES 
  ('CS101-5-LAB', 'CS101', 'LA-1'),
  ('CVE202-5-LAB', 'CVE202', 'LA-2'),
  ('BIO301-5-LAB', 'BIO301', 'LA-2'),
  ('PHAR401-5-LAB', 'PHAR401', 'LA-3'),
  ('MED402-5-LAB', 'MED402', 'LA-1'),
  ('ELEC102-5-LAB', 'ELEC102', 'LA-4'),
  ('AGR302-5-LAB', 'AGR302', 'LA-5'),
  ('REAL401-5-LAB', 'REAL401', 'LA-6'),
  ('ARCH101-5-LAB', 'ARCH101', 'LA-7');

SELECT * FROM lab_section;


--The PRIMARY KEY constraint is used to define a composite primary key consisting of both columns.
--This ensures that each row in the table is unique and can be identified by a combination of the course_id and prerequisite_id/antirequisite_id values.
DROP TABLE course_prerequisite;
CREATE TABLE course_prerequisite(
    prerequisite_id VARCHAR(10),
    course_id VARCHAR(10),
    PRIMARY KEY(prerequisite_id, course_id),
    FOREIGN KEY(course_id) REFERENCES course(course_id)
);

INSERT INTO course_prerequisite(prerequisite_id, course_id)
VALUES
('BIO202', 'BIO301'),
('CVE201', 'CVE202'),
('MED401', 'MED402'),
('PHAR301', 'PHAR401'),
('ELEC101', 'ELEC102'),
('AGR301', 'AGR302'),
('REAL302', 'REAL401');
SELECT * FROM course_prerequisite;

DROP TABLE course_antirequisite;
CREATE TABLE course_antirequisite(
    antirequisite_id VARCHAR(10),
    course_id VARCHAR(10),
    PRIMARY KEY(course_id, antirequisite_id),
    FOREIGN KEY(course_id) REFERENCES course(course_id)
);
INSERT INTO course_antirequisite(antirequisite_id, course_id)
VALUES
('CS101', 'CS101'),
('COMM101', 'COMM101'),
('ARCH101', 'ARCH101');
SELECT * FROM course_antirequisite;

DROP TABLE course_registration;
--ENUM is used in the grade variable to specify that the column can only take two values: 'pass' or 'fail'
CREATE TABLE course_registration(
    student_id VARCHAR(10),
    course_id VARCHAR(10),
    grade ENUM('pass', 'fail'),
    PRIMARY KEY(student_id, course_id),
    FOREIGN KEY(student_id) REFERENCES student(student_id),
    FOREIGN KEY(course_id) REFERENCES course(course_id)
);

INSERT INTO course_registration(student_id, course_id, grade)
VALUES
('STU-1', 'CS101', 'pass'),
('STU-2', 'CVE202', 'pass'),
('STU-3', 'BIO301', 'pass'),
('STU-4', 'REAL401', 'pass'),
('STU-5', 'COMM101', 'pass'),
('STU-6', 'CVE202', 'fail'),
('STU-7', 'MED402', 'pass'),
('STU-8', 'CVE202', 'pass'),
('STU-9', 'AGR302', 'pass'),
('STU-10', 'PHAR401', 'pass');

SELECT * FROM course_registration;
