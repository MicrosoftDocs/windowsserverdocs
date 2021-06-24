---
description: "Learn more about: Guidance about how to configure protected accounts"
ms.assetid: 70c99703-ff0d-4278-9629-b8493b43c833
title: Guidance about how to configure protected accounts
author: iainfoulds
ms.author: daveba
manager: daveba
ms.date: 05/31/2017
ms.topic: article
---

# Guidance about how to configure protected accounts

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Through Pass-the-hash (PtH) attacks, an attacker can authenticate to a remote server or service by using the underlying NTLM hash of a user's password (or other credential derivatives). Microsoft has previously [published guidance](https://www.microsoft.com/download/details.aspx?id=36036) to mitigate pass-the-hash attacks.  Windows Server 2012 R2  includes new features to help mitigate such attacks further. For more information about other security features that help protect against credential theft, see [Credentials Protection and Management](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn408190(v=ws.11)). This topic explains how to configure the following new features:

-   [Protected Users](../../ad-ds/manage/How-to-Configure-Protected-Accounts.md#BKMK_AddtoProtectedUsers)

-   [Authentication policies](../../ad-ds/manage/How-to-Configure-Protected-Accounts.md#BKMK_CreateAuthNPolicies)

-   [Authentication policy silos](../../ad-ds/manage/How-to-Configure-Protected-Accounts.md#BKMK_CreateAuthNPolicySilos)

There are additional mitigations built in to Windows 8.1 and Windows Server 2012 R2 to help protect against credential theft, which are covered in the following topics:

-   [Restricted Admin mode for Remote Desktop](/archive/blogs/kfalde/restricted-admin-mode-for-rdp-in-windows-8-1-2012-r2)

-   [LSA Protection](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn408187(v=ws.11))

## <a name="BKMK_AddtoProtectedUsers"></a>Protected Users
Protected Users is a new global security group to which you can add new or existing users. Windows 8.1 devices and  Windows Server 2012 R2  hosts have special behavior with members of this group to provide better protection against credential theft. For a member of the group, a Windows 8.1 device or a  Windows Server 2012 R2  host does not cache credentials that are not supported for Protected Users. Members of this group have no additional protection if they are logged on to a device that runs a version of Windows earlier than Windows 8.1.

Members of the Protected Users group who are signed-on to Windows 8.1 devices and  Windows Server 2012 R2  hosts can *no longer* use:

-   Default credential delegation (CredSSP) - plaintext credentials are not cached even when the **Allow delegating default credentials** policy is enabled

-   Windows Digest - plaintext credentials are not cached even when they are enabled

-   NTLM - NTOWF is not cached

-   Kerberos long term keys - Kerberos ticket-granting ticket (TGT) is acquired at logon and cannot be re-acquired automatically

-   Sign-on offline - the cached logon verifier is not created

If the domain functional level is  Windows Server 2012 R2 , members of the group can no longer:

-   Authenticate by using NTLM authentication

-   Use Data Encryption Standard (DES) or RC4 cipher suites in Kerberos pre-authentication

-   Be delegated by using unconstrained or constrained delegation

-   Renew user tickets (TGTs) beyond the initial 4-hour lifetime

To add users to the group, you can use [UI tools](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753515(v=ws.11)) such as Active Directory Administrative Center (ADAC) or Active Directory Users and Computers, or a command-line tool such as [Dsmod group](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc732423(v=ws.11)), or the Windows PowerShell[Add-ADGroupMember](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee617210(v=technet.10)) cmdlet. Accounts for services and computers *should not* be members of the Protected Users group. Membership for those accounts provides no local protections because the password or certificate is always available on the host.

> [!WARNING]
> The authentication restrictions have no workaround, which means that members of highly privileged groups such as the Enterprise Admins group or the Domain Admins group are subject to the same restrictions as other members of the Protected Users group. If all members of such groups are added to the Protected Users group, it is possible for all of those accounts to be locked out. You should never add all highly privileged accounts to the Protected Users group until you have thoroughly tested the potential impact.

Members of the Protected Users group must be able to authenticate by using Kerberos with Advanced Encryption Standards (AES). This method requires AES keys for the account in Active Directory. The built-in Administrator does not have an AES key unless the password was changed on a domain controller that runs  Windows Server 2008  or later. Additionally, any account, which has a password that was changed at a domain controller that runs an earlier version of Windows Server, is locked out. Therefore, follow these best practices:

-   Do not test in domains unless **all domain controllers run  Windows Server 2008  or later**.

-   **Change password** for all domain accounts that were created *before* the domain was created. Otherwise, these accounts cannot be authenticated.

-   **Change password** for each user before adding the account to the Protected Users group or ensure that the password was changed recently on a domain controller that runs  Windows Server 2008  or later.

### <a name="BKMK_Prereq"></a>Requirements for using protected accounts
Protected accounts have the following deployment requirements:

-   To provide client-side restrictions for Protected Users, hosts must run Windows 8.1 or  Windows Server 2012 R2 . A user only has to sign-on with an account that is a member of a Protected Users group. In this case, the Protected Users group can be created by [transferring the primary domain controller (PDC) emulator role](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc816944(v=ws.10)) to a domain controller that runs  Windows Server 2012 R2 . After that group object is replicated to other domain controllers, the PDC emulator role can be hosted on a domain controller that runs an earlier version of Windows Server.

-   To provide domain controller-side restrictions for Protected Users, that is to restrict usage of NTLM authentication, and other restrictions, the domain functional level must be  Windows Server 2012 R2 . For more information about functional levels, see [Understanding Active Directory Domain Services (AD DS) Functional Levels](../active-directory-functional-levels.md).

### <a name="BKMK_TrubleshootingEvents"></a>Troubleshoot events related to Protected Users
This section covers new logs to help troubleshoot events that are related to Protected Users and how Protected Users can impact changes to troubleshoot either ticket-granting tickets (TGT) expiration or delegation issues.

#### New logs for Protected Users

Two new operational administrative logs are available to help troubleshoot events that are related to Protected Users: Protected User - Client Log and Protected User Failures - Domain Controller Log. These new logs are located in Event Viewer and are disabled by default. To enable a log, click **Applications and Services Logs**, click **Microsoft**, click **Windows**, click **Authentication**, and then click the name of the log and click **Action** (or right-click the log) and click **Enable Log**.

For more information about events in these logs, see [Authentication Policies and Authentication Policy Silos](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn486813(v=ws.11)).

#### Troubleshoot TGT expiration
Normally, the domain controller sets the TGT lifetime and renewal based on the domain policy as shown in the following Group Policy Management Editor window.

![Screenshot that shows the Group Policy Management Editor window.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_TGTExpiration.png)

For **Protected Users**, the following settings are hard-coded:

-   Maximum lifetime for user ticket: 240 minutes

-   Maximum lifetime for user ticket renewal: 240 minutes

#### Troubleshoot delegation issues
Previously, if a technology that uses Kerberos delegation was failing, the client account was checked to see if **Account is sensitive and cannot be delegated** was set. However, if the account is a member of **Protected Users**, it might not have this setting configured in Active Directory Administrative Center (ADAC). As a result, check the setting and group membership when you troubleshoot delegation issues.

![Screenshot that highlights the Account is sensitive and cannot be delegated check box.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_TshootDelegation.gif)

### <a name="BKMK_AuditAuthNattempts"></a>Audit authentication attempts
To audit authentication attempts explicitly for the members of the **Protected Users** group, you can continue to collect security log audit events or collect the data in the new operational administrative logs. For more information about these events, see [Authentication Policies and Authentication Policy Silos](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn486813(v=ws.11))

### <a name="BKMK_ProvidePUdcProtections"></a>Provide DC-side protections for services and computers
Accounts for services and computers cannot be members of **Protected Users**. This section explains which domain controller-based protections can be offered for these accounts:

-   Reject NTLM authentication: Only configurable via [NTLM block policies](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/jj865674(v=ws.10))

-   Reject Data Encryption Standard (DES) in Kerberos pre-authentication:  Windows Server 2012 R2  domain controllers do not accept DES for computer accounts unless they are configured for DES only because every version of Windows released with Kerberos also supports RC4.

-   Reject RC4 in Kerberos pre-authentication: not configurable.

    > [!NOTE]
    > Although it is possible to [change the configuration of supported encryption types](/archive/blogs/openspecification/windows-configurations-for-kerberos-supported-encryption-type), it is not recommended to change those settings for computer accounts without testing in the target environment.

-   Restrict user tickets (TGTs) to an initial 4-hour lifetime: Use Authentication Policies.

-   Deny delegation with unconstrained or constrained delegation: To restrict an account, open Active Directory Administrative Center (ADAC) and select the **Account is sensitive and cannot be delegated** check box.

    ![Screenshot that shows how to restrict an account.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_TshootDelegation.gif)

## <a name="BKMK_CreateAuthNPolicies"></a>Authentication policies
Authentication Policies is a new container in AD DS that contains authentication policy objects. Authentication policies can specify settings that help mitigate exposure to credential theft, such as restricting TGT lifetime for accounts or adding other claims-related conditions.

In  Windows Server 2012 , Dynamic Access Control introduced an Active Directory forest-scope object class called Central Access Policy to provide an easy way to configure file servers across an organization. In  Windows Server 2012 R2 , a new object class called Authentication Policy (objectClass msDS-AuthNPolicies) can be used to apply authentication configuration to account classes in  Windows Server 2012 R2  domains. Active Directory account classes are:

-   User

-   Computer

-   Managed Service Account and group Managed Service Account (GMSA)

### Quick Kerberos refresher
The Kerberos authentication protocol consists of three types of exchanges, also known as subprotocols:

![Diagram that shows the three types of exchanges in the Kerberos authentication protocol.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_KerbRefresher.gif)

-   The Authentication Service (AS) Exchange (KRB_AS_*)

-   The Ticket-Granting Service (TGS) Exchange (KRB_TGS_*)

-   The Client/Server (AP) Exchange (KRB_AP_*)

The AS exchange is where the client uses the account's password or private key to create a pre-authenticator to request a ticket-granting ticket (TGT). This happens at user sign-on or the first time a service ticket is needed.

The TGS exchange is where the account's TGT is used to create an authenticator to request a service ticket. This happens when an authenticated connection is needed.

The AP exchange occurs as typically as data inside the application protocol and is not impacted by authentication policies.

For more detailed information, see [How the Kerberos Version 5 Authentication Protocol Works](/previous-versions/windows/it-pro/windows-server-2003/cc772815(v=ws.10)).

### Overview
Authentication policies complement Protected Users by providing a way to apply configurable restrictions to accounts and by providing restrictions for accounts for services and computers. Authentication policies are enforced during either the AS exchange or the TGS exchange.

You can restrict initial authentication or the AS exchange by configuring:

-   A TGT lifetime

-   Access control conditions to restrict user sign-on, which must be met by devices from which the AS exchange is coming

![Screenshot that shows how to restrict initial authentication or the AS exchange.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_RestrictAS.gif)

You can restrict service ticket requests through a ticket-granting service (TGS) exchange by configuring:

-   Access control conditions which must be met by the client (user, service, computer) or device from which the TGS exchange is coming

### <a name="BKMK_ReqForAuthnPolicies"></a>Requirements for using authentication policies

|Policy|Requirements|
|----------|----------------|
|Provide custom TGT lifetimes| Windows Server 2012 R2  domain functional level account domains|
|Restrict user sign-on|-    Windows Server 2012 R2  domain functional level account domains with Dynamic Access Control support<br />-   Windows 8, Windows 8.1,  Windows Server 2012  or  Windows Server 2012 R2  devices with Dynamic Access Control support|
|Restrict service ticket issuance that is based on user account and security groups| Windows Server 2012 R2  domain functional level resource domains|
|Restrict service ticket issuance based on user claims or device account, security groups, or claims| Windows Server 2012 R2  domain functional level resource domains with Dynamic Access Control support|

### Restrict a user account to specific devices and hosts
A high-value account with administrative privilege should be a member of the **Protected Users** group. By default, no accounts are members of the **Protected Users** group. Before you add accounts to the group, configure domain controller support and create an audit policy to ensure that there are no blocking issues.

#### Configure domain controller support

The user's account domain must be at  Windows Server 2012 R2  domain functional level (DFL). Ensure all the domain controllers are  Windows Server 2012 R2 , and then use Active Directory Domains and Trusts to [raise the DFL](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753104(v=ws.11)) to  Windows Server 2012 R2 .

**To configure support for Dynamic Access Control**

1.  In the Default Domain Controllers Policy, click **Enabled** to enable **Key Distribution Center (KDC) client support for claims, compound authentication and Kerberos armoring** in Computer Configuration | Administrative Templates | System | KDC.

    ![Screenshot that highlights the Enabled option.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_EnableKDCClaims.gif)

2.  Under **Options**, in the drop-down list box, select **Always provide claims**.

    > [!NOTE]
    > **Supported** can also be configured, but because the domain is at  Windows Server 2012 R2  DFL, having the DCs always provide claims will allow user claims-based access checks to occur when using non-claims aware devices and hosts to connect to claims-aware services.

    ![Screenshot that highlights the Always provide claim menu option.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_AlwaysProvideClaims.png)

    > [!WARNING]
    > Configuring **Fail unarmored authentication requests** will result in authentication failures from any operating system which does not support Kerberos armoring, such as  Windows 7  and previous operating systems, or operating systems beginning with Windows 8, which have not been explicitly configured to support it.

#### Create a user account audit for authentication policy with ADAC

1.  Open Active Directory Administrative Center (ADAC).

    ![Screenshot that shows the Authentication page.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_OpenADAC.gif)

    > [!NOTE]
    > The selected **Authentication** node is visible for domains which are at  Windows Server 2012 R2  DFL. If the node does not appear, then try again by using a domain administrator account from a domain that is at  Windows Server 2012 R2  DFL.

2.  Click **Authentication Policies**, and then click **New** to create a new policy.

    ![Screenshot that shows how to create a new policy.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_NewAuthNPolicy.gif)

    Authentications Policies must have a display name and are enforced by default.

3.  To create an audit-only policy, click **Only audit policy restrictions**.

    ![Screenshot that highlights the Only audit policy restrictions option.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_NewAuthNPolicyAuditOnly.gif)

    Authentication policies are applied based on the Active Directory account type. A single policy can apply to all three account types by configuring settings for each type. Account types are:

    -   User

    -   Computer

    -   Managed Service Account and Group Managed Service Account

    If you have extended the schema with new principals that can be used by the Key Distribution Center (KDC), then the new account type is classified from the closest derived account type.

4.  To configure a TGT lifetime for user accounts, select the **Specify a Ticket-Granting Ticket lifetime for user accounts** check box and enter the time in minutes.

    ![Screenshot that highlights the Specify a Ticket-Granting Ticket lifetime for user accounts check box.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_TGTLifetime.gif)

    For example, if you want a 10-hour maximum TGT lifetime, enter **600** as shown. If no TGT lifetime is configured, then if the account is a member of the **Protected Users** group, the TGT lifetime and renewal is 4 hours. Otherwise, TGT lifetime and renewal are based on the domain policy as seen in the following Group Policy Management Editor window for a domain with default settings.

    ![Screenshot that shows the default policy settings.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_TGTExpiration.png)

5.  To restrict the user account to select devices, click **Edit** to define the conditions that are required for the device.

    ![Screenshot that shows how to restrict the user account to select devices.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_EditAuthNPolicy.gif)

6.  In the **Edit Access Control Conditions** window, click **Add a condition**.

    ![Screenshot that highlights Add a condition.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_AddCondition.png)

##### Add computer account or group conditions

1.  To configure computer accounts or groups, in the drop-down list, select the drop-down list box **Member of each** and change to **Member of any**.

    ![Screenshot that highlights the Member of each list box.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_AddCompMember.png)

    > [!NOTE]
    > This access control defines the conditions of the device or host from which the user signs on. In access control terminology, the computer account for the device or host is the user, which is why **User** is the only option.

2.  Click **Add items**.

    ![Screenshot that highlights the Add items button.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_AddCompAddItems.png)

3.  To change object types, click **Object Types**.

    ![Screenshot that highlights the Object Types button.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_ChangeObjects.gif)

4.  To select computer objects in Active Directory, click **Computers**, and then click **OK**.

    ![Screenshot that highlights the Computers check box.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_ChangeObjectsComputers.gif)

5.  Type the name of the computers to restrict the user, and then click **Check Names**.

    ![Screenshot that highlights Check Names.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_ChangeObjectsCompName.gif)

6.  Click OK and create any other conditions for the computer account.

    ![Screenshot that shows how to edit access control conditions.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_AddCompAddConditions.png)

7.  When done, then click **OK** and the defined conditions will appear for the computer account.

    ![Screenshot that shows where to select OK when you're finished.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_AddCompDone.png)

##### Add computer claim conditions

1.  To configure computer claims, drop-down Group to select the claim.

    ![Screenshot that shows where to select the group.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_CompClaim.gif)

    Claims are only available if they are already provisioned in the forest.

2.  Type the name of OU, the user account should be restricted to sign on.

    ![Screenshot that shows where to type the name.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_CompClaimOUName.gif)

3.  When done, then click OK and the box will show the conditions defined.

    ![Screenshot that shows the defined conditions.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_CompClaimComplete.gif)

##### Troubleshoot missing computer claims
If the claim has been provisioned, but is not available, it might only be configured for **Computer** classes.

Let's say you wanted to restrict authentication based on the organizational unit (OU) of the computer, which was already configured, but only for **Computer** classes.

![Screenshot that highlights the Computer check box.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_RestrictComputers.gif)

For the claim to be available to restrict User sign-on to the device, select the **User** check box.

![Screenshot that highlights the User check box.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_RestrictUsersComputers.gif)

#### Provision a user account with an authentication policy with ADAC

1.  From the **User** account, click **Policy**.

    ![Screenshot that shows where to select Policy.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_UserPolicy.gif)

2.  Select the **Assign an authentication policy to this account** check box.

    ![Screenshot that highlights the Assign an authentication policy to this account check box.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_UserPolicyAssign.gif)

3.  Then select the authentication policy to apply to the user.

    ![Screenshot that shows where to select the authentication policy to apply.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_UserPolicySelect.png)

#### Configure Dynamic Access Control support on devices and hosts
You can configure TGT lifetimes without configuring Dynamic Access Control (DAC). DAC is only needed for checking AllowedToAuthenticateFrom and AllowedToAuthenticateTo.

Using either Group Policy or Local Group Policy Editor, enable **Kerberos client support for claims, compound authentication and Kerberos armoring** in Computer Configuration | Administrative Templates | System | Kerberos:

![Screenshot that shows where to select the Enabled option.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_KerbClientDACSupport.gif)

### <a name="BKMK_TroubleshootAuthnPolicies"></a>Troubleshoot Authentication Policies

#### Determine the accounts that are directly assigned an Authentication Policy
The accounts section in the Authentication Policy shows the accounts that have directly applied the policy.

![Screenshot that shows how to determine the accounts that are directly assigned an Authentication Policy.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_AccountsAssigned.gif)

#### Use the Authentication Policy Failures - Domain Controller administrative log
A new **Authentication Policy Failures - Domain Controller** administrative log under **Applications and Services Logs** > **Microsoft** > **Windows** > **Authentication** has been created to make it easier to discover failures due to Authentication Policies. The log is disabled by default. To enable it, right-click the log name and click **Enable Log**. The new events are very similar in content to the existing Kerberos TGT and service ticket auditing events. For more information about these events, see [Authentication Policies and Authentication Policy Silos](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn486813(v=ws.11)).

### <a name="BKMK_ManageAuthnPoliciesUsingPSH"></a>Manage authentication policies by using Windows PowerShell
This command creates an authentication policy named **TestAuthenticationPolicy**. The **UserAllowedToAuthenticateFrom** parameter specifies the devices from which users can authenticate by an SDDL string in the file named someFile.txt.

```
PS C:\> New-ADAuthenticationPolicy testAuthenticationPolicy -UserAllowedToAuthenticateFrom (Get-Acl .\someFile.txt).sddl
```

This command gets all authentication policies that match the filter that the **Filter** parameter specifies.

```
PS C:\> Get-ADAuthenticationPolicy -Filter "Name -like 'testADAuthenticationPolicy*'" -Server Server02.Contoso.com

```

This command modifies the description and the **UserTGTLifetimeMins** properties of the specified authentication policy.

```
PS C:\> Set-ADAuthenticationPolicy -Identity ADAuthenticationPolicy1 -Description "Description" -UserTGTLifetimeMins 45
```

This command removes the authentication policy that the **Identity** parameter specifies.

```
PS C:\> Remove-ADAuthenticationPolicy -Identity ADAuthenticationPolicy1
```

This command uses the **Get-ADAuthenticationPolicy** cmdlet with the **Filter** parameter to get all authentication policies that are not enforced. The result set is piped to the **Remove-ADAuthenticationPolicy** cmdlet.

```
PS C:\> Get-ADAuthenticationPolicy -Filter 'Enforce -eq $false' | Remove-ADAuthenticationPolicy
```

## <a name="BKMK_CreateAuthNPolicySilos"></a>Authentication policy silos
Authentication Policy Silos is a new container (objectClass msDS-AuthNPolicySilos) in AD DS for user, computer, and service accounts. They help protect high-value accounts. While all organizations need to protect members of Enterprise Admins, Domain Admins and Schema Admins groups because those accounts could be used by an attacker to access anything in the forest, other accounts may also need protection.

Some organizations isolate workloads by creating accounts that are unique to them and by applying Group Policy settings to limit local and remote interactive logon and administrative privileges. Authentication policy silos complement this work by creating a way to define a relationship between User, Computer and managed Service accounts. Accounts can only belong to one silo. You can configure authentication policy for each type of account in order to control:

1.  Non-renewable TGT lifetime

2.  Access control conditions for returning TGT (Note: cannot apply to systems because Kerberos armoring is required)

3.  Access control conditions for returning service ticket

Additionally, accounts in an authentication policy silo have a silo claim, which can be used by claims-aware resources such as file servers to control access.

A new security descriptor can be configured to control issuing service ticket based on:

-   User, user's security groups, and/or user's claims

-   Device, device's security group, and/or device's claims

Getting this information to the resource's DCs requires Dynamic Access Control:

-   User claims:

    -   Windows 8 and later clients supporting Dynamic Access Control

    -   Account domain supports Dynamic Access Control and claims

-   Device and/or device security group:

    -   Windows 8 and later clients supporting Dynamic Access Control

    -   Resource configured for compound authentication

-   Device claims:

    -   Windows 8 and later clients supporting Dynamic Access Control

    -   Device domain supports Dynamic Access Control and claims

    -   Resource configured for compound authentication

Authentication policies can be applied to all members of an authentication policy silo instead of to individual accounts, or separate authentication policies can be applied to different types of accounts within a silo. For example, one authentication policy can be applied to highly privileged user accounts, and a different policy can be applied to services accounts. At least one authentication policy must be created before an authentication policy silo can be created.

> [!NOTE]
> An authentication policy can be applied to members of an authentication policy silo, or it can be applied independently of silos to restrict specific account scope. For example, to protect a single account or a small set of accounts, a policy can be set on those accounts without adding the accounts to a silo.

You can create an authentication policy silo by using Active Directory Administrative Center or Windows PowerShell. By default, an authentication policy silo only audits silo policies, which is equivalent to specifying the **WhatIf** parameter in Windows PowerShell cmdlets. In this case, policy silo restrictions do not apply, but audits are generated to indicate whether failures occur if the restrictions are applied.

#### To create an authentication policy silo by using Active Directory Administrative Center

1.  Open **Active Directory Administrative Center**, click **Authentication**, right-click **Authentication Policy Silos**, click **New**, and then click **Authentication Policy Silo**.

    ![protected accounts](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_CreateNewAuthNPolicySilo.gif)

2.  In **Display name**, type a name for the silo. In **Permitted Accounts**, click **Add**, type the names of the accounts, and then click **OK**. You can specify users, computers, or service accounts. Then specify whether to use a single policy for all principals or a separate policy for each type of principal, and the name of the policy or policies.

    ![Screenshot that shows how to add a permitted account.](media/How-to-Configure-Protected-Accounts/ADDS_ProtectAcct_NewAuthNPolicySiloDisplayName.gif)

### <a name="BKMK_ManageAuthnSilosUsingPSH"></a>Manage authentication policy silos by using Windows PowerShell
This command creates an authentication policy silo object and enforces it.

```
PS C:\>New-ADAuthenticationPolicySilo -Name newSilo -Enforce
```

This command gets all the authentication policy silos that match the filter that is specified by the **Filter** parameter. The output is then passed to the **Format-Table** cmdlet to display the name of the policy and the value for **Enforce** on each policy.

```
PS C:\>Get-ADAuthenticationPolicySilo -Filter 'Name -like "*silo*"' | Format-Table Name, Enforce -AutoSize

Name  Enforce
----  -------
silo     True
silos   False

```

This command uses the **Get-ADAuthenticationPolicySilo** cmdlet with the **Filter** parameter to get all authentication policy silos that are not enforced and pipe the result of the filter to the **Remove-ADAuthenticationPolicySilo** cmdlet.

```
PS C:\>Get-ADAuthenticationPolicySilo -Filter 'Enforce -eq $False' | Remove-ADAuthenticationPolicySilo
```

This command grants access to the authentication policy silo named *Silo* to the user account named *User01*.

```
PS C:\>Grant-ADAuthenticationPolicySiloAccess -Identity Silo -Account User01
```

This command revokes access to the authentication policy silo named *Silo* for the user account named *User01*. Because the **Confirm** parameter is set to **$False**, no confirmation message appears.

```
PS C:\>Revoke-ADAuthenticationPolicySiloAccess -Identity Silo -Account User01 -Confirm:$False
```

This example first uses the **Get-ADComputer** cmdlet to get all computer accounts that match the filter that the **Filter** parameter specifies. The output of this command is passed to **Set-ADAccountAuthenticatinPolicySilo** to assign the authentication policy silo named *Silo* and the authentication policy named *AuthenticationPolicy02* to them.

```
PS C:\>Get-ADComputer -Filter 'Name -like "newComputer*"' | Set-ADAccountAuthenticationPolicySilo -AuthenticationPolicySilo Silo -AuthenticationPolicy AuthenticationPolicy02
```
