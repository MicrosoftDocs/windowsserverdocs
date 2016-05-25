---
title: Install an Additional Domain Controller by Using Unattend Parameters from the Command Line
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 05ef9070-790c-405e-b5dd-a54cf31f1bd2
author: Femila
---
# Install an Additional Domain Controller by Using Unattend Parameters from the Command Line
  You can use the following procedure to install a new domain controller from the command line. In this method of installation, you type unattended installation parameters at the command line rather than creating an answer file. For a complete list of unattended installation options, including default values, allowed values, and descriptions, type **dcpromo \/?:Promotion** at a command prompt, or see Promotion Operation \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=120626](http://go.microsoft.com/fwlink/?LinkID=120626)\).  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To install an additional domain controller by entering unattended installation parameters at the command line  
  
-   At a command prompt, type the following command. When you have typed all the options that are required to create the additional domain controller, press ENTER.  
  
     `dcpromo /unattend /<unattendOption>:<value> /<unattendOption>:<value> ...`  
  
     Where:  
  
    -   `<unattendOption>` is an option in the Promotion Operation table. Separate each `<option:value>` pair with a space.  
  
    -   `<value>` is the configuration instruction for the option.  
  
     The following example creates an additional domain controller with the global catalog, and it installs and configures the DNS Server service:  
  
     `dcpromo /unattend /InstallDns:yes /confirmGC:yes /replicaOrNewDomain:replica /databasePath:"e:\ntds" /logPath:"e:\ntdslogs" /sysvolpath:"g:\sysvol" /safeModeAdminPassword:FH#3573.cK /rebootOnCompletion:yes`  
  
  