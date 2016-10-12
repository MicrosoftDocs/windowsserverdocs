---
title: Get started with AppLocker
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 954a2fe6-2608-4b81-9687-e0deb251a24d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

#Get started with AppLocker

This topic provides a description of AppLocker. This information can help you decide if your organization can benefit from deploying AppLocker application control policies. AppLocker helps administrators control which applications and files users can run. These include executable files, scripts, Windows Installer files, dynamic-link libraries (DLLs), packaged apps, and packaged app installers.

AppLocker documentation covers the following IT adminitrative tasks:


**Plan** 

- [AppLocker Policies Design Guide](../design/AppLocker-Policies-Design-Guide.md)

- [AppLocker Technical Reference](AppLocker-Technical-Reference.md)

**Deploy** 

- [AppLocker Policies Deployment Guide](../deploy/AppLocker-Policies-Deployment-Guide.md)

**Manage** 

- [Administer AppLocker](../manage/Administer-AppLocker.md)





##What does AppLocker do?

By using AppLocker, you can:

- Define rules based on file attributes that persist across application updates, such as the publisher name (derived from the digital signature), product name, file name, and file version. You can also create rules based on the file path and hash.
- Assign a rule to a security group or an individual user. 
- Create exceptions to rules. For example, you can create a rule that allows all users to run all Windows binaries except the Registry Editor (Regedit.exe).
- Use audit-only mode to deploy the policy and understand its impact before enforcing it.
- Create rules on a staging server, test them, then export them to your production environment and import them into a Group Policy Object. 
- Simplify creating and managing AppLocker rules by using Windows PowerShell cmdlets for AppLocker. 
 
AppLocker helps reduce administrative overhead and helps reduce the organization's cost of managing computing resources by decreasing the number of Help Desk calls that result from users running unapproved applications. AppLocker addresses the following application security scenarios:

- Application inventory

AppLocker has the ability to enforce its policy in an audit-only mode where all application access activity is registered in event logs. These events can be collected for further analysis. Windows PowerShell cmdlets also help you analyze this data programmatically.

- Protection against unwanted software

AppLocker has the ability to deny applications from running when you exclude them from the list of allowed applications. When AppLocker rules are enforced in the production environment, any application that is not included in the allowed rules is blocked from running.

- Licensing conformance

AppLocker can help you create rules that preclude unlicensed software from running and restrict licensed software to authorized users.

- Software standardization

AppLocker policies can be configured to allow only supported or approved applications to run on computers within a business group. This permits a more uniform application deployment.

- Manageability improvement

AppLocker includes a number of improvements in manageability as compared to its predecessor Software Restriction Policies. Importing and exporting policies, automatic generation of rules from multiple files, audit-only mode deployment, and Windows PowerShell cmdlets are a few of the improvements over Software Restriction Policies.

## When to use AppLocker

In many organizations, information is the most valuable asset, and ensuring that only approved users have access to that information is imperative. Access control technologies such as Active Directory Rights Management Services (AD RMS) and access control lists (ACLs) help control what users are allowed to access. 

However, when a user runs a process, that process has the same level of access to data that the user has. As a result, sensitive information could easily be deleted or transmitted out of the organization if a user knowingly or unknowingly runs malicious software. AppLocker can help mitigate these types of security breaches by restricting the files that users or groups are allowed to run.

Software publishers are beginning to create more applications that can be installed by non-administrative users. This could jeopardize an organization's written security policy and circumvent traditional application control solutions that rely on the inability of users to install applications. By allowing administrators to create an allowed list of approved files and applications, AppLocker helps prevent such per-user applications from running. Because AppLocker can control DLLs, it is also useful to control who can install and run ActiveX controls. 

AppLocker is ideal for organizations that currently use Group Policy to manage their Windows-based computers. Because AppLocker relies on Group Policy for authoring and deployment, experience with Group Policy is helpful if you plan to use AppLocker. 

The following are examples of scenarios in which AppLocker can be used:

- Your organization's security policy dictates the use of only licensed software, so you need to prevent users from running unlicensed software and also restrict the use of licensed software to authorized users.
- An application is no longer supported by your organization, so you need to prevent it from being used by everyone.
- The potential that unwanted software can be introduced in your environment is high, so you need to reduce this threat.
- The license to an application has been revoked or it is expired in your organization, so you need to prevent it from being used by everyone.
- A new application or a new version of an application is deployed, and you need to prevent users from running the old version.
- Specific software tools are not allowed within the organization, or only specific users should have access to those tools.
- A single user or small group of users needs to use a specific application that is denied for all others.
- Some computers in your organization are shared by people who have different software usage needs, and you need to protect specific applications.
- In addition to other measures, you need to control the access to sensitive data through application usage.

AppLocker can help you protect the digital assets within your organization, reduce the threat of malicious software being introduced into your environment, and improve the management of application control and the maintenance of application control policies. 

##Versions, interoperability, and differences in functionality

###Supported versions and interoperability considerations
AppLocker policies can only be configured on and applied to computers that are running the support versions and editions Windows operating system. For more information see Requirements to Use AppLocker.
###Differences in functionality between versions
The following table lists the differences by operating system version for each of the major features in or functions of AppLocker:
The following table lists the differences by operating system version for each of the major features in or functions of AppLocker:

##System requirements

AppLocker policies can only be configured on and applied to computers that are running on the supported versions and editions of the Windows operating system. Group Policy is required to distribute Group Policy Objects that contain AppLocker policies. For more information, see [Requirements to Use AppLocker](Requirements-to-Use-AppLocker.md).

AppLocker rules can be created on domain controllers.


##Installing AppLocker

AppLocker is included with enterprise-level editions of Windows. You can author AppLocker rules for a single computer or for a group of computers. For a single computer, you can author the rules by using the Local Security Policy editor (secpol.msc). For a group of computers, you can author the rules within a Group Policy Object by using the Group Policy Management Console (GPMC).

The GPMC is available in client computers running Windows only by installing the Remote Server Administration Tools. On computer running Windows Server, you must install the Group Policy Management feature. |

##Using AppLocker on Server Core

Running AppLocker on Server Core installations is not supported.

##Virtualization considerations

You can administer AppLocker policies by using a virtualized instance of Windows provided it meets all the system requirements listed previously. You can also run Group Policy in a virtualized instance. However, you do risk losing the policies that you created and maintain if the virtualized instance is removed or fails.

##Security considerations

Application control policies specify which programs are allowed to run on the local computer.

The variety of forms that malicious software can take make it difficult for users to know what is safe to run. When activated, malicious software can damage content on a hard disk drive, flood a network with requests to cause a denial-of-service (DoS) attack, send confidential information to the Internet, or compromise the security of a computer.

The countermeasure is to create a sound design for your application control policies on end-user computers in your organization, and then thoroughly test the policies in a lab environment before you deploy them in a production environment. AppLocker can be part of your application control strategy because you can control what software is allowed to run on your computers.

A flawed application control policy implementation can disable necessary applications or allow malicious or unintended software to run. Therefore, it is important that organizations dedicate sufficient resources to manage and troubleshoot the implementation of such policies.

For additional information about specific security issues, see [Security Considerations for AppLocker](Security-Considerations-for-AppLocker.md).

