---
ms.assetid: 934ac796-e2ee-490d-8265-6a818be5ee79
title: Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications




-   [Set up the lab environment for AD FS in Windows Server 2012 R2](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md)

-   [Walkthrough Guide: Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md)

-   [Configure Additional Authentication Methods for AD FS](../../ad-fs/operations/Configure-Additional-Authentication-Methods-for-AD-FS.md)

## In this guide
This guide provides the following information:

-   [Authentication mechanisms in AD FS](../../ad-fs/operations/Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md#BKMK_1) - description of the authentication mechanisms available in Active Directory Federation Services (AD FS) in Windows Server 2012 R2

-   [Scenario Overview](../../ad-fs/operations/Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md#BKMK_2) - a description of a scenario where you use Active Directory Federation Services (AD FS) to enable multifactor authentication (MFA) based on user's group membership.

    > [!NOTE]
    > In AD FS in Windows Server 2012 R2 you can enable MFA based on the network location, device identity, and user identity or group membership.

    For detailed step-by-step walkthrough instructions for configuring and verifying this scenario, see [Walkthrough Guide: Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](../../ad-fs/operations/Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md).

## <a name="BKMK_1"></a>Key Concepts - Authentication mechanisms in AD FS

### Benefits of authentication mechanisms in AD   FS
Active Directory Federation Services (AD FS) in Windows Server 2012 R2 provides IT administrators with a richer, more flexible set of tools for authenticating users who want to access corporate resources. It empowers administrators with flexible control over the primary and the additional authentication methods, provides a rich management experience for configuring authentication polices (both through the user interface and Windows PowerShell), and enhances the experience for the end users that access applications and services that are secured by AD FS. The following are some of the benefits of securing your application and services with AD FS in Windows Server 2012 R2:

-   Global authentication policy - a central management capability, from which an IT administrator can choose what authentication methods are used to authenticate users based on the network location from which they access protected resources. This enables administrators to do the following:

    -   Mandate the use of more secure authentication methods for access requests from the extranet.

    -   Enable device authentication for seamless second-factor authentication. This ties the user's identity to the registered device that is used to access the resource, thus offering more secure compound identity verification before protected resources are accessed.

        > [!NOTE]
        > For more information about device object, Device Registration Service, Workplace Join, and the device as seamless second-factor authentication and SSO, see [Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](Join-to-Workplace-from-Any-Device-for-SSO-and-Seamless-Second-Factor-Authentication-Across-Company-Applications.md).

    -   Set MFA requirement for all extranet access or conditionally based on the user's identity, network location or a device that is used to access protected resources.

-   Greater flexibility in configuring authentication policies: you can configure custom authentication policies for AD FS-secured resources with varying business values. For example, you can require MFA for application with high business impact.

-   Ease of use: simple and intuitive management tools such as the GUI-based AD FS Management MMC snap-in and the Windows PowerShell cmdlets enable IT administrators to configure authentication policies with relative ease. With Windows PowerShell, you can script your solutions for use at scale and to automate mundane administrative tasks.

-   Greater control over corporate assets: since as an administrator you can use AD FS to configure an authentication policy that applies to a specific resource, you have greater control over how corporate resources are secured. Applications cannot override the authentication policies specified by IT administrators. For sensitive applications and services, you can enable MFA requirement, device authentication, and optionally fresh authentication every time the resource is accessed.

-   Support for custom MFA providers: for organizations that leverage third-party MFA methods, AD FS offers the ability to incorporate and use these authentication methods seamlessly.

### Authentication scope
In AD FS in Windows Server 2012 R2 you can specify an authentication policy at a global scope that is applicable to all applications and services that are secured by AD FS.  You can also set authentication policies for specific applications and services (relying party trusts) that are secured by AD FS. Specifying an authentication policy for a particular application (per relying party trust) does not override the global authentication policy. If either global or per relying party trust authentication policy requires MFA, MFA will be triggered when the user tries to authenticate to this relying party trust.  The global authentication policy is a fallback for relying party trusts (applications and services) that do not have a specific authentication policy configured.

A global authentication policy applies to all relying parties that are secured by AD FS. You can configure the following settings as part of the global authentication policy:

-   Authentication methods to be used for primary authentication

-   Settings and methods for MFA

-   Whether device authentication is enabled. For more information, see [Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](../../ad-fs/operations/Join-to-Workplace-from-Any-Device-for-SSO-and-Seamless-Second-Factor-Authentication-Across-Company-Applications.md).

Per-relying party trust authentication policies apply specifically to attempts to access that relying party trust (application or service). You can configure the following settings as part of the per-relying party trust authentication policy:

-   Whether users are required to provide their credentials each time at sign-in

-   MFA settings based on the user/group, device registration, and access request location data

### Primary and additional authentication methods
With AD FS in Windows Server 2012 R2, in addition to the primary authentication mechanism, administrators can configure additional authentication methods. Primary authentication methods are built-in and are intended to validate users' identities. You can configure additional authentication factors to request that more information about the user's identity is provided and consequently ensure stronger authentication.

With primary authentication in AD FS in Windows Server 2012 R2, you have the following options:

-   For resources published to be accessed from outside the corporate network, Forms Authentication is selected by default. In addition, you can also enable Certificate Authentication (in other words, smart card-based authentication or user client certificate authentication that works with AD DS).

-   For intranet resources, Windows Authentication is selected by default. In addition you can also enable Forms and/or Certificate Authentication.

By selecting more than one authentication method, you enable your users to have a choice of what method to authenticate with at the sign-in page for your application or service.

You can also enable device authentication for seamless second-factor authentication. This ties the user's identity to the registered device that is used to access the resource, thus offering more secure compound identity verification before protected resources are accessed.

> [!NOTE]
> For more information about device object, Device Registration Service, Workplace Join, and the device as seamless second-factor authentication and SSO, see [Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](../../ad-fs/operations/Join-to-Workplace-from-Any-Device-for-SSO-and-Seamless-Second-Factor-Authentication-Across-Company-Applications.md).

If you specify Windows Authentication method (default option) for your intranet resources, authentication requests undergo this method seamlessly on browsers that support Windows authentication.

> [!NOTE]
> Windows authentication is not supported on all browsers. The authentication mechanism in AD FS in Windows Server 2012 R2 detects the user's browser user agent and uses a configurable setting to determine whether that user agent supports Windows Authentication. Administrators can add to this list of user agents (via the Windows PowerShell `Set-AdfsProperties -WIASupportedUserAgents` command, in order to specify alternate user agent strings for browsers that support Windows Authentication. If the client's user agent does not support Windows Authentication, the default fallback method is Forms Authentication.

### Configuring MFA
There are two parts to configure MFA in AD FS in Windows Server 2012 R2: specifying the conditions under which MFA is required, and selecting an additional authentication method. For more information about additional authentication methods, see [Configure Additional Authentication Methods for AD FS](../../ad-fs/operations/Configure-Additional-Authentication-Methods-for-AD-FS.md).

**MFA settings**

The following options are available for MFA settings (conditions under which to require MFA):

-   You can require MFA for specific users and groups in the AD domain that your federation server is joined to.

-   You can require MFA for either registered (workplace joined) or unregistered (not workplace joined) devices.

    Windows Server 2012 R2 takes a user-centric approach to modern devices where device objects represent a relationship between user@device and a company. Device objects are a new class in AD in Windows Server 2012 R2 that can be used to offer compound-identity when providing access to applications and services. A new component of AD FS - the device registration service (DRS) - provisions a device identity in Active Directory and sets a certificate on the consumer device that will be used to represent the device identity. You can then use this device identity to workplace join your device, in other words, to connect your personal device to the Active Directory of your workplace. When you join your personal device to your workplace, it becomes a known device and will provide seamless second-factor authentication to protected resources and applications. In other words, after a device is workplace joined, the user's identity is tied to this device and can be used for a seamless compound identity verification before a protected resource is accessed.

    For more information on workplace join and leave, see [Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](../../ad-fs/operations/Join-to-Workplace-from-Any-Device-for-SSO-and-Seamless-Second-Factor-Authentication-Across-Company-Applications.md).

-   You can require MFA when the access request for the protected resources comes from either the extranet or the intranet.

## <a name="BKMK_2"></a>Scenario Overview
In this scenario, you enable MFA based on the user's group membership data for a specific application. In other words, you will set up an authentication policy on your federation server to require MFA when users that belong to a certain group request access to a specific application that is hosted on a web server.

More specifically, in this scenario, you enable an authentication policy for a claims-based test application called **claimapp**, whereby an AD user **Robert Hatley** will be required to undergo MFA since he belongs to an AD group **Finance**.

The step-by step instructions to set up and verify this scenario are provided in [Walkthrough Guide: Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md). In order to complete the steps in this walkthrough, you must set up a lab environment and follow the steps in [Set up the lab environment for AD FS in Windows Server 2012 R2](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md).

Other scenarios of enabling MFA in AD FS include the following:

-   Enable MFA, if the access request comes from the extranet. You can modify the code presented in the "Set up MFA Policy" section of [Walkthrough Guide: Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md) with the following:

    ```
    'c:[type == "https://schemas.microsoft.com/ws/2012/01/insidecorporatenetwork", value == "false"] => issue(type="https://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod", value = "https://schemas.microsoft.com/claims/multipleauthn" );'
    ```

-   Enable MFA, if the access request comes from a non-workplace joined device.  You can modify the code presented in the "Set up MFA Policy" section of [Walkthrough Guide: Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md) with the following:

    ```
    'NOT EXISTS([type=="https://schemas.microsoft.com/2012/01/devicecontext/claims/registrationid"]) => issue (type="https://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod", value = "https://schemas.microsoft.com/claims/multipleauthn");'

    ```

-   Enable MFA, if the access is coming from a user with a device that is workplace joined but not registered to this user. You can modify the code presented in the "Set up MFA Policy" section of [Walkthrough Guide: Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md) with the following:

    ```
    'c:[type=="https://schemas.microsoft.com/2012/01/devicecontext/claims/isregistereduser", value == "false"] => issue (type="https://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod", value = "https://schemas.microsoft.com/claims/multipleauthn");'

    ```

## See Also
[Walkthrough Guide: Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md)
[Set up the lab environment for AD FS in Windows Server 2012 R2](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md)



