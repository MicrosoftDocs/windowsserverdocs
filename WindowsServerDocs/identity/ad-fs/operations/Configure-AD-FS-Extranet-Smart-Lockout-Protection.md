---
ms.assetid: 777aab65-c9c7-4dc9-a807-9ab73fac87b8
title: Configure AD FS Extranet Lockout Protection
description:
author: billmath
ms.author: billmath
manager: mtilman
ms.date: 02/01/2019
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# AD FS Extranet Lockout and Extranet Smart Lockout

# Overview

>Applies To: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

In AD FS on Windows Server 2012 R2, we introduced a security feature called [Extranet Soft Lockout](configure-ad-fs-extranet-soft-lockout-protection.md).  With this feature, AD FS stops authenticating users from the extranet for a period of time.  This prevents your user accounts from being locked out in Active Directory. In addition to protecting your users from an AD account lockout, AD FS extranet lockout also protects against brute force password guessing attacks.

In June 2018, AD FS on Windows Server 2016 introduced **Extranet Smart Lockout (ESL)**.  ESL enables AD FS to differentiate between sign-in attempts that look like they're from the valid user and sign-ins from what may be an attacker. As a result, AD FS can lock out attackers while letting valid users continue to use their accounts. This prevents denial-of-service on the user and protects against targeted attacks such as "password-spray" attacks.  
ESL is available for AD FS in Windows Server 2016 and is built into AD FS in Windows Server 2019.

> [!NOTE]
> This feature only works for the **extranet scenario** in which authentication requests come through the Web Application Proxy and only applies to **username and password authentication**.

## Advantages of Extranet Smart Lockout in AD FS 2016
Extranet soft lockout in AD FS 2012 R2 provided the following key advantages:
- Protects your user accounts from **brute force attacks** in which an attacker tries to guess a user's password by continuously sending authentication requests and from **password spray attacks** where attackers attempt to use common passwords with many different accounts
- Protects your user accounts from **Active Directory account lockout** from malicious authentication requests with wrong passwords. In this case, although the user account will be locked out for extranet access, the user can still login to AD from the corporate network. This is known as a **soft lockout**.

Extranet Smart Lockout builds on the advantages of extranet soft lockout by adding the following:
- Protects your users from experiencing **extranet account lockout** from malicious authentication requests.  Smart lockout will prevent potentially malicious requests from unfamiliar locations while allowing the real user to sign on from the extranet from familiar locations (locations from which the user has successfully logged in before).
- Has a log only mode so that the system can learn good and potentially malicious signon activity without disabling any accounts

## Additional advantages of Extranet Smart Lockout in AD FS 2019
Extranet Smart Lockout in AD FS 2019 adds the following advantages compared to AD FS 2016:
- Set independent lockout thresholds for familiar and unfamiliar locations so that users in known good locations can have more room for error than requests from suspect locations
- Enable audit mode for smart lockout while continuing to enforce previous soft lockout behavior

## Pre-requisites for Extranet Smart Lockout in AD FS 2016
The following pre-requisites are required for ESL with AD FS 2019.

### Install updates on all nodes in the farm
First, ensure all Windows Server 2016 AD FS servers are up to date as of the June 2018 Windows Updates and that the AD FS 2016 farm is running at the 2016 farm behavior level.

### Update artifact database permissions
Extranet smart lockout requires the AD FS service account to have permissions to a new table in the ADFS artifact database.  Grant this permission by executing the following command in a PowerShell command window:
``` powershell
PS C:\>$cred = Get-Credential
PS C:\>Update-AdfsArtifactDatabasePermission -Credential $cred
```
Where `$cred` is an account with AD FS administrator permissions (AD FS administrator permissions are required to make the database change.)

>[!NOTE]
>In a multiple server farm that uses the WID database, the above cmdlet requires that Windows Remote management be enabled on every AD FS server

If you do not have AD FS administrator permissions, you can configure database permissions manually in SQL or WID by running the following command when connected to the AdfsArtifactStore database.
```
sp_addrolemember 'db_owner', 'db_genevaservice'
```
### Ensure AD FS Security Audit Logging is enabled
This feature makes use of Security Audit logs, so auditing must be enabled in AD FS as well as the local policy on all AD FS servers.

