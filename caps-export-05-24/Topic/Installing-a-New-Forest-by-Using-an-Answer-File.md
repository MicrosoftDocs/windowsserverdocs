---
title: Installing a New Forest by Using an Answer File
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 020fb9f5-3597-4adc-a5c3-63e94fc78e89
author: Femila
---
# Installing a New Forest by Using an Answer File
  You can use the unattended installation method to install Active Directory Domain Services \(AD DS\) to create a new forest on a full installation or on a Server Core installation of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. To use the unattended method of installation, you must first prepare an answer file that contains configuration values.  
  
 Use the following procedure to create the answer file. For a complete list of unattended installation options, including default values, allowed values, and descriptions, type **dcpromo \/?:Promotion** at a command prompt, or see [Promotion Operation](../Topic/Promotion-Operation.md).  
  
 **Administrative credentials**  
  
 To perform this procedure, you can use any account that has Read and Write privileges for the text editor application.  
  
### To create an answer file for installing a new forest  
  
1.  Open Notepad or any other text editor.  
  
2.  On the first line, type \[DCINSTALL\], and then press ENTER.  
  
3.  Type the following entries, one entry on each line:  
  
     InstallDNS\=yes  
  
     NewDomain\=forest  
  
     NewDomainDNSName\=\<fully qualified domain name \(FQDN\)\>  
  
    > [!NOTE]  
    >  [!INCLUDE[ad_dcpromotext](../Token/ad_dcpromotext_md.md)]  
  
     DomainNetBiosName\=\<first label of the FQDN, by default\>  
  
     ReplicaOrNewDomain\=domain  
  
     ForestLevel\=\<forest functional level number\>  
  
     DomainLevel\=\<domain functional level number\>  
  
     DatabasePath\=\<path to a folder on a local volume, surrounded by double quotation marks\>  
  
     LogPath\=\<path to a folder on a local volume, surrounded by double quotation marks\>  
  
     SYSVOLPath\=\<path to a folder on a local volume, surrounded by double quotation marks\>  
  
     SafeModeAdminPassword\=\<password\>  
  
     If you do not want to include the Directory Services Restore Mode \(DSRM\) password in the answer file, you can leave this entry blank and instead specify its value at the command line when you run Dcpromo and specify the path to the answer file. For more information, see "To install a new domain controller by entering unattended installation parameters at the command line" in [Installing a New Forest by Using the Command Line](../Topic/Installing-a-New-Forest-by-Using-the-Command-Line.md).  
  
4.  Save the answer file to the location on the installation server from which it is to be called by Dcpromo, or save the file to a network shared folder or removable media for distribution.  
  
 After you create the answer file, use the following procedure to perform the unattended installation. Use this procedure to install AD DS on either a full installation or a Server Core installation of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
 **Administrative credentials**  
  
 To perform this procedure, you must be logged on as the local Administrator for the computer. Depending on the operating system installation options that were selected for the computer, the local Administrator password might be blank or it might not be required. In this case, run the following command at a command prompt before you start to install AD DS:  
  
 `net user Administrator <password> /passwordreq:yes`  
  
 Replace `<password>` with a strong password.  
  
### To install a new domain controller by using an answer file  
  
-   At the command prompt, type the following command, and then press ENTER:  
  
     `dcpromo /unattend:"<path to the answer file>"`  
  
> [!NOTE]  
>  If you are using Active Directory\-integrated DNS, the IP address for the Preferred DNS server for the first domain controller in the forest is automatically set to the loopback address of 127.0.0.1. This helps assure that the IP address of the first domain controller will be resolved in DNS even if the address is changed.  
  
  