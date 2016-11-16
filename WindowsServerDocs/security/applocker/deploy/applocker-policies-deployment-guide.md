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

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic for the IT professional introduces the concepts and describes the steps required to deploy AppLocker??? policies introduced in  Windows Server 2008 R2  and  Windows 7.

## Purpose of this guide
This guide provides steps based on your design and planning investigation for deploying application control policies by using AppLocker. It is intended for security architects, security administrators, and system administrators. Through a sequential and iterative deployment process, you can create application control policies, test and adjust the policies, and implement a method for maintaining those policies as the needs in your organization change.

This guide covers the use of Software Restriction Policies (SRP) in conjunction with AppLocker policies to control application usage. For a comparison of SRP and AppLocker, see [Using Software Restriction Policies and AppLocker Policies](using-software-restriction-policies-and-applocker-policies.md) in this guide. To understand if AppLocker is the correct application control solution for you, see [Understand AppLocker Policy Design Decisions](../design/understand-applocker-policy-design-decisions.md).

> [!TIP]
> To digitally save or print pages from this library, click **Export** (in the upper-right corner of the page), and then follow the instructions.

## Prerequisites to deploying AppLocker policies
The following are prerequisites or recommendations to deploying policies:

-   Understand the capabilities of AppLocker:

    -   [AppLocker Technical Overview](https://technet.microsoft.com/en-us/library/ee424365(d=default,l=en-us,v=ws.10).aspx)

    -   [AppLocker Step-by-Step Guide](http://technet.microsoft.com/library/dd723686(v=ws.10).aspx)

-   Document your application control policy deployment plan by addressing these tasks:

    -   [Understand the AppLocker Policy Deployment Process](understand-the-applocker-policy-deployment-process.md)

    -   [Understand AppLocker Policy Design Decisions](../design/understand-applocker-policy-design-decisions.md)

    -   [Determine Your Application Control Objectives](../design/determine-your-application-control-objectives.md)

    -   [Create List of Applications Deployed to Each Business Group](../design/create-list-of-applications-deployed-to-each-business-group.md)

    -   [Select Types of Rules to Create](../design/select-types-of-rules-to-create.md)

    -   [Determine Group Policy Structure and Rule Enforcement](../design/determine-group-policy-structure-and-rule-enforcement.md)

    -   [Plan for AppLocker Policy Management](../design/plan-for-applocker-policy-management.md)

    -   [Create Your AppLocker Planning Document](../design/create-your-applocker-planning-document.md)

## Contents of this guide
This guide provides steps based on your design and planning investigation for deploying application control policies created and maintained by AppLocker for computers running any of the supported versions of Windows listed in [Requirements to Use AppLocker](../get-started/requirements-to-use-applocker.md). It contains the following topics:

-   [Understand the AppLocker Policy Deployment Process](understand-the-applocker-policy-deployment-process.md)

-   [Requirements for Deploying AppLocker Policies](requirements-for-deploying-applocker-policies.md)

-   [Using Software Restriction Policies and AppLocker Policies](using-software-restriction-policies-and-applocker-policies.md)

-   [Create Your AppLocker Policies](create-your-applocker-policies.md)

-   [Deploy the AppLocker Policy into Production](deploy-the-applocker-policy-into-production.md)

-   [Maintain AppLocker Policies](../manage/maintain-applocker-policies.md)

## Additional resources

-   [Using Software Restriction Policies to Protect Against Unauthorized Software](http://go.microsoft.com/fwlink/?LinkID=155634) (http://go.microsoft.com/fwlink/?LinkID=155634)

    This TechNet article is about SRP in Windows XP and Windows Server 2003 and is also applicable to Windows Vista?? and Windows Server 2008. It provides an in-depth look at how software restriction policies can be used to fight viruses, regulate which ActiveX controls can be downloaded, run only digitally signed scripts, and enforce that only approved software is installed on system computers.

-   [Software Restriction Policies](https://technet.microsoft.com/library/cc779607(v=ws.10).aspx)

    Windows Server 2003 product help [Software Restriction Policies](https://technet.microsoft.com/library/cc779607(v=ws.10).aspx). This collection of topics describes the concepts to understand and the steps to implement and maintain SRP.

    More recent guidance to [Administer Software Restriction Policies](http://technet.microsoft.com/library/hh994606.aspx). This collection contains procedures how to administer application control policies using Software Restriction Policies (SRP).