## Pre-requisites for Extranet Smart Lockout in AD FS 2019
The following pre-requisites are required for ESL with AD FS 2016.

### Ensure AD FS Security Audit Logging is enabled
This feature makes use of Security Audit logs, so auditing must be enabled in AD FS as well as the local policy on all AD FS servers.

## Lockout Settings
Extranet smart lockout consists of a set of new capabilities governed by new and existing AD FS properties.

### Extranet Lockout Enabled
Extranet smart lockout uses the same AD FS property that previously was used just to control “soft” extranet lockout.  The property is called ExtranetLockoutEnabled and can be viewed via Get-AdfsProperties.

### Extranet Smart Lockout Mode
A new AD FS property called ExtranetLockoutMode has been added to control smart vs “soft” lockout behavior.  It can be set via Set-AdfsProperties and contains 3 values:

    - **ADPasswordCounter** – This is the legacy ADFS “extranet soft lockout” mode which does not differentiate based on location.  This is the default value.

    - **ADFSSmartLockoutLogOnly** – This is Extranet Smart Lockout, but instead of rejecting authentication requests, AD FS will only write admin and audit events.

    - **ADFSSmartLockoutEnforce** - This is Extranet Smart Lockout with full support for blocking unfamiliar requests when the thresholds are reached.

In AD FS 2019, the values ADPasswordCounter and ADFSSmartLockoutLogOnly can be combined so that soft lockout continues to be enforced while you are preparing for smart lockout.

### Lockout Threshold and Observation Window
Smart lockout in AD FS 2019 uses the same two AD FS properties as soft lockout used previously: ExtranetObservationWindow and ExtranetLockoutThreshold.

- **ExtranetLockoutThreshold &lt;Integer&gt;** this defines the maximum number of bad password attempts. Once the threshold is reached, in ADFSSmartLockoutEnforce mode AD FS will reject requests from the extranet until the  observation window has passed.  In ADFSSmartLockoutLogOnly mode, AD FS will write log entries only.  
- **ExtranetObservationWindow &lt;TimeSpan&gt;** this determines for how long username and password requests from unfamiliar locations will be locked out. AD FS will start to perform username and password authentication again when the window is passed.

> [!NOTE]
> AD FS extranet lockout functions independently from the AD lockout policies. We recommend that you set the **ExtranetLockoutThreshold** parameter value to a value that is less than the AD account lockout threshold. Failing to do so would result in AD FS being unable to protect accounts from being locked out in Active Directory. 

In AD FS 2019, we have introduced a new lockout threshold specific to known good locations: ExtranetLockoutThresholdFamiliarLocation.
- **ExtranetLockoutThresholdFamiliarLocation &lt;Integer&gt;** this defines the maximum number of bad password attempts from familiar locations. In AD FS 2019, the original parameter ExtranetLockoutThreshold applies to unfamiliar locations (IP addresses not known to be good).

### Primary Domain Controller Requirement
AD FS 2016 offers a parameter that allows fallback to another domain controller when the PDC is unavailable.

- **ExtranetLockoutRequirePDC &lt;Boolean&gt;** When enabled, extranet lockout requires a primary domain controller (PDC). When disabled, extranet lockout will fallback to another domain controller in case the PDC is unavailable.

   The following example shows the cmdlet to enable lockout with the PDC requirement disabled:

    ```powershell
    Set-AdfsProperties -EnableExtranetLockout $true -ExtranetLockoutThreshold 15 -ExtranetObservationWindow (new-timespan -Minutes 30) -ExtranetLockoutRequirePDC $false
    ```

## Configuring AD FS with Smart Lockout in Log Only Mode

### AD FS 2016
We recommend that you first set the lockout behavior to log only by running the following cmdlet:

 ```powershell
PS C:\>Set-AdfsProperties -ExtranetLockoutMode AdfsSmartlockoutLogOnly
 ```

In this mode, AD FS populates users familiar location information and writes security audit events, but does not block any requests.  This mode is used to validate that smart lockout is running and to enable AD FS to “learn” familiar locations for users before enabling “enforce” mode.
As AD FS learns, it stores login activity per user (whether in log only mode or enforce mode). 

