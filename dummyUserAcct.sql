-- insert the dummy record
 
-- create a phantom SSN
-- this keeps looking for a unique SSN
-- one that is not used in this district
declare @vSSN INT
set @vSSN = cast(LEFT(cast(abs(cast(cast(newid() as binary(10)) as int)) as varchar(max)) + '00000000',9) as int)
while exists(select EmployeeID from tblEmployee where SocSecNo = @vSSN)
    begin
        set @vSSN = cast(LEFT(cast(abs(cast(cast(newid() as binary(10)) as int)) as varchar(max)) + '00000000',9) as int)
    end
 
 
declare @LastName varchar(100)
declare @FirstName varchar(100)
declare @Email varchar(100)
declare @SiteName varchar(100)
declare @SecGroup int
declare @dummySSN int
declare @MinAge int
declare @MaxAge int
declare @DOB Date
 
set @dummySSN = @vSSN
 
-- generate
set @MinAge = 18;
set @MaxAge = 65;
set @DOB = dateadd(day, (1 - (convert(int, crypt_gen_random(2)) % ((@MaxAge - @MinAge) * 365))), convert(date, dateadd(year, 1 - @MinAge, getdate())))
 
 
set @LastName = 'Test'
set @FirstName = 'Teo'
set @Email = lower(substring(@FirstName,1,1)+@LastName+'@'+(select DistrictAbbrev from tblDistrict))
set @SecGroup = 100 -- (select distinct SecurityGroup from tblUsers)
set @SiteName = 'Food Service CES' --(select * from tblsite)
 
insert into tblEmployee
(
 EmployeeID,
 SocSecNo,
 EmplNo,
 DOB,
 Gender,
 LName,
 FName,
 MI,
 MaritalStatus,
 ShowAddress,
 HideAddress,
 Address,
 City,
 State,
 Zip,
 HidePhone,
 Phone,
 Email,
 HireDate,
 xInactive,
 InActiveReason,
 ToBeInactiveDate,
 TerminateDate,
 EthnicID,
 StatusID,
 Dcreated,
 Fullname,
 ClassificationId,
 WarrantSiteID,
 PayCycle,
 Longevity,
 RetSystemID,
 DistrictId,
 OldId,
 SSNCheckDigit,
 MailSiteID,
 Password,
 WebLoginActive,
 HomeSameAsMailingAddress,
 HomeAddress,
 HomeCity,
 HomeState,
 HomeZip,
 FedMaritalStatus,
 FedExemptions,
 FedAddAmt,
 FedEIC,
 FedSpouseEICCertificateID,
 StateMaritalStatus,
 StateExemptions,
 StateAllowances,
 StateAddAmt,
 WebAdmin,
 WebLoginToken,
 HWPreTax,
 IsDeferredPay,
 StateID,
 IsHispanic,
 RaceId1,
 RaceId2,
 RaceId3,
 RaceId4,
 RaceId5,
 MailingAddressId,
 HomeAddressId,
 HomeEmail,
 StateAllowances2,
 SessionGuid,
 SessionExpirationTime,
 Nickname,
 PreviousLastName,
 CertRetireId,
 ClassRetireId,
 REtirementAccountId,
 RetirementNote,
 CertRetireNum,
 ClassRetireNum,
 ClassRetireNum2,
 CertRetirePlanDate,
 CertRetirePlanDate2,
 CertQualification,
 ClassRetirePlanDate,
 ClassRetirePlanDate2,
 ClassQualification,
 CertRetirementDate,
 ClassRetirementDate,
 PayrollGroupId,
 Locked,
 Attempts,
 PasswordChanged,
 PasswordPrior
)
select
 (select NextKey from PKDispenser where TableName = 'tblEmployee'),
 @dummySSN,
 EmplNo,
 @DOB,
 Gender,
 @LastName,
 @FirstName,
 Null,
 MaritalStatus,
 ShowAddress,
 HideAddress,
 Address,
 City,
 State,
 Zip,
 HidePhone,
 Phone,
 @Email,
 HireDate,
 xInactive,
 InActiveReason,
 ToBeInactiveDate,
 TerminateDate,
 EthnicID,
 StatusID,
 Dcreated,
 Fullname,
 ClassificationId,
 WarrantSiteID,
 PayCycle,
 Longevity,
 RetSystemID,
 DistrictId,
 OldId,
 SSNCheckDigit,
 MailSiteID,
 (select RIGHT(@dummySSN,4)),
 WebLoginActive,
 HomeSameAsMailingAddress,
 HomeAddress,
 HomeCity,
 HomeState,
 HomeZip,
 FedMaritalStatus,
 FedExemptions,
 FedAddAmt,
 FedEIC,
 FedSpouseEICCertificateID,
 StateMaritalStatus,
 StateExemptions,
 StateAllowances,
 StateAddAmt,
 WebAdmin,
 WebLoginToken,
 HWPreTax,
 IsDeferredPay,
 StateID,
 IsHispanic,
 RaceId1,
 RaceId2,
 RaceId3,
 RaceId4,
 RaceId5,
 MailingAddressId,
 HomeAddressId,
 HomeEmail,
 StateAllowances2,
 SessionGuid,
 SessionExpirationTime,
 Nickname,
 PreviousLastName,
 CertRetireId,
 ClassRetireId,
 REtirementAccountId,
 RetirementNote,
 CertRetireNum,
 ClassRetireNum,
 ClassRetireNum2,
 CertRetirePlanDate,
 CertRetirePlanDate2,
 CertQualification,
 ClassRetirePlanDate,
 ClassRetirePlanDate2,
 ClassQualification,
 CertRetirementDate,
 ClassRetirementDate,
 PayrollGroupId,
 Locked,
 Attempts,
 PasswordChanged,
 PasswordPrior
