---
title: Extending Modern Experiences and Single Sign On across Company Apps on Windows with Azure Active Directory Join
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e7e9e7b5-de7f-4857-a247-0fb532a25350
robots: noindex,nofollow
---
# Extending Modern Experiences and Single Sign On across Company Apps on Windows with Azure Active Directory Join
**This is preliminary content and subject to change.**

## Overview
The Windows experience today for corporate\-domain\- joined machines is that all of its modern capabilities rely solely on personally\-owned Microsoft accounts, which don’t address organizations’ compliance and management requirements.

Organizationally\-owned accounts do not participate in the following modern experiences:

-   On domain joined machines, there’s no roaming of personalization and credentials, or backup and restore capabilities

-   Windows Clients remain mostly foreign to Azure Active Directory accounts—. This means that most organizational users don’t enjoy SSO from the Windows desktop to Office 365.

-   The Windows Store does not work with organizational account, making it impractical for acquisition or distribution or enterprise apps to employees\/students’ computers.

With Windows 10 Insider Preview, you can experience all these modern experiences even when you are using an organizational account provided by your company or school. This capability is made possible with Azure Active Directory\- through a feature called **Azure Active Directory Join**.

### What is Azure Active Directory Join
Azure Active Directory Join is the functionality that registers a company\-owned device in Azure Active Directory \(Azure AD\) to enable centralized management. It means users \(employees, students\) can now be connected to the Enterprise Cloud through Azure Active Directory. This enables simplified Windows deployments, access to organizational apps and resources from any Windows device, both corp\-owned or personally owned devices \(BYOD\).

![](media/AzureADJoinOverview.bmp)

### Why should enterprises adopt Azure AD Join
With Azure AD Join, you get the following:

-   **Self\-provisioning of corp\-owned devices**: With Windows 10 Insider Preview, end users can configure a brand new, shrink\-wrapped device in the out\-of\-box experience, without IT involvement.

-   **Support for modern form factors**: Azure AD Join will work on devices that don’t have the traditional domain join capabilities.

-   **Uses existing organizational accounts**:  End users no longer need to create and maintain a personal Microsoft account to get the best experience on company\-issued devices, like they did on Windows 8. They can use their existing work account in Azure AD instead. For many organizations, this basically means setting up and logging on to Windows with the same credentials that are used to access Office 365.

-   **Automatic MDM enrollment**:  Devices can get automatically enrolled in management when connected to Azure AD. This will work with Microsoft Intune and with 3rd party MDMs. When managed with Intune, IT will be able to monitor\/manage Azure AD Joined devices alongside domain joined devices in the SCCM management console.

-   **Single Sign\-On to company resources**: Users enjoy single sign\-on from the Windows desktop to apps and resources in the cloud, such as Office 365 and thousands of business applications that rely on Azure AD for authentication. Corp\-owned devices that are joined to Azure AD will also enjoy SSO to on\-premises resources when the device is on corpnet, and from anywhere when these resources are exposed via the Azure AD Application Proxy.

-   **OS State Roaming**: Things like accessibility settings, websites and Wi\-Fi passwords will be synchronized across corp\-owned devices without requiring a personal Microsoft account.

-   **Enterprise\-ready Windows store** The Windows Store will support app acquisition and licensing with Azure AD accounts. Organizations will be able to volume\-license apps and make them available to the users in their organization.

### Usage scenarios for Azure Active Directory
Following are the three scenarios that you can enable in your enterprise, all which make use of Azure AD Join.

