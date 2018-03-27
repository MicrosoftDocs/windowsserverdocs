---
title: AD FS - Extranet Smart Lockout
description: This document describes the extranet smart lockout feature and how to configure it.
author: billmath
ms.author: billmath
manager: mtillman
ms.date: 03/27/2018
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---



# Overview
As of the March 2018 update for Windows Server 2016, AD FS has a new feature called Extranet Smart Lockout (ESL).  In an era of increased attacks on authentication services, ESL enables AD FS to differentiate between sign-in attempts that look like they're from the valid user and sign-ins from what may be an attacker. As a result, AD FS can lock out attackers while letting valid users continue to use their accounts. This prevents denial-of-service on the user and protects against targeted attacks against known user accounts.
ESL is available for AD FS in Windows Server 2016.  

## How to install and configure ESL
Install updates on all nodes in the farm
First, ensure all Windows Server 2016 AD FS servers are up to date as of the March 2018 Windows Updates.
Update artifact database permissions
Extranet smart lockout requires the AD FS service account to have permissions to a new table in the ADFS artifact database.  Grant this permission by executing the following command in a PowerShell command window:

``` powershell
$cred = Get-Credential
Update-AdfsArtifactDatabasePermission -Credential $cred
```
- Where **$cred** is an account with AD FS administrator permissions.

If you do not have AD FS administrator permissions, you can configure database permissions manually in SQL or WID by running the following command when connected to the AdfsArtifactStore database. These steps should be followed for all nodes in the farm.
```
ALTER AUTHORIZATION ON SCHEMA::[ArtifactStore] TO [db_genevaservice]
```
## Configure ESL
A new parameter called ExtranetLockoutMode was added support ESL.  It contains 3 values

- **ADPasswordCounter** – This is the legacy ADFS “extranet soft lockout” mode which does not differentiate based on location.  This is the default value.
- **ADFSSmartLockoutLogOnly** – This is Extranet Smart Lockout, but instead of rejecting authentication requests, ADFS will write admin and audit events.
- **ADFSSmartLockoutEnforce** - This is Extranet Smart Lockout with full support for blocking unfamiliar requests when thresholds are reached.
We recommend that you first set the lockout provider to log only by running the following cmdlet:

``` powershell
Set-AdfsProperties -ExtranetLockoutMode AdfsSmartlockoutLogOnly
```
In this mode, AD FS performs the analysis but does not block any requests due to lockout counters.  This mode is used to validate that smart lockout is running successfully before enabling “enforce” mode.

For the new mode to take effect, restart the AD FS service on all nodes in the farm

``` powershell
Restart-service adfssrv
```

### Set lockout threshold and observation window
There are two key settings with ESL: lockout threshold and observation window.

#### Lockout Threshold
Each time a password based authentication is successful, AD FS stores the client IP(s) as familiar location(s) in the account activity table. 

- If a password based authentication fails and it is NOT from a familiar location, the failed authentication count is incremented.
- Once the number of failed password attempts from unfamiliar locations reaches the lockout threshold, if a password based authentication from an unfamiliar location fails the account is locked out.

>[!NOTE]
> Lockout continues to apply to familiar locations separately from this new unfamiliar lockout counter.
	
The threshold is set using `Set-AdfsProperties` 
Example:

``` powershell
Set-AdfsProperties -ExtranetLockoutThreshold 10
```
####  Observation window
The observation window setting allows an account to automatically unlock after a certain period of time. 
- Once the account unlocks it allow 1 authentication attempt.  
- If the authentication succeeds the failed authentication count is reset to 0.  
- If it fails then the system waits for another observation window before the user is allowed to try again.

The observation window is set using `Set-AdfsProperties`
Example: 

``` powershell
Set-AdfsProperties -ExtranetObservationWindow ( new-timespan -minutes 5 )
```
### Enable lockout
Extranet lockout can be enabled / disabled using the ` EnableExtranetLockout`  parameter

Example: Enable lockout

``` powershell
Set-AdfsProperties -EnableExtranetLockout $true
```
Example: Disable lockout

``` powershell
Set-AdfsProperties -EnableExtranetLockout $false
```

### Enable enforce mode
Once you are comfortable with the lockout threshold and observation window, ESL can be moved to “enforce” mode using the PSH cmdlet below:

``` powershell
Set-AdfsProperties -ExtranetLockoutMode AdfsSmartLockoutEnforce
``` 
For the new mode to take effect, restart the AD FS service on all nodes in the farm

``` powershell
Restart-service adfssrv
``` 

## Manage User Account Activity
AD FS provides 3 cmdlets to manage user account activity data.  These cmdlets automatically connect to the node in the farm which holds the master role (though this behavior can be overridden by passing the -Server parameter)

`Get-ADFSAccountActivity`

Read the current account activity for a user account.  The cmdlet always automatically connects to the farm master using the Account Activity REST endpoint, so all data should always be consistent

