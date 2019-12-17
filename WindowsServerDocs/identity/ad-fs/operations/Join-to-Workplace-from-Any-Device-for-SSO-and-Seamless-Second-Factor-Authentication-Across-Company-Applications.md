---
ms.assetid: e22d84a5-113d-4bec-b484-036ed29f0c28
title: Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 12/05/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications



The rapid increase in the number of consumer devices and ubiquitous information access is changing the way that people perceive their technology. The constant use of information technology throughout the day, along with easy access of information, is blurring traditional boundaries between work and home life. These shifting boundaries are accompanied by a belief that personal technology-selected and customized to fit users' personalities, activities, and schedules-should extend into the workplace. To accommodate the growing requirement of personal consumer devices to be connected to enterprise networks, we are introducing the following value propositions:

-   Administrators can control who has access to company resources that are based on application, user, device, and location.

-   Employees can access applications and data everywhere, on any device. Employees can use Single Sign-On in browser applications or enterprise applications.

## Key concepts introduced in the solution

### Workplace Join
By using Workplace Join, information workers can join their personal devices with their company's workplace computers to access company resources and services. When you join your personal device to your workplace, it becomes a known device and provides seamless second factor authentication and Single Sign-On to workplace resources and applications. When a device is joined by Workplace Join, attributes of the device can be retrieved from the directory to drive conditional access for the purpose of authorizing issuance of security tokens for applications. Windows 8.1 and iOS 6.0+, and Android 4.0+ devices can be joined by using Workplace Join.

### <a name="BKMK_DRS"></a>Azure Active Directory Device Registration service
Workplace Join is made possible by the Azure Active Directory Device Registration service. When a device is joined by Workplace Join, the service provisions a device object in Azure Active Directory and then sets a key on the local device that is used to represent the device identity. This device identity can then be used with access control rules for applications that are hosted in the cloud and on-premises.

For more details, see [Introduction to device management in Azure Active Directory](https://docs.microsoft.com/azure/active-directory/device-management-introduction).

### Workplace Join as a seamless second factor authentication
Companies can manage the risk that is related to information access and drive governance and compliance while granting consumer devices access to corporate resources. Workplace Join on devices provides the following capabilities to administrators:

-   Identifies known devices with device authentication. Administrators can use this information to drive conditional access and control access to resources.

-   Provides a more seamless sign-in experience for users to access company resources from trusted devices.

### Single Sign-On
Single Sign-On (SSO) in the context of this scenario is the functionality that reduces the number of password prompts that the end user has to enter to access company resources from known devices. This functionality implies that users are prompted only one time during the lifetime of SSO to access company applications and resource from this device. If a device uses Workplace Join, the user who is registered to use this device gets persistent SSO, by default for seven days. This user has a seamless sign-in experience in the same session or in new sessions.

## Solution Overview
As part of this solution, you learn how to use Workplace Join on a supported device and experience Single Sign-On to a company resource.

> [!NOTE]
> To support Windows 8.1, iOS 6.0+, and Android 4.0+ devices, you MUST configure Azure Active Directory Device Registration along with device object write-back, see [Step-by-Step Guide for On-premises Conditional Access using Azure Active Directory Device Registration Service](https://msdn.microsoft.com/library/azure/dn788908.aspx)

This solution guides takes you through the following walkthrough steps:

1.  [Walkthrough: Workplace Join with a Windows Device](../../ad-fs/operations/Walkthrough--Workplace-Join-with-a-Windows-Device.md)

2.  [Walkthrough: Workplace Join with an iOS Device](../../ad-fs/operations/Walkthrough--Workplace-Join-with-an-iOS-Device.md)

3.  [Walkthrough: Workplace Join with an Android Device](../../ad-fs/operations/walkthrough--workplace-join-to-an-android-device.md)

## See Also
[Configure a federation server with Device Registration Service](../deployment/configure-a-federation-server-with-device-registration-service.md)



