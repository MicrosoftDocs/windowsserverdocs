---
title: Create an Answer File for Unattended Domain Controller Installation
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d17862f1-c080-4a2d-a967-e5b2fcea38a1
author: Femila
---
# Create an Answer File for Unattended Domain Controller Installation
  You can use this procedure to create a text file that you can use as the answer file for an unattended installation of an additional domain controller. Use the answer file to install Active Directory Domain Services \(AD DS\) on either a full installation of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or a Server Core installation of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. The answer file contains sensitive information, and it should be kept in a secure location.  
  
> [!NOTE]  
>  The answer file that you use to install an additional domain controller in an existing domain must have the **\/ReplicaOrNewDomain** and **\/ReplicaDomainDNSName** parameters specified.  
>   
>  The answer file that you use to install a domain controller from media must have the **\/ReplicationSourcePath** parameter specified.  
  
 Any account that has Read and Write privileges for the text editor application is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To create an answer file for installing a new domain controller  
  
1.  Open Notepad or any text editor.  
  
2.  On the first line, type **\[DCINSTALL\]**, and then press ENTER.  
  
3.  Create the following entries, one entry on each line. These options are the minimum options that are required for an additional domain controller installation with Domain Name System \(DNS\) and the global catalog installed and configured automatically.  
  
     For a complete list of unattended installation options, including default values, allowed values, and descriptions, see Promotion Operation \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=120626](http://go.microsoft.com/fwlink/?LinkID=120626)\).  
  
     **UserName**\=*SAM account name that has Domain Admins credentials in the target domain.* This account must be used by the administrator who runs the Dcpromo command.  
  
     **UserDomain**\=*Domain name for the user account in* **UserName**  
  
     **Password**\=*Password for the account in UserName.* If you leave this blank, Dcpromo prompts the installer for a password during installation. Dcpromo deletes this value after installation.  
  
     **ReplicaDomainDNSName\=** *The fully qualified domain name \(FQDN\) of the domain of the new domain controller.*  
  
     **ReplicaOrNewDomain**\=**Replica** for an additional domain controller in an existing domain or **Domain** for the first domain controller in a new domain.  
  
     **DatabasePath**\=*Location of the Ntds.dit file—a folder on a local volume, surrounded by double quotation marks.* \(The default is “%systemroot%\\ntds”.\) If you omit this entry, Dcpromo uses the default location.  
  
     **LogPath**\=*Location of the database log files—a folder on a local volume, surrounded by double quotation marks.* \(The default is “%systemroot%\\ntds”.\) If you omit this entry, Dcpromo uses the default location.  
  
     **SYSVOLPath**\=*Location of the SYSVOL tree—a folder on a local volume, surrounded by double quotation marks.* \(The default is “%systemroot%\\SYSVOL”.\) If you omit this entry, Dcpromo uses the default location.  
  
     **InstallDNS**\=**Yes** to make the domain controller a DNS server or **no** to create a domain controller without DNS installed.  
  
     **ConfirmGC**\=**Yes** to make the domain controller a global catalog server or **No** to create a domain controller without the global catalog read\-only directory partitions.  
  
     **SafeModeAdminPassword**\=*Password for the administrator account that must be used to start the domain controller in Directory Services Restore Mode \(DSRM\).* If you leave this blank, Dcpromo prompts the installer for the password during installation. Dcpromo deletes this value after installation. Passwords are removed from the answer file when you run Dcpromo.  
  
     **RebootOnCompletion**\=**Yes** if you want the domain controller to restart automatically following a successful installation, **no** if you want to restart the domain controller manually. If you do not want the domain controller to restart automatically and you do not want to be prompted, use the value **NoAndNoPromptEither**.  
  
4.  If you want to include application directory partitions in the answer file, add the following parameter:  
  
     **ApplicationPartitionsToReplicate\=**  
  
     Provide a value for **ApplicationPartitionsToReplicate** as follows:  
  
    -   If you want to include all application directory partitions, use the value **\***.  
  
    -   If you want to include specific application directory partitions, type the distinguished name of each directory partition. Separate each distinguished name with a space, and enclose the entire list in quotation marks, as shown in the following example:  
  
         **ApplicationPartitionsToReplicate\="dc\=app1,dc\=contoso,dc\=com dc\=app2,dc\=contoso,dc\=com"**  
  
5.  Save the answer file to the location on the installation server from which it is to be called by Dcpromo, or save the file to a network shared folder or removable media for distribution.  
  
## See Also  
 [Install an Additional Domain Controller by Using an Answer File](../Topic/Install-an-Additional-Domain-Controller-by-Using-an-Answer-File.md)   
 [Install an Additional Domain Controller by Using Unattend Parameters from the Command Line](../Topic/Install-an-Additional-Domain-Controller-by-Using-Unattend-Parameters-from-the-Command-Line.md)  
  
  