-   [User joins company-owned device directly to Azure AD](Extending-Modern-Experiences-and-Single-Sign-On-across-Company-Apps-on-Windows-with-Azure-Active-Directory-Join.md#BKMK_AzureADJoinedDevice)

-   [User receives company-owned device joined to on-premises AD](Extending-Modern-Experiences-and-Single-Sign-On-across-Company-Apps-on-Windows-with-Azure-Active-Directory-Join.md#BKMK_DomianJoinedDevice)

-   [User adds a work account to Windows on a personal device](Extending-Modern-Experiences-and-Single-Sign-On-across-Company-Apps-on-Windows-with-Azure-Active-Directory-Join.md#BKMK_PersonalDevice)

The following sections discuss how each of these scenarios work.

#### <a name="BKMK_AzureADJoinedDevice"></a>User joins company\-owned device directly to Azure AD
Enterprises can provide cloud\-only accounts to employees and employees of partner companies and organizations who are then provided with easy access and single\-sign on to their company apps and resources. This scenario is applicable to users who use their devices to primarily access resources in the cloud such as O365, SaaS apps. \(Admin sees these as “Azure AD Joined” devices.\)

Following are the capabilities made available in this scenario

-   Self\-service setup from a shrink\-wrapped state, ready to be used for work

-   Work or school identity used to setup device and to sign\-in to Windows

-   Multiple users in the organization can sign\-in to device

-   SSO to both cloud and on\-premises resources

-   Access to company store, acquire apps & licenses w\/ signed\-in account

-   Microsoft Passport & Windows Hello to sign\-in to on\-prem and Azure AD

-   Roaming of settings and app state using signed\-in account

-   Device auto\-enrolls in MDM and participates in Conditional Access

#### <a name="BKMK_DomianJoinedDevice"></a>User receives company\-owned device joined to on\-premises AD
In a hybrid environment where Active Directory and Azure Active Directory are sync’ed, domain joined devices are automatically represented in the company cloud directory. Users enjoy the best of both worlds. \(Admins sees these devices as “Server AD Domain Joined” devices.\)

Following are the capabilities made available in this scenario

-   Domain Join made even better by auto\-joining to Azure AD

-   Modern experiences through user’s corporate identity in Azure AD

-   SSO to both cloud and on\-premises resources from everywhere

-   Access to company store, acquire apps & licenses w\/ signed\-in account

-   Microsoft Passport & Windows Hello to sign\-in to on\-prem and Azure AD

-   Roaming of OS settings and app state using signed\-in account

-   Device participates in Conditional Access

#### <a name="BKMK_PersonalDevice"></a>User adds a work account to Windows on a personal device
Azure AD accounts can be added to a personal device to access work resources in a secure and compliant fashion. \(Admin sees these devices as “Workplace Joined” devices.\)

Following are the capabilities made available in this scenario

-   Easy configurable steps to set up

-   Work or school account is “added” to your Windows local user account or to your Microsoft Account

-   SSO to cloud resources from everywhere

-   Access to company store, acquire apps & licenses with added account

-   Microsoft Passport & Windows Hello to sign\-in to org. resources

-   Roaming of enterprise app settings and state using “added” account

-   Device auto\-enrolls in MDM & participates in Conditional Access for user

### How different devices benefit from Azure AD Join

|Corporate device\- joined to On\-Premises Domain|Corporate Device not joined to on\-prem domain \(desktop, laptop, tablet, phone\)|Personal device|
|----------------------------------------------------|-------------------------------------------------------------------------------------|-------------------|
|<ul><li>Users log on to Windows with work credentials \(as they do today\)</li><li>Users have access to roaming of settings and Windows Store – These services now work with work account \(no need for personal MSA\)<br /><br /><ul><li>Requires organizations to connect their on\-premises AD to Azure AD</li></ul></li><li>SSO from desktop to work apps\/websites\/resources, both on\-premises and in the Cloud<br /><br /><ul><li>Apps that use Azure AD for authentication</li></ul></li><li>Users can add their personal MSA to access their personal pictures\/files without impacting enterprise data \(roaming settings continues to work with work account\)<br /><br /><ul><li>The MSA account enables SSO and no longer drives roaming of settings</li><li>This is part of the work\/play “coexistence” story line</li></ul></li></ul>|<ul><li>Users can log on to Windows with work credentials that are managed in Azure AD. This is relevant for corporate devices in three cases:<br /><br /><ol><li>The organization doesn’t have AD on premises \(for example, small business\)</li><li>The organization doesn’t create all user accounts in AD \(for example students, consultants, seasonal workers\)</li><li>Corporate devices that can’t be joined to a \(on\-premises\) Domain, like phones or tablets running a Mobile SKU. For example, secondary device taken to factory\/retail floor, Works for managed and federated orgs.</li></ol></li><li>Self\-service setup – users can go through Out\-of\-box experience with their work account \(as an alternative to IT provisioning the devices – both methods are supported\)</li><li>Auto\-registration in enterprise directory \(Azure AD\) and auto\-enrolment in MDM. \(Azure AD Premium feature\)</li><li>Roaming of settings and Windows Store work with work account \(no need for personal MSA\)</li><li>Self\-service password reset \(SSPR\) on winlogon \(ability to reset forgotten password\)</li></ul>|-   Users log on to Windows with their personal MSA credentials \(no change\)<br />-   Super easy to add a work account that’s managed in AD or Azure AD<br />-   Provides SSO across apps and to websites\/resources with this work account<br />-   Provides access to enterprise Store front\/section so that users can acquire and use LoB apps on their personal devices<br />-   Conditional access control and device health attestation|

> [!NOTE]
> Work\/play coexistence: devices and apps \(OneDrive. Office…\) can be connected to both work and personal accounts in a simpler and safer way with Azure AD Join.