>[!NOTE]
>Configuring `ExtranetLockoutMode` to `AdfsSmartlockoutLogOnly` will cause the legacy AD FS “extranet soft lockout” behavior to no longer be in effect, even if the `EnableExtranetLockout` property is set to True.  This means that users who exceed lockout thresholds from familiar or unfamiliar IP addresses will not be locked out by AD FS.  This is intended to be a temporary state so that the system can learn login behavior prior to re-introducing lockout enforcement with the new smart lockout behavior. It is to be noted that user may still get locked out by on-prem AD.

For the new mode to take effect, restart the AD FS service on all nodes in the farm
  
  ``` powershell
PS C:\>Restart-service adfssrv
  ```
Once the mode is configured, you can enable smart lockout using the `EnableExtranetLockout` parameter


``` powershell
PS C:\>Set-AdfsProperties -EnableExtranetLockout $true
```

Note that you can use the same cmdlet to disable lockout

Example: Disable lockout

``` powershell
PS C:\>Set-AdfsProperties -EnableExtranetLockout $false
```
### AD FS 2019
If you are not presently using AD FS Extranet Soft Lockout, we recommend that you follow the same guidance as for AD FS 2016 above.
If you are using soft lockout, however, we recommend that you set the AD FS 2019 lockout behavior to log for smart lockout, but keep enforcing soft lockout, using the below powershell:

 ```powershell
PS C:\>Set-AdfsProperties -ExtranetLockoutMode 3
 ```

Once you execute this cmdlet, you can then use Get-AdfsProperties to query the value of the ExtranetLockoutMode AD FS property.  You will see that its value has been updated to a bitwise combination of ADPasswordCounter and ADFSSmartLockoutLogOnly.

## Observing Audit Events
AD FS will write extranet lockout events to the security audit log:
-	When a user is locked out (reaches the lockout threshold for unsuccessful login attempts)
-	When AD FS receives a login attempt for a user who is already in lockout state

While in log only mode, you can check the security audit log for lockout events.  For any events found, you can check the user state using the Get-ADFSAccountActivity cmdlet to determine if the lockout occurred from familiar or unfamiliar IP addresses, and to double check the list of familiar IP addresses for that user.

