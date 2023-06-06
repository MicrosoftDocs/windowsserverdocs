---
description: "Learn more about: Scenario: Access-Denied Assistance"
ms.assetid: aae907eb-11cf-4a87-a046-8680872ed0b1
title: Scenario Access-Denied Assistance
author: billmath
ms.author: wscontent
manager: femila
ms.date: 06/06/2023
ms.topic: article
---

# Scenario: Access-Denied Assistance

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Users will get an access-denied message when they try to access shared files and folders on a file server for which they do not have permissions. Administrators often do not have the appropriate context to troubleshoot the access issue, which makes it hard to resolve the issue.

## Scenario description
Access-denied assistance is a new feature in  Windows Server 2012, which provides the following ways to troubleshoot issues that are related to access to files and folders:

-   **Self-assistance.** If a user can determine the issue and remediate the problem so that they can get the requested access, the impact to the business is low, and no special exceptions are needed in the central access policy. Access-denied assistance provides an access-denied message that file server administrators can customize with information specific to their organizations. For example, an administrator could set the message so that users can request access from a data owner without involving the file server administrator.

-   **Assistance by the data owner.** You can define a distribution list for shared folders, and configure it so that the folder owner receives an email notification when a user needs access. If the data owner does not know how to help the user get access, the owner can forward this information to the file server administrator.

-   **Assistance by the file server administrator.** This type of assistance is available when the user cannot fix an issue and the data owner cannot help.  Windows Server 2012  provides a user interface where file server administrators can view the effective permissions for a user on a file or folder so that it is easier to troubleshoot access issues.

Access-denied assistance in  Windows Server 2012  provides file server administrators the relevant access details so that they can determine the issue and appropriate tools so that they can make configuration changes to satisfy the access request. For example, a user might follow this process to access a file that they currently do not have access to:

-   The user attempts to read a file in the \\\financeshares shared folder, but the server displays an access-denied message.

-    Windows Server 2012  displays the access-denied assistance information to the user with an option to request assistance.

-   If the user requests access to the resource, the server sends an email with the access request information to the folder owner.

You can find planning information for configuring access-denied assistance in [Plan for Access-Denied Assistance](/previous-versions/orphan-topics/ws.11/jj574182(v=ws.11)?redirectedfrom=MSDN).

You can find steps about configuring access-denied assistance in [Deploy Access-Denied Assistance &#40;Demonstration Steps&#41;](Deploy-Access-Denied-Assistance--Demonstration-Steps-.md).

## In this scenario
This scenario is part of the Dynamic Access Control scenario. For more information about Dynamic Access Control, see:

-   [Dynamic Access Control: Scenario Overview](Dynamic-Access-Control--Scenario-Overview.md)

## Practical applications
Access-denied assistance in  Windows Server 2012  contributes to Dynamic Access Control by giving users the ability to request access to shared files and folders directly from an access-denied message.

## <a name="BKMK_NEW"></a>Features included in this scenario
The following table lists the features that are part of this scenario and describes how they support it.

|Feature|How it supports this scenario|
|-----------|---------------------------------|
|[File Server Resource Manager Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831701(v=ws.11))|Access-denied assistance can be configured by using the File Server Resource Manager console on the file server.|
|[File and Storage Services Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831487(v=ws.11))|File Server Resource Manager is a File and Storage Services role service, and it is comprised of a set of features that can be used to administer the file servers on your network.|