``` powershell
Get-ADFSAccountActivity user@contoso.com
```
`
Set-ADFSAccountActivity
`

Update the account activity for a user account.  This can be used to add new familiar locations or erase state for any account

``` powershell
Set-ADFSAccountActivity user@upnsuffix.com -FamiliarLocation “1.2.3.4”
```
`Reset-ADFSAccountLockout`

Resets the lockout counter for a user account

``` powershell
Reset-ADFSAccountLockout user@upnsuffix.com -Familiar
```

## Troubleshooting
The following can assist you with troubleshooting the extranet smart lockout feature.

### Updating database permissions
If any errors are returned from the `Update-AdfsArtifactDatabasePermission` cmdlet, verify the following

1.	The list of farm nodes is correct.  If a node is in the AD FS farm list but no longer active patch verification will fail.  This can be remedied by running `remove-adfsnode <node name >`
2.	Verify the patch is deployed on all nodes in the farm
3.	Verify the credentials passed to the cmdlet have permission to modify the owner of the ad fs artifact database schema.  

### Logging / Auditing
When an authentication request is rejected because the account exceeds the lockout threshold, AD FS will write an `ExtranetLockoutEvent` to the security audit stream.  

Example event:

An extranet lockout event has occurred. See XML for failure details. 

**Activity ID: 172332e1-1301-4e56-0e00-0080000000db**

```
Additional Data 
XML: <?xml version="1.0" encoding="utf-16"?>
<AuditBase xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ExtranetLockoutAudit">
  <AuditType>ExtranetLockout</AuditType>
  <AuditResult>Failure</AuditResult>
  <FailureType>ExtranetLockoutError</FailureType>
  <ErrorCode>AccountRestrictedAudit</ErrorCode>
  <ContextComponents>
    <Component xsi:type="ResourceAuditComponent">
      <RelyingParty>http://contoso.com/adfs/services/trust</RelyingParty>
      <ClaimsProvider>N/A</ClaimsProvider>
      <UserId>TQDFTD\Administrator</UserId>
    </Component>
    <Component xsi:type="RequestAuditComponent">
      <Server>N/A</Server>
      <AuthProtocol>WSFederation</AuthProtocol>
      <NetworkLocation>Intranet</NetworkLocation>
      <IpAddress>4.4.4.4</IpAddress>
      <ForwardedIpAddress />
      <ProxyIpAddress>1.2.3.4</ProxyIpAddress>
      <NetworkIpAddress>1.2.3.4</NetworkIpAddress>
      <ProxyServer>N/A</ProxyServer>
      <UserAgentString>Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36</UserAgentString>
      <Endpoint>/adfs/ls</Endpoint>
    </Component>
    <Component xsi:type="LockoutConfigAuditComponent">
      <CurrentBadPasswordCount>5</CurrentBadPasswordCount>
      <ConfigBadPasswordCount>5</ConfigBadPasswordCount>
      <LastBadAttempt>02/07/2018 21:47:44</LastBadAttempt>
      <LockoutWindowConfig>00:30:00</LockoutWindowConfig>
    </Component>
  </ContextComponents>
</AuditBase>

```

## Uninstall
SQL farms can uninstall the patch using the Settings app with no issues.

WID farms must follow a set of steps due to the updated WID database verification binary.

1.	Run uninstall psh script which stops the service and drops the account activity table

```
Stop-Service adfssrv -ErrorAction Stop 

$doc = new-object Xml
$doc.Load("$env:windir\ADFS\Microsoft.IdentityServer.Servicehost.exe.config")
$connString = $doc.configuration.'microsoft.identityServer.service'.policystore.connectionString

if ( -not $connString -like "*##wid*" )
{
    Write-Error "SQL installs do not require DB updates, skipping DB table drop"
}
else
{
	$connString = "Data Source=np:\\.\pipe\microsoft##wid\tsql\query;Initial Catalog=AdfsArtifactStore;Integrated Security=True"
	stop-service adfssrv
	$cli = new-object System.Data.SqlClient.SqlConnection
	$cli.ConnectionString = $connString
	$cli.Open()
	try
	{    
        $cmd = new-object System.Data.SqlClient.SqlCommand
        $cmd.CommandText = "IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ArtifactStore].[AccountActivity]') AND type in (N'U')) DROP TABLE [ArtifactStore].[AccountActivity]"
        $cmd.Connection = $cli
        $cmd.ExecuteNonQuery() 
    }
    finally
    {
        $cli.CLose()
    }

	write-warning "Finish removing the patch using the Settings app and then restart the complete to complete the uninstall"
} 

```

2.	Uninstall patch using settings app
3.	Restart machine


## Detailed Database change information
When smart lockout is enabled, AD FS will create a new table in the AD FS artifact DB in which it will store lockout counters and a set of familiar locations.  

This table is created automatically once the feature is enabled.  The table exists on each node in the farm and is not replicated.  Instead of replicating the data, each node in the farm will communicate with the User Activity master to read and write the results of each password authentication.

## Next Steps