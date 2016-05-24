---
title: File and Storage Services: Migrate Network File System
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dc955cea-fb48-44d7-a373-d2bb89faad70
---
# File and Storage Services: Migrate Network File System
This topic describes how to migrate Network File System shares and settings from previous versions of Windows Server to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
## Network File System Migration overview  
You can migrate Network File System \(NFS\) from a server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], Windows Server°2008, or Windows Server°2003°R2 to a server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] using the procedures described in this topic. Some of the methods that are available for migrating NFS are the following:  
  
-   You can gather output from NFS servers running on previous versions of Windows Server, and then modify and use this information to input into the new NFS server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. This can be done using the NFS cmdlets in Windows PowerShell, or using command tools such as **nfsshare** and **nfsadmin**.  
  
-   You can gather output from the NFS servers running on previous versions of Windows Server, and then use this information as a reference when manually configuring NFS settings for the new NFS server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. This can be done using the NFS cmdlets in Windows PowerShell or the File Server Administration Console in Server Manager.  
  
## <a name="BKMK_migratews2012toR2"></a>Migrating NFS Server from Windows Server°2012 to Windows Server°2012°R2  
This section explains how to migrate NFS shares and permissions from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Introduced in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the NFS cmdlets in Windows PowerShell allow you to manage NFS shares and settings, export shares and configuration metadata to .xml files, and then import the files into [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. During this process, UNIX or Linux\-based style group and password files are copied to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. If you used Active Directory Lightweight Directory Services \(AD°LDS\) to configure name mapping, see [Active Directory Lightweight Directory Services Overview](http://technet.microsoft.com/library/hh831593.aspx).  
  
### Export the server configuration  
Before starting the export process, you must first create a directory \(for example C:\\tmp\) where all the files will be exported.  
  
Open Windows PowerShell, and to export the NFS server configuration information, type:  
  
```  
PS C:\tmp> Get-NfsServerConfiguration | Export-Clixml NfsServerConfig.xml  
```  
  
### Export NFS shares  
To export the NFS share settings information, open Windows PowerShell, and type the following. Note that this procedure does not include exporting the NFS share permissions.  
  
```  
PS C:\tmp> Get-NfsShare | Export-Clixml NfsShares.xml  
```  
  
Next, update the host configuration information using the following steps. You can ignore these steps if the net name and host names are going to remain the same.  
  
1.  Open the file where the exported shares are located \(for example, c:\\tmp\\NfsShares.xml\).  
  
2.  Find the network name and host name, and then rename them as appropriate.  
  
3.  If necessary, update the location of the directory path.  
  
4.  Save the file that contains the exported shares \(such as c:\\tmp\\NfsShares.xml\).  
  
### Export NFS share permissions  
To export the NFS share permissions for all the NFS shares, type:  
  
```  
PS C:\tmp> Get-NfsShare | Get-NfsSharePermission | Export-Clixml NfsSharePermission.xml  
```  
  
Next, update the host configuration information using the following steps. You can ignore these steps if the net name and host names are going to remain the same.  
  
1.  Open the file where the exported permissions are located \(for example, c:\\tmp\\NfsSharePermission.xml\).  
  
2.  Find the network name and host name, and then rename them as appropriate.  
  
3.  If necessary, update the location of the directory path.  
  
4.  Save the file that contains the exported permissions \(such as c:\\tmp\\NfsShares.xml\).  
  
### Copy local mapping data  
If you are using the UNIX or Linux\-based local password and group files to map between UNIX and Linux\-based users and Windows, copy the following files from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. You can ignore this step if you are not using UNIX or Linux\-based local password and group files.  
  
```  
PS C:\tmp> COPY %SystemRoot%\system32\drivers\etc\passwd C:\tmp  
PS C:\tmp> COPY %SystemRoot%\system32\drivers\etc\group C:\tmp  
```  
  
### Export identity mapping  
In Windows PowerShell, type the following to display identity mapping information \(such as Lightweight Directory Access Protocol or AD LDS\) used by the NFS Server. This information must be manually recreated in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. If no identity mapping stores are configured, you can ignore this step.  
  
```  
PS C:\tmp> Get-NfsMappingStore | Export-Clixml nfsmappingstore.xml  
```  
  
> [!NOTE]  
> The group and user identity mapping are expected to remain the same after the migration.  
  
### Export netgroups and client groups  
Configuring netgroups and client groups makes it easier to manage computer and user authentication. In Windows PowerShell, type the following to display information about netgroups and client groups, which can then be exported to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
```  
PS C:\tmp> Get-NfsNetgroup | Export-Clixml nfsnetgroup.xml  
PS C:\tmp> Get-NfsNetgroupStore | Export-Clixml nfsnetgroupstore.xml  
PS C:\tmp> Get-NfsClientGroup | Export-Clixml nfsclientgroup.xml  
```  
  
## <a name="BKMK_importtoR2fromws2012"></a>Importing NFS shares and settings from Windows Server°2012 to Windows Server°2012°R2  
This section describes how to import NFS shares and settings that you exported from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. First, create a directory \(for example C:\\tmp\) on the computer running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and copy all the files exported from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
> [!NOTE]  
> The settings for NFS shares are metadata used over existing volumes and directories. Therefore, you should make sure the data and directory structure are correct before NFS share settings are applied. After the directory structure is in place, you can proceed to the following procedure. For more information about data migration, see [Impact of data migration by copying data and shared folders](../Topic/Migrate-File-and-Storage-Services-to-Windows-Server-2012-R2.md#BKMK_datashare).  
  
### Import the server configuration  
Before importing the server configuration, make sure that you have installed the **Server for NFS** role service in Server Manager. To import the server configuration, open Windows PowerShell, and type:  
  
```  
PS C:\tmp> Import-Clixml NfsServerConfig.xml | Set-NfsServerConfiguration  
```  
  
Restart **Server for NFS** by using either **Control Panel** or by typing `Restart-Service NfsService` at a command prompt.  
  
### Import NFS shares  
Before performing this step, make sure that the directory structure is already in place and that the Nfsshares.xml file is updated with the appropriate location, server names, and any additional important information.  
  
To import NFS share settings, open Windows PowerShell, and type:  
  
```  
PS C:\tmp> Import-Clixml NfsShares.xml | %{New-NfsShare -Name $_.Name -Path $_.Path -NetworkName $_.NetworkName -EnableAnonymousAccess  
$_.AnonymousAccess -AnonymousUid $_.AnonymousUid -AnonymousGid $_.AnonymousGid -EnableUnmappedAccess  
$_.UnmappedUserAccess -Authentication $_.Authentication}  
```  
  
You should resolve any errors before proceeding to the next step.  
  
### Import NFS share permissions  
Before performing this step, make sure that the Nfssharepermission.xml file is updated with the correct server names. To import NFS share permissions, open Windows PowerShell, and type:  
  
```  
PS C:\tmp> Import-Clixml NfsSharePermission.xml | foreach { $_ |Grant-NfsSharePermission}  
```  
  
### Import local mapping data  
If UNIX and Linux\-based local password and group files are used for mapping between UNIX and Linux users and Windows, copy the following files \(which were exported from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]\). You can ignore this step if you do not use UNIX and Linux\-based password and group files.  
  
```  
PS C:\tmp> COPY  C:\tmp\passwd %SystemRoot%\system32\drivers\etc\passwd  
PS C:\tmp> COPY C:\tmp\group %SystemRoot%\system32\drivers\etc\group  
```  
  
### Import non\-local identity mapping  
If you are using methods, such as LDAP or AD LDS, to configure identity mapping, use the following Windows PowerShell script to import the .xml file:  
  
```  
PS C:\tmp> Import-Clixml nfsmappingstore.xml | Set-NfsMappingStore  
```  
  
### Import netgroups and client groups  
In Windows PowerShell, type the following to export netgroups and client groups to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]:  
  
```  
PS C:\tmp> Import-Clixml nfsnetgroup.xml | Set-NfsNetgroup  
PS C:\tmp> Import-Clixml nfsnetgroupstore.xml | Set-NfsNetgroupStore  
PS C:\tmp> Import-Clixml nfsclientgroup.xml | Set-NfsClientGroup  
```  
  
After the netgroups and client groups are defined, permission to access shares that an NFS server exports can be configured using the [Grant\-NfsSharePermission](http://technet.microsoft.com/library/jj603090.aspx) Windows PowerShell cmdlet. Some examples for granting share permissions are shown in the following generated information in Windows PowerShell:  
  
```  
PS C:\> New-NfsClientgroup -ClientGroupName MIGRATION -AddMember 'MACHINE1','MACHINE2'  
PS C:\> Get-NfsClientgroup MIGRATION  
ClientGroupName                                             ClientGroupMembers  
---------------                                             ------------------  
MIGRATION                                                   {MACHINE1, MACHINE2}  
PS C:\> Grant-NfsSharePermission -Name NfsTestShare1 -ClientName MIGRATION -ClientType clientgroup -Permission readonly  
PS C:\> Get-NfsSharePermission NfsTestShare1  
Name                  ClientName              Permission        AllowRootAccess  
----                  ----------              ----------      ---------------  
NFSTestShare1          MIGRATION                 READ              False  
```  
  
If you are using Unmapped UNIX User Access \(UUUA\), see [NFS Identity Mapping in Windows Server 2012](http://blogs.technet.com/b/filecab/archive/2012/10/09/nfs-identity-mapping-in-windows-server-2012.aspx), which provides information about the various methods of identity mapping. You should note that both [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] support UNIX and Linux\-based password and group files.  
  
NFS server and share settings migration from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is complete.  
  
## <a name="BKMK_migratefromws2008"></a>Migrating NFS Server from Windows Server°2008°R2, Windows Server°2008, or Windows Server°2003°R2 to Windows Server°2012°R2  
This section describes how to migrate NFS shares and permissions from [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and earlier versions of the Windows Server operating system to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Using the command\-line tools, **nfsshare** and **nfsadmin**, you can export NFS shares and settings, and then import the files into [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
### Get server configuration  
To retrieve information from the NFS server configuration, type the following at a command prompt:  
  
```  
C:\tmp> nfsadmin server  
```  
  
After running the command, create a copy of the information that is generated. An example of output from [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] follows:  
  
```  
The following are the settings on localhost  
  
Locking Daemon Grace Period : 45 seconds    
Activity logging Settings   :  
Protocol for Portmap        : TCP+UDP        
Protocol for Mount          : TCP+UDP        
Protocol for NFS            : TCP+UDP        
Protocol for NLM            : TCP+UDP        
Protocol for NSM            : TCP+UDP        
Protocol for Mapping Server : TCP+UDP        
Protocol for NIS            : TCP+UDP        
Enable NFS V3 Support       : Enabled        
Renew Authentication        : Enabled        
Renew Authentication Interval : 600 seconds   
Directory Cache             : 128 KB          
Translation File Name       :                 
Dot Files Hidden            : Disabled        
Case Sensitive Lookups      : Enabled         
NTFS Case                   : Preserve Case  
NetGroup Source             : none  
NIS Server                  :  
NIS Domain                  :  
LDAP Server or AD Domain    :  
LDAP naming context (DN)    :  
```  
  
### Collect NFS shares information  
You can display NFS share settings by using the following commands. You should note that running these commands does not display NFS share permissions.  
  
To retrieve the list of NFS shares configured in the server, type the following at a command prompt:  
  
```  
C:\tmp> nfsshare  
```  
  
To retrieve detailed information for each NFS share listed after using the preceding command, type:  
  
```  
C:\tmp> nfsshare <share-name>  
```  
  
Example output:  
  
```  
C:\tmp> nfsshare  
        share1 = C:\shares\share1  
        share2 = C:\shares\share2  
C:\tmp> nfsshare share1  
   Alias = share1  
   Path = C:\shares\share1  
   Supported security flavors are SYS:KRB5:KRB5I  
   Encoding = ansi  
   UNMAPPED UNIX USER access allowed  
   ANONYMOUS access disallowed  
   Anonymous UID = -2  
   Anonymous GID = -2  
   HOST ACCESS :  
      ALL MACHINES            read-write     Root Access Allowed      ansi  
```  
  
> [!NOTE]  
> Kerberos authentication was introduced in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] for use with NFS, and therefore, so it is not available in earlier versions of the operating system.  
  
### Collect identity mapping and group identifier information  
To display identity mapping settings \(such as the Network Information Service \[NIS\] server, NIS domain, and LDAP or AD LDS information\), type the following at a command prompt:  
  
```  
C:\tmp> nfsadmin server  
```  
  
To display the identity mapping methods that are used, type:  
  
```  
C:\tmp> nfsadmin mapping  
```  
  
Example output:  
  
```  
C:\tmp> nfsadmin mapping  
The following are the settings on localhost  
Mapping Server Lookup       : Disabled  
Mapping Server              :  
AD Lookup                   : Disabled  
AD Domain                   :  
```  
  
To display the names of all client groups, type:  
  
```  
C:\tmp\nfsadmin server listgroups   
C:\tmp\nfsadmin server listmembers <client group name>  
```  
  
## <a name="BKMK_setupR2fromprevious"></a>Reconfiguring NFS shares and settings from Windows Server°2008°R2, Windows Server°2008, or Windows Server°2003°R2 to Windows Server°2012°R2  
This section explains the process of reconfiguring the NFS shares and settings that you exported from [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or previous versions of Windows Server to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. You can reconfigure NFS shares and settings using the **nfsshare** or **nfsadmin** command tools, or, if you are migrating from [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you can use the NFS cmdlets in Windows PowerShell.  
  
Before you import NFS shares and settings, make sure that you have installed the **Server for NFS** role service in **Server Manager** on the computer running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
The settings for NFS shares are metadata used over existing volumes and directories. Therefore, you should make sure the data and directory structure are correct before NFS share settings are applied. After the directory structure is in place, you can proceed to the following procedure. For more information about data migration, see [Impact of data migration by copying data and shared folders](../Topic/Migrate-File-and-Storage-Services-to-Windows-Server-2012-R2.md#BKMK_datashare).  
  
### Set up the NFS server configuration  
To configure the NFS server, type the following in Windows PowerShell. Instructions for setting up the NFS server using the **nfsadmin** command are provided later in this section.  
  
In Windows PowerShell, type:  
  
```  
PS C:\tmp> Set-NfsServerConfiguration  -[parameters as displayed below]  
```  
  
|Windows Server°2008°R2 output|Equivalent Windows PowerShell cmdlet parameters in Windows Server°2012°R2|  
|---------------------------------|-----------------------------------------------------------------------------|  
|Locking daemon grace period|GracePeriodSec|  
|Protocol for Portmap|PortmapProtocol|  
|Protocol for Mount|MountProtocol|  
|Protocol for NFS|NfsProtocol|  
|Protocol for NLM|NlmProtocol|  
|Protocol for NSM|NsmProtocol|  
|Protocol for Mapping Server|MapServerProtocol|  
|Protocol for NIS|NisProtocol|  
|Enable NFS V3 support|EnableNFSV3|  
|Renew Authentication|EnableAuthenticationRenewal|  
|Renew Authentication Interval|AuthenticationRenewalIntervalSec|  
|Directory Cache|DirectoryCacheSize|  
|Translation File Name|CharacterTranslationFile|  
|Dot Files Hidden|HideFilesBeginningInDot|  
|Activity Logging Setting|LogActivity|  
  
> [!NOTE]  
> In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], there is a new parameter *LeasePeriodSec* for the [Set\-NfsServerConfiguration](http://technet.microsoft.com/library/jj603105.aspx) Windows PowerShell cmdlet. When setting the *GracePeriodSec* value, make sure that the *LeasePeriodSec* value is set to 50 percent of *GracePeriodSec*.  
>   
> Case\-sensitive file lookups and case\-sensitive preservation can no longer be configured in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] because they are now system\-wide Windows settings.  
  
If you prefer to use the **nfsadmin** command tool, type the following at a command prompt:  
  
```  
C:\tmp> nfsadmin server config config_options  
```  
  
For a detailed list of configuration options for **nfsadmin**, type **nfsadmin server \/?**.  
  
### Configure NFS shares  
To configure NFS shares using the information you previously gathered on the shares, type the following in Windows PowerShell. Instructions for configuring NFS shares using the **nfsshare** command are provided later in this section.  
  
```  
PS C:\tmp> New-NfsShare <parameters>  
```  
  
|Windows Server output|Equivalent NfsShare cmdlet parameters in Windows Server°2012°R2|  
|-------------------------|-------------------------------------------------------------------|  
|Alias|\-Name|  
|Path|\-Path|  
|Encoding|\-LanguageEncoding|  
|Anonymous access|\-EnableAnonymousAccess|  
|Anonymous UID|\-AnonymousUID|  
|\-Anonymous GID|\-AnonymousGID|  
|Host access|\-Permission, \-AllowRootAccess, …|  
  
An example of configuring an NFS share follows:  
  
```  
PS C:\> New-NfsShare –Name roshare – Path C:\shares\roshare =AnonymousUid -2 –AnonymousGid -2 –LanguageEncoding ANSI –EnableAnonymousAccess $false –EnableUnmappedAccess $false –AllowRootAccess $false  
```  
  
If you prefer to use the **nfsshare** command tool, type the following at a command prompt:  
  
```  
C:\tmp> nfsshare sharename=drive:path [ -o options ]  
```  
  
For a detailed list of configuration options for **nfsshare**, type **nfsshare server \/?**.  
  
### Configure identity mapping and group identifier information  
Using the information you gathered earlier for identity mapping, type the following in Windows PowerShell to configure ID mapping:  
  
```  
PS C:\tmp> Set-NfsMappingStore <Parameters>  
PS C:\tmp> Set-NfsMappedIdentity <Parameters>  
```  
  
An example of configuring identity mapping follows:  
  
```  
PS c:\tmp> Set-NfsMappingStore -EnableADLookup $true -ADDomainName "Contoso.com"  
  
```  
  
If you prefer to use the **nfsadmin** command tool, type the following at a command prompt:  
  
```  
C:\tmp> nfsadmin server  <parameter for NIS server or LDAP server information>  
C:\tmp> nfsadmin mapping <parameters>  
```  
  
For a detailed list of configuration options for **nfsadmin**, type **nfsadmin server \/?**.  
  
An example of configuring identity mapping using **nfsadmin** follows:  
  
```  
c:\tmp> nfsadmin mapping  
The following are the settings on localhost  
Mapping Server Lookup       : Disabled  
Mapping Server              :  
AD Lookup                   : Enabled  
AD Domain                   : Contoso.com  
```  
  
Using the information you gathered earlier for group identifiers, type the following in Windows PowerShell to configure groups:  
  
```  
Set-NfsgroupStore  
Set-NfsClientGroup  (or) New-NfsClientGroup  
Set-NfsNetGroup (or) New-NfsNetGroup  
```  
  
After you have configured the netgroup and client group, you can set the NFS share permissions using the [Grant\-NfsSharePermission](http://technet.microsoft.com/library/jj603090.aspx) Windows PowerShell cmdlet . Some examples of configuring share permissions follow:  
  
```  
PS C:\> New-NfsClientgroup -ClientGroupName MIGRATION -AddMember 'MACHINE1','MACHINE2'  
PS C:\> Get-NfsClientgroup MIGRATION  
ClientGroupName                                             ClientGroupMembers  
---------------                                             ------------------  
MIGRATION                                                   {MACHINE1, MACHINE2}  
PS C:\> Grant-NfsSharePermission -Name NfsTestShare1 -ClientName MIGRATION -ClientType clientgroup -Permission readonly  
PS C:\> Get-NfsSharePermission NfsTestShare1  
Name                  ClientName              Permission        AllowRootAccess  
----                  ----------              ----------      ---------------  
NFSTestShare1          MIGRATION                 READ              False  
  
```  
  
If you are using Unmapped UNIX User Access \(UUUA\), see [NFS Identity Mapping in Windows Server 2012](http://blogs.technet.com/b/filecab/archive/2012/10/09/nfs-identity-mapping-in-windows-server-2012.aspx), which provides information about the various methods of identity mapping. You should note that both [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] support UNIX and Linux\-based password and group files.  
  
## See Also  
[Migrate File and Storage Services to Windows Server 2012 R2](../Topic/Migrate-File-and-Storage-Services-to-Windows-Server-2012-R2.md)  
[File and Storage Services: Prepare to Migrate](../Topic/File-and-Storage-Services--Prepare-to-Migrate.md)  
[File and Storage Services: Migrate the File and Storage Services Role](../Topic/File-and-Storage-Services--Migrate-the-File-and-Storage-Services-Role.md)  
[File and Storage Services: Verify the Migration](../Topic/File-and-Storage-Services--Verify-the-Migration.md)  
[File and Storage Services: Migrate an iSCSI Software Target](../Topic/File-and-Storage-Services--Migrate-an-iSCSI-Software-Target.md)  
[File and Storage Services: Post-Migration Tasks](../Topic/File-and-Storage-Services--Post-Migration-Tasks.md)  
[File and Storage Services: Appendix A: Optional Procedures](../Topic/File-and-Storage-Services--Appendix-A--Optional-Procedures.md)  
[File and Storage Services: Appendix B: Migration Data Collection Worksheets](../Topic/File-and-Storage-Services--Appendix-B--Migration-Data-Collection-Worksheets.md)  
  
