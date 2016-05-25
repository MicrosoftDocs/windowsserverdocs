---
title: Installing a New Windows Server 2008 Child Domain by Using the Command Line
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: ae6135cb-88f6-4fb5-ab36-107b004840e3
author: Femila
---
# Installing a New Windows Server 2008 Child Domain by Using the Command Line
  Use the following procedure to perform an unattended installation of a new child domain from the command line. For a complete list of unattended installation options, including default values, allowed values, and descriptions, type **dcpromo \/?:Promotion** at a command prompt, or see [Promotion Operation](../Topic/Promotion-Operation.md).  
  
 **Administrative credentials**  
  
 To perform this procedure, you must be a member of the Enterprise Admins group in the forest.  
  
### To install a new child domain by entering unattended installation parameters at the command line  
  
1.  At a command prompt, type the following command, and then press ENTER:  
  
     `dcpromo /unattend /<unattendOption>:<value> /<unattendOption>:<value> ...`  
  
     Where:  
  
    -   `unattendOption` is an option in the [Promotion Operation](../Topic/Promotion-Operation.md) table. Separate each `option:value` pair with a space.  
  
    -   `value` is the configuration instruction for the option.  
  
     The following example creates the first domain controller in a new child domain where you expect to install only domain controllers that run [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]:  
  
     `dcpromo /unattend /InstallDns:yes /ParentDomainDNSName:<contoso.com> /replicaOrNewDomain:domain /newDomain:child /newDomainDnsName:<noam.contoso.com> /childName:<noam> /DomainNetbiosName:<noam> /databasePath:"<e:\Windows\ntds>" /logPath:"<e:\Windows\ntds>" /sysvolpath:"<e:\Windows\sysvol>" /safeModeAdminPassword:<FH#3573.cK> /forestLevel:4 /domainLevel:4 /rebootOnCompletion:yes`  
  
2.  When you have typed all the options that are required to create the child domain, press ENTER.  
  
  