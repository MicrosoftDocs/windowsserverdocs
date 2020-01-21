---
ms.assetid: ba7f2b9f-7351-4680-b7d8-a5f270614f1c
title: What's New in Active Directory Domain Services Installation and Removal
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/09/2018
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---
# What's New in Active Directory Domain Services Installation and Removal

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Active Directory Domain Services (AD DS) deployment in Windows Server 2012 is simpler and faster than previous versions of Windows Server. The AD DS installation process is now built on Windows PowerShell and is integrated with Server Manager. The number of steps required to introduce domain controllers into an existing Active Directory environment is reduced. This makes the process for creating a new Active Directory environment simpler and more efficient. The new AD DS deployment process minimizes the chances of errors that would have otherwise blocked installation.  
  
In addition, you can install the AD DS server role binaries (that is the AD DS server role) on multiple servers at the same time. You can also run the AD DS installation wizard remotely on an individual server. These improvements provide more flexibility for deploying domain controllers that run Windows Server 2012, especially for large-scale, global deployments where many domain controllers need to be deployed to offices in different regions.  
  
AD DS installation includes the following features:  
  
- **Adprep.exe integration into the AD DS installation process.** The cumbersome steps required to prepare an existing Active Directory, such as the need to use a variety of different credentials, copy the Adprep.exe files, or log on to specific domain controllers, are all simplified or occur automatically. This reduces the time required to install AD DS and reduces the chances for errors that might otherwise block domain controller promotion.  

   For environments where it is preferable to run adprep.exe commands in advance of a new domain controller installation, you can still execute adprep.exe commands separately from the AD DS installation. The Windows Server 2012 version of adprep.exe runs remotely, so you can execute all necessary commands from a server that runs a 64-bit version of Windows Server 2008 or later.  

