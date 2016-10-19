---
title: AppLocker Policies Deployment Guide
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e8c1b772-f89e-4eba-8ad3-9d8124373d21
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# AppLocker Policies Deployment Guide

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional introduces the concepts and describes the steps required to deploy AppLocker??? policies introduced in  Windows Server 2008 R2  and  Windows 7.

## Purpose of this guide
This guide provides steps based on your design and planning investigation for deploying application control policies by using AppLocker. It is intended for security architects, security administrators, and system administrators. Through a sequential and iterative deployment process, you can create application control policies, test and adjust the policies, and implement a method for maintaining those policies as the needs in your organization change.

This guide covers the use of Software Restriction Policies (SRP) in conjunction with AppLocker policies to control application usage. For a comparison of SRP and AppLocker, see [Using Software Restriction Policies and AppLocker Policies](Using-Software-Restriction-Policies-and-AppLocker-Policies.md) in this guide. To understand if AppLocker is the correct application control solution for you, see [Understand AppLocker Policy Design Decisions](../design/Understand-AppLocker-Policy-Design-Decisions.md).

> [!TIP]
> To digitally save or print pages from this library, click **Export** (in the upper-right corner of the page), and then follow the instructions.

## Prerequisites to deploying AppLocker policies
The following are prerequisites or recommendations to deploying policies:

-   Understand the capabilities of AppLocker:

    -   [AppLocker Technical Overview](https://technet.microsoft.com/en-us/library/ee424365(d=default,l=en-us,v=ws.10).aspx)

    -   [AppLocker Step-by-Step Guide](http://technet.microsoft.com/library/dd723686(v=ws.10).aspx)

-   Document your application control policy deployment plan by addressing these tasks:

    -   [Understand the AppLocker Policy Deployment Process](Understand-the-AppLocker-Policy-Deployment-Process.md)

    -   [Understand AppLocker Policy Design Decisions](../design/Understand-AppLocker-Policy-Design-Decisions.md)

    -   [Determine Your Application Control Objectives](../design/Determine-Your-Application-Control-Objectives.md)

    -   [Create List of Applications Deployed to Each Business Group](../design/Create-List-of-Applications-Deployed-to-Each-Business-Group.md)

    -   [Select Types of Rules to Create](../design/Select-Types-of-Rules-to-Create.md)

    -   [Determine Group Policy Structure and Rule Enforcement](../design/Determine-Group-Policy-Structure-and-Rule-Enforcement.md)

    -   [Plan for AppLocker Policy Management](../design/Plan-for-AppLocker-Policy-Management.md)

    -   [Create Your AppLocker Planning Document](../design/Create-Your-AppLocker-Planning-Document.md)

## Contents of this guide
This guide provides steps based on your design and planning investigation for deploying application control policies created and maintained by AppLocker for computers running any of the supported versions of Windows listed in [Requirements to Use AppLocker](../get-started/Requirements-to-Use-AppLocker.md). It contains the following topics:

-   [Understand the AppLocker Policy Deployment Process](Understand-the-AppLocker-Policy-Deployment-Process.md)

-   [Requirements for Deploying AppLocker Policies](Requirements-for-Deploying-AppLocker-Policies.md)

-   [Using Software Restriction Policies and AppLocker Policies](Using-Software-Restriction-Policies-and-AppLocker-Policies.md)

-   [Create Your AppLocker Policies](Create-Your-AppLocker-Policies.md)

-   [Deploy the AppLocker Policy into Production](Deploy-the-AppLocker-Policy-into-Production.md)

-   [Maintain AppLocker Policies](../manage/Maintain-AppLocker-Policies.md)

## Additional resources

-   [Using Software Restriction Policies to Protect Against Unauthorized Software](http://go.microsoft.com/fwlink/?LinkID=155634) (http://go.microsoft.com/fwlink/?LinkID=155634)

    This TechNet article is about SRP in Windows XP and Windows Server 2003 and is also applicable to Windows Vista?? and Windows Server 2008. It provides an in-depth look at how software restriction policies can be used to fight viruses, regulate which ActiveX controls can be downloaded, run only digitally signed scripts, and enforce that only approved software is installed on system computers.

-   [Software Restriction Policies](https://technet.microsoft.com/library/cc779607(v=ws.10).aspx)

    Windows Server 2003 product help [Software Restriction Policies](https://technet.microsoft.com/library/cc779607(v=ws.10).aspx). This collection of topics describes the concepts to understand and the steps to implement and maintain SRP.

    More recent guidance to [Administer Software Restriction Policies](http://technet.microsoft.com/library/hh994606.aspx). This collection contains procedures how to administer application control policies using Software Restriction Policies (SRP).


