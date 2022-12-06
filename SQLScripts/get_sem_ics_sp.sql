---Joins all ics data of first or second second semester

CREATE PROCEDURE standbydbo.GET_SEM_ICs @Semester INT
AS
	IF @Semester = 1
		GOTO FirstSemester;

	IF @Semester = 2
		GOTO SecondSemester;

	FirstSemester:

		SELECT *
		FROM CoDE_Staging.standbydbo.U_Q1__SEM1_IC

		UNION ALL

		SELECT *
		FROM CoDE_Staging.standbydbo.U_Q2_SEM1_IC

		UNION ALL

		SELECT *
		FROM CoDE_Staging.standbydbo.U_EOS_SEM1_IC

		UNION ALL

		SELECT *
		FROM CoDE_Staging.standbydbo.ACUMEN_EOS_SEM1_IC

		UNION ALL

		SELECT *
		FROM CoDE_Staging.standbydbo.ACUMEN_Q1_SEM1_IC

		UNION ALL

		SELECT *
		FROM CoDE_Staging.standbydbo.ACUMEN_Q2_SEM1_IC;

		RETURN

	SecondSemester:


		SELECT *
		FROM CoDE_Staging.standbydbo.ACUMEN_EOS_SEM2_IC

		UNION ALL

		SELECT *
		FROM CoDE_Staging.standbydbo.ACUMEN_Q2_SEM2_IC

		UNION ALL

		SELECT *
		FROM CoDE_Staging.standbydbo.ACUMEN_Q1_SEM2;

		RETURN
	GO

EXECUTE standbydbo.GET_SEM_ICs @Semester = 1

