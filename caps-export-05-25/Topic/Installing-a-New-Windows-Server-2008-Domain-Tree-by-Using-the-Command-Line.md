---
title: Installing a New Windows Server 2008 Domain Tree by Using the Command Line
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: a23c7eff-fae6-4fb8-9f25-5516cfb75783
author: Femila
---
# Installing a New Windows Server 2008 Domain Tree by Using the Command Line
  Use the following procedure to perform an unattended installation of a new domain tree from the command line. For a complete list of unattended installation options, including default values, allowed values, and descriptions, type **dcpromo \/?:Promotion** at a command prompt, or see [Promotion Operation](../Topic/Promotion-Operation.md).  
  
 **Administrative credentials**  
  
 To perform this procedure, you must be a member of the Enterprise Admins group in the forest.  
  
#### To install a new domain tree by entering unattended installation parameters at the command line  
  
1.  At a command prompt, type the following command, and then press ENTER:  
  
     `dcpromo /unattend /<unattendOption>:<value> /<unattendOption>:<value> ...`  
  
     Where:  
  
    -   `<unattendOption>` is an option in the [Promotion Operation](../Topic/Promotion-Operation.md) table. Separate each `<option:value>` pair with a space.  
  
    -   `<value>` is the configuration instruction for the option.  
  
     The following example creates the first domain controller in a new domain tree where you expect to install at least some Windows Server 2003 domain controllers:  
  
     `dcpromo /unattend /InstallDns:yes /ParentDomainDNSName:<contoso.com> /replicaOrNewDomain:domain /newDomain:tree /newDomainDnsName:<treyresearch.net> /DomainNetbiosName:<trey> /databasePath:"<e:\Windows\ntds>" /logPath:"<e:\Windows\ntds>" /sysvolpath:"<e:\Windows\sysvol>" /safeModeAdminPassword:<FH#3573.cK> /forestLevel:2 /domainLevel:2 /rebootOnCompletion:yes`  
  
2.  When you have typed all the options that are required to create the child domain, press ENTER.  
  
  