Example event:
```
Log Name:      Security
Source:        AD FS Auditing
Date:          5/21/2018 12:55:59 AM
Event ID:      1210
Task Category: (3)
Level:         Information
Keywords:      Classic,Audit Failure
User:          CONTOSO\adfssvc
Computer:      ADFS2016FS1.corp.contoso.com
Description:
An extranet lockout event has occurred. See XML for failure details. 

Activity ID: fa7a8052-0694-48f0-84e2-b51cde40ac3d 

Additional Data 
XML: <?xml version="1.0" encoding="utf-16"?>
<AuditBase xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ExtranetLockoutAudit">
  <AuditType>ExtranetLockout</AuditType>
  <AuditResult>Failure</AuditResult>
  <FailureType>ExtranetLockoutError</FailureType>
  <ErrorCode>AccountRestrictedAudit</ErrorCode>
  <ContextComponents>
    <Component xsi:type="ResourceAuditComponent">
      <RelyingParty>http://fs.contoso.com/adfs/services/trust</RelyingParty>
      <ClaimsProvider>N/A</ClaimsProvider>
      <UserId>CONTOSO\user</UserId>
    </Component>
    <Component xsi:type="RequestAuditComponent">
      <Server>N/A</Server>
      <AuthProtocol>WSFederation</AuthProtocol>
      <NetworkLocation>Extranet</NetworkLocation>
      <IpAddress>64.187.173.10</IpAddress>
      <ForwardedIpAddress>64.187.173.10</ForwardedIpAddress>
      <ProxyIpAddress>N/A</ProxyIpAddress>
      <NetworkIpAddress>N/A</NetworkIpAddress>
      <ProxyServer>ADFS2016PROXY2</ProxyServer>
      <UserAgentString>Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36</UserAgentString>
      <Endpoint>/adfs/ls/</Endpoint>
    </Component>
    <Component xsi:type="LockoutConfigAuditComponent">
      <CurrentBadPasswordCount>5</CurrentBadPasswordCount>
      <ConfigBadPasswordCount>5</ConfigBadPasswordCount>
      <LastBadAttempt>05/21/2018 00:55:05</LastBadAttempt>
      <LockoutWindowConfig>00:30:00</LockoutWindowConfig>
    </Component>
  </ContextComponents>
</AuditBase>
Event Xml:
<Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event">
  <System>
    <Provider Name="AD FS Auditing" />
    <EventID Qualifiers="0">1210</EventID>
    <Level>0</Level>
    <Task>3</Task>
    <Keywords>0x8090000000000000</Keywords>
    <TimeCreated SystemTime="2018-05-21T00:55:59.921880300Z" />
    <EventRecordID>35521235</EventRecordID>
    <Channel>Security</Channel>
    <Computer>ADFS2016FS1.contoso.com</Computer>
    <Security UserID="S-1-5-21-1156273042-1594504307-2076964089-1104" />
  </System>
  <EventData>
    <Data>fa7a8052-0694-48f0-84e2-b51cde40ac3d</Data>
    <Data><?xml version="1.0" encoding="utf-16"?>
<AuditBase xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ExtranetLockoutAudit">
  <AuditType>ExtranetLockout</AuditType>
  <AuditResult>Failure</AuditResult>
  <FailureType>ExtranetLockoutError</FailureType>
  <ErrorCode>AccountRestrictedAudit</ErrorCode>
  <ContextComponents>
    <Component xsi:type="ResourceAuditComponent">
      <RelyingParty>http://fs.contoso.com/adfs/services/trust</RelyingParty>
      <ClaimsProvider>N/A</ClaimsProvider>
      <UserId>CONTOSO\user</UserId>
    </Component>
    <Component xsi:type="RequestAuditComponent">
      <Server>N/A</Server>
      <AuthProtocol>WSFederation</AuthProtocol>
      <NetworkLocation>Extranet</NetworkLocation>
      <IpAddress>64.187.173.10</IpAddress>
      <ForwardedIpAddress>64.187.173.10</ForwardedIpAddress>
      <ProxyIpAddress>N/A</ProxyIpAddress>
      <NetworkIpAddress>N/A</NetworkIpAddress>
      <ProxyServer>ADFS2016PROXY2</ProxyServer>
      <UserAgentString>Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36</UserAgentString>
      <Endpoint>/adfs/ls/</Endpoint>
    </Component>
    <Component xsi:type="LockoutConfigAuditComponent">
      <CurrentBadPasswordCount>5</CurrentBadPasswordCount>
      <ConfigBadPasswordCount>5</ConfigBadPasswordCount>
      <LastBadAttempt>05/21/2018 00:55:05</LastBadAttempt>
      <LockoutWindowConfig>00:30:00</LockoutWindowConfig>
    </Component>
  </ContextComponents>
</AuditBase></Data>
  </EventData>
</Event>
```

## Observing User Activity
AD FS provides powershell cmdlets to view and manage user account activity data.  To read the current account activity for a user account.  Use the cmdlet below

``` powershell
PS C:\>Get-ADFSAccountActivity user@contoso.com
```

Example output
```
Identifier             : CONTOSO\user
BadPwdCountFamiliar    : 0
BadPwdCountUnknown     : 0
LastFailedAuthFamiliar : 1/1/0001 12:00:00 AM
LastFailedAuthUnknown  : 1/1/0001 12:00:00 AM
FamiliarLockout        : False
UnknownLockout         : False
FamiliarIps            : {}
```

The current activity output contains the following data:

**Identifier**: this is the username

**BadPwdCountFamiliar**: this is the current count of incorrect password login attempts from IP addresses that were on the list of “FamiliarIps” at the time of the attempt

**BadPwdCountUnknown**: this is the current count of incorrect password login attempts from IP addresses that were not on the list of “FamiliarIps” at the time of the attempt

**LastFailedAuthFamiliar**: this is the time of the last incorrect password login attempt from an IP address that was on the list of “FamiliarIps” at the time of the attempt

**LastFailedAuthUnknown**: this is the time of the last incorrect password login attempt from an IP address that was not on the list of “FamiliarIps” at the time of the attempt

**FamiliarLockout**: this indicates if the user is currently in a state of lockout for correct password attempts from IP addresses on the list of “FamiliarIps” 

