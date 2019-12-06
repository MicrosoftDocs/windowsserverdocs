---
ms.assetid: a0f7bb11-47a5-47ff-a70c-9e6353382b39
title: Manage Risk with Conditional Access Control
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Manage Risk with Conditional Access Control




-   [Key concepts-conditional access control in AD FS](../../ad-fs/operations/Manage-Risk-with-Conditional-Access-Control.md#BKMK_1)

-   [Managing Risk with Conditional Access Control](../../ad-fs/operations/Manage-Risk-with-Conditional-Access-Control.md#BKMK_2)

## <a name="BKMK_1"></a>Key concepts - conditional access control in AD FS
The overall function of AD FS is to issue an access token that contains a set of claims. The decision regarding what claims AD FS accepts and then issues is governed by claim rules.

Access control in AD FS is implemented with issuance authorization claim rules that are used to issue a permit or deny claims that will determine whether a user or a group of users will be allowed to access AD FS-secured resources or not. Authorization rules can only be set on relying party trusts.

|Rule option|Rule logic|
|---------------|--------------|
|Permit all users|If incoming claim type equals *any claim type* and value equals *any value*, then issue claim with value equals *Permit*|
|Permit access to users with this incoming claim|If incoming claim type equals *specified claim type* and value equals *specified claim value*, then issue claim with value equals *Permit*|
|Deny access to users with this incoming claim|If incoming claim type equals *specified claim type* and value equals *specified claim value*, then issue claim with value equals *Deny*|

For more information about these rule options and logic, see [When to Use an Authorization Claim Rule](https://technet.microsoft.com/library/ee913560.aspx).

In AD FS in Windows Server 2012 R2, access control is enhanced with multiple factors, including user, device, location, and authentication data. This is made possible by a greater variety of claim types available for the authorization claim rules.  In other words, in AD FS in Windows Server 2012 R2, you can enforce conditional access control based on user identity or group membership, network location, device (whether it is workplace joined, for more information, see [Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](../../ad-fs/operations/Join-to-Workplace-from-Any-Device-for-SSO-and-Seamless-Second-Factor-Authentication-Across-Company-Applications.md)), and the authentication state (whether multifactor authentication (MFA) was performed ).

Conditional access control in AD FS in Windows Server 2012 R2, offers the following benefits:

-   Flexible and expressive per-application authorization policies, whereby you can permit or deny access based on user, device, network location, and authentication state

-   Creating issuance authorization rules for relying party applications

-   Rich UI experience for the common conditional access control scenarios

-   Rich claims language & Windows PowerShell support for advanced conditional access control scenarios

-   Custom (per relying party application) 'Access Denied' messages. For more information, see [Customizing the AD FS Sign-in Pages](https://technet.microsoft.com/library/dn280950.aspx). By being able to customize these messages, you can explain why a user is being denied access and also facilitate self-service remediation where it is possible, for example, prompt users to workplace join their devices. For more information, see [Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](../../ad-fs/operations/Join-to-Workplace-from-Any-Device-for-SSO-and-Seamless-Second-Factor-Authentication-Across-Company-Applications.md).

The following table includes all the claim types available in AD FS in Windows Server 2012 R2 to be used for implementing conditional access control.

|Claim type|Description|
|--------------|---------------|
|Email Address|The email address of the user.|
|Given Name|The given name of the user.|
|Name|The unique name of the user,|
|UPN|The user principal name (UPN) of the user.|
|Common Name|The common name of the user.|
|AD FS 1 x E-mail Address|The email address of the user when interoperating with AD FS 1.1 or AD FS 1.0.|
|Group|A group that the user is a member of.|
|AD FS 1 x UPN|The UPN of the user when interoperating with AD FS 1.1 or AD FS 1.0.|
|Role|A role that the user has.|
|Surname|The surname of the user.|
|PPID|The private identifier of the user.|
|Name ID|The SAML name identifier of the user.|
|Authentication time stamp|Used to display the time and date that the user was authenticated.|
|Authentication method|The method used to authenticate the user.|
|Deny only group SID|The deny-only group SID of the user.|
|Deny only primary SID|The deny-only primary SID of the user.|
|Deny only primary group SID|The deny-only primary group SID of the user.|
|Group SID|The group SID of the user.|
|Primary group SID|The primary group SID of the user.|
|Primary SID|The primary SID of the user.|
|Windows account name|The domain account name of the user in the form of domain\user.|
|Is Registered User|User is registered to use this device.|
|Device Identifier|Identifier of the device.|
|Device Registration Identifier|Identifier for Device Registration.|
|Device Registration Display Name|Display name of Device Registration.|
|Device OS Type|Operating system type of the device.|
|Device OS Version|Operating system version of the device.|
|Is Managed Device|Device is managed by a management service.|
|Forwarded Client IP|IP address of the user.|
|Client Application|Type of the client application.|
|Client User Agent|Device type the client is using to access the application.|
|Client IP|IP address of the client.|
|Endpoint Path|Absolute Endpoint path which can be used to determine active versus passive clients.|
|Proxy|DNS name of the federation server proxy that passed the request.|
|Application Identifier|Identifier for the relying party.|
|Application policies|Application policies of the certificate.|
|Authority Key Identifier|The authority key identifier extension of the certificate that signed an issued certificate.|
|Basic Constraint|One of the basic constraints of the certificate.|
|Enhanced Key Usage|Describes one of the enhanced key usages of the certificate.|
|Issuer|The name of the certification authority that issued the X.509 certificate.|
|Issuer Name|The distinguished name of the certificate issuer.|
|Key Usage|One of the key usages of the certificate.|
|Not After|Date in local time after which a certificate is no longer valid.|
|Not Before|The date in local time on which a certificate becomes valid.|
|Certificate Policies|The policies under which the certificate has been issued.|
|Public Key|Public key of the certificate.|
|Certificate Raw Data|The raw data of the certificate.|
|Subject Alternative Name|One of the alternative names of the certificate.|
|Serial Number|The serial number of the certificate.|
|Signature Algorithm|The algorithm used to create the signature of a certificate.|
|Subject|The subject from the certificate.|
|Subject Key Identifier|The subject key identifier of the certificate.|
|Subject Name|The subject distinguished name from a certificate.|
|V2 Template Name|The name of the version 2 certificate template used wen issuing or renewing a certificate. This is a Microsoft-specific value.|
|V1 Template Name|The name of the version 1 certificate template used when issuing or renewing a certificate. This is a Microsoft-specific value.|
|Thumbprint|Thumbprint of the certificate.|
|X 509 Version|The X.509 format version of the certificate.|
|Inside Corporate Network|Used to indicate if a request originated from inside the corporate network.|
|Password Expiration Time|Used to display the time when the password expires.|
|Password Expiration Days|Used to display the number of days to password expiry.|
|Update Password URL|Used to display the web address of update password service.|
|Authentication Methods References|Used to indicate al authentication methods used to authenticate the user.|

## <a name="BKMK_2"></a>Managing Risk with Conditional Access Control
Using the available settings, there are many ways in which you can manage risk by implementing conditional access control.

### Common Scenarios
For example, imagine a simple scenario of implementing conditional access control based on the user's group membership data for a particular application (relying party trust). In other words, you can set up an issuance authorization rule on your federation server to permit users that belong to a certain group in your AD domain access to a particular application that is secured by AD FS.  The detailed step by step instructions (using the UI and Windows PowerShell) for implementing this scenario are covered in [Walkthrough Guide: Manage Risk with Conditional Access Control](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Conditional-Access-Control.md). In order to complete the steps in this walkthrough, you must set up a lab environment and follow the steps in [Set up the lab environment for AD FS in Windows Server 2012 R2](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md).

### Advanced Scenarios
Other examples of implementing conditional access control in AD FS in Windows Server 2012 R2 include the following:

-   Permit access to an application secured by AD FS only if this user's identity was validated with MFA

    You can use the following code:

    ```
    @RuleTemplate = "Authorization"
    @RuleName = "PermitAccessWithMFA"
    c:[Type == "https://schemas.microsoft.com/claims/authnmethodsreferences", Value =~ "^(?i)https://schemas\.microsoft\.com/claims/multipleauthn$"] => issue(Type = "https://schemas.microsoft.com/authorization/claims/permit", Value = "PermitUsersWithClaim");

    ```

-   Permit access to an application secured by AD FS only if the access request is coming from a workplace joined device that is registered to the user

    You can use the following code:

    ```
    @RuleTemplate = "Authorization"
    @RuleName = "PermitAccessFromRegisteredWorkplaceJoinedDevice"
    c:[Type == "https://schemas.microsoft.com/2012/01/devicecontext/claims/isregistereduser", Value =~ "^(?i)true$"] => issue(Type = "https://schemas.microsoft.com/authorization/claims/permit", Value = "PermitUsersWithClaim");

    ```

-   Permit access to an application secured by AD FS only if the access request is coming from a workplace joined device that is registered to a user whose identity has been validated with MFA

    You can use the following code

    ```
    @RuleTemplate = "Authorization"
    @RuleName = "RequireMFAOnRegisteredWorkplaceJoinedDevice"
    c1:[Type == "https://schemas.microsoft.com/claims/authnmethodsreferences", Value =~ "^(?i)http://schemas\.microsoft\.com/claims/multipleauthn$"] &&
    c2:[Type == "https://schemas.microsoft.com/2012/01/devicecontext/claims/isregistereduser", Value =~ "^(?i)true$"] => issue(Type = "https://schemas.microsoft.com/authorization/claims/permit", Value = "PermitUsersWithClaim");

    ```

-   Permit extranet access to an application secured by AD FS only if the access request is coming from a user whose identity has been validated with MFA.

    You can use the following code:

    ```
    @RuleTemplate = "Authorization"
    @RuleName = "RequireMFAForExtranetAccess"
    c1:[Type == "https://schemas.microsoft.com/claims/authnmethodsreferences", Value =~ "^(?i)http://schemas\.microsoft\.com/claims/multipleauthn$"] &&
    c2:[Type == "https://schemas.microsoft.com/ws/2012/01/insidecorporatenetwork", Value =~ "^(?i)false$"] => issue(Type = "https://schemas.microsoft.com/authorization/claims/permit", Value = "PermitUsersWithClaim");

    ```

## See Also
[Walkthrough Guide: Manage Risk with Conditional Access Control](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Conditional-Access-Control.md)
[Set up the lab environment for AD FS in Windows Server 2012 R2](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md)



