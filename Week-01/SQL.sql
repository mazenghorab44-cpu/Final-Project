Create database HR_Project;
Use HR_Project;
CREATE TABLE Employee (
    EmployeeID VARCHAR(20) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(20),
    Age INT,
    BusinessTravel VARCHAR(100),
    Department VARCHAR(100),
    DistanceFromHome_KM INT,
    State VARCHAR(100),
    Ethnicity VARCHAR(100),
    Education INT,
    EducationField VARCHAR(100),
    JobRole VARCHAR(100),
    MaritalStatus VARCHAR(50),
    Salary DECIMAL(12,2),
    StockOptionLevel INT,
    OverTime VARCHAR(5),
    HireDate DATE,
    Attrition VARCHAR(5),
    YearsAtCompany INT,
    YearsInMostRecentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
)
/*
======================================
exploration and cleaninig the Employees table
======================================
 */
SELECT TOP 10 * FROM dbo.Employee_temp
UPDATE Employee_temp
SET
BusinessTravel = TRIM(BusinessTravel),
EducationField = TRIM(EducationField),
Ethnicity = TRIM(Ethnicity)
SELECT DISTINCT BusinessTravel FROM Employee_temp;
SELECT DISTINCT EducationField FROM dbo.Employee_temp;
SELECT DISTINCT Ethnicity FROM dbo.Employee_temp;

ALTER TABLE dbo.Employee_temp
ADD
OverTime_Text VARCHAR(5),
Attrition_Text VARCHAR(5);

UPDATE dbo.Employee_temp
SET
OverTime_Text = CASE 
    When OverTime = 1 THEN 'Yes'
	ELSE 'NO'
END,
Attrition_Text = CASE 
WHEN Attrition = 1 THEN 'Yes'
ELSE 'No'
END;

SELECT TOP 10 
    OverTime, OverTime_Text,
    Attrition, Attrition_Text
FROM dbo.Employee_temp;

INSERT INTO dbo.Employee (
    EmployeeID,
    FirstName,
    LastName,
    Gender,
    Age,
    BusinessTravel,
    Department,
    DistanceFromHome_KM,
    State,
    Ethnicity,
    Education,
    EducationField,
    JobRole,
    MaritalStatus,
    Salary,
    StockOptionLevel,
    OverTime,
    HireDate,
    Attrition,
    YearsAtCompany,
    YearsInMostRecentRole,
    YearsSinceLastPromotion,
    YearsWithCurrManager
)
SELECT
    EmployeeID,
    FirstName,
    LastName,
    Gender,
    Age,
    BusinessTravel,
    Department,
    DistanceFromHome_KM,
    State,
    Ethnicity,
    Education,
    EducationField,
    JobRole,
    MaritalStatus,
    Salary,
    StockOptionLevel,
    OverTime_Text,   
    HireDate,
    Attrition_Text,  
    YearsAtCompany,
    YearsInMostRecentRole,
    YearsSinceLastPromotion,
    YearsWithCurrManager
FROM dbo.Employee_temp;

SELECT TOP 10 OverTime, Attrition FROM dbo.Employee;

SELECT COUNT(*) AS total_rows FROM dbo.Employee;
SELECT COUNT(*) AS total_rows FROM dbo.Employee_temp;

SELECT DISTINCT OverTime, Attrition FROM dbo.Employee;

SELECT
    SUM(CASE WHEN EmployeeID IS NULL THEN 1 ELSE 0 END) AS null_id,
    SUM(CASE WHEN Salary IS NULL THEN 1 ELSE 0 END) AS null_salary
FROM dbo.Employee;

SELECT COUNT(*) - COUNT(DISTINCT EmployeeID) AS duplicates
FROM dbo.Employee;

-- PerformanceRating
CREATE TABLE PerformanceRating (
    PerformanceID VARCHAR(20) PRIMARY KEY,
    EmployeeID VARCHAR(20),
    ReviewDate DATE,
    EnvironmentSatisfaction INT,
    JobSatisfaction INT,
    RelationshipSatisfaction INT,
    TrainingOpportunitiesWithinYear INT,
    TrainingOpportunitiesTaken INT,
    WorkLifeBalance INT,
    SelfRating INT,
    ManagerRating INT
);


SELECT DISTINCT pt.EmployeeID
FROM PerformanceRating_temp pt
LEFT JOIN Employee e 
ON pt.EmployeeID = e.EmployeeID
WHERE e.EmployeeID IS NULL;


SELECT TOP 10 * FROM PerformanceRating_temp;

SELECT DISTINCT ReviewDate FROM PerformanceRating_temp;

SELECT DISTINCT EmployeeID FROM PerformanceRating_temp;

SELECT DISTINCT SelfRating, ManagerRating FROM PerformanceRating_temp;

SELECT 
    MIN(SelfRating), MAX(SelfRating),
    MIN(ManagerRating), MAX(ManagerRating)
FROM PerformanceRating_temp;

INSERT INTO PerformanceRating (
    PerformanceID,
    EmployeeID,
    ReviewDate,
    EnvironmentSatisfaction,
    JobSatisfaction,
    RelationshipSatisfaction,
    TrainingOpportunitiesWithinYear,
    TrainingOpportunitiesTaken,
    WorkLifeBalance,
    SelfRating,
    ManagerRating
)
SELECT
    PerformanceID,
    EmployeeID,
    ReviewDate,
    EnvironmentSatisfaction,
    JobSatisfaction,
    RelationshipSatisfaction,
    TrainingOpportunitiesWithinYear,
    TrainingOpportunitiesTaken,
    WorkLifeBalance,
    SelfRating,
    ManagerRating
FROM PerformanceRating_temp;

SELECT COUNT(*) FROM PerformanceRating;
SELECT COUNT(*) FROM PerformanceRating_temp;


ALTER TABLE PerformanceRating
ADD CONSTRAINT FK_Performance_Employee
FOREIGN KEY (EmployeeID)
REFERENCES Employee(EmployeeID);

INSERT INTO PerformanceRating (PerformanceID, EmployeeID)
VALUES ('TEST_FAIL', 'XXXX-XXXX');

CREATE TABLE EducationLevel (
    EducationLevelID INT PRIMARY KEY,
    EducationLevel VARCHAR(100)
);

INSERT INTO EducationLevel VALUES
(1, 'No Formal Qualifications'),
(2, 'High School'),
(3, 'Bachelors'),
(4, 'Masters'),
(5, 'Doctorate');


CREATE TABLE RatingLevel (
    RatingID INT PRIMARY KEY,
    RatingLevel VARCHAR(100)
);

INSERT INTO RatingLevel VALUES
(1, 'Unacceptable'),
(2, 'Needs Improvement'),
(3, 'Meets Expectation'),
(4, 'Exceeds Expectation'),
(5, 'Above and Beyond');

CREATE TABLE SatisfiedLevel (
    SatisfactionID INT PRIMARY KEY,
    SatisfactionLevel VARCHAR(100)
);

INSERT INTO SatisfiedLevel VALUES
(1, 'Very Dissatisfied'),
(2, 'Dissatisfied'),
(3, 'Neutral'),
(4, 'Satisfied'),
(5, 'Very Satisfied');

