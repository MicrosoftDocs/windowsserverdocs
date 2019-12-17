---
ms.assetid: ae241ed8-ef19-40a9-b2d5-80b8391551ff
title: Install Active Directory Domain Services (Level 100)
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Install Active Directory Domain Services (Level 100)

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic explains how to install AD DS in  Windows Server 2012  by using any of the following methods:  

-   [Credential requirements to run Adprep.exe and install Active Directory Domain Services](../../ad-ds/deploy/Install-Active-Directory-Domain-Services--Level-100-.md#BKMK_Creds)  

-   [Installing AD DS by Using Windows PowerShell](../../ad-ds/deploy/Install-Active-Directory-Domain-Services--Level-100-.md#BKMK_PS)  

-   [Installing AD DS by using Server Manager](../../ad-ds/deploy/Install-Active-Directory-Domain-Services--Level-100-.md#BKMK_GUI)  

-   [Performing a Staged RODC Installation using the Graphical User Interface](../../ad-ds/deploy/Install-Active-Directory-Domain-Services--Level-100-.md#BKMK_UIStaged)  

## <a name="BKMK_Creds"></a>Credential requirements to run Adprep.exe and install Active Directory Domain Services  
The following credentials are required to run Adprep.exe and install AD DS.  

-   To install a new forest, you must be logged on as the local Administrator for the computer.  

-   To install a new child domain or new domain tree, you must be logged on as a member of the Enterprise Admins group.  

-   To install an additional domain controller in an existing domain, you must be a member of the Domain Admins group.  

    > [!NOTE]  
    > If you do not run adprep.exe command separately and you are installing the first domain controller that runs  Windows Server 2012  in an existing domain or forest, you will be prompted to supply credentials to run Adprep commands. The credential requirements are as follows:  
    >   
    > -   To introduce the first  Windows Server 2012  domain controller in the forest, you need to supply credentials for a member of Enterprise Admins group, the Schema Admins group, and the Domain Admins group in the domain that hosts the schema master.  
    > -   To introduce the first  Windows Server 2012  domain controller in a domain, you need to supply credentials for a member of the Domain Admins group.  
    > -   To introduce the first read-only domain controller (RODC) in the forest, you need to supply credentials for a member of the Enterprise Admins group.  
    >   
    >     > [!NOTE]  
    >     > If you have already run adprep /rodcprep in Windows Server 2008 or Windows Server 2008 R2, you do not need to run it again for  Windows Server 2012 .  

## <a name="BKMK_PS"></a>Installing AD DS by Using Windows PowerShell  
Beginning with  Windows Server 2012 , you can install AD DS using Windows PowerShell. Dcpromo.exe is deprecated beginning with  Windows Server 2012 , but you can still run dcpromo.exe by using an answer file (dcpromo /unattend:<answerfile> or dcpromo /answer:<answerfile>). The ability to continue running dcpromo.exe with an answer file provides organizations that have resources invested in existing automation time to convert the automation from dcpromo.exe to Windows PowerShell. For more information about running dcpromo.exe with an answer file, see [https://support.microsoft.com/kb/947034](https://support.microsoft.com/kb/947034).  

For more information about removing AD DS using Windows PowerShell, see [Remove AD DS using Windows PowerShell](assetId:///99b97af0-aa7e-41ed-8c81-4eee6c03eb4c#BKMK_RemovePS).  

Start with adding the role using Windows PowerShell. This command installs the AD DS server role and installs the AD DS and AD LDS server administration tools, including GUI-based tools such as Active Directory Users and Computers and command-line tools such as dcdia.exe. Server administration tools are not installed by default when you use Windows PowerShell. You need to specify **"IncludeManagementTools** to manage the local server or install [Remote Server Administration Tools](https://www.microsoft.com/download/details.aspx?id=28972) to manage a remote server.  

```  
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools  
<<Windows PowerShell cmdlet and arguments>>  
```  

There is no reboot required until after the AD DS installation is complete.  

You can then run this command to see the available cmdlets in the ADDSDeployment module.  

```  
Get-Command -Module ADDSDeployment
```  

To see the list of arguments that can be specified for a cmdlets and syntax:  

```  
Get-Help <cmdlet name>  
```  

For example, to see the arguments for creating an unoccupied read-only domain controller (RODC) account, type  

```  
Get-Help Add-ADDSReadOnlyDomainControllerAccount
```  

Optional arguments appear in square brackets.  

You can also download the latest Help examples and concepts for Windows PowerShell cmdlets. For more information, see [about_Updatable_Help](https://technet.microsoft.com/library/hh847735.aspx).  

You can run Windows PowerShell cmdlets against remote servers:  

-   In Windows PowerShell, use Invoke-Command with the ADDSDeployment cmdlet. For example, to install AD DS on a remote server named ConDC3 in the contoso.com domain, type:  

    ```  
    Invoke-Command { Install-ADDSDomainController -DomainName contoso.com -Credential (Get-Credential) } -ComputerName ConDC3  
    ```  

-or-  

-   In Server Manager, create a server group that includes the remote server. Right-click the name of the remote server and click **Windows PowerShell**.  

The next sections explain how to run ADDSDeployment module cmdlets to install AD DS.  

-   [ADDSDeployment cmdlet arguments](../../ad-ds/deploy/Install-Active-Directory-Domain-Services--Level-100-.md#BKMK_Params)  

-   [Specifying Windows PowerShell Credentials](../../ad-ds/deploy/Install-Active-Directory-Domain-Services--Level-100-.md#BKMK_PSCreds)  

-   [Using test cmdlets](../../ad-ds/deploy/Install-Active-Directory-Domain-Services--Level-100-.md#BKMK_TestCmdlets)  

-   [Installing a new forest root domain using Windows PowerShell](../../ad-ds/deploy/../../ad-ds/deploy/Install-Active-Directory-Domain-Services--Level-100-.md#BKMK_PSForest)  

-   [Installing a new child or tree domain using Windows PowerShell](../../ad-ds/deploy/Install-Active-Directory-Domain-Services--Level-100-.md#BKMK_PSDomain)  

-   [Installing an additional (replica) domain controller using Windows PowerShell](../../ad-ds/deploy/Install-Active-Directory-Domain-Services--Level-100-.md#BKMK_PSReplica)  

### <a name="BKMK_Params"></a>ADDSDeployment cmdlet arguments  
The following table lists arguments for the ADDSDeployment cmdlets in Windows PowerShell. Arguments in bold are required. Equivalent arguments for dcpromo.exe are listed in parentheses if they are named different in Windows PowerShell.  

Windows PowerShell switches accept $TRUE or $FALSE arguments. Arguments that are $TRUE by default do not need to be specified.  

To override default values, you can specify the argument with a $False value. For example, because **-installdns** is automatically run for a new forest installation if it is not specified, the only way to *prevent* DNS installation when you install a new forest is to use:  

```  
-InstallDNS:$false  
```  

Similarly, because **"installdns** has a default value of $False if you install a domain controller in an environment that does not host Windows Server DNS server, you need to specify the following argument in order to install DNS server:  

```  
-InstallDNS:$true  
```  


|                                                                                                                 Argument                                                                                                                 |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **ADPrepCredential <PS Credential>** **Note:** Required if you are installing the first  Windows Server 2012  domain controller in a domain or forest and the credentials of the current user are insufficient to perform the operation. |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Specifies the account with Enterprise Admins and Schema Admins group membership that can prepare the forest, according to the rules of [Get-Credential](https://technet.microsoft.com/library/dd315327.aspx) and a PSCredential object.<br /><br />If no value is specified, the value of the **"credential** argument is used.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|                                                                                                      AllowDomainControllerReinstall                                                                                                      |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Specifies whether to continue installing this writable domain controller, despite the fact that another writable domain controller account with the same name is detected.<br /><br />Use **$True** only if you are sure that the account is not currently used by another writable domain controller.<br /><br />The default is **$False**.<br /><br />This argument is not valid for an RODC.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|                                                                                                           AllowDomainReinstall                                                                                                           |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        Specifies whether an existing domain is recreated.<br /><br />The default is **$False**.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|                                                                                             AllowPasswordReplicationAccountName <string []>                                                                                              |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         Specifies the names of user accounts, group accounts, and computer accounts whose passwords can be replicated to this RODC. Use an empty string "" if you want to keep the value empty. By default, only the Allowed RODC Password Replication Group is allowed, and it is originally created empty.<br /><br />Supply values as a string array. For example:<br /><br />Code -AllowPasswordReplicationAccountName "JSmith","JSmithPC","Branch Users"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|                      ApplicationPartitionsToReplicate <string []> **Note:** There is no equivalent option in the UI. If you install using the UI, or using IFM, then all application partitions will be replicated.                      |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Specifies the application directory partitions to replicate. This argument is applied only when you specify the **-InstallationMediaPath** argument to install from media (IFM). By default, all application partitions will replicate based on their own scopes.<br /><br />Supply values as a string array. For example:<br /><br />Code -<br /><br />-ApplicationPartitionsToReplicate "partition1","partition2","partition3"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|                                                                                                                 Confirm                                                                                                                  |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        Prompts you for confirmation before running the cmdlet.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|                                                         CreateDnsDelegation **Note:** You cannot specify this argument when you run the Add-ADDSReadOnlyDomainController cmdlet.                                                         |                                                                                                                                                                                                                                                                                                                                                                                                                                   Indicates whether to create a DNS delegation that references the new DNS server that you are installing along with the domain controller. Valid for Active Directory"integrated DNS only. Delegation records can be created only on Microsoft DNS servers that are online and accessible. Delegation records cannot be created for domains that are immediately subordinate to top-level domains such as .com, .gov, .biz, .edu or two-letter country code domains such as .nz and .au.<br /><br />The default is computed automatically based on the environment.                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                                                 **Credential <PS Credential>** **Note:** Required only if the credentials of the current user are insufficient to perform the operation.                                                 |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                Specifies the domain account that can logon to the domain, according to the rules of [Get-Credential](https://technet.microsoft.com/library/dd315327.aspx) and a PSCredential object.<br /><br />If no value is specified, the credentials of the current user are used.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|                                                                                                         CriticalReplicationOnly                                                                                                          |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         Specifies whether the AD DS installation operation performs only critical replication before reboot and then continues. The noncritical replication happens after the installation finishes and the computer reboots.<br /><br />Using this argument is not recommended.<br /><br />There is no equivalent for this option in the user interface (UI).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|                                                                                                          DatabasePath <string>                                                                                                           |                                                                                                                                                                                                                                                                                                                                                                                                                                                      Specifies the fully qualified, non"Universal Naming Convention (UNC) path to a directory on a fixed disk of the local computer that contains the domain database, for example, **C:\Windows\NTDS.**<br /><br />The default is **%SYSTEMROOT%\NTDS**. **Important:** While you can store the AD DS database and log files on volume formatted with Resilient File System (ReFS), there are no specific benefits for hosting AD DS on ReFS, other than the normal benefits of resiliency you get for hosting any data on ReFS.                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|                                                                                                DelegatedAdministratorAccountName <string>                                                                                                |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                Specifies the name of the user or group that can install and administer the RODC.<br /><br />By default, only members of the Domain Admins group can administer an RODC.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|                                                                                              DenyPasswordReplicationAccountName <string []>                                                                                              |                                                                                                                                                                                                                                                                                                           Specifies the names of user accounts, group accounts, and computer accounts whose passwords are not to be replicated to this RODC. Use an empty string "" if you do not want to deny the replication of credentials of any users or computers. By default, Administrators, Server Operators, Backup Operators, Account Operators, and the Denied RODC Password Replication Group are denied. By default, the Denied RODC Password Replication Group includes Cert Publishers, Domain Admins, Enterprise Admins, Enterprise Domain Controllers, Enterprise Read-Only Domain Controllers, Group Policy Creator Owners, the krbtgt account, and Schema Admins.<br /><br />Supply values as a string array. For example:<br /><br />Code -<br /><br />-DenyPasswordReplicationAccountName "RegionalAdmins","AdminPCs"                                                                                                                                                                                                                                                                                                            |
|                                               DnsDelegationCredential <PS Credential> **Note:** You cannot specify this argument when you run the Add-ADDSReadOnlyDomainController cmdlet.                                               |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      Specifies the user name and password for creating DNS delegation, according to the rules of [Get-Credential](https://technet.microsoft.com/library/dd315327.aspx) and a PSCredential object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|                        DomainMode <DomainMode> {Win2003 &#124; Win2008 &#124; Win2008R2 &#124; Win2012 &#124; Win2012R2}<br /><br />Or<br /><br />DomainMode <DomainMode> {2 &#124; 3 &#124; 4 &#124; 5 &#124; 6}                        |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             Specifies the domain functional level during the creation of a new domain.<br /><br />The domain functional level cannot be lower than the forest functional level, but it can be higher.<br /><br />The default value is automatically computed and set to the existing forest functional level or the value that is set for **-ForestMode**.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|                                                                   **DomainName**<br /><br />Required for Install-ADDSForest and Install-ADDSDomainController cmdlets.                                                                    |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     Specifies the FQDN of the domain in which you want to install an additional domain controller.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|                                                       **DomainNetbiosName <string>**<br /><br />Required for Install-ADDSForest if FQDN prefix name is longer than 15 characters.                                                        |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Use with Install-ADDSForest. Assigns a NetBIOS name to the new forest root domain.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|                                                                              DomainType <DomainType> {ChildDomain &#124; TreeDomain} or {child &#124; tree}                                                                              |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  Indicates the type of domain that you want to create: a new domain tree in an existing forest, a child of an existing domain, or a new forest.<br /><br />The default for DomainType is ChildDomain.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                                                                                                                  Force                                                                                                                   |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             When this parameter is specified any warnings that might normally appear during the installation and addition of the domain controller will be suppressed to allow the cmdlet to complete its execution. This parameter can be useful to include when scripting installation.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|                        ForestMode <ForestMode> {Win2003 &#124; Win2008 &#124; Win2008R2 &#124; Win2012 &#124; Win2012R2}<br /><br />Or<br /><br />ForestMode <ForestMode> {2 &#124; 3 &#124; 4 &#124; 5 &#124; 6}                        |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              Specifies the forest functional level when you create a new forest.<br /><br />The default value is Win2012.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|                                                                                                          InstallationMediaPath                                                                                                           |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 Indicates the location of the installation media that will be used to install a new domain controller.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|                                                                                                                InstallDns                                                                                                                |                                                                                                                                                                                                                                                                                                                      Specifies whether the DNS Server service should be installed and configured on the domain controller.<br /><br />For a new forest, the default is **$True** and DNS Server is installed.<br /><br />For a new child domain or domain tree, if the parent domain (or forest root domain for a domain tree) already hosts and stores the DNS names for the domain, then the default for this parameter is $True.<br /><br />For a domain controller installation in an existing domain, if this parameter is left unspecified and the current domain already hosts and stores the DNS names for the domain, then the default for this parameter is **$True**. Otherwise, if DNS domain names are hosted outside of Active Directory, the default is **$False** and no DNS Server is installed.                                                                                                                                                                                                                                                                                                                      |
|                                                                                                             LogPath <string>                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            Specifies the fully qualified, non-UNC path to a directory on a fixed disk of the local computer that contains the domain log files, for example, **C:\Windows\Logs**.<br /><br />The default is **%SYSTEMROOT%\NTDS**. **Important:** Do not store the Active Directory log files on a data volume formatted with Resilient File System (ReFS).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
|                                                                                             MoveInfrastructureOperationMasterRoleIfNecessary                                                                                             |                                                                                                                                                                                                                                                                                                                                                                                                  Specifies whether to transfer the infrastructure master operations master role (also known as flexible single master operations or FSMO) to the domain controller that you are creating"in case it is currently hosted on a global catalog server"and you do not plan to make the domain controller that you are creating a global catalog server. Specify this parameter to transfer the infrastructure master role to the domain controller that you are creating in case the transfer is needed; in this case, specify the **NoGlobalCatalog** option if you want the infrastructure master role to remain where it currently is.                                                                                                                                                                                                                                                                                                                                                                                                  |
|                                                                                **NewDomainName <string>** **Note:** Required only for Install-ADDSDomain.                                                                                |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Specifies the single domain name for the new domain.<br /><br />For example, if you want to create a new child domain named **emea.corp.fabrikam.com**, you should specify **emea** as the value of this argument.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|                                                      **NewDomainNetbiosName <string>**<br /><br />Required for Install-ADDSDomain if FQDN prefix name is longer than 15 characters.                                                      |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               Use with Install-ADDSDomain. Assigns a NetBIOS name to the new domain. The default value is derived from the value of **"NewDomainName**.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|                                                                                                              NoDnsOnNetwork                                                                                                              |                                                                                                                                                                                                                                                                                                                                    Specifies that DNS service is not available on the network. This parameter is used only when the IP setting of the network adapter for this computer is not configured with the name of a DNS server for name resolution. It indicates that a DNS server will be installed on this computer for name resolution. Otherwise, the IP settings of the network adapter must first be configured with the address of a DNS server.<br /><br />Omitting this parameter (the default) indicates that the TCP/IP client settings of the network adapter on this server computer will be used to contact a DNS server. Therefore, if you are not specifying this parameter, ensure that TCP/IP client settings are first configured with a preferred DNS server address.                                                                                                                                                                                                                                                                                                                                     |
|                                                                                                             NoGlobalCatalog                                                                                                              |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   Specifies that you do not want the domain controller to be a global catalog server.<br /><br />Domain controllers that run  Windows Server 2012  are installed with the global catalog by default. In other words, this runs automatically without computation, unless you specify:<br /><br />Code -<br /><br />-NoGlobalCatalog                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|                                                                                                           NoRebootOnCompletion                                                                                                           |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     Specifies whether to restart the computer upon completion of the command, regardless of success. By default, the computer will restart. To prevent the server from restarting, specify:<br /><br />Code -<br /><br />-NoRebootOnCompletion:$True<br /><br />There is no equivalent for this option in the user interface (UI).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|                                                                              **ParentDomainName <string>** **Note:** Required for Install-ADDSDomain cmdlet                                                                              |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 Specifies the FQDN of an existing parent domain. You use this argument when you install a child domain or new domain tree.<br /><br />For example, if you want to create a new child domain named **emea.corp.fabrikam.com**, you should specify **corp.fabrikam.com** as the value of this argument.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                                                                                                             ReadOnlyReplica                                                                                                              |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   Specifies whether to install a read-only domain controller (RODC).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                                                                                                       ReplicationSourceDC <string>                                                                                                       |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              Indicates the FQDN of the partner domain controller from which you replicate the domain information. The default is automatically computed.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|                                                                                             **SafeModeAdministratorPassword <securestring>**                                                                                             | Supplies the password for the administrator account when the computer is started in Safe Mode or a variant of Safe Mode, such as Directory Services Restore Mode.<br /><br />The default is an empty password. You must supply a password. The password must be supplied in a System.Security.SecureString format, such as that provided by read-host -assecurestring or ConvertTo-SecureString.<br /><br />The SafeModeAdministratorPassword argument's operation is special:If not specified as an argument, the cmdlet prompts you to enter and confirm a masked password. This is the preferred usage when running the cmdlet interactively.If specified without a value, and there are no other arguments specified to the cmdlet, the cmdlet prompts you to enter a masked password without confirmation. This is not the preferred usage when running the cmdlet interactively.If specified with a value, the value must be a secure string. This is not the preferred usage when running the cmdlet interactively.For example, you can manually prompt for a password by using the Read-Host cmdlet to prompt the user for a secure string:-safemodeadministratorpassword (read-host -prompt "Password:" -assecurestring)You can also provide a secure string as a converted clear-text variable, although this is highly discouraged. -safemodeadministratorpassword (convertto-securestring "Password1" -asplaintext -force) |
|                                                                     **SiteName <string>**<br /><br />Required for the Add-addsreadonlydomaincontrolleraccount cmdlet                                                                     |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  Specifies the site where the domain controller will be installed. There is no **"sitename** argument when you run **Install-ADDSForest** because the first site created is Default-First-Site-Name.<br /><br />The site name must already exist when provided as an argument to **-sitename**. The cmdlet will not create the site.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|                                                                                                           SkipAutoConfigureDNS                                                                                                           |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Skips automatic configuration of DNS client settings, forwarders, and root hints. This argument is in effect only if the DNS Server service is already installed or automatically installed with **-InstallDNS**.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
|                                                                                                            SystemKey <string>                                                                                                            |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            Specifies the system key for the media from which you replicate the data.<br /><br />The default is **none**.<br /><br />Data must be in format provided by read-host -assecurestring or ConvertTo-SecureString.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
|                                                                                                           SysvolPath <string>                                                                                                            |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     Specifies the fully qualified, non-UNC path to a directory on a fixed disk of the local computer, for example, **C:\Windows\SYSVOL**.<br /><br />The default is **%SYSTEMROOT%\SYSVOL**. **Important:** SYSVOL cannot be stored on a data volume formatted with Resilient File System (ReFS).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|                                                                                                              SkipPreChecks                                                                                                               |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              Does not run the prerequisite checks before starting installation. It is not advisable to use this setting.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|                                                                                                                  WhatIf                                                                                                                  |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   Shows what would happen if the cmdlet runs. The cmdlet is not run.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |

### <a name="BKMK_PSCreds"></a>Specifying Windows PowerShell Credentials  
You can specify credentials without revealing them in plain text on screen by using [Get-credential](https://technet.microsoft.com/library/dd315327.aspx).  

The operation for the -SafeModeAdministratorPassword and LocalAdministratorPassword arguments is special:  

-   If not specified as an argument, the cmdlet prompts you to enter and confirm a masked password. This is the preferred usage when running the cmdlet interactively.  

-   If specified with a value, the value must be a secure string. This is not the preferred usage when running the cmdlet interactively.  

For example, you can manually prompt for a password by using the **Read-Host** cmdlet to prompt the user for a secure string  

```  
-SafeModeAdministratorPassword (Read-Host -Prompt "DSRM Password:" -AsSecureString)
```  

> [!WARNING]  
> As the previous option does not confirm the password, use extreme caution: the password is not visible.  

You can also provide a secure string as a converted clear-text variable, although this is highly discouraged:  

```  
-SafeModeAdministratorPassword (ConvertTo-SecureString "Password1" -AsPlainText -Force)
```  

> [!WARNING]  
> Providing or storing a clear text password is not recommended. Anyone running this command in a script or looking over your shoulder knows the DSRM password of that domain controller. With that knowledge, they can impersonate the domain controller itself and elevate their privilege to the highest level in an Active Directory forest.  

### <a name="BKMK_TestCmdlets"></a>Using test cmdlets  
Each ADDSDeployment cmdlet has a corresponding test cmdlet. The test cmdlets runs only the prerequisite checks for the installation operation; no installation settings are configured. The arguments for each test cmdlet are the same as for the corresponding installation cmdlet, but **"SkipPreChecks** is not available for test cmdlets.  

|Test cmdlet|Description|  
|---------------|---------------|  
|Test-ADDSForestInstallation|Runs the prerequisites for installing a new Active Directory forest.|  
|Test-ADDSDomainInstallation|Runs the prerequisites for installing a new domain in Active Directory.|  
|Test-ADDSDomainControllerInstallation|Runs the prerequisites for installing a domain controller in Active Directory.|  
|Test-ADDSReadOnlyDomainControllerAccountCreation|Runs the prerequisites for adding a read-only domain controller (RODC) account.|  

### <a name="BKMK_PSForest"></a>Installing a new forest root domain using Windows PowerShell  
The command syntax for installing a new forest is as follows. Optional arguments appear within square brackets.  

```  
Install-ADDSForest [-SkipPreChecks] -DomainName <string> -SafeModeAdministratorPassword <SecureString> [-CreateDNSDelegation] [-DatabasePath <string>] [-DNSDelegationCredential <PS Credential>] [-NoDNSOnNetwork] [-DomainMode <DomainMode> {Win2003 | Win2008 | Win2008R2 | Win2012}] [-DomainNetBIOSName <string>] [-ForestMode <ForestMode> {Win2003 | Win2008 | Win2008R2 | Win2012}] [-InstallDNS] [-LogPath <string>] [-NoRebootOnCompletion] [-SkipAutoConfigureDNS] [-SYSVOLPath] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]  
```  

> [!NOTE]  
> The -DomainNetBIOSName argument is required if you want to change the 15-character name that is automatically generated based on the DNS domain name prefix or if the name exceeds 15 characters.  

For example, to install a new forest named corp.contoso.com and be securely prompted to provide the DSRM password, type:  

```  
Install-ADDSForest -DomainName "corp.contoso.com"   
```  

> [!NOTE]  
> DNS server is installed by default when you run Install-ADDSForest.  

To install a new forest named corp.contoso.com, create a DNS delegation in the contoso.com domain, set domain functional level to Windows Server 2008 R2 and set forest functional level to Windows Server 2008, install the Active Directory database and SYSVOL on the D:\ drive, install the log files on the E:\ drive, and be prompted to provide the Directory Services Restore Mode password and type:  

```  
Install-ADDSForest -DomainName corp.contoso.com -CreateDNSDelegation -DomainMode Win2008 -ForestMode Win2008R2 -DatabasePath "d:\NTDS" -SYSVOLPath "d:\SYSVOL" -LogPath "e:\Logs"   
```  

### <a name="BKMK_PSDomain"></a>Installing a new child or tree domain using Windows PowerShell  
The command syntax for installing a new domain is as follows. Optional arguments appear within square brackets.  

```  
Install-ADDSDomain [-SkipPreChecks] -NewDomainName <string> -ParentDomainName <string> -SafeModeAdministratorPassword <SecureString> [-ADPrepCredential <PS Credential>] [-AllowDomainReinstall] [-CreateDNSDelegation] [-Credential <PS Credential>] [-DatabasePath <string>] [-DNSDelegationCredential <PS Credential>] [-NoDNSOnNetwork] [-DomainMode <DomainMode> {Win2003 | Win2008 | Win2008R2 | Win2012}] [DomainType <DomainType> {Child Domain | TreeDomain} [-InstallDNS] [-LogPath <string>] [-NoGlobalCatalog] [-NewDomainNetBIOSName <string>] [-NoRebootOnCompletion] [-ReplicationSourceDC <string>] [-SiteName <string>] [-SkipAutoConfigureDNS] [-Systemkey <SecureString>] [-SYSVOLPath] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]  
```  

> [!NOTE]  
> The **-credential** argument is only required when you are not currently logged on as a member of the Enterprise Admins group.  
>   
> The **-NewDomainNetBIOSName** argument is required if you want to change the automatically generated 15-character name based on the DNS domain name prefix or if the name exceeds 15 characters.  

For example, to use credentials of corp\EnterpriseAdmin1 to create a new child domain named child.corp.contoso.com, install DNS server, create a DNS delegation in the corp.contoso.com domain, set domain functional level to Windows Server 2003, make the domain controller a global catalog server in a site named Houston, use DC1.corp.contoso.com as the replication source domain controller, install the Active Directory database and SYSVOL on the D:\ drive, install the log files on the E:\ drive, and be prompted to provide the Directory Services Restore Mode password but not prompted to confirm the command, type:  

```  
Install-ADDSDomain -SafeModeAdministratorPassword -Credential (get-credential corp\EnterpriseAdmin1) -NewDomainName child -ParentDomainName corp.contoso.com -InstallDNS -CreateDNSDelegation -DomainMode Win2003 -ReplicationSourceDC DC1.corp.contoso.com -SiteName Houston -DatabasePath "d:\NTDS" "SYSVOLPath "d:\SYSVOL" -LogPath "e:\Logs" -Confirm:$False  
```  

### <a name="BKMK_PSReplica"></a>Installing an additional (replica) domain controller using Windows PowerShell  
The command syntax for installing an additional domain controller is as follows. Optional arguments appear within square brackets.  

```  
Install-ADDSDomainController -DomainName <string> [-SkipPreChecks] -SafeModeAdministratorPassword <SecureString> [-ADPrepCredential <PS Credential>] [-AllowDomainControllerReinstall] [-ApplicationPartitionsToReplicate <string[]>] [-CreateDNSDelegation] [-Credential <PS Credential>] [-CriticalReplicationOnly] [-DatabasePath <string>] [-DNSDelegationCredential <PS Credential>] [-NoDNSOnNetwork] [-NoGlobalCatalog] [-InstallationMediaPath <string>] [-InstallDNS] [-LogPath <string>] [-MoveInfrastructureOperationMasterRoleIfNecessary] [-NoRebootOnCompletion] [-ReplicationSourceDC <string>] [-SiteName <string>] [-SkipAutoConfigureDNS] [-SystemKey <SecureString>] [-SYSVOLPath <string>] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]  
```  

To install a domain controller and DNS server in the corp.contoso.com domain and be prompted to supply the domain Administrator credentials and the DSRM password, type:  

```  
Install-ADDSDomainController -Credential (Get-Credential CORP\Administrator) -DomainName "corp.contoso.com"
```  

If the computer is already domain joined and you are a member of the Domain Admins group, you can use:  

```  
Install-ADDSDomainController -DomainName "corp.contoso.com"  
```  

To be prompted for the domain name, type:  

```  
Install-ADDSDomainController -Credential (Get-Credential) -DomainName (Read-Host "Domain to promote into")
```  

The following command will use credentials of Contoso\EnterpriseAdmin1 to install a writable domain controller and a global catalog server in a site named Boston, install DNS server, create a DNS delegation in the contoso.com domain, install from media that is stored in the c:\ADDS IFM folder, install the Active Directory database and SYSVOL on the D:\ drive, install the log files on the E:\ drive, have the server automatically restart after AD DS installation is complete, and be prompted to provide the Directory Services Restore Mode password:  

```  
Install-ADDSDomainController -Credential (Get-Credential CONTOSO\EnterpriseAdmin1) -CreateDNSDelegation -DomainName corp.contoso.com -SiteName Boston -InstallationMediaPath "c:\ADDS IFM" -DatabasePath "d:\NTDS" -SYSVOLPath "d:\SYSVOL" -LogPath "e:\Logs"   
```  

### Performing a staged RODC installation using Windows PowerShell  
The command syntax to create an RODC account is as follows. Optional arguments appear within square brackets.  

```  
Add-ADDSReadOnlyDomainControllerAccount [-SkipPreChecks] -DomainControllerAccuntName <string> -DomainName <string> -SiteName <string> [-AllowPasswordReplicationAccountName <string []>] [-NoGlobalCatalog] [-Credential <PS Credential>] [-DelegatedAdministratorAccountName <string>] [-DenyPasswordReplicationAccountName <string []>] [-InstallDNS] [-ReplicationSourceDC <string>] [-Force] [-WhatIf] [-Confirm] [<Common Parameters>]  
```  

The command syntax to attach a server to an RODC account is as follows. Optional arguments appear within square brackets.  

```  
Install-ADDSDomainController -DomainName <string> [-SkipPreChecks] -SafeModeAdministratorPassword <SecureString> [-ADPrepCredential <PS Credential>] [-ApplicationPartitionsToReplicate <string[]>] [-Credential <PS Credential>] [-CriticalReplicationOnly] [-DatabasePath <string>] [-NoDNSOnNetwork] [-InstallationMediaPath <string>] [-InstallDNS] [-LogPath <string>] [-MoveInfrastructureOperationMasterRoleIfNecessary] [-NoRebootOnCompletion] [-ReplicationSourceDC <string>] [-SkipAutoConfigureDNS] [-SystemKey <SecureString>] [-SYSVOLPath <string>] [-UseExistingAccount] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]  
```  

For example, to create an RODC account named RODC1:  

```  
Add-ADDSReadOnlyDomainControllerAccount -DomainControllerAccountName RODC1 -DomainName corp.contoso.com -SiteName Boston DelegatedAdministratoraccountName PilarA  
```  

Then run the following commands on the server that you want to attach to the RODC1 account. The server cannot be joined to the domain. First, install the AD DS server role and management tools:  

```  
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
```  

The run the following command to create the RODC:  

```  
Install-ADDSDomainController -DomainName corp.contoso.com -SafeModeAdministratorPassword (Read-Host -Prompt "DSRM Password:" -AsSecureString) -Credential (Get-Credential Corp\PilarA) -UseExistingAccount
```  

Press **Y** to confirm or include the **"confirm** argument to prevent the confirmation prompt.  

## <a name="BKMK_GUI"></a>Installing AD DS by using Server Manager  
AD DS can be installed in  Windows Server 2012  by using the Add Roles Wizard in Server Manager, followed by the Active Directory Domain Services Configuration Wizard, which is new beginning in  Windows Server 2012 . The Active Directory Domain Services Installation Wizard (dcpromo.exe) is deprecated beginning in  Windows Server 2012 .  

The following sections explain how to create server pools in order to install and manage AD DS on multiple servers, and how to use the wizards to install AD DS.  

### <a name="BKMK_ServerPools"></a>Creating server pools  
Server Manager can pool other servers on the network as long as they are accessible from the computer running Server Manager. Once pooled, you choose those servers for remote installation of AD DS or any other configuration options possible within Server Manager. The computer running Server Manager automatically pools itself. For more information about server pools, see [Add Servers to Server Manager](https://technet.microsoft.com/library/hh831453.aspx).  

> [!NOTE]  
> In order to manage a domain-joined computer using Server Manager on a workgroup server, or vice-versa, additional configuration steps are needed. For more information, see "Add and manage servers in workgroups" in [Add Servers to Server Manager](https://technet.microsoft.com/library/hh831453.aspx).  

### <a name="BKMK_installADDSGUI"></a>Installing AD DS  
**Administrative credentials**  

The credential requirements to install AD DS vary depending on which deployment configuration you choose. For more information, see [Credential requirements to run Adprep.exe and install Active Directory Domain Services](../../ad-ds/deploy/../../ad-ds/deploy/../../ad-ds/deploy/../../ad-ds/deploy/../../ad-ds/deploy/../../ad-ds/deploy/../../ad-ds/deploy/../../ad-ds/deploy/../../ad-ds/deploy/../../ad-ds/deploy/../../ad-ds/deploy/../../ad-ds/deploy/Install-Active-Directory-Domain-Services--Level-100-.md#BKMK_Creds).  

Use the following procedures to install AD DS using the GUI method. The steps can be performed locally or remotely. For more detailed explanation of these steps, see the following topics:  

-   [Deploying a Forest with Server Manager](../../ad-ds/deploy/Install-a-New-Windows-Server-2012-Active-Directory-Forest--Level-200-.md#BKMK_SMForest)  

-   [Install a Replica Windows Server 2012 Domain Controller in an Existing Domain &#40;Level 200&#41;](../../ad-ds/deploy/Install-a-Replica-Windows-Server-2012-Domain-Controller-in-an-Existing-Domain--Level-200-.md)  

-   [Install a New Windows Server 2012 Active Directory Child or Tree Domain &#40;Level 200&#41;](../../ad-ds/deploy/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-.md)  

-   [Install a Windows Server 2012 Active Directory Read-Only Domain Controller &#40;RODC&#41; &#40;Level 200&#41;](../../ad-ds/deploy/RODC/Install-a-Windows-Server-2012-Active-Directory-Read-Only-Domain-Controller--RODC---Level-200-.md)  

##### To install AD DS by using Server Manager  

1.  In Server Manager, click **Manage** and click **Add Roles and Features** to start the Add Roles Wizard.  

2.  On the **Before you begin** page, click **Next**.  

3.  On the **Select installation type** page, click **Role-based or feature-based installation** and then click **Next**.  

4.  On the **Select destination server** page, click **Select a server from the server pool**, click the name of the server where you want to install AD DS and then click **Next**.  

    To select remote servers, first create a server pool and add the remote servers to it. For more information about creating server pools, see [Add Servers to Server Manager](https://technet.microsoft.com/library/hh831453.aspx).  

5.  On the **Select server roles** page, click **Active Directory Domain Services**, then on the **Add Roles and Features Wizard** dialog box, click **Add Features**, and then click **Next**.  

6.  On the **Select features** page, select any additional features you want to install and click **Next**.  

7.  On the **Active Directory Domain Services** page, review the information and then click **Next**.  

8.  On the **Confirm installation selections** page, click **Install**.  

9. On the **Results** page, verify that the installation succeeded, and click **Promote this server to a domain controller** to start the Active Directory Domain Services Configuration Wizard.  

    ![Install AD DS](media/Install-Active-Directory-Domain-Services--Level-100-/ADDS_SMI_SMPromotes.gif)  

    > [!IMPORTANT]  
    > If you close Add Roles Wizard at this point without starting the Active Directory Domain Services Configuration Wizard, you can restart it by clicking Tasks in Server Manager.  

    ![Install AD DS](media/Install-Active-Directory-Domain-Services--Level-100-/ADDS_SMI_Tasks.gif)  

10. On the **Deployment Configuration** page, choose one of the following options:  

    -   If you are installing an additional domain controller in an existing domain, click **Add a domain controller to an existing domain**, and type the name of the domain (for example, emea.corp.contoso.com) or click **Select...** to choose a domain, and credentials (for example, specify an account that is a member of the Domain Admins group) and then click **Next**.  

        > [!NOTE]  
        > The name of the domain and current user credentials are supplied by default only if the machine is domain-joined and you are performing a local installation. If you are installing AD DS on a remote server, you need to specify the credentials, by design. If current user credentials are not sufficient to perform the installation, click **Change...** in order to specify different credentials.  

        For more information, see [Install a Replica Windows Server 2012 Domain Controller in an Existing Domain &#40;Level 200&#41;](../../ad-ds/deploy/Install-a-Replica-Windows-Server-2012-Domain-Controller-in-an-Existing-Domain--Level-200-.md).  

    -   If you are installing a new child domain, click **Add a new domain to an existing forest**, for **Select domain type**, select **Child Domain**, type or browse to the name of the parent domain DNS name (for example, corp.contoso.com), type the relative name of the new child domain (for example emea), type credentials to use to create the new domain, and then click **Next**.  

        For more information, see [Install a New Windows Server 2012 Active Directory Child or Tree Domain &#40;Level 200&#41;](../../ad-ds/deploy/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-.md).  

    -   If you are installing a new domain tree, click **Add new domain to an existing forest**, for **Select domain type**, choose **Tree Domain**, type the name of the root domain (for example, corp.contoso.com), type the DNS name of the new domain (for example, fabrikam.com), type credentials to use to create the new domain, and then click **Next**.  

        For more information, see [Install a New Windows Server 2012 Active Directory Child or Tree Domain &#40;Level 200&#41;](../../ad-ds/deploy/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-.md).  

    -   If you are installing a new forest, click **Add a new forest** and then type the name of the root domain (for example, corp.contoso.com).  

        For more information, see [Install a New Windows Server 2012 Active Directory Forest &#40;Level 200&#41;](../../ad-ds/deploy/Install-a-New-Windows-Server-2012-Active-Directory-Forest--Level-200-.md).  

11. On the **Domain Controller Options** page, choose one of the following options:  

    -   If you are creating a new forest or domain, select the domain and forest functional levels, click **Domain Name System (DNS) server**, specify the DSRM password, and then click **Next**.  

    -   If you are adding a domain controller to an existing domain, click **Domain Name System (DNS) server**, **Global Catalog (GC)**, or **Read Only Domain Controller (RODC)** as needed, choose the site name, and type the DSRM password and then click **Next**.  

    For more information about which options on this page are available or not available under different conditions, see [Domain Controller Options](../../ad-ds/deploy/AD-DS-Installation-and-Removal-Wizard-Page-Descriptions.md#BKMK_DCOptionsPage).  

12. On the **DNS Options** page (which appears only if you install a DNS server), click **Update DNS delegation** as needed. If you do, provide credentials that have permission to create DNS delegation records in the parent DNS zone.  

    If a DNS server that hosts the parent zone cannot be contacted, the **Update DNS Delegation** option is not available.  

    For more information about whether you need to update the DNS delegation, see [Understanding Zone Delegation](https://technet.microsoft.com/library/cc771640.aspx). If you attempt to update the DNS delegation and encounter an error, see [DNS Options](../../ad-ds/deploy/AD-DS-Installation-and-Removal-Wizard-Page-Descriptions.md#BKMK_DNSOptionsPage).  

13. On the **RODC Options** page (which appears only if you install an RODC), specify the name of a group or user who will manage the RODC, add accounts to or remove accounts from the Allowed or Denied password replication groups, and then click **Next**.  

    For more information, see [Password Replication Policy](https://technet.microsoft.com/library/cc730883(v=ws.10)).  

14. On the **Additional Options** page, choose one of the following options:  

    -   If you are creating a new domain, type a new NetBIOS name or verify the default NetBIOS name of the domain, and then click **Next**.  

    -   If you are adding a domain controller to an existing domain, select the domain controller that you want to replicate the AD DS installation data from (or allow the wizard to select any domain controller). If you are installing from media, click **Install from media path** type and verify the path to the installation source files, and then click **Next**.  

        You cannot use install from media (IFM) to install the first domain controller in a domain. IFM does not work across different operating system versions. In other words, in order to install an additional domain controller that runs  Windows Server 2012  by using IFM, you must create the backup media on a  Windows Server 2012  domain controller. For more information about IFM, see [Installing an Additional Domain Controller by Using IFM](https://technet.microsoft.com/library/cc816722(WS.10).aspx).  

15. On the **Paths** page, type the locations for the Active Directory database, log files, and SYSVOL folder (or accept default locations), and click **Next**.  

    > [!IMPORTANT]  
    > Do not store the Active Directory database, log files, or SYSVOL folder on a data volume formatted with Resilient File System (ReFS).  

16. On the **Preparation Options** page, type credentials that are sufficient to run adprep. For more information, see [Credential requirements to run Adprep.exe and install Active Directory Domain Services](../../ad-ds/deploy/Install-Active-Directory-Domain-Services--Level-100-.md#BKMK_Creds).  

17. On the **Review Options** page, confirm your selections, click **View script** if you want to export the settings to a Windows PowerShell script, and then click **Next**.  

18. On the **Prerequisites Check** page, confirm that prerequisite validation completed and then click **Install**.  

19. On the **Results** page, verify that the server was successfully configured as a domain controller. The server will be restarted automatically to complete the AD DS installation.  

## <a name="BKMK_UIStaged"></a>Performing a Staged RODC Installation using the Graphical User Interface  
A staged RODC installation allows you to create an RODC in two stages. In the first stage, a member of the Domain Admins group creates an RODC account. In the second stage, a server is attached to the RODC account. The second stage can be completed by a member of the Domain Admins group or a delegated domain user or group.  

#### To create an RODC account by using the Active Directory management tools  

1.  You can create the RODC account using Active Directory Administrative Center or Active Directory Users and Computers.  

    1.  Click **Start**, click **Administrative Tools**, and then click **Active Directory Administrative Center**.  

    2.  In the navigation pane (left pane), click the name of the domain.  

    3.  In the Management list (center pane), click the **Domain Controllers** OU.  

    4.  In the Tasks Pane (right pane), click **Pre-create a read-only domain controller account**.  

    -Or-  

    1.  Click **Start**, click **Administrative Tools**, and then click **Active Directory Users and Computers**.  

    2.  Either right-click the **Domain Controllers** organizational unit (OU) or click the **Domain Controllers** OU, and then click **Action**.  

    3.  Click **Pre-create Read-only Domain Controller account**.  

2.  On the **Welcome to the Active Directory Domain Services Installation Wizard** page, if you want to modify the default the Password Replication Policy (PRP), select **Use advanced mode installation**, and then click **Next**.  

3.  On the **Network Credentials** page, under **Specify the account credentials to use to perform the installation**, click **My current logged on credentials** or click **Alternate credentials**, and then click **Set**. In the **Windows Security** dialog box, provide the user name and password for an account that can install the additional domain controller. To install an additional domain controller, you must be a member of the Enterprise Admins group or the Domain Admins group. When you are finished providing credentials, click **Next**.  

4.  On the **Specify the Computer Name** page, type the computer name of the server that will be the RODC.  

5.  On the **Select a Site** page, select a site from the list or select the option to install the domain controller in the site that corresponds to the IP address of the computer on which you are running the wizard, and then click **Next**.  

6.  On the **Additional Domain Controller Options** page, make the following selections, and then click **Next**:  

    -   **DNS server**: This option is selected by default so that your domain controller can function as a Domain Name System (DNS) server. If you do not want the domain controller to be a DNS server, clear this option. However, if you do not install the DNS server role on the RODC and the RODC is the only domain controller in the branch office, users in the branch office will not be able to perform name resolution when the wide area network (WAN) to the hub site is offline.  

    -   **Global catalog**: This option is selected by default. It adds the global catalog, read-only directory partitions to the domain controller, and it enables global catalog search functionality. If you do not want the domain controller to be a global catalog server, clear this option. However, if you do not install a global catalog server in the branch office or enable universal group membership caching for the site that includes the RODC, users in the branch office will not be able to log on to the domain when the WAN to the hub site is offline.  

    -   **Read-only domain controller**. When you create an RODC account, this option is selected by default and you cannot clear it.  

7.  If you selected the **Use advanced mode installation** check box on the **Welcome** page, the **Specify the Password Replication Policy** page appears. By default, no account passwords are replicated to the RODC, and security-sensitive accounts (such as members of the Domain Admins group) are explicitly denied from ever having their passwords replicated to the RODC.  

    To add other accounts to policy, click **Add**, then click **Allow passwords for the account to replicate to this RODC** or click **Deny passwords for the account from replicating to this RODC** and then select the accounts.  

    When complete (or to accept the default setting), click **Next**.  

8.  On the **Delegation of RODC Installation and Administration** page, type the name of the user or the group who will attach the server to the RODC account that you are creating. You can type the name of only one security principal.  

    To search the directory for a specific user or group, click **Set**. In **Select User or Group**, type the name of the user or group. We recommend that you delegate RODC installation and administration to a group.  

    This user or group will also have local administrative rights on the RODC after the installation. If you do not specify a user or group, only members of the Domain Admins group or the Enterprise Admins group will be able to attach the server to the account.  

    When you are finished, click **Next**.  

9. On the **Summary** page, review your selections. Click **Back** to change any selections, if necessary.  

    To save the settings that you selected to an answer file that you can use to automate subsequent AD DS operations, click **Export settings**. Type a name for your answer file, and then click **Save**.  

    When you are sure that your selections are accurate, click **Next** to create the RODC account.  

10. On the **Completing the Active Directory Domain Services Installation Wizard** page, click **Finish**.  

After an RODC account is created, you can attach a server to account to complete the RODC installation. This second stage can be completed in the branch office where the RODC will be located. The server where you perform this procedure must not be joined to the domain. Beginning in  Windows Server 2012 , you use the Add Roles Wizard in Server Manager to attach a server to an RODC account.  

#### To attach a server to an RODC account using Server Manager  

1.  Log on as local Administrator.  

2.  In Server Manager, click **Add roles and features**.  

3.  On the **Before you begin** page, click **Next**.  

4.  On the **Select installation type** page, click **Role-based or feature-based installation** and then click **Next**.  

5.  On the **Select destination server** page, click **Select a server from the server pool**, click the name of the server where you want to install AD DS and then click **Next**.  

6.  On the **Select server roles** page, click **Active Directory Domain Services**, click **Add Features** and then click **Next**.  

7.  On the **Select features** page, select any additional features that you want to install and click **Next**.  

8.  On the **Active Directory Domain Services** page, review the information and then click **Next**.  

9. On the **Confirm installation selections** page, click **Install**.  

10. On the **Results** page, verify **Installation succeeded**, and click **Promote this server to a domain controller** to start the Active Directory Domain Services Configuration Wizard.  

    > [!IMPORTANT]  
    > If you close Add Roles Wizard at this point without starting the Active Directory Domain Services Configuration Wizard, you can restart it by clicking Tasks in Server Manager.  

    (media/Install-Active-Directory-Domain-Services--Level-100-/ADDS_SMI_Tasks.gif)  

11. On the **Deployment Configuration** page, click **Add a domain controller to an existing domain**, type the name of the domain (for example, emea.contoso.com) and credentials (for example, specify an account that is delegated to manage and install the RODC), and then click **Next**.  

12. On the **Domain Controller Options** page, click **Use existing RODC account**, type and confirm the Directory Services Restore Mode password, and then click **Next**.  

13. On the **Additional Options** page, if you are installing from media, click **Install from media path** type and verify the path to the installation source files, select the domain controller that you want to replicate the AD DS installation data from (or allow the wizard to select any domain controller) and then click **Next**.  

14. On the **Paths** page, type the locations for the Active Directory database, log files, and SYSVOL folder, or accept default locations, and then click **Next**.  

15. On the **Review Options** page, confirm your selections, click **View Script** to export the settings to a Windows PowerShell script, and then click **Next**.  

16. On the **Prerequisites Check** page, confirm that prerequisite validation completed and then click **Install**.  

    To complete the AD DS installation, the server will restart automatically.  

## See Also  
[Troubleshooting Domain Controller Deployment](Troubleshooting-Domain-Controller-Deployment.md)  
[Install a New Windows Server 2012 Active Directory Forest &#40;Level 200&#41;](../../ad-ds/deploy/Install-a-New-Windows-Server-2012-Active-Directory-Forest--Level-200-.md)  
[Install a New Windows Server 2012 Active Directory Child or Tree Domain &#40;Level 200&#41;](../../ad-ds/deploy/Install-a-New-Windows-Server-2012-Active-Directory-Child-or-Tree-Domain--Level-200-.md)  
[Install a Replica Windows Server 2012 Domain Controller in an Existing Domain &#40;Level 200&#41;](../../ad-ds/deploy/Install-a-Replica-Windows-Server-2012-Domain-Controller-in-an-Existing-Domain--Level-200-.md)  




