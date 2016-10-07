---
title: AppLocker Policy Use Scenarios
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8c111899-0a26-427a-8cc8-51291ca3e396
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# AppLocker Policy Use Scenarios

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional lists the various application control scenarios in which AppLocker policies can be effectively implemented.

AppLocker can help you improve the management of application control and the maintenance of application control policies. Application control scenarios addressed by AppLocker can be categorized as follows:

1.  **Application inventory**

    AppLocker has the ability to enforce its policy in an audit-only mode where all application access activity is collected in event logs for further analysis. Windows PowerShell cmdlets are also available to help you understand application usage and access.

2.  **Protection against unwanted software**

    AppLocker has the ability to deny applications from running simply by excluding them from the list of allowed applications per business group or user. If an application is not specifically identified by its publisher, installation path, or file hash, the attempt to run the application fails.

3.  **Licensing conformance**

    AppLocker can provide an inventory of software usage within your organization, so you can identify the software that corresponds to your software licensing agreements and restrict application usage based on licensing agreements.

4.  **Software standardization**

    AppLocker policies can be configured to allow only supported or approved applications to run on computers within a business group. This permits a more uniform application deployment.

5.  **Manageability improvement**

    AppLocker policies can be modified and deployed through your existing Group Policy infrastructure and can work in conjunction with policies created by using Software Restriction Policies. As you manage ongoing change in your support of a business group's applications, you can modify policies and use the AppLocker cmdlets to test the policies for the expected results. You can also design application control policies for situations in which users share computers.

### Use scenarios
The following are examples of scenarios in which AppLocker can be used:

-   Your organization implements a policy to standardize the applications used within each business group, so you need to determine the expected usage compared to the actual usage.

-   The security policy for application usage has changed, and you need to evaluate where and when those deployed applications are being accessed.

-   Your organization's security policy dictates the use of only licensed software, so you need to determine which applications are not licensed or prevent unauthorized users from running licensed software.

-   An application is no longer supported by your organization, so you need to prevent it from being used by everyone.

-   Your organization needs to restrict the use of Windows Store apps to just those your organization approves of or develops.

-   The potential that unwanted software can be introduced in your environment is high, so you need to reduce this threat.

-   The license to an application has been revoked or is expired in your organization, so you need to prevent it from being used by everyone.

-   A new application or a new version of an application is deployed, and you need to allow certain groups to use it.

-   Specific software tools are not allowed within the organization, or only specific users have access to those tools.

-   A single user or small group of users needs to use a specific application that is denied for all others.

-   Some computers in your organization are shared by people who have different software usage needs.

-   In addition to other measures, you need to control the access to sensitive data through application usage.

## See also
To explore specific use scenarios, see [AppLocker Step-by-Step Scenarios](http://technet.microsoft.com/library/ee791835(v=ws.10).aspx).

## See Also
[AppLocker Technical Reference](AppLocker-Technical-Reference.md)


