USE [master]
GO
/****** Object:  Login [vending]    Script Date: 29.09.2018 15:37:14 ******/
CREATE LOGIN [vending] WITH PASSWORD=N'12345@qwe', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[русский], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [master]
GO
/****** Object:  Database [Vending]    Script Date: 21.01.2019 20:39:09 ******/
CREATE DATABASE [Vending]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Vending', FILENAME = N'C:\DB\Vending1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Vending_log', FILENAME = N'C:\DB\Vending2.ldf' , SIZE = 8192KB , MAXSIZE = 2147328KB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Vending] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Vending].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Vending] SET ANSI_NULL_DEFAULT ON 
GO
ALTER DATABASE [Vending] SET ANSI_NULLS ON 
GO
ALTER DATABASE [Vending] SET ANSI_PADDING ON 
GO
ALTER DATABASE [Vending] SET ANSI_WARNINGS ON 
GO
ALTER DATABASE [Vending] SET ARITHABORT ON 
GO
ALTER DATABASE [Vending] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Vending] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Vending] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Vending] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Vending] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Vending] SET CURSOR_DEFAULT  LOCAL 
GO
ALTER DATABASE [Vending] SET CONCAT_NULL_YIELDS_NULL ON 
GO
ALTER DATABASE [Vending] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Vending] SET QUOTED_IDENTIFIER ON 
GO
ALTER DATABASE [Vending] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Vending] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Vending] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Vending] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Vending] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Vending] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Vending] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Vending] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Vending] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Vending] SET RECOVERY FULL 
GO
ALTER DATABASE [Vending] SET  MULTI_USER 
GO
ALTER DATABASE [Vending] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Vending] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Vending] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Vending] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Vending', N'ON'
GO
USE [Vending]
GO
/****** Object:  User [vending]    Script Date: 21.01.2019 20:39:09 ******/
CREATE USER [vending] FOR LOGIN [vending] WITH DEFAULT_SCHEMA=[db_owner]
GO
ALTER ROLE [db_owner] ADD MEMBER [vending]
GO
/****** Object:  Table [dbo].[AccountLog]    Script Date: 21.01.2019 20:39:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountLog](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[IPAddress] [varchar](50) NOT NULL,
	[DateTime] [bigint] NOT NULL,
	[DateTimeStr] [varchar](50) NOT NULL,
	[EventText] [varchar](max) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[AccountID] [bigint] NOT NULL,
 CONSTRAINT [PK_AccountLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 21.01.2019 20:39:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Accounts](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[PasswordHash] [varchar](max) NOT NULL,
	[TOTPSecret] [varchar](50) NOT NULL,
	[RegistrationDateTime] [bigint] NOT NULL,
	[RegistrationDateTimeStr] [varchar](50) NOT NULL,
	[Valid] [bit] NOT NULL,
	[Suspended] [bit] NOT NULL,
	[DeviceCountLimit] [int] NOT NULL,
	[PaidTillDateTime] [bigint] NOT NULL,
	[PaidTillDateTimeStr] [varchar](50) NOT NULL,
	[DefaultContactPhone] [varchar](50) NOT NULL,
	[LicenseContent] [varchar](max) NOT NULL,
 CONSTRAINT [PK__Accounts__3214EC2762CEC235] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [dbo].[CryptoKeys]    Script Date: 21.01.2019 20:39:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CryptoKeys](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[PrivateKey] [varbinary](max) NOT NULL,
	[PublicKey] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_CryptoKeys] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [dbo].[SystemLog]    Script Date: 21.01.2019 20:39:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SystemLog](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[DateTime] [bigint] NOT NULL,
	[DateTimeStr] [varchar](50) NOT NULL,
	[IPAddress] [varchar](50) NOT NULL,
	[EventText] [varchar](max) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[UserID] [varchar](max) NOT NULL,
 CONSTRAINT [PK_SystemLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [dbo].[WaterDeviceCommands]    Script Date: 21.01.2019 20:39:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WaterDeviceCommands](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[WaterDeviceID] [bigint] NOT NULL,
	[Command] [varchar](50) NOT NULL,
	[FormedDatetime] [bigint] NOT NULL,
	[FormedDatetimeStr] [varchar](50) NOT NULL,
	[RequestedDatetime] [bigint] NOT NULL,
	[RequestedDatetimeStr] [varchar](50) NOT NULL,
	[AckDatetime] [bigint] NOT NULL,
	[AckDatetimeStr] [varchar](50) NOT NULL,
	[Result] [varchar](max) NOT NULL,
 CONSTRAINT [PK_WaterDeviceCommands] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [dbo].[WaterDeviceIncasso]    Script Date: 21.01.2019 20:39:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WaterDeviceIncasso](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[WaterDeviceID] [bigint] NOT NULL,
	[IncassoDatetime] [bigint] NOT NULL,
	[IncassoDatetimeStr] [varchar](50) NOT NULL,
	[IncassoCashboxCoins] [int] NOT NULL,
	[IncassoCashboxSum] [decimal](7, 2) NOT NULL,
	[IncassoBABills] [int] NOT NULL,
	[IncassoBASum] [decimal](7, 2) NOT NULL,
	[CommandID] [bigint] NOT NULL,
 CONSTRAINT [PK_WaterDeviceIncasso] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [dbo].[WaterDevices]    Script Date: 21.01.2019 20:39:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WaterDevices](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[AccountID] [bigint] NOT NULL,
	[HardwareID] [varchar](50) NOT NULL,
	[RegistrationDateTime] [bigint] NOT NULL,
	[RegistrationDateTimeStr] [varchar](50) NOT NULL,
	[PublicKey] [varbinary](max) NOT NULL,
	[Valid] [bit] NOT NULL,
	[Suspended] [bit] NOT NULL,
	[PendingRegistration] [bit] NOT NULL,
	[RegistrationRequest] [varchar](max) NOT NULL,
	[RegistrationRequestDateTime] [bigint] NOT NULL,
	[RegistrationRequestDateTimeStr] [varchar](50) NOT NULL,
	[LocationAddress] [varchar](50) NOT NULL,
	[LocationLatitude] [decimal](8, 6) NOT NULL,
	[LocationLongtitude] [decimal](8, 6) NOT NULL,
	[ProductName] [varchar](50) NOT NULL,
	[CustomerServiceContactPhone] [varchar](50) NOT NULL,
	[PRICE_PER_ITEM_MDE] [int] NOT NULL,
	[RegistrationResponse] [varchar](max) NOT NULL,
	[PendingRegistrationGUID] [varchar](50) NOT NULL,
	[PendingRegConfirmed] [bit] NOT NULL,
	[PendingRegConfirmationIP] [varchar](50) NOT NULL,
	[PendingRegConfirmationDateTime] [bigint] NOT NULL,
	[PendingRegConfirmationDateTimeStr] [varchar](50) NOT NULL,
	[TaxSystemType] [int] NOT NULL,
	[SettingsVersion] [bigint] NOT NULL,
	[WaterTankHeigthcm] [int] NOT NULL,
	[UseKKT] [bit] NOT NULL,
	[WaterTempSensorAddress] [varbinary](50) NULL,
 CONSTRAINT [PK_WaterDevices] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [dbo].[WaterDeviceState]    Script Date: 21.01.2019 20:39:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WaterDeviceState](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[DateTime] [bigint] NOT NULL,
	[DateTimeStr] [varchar](50) NOT NULL,
	[WaterDeviceID] [bigint] NOT NULL,
	[CC10RURCount] [int] NOT NULL,
	[CC5RURCount] [int] NOT NULL,
	[CC2RURCount] [int] NOT NULL,
	[CC1RURCount] [int] NOT NULL,
	[CCSum] [decimal](7, 2) NOT NULL,
	[CBCount] [int] NOT NULL,
	[CBSum] [decimal](7, 2) NOT NULL,
	[IncassoSum] [decimal](7, 2) NOT NULL,
	[WaterTempCelsius] [decimal](4, 2) NOT NULL,
	[InboxTempCelsius] [decimal](4, 2) NOT NULL,
	[AmbientTempCelsius] [decimal](4, 2) NOT NULL,
	[AmbientRelativeHumidity] [decimal](4, 2) NOT NULL,
	[WaterLevelPercent] [int] NOT NULL,
	[IsHeaterOn] [bit] NOT NULL,
	[IsExternalLightOn] [bit] NOT NULL,
	[IsFillPumpSocketActive] [bit] NOT NULL,
	[TotalLitersDIspensed] [decimal](10, 2) NOT NULL,
	[TotalHoursWorked] [decimal](10, 2) NOT NULL,
	[KKTMfgNumber] [varchar](50) NOT NULL,
	[KKTStageOpened] [bit] NOT NULL,
	[KKTStageOver24h] [bit] NOT NULL,
	[KKTStageNumber] [varchar](50) NOT NULL,
	[KKTReceiptOpened] [bit] NOT NULL,
	[KKTCurrentMode] [int] NOT NULL,
	[KKTPrinterConnected] [bit] NOT NULL,
	[KKTPrinterPaperEmpty] [bit] NOT NULL,
	[KKTPrinterNonRecoverableError] [bit] NOT NULL,
	[KKTPrinterCutterError] [bit] NOT NULL,
	[KKTPrinterOverHeated] [bit] NOT NULL,
	[KKTPrinterPaperJammed] [bit] NOT NULL,
	[KKTPrinterPaperEnding] [bit] NOT NULL,
	[BABillsCount] [int] NOT NULL,
	[BASum] [decimal](7, 2) NOT NULL,
	[LastStageClosedDateTime] [bigint] NOT NULL,
	[LastStageClosedDateTimeStr] [varchar](50) NOT NULL,
	[KKTReceiptNextNumber] [int] NOT NULL,
	[VMCMode] [varchar](50) NOT NULL,
	[MDBInitStep] [int] NOT NULL,
	[ProgramVersion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_WaterDeviceStateData] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [dbo].[WaterDeviceTelemetry]    Script Date: 21.01.2019 20:39:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WaterDeviceTelemetry](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[DateTime] [bigint] NOT NULL,
	[DateTimeStr] [varchar](50) NOT NULL,
	[WaterDeviceID] [bigint] NOT NULL,
	[CC10RURCount] [int] NOT NULL,
	[CC5RURCount] [int] NOT NULL,
	[CC2RURCount] [int] NOT NULL,
	[CC1RURCount] [int] NOT NULL,
	[CCSum] [decimal](7, 2) NOT NULL,
	[CBCount] [int] NOT NULL,
	[CBSum] [decimal](7, 2) NOT NULL,
	[IncassoSum] [decimal](7, 2) NOT NULL,
	[WaterTempCelsius] [decimal](4, 2) NOT NULL,
	[InboxTempCelsius] [decimal](4, 2) NOT NULL,
	[AmbientTempCelsius] [decimal](4, 2) NOT NULL,
	[AmbientRelativeHumidity] [decimal](4, 2) NOT NULL,
	[WaterLevelPercent] [int] NOT NULL,
	[IsHeaterOn] [bit] NOT NULL,
	[IsExternalLightOn] [bit] NOT NULL,
	[IsFillPumpSocketActive] [bit] NOT NULL,
	[TotalLitersDIspensed] [decimal](10, 2) NOT NULL,
	[TotalHoursWorked] [decimal](10, 2) NOT NULL,
	[KKTMfgNumber] [varchar](50) NOT NULL,
	[KKTStageOpened] [bit] NOT NULL,
	[KKTStageOver24h] [bit] NOT NULL,
	[KKTStageNumber] [varchar](50) NOT NULL,
	[KKTReceiptOpened] [bit] NOT NULL,
	[KKTCurrentMode] [int] NOT NULL,
	[KKTPrinterConnected] [bit] NOT NULL,
	[KKTPrinterPaperEmpty] [bit] NOT NULL,
	[KKTPrinterNonRecoverableError] [bit] NOT NULL,
	[KKTPrinterCutterError] [bit] NOT NULL,
	[KKTPrinterOverHeated] [bit] NOT NULL,
	[KKTPrinterPaperJammed] [bit] NOT NULL,
	[KKTPrinterPaperEnding] [bit] NOT NULL,
	[BABillsCount] [int] NOT NULL,
	[BASum] [decimal](7, 2) NOT NULL,
	[LastStageClosedDateTime] [bigint] NOT NULL,
	[LastStageClosedDateTimeStr] [varchar](50) NOT NULL,
	[KKTReceiptNextNumber] [int] NOT NULL,
	[VMCMode] [varchar](50) NOT NULL,
	[MDBInitStep] [int] NOT NULL,
	[ProgramVersion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TelemetryData] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [dbo].[WaterSales]    Script Date: 21.01.2019 20:39:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WaterSales](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[WaterDeviceID] [bigint] NOT NULL,
	[StartDateTime] [bigint] NOT NULL,
	[StartDateTimeStr] [varchar](50) NOT NULL,
	[UserCash] [decimal](7, 2) NOT NULL,
	[Quantity] [decimal](7, 2) NOT NULL,
	[TaxSystemInUse] [int] NOT NULL,
	[PRICE_PER_ITEM_MDE] [int] NOT NULL,
	[ProductName] [varchar](50) NOT NULL,
	[ActualChangeDispensed] [int] NOT NULL,
	[ChangeActualDiff] [decimal](7, 2) NOT NULL,
	[EndDateTime] [bigint] NOT NULL,
	[EndDateTimeString] [varchar](50) NOT NULL,
	[StageNumber] [bigint] NOT NULL,
	[ReceiptNumber] [bigint] NOT NULL,
 CONSTRAINT [PK_WaterSales] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [dbo].[WebSettings]    Script Date: 21.01.2019 20:39:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WebSettings](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[AdminEmail] [varchar](max) NOT NULL,
	[SiteName] [varchar](max) NOT NULL,
	[ServerEndPoint] [varchar](max) NOT NULL,
	[MailFromAddress] [varchar](max) NOT NULL,
	[EMailDisplayName] [varchar](max) NOT NULL,
	[RegDeviceMailSubject] [varchar](max) NOT NULL,
	[RegAccountMailSubject] [varchar](max) NOT NULL,
	[MailUseSMTPAuth] [bit] NOT NULL,
	[MailLogin] [varchar](max) NOT NULL,
	[MailPassword] [varchar](max) NOT NULL,
	[SMTPHost] [varchar](max) NOT NULL,
	[SMTPPort] [int] NOT NULL,
	[SMTPUseSSL] [bit] NOT NULL,
	[BingMapsAPIKey] [varchar](max) NOT NULL,
	[LastSavedDateTimeStr] [varchar](50) NOT NULL,
 CONSTRAINT [PK_WebSettings] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[AccountLog] ADD  CONSTRAINT [DF_AccountLog_IPAddress]  DEFAULT ('') FOR [IPAddress]
GO
ALTER TABLE [dbo].[AccountLog] ADD  CONSTRAINT [DF_AccountLog_DateTime]  DEFAULT ((0)) FOR [DateTime]
GO
ALTER TABLE [dbo].[AccountLog] ADD  CONSTRAINT [DF_AccountLog_DateTimeStr]  DEFAULT ('') FOR [DateTimeStr]
GO
ALTER TABLE [dbo].[AccountLog] ADD  CONSTRAINT [DF_AccountLog_EventText]  DEFAULT ('') FOR [EventText]
GO
ALTER TABLE [dbo].[AccountLog] ADD  CONSTRAINT [DF_AccountLog_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[AccountLog] ADD  CONSTRAINT [DF_AccountLog_AccountID]  DEFAULT ((0)) FOR [AccountID]
GO
ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [DF__Accounts__Valid__108B795B]  DEFAULT ((1)) FOR [Valid]
GO
ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [DF__Accounts__Suspen__117F9D94]  DEFAULT ((0)) FOR [Suspended]
GO
ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [DF_Accounts_DeviceCountLimit]  DEFAULT ((10)) FOR [DeviceCountLimit]
GO
ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [DF_Accounts_PaidTillDateTime]  DEFAULT ((0)) FOR [PaidTillDateTime]
GO
ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [DF_Accounts_PaidTillDateTimeStr]  DEFAULT ('') FOR [PaidTillDateTimeStr]
GO
ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [DF_Accounts_CustomerServiceContactPhone]  DEFAULT ('+79990123456') FOR [DefaultContactPhone]
GO
ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [DF_Accounts_LicenseContent]  DEFAULT ('') FOR [LicenseContent]
GO
ALTER TABLE [dbo].[SystemLog] ADD  CONSTRAINT [DF_SystemLog_DateTime]  DEFAULT ((0)) FOR [DateTime]
GO
ALTER TABLE [dbo].[SystemLog] ADD  CONSTRAINT [DF_SystemLog_DateTimeStr]  DEFAULT ('') FOR [DateTimeStr]
GO
ALTER TABLE [dbo].[SystemLog] ADD  CONSTRAINT [DF_SystemLog_IPAddress]  DEFAULT ('') FOR [IPAddress]
GO
ALTER TABLE [dbo].[SystemLog] ADD  CONSTRAINT [DF_SystemLog_EventText]  DEFAULT ('') FOR [EventText]
GO
ALTER TABLE [dbo].[SystemLog] ADD  CONSTRAINT [DF_SystemLog_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[SystemLog] ADD  CONSTRAINT [DF_Table_1_AccountID]  DEFAULT ((0)) FOR [UserID]
GO
ALTER TABLE [dbo].[WaterDeviceCommands] ADD  CONSTRAINT [DF_WaterDeviceCommands_WaterDeviceID]  DEFAULT ((0)) FOR [WaterDeviceID]
GO
ALTER TABLE [dbo].[WaterDeviceCommands] ADD  CONSTRAINT [DF_WaterDeviceCommands_Command]  DEFAULT ('') FOR [Command]
GO
ALTER TABLE [dbo].[WaterDeviceCommands] ADD  CONSTRAINT [DF_WaterDeviceCommands_FormedDatetime]  DEFAULT ((0)) FOR [FormedDatetime]
GO
ALTER TABLE [dbo].[WaterDeviceCommands] ADD  CONSTRAINT [DF_WaterDeviceCommands_FormedDatetimeStr]  DEFAULT ('') FOR [FormedDatetimeStr]
GO
ALTER TABLE [dbo].[WaterDeviceCommands] ADD  CONSTRAINT [DF_WaterDeviceCommands_RequestedDatetime]  DEFAULT ((0)) FOR [RequestedDatetime]
GO
ALTER TABLE [dbo].[WaterDeviceCommands] ADD  CONSTRAINT [DF_WaterDeviceCommands_RequestedDatetimeStr]  DEFAULT ('') FOR [RequestedDatetimeStr]
GO
ALTER TABLE [dbo].[WaterDeviceCommands] ADD  CONSTRAINT [DF_WaterDeviceCommands_AckDatetime]  DEFAULT ((0)) FOR [AckDatetime]
GO
ALTER TABLE [dbo].[WaterDeviceCommands] ADD  CONSTRAINT [DF_WaterDeviceCommands_AckDatetimeStr]  DEFAULT ('') FOR [AckDatetimeStr]
GO
ALTER TABLE [dbo].[WaterDeviceCommands] ADD  CONSTRAINT [DF_WaterDeviceCommands_ResultStr]  DEFAULT ('') FOR [Result]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_AccountID]  DEFAULT ((0)) FOR [AccountID]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_HardwareID]  DEFAULT ('') FOR [HardwareID]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_RegistrationDateTime]  DEFAULT ((0)) FOR [RegistrationDateTime]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_RegistrationDateTimeStr]  DEFAULT ('') FOR [RegistrationDateTimeStr]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_Valid]  DEFAULT ((1)) FOR [Valid]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_Suspended]  DEFAULT ((0)) FOR [Suspended]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_PendingRegistration]  DEFAULT ((1)) FOR [PendingRegistration]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_RegistrationRequestDateTimeStr]  DEFAULT ('') FOR [RegistrationRequestDateTimeStr]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_LocationAddress]  DEFAULT ('N\A') FOR [LocationAddress]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_LocationLatitude]  DEFAULT ((0)) FOR [LocationLatitude]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_LocationLongtitude]  DEFAULT ((0)) FOR [LocationLongtitude]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_ProductName]  DEFAULT ('Вода питьевая') FOR [ProductName]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_PRICE_PER_ITEM_MDE]  DEFAULT ((500)) FOR [PRICE_PER_ITEM_MDE]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_RegistrationResponse]  DEFAULT ('') FOR [RegistrationResponse]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_PendingRegistrationGUID]  DEFAULT ('') FOR [PendingRegistrationGUID]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_PendingRegConfirmed]  DEFAULT ((0)) FOR [PendingRegConfirmed]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_PendingRegConfirmationIP]  DEFAULT ('') FOR [PendingRegConfirmationIP]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_PendingRegConfirmationDateTime]  DEFAULT ((0)) FOR [PendingRegConfirmationDateTime]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_TaxSystemType]  DEFAULT ((0)) FOR [TaxSystemType]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_SettingsVersion]  DEFAULT ((0)) FOR [SettingsVersion]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_WaterTankHeigthcm]  DEFAULT ((200)) FOR [WaterTankHeigthcm]
GO
ALTER TABLE [dbo].[WaterDevices] ADD  CONSTRAINT [DF_WaterDevices_UseKKT]  DEFAULT ((1)) FOR [UseKKT]
GO
ALTER TABLE [dbo].[WaterDeviceState] ADD  CONSTRAINT [DF_WaterDeviceState_LastStageClosedDateTime]  DEFAULT ((0)) FOR [LastStageClosedDateTime]
GO
ALTER TABLE [dbo].[WaterDeviceState] ADD  CONSTRAINT [DF_WaterDeviceState_LastStageClosedDateTimeStr]  DEFAULT ('') FOR [LastStageClosedDateTimeStr]
GO
ALTER TABLE [dbo].[WaterDeviceState] ADD  CONSTRAINT [DF_WaterDeviceState_KKTReceiptNextNumber]  DEFAULT ((0)) FOR [KKTReceiptNextNumber]
GO
ALTER TABLE [dbo].[WaterDeviceState] ADD  CONSTRAINT [DF_WaterDeviceState_VMCMode]  DEFAULT ('') FOR [VMCMode]
GO
ALTER TABLE [dbo].[WaterDeviceState] ADD  CONSTRAINT [DF_WaterDeviceState_MDBInitStep]  DEFAULT ((0)) FOR [MDBInitStep]
GO
ALTER TABLE [dbo].[WaterDeviceState] ADD  CONSTRAINT [DF_WaterDeviceState_ProgramVersion]  DEFAULT ('0.0.0.0') FOR [ProgramVersion]
GO
ALTER TABLE [dbo].[WaterDeviceTelemetry] ADD  CONSTRAINT [DF_WaterDeviceTelemetry_LastStageClosedDateTime]  DEFAULT ((0)) FOR [LastStageClosedDateTime]
GO
ALTER TABLE [dbo].[WaterDeviceTelemetry] ADD  CONSTRAINT [DF_WaterDeviceTelemetry_LastStageClosedDateTimeStr]  DEFAULT ('') FOR [LastStageClosedDateTimeStr]
GO
ALTER TABLE [dbo].[WaterDeviceTelemetry] ADD  CONSTRAINT [DF_WaterDeviceTelemetry_KKTReceiptNextNumber]  DEFAULT ((0)) FOR [KKTReceiptNextNumber]
GO
ALTER TABLE [dbo].[WaterDeviceTelemetry] ADD  CONSTRAINT [DF_WaterDeviceTelemetry_VMCMode]  DEFAULT ('') FOR [VMCMode]
GO
ALTER TABLE [dbo].[WaterDeviceTelemetry] ADD  CONSTRAINT [DF_WaterDeviceTelemetry_MDBInitStep]  DEFAULT ((0)) FOR [MDBInitStep]
GO
ALTER TABLE [dbo].[WaterDeviceTelemetry] ADD  CONSTRAINT [DF_WaterDeviceTelemetry_ProgramVersion]  DEFAULT ('0.0.0.0') FOR [ProgramVersion]
GO
ALTER TABLE [dbo].[WaterSales] ADD  CONSTRAINT [DF_WaterSales_StageNumber]  DEFAULT ((0)) FOR [StageNumber]
GO
ALTER TABLE [dbo].[WaterSales] ADD  CONSTRAINT [DF_WaterSales_ReceiptNumber]  DEFAULT ((0)) FOR [ReceiptNumber]
GO
ALTER TABLE [dbo].[WebSettings] ADD  CONSTRAINT [DF_WebSettings_LastSavedDateTimeStr]  DEFAULT ('') FOR [LastSavedDateTimeStr]
GO
USE [master]
GO
ALTER DATABASE [Vending] SET  READ_WRITE 
GO