from tblEmployee where EmployeeID = (select top 1 EmployeeID from tblUsers where SecurityGroup = @SecGroup and InactiveDate is null and EmployeeID in (select EmployeeID from tblEmployee))
 
 
insert into tblUsers
(
 EmployeeID,
 SiteID,
 SecurityGroup,
 LoginName,
 Password,
 Confirm,
 AuthLogin,
 AuthorizationCode,
 AuthOrder,
 AuthInactive,
 ClassificationID,
 PayrollID,
 DCreated,
 DistrictId,
 OldId,
 AuthSlots,
 AuthRPA,
 EffectiveDate,
 InactiveDate,
 CitrixUserName,
 InternalPhone,
 Comments,
 IsMac,
 ClassificationGroupID,
 AuthEmailDefault,
 Newsletter,
 AuthEWA,
 AuthEWAInactive,
 wikiGroup,
 WikiHelp,
 authscr,
 ExportTempTableName,
 TwoXUsername,
 TwoXPassword,
 IsKeyContact,
 IsPrimaryContact,
 ContactType,
 AccountCategoryId
)
select top 1
 (select NextKey from PKDispenser where TableName = 'tblEmployee'),
 (select SiteID from tblSite where SiteName = @SiteName),
 SecurityGroup,
 (select substring(FName,1,1)+LName from tblemployee where employeeid = (select NextKey from PKDispenser where TableName = 'tblEmployee')),
 (select RIGHT(SocSecNo,4) from tblemployee where employeeid = (select NextKey from PKDispenser where TableName = 'tblEmployee')),
 Confirm,
 AuthLogin,
 AuthorizationCode,
 AuthOrder,
 AuthInactive,
 ClassificationID,
 PayrollID,
 DCreated,
 DistrictId,
 OldId,
 AuthSlots,
 AuthRPA,
 EffectiveDate,
 InactiveDate,
 CitrixUserName,
 InternalPhone,
 Comments,
 IsMac,
 ClassificationGroupID,
 AuthEmailDefault,
 Newsletter,
 AuthEWA,
 AuthEWAInactive,
 wikiGroup,
 WikiHelp,
 authscr,
 ExportTempTableName,
 TwoXUsername,
 TwoXPassword,
 IsKeyContact,
 IsPrimaryContact,
 ContactType,
 AccountCategoryId
from tblUsers
where
 SecurityGroup = @SecGroup
 and InactiveDate is null
 
-- Get Username and Password select employeeid, fullname, email, [password],
select
 EmployeeID,
 Fullname,
 Email,
 [Password]
from tblEmployee
where
 employeeid = (select NextKey from PKDispenser where TableName = 'tblEmployee')
 
 
-- whack mode
delete
 from tblEmployee
 where
    Fullname = 'Test, Teo '
 
 
-- update pkdispenser
update PKDispenser
 set
  NextKey = NextKey + 1
where
 TableName = 'tblEmployee'