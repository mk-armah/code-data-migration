IF (
		SELECT SCHEMA_ID('standby')
		) IS NOT NULL

BEGIN
	DROP TABLE CoDE_Staging.[standby].ACUMEN_EOS_SEM2_IC;

	DROP TABLE CoDE_Staging.[standby].U_Q1_SEM2_IC;

	DROP TABLE CoDE_Staging.[standby].U_Q2_SEM2_IC;

	DROP TABLE CoDE_Staging.[standby].U_EOS_SEM2_IC;

	DROP TABLE CoDE_Staging.[standby].U_EOS_SEM1_IC;

	DROP TABLE CoDE_Staging.[standby].U_Q2_SEM1_IC;

	DROP TABLE CoDE_Staging.[standby].U_Q1__SEM1_IC;

	DROP TABLE CoDE_Staging.[standby].ACUMEN_Q1_SEM2;

	DROP TABLE CoDE_Staging.[standby].ACUMEN_Q2_SEM2_IC;

	DROP TABLE CoDE_Staging.[standby].ACUMEN_Q2_SEM1_IC;

	DROP TABLE CoDE_Staging.[standby].ACUMEN_Q1_SEM1_IC;

	DROP TABLE CoDE_Staging.[standby].ACUMEN_EOS_SEM1_IC;
	

	PRINT N'Droped all existing data from standby schema'
END 

BEGIN TRY /*creating tables*/
	PRINT ('--- CREATING STANDBY TABLES ---')
	
	CREATE TABLE CoDE_Staging.[standby].ACUMEN_EOS_SEM2_IC (
		Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		StudyCentre NVARCHAR(100)
		,RegistrationNumber NVARCHAR(25)
		,FullName NVARCHAR(100)
		,[Level] INT
		,DegreeTitle NVARCHAR(100)
		,CourseCode NVARCHAR(10)
		,CourseTitle NVARCHAR(100)
		,[Session] INT
		);

	CREATE TABLE CoDE_Staging.[standby].ACUMEN_EOS_SEM1_IC (
		Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		StudyCentre NVARCHAR(100)
		,RegistrationNumber NVARCHAR(25)
		,FullName NVARCHAR(100)
		,[Level] INT
		,DegreeTitle NVARCHAR(100)
		,CourseCode NVARCHAR(10)
		,CourseTitle NVARCHAR(100)
		,[Session] INT
		);
 
	CREATE TABLE CoDE_Staging.[standby].ACUMEN_Q1_SEM1_IC (
		Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		StudyCentre NVARCHAR(100)
		,RegistrationNumber NVARCHAR(25)
		,FullName NVARCHAR(100)
		,[Level] INT
		,DegreeTitle NVARCHAR(100)
		,CourseCode NVARCHAR(10)
		,CourseTitle NVARCHAR(100)
		,[Session] INT
		)

	CREATE TABLE CoDE_Staging.[standby].ACUMEN_Q2_SEM1_IC (
		Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		StudyCentre NVARCHAR(100)
		,RegistrationNumber NVARCHAR(25)
		,FullName NVARCHAR(100)
		,[Level] INT
		,DegreeTitle NVARCHAR(100)
		,CourseCode NVARCHAR(10)
		,CourseTitle NVARCHAR(100)
		,[Session] INT
		);

	CREATE TABLE CoDE_Staging.[standby].ACUMEN_Q2_SEM2_IC (
		Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		StudyCentre NVARCHAR(100)
		,RegistrationNumber NVARCHAR(25)
		,FullName NVARCHAR(100)
		,[Level] INT
		,DegreeTitle NVARCHAR(100)
		,CourseCode NVARCHAR(10)
		,CourseTitle NVARCHAR(100)
		,[Session] INT
		);

	CREATE TABLE CoDE_Staging.[standby].ACUMEN_Q1_SEM2 (
		Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		StudyCentre NVARCHAR(100)
		,RegistrationNumber NVARCHAR(25)
		,FullName NVARCHAR(100)
		,[Level] INT
		,DegreeTitle NVARCHAR(100)
		,CourseCode NVARCHAR(10)
		,CourseTitle NVARCHAR(100)
		,[Session] INT
		);

	CREATE TABLE CoDE_Staging.[standby].U_Q1__SEM1_IC (
		Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		StudyCentre NVARCHAR(100)
		,RegistrationNumber NVARCHAR(25)
		,FullName NVARCHAR(100)
		,[Level] INT
		,DegreeTitle NVARCHAR(100)
		,CourseCode NVARCHAR(10)
		,CourseTitle NVARCHAR(100)
		,[Session] INT
		)

	CREATE TABLE CoDE_Staging.[standby].U_Q2_SEM1_IC (
		Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		StudyCentre NVARCHAR(100)
		,RegistrationNumber NVARCHAR(25)
		,FullName NVARCHAR(100)
		,[Level] INT
		,DegreeTitle NVARCHAR(100)
		,CourseCode NVARCHAR(10)
		,CourseTitle NVARCHAR(100)
		,[Session] INT
		)

	CREATE TABLE CoDE_Staging.[standby].U_EOS_SEM1_IC (
		Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		StudyCentre NVARCHAR(100)
		,RegistrationNumber NVARCHAR(25)
		,FullName NVARCHAR(100)
		,[Level] INT
		,DegreeTitle NVARCHAR(100)
		,CourseCode NVARCHAR(10)
		,CourseTitle NVARCHAR(100)
		,[Session] INT
		)

	CREATE TABLE CoDE_Staging.[standby].U_EOS_SEM2_IC (
		Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		StudyCentre NVARCHAR(100)
		,RegistrationNumber NVARCHAR(25)
		,FullName NVARCHAR(100)
		,[Level] INT
		,DegreeTitle NVARCHAR(100)
		,CourseCode NVARCHAR(10)
		,CourseTitle NVARCHAR(100)
		,[Session] INT
		)

	CREATE TABLE CoDE_Staging.[standby].U_Q2_SEM2_IC (
		Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		StudyCentre NVARCHAR(100)
		,RegistrationNumber NVARCHAR(25)
		,FullName NVARCHAR(100)
		,[Level] INT
		,DegreeTitle NVARCHAR(100)
		,CourseCode NVARCHAR(10)
		,CourseTitle NVARCHAR(100)
		,[Session] INT
		)

	CREATE TABLE CoDE_Staging.[standby].U_Q1_SEM2_IC (
		Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		StudyCentre NVARCHAR(100)
		,RegistrationNumber NVARCHAR(25)
		,FullName NVARCHAR(100)
		,[Level] INT
		,DegreeTitle NVARCHAR(100)
		,CourseCode NVARCHAR(10)
		,CourseTitle NVARCHAR(100)
		,[Session] INT
		)
