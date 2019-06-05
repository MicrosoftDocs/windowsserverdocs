---
ms.assetid: 5ab76733-804d-4f30-bee6-cb672ad5075a
title: Troubleshooting Domain Controller Deployment
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 03/20/2019
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---
# Troubleshooting Domain Controller Deployment

>Applies To: Windows Server 2016

This topic covers detailed methodology on troubleshooting domain controller configuration and deployment.  

## Introduction to Troubleshooting

![Troubleshooting](media/Troubleshooting-Domain-Controller-Deployment/adds_deploy_troubleshooting.png)  

## Built-in logs for troubleshooting

The built-in logs are the most important instrument for troubleshooting issues with domain controller promotion and demotion. All of these logs are enabled and configured for maximum verbosity by default.  

|Phase|Log|  
|---------|-------|  
|Server Manager or ADDSDeployment Windows PowerShell operations|-   %systemroot%\debug\dcpromoui.log<br /><br />-   %systemroot%\debug\dcpromoui*.log|  
|Installation/Promotion of the domain controller|-   %systemroot%\debug\dcpromo.log<br /><br />-   %systemroot%\debug\dcpromo*.log<br /><br />-   Event viewer\Windows logs\System<br /><br />-   Event viewer\Windows logs\Application<br /><br />-   Event viewer\Applications and services logs\Directory Service<br /><br />-   Event viewer\Applications and services logs\File Replication Service<br /><br />-   Event viewer\Applications and services logs\DFS Replication|  
|Forest or domain upgrade|-   %systemroot%\debug\adprep\\<datetime>\adprep.log<br /><br />-   %systemroot%\debug\adprep\\<datetime>\csv.log<br /><br />-   %systemroot%\debug\adprep\\<datetime>\dspecup.log<br /><br />-   %systemroot%\debug\adprep\\<datetime>\ldif.log*|  
|Server Manager ADDSDeployment Windows PowerShell deployment engine|-   Event viewer\Applications and services logs\Microsoft\Windows\DirectoryServices-Deployment\Operational|  
|Windows Servicing|-   %systemroot%\Logs\CBS\\*<br /><br />-   %systemroot%\servicing\sessions\sessions.xml<br /><br />-   %systemroot%\winsxs\poqexec.log<br /><br />-   %systemroot%\winsxs\pending.xml|  

### Tools and Commands for Troubleshooting Domain Controller Configuration

To troubleshoot issues not explained by the logs, use the following tools as a starting point:  

-   Dcdiag.exe  

-   Repadmin.exe  

