---
title: AppLocker Policies Deployment Guide
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e8c1b772-f89e-4eba-8ad3-9d8124373d21
---
# AppLocker Policies Deployment Guide
This topic for the IT professional introduces the concepts and describes the steps required to deploy AppLocker™ policies introduced in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)].  
  
## Purpose of this guide  
This guide provides steps based on your design and planning investigation for deploying application control policies by using AppLocker. It is intended for security architects, security administrators, and system administrators. Through a sequential and iterative deployment process, you can create application control policies, test and adjust the policies, and implement a method for maintaining those policies as the needs in your organization change.  
  
This guide covers the use of Software Restriction Policies \(SRP\) in conjunction with AppLocker policies to control application usage. For a comparison of SRP and AppLocker, see [Using Software Restriction Policies and AppLocker Policies](../Topic/Using-Software-Restriction-Policies-and-AppLocker-Policies.md) in this guide. To understand if AppLocker is the correct application control solution for you, see [Understand AppLocker Policy Design Decisions](../Topic/Understand-AppLocker-Policy-Design-Decisions.md).  
  
> [!TIP]  
> [!INCLUDE[build-a-book](../Token/build-a-book_md.md)]  
  
## Prerequisites to deploying AppLocker policies  
The following are prerequisites or recommendations to deploying policies:  
  
-   Understand the capabilities of AppLocker:  
  
    -   [AppLocker Technical Overview](https://technet.microsoft.com/en-us/library/ee424365(d=default,l=en-us,v=ws.10).aspx)  
  
    -   [AppLocker Step\-by\-Step Guide](http://technet.microsoft.com/library/dd723686(v=ws.10).aspx)  
  
-   Document your application control policy deployment plan by addressing these tasks:  
  
    -   [Understand the AppLocker Policy Deployment Process](../Topic/Understand-the-AppLocker-Policy-Deployment-Process.md)  
  
    -   [Understand AppLocker Policy Design Decisions](../Topic/Understand-AppLocker-Policy-Design-Decisions.md)  
  
    -   [Determine Your Application Control Objectives](../Topic/Determine-Your-Application-Control-Objectives.md)  
  
    -   [Create List of Applications Deployed to Each Business Group](../Topic/Create-List-of-Applications-Deployed-to-Each-Business-Group.md)  
  
    -   [Select Types of Rules to Create](../Topic/Select-Types-of-Rules-to-Create.md)  
  
    -   [Determine Group Policy Structure and Rule Enforcement](../Topic/Determine-Group-Policy-Structure-and-Rule-Enforcement.md)  
  
    -   [Plan for AppLocker Policy Management](../Topic/Plan-for-AppLocker-Policy-Management.md)  
  
    -   [Create Your AppLocker Planning Document](../Topic/Create-Your-AppLocker-Planning-Document.md)  
  
## Contents of this guide  
This guide provides steps based on your design and planning investigation for deploying application control policies created and maintained by AppLocker for computers running any of the supported versions of Windows listed in [Requirements to Use AppLocker](../Topic/Requirements-to-Use-AppLocker.md). It contains the following topics:  
  
-   [Understand the AppLocker Policy Deployment Process](../Topic/Understand-the-AppLocker-Policy-Deployment-Process.md)  
  
-   [Requirements for Deploying AppLocker Policies](../Topic/Requirements-for-Deploying-AppLocker-Policies.md)  
  
-   [Using Software Restriction Policies and AppLocker Policies](../Topic/Using-Software-Restriction-Policies-and-AppLocker-Policies.md)  
  
-   [Create Your AppLocker Policies](../Topic/Create-Your-AppLocker-Policies.md)  
  
-   [Deploy the AppLocker Policy into Production](../Topic/Deploy-the-AppLocker-Policy-into-Production.md)  
  
-   [Maintain AppLocker Policies](../Topic/Maintain-AppLocker-Policies.md)  
  
## Additional resources  
  
-   [Using Software Restriction Policies to Protect Against Unauthorized Software](http://go.microsoft.com/fwlink/?LinkID=155634) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=155634\)  
  
    This TechNet article is about SRP in Windows XP and Windows Server 2003 and is also applicable to Windows Vista® and Windows Server 2008. It provides an in\-depth look at how software restriction policies can be used to fight viruses, regulate which ActiveX controls can be downloaded, run only digitally signed scripts, and enforce that only approved software is installed on system computers.  
  
-   [Software Restriction Policies](https://technet.microsoft.com/library/cc779607(v=ws.10).aspx)  
  
    Windows Server 2003 product help [Software Restriction Policies](https://technet.microsoft.com/library/cc779607(v=ws.10).aspx). This collection of topics describes the concepts to understand and the steps to implement and maintain SRP.  
  
    More recent guidance to [Administer Software Restriction Policies](http://technet.microsoft.com/library/hh994606.aspx). This collection contains procedures how to administer application control policies using Software Restriction Policies \(SRP\).  
  
-   [AppLocker Overview \[Client\]](assetId:///1637ae87-5059-4d95-8c68-96f35cbc88c7)  
  
    This topic lists AppLocker documentation resources for the IT professional.  
  
