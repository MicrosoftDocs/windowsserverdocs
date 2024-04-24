---
ms.assetid: 777aab65-c9c7-4dc9-a807-9ab73fac87b8
title: Configure AD FS Extranet Smart Lockout Protection
description: Learn more about AD FS Extranet Lockout and Extranet Smart Lockout to protect your users from experiencing extranet account lockout from malicious activity.
author: billmath
ms.author: wscontent
manager: amycolannino
ms.date: 06/16/2023
ms.topic: article
---

# AD FS Extranet Lockout and Extranet Smart Lockout Overview

Extranet Smart Lockout (ESL) protects your users from experiencing extranet account lockout from malicious activity.

ESL enables AD FS to differentiate between sign-in attempts from a familiar location for a user and sign-in attempts from what might be an attacker. AD FS can lock out attackers while letting valid users continue to use their accounts. This distinction prevents and protects against denial-of-service and certain classes of password spray attacks on the user. ESL is available for AD FS in Windows Server 2016 and is built into AD FS in Windows Server 2019.

ESL is only available for username and password authentication requests that come through the extranet with the Web Application Proxy or a third party proxy. Any third party proxy must support the MS-ADFSPIP protocol to be used in place of the Web Application Proxy, such as [F5 BIG-IP Access Policy Manager](https://devcentral.f5.com/s/articles/ad-fs-proxy-replacement-on-f5-big-ip-30191). Consult the third party proxy documentation to determine if the proxy supports the MS-ADFSPIP protocol.

## Features in AD FS 2019

Extranet Smart Lockout in AD FS 2019 adds the following advantages compared to AD FS 2016:

- Independent lockout thresholds for familiar and unfamiliar locations. Users in known good locations can have more room for error than requests from suspicious locations.
- Audit mode for smart lockout while continuing to enforce previous soft lockout behavior. This distinction lets you learn about user-familiar locations and still be protected by the extranet lockout feature that's available from AD FS 2012 R2.

### Configuration information

When ESL is enabled, a new table in the Artifact database, `AdfsArtifactStore.AccountActivity`, is created. A node is also selected in the AD FS farm as the “User Activity” primary node. In a Windows Internal Database (WID) configuration, this node is always the primary node. In a SQL configuration, one node is selected to be the User Activity primary node.

To view the node selected as the "User Activity" primary node, use `(Get-AdfsFarmInformation).FarmRoles`.

All secondary nodes contact the primary node on each fresh sign-in through Port 80 to learn the latest value of the bad password counts and new familiar location values. Secondary nodes also update the primary node after the sign-in is processed.

:::image type="content" source="media/configure-ad-fs-extranet-smart-lockout-protection/esl1.png" alt-text="Diagram showing the sign-in process between primary nodes, secondary nodes, and the client.":::

If the secondary node can't contact the primary node, the secondary node writes error events into the AD FS admin log. Authentications continue to be processed, but AD FS only writes the updated state locally. AD FS retries contacting the primary node every 10 minutes. AD FS switches back to the primary node once the primary node is available.

### Terminology

- **FamiliarLocation**: During an authentication request, ESL checks all presented Internet Protocols (IPs). These IPs are a combination of network IP, forwarded IP, and the optional x-forwarded-for IP. If the request is successful, all the IPs are added to the Account Activity table as “familiar IPs.” If the request has all the IPs present in the “familiar IPs,” the request is treated as a “familiar” location.
- **UnknownLocation**: If a request that comes in has at least one IP not present in the existing **FamiliarLocation** list, then the request is treated as an “Unknown” location. This action handles proxying scenarios such as Exchange Online legacy authentication where Exchange Online addresses handle both successful and failed requests.
- **badPwdCount**: A value representing the number of times an incorrect password was submitted, and the authentication was unsuccessful. For each user, separate counters are kept for familiar locations and unknown locations.
- **UnknownLockout**: A boolean value per user if the user is locked out from accessing from unknown locations. This value is calculated based on the **badPwdCountUnfamiliar** and **ExtranetLockoutThreshold** values.
- **ExtranetLockoutThreshold**: This value determines the maximum number of bad password attempts. When the threshold is reached, AD FS rejects requests from the extranet until the observation window has passed.
- **ExtranetObservationWindow**: This value determines the duration that username and password requests from unknown locations are locked out. When the window has passed, AD FS starts to perform username and password authentication from unknown locations again.
- **ExtranetLockoutRequirePDC**: When enabled, extranet lockout requires a primary domain controller (PDC). When disabled, extranet lockout falls back to another domain controller in case the PDC is unavailable.
- **ExtranetLockoutMode**: Controls **Log-Only** vs **Enforced** mode of ESL.
  - **ADFSSmartLockoutLogOnly**: ESL is enabled. AD FS writes admin and audit events but doesn't reject authentication requests. This mode is intended to be enabled for **FamiliarLocation** to be populated before **ADFSSmartLockoutEnforce** is enabled.
  - **ADFSSmartLockoutEnforce**: Full support for blocking unfamiliar authentication requests when thresholds are reached.

IPv4 and IPv6 addresses are supported.

### Anatomy of a transaction

- **Pre-Auth Check**: During an authentication request, ESL checks all presented IPs. These IPs are a combination of network IP, forwarded IP, and the optional x-forwarded-for IP. In the audit logs, these IPs are listed in the `<IpAddress>` field in the order of x-ms-forwarded-client-ip, x-forwarded-for, x-ms-proxy-client-ip.

  Based on these IPs, AD FS determines if the request is from a familiar location and then checks if the respective **badPwdCount** is less than the set threshold limit or if the last failed attempt happened longer than the observation window time frame. If one of these conditions is true, AD FS allows this transaction for further processing and credential validation. If both conditions are false, the account is already in a locked out state until the observation window passes. After the observation window passes, the user is allowed one attempt to authenticate. In Windows Server 2019, AD FS checks against the appropriate threshold limit based on if the IP address matches a familiar location.
- **Successful Login**: If the login succeeds, then the IPs from the request are added to the user's familiar location IP list.
- **Failed Login**: If the login fails, the **badPwdCount** is increased. The user goes into a lockout state if the attacker sends more bad passwords to the system than the threshold allows. (badPwdCount > ExtranetLockoutThreshold)

:::image type="content" source="media/configure-ad-fs-extranet-smart-lockout-protection/esl2.png" alt-text="Diagram showing the process of successful and unsuccessful authentication.":::

The **UnknownLockout** value equals **True** when the account is locked out. This lockout means that the user's **badPwdCount** is over the threshold. For example, someone attempted more passwords than the system allows. In this state, there are two ways that a valid user can sign in:

- Wait for the **ObservationWindow** time to elapse.
- In order to reset the Lockout state, reset the **badPwdCount** back to zero with **Reset-ADFSAccountLockout**.

If no resets occur, the account is allowed a single password attempt against AD for each observation window. After that attempt, the account returns to the locked-out state, and the observation window restarts. The **badPwdCount** value only resets automatically after a successful password sign-in.

### Log-Only mode versus Enforce mode

The **AccountActivity** table is populated both during **Log-Only** mode and **Enforce** mode. If **Log-Only** mode is bypassed, and ESL is moved directly into **Enforce** mode without the recommended waiting period, the familiar IPs of the users aren't known to AD FS. ESL then behaves like **ADBadPasswordCounter**, potentially blocking legitimate user traffic if the user account is under an active brute force attack. If the **Log-Only** mode is bypassed, and the user enters a locked out state where **UnknownLockout** equals **True** and attempts to sign in with a good password from an IP that isn't in the “familiar” IP list, then they aren't able to sign in. **Log-Only** mode is recommended for 3-7 days to avoid this scenario. If accounts are actively under attack, a minimum of 24 hours of **Log-Only** mode is necessary to prevent lockouts to legitimate users.

## Extranet Smart Lockout Configuration

The following sections describe the prerequisites and configurations for enabling ESL for AD FS 2016.

### Prerequisites for AD FS 2016

1. Install updates on all nodes in the farm.

   First, ensure all Windows Server 2016 AD FS servers are up to date as of the June 2018 Windows Updates and that the AD FS 2016 farm runs at the 2016 farm behavior level.

1. Verify Permissions.

   ESL requires that Windows Remote management is enabled on every AD FS server.

1. Update artifact database permissions.

   ESL requires the AD FS service account to have permissions to create a new table in the AD FS artifact database. Sign in to any AD FS server as an AD FS admin. Then grant this permission in a PowerShell Command Prompt window by running the following commands:

   ```powershell
   PS C:\>$cred = Get-Credential
   PS C:\>Update-AdfsArtifactDatabasePermission -Credential $cred
   ```

   > [!NOTE]
   > The $cred placeholder is an account that has AD FS administrator permissions. This should provide the write permissions to create the table.

   The previous commands might fail due to lack of sufficient permission because your AD FS farm uses SQL Server, and the credential provided previously doesn't have admin permission on your SQL server. In this case, you can configure database permissions manually in SQL Server Database when you're connected to the **AdfsArtifactStore** database by running the following command:

    ```
    # when prompted with “Are you sure you want to perform this action?”, enter Y.

    [CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact = 'High')]
    Param()

    $fileLocation = "$env:windir\ADFS\Microsoft.IdentityServer.Servicehost.exe.config"

    if (-not [System.IO.File]::Exists($fileLocation))
    {
    write-error "Unable to open AD FS configuration file."
    return
    }

    $doc = new-object Xml
    $doc.Load($fileLocation)
    $connString = $doc.configuration.'microsoft.identityServer.service'.policystore.connectionString
    $connString = $connString -replace "Initial Catalog=AdfsConfigurationV[0-9]*", "Initial Catalog=AdfsArtifactStore"

    if ($PSCmdlet.ShouldProcess($connString, "Executing SQL command sp_addrolemember 'db_owner', 'db_genevaservice' "))
    {
    $cli = new-object System.Data.SqlClient.SqlConnection
    $cli.ConnectionString = $connString
    $cli.Open()

    try
    {

    $cmd = new-object System.Data.SqlClient.SqlCommand
    $cmd.CommandText = "sp_addrolemember 'db_owner', 'db_genevaservice'"
    $cmd.Connection = $cli
    $rowsAffected = $cmd.ExecuteNonQuery()
    if ( -1 -eq $rowsAffected )
    {
    write-host "Success"
    }
    }
    finally
    {
    $cli.CLose()
    }
    }
    ```

### Ensure AD FS Security Audit Logging is enabled

This feature makes use of Security Audit logs, so auditing must be enabled in AD FS and the local policy on all AD FS servers.

### Configuration Instructions

ESL uses the AD FS property **ExtranetLockoutEnabled**. This property was previously used to control Extranet Soft Lockout in Server 2012 R2. If ESL is enabled, and you want to view the current property configuration, run `Get-AdfsProperties`.

### Configuration Recommendations

When configuring ESL, follow best practices for setting thresholds:

`ExtranetObservationWindow (new-timespan -Minutes 30)`

`ExtranetLockoutThreshold: Half of AD Threshold Value`

`AD value: 20, ExtranetLockoutThreshold: 10`

Active Directory lockout works independently from ESL. However, if Active Directory lockout is enabled, select **ExtranetLockoutThreshold** in AD FS and **Account Lockout Threshold** in AD.

`ExtranetLockoutRequirePDC - $false`

When enabled, extranet lockout requires a primary domain controller (PDC). When disabled and configured as false, extranet lockout falls back to another domain controller in case the PDC is unavailable.

To set this property run:

``` powershell
Set-AdfsProperties -EnableExtranetLockout $true -ExtranetLockoutThreshold 15 -ExtranetObservationWindow (New-TimeSpan -Minutes 30) -ExtranetLockoutRequirePDC $false
```

### Enable Log-Only Mode

In **Log-Only** mode, AD FS populates a user's familiar location information and writes security audit events but doesn't block any requests. This mode is used to validate that smart lockout is running and to enable AD FS to “learn” familiar locations for users before enabling **Enforce** mode. As AD FS learns, it stores sign-in activity per user (whether in **Log-Only** mode or **Enforce** mode).
Set the lockout behavior to **Log-Only** by running the following cmdlet:

`Set-AdfsProperties -ExtranetLockoutMode AdfsSmartlockoutLogOnly`

**Log-Only** mode is intended to be a temporary state so that the system can learn sign-in behavior prior to introducing lockout enforcement with the smart lockout behavior. The recommended duration for **Log-Only** mode is 3-7 days. If accounts are actively under attack, **Log-Only** mode must run for a minimum of 24 hours.

On AD FS 2016, if 2012 R2 Extranet Soft Lockout behavior is enabled prior to enabling Extranet Smart Lockout, **Log-Only** mode disables the Extranet Soft Lockout behavior. AD FS Smart Lockout doesn't lock out users in **Log-Only** mode. However, on-premises AD might lock out the user based on the AD configuration. Review AD Lockout policies to learn how on-premises AD can lock out users.

On AD FS 2019, another advantage is to be able to enable **Log-Only** mode for smart lockout while continuing to enforce the previous soft lockout behavior by using the below PowerShell:

`Set-AdfsProperties -ExtranetLockoutMode 3`

For the new mode to take effect, restart the AD FS service on all nodes in the farm by using:

   `Restart-service adfssrv`

Once the mode is configured, you can enable smart lockout by using the **EnableExtranetLockout** parameter:

   `Set-AdfsProperties -EnableExtranetLockout $true`

### Enable Enforce Mode

After you're comfortable with the lockout threshold and observation window, ESL can be moved to **Enforce** mode by using the following PSH cmdlet:

`Set-AdfsProperties -ExtranetLockoutMode AdfsSmartLockoutEnforce`

For the new mode to take effect, restart the AD FS service on all nodes in the farm by using the following command.

`Restart-service adfssrv`

## Manage user account activity

AD FS provides three cmdlets to manage account activity data. These cmdlets automatically connect to the node in the farm that holds the primary role.

> [!NOTE]
> You can use Just Enough Administration (JEA) to delegate AD FS commandlets to reset account lockouts. For example, you can delegate permissions to Help Desk personnel to use ESL commandlets. For more information, see [Delegate AD FS Powershell commandlet access to nonadmin Users](delegate-ad-fs-pshell-access.md).

You can override this behavior by passing the `-Server` parameter.

### Get-ADFSAccountActivity -UserPrincipalName

The cmdlet automatically connects to the farm primary node by using the Account Activity REST endpoint. Therefore, all data should always be consistent. Read the current account activity for a user account by using:

`Get-ADFSAccountActivity user@contoso.com`

Properties:

- **BadPwdCountFamiliar**: Incremented when an authentication is unsuccessful from a known location.
- **BadPwdCountUnknown**: Incremented when an authentication is unsuccessful from an unknown location.
- **LastFailedAuthFamiliar**: If authentication was unsuccessful from a familiar location, **LastFailedAuthFamiliar** is set to time of unsuccessful authentication.
- **LastFailedAuthUnknown**: If authentication was unsuccessful from an unknown location, **LastFailedAuthUnknown** is set to time of unsuccessful authentication.
- **FamiliarLockout**: Boolean value that is **True** if the **BadPwdCountFamiliar** > **ExtranetLockoutThreshold**.
- **UnknownLockout**: Boolean value that is **True** if the **BadPwdCountUnknown** > **ExtranetLockoutThreshold**.
- **FamiliarIPs**: maximum of 20 IPs that are familiar to the user. When 20 IPs is exceeded, the oldest IP in the list is removed.

### Set-ADFSAccountActivity

**Set-ADFSAccountActivity** adds new familiar locations. The familiar IP list has a maximum of 20 entries. If 20 entries are exceeded, the oldest IP in the list is removed.

`Set-ADFSAccountActivity user@contoso.com -AdditionalFamiliarIps “1.2.3.4”`

### Reset-ADFSAccountLockout

Resets the lockout counter for a user account for each Familiar location (**badPwdCountFamiliar**) or Unfamiliar Location counter (**badPwdCountUnfamiliar**). When you reset a counter, the **FamiliarLockout** or **UnfamiliarLockout** value updates, as the reset counter is less than the threshold.

`Reset-ADFSAccountLockout user@contoso.com -Location Familiar`

`Reset-ADFSAccountLockout user@contoso.com -Location Unknown`

## Event logging & user activity information for AD FS extranet lockout

The following sections describe how to monitor event logging, user account activity, and lockouts.

### Connect Health

The recommended way to monitor user account activity is through Connect Health. Connect Health generates downloadable reporting on Risky IPs and bad password attempts. Each item in the Risky IP report shows aggregated information about failed AD FS sign-in activities that exceed designated threshold. Email notifications can be set to alert administrators with customizable email settings when failed AD FS sign-in activities occur. For more information and setup instructions, see [Monitor AD FS using Microsoft Entra Connect Health](/azure/active-directory/hybrid/how-to-connect-health-adfs).

### AD FS Extranet Smart Lockout events

> [!NOTE]
> To troubleshoot ESL, see [Mitigating password spray attacks and account lockouts](https://adfshelp.microsoft.com/TroubleshootingGuides/Workflow/a73d5843-9939-4c03-80a1-adcbbf3ccec8).

For Extranet Smart Lockout events to be written, ESL must be enabled in **Log-Only** or **Enforce** mode, and AD FS security auditing must be enabled.
AD FS writes extranet lockout events to the security audit log when:

- A user is locked out, meaning that user reaches the lockout threshold for unsuccessful sign-in attempts.
- AD FS receives a sign-in attempt for a user who is already in a lockout state.

While in **Log-Only** mode, you can check the security audit log for lockout events. For any events found, you can check the user state by using the `Get-ADFSAccountActivity` cmdlet to determine if the lockout occurred from familiar or unfamiliar IP addresses. You can also use the `Get-ADFSAccountActivity` cmdlet to double check the list of familiar IP addresses for that user.

|Event ID|Description|
|-----|-----|
|1203|This event is written for each bad password attempt. As soon as the **badPwdCount** reaches the value specified in **ExtranetLockoutThreshold**, the account is locked out on AD FS for the duration specified in **ExtranetObservationWindow**.</br>Activity ID: %1</br>XML: %2|
|1210|This event is written each time a user is locked out. </br>Activity ID: %1</br>XML: %2|
|557 (AD FS 2019)| An error occurred while trying to communicate with the account store rest service on node %1. If you use a WID farm, the primary node might be offline. If you use a SQL farm, AD FS automatically selects a new node to host the user store primary role.|
|562 (AD FS 2019)|An error occurred when communicating with the account store endpoint on server %1.</br>Exception Message: %2|
|563 (AD FS 2019)|An error occurred while calculating extranet lockout status. Due to the value of the %1, setting authentication is allowed for this user, and token issuance continues. If you use a WID farm, the primary node might be offline. If you use a SQL farm, AD FS automatically selects a new node to host the user store primary role.</br> Account store server name: %2</br>User ID: %3</br>Exception Message: %4|
|512|The account for the following user is locked out. A sign-in attempt is being allowed due to the system configuration.</br> Activity ID: %1 </br>User: %2 </br>Client IP: %3 </br>Bad Password Count: %4  </br>Last Bad Password Attempt: %5|
|515|The following user account was in a locked out state, and the correct password was provided. This account might be compromised.</br> More Data </br>Activity ID: %1 </br>User: %2 </br>Client IP: %3 |
|516|The following user account has been locked out due to too many bad password attempts.</br> Activity ID: %1  </br>User: %2  </br>Client IP: %3  </br>Bad Password Count: %4  </br>Last Bad Password Attempt: %5|

## ESL frequently asked questions

**Will an AD FS farm that uses Extranet Smart Lockout in Enforce mode ever see malicious user lockouts?**

If AD FS Smart Lockout is set to **Enforce** mode, then you never see the legitimate user's account locked out by brute force or denial of service. The only way a malicious account lockout can prevent a user sign-in is if the bad actor has the user password or can send requests from a known good (familiar) IP address for that user.

**What happens if ESL is enabled and the bad actor has a user's password?**

The typical goal of the brute force attack scenario is to guess a password and successfully sign in. If a user is phished or if a password is guessed, then the ESL feature doesn't block the access since the sign-in meets successful criteria of a correct password plus new IP. The bad actors IP would then appear as a familiar one. The best mitigation in this scenario is to clear the user's activity in AD FS and to require multi factor authentication for the users. You should install Microsoft Entra Password Protection to ensure guessable passwords don't get into the system.

**If my user has never signed in successfully from an IP and then tries with a wrong password a few times, will they be able to sign in once they finally type their password correctly?**

If a user submits multiple bad passwords (for example, by mistyping) and on the following attempt gets the password correct, then the user immediately signs in successfully. This successful sign-in clears the bad password count and adds that IP to the **FamiliarIPs** list. However, if they go above the threshold of failed sign-ins from the unknown location, they enter into lockout state. They must then wait past the observation window and sign in with a valid password. They might require admin intervention to reset their account.

**Does ESL work on intranet too?**

If the clients connect directly to the AD FS servers and not via Web Application Proxy servers, then the ESL behavior doesn't apply.

**I'm seeing Microsoft IP addresses in the Client IP field. Does ESL block EXO proxied brute force attacks?**  

ESL works well to prevent Exchange Online or other legacy authentication brute force attack scenarios. A legacy authentication has an “Activity ID” of 00000000-0000-0000-0000-000000000000. In these attacks, the bad actor is taking advantage of Exchange Online basic authentication (also known as legacy authentication) so that the client IP address appears as a Microsoft one. The Exchange Online servers in the cloud proxy the authentication verification on behalf of the Outlook client. In these scenarios, the IP address of the malicious submitter is in the x-ms-forwarded-client-ip, and the Microsoft Exchange Online server IP is in the x-ms-client-ip value.
Extranet Smart Lockout checks network IPs, forwarded IPs, the x-forwarded-client-IP, and the x-ms-client-ip value. If the request is successful, all the IPs are added to the familiar list. If a request comes in, and any of the presented IPs aren't in the familiar list, then the request is marked as unfamiliar. The familiar user is able to sign in successfully while requests from the unfamiliar locations are blocked.

**Can I estimate the size of the ADFSArtifactStore before enabling ESL?**

With ESL enabled, AD FS tracks the account activity and known locations for users in the **ADFSArtifactStore** database. This database scales in size relative to the number of users and known locations tracked. When planning to enable ESL, you can estimate the size for the **ADFSArtifactStore** database to grow at a rate of up to 1 GB per 100,000 users. If the AD FS farm uses the Windows Internal Database (WID), the default location for the database files is C:\Windows\WID\Data\. To prevent filling this drive, ensure you have a minimum of 5 GB of free storage before enabling ESL. In addition to disk storage, plan for total process memory to grow after enabling ESL by up to 1 GB of RAM for a user population of 500,000 or less.

## See also

- [Best practices for securing Active Directory Federation Services](../../ad-fs/deployment/best-practices-securing-ad-fs.md)
- [Set-AdfsProperties](/powershell/module/adfs/set-adfsproperties)
- [AD FS Operations](../ad-fs-operations.md)
