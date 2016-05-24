---
title: Installing an Additional Domain Controller by Using an Answer file
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 44486dd0-d422-4c1a-ad74-80a66198bc12
author: Femila
---
# Installing an Additional Domain Controller by Using an Answer file
  The answer file that you use to create a new domain controller must have the replica options specified. Use the following procedure to create the answer file.  
  
 **Administrative credentials**  
  
 To perform this procedure, you can use any account that has Read and Write permissions for the text editor application.  
  
### To create an answer file for installing a new domain controller  
  
1.  Open Notepad or any text editor.  
  
2.  On the first line, type \[DCINSTALL\], and then press ENTER.  
  
3.  Create the following entries, one entry on each line. These options are the minimum options that are required for a new domain controller installation with Domain Name System \(DNS\) and the global catalog installed and configured automatically. For a complete list of unattended installation options, including default values, allowed values, and descriptions, see [Promotion Operation](../Topic/Promotion-Operation.md).  
  
     UserName\=\<administrative account in the domain of the new domain controller\>  
  
     UserDomain\=\<name of the domain of the new domain controller\>  
  
     Password\=\<password for the account in UserName\>  
  
     ReplicaOrNewDomain\=replica  
  
     ReplicaDomainDNSName\=\<The name of the domain in which you want to add another domain controller\>  
  
     DatabasePath\=\<path to a folder on a local volume, surrounded by double quotation marks\>  
  
     LogPath\=\<path to a folder on a local volume, surrounded by double quotation marks\>  
  
     SYSVOLPath\=\<path to a folder on a local volume, surrounded by double quotation marks\>  
  
     InstallDNS\=yes  
  
     ConfirmGC\=yes  
  
     SafeModeAdminPassword\=\<password\>  
  
     RebootOnCompletion\=yes  
  
4.  Save the answer file to the location on the installation server from which it is to be called by Dcpromo, or save the file to a network shared folder or removable media for distribution.  
  
 After you create the answer file, use the following procedure to perform the unattended installation. Use this procedure to install AD DS on either a full installation or a Server Core installation of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
 **Administrative credentials**  
  
 To perform this procedure, you must be a member of the Domain Admins group.  
  
### To install a new domain controller by using an answer file  
  
-   At the command prompt, type the following command, and then press ENTER:  
  
     `dcpromo /unattend:"<path to the answer file>"`  
  
  