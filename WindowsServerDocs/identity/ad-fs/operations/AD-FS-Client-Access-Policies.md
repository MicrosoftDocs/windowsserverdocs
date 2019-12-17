---
ms.assetid: 
title: Client Access Control policies in AD FS
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Controlling Access to Organizational Data with Active Directory Federation Services

This document provides an overview of access control with AD FS across on premises, hybrid and cloud scenarios.  

## AD FS and Conditional Access to On Premises Resources 
Since the introduction of Active Directory Federation Services, authorization policies have been available to restrict or allow users access to resources based on attributes of the request and the resource.  As AD FS has moved from version to version, how these policies are implemented has changed.  For detailed information on access control features by version see:
- [Access Control Policies in AD FS in Windows Server 2016](Access-Control-Policies-in-AD-FS.md)
- [Access control in AD FS in Windows Server 2012 R2](Manage-Risk-with-Conditional-Access-Control.md)


## AD FS and Conditional Access in a Hybrid Organization  

AD FS provides the on premises component of conditional access policy in a hybrid scenario. AD FS based authorization rules should be used for non Azure AD resources, such as on premises applications federated directly to AD FS.  The cloud component is provided by [Azure AD Conditional Access](https://docs.microsoft.com/azure/active-directory/active-directory-conditional-access).  Azure AD Connect provides the control plane connecting the two.

For example, when you register devices with Azure AD for conditional access to cloud resources, the Azure AD Connect device write back capability makes device registration information available on premises for AD FS policies to consume and enforce.  This way, you have a consistent approach to access control policies for both on premises and cloud resources.  

![conditional access](../deployment/media/Plan-Device-based-Conditional-Access-on-Premises/ADFS_ITPRO4.png)  


### The evolution of Client Access Policies for Office 365
Many of you are using client access policies with AD FS to limit access to Office 365 and other Microsoft Online services based on factors such as the location of the client and the type of client application being used.  
- [Client access policies in Windows Server 2012 R2 AD FS](Access-Control-Policies-W2K12.md)
- [Client access policies in AD FS 2.0](Access-Control-Policies-in-AD-FS-2.md)

Some examples of these policies include:
- Block all extranet client access to Office 365
- Block all extranet client access to Office 365, except for devices accessing Exchange Online for Exchange Active Sync

Often the underlying need behind these policies is to mitigate risk of data leakage by ensuring only authorized clients, applications that do not cache data, or devices that can be disabled remotely can get access to resources.

While the above documented policies for AD FS work in the specific scenarios documented, they have limitations because they depend on client data that is not consistently available.  For example, the identity of the client application has only been available for Exchange Online based services and not for resources such as SharePoint Online, where the same data might be accessed via the browser or a 'thick client' such as Word or Excel.  Also AD FS is unaware of the resource within Office 365 being accessed, such as SharePoint Online or Exchange Online.

To address these limitations and provide a more robust way to use polices to manage access to business data in Office 365 or other Azure AD based resources, Microsoft has introduced Azure AD Conditional Access.  Azure AD Conditional Access policies can be configured for a specific resource, or for any or all resources within Office 365, SaaS or custom applications in Azure AD.  These policies pivot on device trust, location, and other factors.

To find out more about Azure AD Conditional Access, see [Conditional Access in Azure Active Directory](https://docs.microsoft.com/azure/active-directory/active-directory-conditional-access)

A key change enabling these scenarios is [modern authentication](https://blogs.office.com/2015/11/19/updated-office-365-modern-authentication-public-preview/), a new way of authenticating users and devices that works the same way across Office clients, Skype, Outlook, and browsers.

## Next Steps
For more information on controlling access across the cloud and on premises see:

- [Conditional Access in Azure Active Directory](https://docs.microsoft.com/azure/active-directory/active-directory-conditional-access)
- [Access Control Policies in AD FS 2016](Access-Control-Policies-in-AD-FS.md)
