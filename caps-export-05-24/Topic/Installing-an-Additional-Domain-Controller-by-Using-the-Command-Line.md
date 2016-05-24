---
title: Installing an Additional Domain Controller by Using the Command Line
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: e8bc41fb-24d1-47c4-b5de-d2e0428610e2
author: Femila
---
# Installing an Additional Domain Controller by Using the Command Line
  Use the following procedure to perform an unattended installation of a new domain controller from the command line. For a complete list of unattended installation options, including default values, allowed values, and descriptions, type **dcpromo \/?:Promotion** at a command prompt, or see [Promotion Operation](../Topic/Promotion-Operation.md).  
  
 **Administrative credentials**  
  
 To perform this procedure, you must be a member of the Domain Admins group.  
  
### To install a new domain controller by entering unattended installation parameters at the command line  
  
1.  At a command prompt, type the following, and then press ENTER:  
  
     **dcpromo \/unattend \/** *unattendOption* **:** *value*  **\/** *unattendOption* **:** *value*  **...**  
  
     Where  
  
    -   *unattendOption* is an option in the [Promotion Operation](../Topic/Promotion-Operation.md) table. Separate each *option:value* pair with a space.  
  
    -   *value* is the configuration instruction for the option.  
  
     The following example creates an additional domain controller with the global catalog and installs and configures DNS Server service:  
  
     `dcpromo /unattend /InstallDns:yes /confirmGC:yes /replicaOrNewDomain:replica /replicaDomainDNSName:contoso.com /databasePath:"e:\Windows\ntds" /logPath:"e:\Windows\ntds" /sysvolpath:"e:\Windows\sysvol"  /safeModeAdminPassword: FH#3573.cK /rebootOnCompletion:yes`  
  
2.  When you have typed all the options that are required to create the additional domain controller, press ENTER.  
  
  