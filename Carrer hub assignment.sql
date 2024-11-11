--CREATE  A DATABASE CARRER HUB
CREATE DATABASE CARRERHUB

-- Create Companies table
CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(40) NOT NULL,
    Location VARCHAR(50)
);


-- Create Jobs table
CREATE TABLE Jobs (
    JobID INT PRIMARY KEY,
    CompanyID INT,
    JobTitle VARCHAR(30) NOT NULL,
    JobDescription TEXT,
    JobLocation VARCHAR(40),
    Salary DECIMAL(10, 2) CHECK (Salary >= 0),
    JobType VARCHAR(50),
    PostedDate DATETIME,
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);


-- Create Applicants table
CREATE TABLE Applicants (
    ApplicantID INT PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Email VARCHAR(40) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    Resume TEXT
);

ALTER TABLE Applicants
ADD YearsOfExperience INT;

UPDATE Applicants
SET YearsOfExperience = 3
WHERE ApplicantID = 1;  


-- Create Applications table
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

-- Insert sample values into Companies table
INSERT INTO Companies (CompanyID, CompanyName, Location) VALUES
(1, 'Hexaware Technologies', 'Chennai'),
(2, 'Cognizant', 'Bangalore'),
(3, 'Tech Maheindra', 'Hyderabad'),
(4, 'Capgemini', 'Chennai'),
(5, 'Accenture', ' Hyderabad');
SELECT * FROM  Companies

-- Insert sample values into Jobs table
INSERT INTO Jobs (JobID, CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate) VALUES
(1, 1, 'Software Developer', 'use programming and design to build software', 'Chennai', 80000.00, 'Full-time', '2024-11-20 09:00:00'),
(2, 1, 'Data Scientist', 'Analyze data ', 'Bangalore', 130000.00, 'Full-time', '2024-08-05 10:00:00'),
(3, 2, 'Graphic Designer', 'Create designs', 'Hyderabad', 8000.00, 'Part-time', '2024-10-23 7:00:00'),
(4, 3, 'Project Manager', 'plan and organize the project within time', 'Bangalore', 150000.00, 'Full-time', '2023-04-15 8:00:00'),
(5, 4, 'Software Tester', 'software needs specifications and requirements', 'Chennai', 105000.00, 'Full-time', '2023-05-10 10:00:00'),
(6, 5, 'Software Engineer', 'Develop and maintain software applications', 'Hyderabad', 140000.00, 'Part-time', '2023-07-25 19:00:00');
SELECT * FROM Jobs

-- Insert sample values into Applicants table
INSERT INTO Applicants (ApplicantID, FirstName, LastName, Email, Phone, Resume,YearsOfExperience) VALUES
(1, 'Rishitha', 'Sannapureddy', 'rishi@example.com', '283-878-8485', 'Selected',3),
(2, 'Aryann', ' Kavalreddy', 'aryann@example.com', '985-8679-9587', 'Selected',4),
(3, 'Ashwin', 'Kandukuri', 'ashwin@example.com', '987-757-8876', 'Rejected',3),
(4, 'Cherry', 'Kankanala', 'cherry@example.com', '986-865-8756', 'Selected',2),
(5, 'Sushwanth', 'Yettigadda', 'sush145@example.com', '967-856-8677', 'Rejected',3);
SELECT * FROM Applicants
DELETE FROM Applicants

-- Insert sample values into Applications table
INSERT INTO Applications ( JobID, ApplicantID, ApplicationDate, CoverLetter) VALUES
(1,1, 1, '2024-11-02 09:30:00', 'I am very interested in the Software Developer position'),
(2,2, 2, '2024-08-06 10:15:00', 'I would love to apply for the Data Scientist role'),
(3, 3, 1, '2024-06-11 08:45:00', 'I am very interested in the Graphics Designer position'),
(4,4, 3, '2024-05-16 09:30:00', 'I am excited to apply for the Project Manager role'),
 (5,5, 4, '2024-10-12 10:00:00', 'I am very interested in the Software Tester position'),
( 6,6, 5, '2023-10-26 06:20:00', 'I am very interested in the Software Engineer position');
SELECT * FROM Applications

--1.Provide a SQL script that initializes the database for the Job Board scenario “CareerHub”.  
CREATE DATABASE CareerHub;

--2.Create tables for Companies, Jobs, Applicants and Applications. 
Already created

--3Define appropriate primary keys, foreign keys, and constraints. 
This already done in the above tables

--4.	Ensure the script handles potential errors, such as if the database or table
CREATE TABLE Applicants (
    ApplicantID INT PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Email VARCHAR(40) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    Resume TEXT,
    YearsOfExperience INT  
);
DELETE FROM Applicants;

--5.	5.	Write an SQL query to count the number of applications received for each job listing in the "Jobs" table. Display the job title and the corresponding application count.
--Ensure that it lists all jobs, even if they have no applications. 
SELECT j.JobTitle, COUNT(a.ApplicationID) AS ApplicationCount
FROM Jobs j
LEFT JOIN Applications a ON j.JobID = a.JobID
GROUP BY j.JobID, j.JobTitle;