END TRY

BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrorNumber
		,ERROR_MESSAGE() AS ErrorMessage
END CATCH;/*----merged data*/
/**
IF (
		SELECT SCHEMA_ID('mergedbo')
		) IS NOT NULL
BEGIN
	DROP TABLE CoDE_Staging.mergedbo.Merged

	PRINT N'Droped all existing data from mergedbo schema'
END /*EXEC ('CREATE SCHEMA mergedbo;');*/

BEGIN TRY
	PRINT ('--- CREATING MERGED TABLE ---')

	CREATE TABLE CoDE_Staging.mergedbo.Merged (
		Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
		StudyCenter NVARCHAR(100)
		,RegistrationNumber INT
		,FirstName NVARCHAR(100)
		,LastName NVARCHAR(100) /*- lastname of the student*/
		,[Level] INT
		,DegreeType NVARCHAR(10) /*- Degree or Diploma*/
		,CourseCode NVARCHAR(100) /* the course code*/
		,CourseTitle NVARCHAR(100) /* name of the course being pursued  */
		,TestType NVARCHAR(100)
		,TestYear DATE
		,Program NVARCHAR(100) /*program being persued*/
		,Session INT /* distance or regular*/
		,Enrollmentyear DATE /* can be found in registration number*/
		,Semester INT
		)
END TRY

BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrorNumber
		,ERROR_MESSAGE() AS ErrorMessage
END CATCH;
**/

SELECT * FROM CoDE_Staging.[standby].U_Q2_SEM2_IC