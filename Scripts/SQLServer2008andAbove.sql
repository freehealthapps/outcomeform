﻿
/********************************************************************************************************/
-- Original Copyright Matt Cutting & Matthew Bishop 2017
-- Contact for more details: 
-- Matt Cutting: 	matt@responsivehealth.co.uk / 07734 051804
-- Matthew Bishop:	matthew.bishop@perspicacityltd.co.uk / 07545 878906
/********************************************************************************************************/

USE [FreeHealthApps_DynamicOutcomeForm]
GO
/****** Object:  Schema [app]    Script Date: 29/04/2017 20:18:28 ******/
CREATE SCHEMA [app]
GO
/****** Object:  Schema [PAS]    Script Date: 29/04/2017 20:18:28 ******/
CREATE SCHEMA [PAS]
GO
/****** Object:  Schema [RTT]    Script Date: 29/04/2017 20:18:28 ******/
CREATE SCHEMA [RTT]
GO
/****** Object:  UserDefinedFunction [RTT].[fnNewFollowup]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Matthew Cutting
-- ALTER date:	02.08.2016
-- Description:	Used for checking if an appointment is new or follow up by checking the user code
-- =============================================
CREATE FUNCTION [RTT].[fnNewFollowup] (@user VARCHAR(20), @flag CHAR(1), @default CHAR(1))
	RETURNS CHAR(1)
AS
BEGIN
	DECLARE @newFollowup CHAR(1)

	SELECT @newFollowup = DestinationCode FROM RPA_Datawarehouse_Lookup.Lookups.NewFollowUpUserMapping WHERE SourceCode = @user;
	
	IF (@newFollowup IS NULL) 
	BEGIN
		SET @newFollowup = ISNULL(@flag, @default)
	END

	RETURN @newFollowup;
END

GO
/****** Object:  Table [app].[FormGeneratorGroup]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[FormGeneratorGroup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[CssClass] [nvarchar](255) NULL,
	[ImageUrl] [nvarchar](255) NULL,
	[DefaultTemplateId] [int] NULL,
	[Display] [bit] NOT NULL,
 CONSTRAINT [PK_FormGeneratorGroup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [app].[FormGeneratorPASQuery]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[FormGeneratorPASQuery](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[SQL] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_FormGeneratorOASISQuery] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [app].[FormGeneratorSearch]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[FormGeneratorSearch](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[Url] [nvarchar](255) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
 CONSTRAINT [PK_FormGeneratorSearch] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [app].[FormGeneratorSearchTemplate]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[FormGeneratorSearchTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupId] [int] NOT NULL,
	[SearchId] [int] NOT NULL,
	[TemplateId] [int] NOT NULL,
	[PASQueryId] [int] NOT NULL,
 CONSTRAINT [PK_FormGeneratorSearchTemplate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [app].[FormGeneratorTemplate]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[FormGeneratorTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupId] [int] NOT NULL,
	[GeneratorUrl] [nvarchar](255) NOT NULL,
	[AllGeneratorUrl] [nvarchar](255) NULL,
	[TemplateName] [nvarchar](255) NOT NULL,
	[AllTemplateName] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[StoredProcedure1] [nvarchar](255) NULL,
	[StoredProcedure2] [nvarchar](255) NULL,
	[StoredProcedure3] [nvarchar](255) NULL,
	[StoredProcedure4] [nvarchar](255) NULL,
	[StoredProcedure5] [nvarchar](255) NULL,
	[StoredProcedure6] [nvarchar](255) NULL,
	[StoredProcedure7] [nvarchar](255) NULL,
	[StoredProcedure8] [nvarchar](255) NULL,
	[StoredProcedure9] [nvarchar](255) NULL,
	[StoredProcedure10] [nvarchar](255) NULL,
	[EncounterPASQueryId] [int] NULL,
	[Display] [bit] NOT NULL,
 CONSTRAINT [PK_FormGeneratorTemplate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [PAS].[Appointment]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PAS].[Appointment](
	[AppointmentId] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[ClinicId] [int] NOT NULL,
	[ApptDate] [datetime] NOT NULL,
	[PathwayNumber] [nvarchar](255) NOT NULL,
	[PathwayId] [int] NOT NULL,
 CONSTRAINT [PK_Appointment] PRIMARY KEY CLUSTERED 
(
	[AppointmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [PAS].[Clinic]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PAS].[Clinic](
	[ClinicId] [int] IDENTITY(1,1) NOT NULL,
	[ClinicCode] [nvarchar](50) NOT NULL,
	[ClinicDescription] [nvarchar](255) NOT NULL,
	[ConsultantId] [int] NOT NULL,
	[SpecialtyId] [int] NOT NULL,
 CONSTRAINT [PK_Clinic] PRIMARY KEY CLUSTERED 
(
	[ClinicId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [PAS].[Consultant]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PAS].[Consultant](
	[ConsultantId] [int] IDENTITY(1,1) NOT NULL,
	[ConsultantName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Consultant] PRIMARY KEY CLUSTERED 
(
	[ConsultantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [PAS].[Patient]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PAS].[Patient](
	[PatientId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](255) NULL,
	[FamilyName] [nvarchar](255) NULL,
	[DateOfBirth] [date] NULL,
	[NHSNumber] [nvarchar](10) NULL,
	[CRN] [nvarchar](50) NULL,
 CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED 
(
	[PatientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [PAS].[Specialty]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PAS].[Specialty](
	[SpecialtyId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK_Specialty] PRIMARY KEY CLUSTERED 
(
	[SpecialtyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [RTT].[Event]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RTT].[Event](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventDefinitionId] [int] NOT NULL,
	[PatientId] [int] NULL,
	[EncounterId] [int] NULL,
	[EncounterType] [varchar](10) NULL,
	[ReferralId] [int] NULL,
	[PathwayId] [int] NULL,
	[PlannedAdmitId] [int] NULL,
	[SpecialtyCode] [varchar](255) NULL,
	[SpecialtyDescription] [varchar](255) NULL,
	[ConsultantCode] [varchar](255) NULL,
	[ConsultantName] [varchar](255) NULL,
	[OutcomeCode] [varchar](255) NULL,
	[OutcomeDescription] [varchar](255) NULL,
	[ClinicCode] [varchar](255) NULL,
	[InpatientWaitingList] [varchar](255) NULL,
	[OutpatientWaitingList] [varchar](255) NULL,
	[ProcedureDescription] [varchar](255) NULL,
	[EventDate] [date] NULL,
	[EventTime] [time](7) NULL,
	[EventDateTime] [datetime2](7) NULL,
	[Ix] [int] NULL,
	[RevIx] [int] NULL,
	[PathwayIx] [int] NULL,
	[PathwayRevIx] [int] NULL,
	[VisitIx] [int] NULL,
	[VisitRevIx] [int] NULL,
	[SerialDnaIx] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [RTT].[EventAction]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RTT].[EventAction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK_EventAction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [RTT].[EventDefinition]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RTT].[EventDefinition](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventTypeId] [int] NOT NULL,
	[EventSubTypeId] [int] NULL,
	[EndpointId] [int] NOT NULL,
	[ActionId] [int] NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Code] [nvarchar](2) NULL,
	[Description] [nvarchar](255) NULL,
	[LongDescription] [nvarchar](4000) NULL,
 CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [RTT].[EventDescription]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RTT].[EventDescription](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventId] [int] NOT NULL,
	[TemplateId] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[DisplayOrder] [int] NULL,
 CONSTRAINT [PK_EventDescription] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [RTT].[EventDescriptionTemplate]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RTT].[EventDescriptionTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Template] [nvarchar](512) NOT NULL,
 CONSTRAINT [PK_EventDescriptionTemplate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [RTT].[EventDescriptionTemplateEventDisplayOrder]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RTT].[EventDescriptionTemplateEventDisplayOrder](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventDisplayOrderId] [int] NOT NULL,
	[EventDescriptionTemplateId] [int] NOT NULL,
	[TemplateOrder] [int] NOT NULL,
 CONSTRAINT [PK_EventDescriptionTemplateEventDisplayOrder] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [RTT].[EventDisplay]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RTT].[EventDisplay](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[MaxNoEvents] [int] NOT NULL,
	[NoStartEvents] [int] NOT NULL,
	[Version] [int] NOT NULL,
 CONSTRAINT [PK_EventDisplay] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [RTT].[EventDisplayOrder]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RTT].[EventDisplayOrder](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventDisplayId] [int] NOT NULL,
	[EventDefinitionId] [int] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[CssClass] [nvarchar](255) NULL,
 CONSTRAINT [PK_EventDisplayOrder] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [RTT].[EventEndpoint]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RTT].[EventEndpoint](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK_EventEndpoint] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [RTT].[EventSubType]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RTT].[EventSubType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventTypeId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK_EventSubType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [RTT].[EventType]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RTT].[EventType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK_EventType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [RTT].[Pathway]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RTT].[Pathway](
	[PathwayId] [int] IDENTITY(1,1) NOT NULL,
	[PathwayNumber] [nvarchar](255) NOT NULL,
	[DaysWait] [int] NULL,
	[ClockStartDate] [date] NULL,
	[ClockStopDate] [date] NULL,
 CONSTRAINT [PK_Pathway] PRIMARY KEY CLUSTERED 
(
	[PathwayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [RTT].[tvf_GetEventByDefinitionByPathway]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Matthew Cutting
-- ALTER date:	25.10.2016
-- Description:	Used for returning an RTT.Event row by the name of the definition
-- =============================================
CREATE FUNCTION [RTT].[tvf_GetEventByDefinitionByPathway](	
	@pathwayId INT,
	@definitionType NVARCHAR(4000),
	@definitionFilterBy NVARCHAR(10),
	@exists NVARCHAR(4000),
	@existsFilterBy NVARCHAR(4000)
)
RETURNS TABLE 
AS
	RETURN (	
		SELECT e.Id, e.EventDateTime, e.PathwayId, e.EncounterId, ed.Name AS EventDefinition, e.ClinicCode, e.OutcomeCode
			--,(SELECT TOP 1 1 FROM Reporting.DM.RTT rtt WHERE rtt.PathwayNumber = e.PathwayId AND e.EventDate >= rtt.ClockStartDate AND (rtt.ClockStopDate IS NULL OR e.EventDate <= rtt.ClockStopDate)) AS IsInRttPeriod
		FROM RTT.[Event] e 
		JOIN RTT.EventDefinition ed ON e.EventDefinitionId = ed.Id
		WHERE 
			e.PathwayId = @pathwayId AND
			((1 = CASE @definitionFilterBy WHEN 'NOT IN' THEN 1 END AND CHARINDEX(ed.Name + ',', @definitionType) <= 0)
			OR
			(1 = CASE @definitionFilterBy WHEN 'IN' THEN 1 END AND CHARINDEX(ed.Name + ',', @definitionType) > 0))
			AND (
				(1 = CASE WHEN @existsFilterBy IS NULL THEN 1 END)
				OR (1 = CASE @existsFilterBy WHEN 'EXISTS' THEN 1 END AND EXISTS(										
								SELECT b.Id 
								FROM RTT.[Event] b
								JOIN RTT.EventDefinition b_ed ON b.EventDefinitionId = b_ed.Id  
								WHERE b.EncounterId = e.EncounterId AND CHARINDEX(b_ed.Name + ',', @exists) > 0)
					)
				OR (1 = CASE @existsFilterBy WHEN 'NOT EXISTS' THEN 1 END AND NOT EXISTS(										
								SELECT b.Id 
								FROM RTT.[Event] b
								JOIN RTT.EventDefinition b_ed ON b.EventDefinitionId = b_ed.Id  
								WHERE b.EncounterId = e.EncounterId AND CHARINDEX(b_ed.Name + ',', @exists) > 0)
					)
			)
	)

GO
/****** Object:  UserDefinedFunction [RTT].[tvf_GetEventDefinitionByName]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Matthew Cutting
-- ALTER date:	02.08.2016
-- Description:	Used for returning an RTT.Event row by the name field
-- =============================================
CREATE FUNCTION [RTT].[tvf_GetEventDefinitionByName](	
	@name nvarchar(255)
)
RETURNS TABLE 
AS
	RETURN 
	(
		SELECT TOP 1 *	FROM RTT.[EventDefinition] ed WHERE ed.Name = @name
	)

GO
SET IDENTITY_INSERT [app].[FormGeneratorGroup] ON 

GO
INSERT [app].[FormGeneratorGroup] ([Id], [Name], [Description], [CssClass], [ImageUrl], [DefaultTemplateId], [Display]) VALUES (1, N'Outpatient Attendance Form', N'Generate an outpatient attendance form automatically populated with clinic and patient details<br/><br/>This form also provides a summary of the pathway as well as an event timeline.', N'bg-green', N'/img/attendanceForm.jpg', 1, 1)
GO
INSERT [app].[FormGeneratorGroup] ([Id], [Name], [Description], [CssClass], [ImageUrl], [DefaultTemplateId], [Display]) VALUES (2, N'Outpatient Attendance Help Sheet', N'Help sheet for the outpatient attendance form listing definitions related to pathways.<br/><br/> The help sheet displays a legend of all pathway events with descriptions.', N'bg-blue', N'/img/CribSheet.jpg', 3, 1)
GO
SET IDENTITY_INSERT [app].[FormGeneratorGroup] OFF
GO
SET IDENTITY_INSERT [app].[FormGeneratorPASQuery] ON 

GO
INSERT [app].[FormGeneratorPASQuery] ([Id], [Name], [SQL]) VALUES (1, N'SearchByCRN', N'SELECT appt.AppointmentId AS APPOINTMENT_ID, 
		ptt.FamilyName + '' '' + ptt.FirstName AS PATIENT_NAME, 
		SUBSTRING(ptt.NHSNumber, 1, 3) + ''-'' + SUBSTRING(ptt.NHSNumber, 4, 3) + ''-'' + SUBSTRING(ptt.NHSNumber, 7, 4) AS NHS_NUMBER, 
		FORMAT(ptt.DateOfBirth,''dd-MMM-yyyy'', ''en-gb'') AS DATE_OF_BIRTH,
		clinic.ClinicDescription AS CLINIC_DESCRIPTION, 
		clinic.ClinicCode AS CLINIC_CODE, 
		FORMAT(appt.ApptDate,''dd-MMM-yyyy'', ''en-gb'') AS APPT_DATE,
		FORMAT(appt.ApptDate,''HH:mm'', ''en-gb'') AS APPT_TIME,
		specialty.[Description] AS SPECIALTY_DESCRIPTION, 
		cons.ConsultantName AS CONSULTANT_NAME 
FROM PAS.Appointment appt
JOIN PAS.Patient ptt ON appt.PatientId = ptt.PatientId  
JOIN PAS.Clinic clinic ON appt.ClinicId = clinic.ClinicId
JOIN PAS.Specialty specialty ON clinic.SpecialtyId = specialty.SpecialtyId
JOIN PAS.Consultant cons ON clinic.ConsultantId = cons.ConsultantId
WHERE ptt.CRN = @0')
GO
INSERT [app].[FormGeneratorPASQuery] ([Id], [Name], [SQL]) VALUES (2, N'SearchByNHSNumber', N'SELECT appt.AppointmentId AS APPOINTMENT_ID, 
		ptt.FamilyName + '' '' + ptt.FirstName AS PATIENT_NAME, 
		SUBSTRING(ptt.NHSNumber, 1, 3) + ''-'' + SUBSTRING(ptt.NHSNumber, 4, 3) + ''-'' + SUBSTRING(ptt.NHSNumber, 7, 4) AS NHS_NUMBER, 
		FORMAT(ptt.DateOfBirth,''dd-MMM-yyyy'', ''en-gb'') AS DATE_OF_BIRTH,
		clinic.ClinicDescription AS CLINIC_DESCRIPTION, 
		clinic.ClinicCode AS CLINIC_CODE, 
		FORMAT(appt.ApptDate,''dd-MMM-yyyy'', ''en-gb'') AS APPT_DATE,
		FORMAT(appt.ApptDate,''HH:mm'', ''en-gb'') AS APPT_TIME,
		specialty.[Description] AS SPECIALTY_DESCRIPTION, 
		cons.ConsultantName AS CONSULTANT_NAME 
FROM PAS.Appointment appt
JOIN PAS.Patient ptt ON appt.PatientId = ptt.PatientId  
JOIN PAS.Clinic clinic ON appt.ClinicId = clinic.ClinicId
JOIN PAS.Specialty specialty ON clinic.SpecialtyId = specialty.SpecialtyId
JOIN PAS.Consultant cons ON clinic.ConsultantId = cons.ConsultantId
WHERE ptt.NHSNumber = @0')
GO
INSERT [app].[FormGeneratorPASQuery] ([Id], [Name], [SQL]) VALUES (3, N'SearchByClinicCodeDate', N'SELECT appt.AppointmentId AS APPOINTMENT_ID, 
		ptt.FamilyName + '' '' + ptt.FirstName AS PATIENT_NAME, 
		SUBSTRING(ptt.NHSNumber, 1, 3) + ''-'' + SUBSTRING(ptt.NHSNumber, 4, 3) + ''-'' + SUBSTRING(ptt.NHSNumber, 7, 4) AS NHS_NUMBER, 
		FORMAT(ptt.DateOfBirth,''dd-MMM-yyyy'', ''en-gb'') AS DATE_OF_BIRTH,
		clinic.ClinicDescription AS CLINIC_DESCRIPTION, 
		clinic.ClinicCode AS CLINIC_CODE, 
		FORMAT(appt.ApptDate,''dd-MMM-yyyy'', ''en-gb'') AS APPT_DATE,
		FORMAT(appt.ApptDate,''HH:mm'', ''en-gb'') AS APPT_TIME,
		specialty.[Description] AS SPECIALTY_DESCRIPTION, 
		cons.ConsultantName AS CONSULTANT_NAME 
FROM PAS.Appointment appt
JOIN PAS.Patient ptt ON appt.PatientId = ptt.PatientId  
JOIN PAS.Clinic clinic ON appt.ClinicId = clinic.ClinicId
JOIN PAS.Specialty specialty ON clinic.SpecialtyId = specialty.SpecialtyId
JOIN PAS.Consultant cons ON clinic.ConsultantId = cons.ConsultantId
WHERE clinic.ClinicCode = @0 AND CAST(appt.ApptDate AS date) = CAST(@1 AS date) 
ORDER BY @2')
GO
INSERT [app].[FormGeneratorPASQuery] ([Id], [Name], [SQL]) VALUES (4, N'SearchByPathway', N'SELECT appt.AppointmentId AS APPOINTMENT_ID, 
		ptt.FamilyName + '' '' + ptt.FirstName AS PATIENT_NAME, 
		SUBSTRING(ptt.NHSNumber, 1, 3) + ''-'' + SUBSTRING(ptt.NHSNumber, 4, 3) + ''-'' + SUBSTRING(ptt.NHSNumber, 7, 4) AS NHS_NUMBER, 
		FORMAT(ptt.DateOfBirth,''dd-MMM-yyyy'', ''en-gb'') AS DATE_OF_BIRTH,
		clinic.ClinicDescription AS CLINIC_DESCRIPTION, 
		clinic.ClinicCode AS CLINIC_CODE, 
		FORMAT(appt.ApptDate,''dd-MMM-yyyy'', ''en-gb'') AS APPT_DATE,
		FORMAT(appt.ApptDate,''HH:mm'', ''en-gb'') AS APPT_TIME,
		specialty.[Description] AS SPECIALTY_DESCRIPTION, 
		cons.ConsultantName AS CONSULTANT_NAME 
FROM PAS.Appointment appt
JOIN PAS.Patient ptt ON appt.PatientId = ptt.PatientId  
JOIN PAS.Clinic clinic ON appt.ClinicId = clinic.ClinicId
JOIN PAS.Specialty specialty ON clinic.SpecialtyId = specialty.SpecialtyId
JOIN PAS.Consultant cons ON clinic.ConsultantId = cons.ConsultantId
WHERE appt.PathwayNumber = @0')
GO
INSERT [app].[FormGeneratorPASQuery] ([Id], [Name], [SQL]) VALUES (5, N'EncounterByAppointmentId', N'SELECT appt.AppointmentId AS APPOINTMENT_ID, 
	   ptt.FamilyName + '' '' + ptt.FirstName AS PATIENT_NAME, 
	   ptt.CRN, 
	   SUBSTRING(ptt.NHSNumber, 1, 3) + ''-'' + SUBSTRING(ptt.NHSNumber, 4, 3) + ''-'' + SUBSTRING(ptt.NHSNumber, 7, 4) AS NHS_NUMBER, 
	   FORMAT(ptt.DateOfBirth,''dd-MMM-yyyy'', ''en-gb'') AS DATE_OF_BIRTH,
	   clinic.ClinicDescription AS CLINIC_DESCRIPTION, 
	   clinic.ClinicCode AS CLINIC_CODE, 
	   FORMAT(appt.ApptDate,''dd-MMM-yyyy'', ''en-gb'') AS APPT_DATE,
	   FORMAT(appt.ApptDate,''HH:mm'', ''en-gb'') AS APPT_TIME,
	   specialty.[Description] AS SPECIALTY_DESCRIPTION, 
	   cons.ConsultantName AS CLINICIAN_NAME, 
	   cons.ConsultantName AS CONSULTANT_NAME,
	   ptt.PatientId AS PATIENT_ID, 
	   appt.AppointmentId AS ENCOUNTER_ID, 
	   appt.PathwayNumber AS PATHWAY_NO, 
	   appt.PathwayId  AS PATHWAY_ID 
FROM PAS.Appointment appt
JOIN PAS.Patient ptt ON appt.PatientId = ptt.PatientId  
JOIN PAS.Clinic clinic ON appt.ClinicId = clinic.ClinicId
JOIN PAS.Specialty specialty ON clinic.SpecialtyId = specialty.SpecialtyId
JOIN PAS.Consultant cons ON clinic.ConsultantId = cons.ConsultantId
WHERE appt.AppointmentId = @0')
GO
SET IDENTITY_INSERT [app].[FormGeneratorPASQuery] OFF
GO
SET IDENTITY_INSERT [app].[FormGeneratorSearch] ON 

GO
INSERT [app].[FormGeneratorSearch] ([Id], [Name], [Description], [Url], [DisplayOrder]) VALUES (1, N'SearchByCRN', N'By Hospital Number', N'/Search/SearchByCRN', 10)
GO
INSERT [app].[FormGeneratorSearch] ([Id], [Name], [Description], [Url], [DisplayOrder]) VALUES (2, N'SearchByNHSNumber', N'By NHS Number', N'/Search/SearchByNHS', 20)
GO
INSERT [app].[FormGeneratorSearch] ([Id], [Name], [Description], [Url], [DisplayOrder]) VALUES (3, N'SearchByClinic', N'By Clinic', N'/Search/SearchByClinic', 30)
GO
INSERT [app].[FormGeneratorSearch] ([Id], [Name], [Description], [Url], [DisplayOrder]) VALUES (4, N'SearchByPathway', N'By Pathway', N'/Search/SearchByPathway', 40)
GO
SET IDENTITY_INSERT [app].[FormGeneratorSearch] OFF
GO
SET IDENTITY_INSERT [app].[FormGeneratorSearchTemplate] ON 

GO
INSERT [app].[FormGeneratorSearchTemplate] ([Id], [GroupId], [SearchId], [TemplateId], [PASQueryId]) VALUES (1, 1, 1, 1, 1)
GO
INSERT [app].[FormGeneratorSearchTemplate] ([Id], [GroupId], [SearchId], [TemplateId], [PASQueryId]) VALUES (2, 1, 2, 1, 2)
GO
INSERT [app].[FormGeneratorSearchTemplate] ([Id], [GroupId], [SearchId], [TemplateId], [PASQueryId]) VALUES (3, 1, 3, 1, 3)
GO
INSERT [app].[FormGeneratorSearchTemplate] ([Id], [GroupId], [SearchId], [TemplateId], [PASQueryId]) VALUES (4, 1, 4, 1, 4)
GO
SET IDENTITY_INSERT [app].[FormGeneratorSearchTemplate] OFF
GO
SET IDENTITY_INSERT [app].[FormGeneratorTemplate] ON 

GO
INSERT [app].[FormGeneratorTemplate] ([Id], [GroupId], [GeneratorUrl], [AllGeneratorUrl], [TemplateName], [AllTemplateName], [Description], [StoredProcedure1], [StoredProcedure2], [StoredProcedure3], [StoredProcedure4], [StoredProcedure5], [StoredProcedure6], [StoredProcedure7], [StoredProcedure8], [StoredProcedure9], [StoredProcedure10], [EncounterPASQueryId], [Display]) VALUES (1, 1, N'pdf/generatebyappointmentid', N'pdf/generatebycliniccodeclinicdate', N'OutpatientAttendanceForm', N'OutpatientAttendanceFormClinic', N'Attendance Form (Individual)', N'[RTT].[uspEventSummary]', N'[RTT].[uspPathwayTimeLine]', N'[RTT].[uspPathwayTimeLine_SummaryDates]', N'RTT.[uspPathwayTimeLine_Summary]', N'[RTT].[uspPathwayTimeLine_SummaryStart]', NULL, NULL, NULL, NULL, NULL, 5, 1)
GO
INSERT [app].[FormGeneratorTemplate] ([Id], [GroupId], [GeneratorUrl], [AllGeneratorUrl], [TemplateName], [AllTemplateName], [Description], [StoredProcedure1], [StoredProcedure2], [StoredProcedure3], [StoredProcedure4], [StoredProcedure5], [StoredProcedure6], [StoredProcedure7], [StoredProcedure8], [StoredProcedure9], [StoredProcedure10], [EncounterPASQueryId], [Display]) VALUES (3, 2, N'pdf/generatebyappointmentid', NULL, N'CribSheet', NULL, NULL, N'RTT.uspCribSheet', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0)
GO
SET IDENTITY_INSERT [app].[FormGeneratorTemplate] OFF
GO
SET IDENTITY_INSERT [PAS].[Appointment] ON 

GO
INSERT [PAS].[Appointment] ([AppointmentId], [PatientId], [ClinicId], [ApptDate], [PathwayNumber], [PathwayId]) VALUES (1, 1, 1, CAST(N'2016-10-20T11:15:00.000' AS DateTime), N'000000000000000', 1)
GO
INSERT [PAS].[Appointment] ([AppointmentId], [PatientId], [ClinicId], [ApptDate], [PathwayNumber], [PathwayId]) VALUES (2, 2, 1, CAST(N'2016-10-20T09:15:00.000' AS DateTime), N'000000000000001', 2)
GO
INSERT [PAS].[Appointment] ([AppointmentId], [PatientId], [ClinicId], [ApptDate], [PathwayNumber], [PathwayId]) VALUES (3, 3, 1, CAST(N'2016-10-20T10:15:00.000' AS DateTime), N'000000000000002', 3)
GO
INSERT [PAS].[Appointment] ([AppointmentId], [PatientId], [ClinicId], [ApptDate], [PathwayNumber], [PathwayId]) VALUES (4, 4, 2, CAST(N'2016-11-24T09:00:00.000' AS DateTime), N'000000000000003', 4)
GO
INSERT [PAS].[Appointment] ([AppointmentId], [PatientId], [ClinicId], [ApptDate], [PathwayNumber], [PathwayId]) VALUES (5, 5, 2, CAST(N'2016-11-24T09:15:00.000' AS DateTime), N'000000000000004', 5)
GO
SET IDENTITY_INSERT [PAS].[Appointment] OFF
GO
SET IDENTITY_INSERT [PAS].[Clinic] ON 

GO
INSERT [PAS].[Clinic] ([ClinicId], [ClinicCode], [ClinicDescription], [ConsultantId], [SpecialtyId]) VALUES (1, N'ENT01', N'ENT Routine Clinic', 1, 1)
GO
INSERT [PAS].[Clinic] ([ClinicId], [ClinicCode], [ClinicDescription], [ConsultantId], [SpecialtyId]) VALUES (2, N'ENT02', N'ENT Routine Clinic', 2, 1)
GO
SET IDENTITY_INSERT [PAS].[Clinic] OFF
GO
SET IDENTITY_INSERT [PAS].[Consultant] ON 

GO
INSERT [PAS].[Consultant] ([ConsultantId], [ConsultantName]) VALUES (1, N'MOUTASAMY,MRS Winifred')
GO
INSERT [PAS].[Consultant] ([ConsultantId], [ConsultantName]) VALUES (2, N'GOHL, MR Rajesh')
GO
SET IDENTITY_INSERT [PAS].[Consultant] OFF
GO
SET IDENTITY_INSERT [PAS].[Patient] ON 

GO
INSERT [PAS].[Patient] ([PatientId], [FirstName], [FamilyName], [DateOfBirth], [NHSNumber], [CRN]) VALUES (1, N'Fred', N'FLINTSTONE', CAST(N'1990-01-01' AS Date), N'0000000000', N'000000AA')
GO
INSERT [PAS].[Patient] ([PatientId], [FirstName], [FamilyName], [DateOfBirth], [NHSNumber], [CRN]) VALUES (2, N'Wilma', N'FLINTSTONE', CAST(N'1990-01-01' AS Date), N'1111111111', N'000000BB')
GO
INSERT [PAS].[Patient] ([PatientId], [FirstName], [FamilyName], [DateOfBirth], [NHSNumber], [CRN]) VALUES (3, N'Barney', N'RUBBLE', CAST(N'1990-01-01' AS Date), N'2222222222', N'000000CC')
GO
INSERT [PAS].[Patient] ([PatientId], [FirstName], [FamilyName], [DateOfBirth], [NHSNumber], [CRN]) VALUES (4, N'Homer', N'SIMPSON', CAST(N'1990-01-01' AS Date), N'3333333333', N'000000DD')
GO
INSERT [PAS].[Patient] ([PatientId], [FirstName], [FamilyName], [DateOfBirth], [NHSNumber], [CRN]) VALUES (5, N'Margaret', N'SIMPSON', CAST(N'1990-01-01' AS Date), N'4444444444', N'000000EE')
GO
SET IDENTITY_INSERT [PAS].[Patient] OFF
GO
SET IDENTITY_INSERT [PAS].[Specialty] ON 

GO
INSERT [PAS].[Specialty] ([SpecialtyId], [Description]) VALUES (1, N'ENT')
GO
SET IDENTITY_INSERT [PAS].[Specialty] OFF
GO
SET IDENTITY_INSERT [RTT].[Event] ON 

GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (1, 3, 1, NULL, NULL, NULL, 1, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2015-11-05' AS Date), CAST(N'00:00:00' AS Time), CAST(N'2015-11-05T00:00:00.0000000' AS DateTime2), 1, 5, 1, 5, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (2, 5, 1, NULL, NULL, NULL, 1, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2015-11-05' AS Date), CAST(N'00:00:00' AS Time), CAST(N'2015-11-05T00:00:00.0000000' AS DateTime2), 2, 4, 2, 4, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (3, 12, 1, NULL, NULL, NULL, 1, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2015-12-15' AS Date), CAST(N'14:00:00' AS Time), CAST(N'2015-12-15T14:00:00.0000000' AS DateTime2), 3, 3, 3, 3, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (4, 11, 1, NULL, NULL, NULL, 1, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-02-02' AS Date), CAST(N'14:00:00' AS Time), CAST(N'2016-02-02T14:00:00.0000000' AS DateTime2), 4, 2, 4, 2, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (5, 6, 1, NULL, NULL, NULL, 1, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-02-03' AS Date), CAST(N'00:00:00' AS Time), CAST(N'2016-02-03T00:00:00.0000000' AS DateTime2), 5, 1, 5, 1, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (6, 3, 2, NULL, NULL, NULL, 2, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-05-06' AS Date), CAST(N'00:00:00' AS Time), CAST(N'2016-05-06T00:00:00.0000000' AS DateTime2), 1, 4, 1, 4, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (7, 5, 2, NULL, NULL, NULL, 2, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-05-06' AS Date), CAST(N'00:00:00' AS Time), CAST(N'2016-05-06T00:00:00.0000000' AS DateTime2), 2, 3, 2, 3, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (8, 34, 2, NULL, NULL, NULL, 2, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-06-08' AS Date), CAST(N'11:00:00' AS Time), CAST(N'2016-06-08T11:00:00.0000000' AS DateTime2), 3, 2, 3, 2, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (9, 11, 2, NULL, NULL, NULL, 2, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-08-22' AS Date), CAST(N'10:00:00' AS Time), CAST(N'2016-08-22T10:00:00.0000000' AS DateTime2), 4, 1, 4, 1, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (10, 3, 3, NULL, NULL, NULL, 3, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-04-27' AS Date), CAST(N'00:00:00' AS Time), CAST(N'2016-04-27T00:00:00.0000000' AS DateTime2), 1, 10, 1, 10, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (11, 5, 3, NULL, NULL, NULL, 3, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-04-27' AS Date), CAST(N'00:00:00' AS Time), CAST(N'2016-04-27T00:00:00.0000000' AS DateTime2), 2, 9, 2, 9, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (12, 11, 3, NULL, NULL, NULL, 3, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-05-04' AS Date), CAST(N'09:30:00' AS Time), CAST(N'2016-05-04T09:30:00.0000000' AS DateTime2), 3, 8, 3, 8, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (13, 14, 3, NULL, NULL, NULL, 3, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-06-01' AS Date), CAST(N'10:00:00' AS Time), CAST(N'2016-06-01T10:00:00.0000000' AS DateTime2), 4, 7, 4, 7, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (14, 16, 3, NULL, NULL, NULL, 3, NULL, N'1', N'ENT', NULL, NULL, N'86350', NULL, NULL, NULL, NULL, NULL, CAST(N'2016-06-05' AS Date), CAST(N'10:00:00' AS Time), CAST(N'2016-06-05T10:00:00.0000000' AS DateTime2), 5, 6, 5, 6, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (15, 16, 3, NULL, NULL, NULL, 3, NULL, N'1', N'ENT', NULL, NULL, N'86350', NULL, NULL, NULL, NULL, NULL, CAST(N'2016-06-06' AS Date), CAST(N'10:00:00' AS Time), CAST(N'2016-06-06T10:00:00.0000000' AS DateTime2), 6, 5, 6, 5, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (16, 14, 3, NULL, NULL, NULL, 3, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-06-22' AS Date), CAST(N'10:00:00' AS Time), CAST(N'2016-06-22T10:00:00.0000000' AS DateTime2), 7, 4, 7, 4, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (17, 14, 3, NULL, NULL, NULL, 3, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-07-06' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2016-07-06T09:00:00.0000000' AS DateTime2), 8, 3, 8, 3, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (18, 15, 3, NULL, NULL, NULL, 3, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-08-17' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2016-08-17T09:00:00.0000000' AS DateTime2), 9, 2, 9, 2, NULL, NULL, 1)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (19, 15, 3, NULL, NULL, NULL, 3, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-10-25' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2016-10-06T09:00:00.0000000' AS DateTime2), 10, 1, 10, 1, NULL, NULL, 2)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (20, 3, 4, NULL, NULL, NULL, 4, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2015-11-16' AS Date), CAST(N'00:00:00' AS Time), CAST(N'2015-11-16T00:00:00.0000000' AS DateTime2), 1, 5, 1, 5, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (21, 5, 4, NULL, NULL, NULL, 4, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2015-11-16' AS Date), CAST(N'00:00:00' AS Time), CAST(N'2015-11-16T00:00:00.0000000' AS DateTime2), 2, 4, 2, 4, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (22, 34, 4, NULL, NULL, NULL, 4, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-01-28' AS Date), CAST(N'09:15:00' AS Time), CAST(N'2016-01-28T09:15:00.0000000' AS DateTime2), 3, 3, 3, 3, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (23, 11, 4, NULL, NULL, NULL, 4, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-02-29' AS Date), CAST(N'10:00:00' AS Time), CAST(N'2016-02-29T10:00:00.0000000' AS DateTime2), 4, 2, 4, 2, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (24, 6, 4, NULL, NULL, NULL, 4, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-03-01' AS Date), CAST(N'00:00:00' AS Time), CAST(N'2016-03-01T00:00:00.0000000' AS DateTime2), 5, 1, 5, 1, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (25, 14, 5, NULL, NULL, NULL, 5, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2015-06-12' AS Date), CAST(N'13:30:00' AS Time), CAST(N'2015-06-12T13:30:00.0000000' AS DateTime2), 1, 7, 1, 7, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (26, 3, 5, NULL, NULL, NULL, 5, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2015-12-11' AS Date), CAST(N'00:00:00' AS Time), CAST(N'2015-12-11T00:00:00.0000000' AS DateTime2), 2, 6, 2, 6, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (27, 5, 5, NULL, NULL, NULL, 5, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2015-12-11' AS Date), CAST(N'00:00:00' AS Time), CAST(N'2015-12-11T00:00:00.0000000' AS DateTime2), 3, 5, 3, 5, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (28, 15, 5, NULL, NULL, NULL, 5, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-01-08' AS Date), CAST(N'08:45:00' AS Time), CAST(N'2016-01-08T08:45:00.0000000' AS DateTime2), 4, 4, 4, 4, NULL, NULL, 1)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (29, 11, 5, NULL, NULL, NULL, 5, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-02-02' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2016-02-02T09:00:00.0000000' AS DateTime2), 5, 3, 5, 3, NULL, NULL, 0)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (30, 6, 5, NULL, NULL, NULL, 5, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-02-03' AS Date), CAST(N'10:00:00' AS Time), CAST(N'2016-02-03T00:00:00.0000000' AS DateTime2), 6, 2, 6, 2, NULL, NULL, NULL)
GO
INSERT [RTT].[Event] ([Id], [EventDefinitionId], [PatientId], [EncounterId], [EncounterType], [ReferralId], [PathwayId], [PlannedAdmitId], [SpecialtyCode], [SpecialtyDescription], [ConsultantCode], [ConsultantName], [OutcomeCode], [OutcomeDescription], [ClinicCode], [InpatientWaitingList], [OutpatientWaitingList], [ProcedureDescription], [EventDate], [EventTime], [EventDateTime], [Ix], [RevIx], [PathwayIx], [PathwayRevIx], [VisitIx], [VisitRevIx], [SerialDnaIx]) VALUES (31, 14, 5, NULL, NULL, NULL, 5, NULL, N'1', N'ENT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2016-02-24' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2016-02-24T09:00:00.0000000' AS DateTime2), 7, 1, 7, 1, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [RTT].[Event] OFF
GO
SET IDENTITY_INSERT [RTT].[EventAction] ON 

GO
INSERT [RTT].[EventAction] ([Id], [Name], [Description]) VALUES (1, N'S', N'Seen')
GO
INSERT [RTT].[EventAction] ([Id], [Name], [Description]) VALUES (2, N'C', N'Cancelled')
GO
INSERT [RTT].[EventAction] ([Id], [Name], [Description]) VALUES (3, N'A', N'Attend')
GO
INSERT [RTT].[EventAction] ([Id], [Name], [Description]) VALUES (4, N'D', N'DNA')
GO
INSERT [RTT].[EventAction] ([Id], [Name], [Description]) VALUES (5, N'R', N'Reschedule')
GO
SET IDENTITY_INSERT [RTT].[EventAction] OFF
GO
SET IDENTITY_INSERT [RTT].[EventDefinition] ON 

GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (1, 1, NULL, 1, NULL, N'REFERRAL_START', NULL, N'Referral Start', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (2, 1, NULL, 3, NULL, N'REFERRAL_END', NULL, N'Referral End', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (3, 2, NULL, 1, NULL, N'PATHWAY_START', N'PS', N'Pathway Start', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (4, 2, NULL, 3, NULL, N'PATHWAY_END', N'PE', N'Pathway End', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (5, 3, NULL, 1, NULL, N'CLOCK_START', N'CS', N'Clock Start', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (6, 3, NULL, 3, NULL, N'CLOCK_STOP', N'CE', N'Clock End', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (7, 4, NULL, 1, NULL, N'OPWL_START', NULL, N'Outpatient Waiting List Start', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (8, 4, NULL, 3, 1, N'OPWL_END_SEEN', NULL, N'Outpatient Waiting List End (Seen)', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (9, 5, 1, 1, NULL, N'OPNEWAPPT_START', NULL, N'Outpatient New Appointment Start', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (10, 5, 2, 1, NULL, N'OPFUPAPPT_START', NULL, N'Outpatient Follow Up Appointment Start', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (11, 5, 1, 3, 3, N'OPNEWAPPT_END_ATTEND', N'NS', N'New Appointment (Attend)', N'New Outpatient Appointment where the Patient has attended')
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (12, 5, 1, 3, 4, N'OPNEWAPPT_END_DNA', N'ND', N'New Appointment (DNA)', N'New Outpatient Appointment where the Patient did not attend')
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (13, 5, 1, 3, 5, N'OPNEWAPPT_END_RESCHEDULE', NULL, N'New Appointment (Reschedule)', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (14, 5, 2, 3, 3, N'OPFUPAPPT_END_ATTEND', N'FS', N'Follow Up Appointment (Attend)', N'Follow Up Outpatient Appointment where the Patient has attended')
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (15, 5, 2, 3, 4, N'OPFUPAPPT_END_DNA', N'FD', N'Follow Up Appointment (DNA)', N'Follow Up Outpatient Appointment where the Patient did not attend')
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (16, 5, 2, 3, 5, N'OPFUPAPPT_END_RESCHEDULE', NULL, N'Follow Up Appointment (Reschedule)', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (17, 4, NULL, 3, 2, N'OPWL_END_CANCEL', NULL, N'Outpatient Waiting List End (Cancel)', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (18, 6, 3, 1, NULL, N'DTWL_START', NULL, N'Diagnostic Waiting List Start', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (19, 6, 3, 3, 1, N'DTWL_END_SEEN', NULL, N'Diagnostic Waiting List End (Seen)', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (20, 6, 3, 3, 2, N'DTWL_END_CANCEL', NULL, N'Diagnostic Waiting List End (Cancel)', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (21, 6, 4, 1, NULL, N'TTWL_START', NULL, N'Theraputic Waiting List Start', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (22, 6, 4, 3, 1, N'TTWL_END_SEEN', NULL, N'Theraputic Waiting List End (Seen)', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (23, 7, 5, 1, NULL, N'DPROC_START', NULL, N'Diagnostic Procedure Start', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (24, 7, 5, 3, 2, N'DPROC_END_CANCEL', N'DC', N'Diagnostic Procedure (Cancel)', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (25, 7, 5, 3, 3, N'DPROC_END_ATTEND', N'DS', N'Diagnostic Procedure (Attend)', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (26, 7, 5, 3, 4, N'DPROC_END_DNA', N'DD', N'Diagnostic Procedure (DNA)', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (27, 7, 5, 3, 5, N'DPROC_END_RESCHEDULE', NULL, N'Diagnostic Procedure (Reschedule)', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (28, 7, 6, 1, NULL, N'TPROC_START', NULL, N'Theraputic Procedure Start', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (30, 7, 6, 3, 2, N'TPROC_END_CANCEL', N'TC', N'Theraputic Procedure (Cancel)', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (31, 7, 6, 3, 3, N'TPROC_END_ATTEND', N'TS', N'Theraputic Procedure (Attend)', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (32, 7, 6, 3, 4, N'TPROC_END_DNA', N'TD', N'Theraputic Procedure (DNA)', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (33, 7, 6, 3, 5, N'TPROC_END_RESCHEDULE', NULL, N'Theraputic Procedure (Reschedule)', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (34, 5, 1, 3, 2, N'OPNEWAPPT_END_CANCEL', N'NC', N'New Appointment (Cancel)', N'New Outpatient Appointment where the Patient/Hospital has cancelled and no new appointment given')
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (35, 5, 2, 3, 2, N'OPFUPAPPT_END_CANCEL', N'FC', N'Follow Up Appointment (Cancel)', N'Follow Up Outpatient Appointment where the Patient/Hospital has cancelled and no new appointment given')
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (36, 6, 4, 3, 2, N'TTWL_END_CANCEL', NULL, N'Theraputic Waiting List End (Cancel)', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (37, 8, 7, 3, NULL, N'DEATH', N'XX', N'Death', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (38, 4, NULL, 2, NULL, N'OPWL_BOOKED', NULL, N'Outpatient Waiting List Booked', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (39, 9, NULL, 1, NULL, N'ADMISSION_START', N'AM', N'Admission', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (40, 9, NULL, 3, NULL, N'ADMISSION_END', NULL, N'Admission End', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (41, 5, 1, 2, NULL, N'OPNEWAPPT_APPT', NULL, N'Outpatient New Appointment Date', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (42, 5, 2, 2, NULL, N'OPFUPAPPT_APPT', NULL, N'Outpatient Follow Up Appointment Date', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (43, 7, 5, 2, NULL, N'DPROC_TCI', N'D ', N'Diagnostic Procedure TCI', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (44, 7, 6, 2, NULL, N'TPROC_TCI', N'T ', N'Theraputic Procedure TCI', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (45, 7, 6, 3, NULL, N'TPROC_END_NOOUTCOME', N'T-', N'Theraputic Procedure Not Outcomed', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (46, 7, 5, 3, NULL, N'DPROC_END_NOOUTCOME', N'D-', N'Diagnostic Procedure Not Outcomed', NULL)
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (47, 5, 1, 3, NULL, N'OPNEWAPPT_END_NOOUTCOME', N'N-', N'New Appointment Not Outcomed', N'New Outpatient Appointment where the appointment has passed but has not been outcomed in OASIS')
GO
INSERT [RTT].[EventDefinition] ([Id], [EventTypeId], [EventSubTypeId], [EndpointId], [ActionId], [Name], [Code], [Description], [LongDescription]) VALUES (48, 5, 2, 3, NULL, N'OPFUPAPPT_END_NOOUTCOME', N'F-', N'Follow Up Appointment Not Outcomed', N'Follow Up Outpatient Appointment where the appointment has passed but has not been outcomed in OASIS')
GO
SET IDENTITY_INSERT [RTT].[EventDefinition] OFF
GO
SET IDENTITY_INSERT [RTT].[EventDescription] ON 

GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (2, 1, 2, N'Pathway Start', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (3, 2, 2, N'Clock Start', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (4, 2, 1, N'Source: EBS ELECTRONIC BOOKING ', 20)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (5, 3, 1, N'*DNA REAPPOINT ONLY CLINICAL SAFETY REASONS', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (6, 4, 1, N'*TREATMENT GIVEN AT THIS APPT INCLUDING ADMITTED TODAY FROM CLINIC', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (7, 5, 2, N'Clock End', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (8, 6, 2, N' Pathway Start', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (9, 7, 2, N'Clock Start', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (10, 7, 1, N'Source: EBS ELECTRONIC BOOKING', 20)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (11, 8, 1, N'C&B PRIORITY CHANGE FOR OTHER REASONS', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (12, 9, 1, N'*TREATMENT PLAN AGREED I.E. WAITING REPORTS DIAGNOSTICS ETC', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (13, 10, 2, N' Pathway Start', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (14, 11, 2, N'Clock Start', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (15, 11, 2, N'Source: G.P. REFERRAL', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (16, 12, 1, N'*TREATMENT PLAN AGREED I.E. WAITING REPORTS DIAGNOSTICS ETC', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (17, 13, 1, N'*TREATMENT PLAN AGREED I.E. WAITING REPORTS DIAGNOSTICS ETC', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (18, 16, 1, N'*TREATMENT PLAN AGREED I.E. WAITING REPORTS DIAGNOSTICS ETC', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (19, 17, 1, N'*COMMENCE WATCHFUL WAIT ACTIVE SURVEILLANCE CONSULTANT INITIATE', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (20, 18, 1, N'*DNA REAPPOINT ONLY CLINICAL SAFETY REASONS', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (21, 19, 1, N'*DNA REAPPOINT ONLY CLINICAL SAFETY REASONS', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (22, 20, 2, N' Pathway Start', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (23, 21, 2, N'Clock Start', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (24, 21, 1, N'Source: G.P. REFERRAL', 20)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (25, 22, 1, N'C&B PATIENT 8 OTHER MORE PRESSING ENGAGEMENT
 ', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (26, 23, 1, N'*TREATMENT GIVEN AT THIS APPT INCLUDING ADMITTED TODAY FROM CLINIC', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (27, 24, 2, N'Clock End', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (28, 25, 2, N' Pre-Assessment ', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (29, 25, 1, N'*PAC FIT FOR SURGERY', 20)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (30, 26, 2, N'Pathway Start', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (31, 27, 2, N'Clock Start', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (32, 27, 1, N'Source: G.P. REFERRAL', 20)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (33, 28, 2, N'Pre-Assessment', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (34, 28, 1, N'*DNA REAPPOINT TREATMENT PREVIOUSLY GIVEN', 20)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (35, 29, 1, N' *TREATMENT PREVIOUSLY GIVEN CONTINUE TO FOLLOW UP
', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (36, 30, 2, N'Clock End', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (37, 31, 2, N' Pre-Assessment ', 10)
GO
INSERT [RTT].[EventDescription] ([Id], [EventId], [TemplateId], [Description], [DisplayOrder]) VALUES (38, 31, 1, N'*PAC FIT FOR SURGERY', 20)
GO
SET IDENTITY_INSERT [RTT].[EventDescription] OFF
GO
SET IDENTITY_INSERT [RTT].[EventDescriptionTemplate] ON 

GO
INSERT [RTT].[EventDescriptionTemplate] ([Id], [Name], [Description], [Template]) VALUES (1, N'OutcomeDescription', N'Uses the Outcome Description in the RTT.Event table', N'{0}')
GO
INSERT [RTT].[EventDescriptionTemplate] ([Id], [Name], [Description], [Template]) VALUES (2, N'EventDescription', N'Uses the Event Description in the RTT.EventDefinition table', N'{0}')
GO
INSERT [RTT].[EventDescriptionTemplate] ([Id], [Name], [Description], [Template]) VALUES (3, N'DiagnosticProcedures', N'Uses the Outcome Description in the RTT.Event table for Diagnostic Procedures', N'DIAGNOSIS: {0}')
GO
INSERT [RTT].[EventDescriptionTemplate] ([Id], [Name], [Description], [Template]) VALUES (4, N'DischargeDate', N'Uses the Discharge (Admission End Event) of the event', N'Ward Discharge: {0}')
GO
INSERT [RTT].[EventDescriptionTemplate] ([Id], [Name], [Description], [Template]) VALUES (5, N'ReferralSource', N'Uses the referral source from the appointmet referrals table', N'Source: {0}')
GO
INSERT [RTT].[EventDescriptionTemplate] ([Id], [Name], [Description], [Template]) VALUES (6, N'PreAssessment', N'Identifies appointments that have been booked into a pre-assessment clinic', N'Pre-Assessment')
GO
SET IDENTITY_INSERT [RTT].[EventDescriptionTemplate] OFF
GO
SET IDENTITY_INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ON 

GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (1, 1, 2, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (2, 1, 5, 20)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (3, 2, 2, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (4, 3, 2, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (5, 4, 2, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (6, 6, 6, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (7, 7, 6, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (8, 8, 6, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (9, 6, 1, 20)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (10, 7, 1, 20)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (11, 8, 1, 20)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (12, 9, 6, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (13, 10, 6, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (14, 11, 6, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (15, 12, 6, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (16, 9, 1, 20)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (17, 10, 1, 20)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (18, 11, 1, 20)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (19, 12, 1, 20)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (20, 13, 3, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (21, 14, 3, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (22, 15, 1, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (23, 16, 1, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (24, 17, 1, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (25, 18, 1, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (26, 19, 1, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (27, 20, 1, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (28, 21, 1, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (29, 22, 4, 10)
GO
INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] ([Id], [EventDisplayOrderId], [EventDescriptionTemplateId], [TemplateOrder]) VALUES (30, 23, 1, 10)
GO
SET IDENTITY_INSERT [RTT].[EventDescriptionTemplateEventDisplayOrder] OFF
GO
SET IDENTITY_INSERT [RTT].[EventDisplay] ON 

GO
INSERT [RTT].[EventDisplay] ([Id], [Name], [MaxNoEvents], [NoStartEvents], [Version]) VALUES (1, N'OutpatientAttendance_PathwayTimeline', 10, 2, 1)
GO
SET IDENTITY_INSERT [RTT].[EventDisplay] OFF
GO
SET IDENTITY_INSERT [RTT].[EventDisplayOrder] ON 

GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (1, 1, 5, 10, N'clock-start')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (2, 1, 3, 20, N'pathway-start')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (3, 1, 4, 30, N'pathway-end')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (4, 1, 6, 40, N'clock-end')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (6, 1, 11, 60, N'new-seen')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (7, 1, 12, 70, N'new-dna')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (8, 1, 34, 80, N'new-cancel')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (9, 1, 14, 90, N'followup-seen')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (10, 1, 15, 100, N'followup-dna')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (11, 1, 35, 110, N'followup-cancel')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (12, 1, 24, 120, N'dproc-cancel')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (13, 1, 25, 130, N'dproc-seen')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (14, 1, 26, 140, N'dproc-dna')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (15, 1, 30, 150, N'tproc-cancel')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (16, 1, 31, 160, N'tproc-seen')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (17, 1, 32, 170, N'tproc-dna')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (18, 1, 45, 180, N'tproc-nooutcome')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (19, 1, 46, 190, N'dproc-nooutcome')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (20, 1, 47, 200, N'new-nooutcome')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (21, 1, 48, 210, N'followup-nooutcome')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (22, 1, 39, 220, N'adm-start')
GO
INSERT [RTT].[EventDisplayOrder] ([Id], [EventDisplayId], [EventDefinitionId], [DisplayOrder], [CssClass]) VALUES (23, 1, 37, 240, N'death')
GO
SET IDENTITY_INSERT [RTT].[EventDisplayOrder] OFF
GO
SET IDENTITY_INSERT [RTT].[EventEndpoint] ON 

GO
INSERT [RTT].[EventEndpoint] ([Id], [Name], [Description]) VALUES (1, N'S', N'Start')
GO
INSERT [RTT].[EventEndpoint] ([Id], [Name], [Description]) VALUES (2, N'M', N'Midpoint')
GO
INSERT [RTT].[EventEndpoint] ([Id], [Name], [Description]) VALUES (3, N'E', N'End')
GO
SET IDENTITY_INSERT [RTT].[EventEndpoint] OFF
GO
SET IDENTITY_INSERT [RTT].[EventSubType] ON 

GO
INSERT [RTT].[EventSubType] ([Id], [EventTypeId], [Name], [Description]) VALUES (1, 5, N'NEW', N'New Appointment')
GO
INSERT [RTT].[EventSubType] ([Id], [EventTypeId], [Name], [Description]) VALUES (2, 5, N'FUP', N'Follow Up Appointment')
GO
INSERT [RTT].[EventSubType] ([Id], [EventTypeId], [Name], [Description]) VALUES (3, 6, N'DIAGNOSTIC', N'Diagnostic Waiting List')
GO
INSERT [RTT].[EventSubType] ([Id], [EventTypeId], [Name], [Description]) VALUES (4, 6, N'THERAPUTIC', N'Theraputic Waiting List')
GO
INSERT [RTT].[EventSubType] ([Id], [EventTypeId], [Name], [Description]) VALUES (5, 7, N'DIAGNOSTIC', N'Diagnostic Procedure')
GO
INSERT [RTT].[EventSubType] ([Id], [EventTypeId], [Name], [Description]) VALUES (6, 7, N'THERAPUTIC', N'Theraputic Procedure')
GO
INSERT [RTT].[EventSubType] ([Id], [EventTypeId], [Name], [Description]) VALUES (7, 8, N'DEATH', N'Death')
GO
SET IDENTITY_INSERT [RTT].[EventSubType] OFF
GO
SET IDENTITY_INSERT [RTT].[EventType] ON 

GO
INSERT [RTT].[EventType] ([Id], [Name], [Description]) VALUES (1, N'REFERRAL', N'Referral')
GO
INSERT [RTT].[EventType] ([Id], [Name], [Description]) VALUES (2, N'PATHWAY', N'Pathway')
GO
INSERT [RTT].[EventType] ([Id], [Name], [Description]) VALUES (3, N'CLOCK', N'Clock')
GO
INSERT [RTT].[EventType] ([Id], [Name], [Description]) VALUES (4, N'OPWL', N'Outpatient  Waiting List')
GO
INSERT [RTT].[EventType] ([Id], [Name], [Description]) VALUES (5, N'OPAPP', N'Outpatient Appointment')
GO
INSERT [RTT].[EventType] ([Id], [Name], [Description]) VALUES (6, N'TWL', N'Treatment Waiting List')
GO
INSERT [RTT].[EventType] ([Id], [Name], [Description]) VALUES (7, N'PROC', N'Procedure')
GO
INSERT [RTT].[EventType] ([Id], [Name], [Description]) VALUES (8, N'LIFE', N'Life Event')
GO
INSERT [RTT].[EventType] ([Id], [Name], [Description]) VALUES (9, N'ADMISSION', N'Admission')
GO
SET IDENTITY_INSERT [RTT].[EventType] OFF
GO
SET IDENTITY_INSERT [RTT].[Pathway] ON 

GO
INSERT [RTT].[Pathway] ([PathwayId], [PathwayNumber], [DaysWait], [ClockStartDate], [ClockStopDate]) VALUES (1, N'000000000000000', 84, CAST(N'2015-11-05' AS Date), CAST(N'2016-02-03' AS Date))
GO
INSERT [RTT].[Pathway] ([PathwayId], [PathwayNumber], [DaysWait], [ClockStartDate], [ClockStopDate]) VALUES (2, N'000000000000001', 161, CAST(N'2016-05-06' AS Date), NULL)
GO
INSERT [RTT].[Pathway] ([PathwayId], [PathwayNumber], [DaysWait], [ClockStartDate], [ClockStopDate]) VALUES (3, N'000000000000002', 196, CAST(N'2016-04-27' AS Date), NULL)
GO
INSERT [RTT].[Pathway] ([PathwayId], [PathwayNumber], [DaysWait], [ClockStartDate], [ClockStopDate]) VALUES (4, N'000000000000003', 105, CAST(N'2015-11-16' AS Date), CAST(N'2016-03-01' AS Date))
GO
INSERT [RTT].[Pathway] ([PathwayId], [PathwayNumber], [DaysWait], [ClockStartDate], [ClockStopDate]) VALUES (5, N'000000000000004', 49, CAST(N'2015-12-11' AS Date), CAST(N'2016-02-03' AS Date))
GO
SET IDENTITY_INSERT [RTT].[Pathway] OFF
GO
/****** Object:  Index [IX_RttEvent_EventDateTimeASC]    Script Date: 29/04/2017 20:18:28 ******/
CREATE NONCLUSTERED INDEX [IX_RttEvent_EventDateTimeASC] ON [RTT].[Event]
(
	[EventDateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RttEvent_EventDateTimeDESC]    Script Date: 29/04/2017 20:18:28 ******/
CREATE NONCLUSTERED INDEX [IX_RttEvent_EventDateTimeDESC] ON [RTT].[Event]
(
	[EventDateTime] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RttEvents_EncounterId]    Script Date: 29/04/2017 20:18:28 ******/
CREATE NONCLUSTERED INDEX [IX_RttEvents_EncounterId] ON [RTT].[Event]
(
	[EncounterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RttEvents_RttPathwayId]    Script Date: 29/04/2017 20:18:28 ******/
CREATE NONCLUSTERED INDEX [IX_RttEvents_RttPathwayId] ON [RTT].[Event]
(
	[PathwayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RttEventDescription_EventId]    Script Date: 29/04/2017 20:18:28 ******/
CREATE NONCLUSTERED INDEX [IX_RttEventDescription_EventId] ON [RTT].[EventDescription]
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [app].[FormGeneratorSearchTemplate]  WITH CHECK ADD  CONSTRAINT [FK_FormGeneratorSearchTemplate_FormGeneratorGroup] FOREIGN KEY([GroupId])
REFERENCES [app].[FormGeneratorGroup] ([Id])
GO
ALTER TABLE [app].[FormGeneratorSearchTemplate] CHECK CONSTRAINT [FK_FormGeneratorSearchTemplate_FormGeneratorGroup]
GO
ALTER TABLE [app].[FormGeneratorSearchTemplate]  WITH CHECK ADD  CONSTRAINT [FK_FormGeneratorSearchTemplate_FormGeneratorOASISQuery] FOREIGN KEY([PASQueryId])
REFERENCES [app].[FormGeneratorPASQuery] ([Id])
GO
ALTER TABLE [app].[FormGeneratorSearchTemplate] CHECK CONSTRAINT [FK_FormGeneratorSearchTemplate_FormGeneratorOASISQuery]
GO
ALTER TABLE [app].[FormGeneratorSearchTemplate]  WITH CHECK ADD  CONSTRAINT [FK_FormGeneratorSearchTemplate_FormGeneratorSearch] FOREIGN KEY([SearchId])
REFERENCES [app].[FormGeneratorSearch] ([Id])
GO
ALTER TABLE [app].[FormGeneratorSearchTemplate] CHECK CONSTRAINT [FK_FormGeneratorSearchTemplate_FormGeneratorSearch]
GO
ALTER TABLE [app].[FormGeneratorSearchTemplate]  WITH CHECK ADD  CONSTRAINT [FK_FormGeneratorSearchTemplate_FormGeneratorTemplate] FOREIGN KEY([TemplateId])
REFERENCES [app].[FormGeneratorTemplate] ([Id])
GO
ALTER TABLE [app].[FormGeneratorSearchTemplate] CHECK CONSTRAINT [FK_FormGeneratorSearchTemplate_FormGeneratorTemplate]
GO
ALTER TABLE [app].[FormGeneratorTemplate]  WITH CHECK ADD  CONSTRAINT [FK_FormGeneratorTemplate_FormGeneratorGroup] FOREIGN KEY([GroupId])
REFERENCES [app].[FormGeneratorGroup] ([Id])
GO
ALTER TABLE [app].[FormGeneratorTemplate] CHECK CONSTRAINT [FK_FormGeneratorTemplate_FormGeneratorGroup]
GO
ALTER TABLE [app].[FormGeneratorTemplate]  WITH CHECK ADD  CONSTRAINT [FK_FormGeneratorTemplate_FormGeneratorOASISQuery] FOREIGN KEY([EncounterPASQueryId])
REFERENCES [app].[FormGeneratorPASQuery] ([Id])
GO
ALTER TABLE [app].[FormGeneratorTemplate] CHECK CONSTRAINT [FK_FormGeneratorTemplate_FormGeneratorOASISQuery]
GO
ALTER TABLE [PAS].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Clinic] FOREIGN KEY([ClinicId])
REFERENCES [PAS].[Clinic] ([ClinicId])
GO
ALTER TABLE [PAS].[Appointment] CHECK CONSTRAINT [FK_Appointment_Clinic]
GO
ALTER TABLE [PAS].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Patient] FOREIGN KEY([PatientId])
REFERENCES [PAS].[Patient] ([PatientId])
GO
ALTER TABLE [PAS].[Appointment] CHECK CONSTRAINT [FK_Appointment_Patient]
GO
ALTER TABLE [PAS].[Clinic]  WITH CHECK ADD  CONSTRAINT [FK_Clinic_Consultant] FOREIGN KEY([ConsultantId])
REFERENCES [PAS].[Consultant] ([ConsultantId])
GO
ALTER TABLE [PAS].[Clinic] CHECK CONSTRAINT [FK_Clinic_Consultant]
GO
ALTER TABLE [PAS].[Clinic]  WITH CHECK ADD  CONSTRAINT [FK_Clinic_Specialty] FOREIGN KEY([SpecialtyId])
REFERENCES [PAS].[Specialty] ([SpecialtyId])
GO
ALTER TABLE [PAS].[Clinic] CHECK CONSTRAINT [FK_Clinic_Specialty]
GO
ALTER TABLE [RTT].[EventDefinition]  WITH CHECK ADD  CONSTRAINT [FK_EventDefinition_EventAction] FOREIGN KEY([ActionId])
REFERENCES [RTT].[EventAction] ([Id])
GO
ALTER TABLE [RTT].[EventDefinition] CHECK CONSTRAINT [FK_EventDefinition_EventAction]
GO
ALTER TABLE [RTT].[EventDefinition]  WITH CHECK ADD  CONSTRAINT [FK_EventDefinition_EventEndpoint] FOREIGN KEY([EndpointId])
REFERENCES [RTT].[EventEndpoint] ([Id])
GO
ALTER TABLE [RTT].[EventDefinition] CHECK CONSTRAINT [FK_EventDefinition_EventEndpoint]
GO
ALTER TABLE [RTT].[EventDefinition]  WITH CHECK ADD  CONSTRAINT [FK_EventDefinition_EventSubType] FOREIGN KEY([EventSubTypeId])
REFERENCES [RTT].[EventSubType] ([Id])
GO
ALTER TABLE [RTT].[EventDefinition] CHECK CONSTRAINT [FK_EventDefinition_EventSubType]
GO
ALTER TABLE [RTT].[EventDefinition]  WITH CHECK ADD  CONSTRAINT [FK_EventDefinition_EventType] FOREIGN KEY([EventTypeId])
REFERENCES [RTT].[EventType] ([Id])
GO
ALTER TABLE [RTT].[EventDefinition] CHECK CONSTRAINT [FK_EventDefinition_EventType]
GO
ALTER TABLE [RTT].[EventDescriptionTemplateEventDisplayOrder]  WITH CHECK ADD  CONSTRAINT [FK_EventDescriptionTemplateDisplayOrder_EventDescriptionTemplate] FOREIGN KEY([EventDescriptionTemplateId])
REFERENCES [RTT].[EventDefinition] ([Id])
GO
ALTER TABLE [RTT].[EventDescriptionTemplateEventDisplayOrder] CHECK CONSTRAINT [FK_EventDescriptionTemplateDisplayOrder_EventDescriptionTemplate]
GO
ALTER TABLE [RTT].[EventDescriptionTemplateEventDisplayOrder]  WITH CHECK ADD  CONSTRAINT [FK_EventDescriptionTemplateDisplayOrder_EventDisplayOrder] FOREIGN KEY([EventDisplayOrderId])
REFERENCES [RTT].[EventDisplayOrder] ([Id])
GO
ALTER TABLE [RTT].[EventDescriptionTemplateEventDisplayOrder] CHECK CONSTRAINT [FK_EventDescriptionTemplateDisplayOrder_EventDisplayOrder]
GO
ALTER TABLE [RTT].[EventDisplayOrder]  WITH CHECK ADD  CONSTRAINT [FK_EventDisplayOrder_EventDefinition] FOREIGN KEY([EventDefinitionId])
REFERENCES [RTT].[EventDefinition] ([Id])
GO
ALTER TABLE [RTT].[EventDisplayOrder] CHECK CONSTRAINT [FK_EventDisplayOrder_EventDefinition]
GO
ALTER TABLE [RTT].[EventDisplayOrder]  WITH CHECK ADD  CONSTRAINT [FK_EventDisplayOrder_EventDisplay] FOREIGN KEY([EventDisplayId])
REFERENCES [RTT].[EventDisplay] ([Id])
GO
ALTER TABLE [RTT].[EventDisplayOrder] CHECK CONSTRAINT [FK_EventDisplayOrder_EventDisplay]
GO
ALTER TABLE [RTT].[EventSubType]  WITH CHECK ADD  CONSTRAINT [FK_EventSubType_EventType] FOREIGN KEY([EventTypeId])
REFERENCES [RTT].[EventType] ([Id])
GO
ALTER TABLE [RTT].[EventSubType] CHECK CONSTRAINT [FK_EventSubType_EventType]
GO
/****** Object:  StoredProcedure [app].[uspFormGenerator_GetFormGroup]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [app].[uspFormGenerator_GetFormGroup]
AS
	BEGIN
		SELECT g.Id, g.Name, g.Description, g.ImageUrl, g.CssClass, t.TemplateName AS DefaultTemplateName,
			CASE (SELECT COUNT(*) FROM [APP].FormGeneratorSearchTemplate st WHERE st.GroupId = g.Id) 
				WHEN 0 THEN 0
				ELSE 1 
			END AS ShowSearch
		FROM [APP].[FormGeneratorGroup] g
		LEFT JOIN [APP].FormGeneratorTemplate t ON g.DefaultTemplateId = t.Id
		WHERE g.Display = 1
	END

GO
/****** Object:  StoredProcedure [app].[uspFormGenerator_GetFormSearchByGroupId]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [app].[uspFormGenerator_GetFormSearchByGroupId]
	@id int
AS
	BEGIN
		SET NOCOUNT ON;

		SELECT s.Name AS SearchName, s.Description AS SearchDescription, s.Url AS SearchUrl, t.Id AS TemplateId
		FROM [APP].[FormGeneratorSearchTemplate] st
		JOIN [APP].[FormGeneratorSearch] s ON st.SearchId = s.Id
		JOIN [APP].[FormGeneratorTemplate] t ON st.TemplateId = t.Id
		WHERE st.GroupId = @id AND t.Display = 1
		ORDER BY s.DisplayOrder
	END

GO
/****** Object:  StoredProcedure [app].[uspFormGenerator_GetFormTemplateByAllName]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [app].[uspFormGenerator_GetFormTemplateByAllName]
	@name NVARCHAR(255)
AS
	BEGIN
		SET NOCOUNT ON;

		SELECT t.*, q.[SQL]
		FROM [APP].[FormGeneratorTemplate] t
		LEFT JOIN [APP].[FormGeneratorPASQuery] q ON t.EncounterPASQueryId = q.Id
		WHERE t.AllTemplateName = @name
	END

GO
/****** Object:  StoredProcedure [app].[uspFormGenerator_GetFormTemplateById]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [app].[uspFormGenerator_GetFormTemplateById]
	@id int
AS
	BEGIN
		SET NOCOUNT ON;

		SELECT *
		FROM [APP].[FormGeneratorTemplate]
		WHERE Id = @id
	END

GO
/****** Object:  StoredProcedure [app].[uspFormGenerator_GetFormTemplateByName]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [app].[uspFormGenerator_GetFormTemplateByName]
	@name NVARCHAR(255)
AS
	BEGIN
		SET NOCOUNT ON;

		SELECT t.*, q.[SQL]
		FROM [APP].[FormGeneratorTemplate] t
		LEFT JOIN [APP].[FormGeneratorPASQuery] q ON t.EncounterPASQueryId = q.Id
		WHERE t.TemplateName = @name
	END

GO
/****** Object:  StoredProcedure [app].[uspFormGenerator_GetPASQueryByName]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [app].[uspFormGenerator_GetPASQueryByName]
	@name NVARCHAR(255)
AS
	BEGIN
		SET NOCOUNT ON;
		SELECT TOP 1 q.Name, q.[SQL] FROM [APP].[FormGeneratorPASQuery] q WHERE q.Name = @name 
	END

GO
/****** Object:  StoredProcedure [app].[uspFormGenerator_GetPASQueryByNameTemplateId]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [app].[uspFormGenerator_GetPASQueryByNameTemplateId]
	@name NVARCHAR(255),
	@id int
AS
	BEGIN
		SET NOCOUNT ON;

		SELECT TOP 1 q.Name, q.[SQL]
		FROM [APP].[FormGeneratorPASQuery] q
		JOIN [APP].[FormGeneratorSearchTemplate] st ON q.Id = st.PASQueryId
		WHERE q.Name = @name AND st.TemplateId = @id
	END

GO
/****** Object:  StoredProcedure [RTT].[uspCribSheet]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [RTT].[uspCribSheet]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT  ed.Code,
			ed.Name AS EventName,
			ed.[Description]  AS EventDescription,
			edo.CssClass, LongDescription
	FROM RTT.[EventDefinition] ed
	JOIN RTT.[EventDisplayOrder] edo ON ed.Id = edo.EventDefinitionId
	JOIN RTT.[EventDisplay] display ON display.Id = edo.EventDisplayId
	LEFT JOIN RTT.EventAction act ON ed.ActionId = act.Id
	LEFT JOIN RTT.EventEndpoint ep ON ed.EndpointId = ep.Id
	LEFT JOIN RTT.EventType et ON ed.EventTypeId = et.Id
	LEFT JOIN RTT.EventSubType sub ON ed.EventSubTypeId = sub.Id
	WHERE display.Name = 'OutpatientAttendance_PathwayTimeline' AND display.Version = 1
	ORDER BY edo.DisplayOrder;		
END

GO
/****** Object:  StoredProcedure [RTT].[uspEventSummary]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [RTT].[uspEventSummary]
	@PatientId INT, @PathwayId INT, @EncounterId INT
AS
BEGIN
	SET NOCOUNT ON;

	IF(EXISTS(SELECT ev.Id FROM RTT.[Event] ev WHERE ev.PathwayId = @PathwayId AND ev.Ix = 1))
	BEGIN
		SELECT 
			(SELECT COUNT(*) FROM RTT.[Event] totalDNA JOIN RTT.[EventDefinition] ed ON totalDNA.EventDefinitionId = ed.Id WHERE rtt.PathwayId = totalDNA.PathwayId AND ed.ActionId = 4) AS NoDNA
			,(SELECT TOP 1 SerialDnaIx FROM RTT.[Event] serialDNA WHERE rtt.PathwayId = serialDNA.PathwayId AND serialDNA.SerialDnaIx IS NOT NULL ORDER BY serialDNA.EventDateTime DESC, serialDNA.SerialDnaIx DESC) AS NoSerialDNA
			,FLOOR(dmRtt.DaysWait / 7)  AS RttWeek
			,(SELECT COUNT(*) FROM RTT.[Event] resechedule JOIN RTT.[EventDefinition] ed ON resechedule.EventDefinitionId = ed.Id WHERE rtt.PathwayId = resechedule.PathwayId AND ActionId = 5 AND resechedule.OutcomeCode = '86350') AS NoRescheduleHospital
			,(SELECT COUNT(*) FROM RTT.[Event] resechedule JOIN RTT.[EventDefinition] ed ON resechedule.EventDefinitionId = ed.Id WHERE rtt.PathwayId = resechedule.PathwayId AND ActionId = 5 AND resechedule.OutcomeCode = '90375') AS NoReschedulePatient
			,(SELECT COUNT(*) FROM RTT.[Event] cancel JOIN RTT.[EventDefinition] ed ON cancel.EventDefinitionId = ed.Id WHERE rtt.PathwayId = cancel.PathwayId AND ActionId = 2) AS NoCancellation
			,CASE WHEN FLOOR(dmRtt.DaysWait / 7) > 18 THEN
				1
			END AS IsLongerThan18Weeks
			,CASE WHEN dmRtt.ClockStartDate IS NOT NULL AND dmRtt.ClockStopDate IS NULL THEN
				1
			END AS IsClockRunning
			,CASE WHEN dmRtt.ClockStopDate IS NOT NULL THEN
				1
			END AS IsClockStopped
			,CASE WHEN (SELECT TOP 1 SerialDnaIx FROM RTT.[Event] serialDNA WHERE rtt.PathwayId = serialDNA.PathwayId AND serialDNA.SerialDnaIx IS NOT NULL ORDER BY serialDNA.EventDateTime DESC) > 1 THEN
				1
			END AS IsSerialDna
		FROM RTT.[Event] rtt
		LEFT JOIN RTT.Pathway dmRtt ON rtt.PathwayId = dmRtt.PathwayId
		WHERE rtt.PathwayId = @PathwayId AND rtt.Ix = 1
	END
	ELSE
	BEGIN -- Return something so that the outcome options are displayed
		SELECT '--' AS NoDNA, '--' AS NoSerialDNA, '--' AS RttWeek, '--' AS NoRescheduleHospital, '--' AS NoReschedulePatient, '--' AS NoCancellation,
		1 AS IsClockRunning, 1 AS IsClockStopped, 1 AS IsNotFound
	END
END

GO
/****** Object:  StoredProcedure [RTT].[uspPathwayTimeLine]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [RTT].[uspPathwayTimeLine]
	@PatientId INT, @PathwayId INT, @EncounterId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @maxNoEvents INT; 
	SELECT TOP 1 @maxNoEvents = MaxNoEvents FROM RTT.[EventDisplay] ed WHERE ed.Name = 'OutpatientAttendance_PathwayTimeline' AND ed.[Version] = 1;

	SELECT TOP (@maxNoEvents) rtt.EncounterId,
			FORMAT(rtt.EventDate, 'dd-MMM-yyyy') AS EventDate, 
			ed.Code,
			ed.Name AS EventName,

			STUFF(( SELECT '<br/>' + evd.[Description] 
					FROM RTT.EventDescription evd 
					WHERE evd.EventId = rtt.Id 
					ORDER BY evd.DisplayOrder
					FOR XML PATH(''), type).value('.', 'varchar(max)'), 1, 5, '') AS EventDescription,
			CASE code 
				WHEN 'CS' THEN ''
				WHEN 'PS' THEN ''
				WHEN 'PE' THEN ''
			ELSE
				CASE WHEN (SELECT TOP 1 a.DaysWait FROM RTT.Pathway a WHERE a.PathwayId = rtt.PathwayId AND rtt.EventDate >= a.ClockStartDate AND (a.ClockStopDate IS NULL OR rtt.EventDate <= a.ClockStopDate)) IS NULL THEN
					'Watchful Wait'
				ELSE
					CAST(FLOOR(DATEDIFF(d, 
						(SELECT TOP 1 a.ClockStartDate FROM RTT.Pathway a WHERE a.PathwayId = rtt.PathwayId AND rtt.EventDate >= a.ClockStartDate AND (a.ClockStopDate IS NULL OR rtt.EventDate <= a.ClockStopDate) ORDER BY a.ClockStopDate)
							, rtt.EventDate) / 7) AS varchar(5)) + ' wks'
				END
			END AS WeeksWait,
			ego.CssClass
	FROM RTT.[Event] rtt 
	JOIN RTT.[EventDefinition] ed ON rtt.EventDefinitionId = ed.Id
	JOIN RTT.[EventDisplayOrder] ego ON ed.Id = ego.EventDefinitionId
	JOIN RTT.[EventDisplay] eg ON eg.Id = ego.EventDisplayId
	LEFT JOIN RTT.EventAction act ON ed.ActionId = act.Id
	LEFT JOIN RTT.EventEndpoint ep ON ed.EndpointId = ep.Id
	LEFT JOIN RTT.EventType et ON ed.EventTypeId = et.Id
	LEFT JOIN RTT.EventSubType sub ON ed.EventSubTypeId = sub.Id
	WHERE rtt.PathwayId = @PathwayId AND eg.Name = 'OutpatientAttendance_PathwayTimeline' AND eg.[Version] = 1
	ORDER BY rtt.EventDate DESC, ego.DisplayOrder;
END

GO
/****** Object:  StoredProcedure [RTT].[uspPathwayTimeLine_Summary]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Matthew Cutting
-- ALTER date:	22.08.2016
-- Description:	Used by the dynamic outpatient attendance form for displaying a summary of events if there are too many events to fit on the timeline
-- =============================================
CREATE PROCEDURE [RTT].[uspPathwayTimeLine_Summary]
	@PatientId INT, @PathwayId INT, @EncounterId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @maxNoEvents INT; 
	DECLARE @noStartEvents INT; 
	DECLARE @noEvents INT; 

	SELECT TOP 1 @maxNoEvents = MaxNoEvents, @noStartEvents = NoStartEvents FROM RTT.[EventDisplay] ed WHERE ed.Name = 'OutpatientAttendance_PathwayTimeline' AND ed.[Version] = 1;

	SELECT @noEvents = COUNT(*) 
	FROM RTT.[Event] rtt 
	JOIN RTT.[EventDefinition] ed ON rtt.EventDefinitionId = ed.Id
	JOIN RTT.[EventDisplayOrder] ego ON ed.Id = ego.EventDefinitionId
	JOIN RTT.[EventDisplay] eg ON eg.Id = ego.EventDisplayId
	LEFT JOIN RTT.EventAction act ON ed.ActionId = act.Id
	LEFT JOIN RTT.EventEndpoint ep ON ed.EndpointId = ep.Id
	LEFT JOIN RTT.EventType et ON ed.EventTypeId = et.Id
	LEFT JOIN RTT.EventSubType sub ON ed.EventSubTypeId = sub.Id
	WHERE rtt.PathwayId = @PathwayId AND eg.Name = 'OutpatientAttendance_PathwayTimeline' AND eg.[Version] = 1; 


	IF @noEvents > @maxNoEvents 
	BEGIN
		DECLARE @ExcludedEvents TABLE(Id INT)

		--Exclude events that have already been written
		INSERT INTO @ExcludedEvents (Id)
		SELECT TOP (@maxNoEvents) rtt.Id
		FROM RTT.[Event] rtt 
		JOIN RTT.[EventDefinition] ed ON rtt.EventDefinitionId = ed.Id
		JOIN RTT.[EventDisplayOrder] ego ON ed.Id = ego.EventDefinitionId
		JOIN RTT.[EventDisplay] eg ON eg.Id = ego.EventDisplayId
		LEFT JOIN RTT.EventAction act ON ed.ActionId = act.Id
		LEFT JOIN RTT.EventEndpoint ep ON ed.EndpointId = ep.Id
		LEFT JOIN RTT.EventType et ON ed.EventTypeId = et.Id
		LEFT JOIN RTT.EventSubType sub ON ed.EventSubTypeId = sub.Id
		WHERE rtt.PathwayId = @PathwayId AND eg.Name = 'OutpatientAttendance_PathwayTimeline' AND eg.[Version] = 1
		ORDER BY rtt.EventDate DESC, ego.DisplayOrder;

		--Exclude events that are in the start top x
		INSERT INTO @ExcludedEvents (Id)
		SELECT TOP (@noStartEvents) rtt.Id 
		FROM RTT.[Event] rtt 
		JOIN RTT.[EventDefinition] ed ON rtt.EventDefinitionId = ed.Id
		JOIN RTT.[EventDisplayOrder] ego ON ed.Id = ego.EventDefinitionId
		JOIN RTT.[EventDisplay] eg ON eg.Id = ego.EventDisplayId
		LEFT JOIN RTT.EventAction act ON ed.ActionId = act.Id
		LEFT JOIN RTT.EventEndpoint ep ON ed.EndpointId = ep.Id
		LEFT JOIN RTT.EventType et ON ed.EventTypeId = et.Id
		LEFT JOIN RTT.EventSubType sub ON ed.EventSubTypeId = sub.Id
		WHERE eg.Name = 'OutpatientAttendance_PathwayTimeline' AND eg.[Version] = 1 AND rtt.PathwayId = @PathwayId 
		ORDER BY rtt.EventDate, ego.DisplayOrder; -- then sort in descending

		-- Return the summary
		SELECT 
			ed.Code, ed.[Description], 
			(SELECT COUNT(*) 
				FROM RTT.[Event] rtt 
				JOIN RTT.[EventDefinition] ed2 ON rtt.EventDefinitionId = ed2.Id
				WHERE 
					rtt.PathwayId = @PathwayId AND ed2.Code = ed.Code AND rtt.Id NOT IN (SELECT Id FROM @ExcludedEvents)
			) NoEvents
		FROM RTT.[EventDefinition] ed
		JOIN RTT.[EventDisplayOrder] ego ON ed.Id = ego.EventDefinitionId
		JOIN RTT.[EventDisplay] eg ON eg.Id = ego.EventDisplayId
		LEFT JOIN RTT.EventAction act ON ed.ActionId = act.Id
		LEFT JOIN RTT.EventEndpoint ep ON ed.EndpointId = ep.Id
		LEFT JOIN RTT.EventType et ON ed.EventTypeId = et.Id
		LEFT JOIN RTT.EventSubType sub ON ed.EventSubTypeId = sub.Id
		WHERE eg.Name = 'OutpatientAttendance_PathwayTimeline' AND eg.[Version] = 1
			AND (SELECT COUNT(*) 
					FROM RTT.[Event] rtt 
					JOIN RTT.[EventDefinition] ed2 ON rtt.EventDefinitionId = ed2.Id
				WHERE 
					rtt.PathwayId = @PathwayId AND ed2.Code = ed.Code AND rtt.Id NOT IN (SELECT Id FROM @ExcludedEvents)
			) > 0 
		ORDER BY ego.DisplayOrder DESC;
	END
END

GO
/****** Object:  StoredProcedure [RTT].[uspPathwayTimeLine_SummaryDates]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Matthew Cutting
-- ALTER date:	22.08.2016
-- Description:	Used by the dynamic outpatient attendance form for displaying a summary of events if there are too many events to fit on the timeline
-- =============================================
CREATE PROCEDURE [RTT].[uspPathwayTimeLine_SummaryDates]
	@PatientId INT, @PathwayId INT, @EncounterId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @maxNoEvents INT; 
	DECLARE @noStartEvents INT; 
	DECLARE @noEvents INT; 

	SELECT TOP 1 @maxNoEvents = MaxNoEvents, @noStartEvents = NoStartEvents FROM RTT.[EventDisplay] ed WHERE ed.Name = 'OutpatientAttendance_PathwayTimeline' AND ed.[Version] = 1;

	SELECT @noEvents = COUNT(*) 
	FROM RTT.[Event] rtt 
	JOIN RTT.[EventDefinition] ed ON rtt.EventDefinitionId = ed.Id
	JOIN RTT.[EventDisplayOrder] ego ON ed.Id = ego.EventDefinitionId
	JOIN RTT.[EventDisplay] eg ON eg.Id = ego.EventDisplayId
	LEFT JOIN RTT.EventAction act ON ed.ActionId = act.Id
	LEFT JOIN RTT.EventEndpoint ep ON ed.EndpointId = ep.Id
	LEFT JOIN RTT.EventType et ON ed.EventTypeId = et.Id
	LEFT JOIN RTT.EventSubType sub ON ed.EventSubTypeId = sub.Id
	WHERE rtt.PathwayId = @PathwayId AND eg.Name = 'OutpatientAttendance_PathwayTimeline' AND eg.[Version] = 1; 


	IF @noEvents > @maxNoEvents 
	BEGIN
		DECLARE @ExcludedEvents TABLE(Id INT)

		--Exclude events that have already been written
		INSERT INTO @ExcludedEvents (Id)
		SELECT TOP (@maxNoEvents) rtt.Id
		FROM RTT.[Event] rtt 
		JOIN RTT.[EventDefinition] ed ON rtt.EventDefinitionId = ed.Id
		JOIN RTT.[EventDisplayOrder] ego ON ed.Id = ego.EventDefinitionId
		JOIN RTT.[EventDisplay] eg ON eg.Id = ego.EventDisplayId
		LEFT JOIN RTT.EventAction act ON ed.ActionId = act.Id
		LEFT JOIN RTT.EventEndpoint ep ON ed.EndpointId = ep.Id
		LEFT JOIN RTT.EventType et ON ed.EventTypeId = et.Id
		LEFT JOIN RTT.EventSubType sub ON ed.EventSubTypeId = sub.Id
		WHERE rtt.PathwayId = @PathwayId AND eg.Name = 'OutpatientAttendance_PathwayTimeline' AND eg.[Version] = 1
		ORDER BY rtt.EventDate DESC, ego.DisplayOrder;

		--Exclude events that are in the start top x
		INSERT INTO @ExcludedEvents (Id)
		SELECT TOP (@noStartEvents) rtt.Id 
		FROM RTT.[Event] rtt 
		JOIN RTT.[EventDefinition] ed ON rtt.EventDefinitionId = ed.Id
		JOIN RTT.[EventDisplayOrder] ego ON ed.Id = ego.EventDefinitionId
		JOIN RTT.[EventDisplay] eg ON eg.Id = ego.EventDisplayId
		LEFT JOIN RTT.EventAction act ON ed.ActionId = act.Id
		LEFT JOIN RTT.EventEndpoint ep ON ed.EndpointId = ep.Id
		LEFT JOIN RTT.EventType et ON ed.EventTypeId = et.Id
		LEFT JOIN RTT.EventSubType sub ON ed.EventSubTypeId = sub.Id
		WHERE eg.Name = 'OutpatientAttendance_PathwayTimeline' AND eg.[Version] = 1 AND rtt.PathwayId = @PathwayId 
		ORDER BY rtt.EventDate, ego.DisplayOrder; -- then sort in descending

		-- Return the first and last dates
		SELECT FORMAT(MIN(rtt.EventDate), 'dd-MMM-yyyy') AS StartDate, FORMAT(MAX(rtt.EventDate), 'dd-MMM-yyyy') AS EndDate
		FROM RTT.[Event] rtt 
		JOIN RTT.[EventDefinition] ed ON rtt.EventDefinitionId = ed.Id
		JOIN RTT.[EventDisplayOrder] ego ON ed.Id = ego.EventDefinitionId
		JOIN RTT.[EventDisplay] eg ON eg.Id = ego.EventDisplayId
		LEFT JOIN RTT.EventAction act ON ed.ActionId = act.Id
		LEFT JOIN RTT.EventEndpoint ep ON ed.EndpointId = ep.Id
		LEFT JOIN RTT.EventType et ON ed.EventTypeId = et.Id
		LEFT JOIN RTT.EventSubType sub ON ed.EventSubTypeId = sub.Id
		WHERE eg.Name = 'OutpatientAttendance_PathwayTimeline' AND eg.[Version] = 1
			AND rtt.PathwayId = @PathwayId AND rtt.Id NOT IN (SELECT Id FROM @ExcludedEvents)
		--GROUP BY rtt.e;
	END
END

GO
/****** Object:  StoredProcedure [RTT].[uspPathwayTimeLine_SummaryStart]    Script Date: 29/04/2017 20:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [RTT].[uspPathwayTimeLine_SummaryStart]
	@PatientId INT, @PathwayId INT, @EncounterId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @maxNoEvents INT; 
	DECLARE @noStartEvents INT; 
	DECLARE @noEvents INT; 

	SELECT TOP 1 @maxNoEvents = MaxNoEvents, @noStartEvents = NoStartEvents FROM RTT.[EventDisplay] ed WHERE ed.Name = 'OutpatientAttendance_PathwayTimeline' AND ed.[Version] = 1;

	SELECT @noEvents = COUNT(*) 
		FROM RTT.[Event] rtt 
		JOIN RTT.[EventDefinition] ed ON rtt.EventDefinitionId = ed.Id
		JOIN RTT.[EventDisplayOrder] ego ON ed.Id = ego.EventDefinitionId
		JOIN RTT.[EventDisplay] eg ON eg.Id = ego.EventDisplayId
		LEFT JOIN RTT.EventAction act ON ed.ActionId = act.Id
		LEFT JOIN RTT.EventEndpoint ep ON ed.EndpointId = ep.Id
		LEFT JOIN RTT.EventType et ON ed.EventTypeId = et.Id
		LEFT JOIN RTT.EventSubType sub ON ed.EventSubTypeId = sub.Id
	WHERE rtt.PathwayId = @PathwayId AND eg.Name = 'OutpatientAttendance_PathwayTimeline' AND eg.[Version] = 1; 

	--Check to see if the number of events is more than allowed
	IF @noEvents > @maxNoEvents 
	BEGIN
			SELECT rtt.EncounterId,
					FORMAT(rtt.EventDate, 'dd-MMM-yyyy') AS EventDate, 
					ed.Code,
					ed.Name AS EventName,

					STUFF(( SELECT '<br/>' + evd.[Description] 
							FROM RTT.EventDescription evd 
							WHERE evd.EventId = rtt.Id 
							ORDER BY evd.DisplayOrder
							FOR XML PATH(''), type).value('.', 'varchar(max)'), 1, 5, '') AS EventDescription,
					CASE code 
						WHEN 'CS' THEN ''
						WHEN 'PS' THEN ''
						WHEN 'PE' THEN ''
					ELSE
						CASE WHEN (SELECT TOP 1 a.DaysWait FROM RTT.Pathway a WHERE a.PathwayId = rtt.PathwayId AND rtt.EventDate >= a.ClockStartDate AND (a.ClockStopDate IS NULL OR rtt.EventDate <= a.ClockStopDate)) IS NULL THEN
							'Watchful Wait'
						ELSE
							CAST(FLOOR(DATEDIFF(d, 
								(SELECT TOP 1 a.ClockStartDate FROM RTT.Pathway a WHERE a.PathwayId = rtt.PathwayId AND rtt.EventDate >= a.ClockStartDate AND (a.ClockStopDate IS NULL OR rtt.EventDate <= a.ClockStopDate) ORDER BY a.ClockStopDate)
									, rtt.EventDate) / 7) AS varchar(5)) + ' wks'
						END
					END AS WeeksWait,
					ego.CssClass
			FROM RTT.[Event] rtt 
			JOIN RTT.[EventDefinition] ed ON rtt.EventDefinitionId = ed.Id
			JOIN RTT.[EventDisplayOrder] ego ON ed.Id = ego.EventDefinitionId
			JOIN RTT.[EventDisplay] eg ON eg.Id = ego.EventDisplayId
			LEFT JOIN RTT.EventAction act ON ed.ActionId = act.Id
			LEFT JOIN RTT.EventEndpoint ep ON ed.EndpointId = ep.Id
			LEFT JOIN RTT.EventType et ON ed.EventTypeId = et.Id
			LEFT JOIN RTT.EventSubType sub ON ed.EventSubTypeId = sub.Id
			WHERE eg.Name = 'OutpatientAttendance_PathwayTimeline' AND eg.[Version] = 1 AND rtt.PathwayId = @PathwayId 
				AND rtt.Id IN -- Get the top x in ascending order
					(SELECT TOP (@noStartEvents) rtt.Id
						FROM RTT.[Event] rtt 
						JOIN RTT.[EventDefinition] ed ON rtt.EventDefinitionId = ed.Id
						JOIN RTT.[EventDisplayOrder] ego ON ed.Id = ego.EventDefinitionId
						JOIN RTT.[EventDisplay] eg ON eg.Id = ego.EventDisplayId
						LEFT JOIN RTT.EventAction act ON ed.ActionId = act.Id
						LEFT JOIN RTT.EventEndpoint ep ON ed.EndpointId = ep.Id
						LEFT JOIN RTT.EventType et ON ed.EventTypeId = et.Id
						LEFT JOIN RTT.EventSubType sub ON ed.EventSubTypeId = sub.Id
						WHERE rtt.PathwayId = @PathwayId AND eg.Name = 'OutpatientAttendance_PathwayTimeline' AND eg.[Version] = 1
						ORDER BY rtt.EventDate, ego.DisplayOrder
					)
			ORDER BY rtt.EventDate DESC, ego.DisplayOrder; -- then sort in descending
	END
END

GO
