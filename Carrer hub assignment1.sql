
--CREATE DATABSE CareerHub
    CREATE DATABASE CareerHub;

-- Drop tables if they already exist to handle potential errors
IF OBJECT_ID('Applications', 'U') IS NOT NULL DROP TABLE Applications;
IF OBJECT_ID('Jobs', 'U') IS NOT NULL DROP TABLE Jobs;
IF OBJECT_ID('Applicants', 'U') IS NOT NULL DROP TABLE Applicants;
IF OBJECT_ID('Companies', 'U') IS NOT NULL DROP TABLE Companies;



-- 2.Create tables for Companies, Jobs, Applicants and Applications. 
CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL
);

--  - Creating Jobs table
CREATE TABLE Jobs (
    JobID INT PRIMARY KEY,
    CompanyID INT,
    JobTitle VARCHAR(255) NOT NULL,
    JobDescription TEXT,
    JobLocation VARCHAR(255),
    Salary DECIMAL(18, 2),
    JobType VARCHAR(50),
    PostedDate DATETIME,
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);
DROP TABLE Jobs

-- - Creating Applicants table

CREATE TABLE Applicants (
    ApplicantID INT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    Phone VARCHAR(20),
    Resume TEXT
);

--  - Creating Applications table

CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY,
    JobID INT,
    ApplicantID INT,
    ApplicationDate DATETIME,
    CoverLetter TEXT,
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID)
);
DROP TABLE Applications

-- Inserting records into Companies table
INSERT INTO Companies (CompanyID, CompanyName, Location) VALUES
(1, 'Hexaware Technologies', 'Chennai'),
(2, 'Cognizant', 'Bangalore'),
(3, 'Tech Maheindra', 'Hyderabad'),
(4, 'Capgemini', 'Chennai'),
(5, 'Accenture', ' Hyderabad');

SELECT * FROM Companies;

-- Inserting records into Jobs table
INSERT INTO Jobs (JobID, CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate) VALUES
(1, 1, 'Software Developer', 'use programming and design to build software', 'Chennai', 80000.00, 'Full-time', '2024-11-20 '),
(2, 1, 'Data Scientist', 'Analyze data ', 'Bangalore', 130000.00, 'Full-time', '2024-08-05 10:00:00'),
(3, 2, 'Graphic Designer', 'Create designs', 'Hyderabad', 8000.00, 'Part-time', '2024-10-23 7:00:00'),
(4, 3, 'Project Manager', 'plan and organize the project within time', 'Bangalore', 150000.00, 'Full-time', '2023-04-15 '),
(5, 4, 'Software Tester', 'software needs specifications and requirements', 'Chennai', 105000.00, 'Full-time', '2023-05-10');


SELECT * FROM Jobs;

-- Inserting records into Applicants table
INSERT INTO Applicants (ApplicantID, FirstName, LastName, Email, Phone, Resume) VALUES
(1, 'Rishitha', 'Sannapureddy', 'rishi@example.com', '283-878-8485', 'Selected'),
(2, 'Aryann', ' Kavalreddy', 'aryann@example.com', '985-8679-9587', 'Selected'),
(3, 'Ashwin', 'Kandukuri', 'ashwin@example.com', '987-757-8876', 'Rejected'),
(4, 'Cherry', 'Kankanala', 'cherry@example.com', '986-865-8756', 'Selected'),
(5, 'Sushwanth', 'Yettigadda', 'sush145@example.com', '967-856-8677', 'Rejected');
SELECT * FROM Applicants

-- Inserting records into Applications table
INSERT INTO Applications 
  (ApplicationID, JobID, ApplicantID, ApplicationDate, CoverLetter) VALUES 
  (1, 1, 1, '2023-11-11', 'I am very interested in the Software Developer position'),
  (2, 2, 2, '2023-11-12', 'I would love to apply for the Data Scientist role'),
  (3, 3, 3, '2023-11-13', 'I am very interested in the Graphics Designer position'),
  (4, 4, 4, '2023-11-14', 'I am very interested in the Project Manager position'),
  (5, 5, 5, '2023-11-15', 'I am very interested in the Software Tester position');

SELECT * FROM Applications;
DELETE FROM Applications


-- 3. Define appropriate primary keys, foreign keys, and constraints.
-- The primary keys and foreign keys are already defined within the table creation itself

-- 5. Write an SQL query to count the number of applications received for each job listing in the "Jobs" table. Display 
--the job title and the corresponding application count. Ensure that it lists all jobs, even if they have no applications. 

SELECT j.JobTitle, COUNT(a.ApplicationID) AS ApplicationCount
FROM Jobs j
LEFT JOIN Applications a
ON j.JobID = a.JobID
GROUP BY j.JobTitle;

SELECT * FROM Jobs;
SELECT * FROM Applications;


-- 6. Develop an SQL query that retrieves job listings from the "Jobs" table within a specified salary range.
 Allow parameters for the minimum and maximum salary values. Display the job title, company name,
 location, and salary for each matching job. */

DECLARE @MinSalary DECIMAL(18, 2) = 80000.00;
DECLARE @MaxSalary DECIMAL(18, 2) = 130000.00;

SELECT j.JobTitle, c.CompanyName, j.JobLocation, j.Salary
FROM Jobs j
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE j.Salary BETWEEN @MinSalary AND @MaxSalary;

--7. Write an SQL query that retrieves the job application history for a specific applicant. Allow aparameter for
 the ApplicantID, and return a result set with the job titles, company names, and application dates for all the 
 jobs the applicant has applied to. */
