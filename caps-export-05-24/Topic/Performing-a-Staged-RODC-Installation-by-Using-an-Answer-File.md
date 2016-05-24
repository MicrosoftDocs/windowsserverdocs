---
title: Performing a Staged RODC Installation by Using an Answer File
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b17a6ea8-c819-46d1-870f-7b793fc3ed74
author: Femila
---
# Performing a Staged RODC Installation by Using an Answer File
  Use the following procedures to perform a staged installation of an RODC by using an answer file.  
  
## Performing a staged RODC installation by using an answer file  
 Use the following procedure to create an answer file for each stage of an RODC installation. In the first stage, you create an RODC account. In the next stage, you attach the server to the account. In this example, the DNS server and global catalog options are also installed but they are not mandatory. The site name is mandatory for an RODC installation. If you are adding multiple security principals to the RODC password replication policy, you must specify the appropriate entry \(Allowed or Denied\) on a separate line for each security principal.  
  
 For a complete list of unattended installation options, including default values, allowed values, and descriptions, see CreateDCAccount Operation \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=122101](http://go.microsoft.com/fwlink/?LinkId=122101)\) and UseExistingAccount Operation \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=122102](http://go.microsoft.com/fwlink/?LinkId=122102)\).  
  
### Creating the RODC account  
 Use the following procedure to create the RODC account.  
  
 **Administrative credentials**  
  
 To perform this procedure, you can use any account that has Read and Write permissions for the text editor application.  
  
##### To create an answer file for creating an RODC account  
  
1.  Open Notepad or any other text editor.  
  
2.  On the first line, type \[DCINSTALL\], and then press ENTER.  
  
3.  Type the following entries, one entry on each line:  
  
     ; Read\-Only Domain Controller Installation  
  
     ReplicaDomainDNSName\=*FullyQualifiedDomainName*  
  
     DCAccountName\=*RODCName*  
  
     ; RODC Password Replication Policy  
  
     PasswordReplicationDenied\=BUILTIN\\Administrators  
  
     PasswordReplicationDenied\="BUILTIN\\Server Operators"  
  
     PasswordReplicationDenied\="BUILTIN\\Backup Operators"  
  
     PasswordReplicationDenied\="BUILTIN\\Account Operators"  
  
     PasswordReplicationDenied\="*DomainName*\\Denied RODC Password Replication Group"  
  
     PasswordReplicationAllowed\=*GroupName1*  
  
     PasswordReplicationAllowed\=*GroupName2*  
  
     PasswordReplicationAllowed\=*User\_Name1*  
  
     PasswordReplicationAllowed\=*Computer\_Name1*  
  
     DelegatedAdmin\=*RODCAdministrator*  
  
     SiteName\=*SiteName*  
  
     InstallDNS\=Yes  
  
     ConfirmGc\=Yes  
  
     ReplicationSourceDC\=*SourceDCName*  
  
4.  Save the answer file to the location on the installation server from which it is to be called by Dcpromo, or save the file to a network shared folder or removable media for distribution.  
  
 Use the following table to replace the variables in the answer file with values that are appropriate for your organization.  
  
|Placeholder|Description|  
|-----------------|-----------------|  
|*FullyQualifiedDomainName*|The fully qualified domain name \(FQDN\) of the domain where you are installing the RODC.|  
|*RODCName*|The name of the server that will become the RODC.<br /><br /> Before anyone attempts to attach that server to the account that you are creating, it must be named with the name that you specify here and it must not be joined to the domain.|  
|*DomainName*|The single\-label DNS name or the FQDN of the domain where you are installing the RODC.|  
|*GroupName1, GroupName2, User\_Name1, Computer\_Name1,…*|The name of the security principal that you are adding to the password replication policy.<br /><br /> The account names must be enclosed within quotation marks.<br /><br /> When you specify the accounts of mobile users, also specify the computer accounts, such as laptop computers, that those users will use to log on to the RODC.|  
|*RODCAdministrator*|The name of the account to whom you are delegating installation and administrative right for the RODC.<br /><br /> You can specify only one user or group. As a best practice, specify the name of a group. Then, add to the group the account of any user that you want to manage the RODC.|  
|*SiteName*|The name of the site where you want to install the RODC.|  
|*SourceDCName*|The FQDN of the domain controller from which you replicate the domain information \(the installation partner\).|  
  
 After you create the answer file, use the following procedure to automate the creation of the RODC account.  
  
 **Administrative credentials**  
  
 To perform this procedure, you must be logged on to a domain controller as a member of the Domain Admins group or the Enterprise Admins group.  
  
##### To create an RODC account by using an answer file  
  
-   At the command prompt, type the following command, and then press ENTER:  
  
     `dcpromo.exe /CreateDCAccount /unattend:"<Path to answer file>"`  
  
### Attaching a server to an RODC account  
 Use the following procedure to create an answer file that you can use to attach a server to an RODC account.  
  
##### To create an answer file for attaching a server to an RODC account  
  
1.  Open Notepad or any other text editor.  
  
2.  On the first line, type \[DCINSTALL\], and then press ENTER.  
  
3.  Type the following entries, one entry on each line:  
  
     ; Read\-Only Domain Controller Installation  
  
     ReplicaDomainDNSName\=*FullyQualifiedDomainName*  
  
     UserDomain\=*FullyQualifiedDomainName*  
  
     UserName\=*DomainName*\\*User\_Name*  
  
     Password\=\*  
  
     DatabasePath\=*PathToDatabase*  
  
     LogPath\= *PathToLogFiles*  
  
     SYSVOLPath\= *PathToSYSVOL*  
  
     ; Set SafeModeAdminPassword to the correct value prior to using the answer file  
  
     SafeModeAdminPassword\=  
  
     ; CriticalReplicationOnly\=Yes  
  
     RebootOnCompletion\=Yes  
  
4.  Save the answer file to the location on the installation server from which it is to be called by Dcpromo, or save the file to a network shared folder or removable media for distribution.  
  
 Use the following table to replace the variables in the answer file with values that are appropriate for your organization.  
  
|Placeholder|Description|  
|-----------------|-----------------|  
|*FullyQualifiedDomainName*|The FQDN of the domain where you are installing the RODC. For UserDomain, enter the domain name for the user name \(account credentials\) that will be used to install a domain controller.|  
|*DomainName\\UserName*|The credentials of the user with the rights to attach the server to the RODC account, in the Windows NT format.<br /><br /> As a best practice, this user should be a member of a security group that has been delegated installation and administrative rights for the RODC. If you do not specify a user, only members of the Domain Admins group or the Enterprise Admins group can perform the operation.|  
|*PathToDatabase*|The location of the directory database, for example, C:\\Windows\\NTDS.|  
|*PathToLogFiles*|The location of the database log files, for example, C:\\Windows\\NTDS.|  
|*PathToSYSVOL*|The location of the SYSVOL shared folder, for example, C:\\Windows\\SYSVOL.|  
  
 After you create the answer file, use the following procedure to automate the operation for attaching the server to the RODC account. Before you begin this procedure, the server must be named with the name of the RODC account and it must not be joined to the domain.  
  
 **Administrative credentials**  
  
 Use the following procedure to attach a server to an RODC account. Because the server is not joined to the domain, log on to the server as the local Administrator.  
  
##### To attach a server to an RODC account by using an answer file  
  
-   At the command prompt, type the following command, and then press ENTER:  
  
     `dcpromo.exe /UseExistingAccount:Attach /unattend:"<Path to answer file>"`  
  
  