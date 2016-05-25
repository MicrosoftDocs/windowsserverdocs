---
title: Performing a Staged RODC Installation by Using the Command Line
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 565833f5-c2d5-45bc-95b5-e7a3da46c509
author: Femila
---
# Performing a Staged RODC Installation by Using the Command Line
  Use the following procedures to perform a staged installation of an RODC from the command line.  
  
## Performing a staged RODC installation by entering installation parameters at the command line  
 Although we recommend that you create an RODC account by using the Windows interface because it reduces the chance for typing errors, you can use the following procedure to create an RODC account—using unattended installation parameters—from the command line. If you are creating an RODC account on a domain controller that is running a Server Core installation of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you cannot use the Windows interface.  
  
 **Administrative credentials**  
  
 To perform this procedure, you must be logged on to a domain controller as a member of the Domain Admins group or the Enterprise Admins group.  
  
#### To create an RODC account by entering unattended installation parameters at the command line  
  
1.  At a command prompt, type the following command, and then press ENTER:  
  
    ```  
    dcpromo /unattend /CreateDCAccount /ReplicaDomainDNSName:<DomainName> /DCAccountName:<RODCName> /SiteName:<SiteName> /<unattendOption>:<value> /<unattendOption>:<value> ...  
    ```  
  
     Where:  
  
    -   `<DomainName>` is the name of the domain where you are creating the RODC account.  
  
    -   `<RODCName>` is the name of the RODC account that you want to create.  
  
    -   `<SiteName>` is the name of the site where you want to create the RODC account.  
  
    -   `<unattendOption>` is an option in the CreateDCAccount Operation \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=122101](http://go.microsoft.com/fwlink/?LinkId=122101)\) table. Separate each `<option>:<value>` pair with a space.  
  
    -   `<value>` is the configuration instruction for the option.  
  
     The following example creates an RODC account named RODC10 in the contoso.com domain in the Default\-First\-Site\-Name site with additional installation options:  
  
    ```  
    dcpromo /CreateDCAccount /ReplicaDomainDNSName: contoso.com /DCAccountName:RODC10 /SiteName:Default-First-Site-Name /SourceDC:DC1.contoso.com /PasswordReplicationDenied=BUILTIN\Administrators /PasswordReplicationDenied="BUILTIN\Server Operators" /PasswordReplicationDenied="BUILTIN\Backup Operators" /PasswordReplicationDenied="BUILTIN\Account Operators" /PasswordReplicationDenied="Contoso\Denied RODC Password Replication Group" /PasswordReplicationAllowed="Group Name1" /PasswordReplicationAllowed="Group Name2" /PasswordReplicationAllowed="User Name1" /PasswordReplicationAllowed=ComputerName1 /DelegatedAdmin=BranchAdminGroup  
    ```  
  
2.  When you finish typing all the options that are required to create the RODC account, press ENTER.  
  
 After you create the RODC account, perform the following procedure on the server that will become the RODC to attach that server to the RODC account.  
  
 **Administrative credentials**  
  
 Because the server is not joined to the domain, log on to the server as the local Administrator.  
  
#### To attach a server to an RODC account by entering unattended installation parameters at the command line  
  
1.  At a command prompt, type the following command, and then press ENTER:  
  
    ```  
    dcpromo /unattend /UseExistingAccount:Attach /ReplicaDomainDNSName:<FullyQualifiedDomainName> /UserDomain:<FullyQualifiedDomainName> /UserName:<DomainName>\<UserName> /password:* /<unattendOption>:<value> /<unattendOption>:<value> ...  
    ```  
  
     Where:  
  
    -   `<FullyQualifiedDomainName>` is the FQDN of the domain where you are installing the RODC. For `/UserDomain`, enter the domain name for the user name \(that is, account credentials\) that will be used to install a domain controller.  
  
    -   `<DomainName>\<UserName>` is the account credentials of the user with the rights to attach the server to the RODC account, in the Windows NT format.  
  
    -   `<unattendOption>` is an option in the UseExistingAccount Operation \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=122102](http://go.microsoft.com/fwlink/?LinkId=122102)\) table. Separate each `<option>:<value>` pair with a space.  
  
    -   `<value>` is the configuration instruction for the option.  
  
     The following example attaches a server to an RODC account in the contoso.com domain with additional installation options, using the domain credentials of the contoso\\da1 account:  
  
    ```  
    dcpromo /unattend /UseExistingAccount:Attach /ReplicaDomainDNSName: contoso.com /UserDomain:contoso.com /UserName:contoso\da1 /password:* /databasePath:"e:\Windows\ntds" /logPath:"e:\Windows\ntds" /sysvolpath:"e:\Windows\sysvol" /safeModeAdminPassword:FH#3573.cK /rebootOnCompletion:yes  
    ```  
  
2.  When you finish typing all the options that are required to create the RODC account, press ENTER.  
  
  