-   [AutoRuns.exe](https://technet.microsoft.com/sysinternals/bb963902.aspx), Task Manager, and MSInfo32.exe  

-   [Network Monitor 3.4](https://www.microsoft.com/download/en/details.aspx?displaylang=en&id=4865) (or a third party network capture and analysis tool)  

### General Methodology for Troubleshooting Domain Controller Configuration  

1.  Did a simple syntax issue cause the error?  

    1.  Did you mistype or forget to provide an argument to ADDSDeployment Windows PowerShell? For example, if using ADDSDeployment Windows PowerShell, did you forget to add required argument **-domainname** with a valid name?  

    2.  Examine the Windows PowerShell console output carefully to see exactly why it is failing to parse the command-line provided.  

2.  Is the error a prerequisite failure?  

    1.  Many errors that used to appear as fatal promotion results are now prevented by the prerequisite checker.  

    2.  Examine the text of the prerequisite errors carefully, they provide the necessary guidance to resolve most issues, as they are controlled scenarios.  

3.  Is the error in promotion and therefore fatal?  

    1.  Examine the results carefully: many errors have simple explanations such as bad passwords, network name resolution, or critical offline domain controllers.  

    2.  Examine the Dcpromoui.log and dcpromo.log for the errors shown in the output, then work backwards from them to see indications of why the failure occurred.  

        1.  Always compare to a working sample log  

        2.  Examine the ADPrep logs for errors only if the results indicate a problem extending the schema or preparing the forest or domain.  

        3.  Examine the DirectoryServices-Deployment event log for errors only if the Dcpromoui.log lacks detail or ends arbitrarily due to an unhandled exception in the configuration process.  

    3.  Examine the Directory Services, System, and Application event logs for other indicators of a configuration issue. Often times, the domain controller promotion is just a symptom of other network misconfiguration that would affect all distributed systems.  

    4.  Use dcdiag.exe and repadmin.exe to validate the overall forest health and indicate subtle misconfigurations that may prevent further domain controller promotion.  

    5.  Use AutoRuns.exe, Task Manager, or MSinfo32.exe to examine the computer for third party software that may be interfering.  

        1.  Remove third party software (do not simply disable the software; that does not prevent drivers loading).  

    6.  Install NetMon 3.4 on the computer that fails to promote as well the replication partner domain controller and analyze the promotion process with double-sided network captures.  

        1.  Compare this to your working lab environment to understand what a healthy promotion looks like and where it is failing.  

        2.  At this point, the errors are likely with the forest objects, non-default security changes, or the network, and this new domain controller is a victim of misconfigurations in DNS, firewalls, host intrusion protection software, or other outside factors.  

## Troubleshooting Events and Error Messages

Domain controller promotion and demotion always returns a code at the end of operation and unlike most programs, do not return zero for success. To see the code at the end of a domain controller configuration, you have several options:  

1. When using Server Manager, examine the promotion results in the ten seconds prior to automatic reboot.  

2. When using ADDSDeployment Windows PowerShell, examine the promotion results in the ten seconds prior to automatic reboot. Alternatively, choose not to restart automatically on completion. You should add the **Format-List** pipeline to make the output easier to read. For example:  

   ```  
   Install-addsdomaincontroller <options> -norebootoncompletion:$true | format-list  

   ```  

   Errors in prerequisite validation and verification do not continue on to a reboot, so they are visible in all cases. For example:  

   ![Troubleshooting](media/Troubleshooting-Domain-Controller-Deployment/ADDS_PSPrereqError.png)  

3. In any scenario, examine the dcpromo.log and dcpromoui.log.  

   > [!NOTE]  
   > Some of the errors listed below are no longer possible due to operating system and domain controller configuration changes in later operating systems. The new ADDSDeployment Windows PowerShell codes also prevents certain errors, but the dcpromo.exe /unattend does not; this is another compelling reason to switch all of your current automation from the deprecated DCPromo to ADDSDeployment Windows PowerShell.  

### Promotion and demotion success codes

|Error Code|Explanation|Note|  
|--------------|---------------|--------|  
|1|Exit, success|You still must reboot, this just notes that the automatic restart flag was removed|  
|2|Exit, success, need to reboot||  
|3|Exit, success, with a non-critical failure|Typically seen when returning the DNS Delegation warning. If not configuring DNS delegation, use:<br /><br />-creatednsdelegation:$false|  
|4|Exit, success, with a non-critical failure, need to reboot|Typically seen when returning the DNS Delegation warning. If not configuring DNS delegation, use:<br /><br />-creatednsdelegation:$false|  

### Promotion and demotion failure codes

Promotion and demotion return the following failure message codes. There is also likely to be an extended error message; always read the entire error carefully, not just the numeric portion.  


| Error Code |                                                           Explanation                                                            |                                                                                                                            Suggested resolution                                                                                                                            |
|------------|----------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     11     |                                          Domain controller promotion is already running                                          |                                                                                 Do not run than one instance of domain controller promotion at the same time for the same target computer                                                                                  |
|     12     |                                                    User must be administrator                                                    |                                                                                        Logon as a member of the built-in Administrators group and ensure you are elevating with UAC                                                                                        |
|     13     |                                               Certification Authority is installed                                               | You cannot demote this domain controller, as it is also a Certification Authority. Do not remove the CA before you carefully inventory its usage - if it is issuing certificates, removing the role will cause an outage. Running CAs on domain controllers is discouraged |
|     14     |                                                    Running in safe-boot mode                                                     |                                                                                                                      Boot the server into normal mode                                                                                                                      |
|     15     |                                            Role change is in progress or needs reboot                                            |                                                                                             You must restart the server (due to prior configuration changes) before promotion                                                                                              |
|     16     |                                                    Running on wrong platform                                                     |                                                                                                                       *Not likely to get this error*                                                                                                                       |
|     17     |                                                      No NTFS 5 drives exist                                                      |                                                                            This error is not possible in Windows Server 2012, which requires at least the %systemdrive% be formatted with NTFS                                                                             |
|     18     |                                                    Not enough space in windir                                                    |                                                                                                        Free up space on the %systemdrive% volume using cleanmgr.exe                                                                                                        |
|     19     |                                                Name change pending, needs reboot                                                 |                                                                                                                             Reboot the server                                                                                                                              |
|     20     |                                                 Computer name is invalid syntax                                                  |                                                                                                                   Rename the computer with a valid name                                                                                                                    |
|     21     |                             This domain controller holds FSMO roles, is a GC, and/or is a DNS server                             |                                                                                                      Add **-demoteoperationmasterrole** when using **-forceremoval**.                                                                                                      |
|     22     |                                        TCP/IP needs to be installed or isn't functioning                                         |                                                                                                    Verify computer has TCP/IP configured, bound, and working correctly                                                                                                     |
|     23     |                                             DNS client needs to be configured first                                              |                                                                                                  Set a primary DNS server when adding a new domain controller to a domain                                                                                                  |
|     24     |                                  Supplied credentials are invalid or missing required elements                                   |                                                                                                               Verify your user name and password is correct                                                                                                                |
|     25     |                                 Domain controller for the specified domain could not be located                                  |                                                                                                                Validate DNS client settings, firewall rules                                                                                                                |
|     26     |                                        List of domains could not be read from the forest                                         |                                                                                                      Validate DNS client settings, LDAP functionality, firewall rules                                                                                                      |
|     27     |                                                       Missing domain name                                                        |                                                                                                                Specify a domain when promoting or demoting                                                                                                                 |
|     28     |                                                         Bad domain name                                                          |                                                                                                          Choose a different, valid DNS domain name when promoting                                                                                                          |
|     29     |                                                   Parent domain does not exist                                                   |                                                                                             Verify the parent domain specified when creating a new child domain or tree domain                                                                                             |
|     30     |                                                       Domain not in forest                                                       |                                                                                                                      Verify the domain name provided                                                                                                                       |
|     31     |                                                   Child Domain already exists                                                    |                                                                                                                      Specify a different domain name                                                                                                                       |
|     32     |                                                     Bad NetBIOS domain name                                                      |                                                                                                                    Specify a valid NetBIOS domain name                                                                                                                     |
|     33     |                                                 Path to the IFM files is invalid                                                 |                                                                                                            Validate your path to the Install From Media folder                                                                                                             |
|     34     |                                                     The IFM database is bad                                                      |                                                          Use the correct Install From Media for this operating system and role (same operating system version, same type of domain controller - RODC versus RWDC)                                                          |
|     35     |                                                          Missing SYSKEY                                                          |                                                                                             The Install from Media is encrypted and you must provide a valid SYSKEY to use it                                                                                              |
|     37     |                                          Path for NTDS Database or its logs is invalid                                           |                                                                                          Change path of Database and Logs to a fixed NTFS volume, not a mapped drive or UNC path                                                                                           |
|     38     |                                   Volume does not have enough space for NTDS database or logs                                    |                                                                              Free up space using cleanmgr.exe, add more disk space, manually clear space by moving unnecessary data elsewhere                                                                              |
|     39     |                                                    Path for SYSVOL is invalid                                                    |                                                                                            Change path of SYSVOL folder to a fixed NTFS volume, not a mapped drive or UNC path                                                                                             |
|     40     |                                                        Invalid site name                                                         |                                                                                                                      Provide a site name that exists                                                                                                                       |
|     41     |                                             Need to specify a password for safe-mode                                             |                                                                                Provide a password for the DSRM account, it cannot be blank no matter how the password policy is configured                                                                                 |
|     42     |                                    Safe-mode password does not meet criteria (promotion only)                                    |                                                                                         Provide a password for the DSRM account that meets the password policy's configured rules                                                                                          |
|     43     |                                      Admin password does not meet criteria (demotion only)                                       |                                                                                  Provide a password for the local administrator account that meets the password policy's configured rules                                                                                  |
|     44     |                                           The specified name for the forest is invalid                                           |                                                                                                                Specify a valid forest root DNS domain name                                                                                                                 |
|     45     |                                         A forest with the specified name already exists                                          |                                                                                                               Choose a different forest root DNS domain name                                                                                                               |
|     46     |                                            The specified name for the tree is invalid                                            |                                                                                                                    Specify a valid tree DNS domain name                                                                                                                    |
|     47     |                                          A tree with the specified name already exists                                           |                                                                                                                  Choose a different tree DNS domain name                                                                                                                   |
|     48     |                                       The tree name does not fit into the forest structure                                       |                                                                                                                  Choose a different tree DNS domain name                                                                                                                   |
|     49     |                                               The specified domain does not exist                                                |                                                                                                                       Verify your typed domain name                                                                                                                        |
|     50     | During demote, last domain controller was detected even though it is not, or last domain controller was specified, but it is not |        Do not specify **Last Domain Controller in the Domain** (**-lastdomaincontrollerindomain**) unless it is true. Use **-ignorelastdcindomainmismatch** to override if this is truly the last domain controller and there is phantom domain controller metadata        |
|     51     |                                          App partitions exist on this domain controller                                          |                                                                                              Specify to **Remove Application Partitions** (**-removeapplicationpartitions**)                                                                                               |
|     52     |            Required command-line argument is missing (that is, an answer file must be specified on the command-line)             |                                                                                              *Only seen with dcpromo /unattend, which is deprecated. See older documentation*                                                                                              |
|     53     |                               The promotion/demotion failed, machine must be rebooted to clean up                                |                                                                                                                    Examine the extended error and logs                                                                                                                     |
|     54     |                                                  The promotion/demotion failed                                                   |                                                                                                                    Examine the extended error and logs                                                                                                                     |
|     55     |                                         The promotion/demotion was canceled by the user                                          |                                                                                                                    Examine the extended error and logs                                                                                                                     |
|     56     |                      The promotion/demotion was canceled by the user, machine must be rebooted to clean up                       |                                                                                                                    Examine the extended error and logs                                                                                                                     |
|     58     |                                       A site name must be specified during RODC promotion                                        |                                                                                           You must specify a site for an RODC, it will not automatically detect one like an RWDC                                                                                           |
|     59     |                        During demote, this domain controller is the last DNS server for one of its zones                         |                                                                                    Specify that this is the **Last DNS Server in the Domain** or use **-ignorelastdnsserverfordomain**                                                                                     |
|     60     |         A domain controller running Windows Server 2008 or later must be present in the domain in order to promote RODC          |                                                                                             Promote at least one Windows Server 2008 or later model writable domain controller                                                                                             |
|     61     |        You cannot install Active Directory Domain Services with DNS in an existing domain that does not already host DNS         |                                                                                                                      *Not possible to get this error*                                                                                                                      |
|     62     |                                         Answer file does not have a [DCInstall] section                                          |                                                                                             *Only seen with dcpromo /unattend, which is deprecated. See older documentation.*                                                                                              |
|     63     |                                       Forest functional level is below windows server 2003                                       |                                                            Raise the forest functional level to at least Windows Server 2003 Native. Windows 2000 and Windows NT 4.0 are no longer supported operating systems                                                             |
|     64     |                                      Promo failed because component binary detection failed                                      |                                                                                                                           Install the AD DS role                                                                                                                           |
|     65     |                                    Promo failed because component binary installation failed                                     |                                                                                                                           Install the AD DS role                                                                                                                           |
|     66     |                                      Promo failed because operating system detection failed                                      |                                  Examine the extended error and logs; the server is failing to return its operating system version. It is likely that the computer will need to be re-installed, as its overall health is highly suspect                                   |
|     68     |                                                  Replication partner is invalid                                                  |                                                                             Use repadmin.exe or the **Get-ADReplication\\**\* Windows PowerShell to validate partner domain controller health                                                                              |
|     69     |                                    Required Port is already in use by some other application                                     |                                                                                    Use **netstat.exe -anob** to locate processes that are incorrectly assigned to reserved AD DS ports                                                                                     |
|     70     |                                          The forest root domain controller must be a GC                                          |                                                                                              *Only seen with dcpromo /unattend, which is deprecated. See older documentation*                                                                                              |
|     71     |                                                 DNS server is already installed                                                  |                                                                                          Do not specify to install DNS (**-installDNS**) if the DNS service is already installed                                                                                           |
|     72     |                                  Computer is running Remote Desktop Services in non-admin mode                                   |        You cannot promote this domain controller, as it is also a RDS server configured for more than two admin users. Do not remove RDS before you carefully inventory its usage - if it is being used by applications or end-users, removal will cause an outage         |
|     73     |                                        The specified forest functional level is invalid.                                         |                                                                                                                  Specify a valid forest functional level                                                                                                                   |
|     74     |                                        The specified domain functional level is invalid.                                         |                                                                                                                  Specify a valid domain functional level                                                                                                                   |
|     75     |                                   Unable to determine the default password replication policy.                                   |                                                                                                Validate that the RODC password replication policy exists and is accessible                                                                                                 |
|     76     |                                 Specified replicated/non-replicated security groups are invalid                                  |                                                                                Validate that you have typed in valid domain and user accounts when specifying a password replication policy                                                                                |
|     77     |                                                The specified argument is invalid                                                 |                                                                                                                    Examine the extended error and logs                                                                                                                     |
|     78     |                                            Failed to examine Active Directory Forest                                             |                                                                                                                    Examine the extended error and logs                                                                                                                     |
|     79     |                                 RODC cannot be promoted because rodcprep has not been performed                                  |                                                                                               Use Windows Server 2012 to prepare the forest or use **adprep.exe /rodcprep**                                                                                                |
|     80     |                                                Domainprep has not been performed                                                 |                                                                                              Use Windows Server 2012 to prepare the domain or use **adprep.exe /domainprep**                                                                                               |
|     81     |                                                Forestprep has not been performed                                                 |                                                                                              Use Windows Server 2012 to prepare the forest or use **adprep.exe /forestprep**                                                                                               |
|     82     |                                                      Forest schema mismatch                                                      |                                                                                              Use Windows Server 2012 to prepare the forest or use **adprep.exe /forestprep**                                                                                               |
|     83     |                                                         Unsupported SKU                                                          |                                                                                                                       *Not likely to get this error*                                                                                                                       |
|     84     |                                           Unable to detect a domain controller account                                           |                                                                                         Validate that existing domain controllers have correct user account control attribute set.                                                                                         |
|     85     |                                     Unable to select a domain controller account for stage 2                                     |                                                 Returned if you specify "Use Existing Account" but either no account found or there is an error during account lookup. Ensure you provided the correct RODC staged account                                                 |
|     86     |                                                  Need to run stage 2 promotion                                                   |                                                                       Returned if you promote an additional domain controller but an existing account exists and "Allow Reinstall" was not specified                                                                       |
|     87     |                                      A domain controller account of conflicting type exists                                      |   Rename the computer before promoting, if not trying to attach to an unoccupied domain controller. You must attach to the unoccupied domain controller account using **-useexistingaccount** and the correct read-only or writable argument, depending on account type    |
|     88     |                                             The specified server admin is not valid                                              |                                                                           You specified an invalid account for RODC admin delegation. Verify that the account specified is a valid user or group                                                                           |
|     89     |                                         RID master for the specified domain is offline.                                          |                                                                 Use **netdom.exe query fsmo** to detect the RID master. Bring it online and make it accessible to the domain controller you are promoting                                                                  |
|     90     |                                                 Domain naming master is offline.                                                 |                                                            Use **netdom.exe query fsmo** to detect the domain naming master. Bring it online and make it accessible to the domain controller you are promoting                                                             |
|     91     |                                             Failed to detect if the process is wow64                                             |                                                                                                  *Not possible to get this error anymore, the operating system is 64-bit*                                                                                                  |
|     92     |                                                  Wow64 process is not supported                                                  |                                                                                                  *Not possible to get this error anymore, the operating system is 64-bit*                                                                                                  |
|     93     |                                Domain controller service is not running for non-forceful demotion                                |                                                                                                                          Start the AD DS service                                                                                                                           |
|     94     |                           Local admin password does not meet requirement: either blank or not required                           |                                                                                         Provide a non-blank password and ensure that the local password policy requires a password                                                                                         |
|     95     |              Cannot demote last Windows Server 2008 or later domain controller in the domain where live RODCs exist              |                                                                             You must first demote all RODCs before you can demote all Windows Server 2008 or later writable domain controllers                                                                             |
|     96     |                                                 Unable to uninstall DS binaries                                                  |                                                                                              *Only seen with dcpromo /unattend, which is deprecated. See older documentation*                                                                                              |
|     97     |                      Forest functional level version higher than that of the child domain operating system                       |                                                                                           Provide a child domain functional the same or higher than the forest functional level                                                                                            |
|     98     |                                        Component binary install/uninstall is in progress.                                        |                                                                                              *Only seen with dcpromo /unattend, which is deprecated. See older documentation*                                                                                              |
|     99     |                              Forest functional level is too low (error is Windows Server 2012 only)                              |                                                            Raise the forest functional level to at least Windows Server 2003 native. Windows 2000 and Windows NT 4.0 are no longer supported operating systems                                                             |
|    100     |                              Domain functional level is too low (error is Windows Server 2012 only)                              |                                                            Raise the domain functional level to at least Windows Server 2003 native. Windows 2000 and Windows NT 4.0 are no longer supported operating systems                                                             |

## Known issues and common support scenarios

The following are common issues seen during the Windows Server 2012 development process. All of these issues are "by design" and have either a valid workaround or more appropriate technique to avoid them in the first place. Many of these behaviors are identical in Windows Server 2008 R2 and older operating systems, but the rewrite of AD DS deployment brings heightened sensitivity to issues.  

|Issue|Demoting a domain controller leaves DNS running with no zones|  
|---------|-----------------------------------------------------------------|  
|Symptoms|Server still responds to DNS requests but has no zone information|  
|Resolution and Notes|When removing the AD DS role, also remove the DNS Server role or set the DNS Server service to disabled. Remember to point the DNS client to another server than itself. If using Windows PowerShell, run the following after you demote the server:<br /><br />Code - uninstall-windowsfeature dns<br /><br />or<br /><br />Code - set-service dns -starttype disabled<br />stop-service dns|  

|Issue|Promoting a Windows Server 2012 into an existing single-label domain does not configure updatetopleveldomain=1 or allowsinglelabeldnsdomain=1|  
|---------|----------------------------------------------------------------------------------------------------------------------------------------------------|  
|Symptoms|DNS dynamic record registration does not occur|  
|Resolution and Notes|Set these values using the Netlogon and DNS group policies. Microsoft began blocking single-label domain creation in Windows Server 2008; you can use ADMT or the Domain Rename Tool to change to an approved DNS domain structure.|  

|Issue|Demotion of last domain controller in a domain fails if there are pre-created, unoccupied RODC accounts|  
|---------|------------------------------------------------------------------------------------------------------------|  
|Symptoms|Demotion fails with message:<br /><br />**Dcpromo.General.54**<br /><br />Active Directory Domain Services could not find another Active Directory Domain Controller to transfer the remaining data in directory partition CN=Schema,CN=Configuration,DC=corp,DC=contoso,DC=com.<br /><br />"The format of the specified domain name is invalid."|  
|Resolution and Notes|Remove any remaining pre-created RODC accounts before demoting a domain, using **Dsa.msc** or **Ntdsutil.exe metadata cleanup**.|  

|Issue|Automated forest and domain preparation does not run GPPREP|  
|---------|---------------------------------------------------------------|  
|Symptoms|Cross-domain planning functionality for Group Policy, Resultant Set of Policy (RSOP) Planning Mode, requires updated file system and Active Directory permissions for existing GP. Without Gpprep, you cannot use RSOP Planning across domains.|  
|Resolution and Notes|Run **adprep.exe /gpprep** manually for all domains that were not previously prepared for Windows Server 2003, Windows Server 2008, or Windows Server 2008 R2. Administrators should run GPPrep only once in the history of a domain, not with every upgrade. It is not run by automatic adprep because if you have already set adequate custom permissions, it would cause all SYSVOL contents to re-replicate on all domain controllers.|  

|Issue|Install from media fails to verify when pointing to a UNC path|  
|---------|------------------------------------------------------------------|  
|Symptoms|Error returned:<br /><br />Code - Could not validate media path. Exception calling "GetDatabaseInfo" with "2" arguments. The folder is not valid.|  
|Resolution and Notes|You must store IFM files on a local disk, not a remote UNC path. This intentional block prevents partial server promotion due to a network interruption.|  

|Issue|DNS delegation warning shown twice during domain controller promotion|  
|---------|-------------------------------------------------------------------------|  
|Symptoms|Warning returned *twice* when promoting using ADDSDeployment Windows PowerShell:<br /><br />Code - "A delegation for this DNS server cannot be created because the authoritative parent zone cannot be found or it does not run Windows DNS server. If you are integrating with an existing DNS infrastructure, you should manually create a delegation to this DNS server in the parent zone to ensure reliable name resolution from outside the domain. Otherwise, no action is required."|  
|Resolution and Notes|Ignore. ADDSDeployment Windows PowerShell shows the warning first during prerequisite checking, then again during configuration of the domain controller. If you do not wish to configure DNS delegation, use argument:<br /><br />Code - -creatednsdelegation:$false<br /><br />Do *not* skip the prerequisite checks in order to suppress this message|  

|Issue|Specifying UPN or non-domain credentials during configuration returns misleading errors|  
|---------|--------------------------------------------------------------------------------------------|  
|Symptoms|Server Manager returns error:<br /><br />Code - Exception calling "DNSOption" with "6" Arguments<br /><br />ADDSDeployment Windows PowerShell returns error:<br /><br />Code - Verification of user permissions failed. You must supply the name of the domain to which this user account belongs.|  
|Resolution and Notes|Ensure you are providing valid domain credentials in the form of **domain\user**.|  

|Issue|Removing the DirectoryServices-DomainController role using Dism.exe leads to unbootable server|  
|---------|---------------------------------------------------------------------------------------------------|  
|Symptoms|If using Dism.exe to remove the AD DS role before demoting a domain controller gracefully, the server no longer boots normally and shows error:<br /><br />Code - Status: 0x000000000<br />Info: An unexpected error has occurred.|  
|Resolution and Notes|Boot into Directory Services Repair Mode using *Shift+F8*. Add the AD DS role back, and then forcibly demote the domain controller. Alternatively, restore the System State from backup. Do not use Dism.exe for AD DS role removal; the utility has no knowledge of domain controllers.|  

|Issue|Installing a new forest fails when setting forestmode to Win2012|  
|---------|--------------------------------------------------------------------|  
|Symptoms|Promotion using ADDSDeployment Windows PowerShell returns error:<br /><br />Code -  Test.VerifyDcPromoCore.DCPromo.General.74<br /><br />Verification of prerequisites for Domain Controller promotion failed. The specified domain functional level is invalid|  
|Resolution and Notes|Do not specify a forest functional mode of Win2012 without *also* specifying a domain functional mode of Win2012. Here is an example that will work without errors:<br /><br />Code - -forestmode Win2012 -domainmode Win2012]|  

|||  
|-|-|  
|Issue|Clicking Verify in the Install from Media selection area appears to do nothing|  
|Symptoms|When you specify a path to an IFM folder, clicking the **Verify** button never returns a message or appears to do anything.|  
|Resolution and Notes|The **Verify** button only returns errors if there are issues. Otherwise, it makes the **Next** button selectable if you have provided an IFM path. You must click **Verify** to proceed if you have selected IFM.|  

|||  
|-|-|  
|Issue|Demoting with Server Manager does not provide feedback until completed.|  
|Symptoms|When using Server Manager to remove the AD DS role and demote a domain controller, there is no ongoing feedback given until the demotion completes or fails.|  
|Resolution and Notes|This is a limitation of Server Manager. For feedback, use ADDSDeployment Windows PowerShell cmdlet:<br /><br />Code - Uninstall-addsdomaincontroller|  

|||  
|-|-|  
|Issue|Install from Media Verify does not detect that RODC media provided for writable domain controller, or vice versa.|  
|Symptoms|When promoting a new domain controller using IFM and providing incorrect media to IFM - such as RODC media for a writable domain controller, or RWDC media for an RODC - the Verify button does not return an error. Later, promotion fails with error:<br /><br />Code - An error occurred while trying to configure this machine as a domain controller. <br />The Install-From-Media promotion of a Read-Only DC cannot start because the specified source database is not allowed. Only databases from other RODCs can be used for IFM promotion of a RODC.|  
|Resolution and Notes|Verify only validates the overall integrity of IFM. Do not provide the wrong IFM type to a server. Restart the server before you attempt promotion again with the correct media.|  

|||  
|-|-|  
|Issue|Promoting an RODC into a pre-created computer account fails|  
|Symptoms|When using ADDSDeployment Windows PowerShell to promote a new RODC with a staged computer account, receive error:<br /><br />Code - Parameter set cannot be resolved using the specified named parameters.    <br />InvalidArgument: ParameterBindingException<br />    + FullyQualifiedErrorId : AmbiguousParameterSet,Microsoft.DirectoryServices.Deployment.PowerShell.Commands.Install|  
|Resolution and Notes|Do not provide parameters already defined already on a pre-created RODC account. These include:<br /><br />Code - -readonlyreplica<br />-installdns<br />-donotconfigureglobalcatalog<br />-sitename<br />-installdns|  

|||  
|-|-|  
|Issue|Deselecting/selecting "Restart each destination server automatically if required" does nothing|  
|Symptoms|If selecting (or not selecting) the Server Manager option **Restart each destination server automatically if required** whendemoting a domain controller through role removal, the server always restarts, regardless of choice.|  
|Resolution and Notes|This is intentional. The demotion process restarts the server regardless of this setting.|  

|||  
|-|-|  
|Issue|Dcpromo.log shows "[error] setting security on server files failed with 2"|  
|Symptoms|Demotion of a domain controller completes without issues, but examination of the dcpromo log shows error:<br /><br />Code - [error] setting security on server files failed with 2|  
|Resolution and Notes|Ignore, error is expected and cosmetic.|  

|||  
|-|-|  
|Issue|Prerequisite adprep check fails with error "Unable to perform Exchange schema conflict check"|  
|Symptoms|When attempting to promote a Windows Server 2012 domain controller into an existing Windows Server 2003, Windows Server 2008, or Windows Server 2008 R2 forest, prerequisite check fails with error:<br /><br />Code - Verification of prerequisites for AD prep failed. Unable to perform Exchange schema conflict check for domain  *<domain name>* (Exception: the RPC server is unavailable)<br /><br />The adprep.log shows error:<br /><br />Code - Adprep could not retrieve data from the server *<domain controller>*<br /><br />through Windows Management Instrumentation (WMI).|  
|Resolution and Notes|The new domain controller cannot access WMI through DCOM/RPC protocols against the existing domain controllers. To date, there have been three causes for this:<br /><br />-   A firewall rule blocks access to the existing domain controllers<br /><br />-   The NETWORK SERVICE account is missing from the "Logon as a service" (SeServiceLogonRight) privilege on the existing domain controllers<br /><br />-   NTLM is disabled on domain controllers, using security policies described in [Introducing the Restriction of NTLM Authentication](https://technet.microsoft.com/library/dd560653(WS.10).aspx)|  

|||  
|-|-|  
|Issue|Creating a new AD DS forest always shows DNS warning|  
|Symptoms|When creating a new AD DS forest and creating the DNS zone on the new domain controller for itself, you always receive warning message:<br /><br />Code - An error was detected in the DNS configuration. <br />None of the DNS servers used by this computer responded within the timeout interval.<br />(error code 0x000005B4 "ERROR_TIMEOUT")|  
|Resolution and Notes|Ignore. This warning is intentional on the first domain controller in the root domain of a new forest, in case you intended to point to an existing DNS server and zone.|  

|||  
|-|-|  
|Issue|Windows PowerShell -whatif argument returns incorrect DNS server information|  
|Symptoms|If you use the **-whatif** argument when configuring a domain controller with implicit or explicit **-installdns:$true**, the resulting output shows:<br /><br />Code - "DNS Server: No"|  
|Resolution and Notes|Ignore. DNS is installed and configured correctly.|  

|||  
|-|-|  
|Issue|After promotion, logon fails with " Not enough storage is available to process this command"|  
|Symptoms|After you promote a new domain controller and then log off and attempt to log on interactively, you receive error:<br /><br />Code - Not enough storage is available to process this command|  
|Resolution and Notes|The domain controller was not rebooted after promotion, either due to an error or because you specified the ADDSDeployment Windows PowerShell argument **-norebootoncompletion**. Restart the domain controller.|  

|||  
|-|-|  
|Issue|The Next button is not available on the Domain Controller Options page|  
|Symptoms|Even though you have set a password, the **Next** button on the **Domain Controller Options** page in Server Manager is not available. There is no site listed in the **Site name** menu.|  
|Resolution and Notes|You have multiple AD DS sites and at least one is missing subnets; this future domain controller belongs to one of those subnets. You must manually select the subnet from the Site name dropdown menu. You should also review all AD sites using DSSITE.MSC or use the following Windows PowerShell command to find all sites missing subnets:<br /><br />Code - get-adreplicationsite -filter \* -property subnets &#124; where-object {!$_.subnets -eq "\*"} &#124; format-table name|  

|||  
|-|-|  
|Issue|Promotion or demotion fails with message "the service cannot be started"|  
|Symptoms|If you attempt promotion, demotion, or cloning of a domain controller you receive error:<br /><br />Code - The service cannot be started, either because it is disabled or it has no enabled devices associated with it" (0x80070422)<br /><br />The error may be interactive, an event, or written to a log like dcpromoui.log or dcpromo.log|  
|Resolution and Notes|The DS Role Server service (DsRoleSvc) is disabled. By default, this service is installed during AD DS role installation and set to a Manual start type. Do not disable this service. Set it back to Manual and allow the DS role operations to start and stop it on demand. This behavior is by design.|  

|||  
|-|-|  
|Issue|Server Manager still warns that you need to promote DC|  
|Symptoms|If you promote a domain controller using the deprecated dcpromo.exe /unattend or upgrade an existing Windows Server 2008 R2 domain controller in place to Windows Server 2012, Server Manager still shows the post-deployment configuration task **Promote this server to a domain controller**.|  
|Resolution and Notes|Click the post-deployment warning link and the message will disappear for good. This behavior is cosmetic and expected.|  

|||  
|-|-|  
|Issue|Server Manager deployment script missing role installation|  
|Symptoms|If you promote a domain controller using Server Manager and save the Windows PowerShell deployment script, it does not include the role installation cmdlet and arguments (install-windowsfeature -name ad-domain-services -includemanagementtools). Without the role, the DC cannot be configured.|  
|Resolution and Notes|Manually add that cmdlet and arguments to any scripts. This behavior is expected and by design.|  

|||  
|-|-|  
|Issue|Server Manager deployment script is not named PS1|  
|Symptoms|If you promote a domain controller using Server Manager and save the Windows PowerShell deployment script, the file is named with a random temporary name and not as a PS1 file.|  
|Resolution and Notes|Manually rename the file. This behavior is expected and by design.|  

|Issue|Dcpromo /unattend allows unsupported functional levels|  
|-|-|  
|Symptoms|If you promote a domain controller using dcpromo /unattend with the following sample answer file:<br /><br />Code -<br /><br />[DCInstall]<br />NewDomain=Forest<br /><br />ReplicaOrNewDomain=Domain<br /><br />NewDomainDNSName=corp.contoso.com<br /><br />SafeModeAdminPassword=Safepassword@6<br /><br />DomainNetbiosName=corp<br /><br />DNSOnNetwork=Yes<br /><br />AutoConfigDNS=Yes<br /><br />RebootOnSuccess=NoAndNoPromptEither<br /><br />RebootOnCompletion=No<br /><br />*DomainLevel=0*<br /><br />*ForestLevel=0*<br /><br />Promotion fails with the following errors in the dcpromoui.log:<br /><br />Code - dcpromoui EA4.5B8 0089 13:31:50.783       Enter CArgumentsSpec::ValidateArgument DomainLevel<br /><br />dcpromoui EA4.5B8 008A 13:31:50.783         Value for DomainLevel is 0<br /><br />dcpromoui EA4.5B8 008B 13:31:50.783   Exit code is 77<br /><br />dcpromoui EA4.5B8 008C 13:31:50.783   The specified argument is invalid.<br /><br />dcpromoui EA4.5B8 008D 13:31:50.783 closing log<br /><br />dcpromoui EA4.5B8 0032 13:31:50.830   Exit code is 77<br /><br />Level 0 is Windows 2000, which is not supported in Windows Server 2012.|  
|Resolution and Notes|Do not use the deprecated dcpromo /unattend and understand that it allows you to specify invalid settings that later fail. This behavior is expected and by design.|  

|Issue|Promotion "hangs" at creating NTDS settings object, never completes|  
|-|-|  
|Symptoms|If you promote a replica DC or RODC, the promotion reaches "creating NTDS settings object" and never proceeds or completes. The logs stop updating as well.|  
|Resolution and Notes|This is a known issue caused by providing credentials of the built-in local Administrator account with a matching password to the built-in domain Administrator account. This causes a failure down in the core setup engine that does not error, but instead waits indefinitely (quasi-loop). This is expected - albeit undesirable - behavior.<br /><br />To fix the server:<br /><br />1.  Reboot it.<br /><br />1.  In AD, delete that server's member computer account (it will not yet be a DC account)<br /><br />1.  On that server, forcibly disjoin it from the domain<br /><br />1.  On that server, remove the AD DS role.<br /><br />1.  Reboot<br /><br />1.  Re-add the AD DS role and reattempt promotion, ensuring that you always provide the ***domain\admin*** formatted credentials to DC promotion and not just the built-in local administrator account|  