**UnknownLockout**: this indicates if the user is currently in a state of lockout for correct password attempts from IP addresses not on the list of “FamiliarIps”
FamiliarIps: this is the current list of familiar IP addresses for the user

## Adjust threshold and window
Once you have been running in log only mode for a sufficient amount of time for AD FS to learn login locations, you may wish to adjust the threshold or observation window from the default settings.  This is done using `Set-AdfsProperties` as in the examples below:

The observation window is set using `ExtranetObservationWindow`:

Example: 

``` powershell
PS C:\>Set-AdfsProperties -ExtranetObservationWindow ( new-timespan -minutes 30 )
```

Where the value is a TimeSpan

### Setting threshold value in AD FS 2016
In AD FS 2016, the threshold is set using ExtranetLockoutThreshold:

Example:

``` powershell
PS C:\>Set-AdfsProperties -ExtranetLockoutThreshold 5
```

### Setting threshold values in AD FS 2019
In AD FS 2019, there are distinct threshold values for known good and unfamiliar locations

To set the threshold value for unfamiliar locations, use the same property used for AD FS 2016 above:

Example:

``` powershell
PS C:\>Set-AdfsProperties -ExtranetLockoutThreshold 5
```

To set the threshold value for known good locations, use the new property ExtranetLockoutThresholdFamiliarLocation, as shown in the example below:

Example:

``` powershell
PS C:\>Set-AdfsProperties -ExtranetLockoutThresholdFamiliarLocation 10
```


## Enable enforce mode
Once you have been running in log only mode for sufficient time for AD FS to learn login locations and to observe any lockout activity, and once you are comfortable with the lockout threshold and observation window, smart lockout can be moved to “enforce” mode using the PSH cmdlet below:

``` powershell
PS C:\>Set-AdfsProperties -ExtranetLockoutMode AdfsSmartLockoutEnforce
```

For the new mode to take effect, restart the AD FS service on all nodes in the farm

``` powershell
PS C:\>Restart-service adfssrv
```


## Manage User Account Activity
AD FS provides 3 cmdlets to manage user account activity data.  These cmdlets automatically connect to the node in the farm which holds the master role (though this behavior can be overridden by passing the -Server parameter).

> [!NOTE] 
> For information on delegating permissions for using these cmdlets, see [Delegate AD FS Powershell Commandlet Access to Non-Admin Users](delegate-ad-fs-pshell-access.md)

These cmdlets are:

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

## Troubleshooting ESL
The following can assist you with troubleshooting the extranet smart lockout feature.

### Updating database permissions for ESL
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

## Banned IP addresses
In addition to the extranet smart lockout capabilities, the AD FS June 2018 update enables you to configure a set of IP addresses globally in AD FS, so that requests coming from those IP addresses, or that have those IP addresses in the **x-forwarded-for** or **x-ms-forwarded-client-ip** headers, will be blocked by AD FS.

##### Adding banned IPs
To add banned IPs to the global list, use the below Powershell cmdlet:

``` powershell
PS C:\ >Set-AdfsProperties -AddBannedIps "1.2.3.4", "::3", "1.2.3.4/16"
```

Allowed formats

1.	IPv4
2.	IPv6
3.	CIDR format with IPv4 or v6
4.	IP range with IPv4 or v6 ( i.e. 1.2.3.4-1.2.3.6 )

#### Removing banned IPs
To remove banned IPs from the global list, use the below Powershell cmdlet:

``` powershell
PS C:\ >Set-AdfsProperties -RemoveBannedIps "1.2.3.4"
```

#### Read banned IPs
To read the current set of banned IP addresses, use the below Powershell cmdlet:

``` powershell
PS C:\ >Get-AdfsProperties 
```

Example output:

```
BannedIpList                   : {1.2.3.4, ::3,1.2.3.4/16}
```



## Additional references  
[Best practices for securing Active Directory Federation Services](../../ad-fs/deployment/best-practices-securing-ad-fs.md)

[Set-AdfsProperties](https://technet.microsoft.com/itpro/powershell/windows/adfs/set-adfsproperties)

[AD FS Operations](../../ad-fs/AD-FS-2016-Operations.md)

    
