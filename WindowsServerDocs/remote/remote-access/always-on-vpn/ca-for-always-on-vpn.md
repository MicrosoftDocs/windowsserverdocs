---
title: Conditional Access for Always On VPN
description: In previous versions of the Windows VPN architecture, platform limitations made it difficult to provide the critical functionality needed to replace DirectAccess (like automatic connections initiated before users sign in).
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.date: 
ms.assetid: 8fe1c810-4599-4493-b4b8-73fa9aa18535
manager: brianlic
ms.author: pashort
author: shortpatti
---

# Conditional Access for Always On VPN

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10 RS2 (version) 1703 or later

Conditional access is a capability of Azure Active Directory (AD) that enables you to define conditions under which authorized users can access your apps. With Azure AD, you can easily accomplish multi-factor authentication for users accessing a service when they are off the corporate network. In Azure AD, the VPN server is modeled by an Azure AD cloud application with a new service principal with the DisplayName of **VPN Server**. The VPN Server cloud application is created when you create the first root certificate in the **VPN Connectivity** blade. You can create multiple certificates to handle expiration dates to avoid outages. However, only one certificate can be marked as **primary**. 

After a **primary** certificate is created, you must link a conditional access policy to the **VPN Server** cloud application. By using conditional access policies, you can apply the right access controls under the required conditions. Azure AD conditional access provides you with added security when needed and stays out of your user’s way when it isn’t.

For the Always On VPN clients to request a client access token from the VPN server cloud application, you must deploy [VPNv2 profiles](https://docs.microsoft.com/en-us/windows/client-management/mdm/vpnv2-csp#examples). The VPNv2 profiles are based Open Mobile Alliance (OMA) Device Management (DM),
via Mobile Device Management (MDM).

<!-- 
To configure conditional access for VPN connectivity, you need to complete the following steps:

1.  Configure your VPN server. This step configures root certificates for VPN authentication with Azure AD.

2.  Configure your VPN client.

3.  Configure your conditional access policy.

-->

## Authentiction flow

The authentication process happens when a device compliance-enabled VPN connection profile is triggered either manually or automatically.

![Authentication Flow](media/3b94a9d784e50411a148f8d1f3fc3314.png)

Authentication Flow

1.  Always On VPN containing `<DeviceCompliance> <Enabled>true</Enabled>` in the VPNv2 profile tells the VPN client to retrieve the user's Primary Refresh Token (PRT) by issuing a `gettoken()` API call to Web Account Manager (WAM) (aka: Token Broker) service.

2.  The WAM authenticates to Azure AD by making a WebRequest call to the **VPN Server** cloud application in Azure AD in an attempt to get an access token for the user. It does this by providing the PRT and other information about the device that is trying to connect.<br>A device check is performed by Azure AD to determine whether the device complies with the VPN policy.

    | If the device is... | Then...                                                                                                        |
    |---------------------|----------------------------------------------------------------------------------------------------------------|
    | Compliant           | Azure AD requests a token from Azure AD certificate authority.                                                 |
    | NOT compliant       | remediation steps are preformed \@Reviewer, where are these steps and who does them? can the customer do this? |

3.  After Azure AD receives a token from Azure AD certificate authority, Azure pushes a short-lived (1-hour) certificate to the user's certificate store (certmgr.msc) via the WAM. The certificated that is short-lived is signed by the root certificate that was marked as Primary in the **VPN connectivity** blade.<br>The WAM returns control over to the VPN client for further connection processing.

4.  The VPN client retrieves the Azure AD-issued certificate from the user's personal Certificate Store by selecting the certificate containing the `<EKUName>AAD Conditional Access</EKUName>` and `<EKUOID>1.3.6.1.4.1.311.87</EKUOID>` values defined in the section of the VPNv2 profile.<br>The VPN client passes this certificate to the VPN server where it is verified to chain correctly to the 'primary' certificate that was downloaded from the 'VPN connectivity' blade and added to the Trusted Root Certificate Store of the on-premises RADIUS (VPN) server and the Windows 10 clients.

## Features and requirements
 

### Servers

### Clients
The remote client computers must be joined to the Active Directory domain and is running the Windows 10 Anniversary Update version 1607 or later.

### VPNv2 profile
The VPNv2 profile must contain:
•	An entry of `<DeviceCompliance> true</Enabled>`, which tells the VPN client to request an Azure AD (AAD) Certificate.
•	Gateway enforcement, or VPN client certificate filtering using the `<TLSExtension>`, which contains `<EKUName>AAD Conditional Access</EKUName>` and `<EKUOID>1.3.6.1.4.1.311.87</EKUOID>`. The Object Identifier (OID) filter tells the VPN client which certificate in the user's store should be used.
•	The `<TrustedRootCA>5a 89 fe cb 5b 49 a7 0b 1a 52 63 b7 35 ee d7 1c c2 68 be 4b </TrustedRootCA>` entry must contain the Thumbprint of the Root Certificate Authority at the top of the chain of the Server Authentication certificate. Additional root certificates can be added by adding additional `<TrustedRootCA></TrustedRootCA>` entries. If the CA that issued the Server Authentication certificate was an Intermediate authority, this is not the certificate thumbprint to use. It must be the root CA. This should not contain the thumbprint of the cloud root certificates


## Next steps

| If you...                                                              | Then see...                                                                                                                                                                   |
|------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Want to start planning your deployment                                 | [Conditional Access for Always On VPN Planning](ca-for-vpn-planning.md)                                                                                                       |
| Want to know more about Conditions                                     | [Conditions in Azure Active Directory conditional access](https://docs.microsoft.com/en-us/azure/active-directory/active-directory-conditional-access-conditions)             |
| Want to know more about Access controls                                | [Access controls in Azure Active Directory conditional access](https://docs.microsoft.com/en-us/azure/active-directory/active-directory-conditional-access-controls)          |
| Get experience with configuring conditional access                     | [Get started with Role-Based Access Control in the Azure portal](https://docs.microsoft.com/en-us/azure/active-directory/role-based-access-control-what-is)                   |
| Are ready to configure conditional access policies in your environment | [Best practices for conditional access in Azure Active Directory](https://docs.microsoft.com/en-us/azure/active-directory/active-directory-conditional-access-best-practices) |