DECLARE @ApplicantID INT = 1;

SELECT j.JobTitle, c.CompanyName, a.ApplicationDate
FROM Applications a
JOIN Jobs j 
ON a.JobID = j.JobID
JOIN Companies c 
ON j.CompanyID = c.CompanyID
WHERE a.ApplicantID = @ApplicantID;

SELECT * FROM Jobs;
SELECT * FROM Companies;
SELECT * FROM Applications;


-- 8. Create an SQL query that calculates and displays the average salary offered by all companies for job listings in 
 --the "Jobs" table. Ensure that the query filters out jobs with a salary of zero. 

SELECT c.CompanyName, AVG(j.Salary) AS Average_Salary
FROM Jobs j
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE j.Salary > 0
GROUP BY c.CompanyName;


-- 9. Write an SQL query to identify the company that has posted the most job listings. Display the company name along 
 --with the count of job listings they have posted. Handle ties if multiple companies have the same maximum count. 

SELECT c.CompanyName, COUNT(j.JobID) AS Job_Count
FROM Jobs j
JOIN Companies c 
ON j.CompanyID = c.CompanyID
GROUP BY c.CompanyName
ORDER BY Job_Count DESC;

-- 10. Find the applicants who have applied for positions in companies located in 'CityX' and have at least 3 years of experience. 
SELECT * FROM Applicants;

ALTER TABLE Applicants
ADD YearsOfExperience INT;

UPDATE Applicants
SET YearsOfExperience = 
    CASE 
        WHEN ApplicantID = 1 THEN 2
        WHEN ApplicantID = 2 THEN 3
        WHEN ApplicantID = 3 THEN 5
		WHEN ApplicantID = 4 THEN 4
        WHEN ApplicantID = 5 THEN 3
        WHEN ApplicantID = 6 THEN 6
		WHEN ApplicantID = 7 THEN 3
        WHEN ApplicantID = 8 THEN 5
        WHEN ApplicantID = 9 THEN 4
		WHEN ApplicantID = 10 THEN 6
    END;

DECLARE @CityX VARCHAR(255) = 'Chennai';



-- 11. Retrieve a list of distinct job titles with salaries between $60,000 and $80,000. 

SELECT DISTINCT JobTitle
FROM Jobs
WHERE Salary BETWEEN 60000 AND 80000;

-- 12. Find the jobs that have not received any applications. 

SELECT j.JobTitle
FROM Jobs j
LEFT JOIN Applications a 
ON j.JobID = a.JobID
WHERE a.ApplicationID IS NULL;

-- 13. Retrieve a list of job applicants along with the companies they have applied to and the positions they have applied for. 

SELECT a.FirstName, a.LastName, c.CompanyName, j.JobTitle
FROM Applications app
JOIN Applicants a 
ON app.ApplicantID = a.ApplicantID
JOIN Jobs j 
ON app.JobID = j.JobID
JOIN Companies c 
ON j.CompanyID = c.CompanyID;

-- 14. Retrieve a list of companies along with the count of jobs they have posted, even if they have not received any applications. 

SELECT c.CompanyName, COUNT(j.JobID) AS JobCount
FROM Companies c
LEFT JOIN Jobs j 
ON c.CompanyID = j.CompanyID
GROUP BY c.CompanyName;

--15. List all applicants along with the companies and positions they have applied for, including those who have not applied. 

SELECT a.FirstName, a.LastName, c.CompanyName, j.JobTitle
FROM Applicants a
LEFT JOIN Applications app 
ON a.ApplicantID = app.ApplicantID
LEFT JOIN Jobs j 
ON app.JobID = j.JobID
LEFT JOIN Companies c 
ON j.CompanyID = c.CompanyID;

SELECT * FROM Applicants;
SELECT * FROM Applications;

-- 16. Find companies that have posted jobs with a salary higher than the average salary of all jobs. 

SELECT DISTINCT c.CompanyName
FROM Companies c
JOIN Jobs j 
ON c.CompanyID = j.CompanyID
WHERE j.Salary > (SELECT AVG(Salary) FROM Jobs WHERE Salary > 0);

 -- Display a list of applicants with their names and a concatenated string of their city and state. 
 --Question has been change by trainer instead (city and state) using (JobTitle and JobLocation) */

SELECT a.FirstName, a.LastName, CONCAT(j.JobTitle, ', ', j.JobLocation) AS JobTitleLocation
FROM Applications app
JOIN Jobs j ON app.JobID = j.JobID
JOIN Applicants a ON app.ApplicantID = a.ApplicantID;

SELECT * FROM Applicants;
SELECT * FROM Jobs;
SELECT * FROM Applications;

-- 18. Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'. 

SELECT JobTitle
FROM Jobs
WHERE JobTitle LIKE '%Developer%' OR JobTitle LIKE '%Engineer%';

/* 19. Retrieve a list of applicants and the jobs they have applied for, including those who have not applied and 
jobs without applicants. */

SELECT a.FirstName, a.LastName, j.JobTitle
FROM Applicants a
FULL JOIN Applications app 
ON a.ApplicantID = app.ApplicantID
FULL JOIN Jobs j 
ON app.JobID = j.JobID;

/* 20. List all combinations of applicants and companies where the company is in a specific city and the applicant has 
more than 2 years of experience. For example: city=Chennai */

DECLARE @City VARCHAR(255) = 'Chennai';

SELECT a.FirstName, a.LastName, c.CompanyName
FROM Applicants a
CROSS JOIN Companies c
WHERE c.Location = @City AND a.YearsOfExperience > 2;
