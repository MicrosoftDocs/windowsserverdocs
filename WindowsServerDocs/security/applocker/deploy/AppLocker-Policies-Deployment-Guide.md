---
title: applocker Policies Deployment Guide
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
# applocker Policies Deployment Guide
This topic for the IT professional introduces the concepts and describes the steps required to deploy applocker™ policies introduced in  Windows Server 2008 R2  and  Windows 7 .

## Purpose of this guide
This guide provides steps based on your design and planning investigation for deploying application control policies by using applocker. It is intended for security architects, security administrators, and system administrators. Through a sequential and iterative deployment process, you can create application control policies, test and adjust the policies, and implement a method for maintaining those policies as the needs in your organization change.

This guide covers the use of Software Restriction Policies \(SRP\) in conjunction with applocker policies to control application usage. For a comparison of SRP and applocker, see [Using Software Restriction Policies and applocker Policies]() in this guide. To understand if applocker is the correct application control solution for you, see [Understand applocker Policy Design Decisions]().

> [!TIP]
> To digitally save or print pages from this library, click **Export** \(in the upper\-right corner of the page\), and then follow the instructions.

## Prerequisites to deploying applocker policies
The following are prerequisites or recommendations to deploying policies:

-   Understand the capabilities of applocker:

    -   [applocker Technical Overview](https://technet.microsoft.com/en-us/library/ee424365(d=default,l=en-us,v=ws.10).aspx)

    -   [applocker Step\-by\-Step Guide](http://technet.microsoft.com/library/dd723686(v=ws.10).aspx)

-   Document your application control policy deployment plan by addressing these tasks:

    -   [Understand the applocker Policy Deployment Process]()

    -   [Understand applocker Policy Design Decisions]()

    -   [Determine Your Application Control Objectives]()

    -   [Create List of Applications Deployed to Each Business Group]()

    -   [Select Types of Rules to Create]()

    -   [Determine Group Policy Structure and Rule Enforcement]()

    -   [Plan for applocker Policy Management]()

    -   [Create Your applocker Planning Document]()

## Contents of this guide
This guide provides steps based on your design and planning investigation for deploying application control policies created and maintained by applocker for computers running any of the supported versions of Windows listed in [Requirements to Use applocker](). It contains the following topics:

-   [Understand the applocker Policy Deployment Process]()

-   [Requirements for Deploying applocker Policies]()

-   [Using Software Restriction Policies and applocker Policies]()

-   [Create Your applocker Policies]()

-   [Deploy the applocker Policy into Production]()

-   [Maintain applocker Policies]()

## Additional resources

-   [Using Software Restriction Policies to Protect Against Unauthorized Software](http://go.microsoft.com/fwlink/?LinkID=155634) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=155634\)

    This TechNet article is about SRP in Windows XP and Windows Server 2003 and is also applicable to Windows Vista® and Windows Server 2008. It provides an in\-depth look at how software restriction policies can be used to fight viruses, regulate which ActiveX controls can be downloaded, run only digitally signed scripts, and enforce that only approved software is installed on system computers.

-   [Software Restriction Policies](https://technet.microsoft.com/library/cc779607(v=ws.10).aspx)

    Windows Server 2003 product help [Software Restriction Policies](https://technet.microsoft.com/library/cc779607(v=ws.10).aspx). This collection of topics describes the concepts to understand and the steps to implement and maintain SRP.

    More recent guidance to [Administer Software Restriction Policies](http://technet.microsoft.com/library/hh994606.aspx). This collection contains procedures how to administer application control policies using Software Restriction Policies \(SRP\).

-   [applocker Overview \[Client\]](assetId:///1637ae87-5059-4d95-8c68-96f35cbc88c7)

    This topic lists applocker documentation resources for the IT professional.


