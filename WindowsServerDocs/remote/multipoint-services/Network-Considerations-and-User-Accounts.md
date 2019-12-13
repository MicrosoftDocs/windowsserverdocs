---
title: Network Considerations and User Accounts
description: Provides planning information for different network and user scenarios with MultiPoint Services
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ef4859fc-b7ae-4827-ab9c-b1dc07ab6c16
author: evaseydl
manager: scottman
ms.author: evas
---
# Network Considerations and User Accounts
MultiPoint Services can be deployed in a variety of network environments, and it can support local user accounts and domain user accounts. Generally, MultiPoint Services user accounts will be managed in one of the following network environments:  
  
-   A single computer running MultiPoint Services with local user accounts  
  
-   Multiple computers running MultiPoint Services, each with a local user account  
  
-   Multiple computers running MultiPoint Services and that are using domain user accounts

By definition, *local user accounts* can only be accessed from the computer on which they were created. Local user accounts are user accounts that are created on a specific computer that is running MultiPoint Services. In contrast, *domain user accounts* are user accounts that reside on a domain controller, and they can be accessed from any computer that is connected to the domain. When you are deciding which type of network environment to use, consider the following:  
  
-   Will resources be shared among servers?  
  
-   Will users be switching between servers?  
  
-   Will users access database servers that require authentication?  
  
-   Will users access internal web servers that require authentication?  
  
-   Is there an existing Active Directory domain infrastructure in place?  
  
-   Who will be using the MultiPoint Manager console to manage user desktops, view thumbnails, add users, limit websites, and so on? Will this person be managing more than one server? This person must have administrative privileges on the servers.  
  
The following sections address user account management in these networking environments.  
  
## Single MultiPoint Server with local user accounts  
In environments with a single computer that is running MultiPoint Services, there is no requirement to have a network. However, to take advantage of Internet resources, the networking requirements may be as basic as a router and a connection to an Internet service provider (ISP). Network connections that are associated with a network adapter on MultiPoint Services are configured, by default, to obtain an IP address and DNS server address automatically through DHCP. Internet routers are typically configured as DHCP servers, and they provide private IP addresses to computers that connect to them on the internal network. Therefore, a single computer running MultiPoint Services may be able to connect to the internal interface of the router, obtain automatic IP information, and connect to the Internet without significant effort or configuration by an administrator.  
  
A common way to manage users in this kind of environment is to create a local user account for each person who will access the system. Anyone who has a local user account on that computer can log on to MultiPoint Services from any station that is associated with the system. Local user accounts can be created and managed from MultiPoint Manager.  
  
## Multiple MultiPoint Server systems with local user accounts  
Given that local user accounts are only accessible from the computer on which they were created, when you deploy multiple MultiPoint Services systems in an environment, you can manage local user accounts in one of two ways:  
  
-   You can create user accounts for specific individuals on specific computers running MultiPoint Services.  
  
-   You can use MultiPoint Manager to create accounts for every user on every computer running MultiPoint Services.  
  
For example, if you plan to assign users to a specific computer running MultiPoint Services, you might create four local user accounts on Computer A (user01, user02, user03, and user04) and four local user accounts on Computer B (user05, user06, user07, and user08). In this scenario, users 01\-04 can log on to Computer A from any station that is connected to it; however, they cannot log on to Computer B. The same is true for users 05\-08, who would be able to log on only to Computer B, but not to Computer A. Depending on the specific deployment environment, this can be acceptable or even desirable.  
  
However, if every user must be able to log on to any of the computers running MultiPoint Services, a local user account must be created for each user on each computer that is running MultiPoint Services. Choosing to manage users in this manner introduces certain complexities. For example, if user01 logs on to Computer A on Monday and saves a file in the Documents folder, and then the user logs on to Computer B on Tuesday, the file that was saved in the Documents folder on Computer A will not be accessible on Computer B.  
  
Additionally, if a user has accounts on Computer A and Computer B, there is no way to automatically synchronize the passwords for the accounts. This can result in users having difficulty logging on should the account password be changed on one computer, but not the other. You can simplify user account management in this kind of network environment by assigning each user to a single computer that is running MultiPoint Services. This way, the user can log on to any of the stations that are associated with that computer and access the appropriate files.  
  
## Multiple MultiPoint Services systems with domain accounts  
Domain environments are common in large network environments that include multiple servers. For example, you might join one or more computers running the MultiPoint Services role to a domain, and then use Microsoft Active Directory to manage user accounts that can be accessed from any computer in the domain. This allows for individual domain user accounts to be created and accessed from any station in any MultiPoint Services system that is joined to the domain.  
 
When you deploy MultiPoint Services in a domain environment, there are several factors to consider:  
  
-   If domain accounts are used, they cannot be managed from MultiPoint Manager.  
  
-   By default, MultiPoint Services is configured to give each user permission to log on to only one station at a time. If you decide to allow users to log on to multiple stations at the same time using a single account, you can use the **Edit Server Settings** option in MultiPoint Manager.  
  
-   The location of domain controllers may affect the speed and reliability with which users will be able to authenticate with the domain and locate resources.  
  
## Single user account for multiple stations  
MultiPoint Services has the ability to log on to multiple stations on the same computer simultaneously using a single user account. This feature is useful in environments where users are not given unique user names, and where using a single user account can simplify the management of the MultiPoint Services system.  
  