--6.	Develop an SQL query that retrieves job listings from the "Jobs" table within a specified salary range. Allow parameters for the minimum and maximum salary values.
--Display the job title, company name, location, and salary for each matching job.
SELECT j.JobTitle, 
       c.CompanyName, 
       j.JobLocation, 
       j.Salary
FROM Jobs j
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE j.Salary BETWEEN 80000 AND 130000;

--7.	Write an SQL query that retrieves the job application history for a specific applicant. 
--Allow a parameter for the ApplicantID, and return a result set with the job titles, company names, and application dates for all the jobs the applicant has applied to. 
DECLARE @ApplicantID INT = 1;

SELECT j.JobTitle, c.CompanyName, a.ApplicationDate
FROM Applications a
JOIN Jobs j 
ON a.JobID = j.JobID
JOIN Companies c 
ON j.CompanyID = c.CompanyID
WHERE a.ApplicantID = 3;

SELECT * FROM Jobs;
SELECT * FROM Companies;
SELECT * FROM Applications;
--8.	Create an SQL query that calculates and displays the average salary offered by all companies for job listings in the "Jobs" table. Ensure that the query filters out jobs with a salary of zero. 
SELECT AVG(Salary) AS AverageSalary
FROM Jobs
WHERE Salary > 0;


--9.	Write an SQL query to identify the company that has posted the most job listings. Display the company name along with the count of job listings they have posted. 
--Handle ties if multiple companies have the same maximum count. 
SELECT c.CompanyName, COUNT(j.JobID) AS Job_Count
FROM Jobs j
JOIN Companies c 
ON j.CompanyID = c.CompanyID
GROUP BY c.CompanyName
ORDER BY Job_Count DESC;

--10.	Find the applicants who have applied for positions in companies located in 'CityX' and have at least 3 years of experience
-- Declare the @cityX parameter (replace 'CityX' with the desired city name)
DECLARE @cityX VARCHAR(50) = 'CityX';

SELECT a.FirstName, 
       a.LastName
FROM Applications app
JOIN Jobs j ON app.JobID = j.JobID
JOIN Applicants a ON app.ApplicantID = a.ApplicantID
WHERE j.JobLocation = @cityX 
  AND a.YearsOfExperience >= 3;

--11.	Retrieve a list of distinct job titles with salaries between $60,000 and $80,000. 
SELECT DISTINCT JobTitle
FROM Jobs
WHERE Salary BETWEEN 60000 AND 80000;

--12.Find the jobs that have not received any applications
SELECT JobID, 
       JobTitle, 
       CompanyID, 
       JobLocation, 
       Salary
FROM Jobs
WHERE JobID NOT IN (SELECT JobID FROM Applications);

--13.Retrieve a list of job applicants along with the companies they have applied to and the positions they have applied for
SELECT a.ApplicantID, a.FirstName, a.LastName, c.CompanyName, j.JobTitle
FROM Applicants a
JOIN Applications app ON a.ApplicantID = app.ApplicantID
JOIN Jobs j ON app.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID;

--14Retrieve a list of companies along with the count of jobs they have posted, even if they have not received any applications. 
SELECT c.CompanyID,
       c.CompanyName,
       COUNT(j.JobID) AS JobCount
FROM Companies c
LEFT JOIN Jobs j ON c.CompanyID = j.CompanyID
GROUP BY c.CompanyID, c.CompanyName;

--15List all applicants along with the companies and positions they have applied for, including those who have not applied. 
SELECT a.ApplicantID,
       a.FirstName,
       a.LastName,
       c.CompanyName,
       j.JobTitle
FROM Applicants a
LEFT JOIN Applications app ON a.ApplicantID = app.ApplicantID
LEFT JOIN Jobs j ON app.JobID = j.JobID
LEFT JOIN Companies c ON j.CompanyID = c.CompanyID;

--16Find companies that have posted jobs with a salary higher than the average salary of all jobs.
SELECT DISTINCT c.CompanyID,
                c.CompanyName
FROM Companies c
JOIN Jobs j ON c.CompanyID = j.CompanyID
WHERE j.Salary > (SELECT AVG(Salary) FROM Jobs);

SELECT * FROM Applicants;
SELECT * FROM Jobs;
SELECT * FROM Applications;

--18Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'.
SELECT JobID,
       JobTitle,
       CompanyID,
       Salary
FROM Jobs
WHERE JobTitle LIKE '%Developer%'
   OR JobTitle LIKE '%Engineer%';

 -- 19.Retrieve a list of applicants and the jobs they have applied for, including those who have not applied and jobs without applicants. 
   SELECT a.FirstName, a.LastName, j.JobTitle
FROM Applicants a
FULL JOIN Applications app 
ON a.ApplicantID = app.ApplicantID
FULL JOIN Jobs j 
ON app.JobID = j.JobID;

   
--20.List all combinations of applicants and companies where the company is in a specific city and the applicant has more than 2 years of experience. For example: city=Chennai 
   SELECT 
    a.ApplicantID, 
    a.FirstName, 
    a.LastName, 
    c.CompanyName, 
    j.JobTitle
FROM Applicants a
JOIN Applications app ON a.ApplicantID = app.ApplicantID
JOIN Jobs j ON app.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID;
