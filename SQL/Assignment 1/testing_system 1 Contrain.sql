
DROP DATABASE IF EXISTS TESTING_SYSTEM_ASSIGNMENT_1;
CREATE DATABASE TESTING_SYSTEM_ASSIGNMENT_1;
USE	TESTING_SYSTEM_ASSIGNMENT_1;

-- CREATE TABLE: DEPARTMENT	
CREATE TABLE DEPARTMENT (
DEPARTMENT_ID	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
DEPARTMENT_NAME	VARCHAR (20) UNIQUE KEY NULL
);

-- CREATE TABLE: POSITION	
CREATE TABLE POSITION (
POSITION_ID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
POSITION_NAME	ENUM ('DEV', 'TEST', 'SCRUM MASTER', 'PM') NOT NULL
);

-- CREATE TABLE: ACCOUNT
CREATE TABLE `ACCOUNT` (
ACCOUNT_ID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
EMAIL			VARCHAR (50) UNIQUE KEY DEFAULT ('KHONG CO MAIL'),
USER_NAME		VARCHAR (50) UNIQUE KEY NOT NULL CHECK (LENGTH(USER_NAME)>=6),
FULL_NAME		VARCHAR (50) NOT NULL,
DEPARTMENT_ID	TINYINT UNSIGNED,
POSITION_ID		TINYINT UNSIGNED,
CREATE_DATE		DATETIME DEFAULT NOW(),
GENDER			VARCHAR(50),
FOREIGN KEY	(DEPARTMENT_ID) REFERENCES DEPARTMENT (DEPARTMENT_ID) ON DELETE CASCADE,
FOREIGN KEY	(POSITION_ID) REFERENCES POSITION (POSITION_ID)
);

-- CREATE TABLE: GROUP
CREATE TABLE `GROUP` (
GROUP_ID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
GROUP_NAME		VARCHAR (50) NOT NULL CHECK (LENGTH(GROUP_NAME)>=6),
CREATOR_ID		TINYINT UNSIGNED NOT NULL,
CREATE_DATE		DATE DEFAULT (CURRENT_DATE),
FOREIGN KEY (CREATOR_ID) REFERENCES `ACCOUNT` (ACCOUNT_ID) ON DELETE CASCADE
);

-- CREATE TABLE: GROUPACCOUNT
CREATE TABLE GROUPACCOUNT (
GROUP_ID		TINYINT UNSIGNED,
ACCOUNT_ID		TINYINT UNSIGNED DEFAULT (1),
CREATE_DATE		DATETIME DEFAULT NOW(),
PRIMARY KEY (GROUP_ID, ACCOUNT_ID),
FOREIGN KEY	(GROUP_ID) REFERENCES `GROUP` (GROUP_ID) ON DELETE CASCADE,
FOREIGN KEY	(ACCOUNT_ID) REFERENCES `ACCOUNT` (ACCOUNT_ID) ON DELETE CASCADE
);

-- CREATE TABLE: TYPEQUESTION
CREATE TABLE TYPEQUESTION (
TYPE_ID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
TYPE_NAME		ENUM ('ESSAY', 'MULTIPLE-CHOICE') NOT NULL
);

-- CREATE TABLE: CATEGORYQUESTION
CREATE TABLE CATEGORYQUESTION (
CATEGORY_ID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
CATEGORY_NAME	NVARCHAR (50) NOT NULL DEFAULT ('chua xac dinh')
);

-- CREATE TABLE: QUESTION
CREATE TABLE Question (
QUESTION_ID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
CONTENT			VARCHAR (50) NOT NULL CHECK (LENGTH(CONTENT)>=6),
Category_ID		TINYINT UNSIGNED DEFAULT (1),
TYPE_ID			TINYINT UNSIGNED DEFAULT (1),-- Default: Doi phe duyet
CREATOR_ID		TINYINT UNSIGNED CHECK (CREATOR_ID<=10),
CREATE_DATE		DATE DEFAULT (CURRENT_DATE),
FOREIGN KEY	(CATEGORY_ID) REFERENCES CATEGORYQUESTION (CATEGORY_ID)
);

-- CREATE TABLE: ANSWER
CREATE TABLE ANSWER (
ANSWER_ID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
CONTENT			VARCHAR (500) NOT NULL CHECK (LENGTH(CONTENT)>=6),
Question_ID		TINYINT UNSIGNED,
isCorrect		ENUM ('T', 'F'),
FOREIGN KEY	(Question_ID) REFERENCES Question (Question_ID)
);

-- CREATE TABLE: EXAM
CREATE TABLE EXAM (
EXAM_ID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
`CODE`			CHAR (10) UNIQUE KEY DEFAULT('CHUA UPDATE'),
TITLE			VARCHAR (50),
CATEGORY_ID		TINYINT UNSIGNED,
DURATION		TINYINT UNSIGNED,
CREATOR_ID		TINYINT UNSIGNED,
CREATE_DATE		DATE DEFAULT (CURRENT_DATE)
);

-- CREATE TABLE: EXAMQUESTION
CREATE TABLE EXAMQUESTION (
EXAM_ID			TINYINT UNSIGNED DEFAULT(2), -- Default: Chua update
QUESTION_ID		TINYINT UNSIGNED,
PRIMARY KEY (EXAM_ID, QUESTION_ID),
FOREIGN KEY	(EXAM_ID) REFERENCES EXAM (EXAM_ID) ON DELETE CASCADE,
FOREIGN KEY	(QUESTION_ID) REFERENCES QUESTION (QUESTION_ID)
);