- **The new AD DS installation is built on Windows PowerShell and can be invoked remotely.** The new AD DS installation is integrated with Server Manager, so you can use the same interface to install AD DS that you use when installing other server roles. For Windows PowerShell users, the AD DS deployment cmdlets provide greater functionality and flexibility. There is functional parity between command-line and GUI installation options.  
- **The new AD DS installation includes prerequisite validation.** Any potential errors are identified before the installation begins. You can correct error conditions before they occur without the concerns resulting from a partially complete upgrade. For example, if adprep /domainprep needs to be run, the installation wizard verifies that the user has sufficient rights to execute the operation.  
- **Configuration pages are grouped in a sequence that mirrors the requirements of the most common promotion options with related options grouped in fewer wizard pages.** This provides better context for making installation choices.  
- **You can export a Windows PowerShell script that contains all the options that were specified during the graphical installation.** At the end of an installation or removal, you can export the settings to a Windows PowerShell script for use with automating the same operation.  
- **Only critical replication occurs before reboot.** New switch to allow replication of non-critical data before reboot. For more information, see [ADDSDeployment cmdlet arguments](../../ad-ds/deploy/Install-Active-Directory-Domain-Services--Level-100-.md#BKMK_Params).  

## <a name="BKMK_ADConfigurationWizard"></a>The Active Directory Domain Services Configuration Wizard

Beginning with  Windows Server 2012 , the Active Directory Domain Services Configuration Wizard replaces the legacy Active Directory Domain Services Installation Wizard as the user interface (UI) option to specify settings when you install a domain controller. The Active Directory Domain Services Configuration Wizard begins after Add Roles Wizard is finished.  

> [!WARNING]  
> The legacy Active Directory Domain Services Installation Wizard (dcpromo.exe) is deprecated beginning with Windows Server 2012.  

In [Install Active Directory Domain Services &#40;Level 100&#41;](../../ad-ds/deploy/Install-Active-Directory-Domain-Services--Level-100-.md), the UI procedures show how to start the Add Roles Wizard to install the AD DS server role binaries and then run the Active Directory Domain Services Configuration Wizard to complete the domain controller installation. The Windows PowerShell examples show how to complete both steps using an AD DS deployment cmdlet.  
  
## <a name="BKMK_NewAdprep"></a>Adprep.exe integration

Beginning with Windows Server 2012, there is only one version of Adprep.exe (there is no 32-bit version, adprep32.exe). Adprep commands are run automatically as needed when you install a domain controller that runs Windows Server 2012 to an existing Active Directory domain or forest.  
  
Although adprep operations are run automatically, you can run Adprep.exe separately. For example, if the user who installs AD DS is not a member of the Enterprise Admins group, which is required in order to run Adprep /forestprep, then you might need to run the command separately. But, you only have to run adprep.exe if you are planning to in-place upgrade your first Windows Server 2012 domain controller (in other words, you plan to in-place upgrade the operating system of a domain controller that runs Windows Server 2012).  
  
Adprep.exe is located in the \support\adprep folder of the Windows Server 2012 installation disc. The Windows Server 2012 version of adprep is capable of executing remotely.  
  
The Windows Server 2012 version of adprep.exe can run on any server that runs a 64-bit version of  Windows Server 2008  or later. The server needs network connectivity to the schema master for the forest and the infrastructure master of the domain where you want to add a domain controller. If either of those roles is hosted on a server that runs Windows Server 2003, then adprep must be run remotely. The server where you run adprep does not need to be a domain controller. It can be domain joined or in a workgroup.  

> [!NOTE]  
> If you try to run the Windows Server 2012 version of adprep.exe on a server that runs Windows Server 2003, the following error appears:  
>   
> Adprep.exe is not a valid Win32 application.  

![What's new](media/What-s-New-in-Active-Directory-Domain-Services-Installation-and-Removal/AdprepNotValid.gif)  

For information about resolving other errors returned by Adprep.exe, see [Known issues](../../ad-ds/deploy/What-s-New-in-Active-Directory-Domain-Services-Installation-and-Removal.md#BKMK_KnownIssues).  

### Group membership check against Windows Server 2003 operations master roles

For each command (/forestprep, /domainprep, or /rodcprep), Adprep performs a group membership check to determine whether the specified credential represents an account in certain groups. To perform this check, Adprep contacts the operations master role owner. If the operations master is running Windows Server 2003, you need to specify the /user and /userdomain command line parameters if you run Adprep.exe to ensure the group membership check is performed in all cases.  
  
The /user and /userdomain are new parameters for Adprep.exe in  Windows Server 2012 . These parameters specify the user account name and user domain, respectively, of the user who runs the adprep command. The Adprep.exe command-line utility blocks specifying one of /userdomain and /user but omitting the other.  
  
However, Adprep operations can also be run as part of an AD DS installation using Windows PowerShell or Server Manager. Those experiences share the same underlying implementation (adprep.dll) as adprep.exe. The Windows PowerShell and Server Manager experiences have their separate credentials input, which does not impose the same requirements as by adprep.exe. Using Windows PowerShell or Server Manager, it is possible to pass a value for /user but not /userdomain to adprep.dll. If /user is specified but /userdomain is not specified, the local machine's domain is used to perform the check. If the machine is not domain joined, group membership cannot be checked.  
  
When group membership cannot be checked, Adprep shows a warning message in the adprep log files and continues:  

```
Adprep was unable to check the specified user's group membership. This could happen if the FSMO role owner <DNS host name of operations master> is running Windows Server 2003 or lower version of Windows.  
```

If you run Adprep.exe without specifying the /user and /userdomain parameters and the operations master is running Windows Server 2003, Adprep.exe contacts a domain controller in the domain of the current logon user. If the current logon user is not a domain account, Adprep.exe cannot perform the group membership check. Adprep.exe also cannot perform the group membership check if smartcard credentials are used, even if you do specify both /user and /userdomain.  
  
If Adprep finishes successfully, there is no action required. If Adprep fails during execution with access errors, provide an account with the correct membership. For more information, see [Credential requirements to run Adprep.exe and install Active Directory Domain Services](../../ad-ds/deploy/Install-Active-Directory-Domain-Services--Level-100-.md#BKMK_Creds).  
  
### Syntax for Adprep in Windows Server 2012

Use the following syntax to run adprep separately from an AD DS installation:  

```
Adprep.exe /forestprep /forest <forest name> /userdomain <user domain name> /user <user name> /password *  
```

Use /logdsid in the command in order to generate more detailed logging. The adprep.log is located in %windir%\System32\Debug\Adprep\Logs.  

### Running adprep using smartcard

The Windows Server 2012 version of adprep.exe works using smartcard as credentials, but there is no easy way to specify the smart card credential through the command line. One way to do it is to obtain the smart card credential through PowerShell cmdlet Get-Credential. Then use the user name of the returned PSCredential object, which appears as `@@...`. The password is the PIN of the smart card.  

Adprep.exe requires /userdomain if /user is specified. For smartcard credentials, the /userdomain should be the domain of the underlying user account represented by the smartcard.  

### Adprep /domainprep /gpprep command is not run automatically

The adprep /domainprep /gpprep command is not run as part of AD DS installation. This command sets permissions that are required for Resultant Set of Policy (RSOP) planning mode functionality. For more information about this command, see [Microsoft Knowledge Base article 324392](https://support.microsoft.com/kb/324392). If the command needs to be run in your Active Directory domain, you can run it separately from the AD DS installation. If the command has already been run in preparation of deploying domain controllers that run Windows Server 2003 SP1 or later, the command does not need to be run again.  

You can safely add domain controllers that run Windows Server 2012 to an existing domain without running adprep /domainprep /gpprep, but RSOP planning mode will not function properly.  

## <a name="BKMK_PrereqCheck"></a>AD DS installation prerequisite validation

The AD DS installation wizard checks that the following prerequisites are met before the installation begins. This provides you with a chance to correct issues that can potentially block installation.  
  
For example, Adprep-related prerequisites include:  

- Adprep credential verification: If adprep needs to be run, the installation wizard verifies that the user has sufficient rights to execute the required Adprep operations.  
- Schema master availability check: If the installation wizard determines that adprep /forestprep needs to be run, it verifies that the schema master is online and fails otherwise.  
- Infrastructure master availability check: If the installation wizard determines that adprep /domainprep needs to be run, it verifies that the infrastructure master is online and fails otherwise.

Other prerequisite checks that are carried forward from the legacy Active Directory Installation Wizard (dcpromo.exe) include:  

- Forest name verification: Ensures that the forest name is valid and does not currently exist.  
- NetBIOS name verification: Checks that provided NetBIOS name is valid and does not conflict with existing names.  
- Component path verification: Verifies that paths for the Active Directory database, logs, and SYSVOL are valid and that there is enough disk space available for them.  
- Child domain name verification: Ensures that the parent and new child domain names are valid and that they do not conflict with existing domains.  
- Tree domain name verification: Ensures that the specified tree name is valid and that it does not currently exist.  

## <a name="BKMK_SystemReqs"></a>System requirements

System requirements for Windows Server 2012 are unchanged from Windows Server 2008 R2. For more information, see [Windows Server 2008 R2 with SP1 System Requirements](https://www.microsoft.com/windowsserver2008/en/us/system-requirements.aspx) (https://www.microsoft.com/windowsserver2008/en/us/system-requirements.aspx).  

Some features can have additional requirements. For example, the virtual domain controller cloning feature requires that the PDC emulator run Windows Server 2012 and a computer running Windows Server 2012 with the Hyper-V role installed.  

## <a name="BKMK_KnownIssues"></a>Known issues

This section lists some of the known issues that affect AD DS installation in  Windows Server 2012 . For additional known issues, see [Troubleshooting Domain Controller Deployment](../../ad-ds/deploy/Troubleshooting-Domain-Controller-Deployment.md).  

- If WMI access to the schema master is blocked by Windows Firewall when you remotely run adprep /forestprep, the following error is logged in the adprep log at %systemroot%\system32\debug\adprep:  

   ```
   Adprep encountered a Win32 error.
   Error code: 0x6ba Error message: The RPC server is unavailable.  
   ```

   In this case, you can work around the error by either running adprep /forestprep directly on the schema master, or you can run one of the following commands to allow WMI traffic through Windows Firewall.

   For Windows Server 2008 or later:

   ```
   netsh advfirewall firewall set rule group="windows management instrumentation (wmi)" new enable=yes
   ```

   For Windows Server 2003:

   ```
   netsh firewall set service RemoteAdmin enable
   ```

   After adprep finishes you can run either of the following commands to block WMI traffic again:

   ```
   netsh advfirewall firewall set rule group="windows management instrumentation (wmi)" new enable=no
   ```

   ```
   netsh firewall set service remoteadmin disable
   ```

- You can type Ctrl + C to cancel the Install-ADDSForest cmdlet. The cancellation stops the installation and any changes that were made to the state of the server are reverted. But after the cancellation command is issued, control is not returned to Windows PowerShell, and the cmdlet can hang indefinitely.  
- **Installation of an additional domain controller using smart card credentials fails if the target server is not joined to the domain before installation.**  

   The error message returned in this case is:  

   Unable to connect to the replication source domain controller *source domain controller name*. (Exception: Logonfailure: unknown user name or bad password)  

   If you join the target server to the domain and then perform the installation using a smart card, the installation succeeds.  
  
- **The ADDSDeployment module does not run under 32-bit processes.** If you are automating deployment and configuration of Windows Server 2012 using a script that includes an ADDSDeployment cmdlet and any other cmdlet that does not support native 64-bit processes, the script can fail with an error that indicates the ADDSDeployment cmdlet cannot be found.  

   In this case, you need to run the ADDSDeployment cmdlet separately from the cmdlet that does not support native 64-bit processes.  

- There is a new file system in Windows Server 2012 named Resilient File System. Do not store the Active Directory database, log files, or SYSVOL on a data volume formatted with Resilient File System (ReFS). For more information about ReFS, see [Building the next generation file system for Windows: ReFS](https://blogs.msdn.com/b/b8/archive/2012/01/16/building-the-next-generation-file-system-for-windows-refs.aspx).  
- In Server Manager, servers that run AD DS or other server roles on a Server Core installation and have been upgraded to  Windows Server 2012 , the server role can appear with red status, even though events and status are collected as expected. Servers that run a Server Core installation of a preliminary release Windows Server 2012 can also be impacted.  

### Active Directory Domain Services installation hangs if an error prevents critical replication

If the AD DS installation encounters an error during the critical replication phase, the installation can hang indefinitely. For example, if networking errors prevent critical replication from completing, the installation will not proceed.  
  
If you are installing using Server Manager, you may see the installation progress page remain open, but there is no error reported on screen, and the progress may not change for about 15 minutes. If you are using Windows PowerShell, the progress shown in the Windows PowerShell window will not change for more than 15 minutes.  
  
If you experience this problem, check the dcpromo.log file in the %systemroot%\debug folder on the target server. The log file will typically indicate repeated failures to replicate. Some known causes for this problem are:  

- Networking problems prevent critical replication between the target server being promoted and the replication source domain controller.  

   For example, the dcpromo.log shows:  

   ```  
   05/02/2012 14:16:46 [INFO] EVENTLOG (Error): NTDS Replication / DS RPC Client : 1963  
   Internal event: The following local directory service received an exception from a remote procedure call (RPC) connection. Extensive RPC information was requested. This is intermediate information and might not contain a possible cause.  
   Process ID:   
   500  
   Reported error information:  
   Error value:   
   Could not find the domain controller for this domain. (1908)  
   directory service:   
   <domain>.com  
   Extensive error information:  
   Error value:   
   A security package specific error occurred. 1825  
   directory service:   
   <DC Name>  
   ```  

   Because the installation process retries critical replication indefinitely, the domain controller installation proceeds if the underlying network problems are resolved. Investigate the networking problem using tools such as ipconfig, nslookup, and netmon as needed. Ensure connectivity exists between the domain controller you are promoting and the replication partner selected during the AD DS installation. Also make sure name resolution is working.  

   AD DS installation requirements for network connectivity and name resolution are validated during the prerequisite check before the installation begins. But some error conditions can arise in the time after prerequisite validation occurs and before the installation completes, such as if the replication partner becomes unavailable during installation.  

- During replica domain controller installation, the local Administrator account of the target server is specified for the installation credentials and the password of the local Administrator account matches the password of a Domain Admin account. In this case, you can complete the installation wizard and begin the installation before you encounter the "Access is denied" failure.  

   For example, the dcpromo.log shows:  

   ```  
   03/30/2012 11:36:51 [INFO] Creating the NTDS Settings object for this Active Directory Domain Controller on the remote AD DC DC2.contoso.com...  
   03/30/2012 11:36:51 [INFO] EVENTLOG (Error): NTDS Replication / DS RPC Client : 1963Internal event: The following local directory service received an exception from a remote procedure call (RPC) connection. Extensive RPC information was requested. This is intermediate information and might not contain a possible cause.  
   Process ID:   
   508  
   Reported error information:  
   Error value:   
   Access is denied. (5)  
   directory service:   
   DC2.contoso.com  
   ```  

   If the error is caused by specifying a local Administrator account and password, in order to recover you need to reinstall the operating system, [perform metadata cleanup](https://technet.microsoft.com/library/cc816907(WS.10).aspx) of the account for the domain controller that failed to complete installation, and then retry the AD DS installation using Domain Admin credentials. Restarting the server will not correct this error condition because the server will indicate that AD DS is installed even though the installation did not finish successfully.  

### <a name="BKMK_nonnormalDNSNameWarning"></a>Active Directory Domain Services Configuration Wizard warns when a non-normalized DNS name is specified

If you create a new domain or forest and you specify a DNS domain name that includes internationalized characters that are not normalized, then the Active Directory Domain Services Configuration Wizard displays a warning that DNS queries for the name can fail. Although the DNS domain name is specified in the Deployment Configuration page, the warning appears on the Prerequisites Check page later in the wizard.  

If a DNS domain name is specified using an un-normalized name like füßball.com or 'ΣΤ'.com (the normalized versions are: füssball.com and βστα.com), client applications that try to access it with WinHTTP will normalize the name before calling name resolution APIs. If the user types "'ΣΤ'.com" on some dialog, the DNS query will be sent as "βστα.com" and no DNS server will match it with a resource record for "'ΣΤ'.com". The user will be unable to resolve name.  

The following example explains one of the issues that can happen when using an IDN name that is not normalized:  

1. The domain using a non-normalized name is  created and registered on dns server: füßball.com  
2. Machine "nps" is joined to the domain and gets its name registered: nps.füßball.com  
3. A client application tries to connect to the server nps.füßball.com  
4. The client application tries to resolve the name nps.füßball.com calling name resolution APIs.  
5. Due to normalization, the name gets converted to nps.füssball.com and is queried over the wire as nps.füßball.com  
6. The client application is unable to resolve the name since the registered name is nps.füßball.com  

If the warning appears in the Prerequisites Check page in the Active Directory Domain Services Configuration Wizard, return to the Deployment Configuration page and specify a normalized DNS domain name. If you are installing a new domain using Windows PowerShell, specify a normalized DNS name for the -DomainName option.  

For more information about IDNs, see [Handling Internationalized Domain Names (IDNs)](https://msdn.microsoft.com/library/windows/desktop/dd318142(v=vs.85).aspx).  
