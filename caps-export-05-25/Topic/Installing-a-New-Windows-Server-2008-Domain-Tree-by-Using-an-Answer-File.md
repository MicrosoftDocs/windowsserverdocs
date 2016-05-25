---
title: Installing a New Windows Server 2008 Domain Tree by Using an Answer File
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d94288ec-62eb-4f17-add9-341cefedb804
author: Femila
---
# Installing a New Windows Server 2008 Domain Tree by Using an Answer File
  You can use the following procedure to create an answer file and then use that answer file to create a new domain tree. This procedure identifies only the essential answer file entries for creating a new domain tree. For a complete list of unattended installation options, including default values, allowed values, and return codes, see [Promotion Operation](../Topic/Promotion-Operation.md).  
  
 **Administrative credentials**  
  
 To perform this procedure, you can use any account that has Read and Write permissions for the text editor application.  
  
### To create an answer file for installing a new domain  
  
1.  Open Notepad or any text editor.  
  
2.  On the first line, type \[DCINSTALL\], and then press ENTER.  
  
3.  Create the following entries, one entry on each line. These options are the minimum options that are required for a new domain installation with Domain Name System \(DNS\) configured automatically. For a complete list of unattended installation options, including default values, allowed values, and descriptions, see [Promotion Operation](../Topic/Promotion-Operation.md).  
  
     ParentDomainDNSName\=\<fully qualified domain name \(FQDN\) of the parent domain\>  
  
     UserName\=\<administrative account in the parent domain\>  
  
     Password\=\<specify \* to have the user be prompted for credentials during the installation\>  
  
     NewDomain\=tree  
  
     ChildName\=\<Single\-label DNS name of the new domain\>  
  
     NewDomainDNSName\=\<FQDN of the new domain\>  
  
     DomainNetBiosName\=\<usually, first label of the FQDN\>  
  
     ReplicaOrNewDomain\=domain  
  
     DomainLevel\=\<domain functional level number\>  
  
     DatabasePath\=\<path to a folder on a local volume, surrounded by double quotation marks\>  
  
     LogPath\=\<path to a folder on a local volume, surrounded by double quotation marks\>  
  
     SYSVOLPath\=\<path to a folder on a local volume, surrounded by double quotation marks\>  
  
     InstallDNS\=yes  
  
     CreateDNSDelegation\=yes  
  
     DNSDelegationUserName\=\<If the account that is being used to install AD DS is different than the account in the parent domain that has the credentials that are required to create a DNS delegation, specify the account that can create the DNS delegation for this parameter; specify \* to have the user be prompted for credentials during the installation.\>  
  
     DNSDelegationPassword\=\<The password for the account that is specified for DNSDelegationUserName; specify \* to have the user be prompted for credentials during the installation.\>  
  
     SafeModeAdminPassword\=\<password\>  
  
     RebootOnCompletion\=yes  
  
4.  Save the answer file to the location on the installation server from which it is to be called by Dcpromo, or save the file to a network share or removable media for distribution.  
  
 After you create the answer file, use the following procedure to perform the unattended installation. Use this procedure to install AD DS on either a full installation or a Server Core installation of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
 **Administrative credentials**  
  
 To perform this procedure, you must be a member of the Enterprise Admins group in the forest.  
  
### To install a new child domain by using an answer file  
  
-   At the command prompt, type the following command, and then press ENTER:  
  
     `dcpromo /unattend:"<path to the answer file>"`  
  
  