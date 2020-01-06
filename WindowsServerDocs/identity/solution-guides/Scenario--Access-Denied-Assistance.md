---
ms.assetid: aae907eb-11cf-4a87-a046-8680872ed0b1
title: Scenario Access-Denied Assistance
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Scenario: Access-Denied Assistance

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Users will get an access-denied message when they try to access shared files and folders on a file server for which they do not have permissions. Administrators often do not have the appropriate context to troubleshoot the access issue, which makes it hard to resolve the issue.  
  
## Scenario description  
Access-denied assistance is a new feature in  Windows Server 2012 , which provides the following ways to troubleshoot issues that are related to access to files and folders:  
  
-   **Self-assistance.** If a user can determine the issue and remediate the problem so that they can get the requested access, the impact to the business is low, and no special exceptions are needed in the central access policy. Access-denied assistance provides an access-denied message that file server administrators can customize with information specific to their organizations. For example, an administrator could set the message so that users can request access from a data owner without involving the file server administrator.  
  
-   **Assistance by the data owner.** You can define a distribution list for shared folders, and configure it so that the folder owner receives an email notification when a user needs access. If the data owner does not know how to help the user get access, the owner can forward this information to the file server administrator.  
  
-   **Assistance by the file server administrator.** This type of assistance is available when the user cannot fix an issue and the data owner cannot help.  Windows Server 2012  provides a user interface where file server administrators can view the effective permissions for a user on a file or folder so that it is easier to troubleshoot access issues.  
  
Access-denied assistance in  Windows Server 2012  provides file server administrators the relevant access details so that they can determine the issue and appropriate tools so that they can make configuration changes to satisfy the access request. For example, a user might follow this process to access a file that they currently do not have access to:  
  
-   The user attempts to read a file in the \\\financeshares shared folder, but the server displays an access-denied message.  
  
-    Windows Server 2012  displays the access-denied assistance information to the user with an option to request assistance.  
  
-   If the user requests access to the resource, the server sends an email with the access request information to the folder owner.  
  
You can find planning information for configuring access-denied assistance in [Plan for Access-Denied Assistance](assetId:///b169f0a4-8b97-4da8-ae4a-c8f1986d19e1).  
  
You can find steps about configuring access-denied assistance in [Deploy Access-Denied Assistance &#40;Demonstration Steps&#41;](Deploy-Access-Denied-Assistance--Demonstration-Steps-.md).  
  
## In this scenario  
This scenario is part of the Dynamic Access Control scenario. For additional information about Dynamic Access Control, see:  
  
-   [Dynamic Access Control: Scenario Overview](Dynamic-Access-Control--Scenario-Overview.md)  
  
## Practical applications  
Access-denied assistance in  Windows Server 2012  contributes to Dynamic Access Control by giving users the ability to request access to shared files and folders directly from an access-denied message.  
  
## <a name="BKMK_NEW"></a>Features included in this scenario  
The following table lists the features that are part of this scenario and describes how they support it.  
  
|Feature|How it supports this scenario|  
|-----------|---------------------------------|  
|[File Server Resource Manager Overview](https://technet.microsoft.com/library/hh831701.aspx)|Access-denied assistance can be configured by using the File Server Resource Manager console on the file server.|  
|[File and Storage Services Overview](https://technet.microsoft.com/library/hh831487.aspx)|File Server Resource Manager is a File and Storage Services role service, and it is comprised of a set of features that can be used to administer the file servers on your network.|  
  


