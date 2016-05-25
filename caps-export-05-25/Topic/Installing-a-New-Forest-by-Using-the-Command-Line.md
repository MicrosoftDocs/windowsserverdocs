---
title: Installing a New Forest by Using the Command Line
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: a68eae0d-ec73-4792-9e51-65167c76a484
author: Femila
---
# Installing a New Forest by Using the Command Line
  If you have a list of the unattended installation options and parameter values that you want to use to create a new forest, you can type the options and values directly at the command line. For a complete list of unattended installation options, including default values, allowed values, and descriptions, type **dcpromo \/?:Promotion** at a command prompt, or see [Promotion Operation](../Topic/Promotion-Operation.md).  
  
 As an alternative, you can use an answer file and then type additional unattended installation parameters and values at the same command line. In this case, the command\-line parameters are installed in addition to any parameters that are listed in the answer file. If the answer file and the command\-line parameters specify different values for the same option, the command\-line parameter value is used instead of the answer file value.  
  
 For example, suppose that you use an answer file that lists a blank Directory Services Restore Mode \(DSRM\) password, as in the following entry:  
  
 SafeModeAdminPassword\=  
  
 Then, you type the following command:  
  
 `Dcpromo /unattend:"<path to the answer file>" SafeModeAdminPassword=C^n3S7#jl`  
  
 In this example, the DSRM password is `C^n3S7#jl`. The correlating entry in the answer file is overwritten by the value that you type at the command line. However, all the other answer file entries are installed using the values that you specify in the answer file.  
  
 Use the following procedure to install a new forest as an unattended installation from the command line.  
  
 **Administrative credentials**  
  
 To perform this procedure, you must be logged on to the server as the local Administrator for the server. Depending on the operating system installation options that were selected for the computer, the local Administrator password might be blank or it might not be required. In this case, run the following command at a command prompt before you start to install AD DS:  
  
 `net user Administrator <password> /passwordreq:yes`  
  
 Replace `<password>` with a strong password.  
  
### To install a new domain controller by entering unattended installation parameters at the command line  
  
1.  At a command prompt, type the following command, and then press ENTER:  
  
     `dcpromo /unattend /<unattendOption>:<value> /<unattendOption>:<value> ...`  
  
     Where:  
  
    -   `<unattendOption>` is an option in the [Promotion Operation](../Topic/Promotion-Operation.md) table. Separate each `<option:value>` pair with a space.  
  
    -   `value` is the configuration instruction for the option.  
  
     The following example creates the first domain controller in a new forest where you expect to install at least some Windows Server 2003 domain controllers:  
  
     `dcpromo /unattend /InstallDns:yes /dnsOnNetwork:yes /replicaOrNewDomain:domain /newDomain:forest /newDomainDnsName:contoso.com /DomainNetbiosName:contoso /databasePath:"e:\Windows\ntds" /logPath:"e:\Windows\ntdslogs" /sysvolpath:"e:\Windows\sysvol" /safeModeAdminPassword:FH#3573.cK /forestLevel:2 /domainLevel:2 /rebootOnCompletion:yes`  
  
2.  When you have typed all the options that are required to create the forest, press ENTER.  
  
> [!NOTE]  
>  If you are using Active Directory\-integrated DNS, the IP address for the Preferred DNS server for the first domain controller in the forest is automatically set to the loopback address of 127.0.0.1. This helps assure that the IP address of the first domain controller will be resolved in DNS even if the address is changed.  
  
  