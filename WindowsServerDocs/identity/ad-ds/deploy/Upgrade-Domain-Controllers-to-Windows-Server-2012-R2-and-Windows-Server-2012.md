---
title: Upgrade Domain Controllers to Windows Server 2012 R2 and Windows Server 2012
description: Learn more about upgrading domain controllers to Windows Server 2012 R2 and Windows Server 2012
ms.author: daveba
author: iainfoulds
ms.date: 05/16/2023
ms.topic: article
ms.custom: inhenke
---

# Upgrade Domain Controllers to Windows Server 2012 R2 and Windows Server 2012

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This article provides background information about Active Directory Domain Services in  Windows Server 2012 R2  and  Windows Server 2012  and explains the process for upgrading domain controllers from Windows Server 2008 or Windows Server 2008 R2.

## <a name="BKMK_UpgradeWorkflow"></a>Domain controller upgrade steps

The recommended way to upgrade a domain is to promote domain controllers that run newer versions of Windows Server and demote older domain controllers as needed. That method is preferable to upgrading the operating system of an existing domain controller. This list covers general steps to follow before you promote a domain controller that runs a newer version of Windows Server:

1. Verify the target server meets [system requirements](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn303418(v=ws.11)).
1. Verify [Application compatibility](../../ad-ds/deploy/Upgrade-Domain-Controllers-to-Windows-Server-2012-R2-and-Windows-Server-2012.md#BKMK_AppCompat).
1. Verify security settings. For more information, see [Deprecated features and behavior changes related to AD DS in Windows Server 2012](../../ad-ds/deploy/Upgrade-Domain-Controllers-to-Windows-Server-2012-R2-and-Windows-Server-2012.md#BKMK_DeprecatedFeatures) and [Secure default settings in Windows Server 2008 and Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee522994(v=ws.10)#BKMK_SecureDefault).
1. Check connectivity to the target server from the computer where you plan to run the installation.
1. Check for availability of necessary operation master roles:

   - To install the first DC that runs  Windows Server 2012  in an existing domain and forest, the machine where you run the installation needs connectivity to the schema master in order to run adprep /forestprep and the infrastructure master in order to run adprep /domainprep.
   - To install the first DC in a domain where the forest schema is already extended, you only need connectivity to infrastructure master.
   - To install or remove a domain in an existing forest, you need connectivity to the domain naming master.
   - Any domain controller installation also requires connectivity to the RID master.
   - If you're installing the first read-only domain controller in an existing forest, you need connectivity to the infrastructure master for each application directory partition, also known as a nondomain naming context or NDNC.

1. Be sure to supply the necessary credentials to run the AD DS installation.

   |Installation action|Credential requirements|
   |-----------------------|---------------------------|
   |Install a new forest|Local Administrator on the target server|
   |Install a new domain in an existing forest|Enterprise Admins|
   |Install an additional DC in an existing domain|Domain Admins|
   |Run adprep /forestprep|Schema Admins, Enterprise Admins, and Domain Admins|
   |Run adprep /domainprep|Domain Admins|
   |Run adprep /domainprep /gpprep|Domain Admins|
   |Run adprep /rodcprep|Enterprise Admins|

   You can delegate permissions to install AD DS. For more information, see [Installation Management Tasks](/previous-versions/windows/it-pro/windows-server-2003/cc773327(v=ws.10)).

Steps-by-step instructions to promote new and replica Windows Server 2012 domain controllers using Windows PowerShell cmdlets and Server Manager can be found in the following links:

- [Install Active Directory Domain Services (Level 100)](./install-active-directory-domain-services--level-100-.md)
- [Install a New Windows Server 2012 Active Directory Forest (Level 200)](./install-a-new-windows-server-2012-active-directory-forest--level-200-.md)
- [Install a Replica Windows Server 2012 Domain Controller in an Existing Domain (Level 200)](./install-a-replica-windows-server-2012-domain-controller-in-an-existing-domain--level-200-.md)
- [Install a New Windows Server 2012 Active Directory Child or Tree Domain (Level 200)](./install-a-new-windows-server-2012-active-directory-child-or-tree-domain--level-200-.md)
- [Install a Windows Server 2012 Active Directory Read-Only Domain Controller (RODC) (Level 200)](./rodc/install-a-windows-server-2012-active-directory-read-only-domain-controller--rodc---level-200-.md)
- [Windows Server 2012 forum about domain controllers](/answers/topics/windows-server-2012.html)

## Windows Update considerations

Prior to the release of Windows 8, Windows Update managed its own internal schedule to check for updates, and to download and install them. It required that the Windows Update Agent was always running in the background, consuming memory and other system resources.

Windows 8 and Windows Server 2012 introduce a new feature called [Automatic Maintenance](/windows/win32/w8cookbook/automatic-maintenance). Automatic Maintenance consolidates many different features that each used to manage its own scheduling and execution logic. This consolidation enables all these components to use far less system resources, work consistently, respect the new [Connected Standby](/windows/win32/w8cookbook/automatic-maintenance) state for new device types, and consume less battery on portable devices.

Because Windows Update is a part of Automatic Maintenance in Windows 8 and Windows Server 2012, its own internal schedule for setting a day and time to install updates is no longer effective. To help ensure consistent and predictable restart behavior for all devices and computers in your enterprise, including those that run Windows 8 and Windows Server 2012, see Microsoft KB article [2885694](https://support.microsoft.com/kb/2885694) (or see October 2013 cumulative rollup [2883201](https://support.microsoft.com/kb/2883201)). Then configure policy settings as described in the WSUS blog post [Enabling a more predictable Windows Update experience for Windows 8 and Windows Server 2012 (KB 2885694)](/archive/blogs/wsus/enabling-a-more-predictable-windows-update-experience-for-windows-8-and-windows-server-2012-kb-2885694).

## <a name="BKMK_NewWS2012R2"></a>What's new in AD DS in Windows Server 2012 R2?

The following table summarizes new features for AD DS in Windows Server 2012 R2, with a link to more detailed information where it's available. For a more detailed explanation of some features, including their requirements, see [What's New in Active Directory in Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn268294(v=ws.11)).

|Feature|Description|
|-----------|---------------|
|[Workplace Join](../../ad-fs/operations/join-to-workplace-from-any-device-for-sso-and-seamless-second-factor-authentication-across-company-applications.md)|Allows information workers to join their personal devices with their company to access company resources and services.|
|[Web Application Proxy](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn280942(v=ws.11))|Provides access to web application using a new Remote Access role service.|
|[Active Directory Federation Services](../../active-directory-federation-services.md)|AD FS has simplified deployment and improvements to enable users to access resources from personal devices and help IT departments manage access control.|
|[SPN and UPN uniqueness](../manage/component-updates/spn-and-upn-uniqueness.md)|Domain Controllers running Windows Server 2012 R2 block the creation of duplicate service principal names (SPNs) and user principal names (UPNs).|
|[Winlogon Automatic Restart Sign-On (ARSO)](../manage/component-updates/winlogon-automatic-restart-sign-on--arso-.md)|Enables lock screen applications to be restarted and available on Windows 8.1 devices.|
|[TPM Key Attestation](../manage/component-updates/tpm-key-attestation.md)|Enables CAs to cryptographically attest in an issued certificate that the certificate requester private key is actually protected by a Trusted Platform Module (TPM).|
|[Credentials Protection and Management](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn408190(v=ws.11))|New credential protection and domain authentication controls to reduce credential theft.|
|[Deprecation of File Replication Service (FRS)](../manage/component-updates/directory-services-component-updates.md)|The Windows Server 2003 domain functional level is also deprecated because at the functional level, FRS is used to replicate SYSVOL. That means when you create a new domain on a server that runs Windows Server 2012 R2, the domain functional level must be Windows Server 2008 or newer. You can still add a domain controller that runs Windows Server 2012 R2 to an existing domain that has a Windows Server 2003 domain functional level. You just can't create a new domain at that level.|
|[New domain and forest functional levels](../active-directory-functional-levels.md)|There are new functional levels for Windows Server 2012 R2. New features are available at Windows Server 2012 R2 DFL.|
|[LDAP query optimizer changes](../manage/component-updates/directory-services-component-updates.md)|Performance improvement in LDAP search efficiency and LDAP search time of complex queries.|
|[1644 Event improvements](../manage/component-updates/directory-services-component-updates.md)|LDAP search result statistics were added to event ID 1644 to aid in troubleshooting.|
|[Active Directory replication throughput improvement](../manage/component-updates/directory-services-component-updates.md)|Adjusts the maximum AD Replication throughput from 40Mbps to around 600 Mbps|

## <a name="BKMK_WhatsNewAD"></a>What's new in AD DS in Windows Server 2012?

The following table summarizes the new features for AD DS in Windows Server 2012, with a link to more detailed information where it is available. For a more detailed explanation of some features, including their requirements, see [What's New in Active Directory Domain Services (AD DS)](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831477(v=ws.11)).

|Feature|Description|
|-----------|---------------|
|Active Directory-Based Activation (AD BA) see [Volume Activation Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831612(v=ws.11))|Simplifies the task of configuring the distribution and management of volume software licenses.|
|[Active Directory Federation Services (AD FS)](../../active-directory-federation-services.md)|Adds role install via Server Manager, simplified trust-setup, automatic trust management, SAML-protocol support, and more.|
|Active Directory lost page flush events|NTDS ISAM event 530 with jet error -1119 is logged to detect lost page flush events to Active Directory databases.|
|[Active Directory Recycle Bin User Interface](../get-started/adac/introduction-to-active-directory-administrative-center-enhancements--level-100-.md#ad_recycle_bin_mgmt)|Active Directory Administrative Center (ADAC) adds GUI management of recycle bin feature originally introduced in Windows Server 2008 R2.|
|[Active Directory Replication and Topology Windows PowerShell cmdlets](../manage/powershell/introduction-to-active-directory-replication-and-topology-management-using-windows-powershell--level-100-.md)|Supports the creation and management of Active Directory sites, site-links, connection objects, and more using Windows PowerShell.|
|[Dynamic Access Control](../../solution-guides/dynamic-access-control--scenario-overview.md)|New claims-based authorization platform that enhances the legacy access control model.|
|[Fine-Grained Password Policy User Interface](../get-started/adac/introduction-to-active-directory-administrative-center-enhancements--level-100-.md#fine_grained_pswd_policy_mgmt)|ADAC adds GUI support for the creating, editing and assignment of PSOs originally added in Windows Server 2008.|
|[Group Managed Service Accounts (gMSA)](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831782(v=ws.11))|A new security principal type known as a gMSA. Services running on multiple hosts can run under the same gMSA account.|
|[DirectAccess Offline Domain Join](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj574150(v=ws.11))|Extends offline domain-join by including DirectAccess prerequisites.|
|[Rapid deployment via virtual domain controller (DC) cloning](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj574150(v=ws.11)#virtualized_dc_cloning)|Virtualized DCs can be rapidly deployed by cloning existing virtual domain controllers using Windows PowerShell cmdlets.|
|[RID pool changes](../manage/managing-rid-issuance.md)|Adds new monitoring events and quotas to safeguard against excessive consumption of the global RID pool. Optionally doubles the size of the global RID pool if the original pool becomes exhausted.|
|Secure Time service|Enhances security for W32tm by removing secrets from the wire, removing the MD5 hash functions and requiring the server to authenticate with Windows 8 time clients|
|[USN rollback protection for virtualized DCs](../manage/managing-rid-issuance.md)|Accidentally restoring snapshot backups of virtualized DCs no longer causes USN rollback.|
|[Windows PowerShell History Viewer](../get-started/adac/introduction-to-active-directory-administrative-center-enhancements--level-100-.md#windows_powershell_history_viewer)|Allow administrators to view the Windows PowerShell commands executed when using ADAC.|

### <a name="BKMK_"></a>Automatic Maintenance and changes to restart behavior after updates are applied by Windows Update

Prior to the release of Windows 8, Windows Update managed its own internal schedule to check for updates, and to download and install them. It required that the Windows Update Agent was always running in the background, consuming memory and other system resources.

Windows 8 and Windows Server 2012 introduce a new feature called [Automatic Maintenance](/windows/win32/w8cookbook/automatic-maintenance). Automatic Maintenance consolidates many different features that each used to manage its own scheduling and execution logic. This consolidation allows for all these components to use far less system resources, work consistently, respect the new [Connected Standby](/windows/win32/w8cookbook/automatic-maintenance) state for new device types, and consume less battery on portable devices.

Because Windows Update is a part of Automatic Maintenance in Windows 8 and Windows Server 2012, its own internal schedule for setting a day and time to install updates is no longer effective. To help ensure consistent and predictable restart behavior for all devices and computers in your enterprise, including those that run Windows 8 and Windows Server 2012, you can configure the following Group Policy settings:

- **Computer Configuration|Policies|Administrative Templates|Windows Components|Windows Update|Configure Automatic Updates**
- **Computer Configuration|Policies|Administrative Templates|Windows Components|Windows Update|No auto-restart with logged on users**
- **Computer Configuration|Policies|Administrative Templates|Windows Components|Maintenance Scheduler|Maintenance Random Delay**

The following table lists some examples of how to configure these settings to provide desired restart behavior.

|**Scenario**|**Recommended configuration(s)**|
|-|-|
|**WSUS managed**<p>-   Install updates once per week<br />-   Reboot Fridays at 11PM|Set machines to autoinstall, prevent autoreboot until desired time<p>**Policy**: Configure Automatic Updates (Enabled)<p>Configure automatic updating: 4 - Auto download and schedule the install<p>**Policy**: No autorestart with logged-on users (Disabled)<p>**WSUS deadlines**: set to Fridays at 11PM|
|**WSUS managed**<p>-   Stagger installs across different hours/days|Set target groups for different groups of machines that should be updated together<p>Use above steps for previous scenario<p>Set different deadlines for different target groups|
|**Not WSUS-managed - no support for deadlines**<p>-   Stagger installs at different times|**Policy**: Configure Automatic Updates (Enabled)<p>Configure automatic updating: 4 - Auto download and schedule the install<p>**Registry key:** Enable the registry key discussed in Microsoft KB article [2835627](https://support.microsoft.com/kb/2835627)<p>**Policy:** Automatic Maintenance Random Delay (Enabled)<p>Set **Regular maintenance random delay** to PT6H for 6-hour random delay to provide the following behavior:<p>-   Updates will install at the configured maintenance time plus a random delay<p>-   Restart for each machine will take place exactly 3 days later<p>Alternatively, set a different maintenance time for each group of machines|

For more information about why the Windows engineering team implemented these changes, see [How to reduce your chances of being prompted to restart your computer](/troubleshoot/windows-server/deployment/why-prompted-restart-computer#how-to-reduce-your-chances-of-being-prompted-to-restart-your-computer).

## <a name="BKMK_InstallationChanges"></a>AD DS server role installation changes

In Windows Server 2003 through Windows Server 2008 R2, you ran the x86 or X64 version of the Adprep.exe command-line tool before running the Active Directory Installation Wizard, Dcpromo.exe, and Dcpromo.exe had optional variants to install from media or for unattended installation.

Beginning in Windows Server 2012, command-line installations are performed by using the ADDSDeployment Module in Windows PowerShell. GUI-based promotions are performed in Server Manager using a completely new AD DS Configuration Wizard. To simplify the installation process, ADPREP has been integrated into the AD DS installation and runs automatically as needed. The Windows PowerShell-based AD DS Configuration Wizard automatically targets the schema and infrastructure master roles in the domains where DCs are being added, then remotely runs the required ADPREP commands on the relevant domain controllers.

Prerequisite checks in the AD DS Installation Wizard identify potential errors before the installation begins. Error conditions can be corrected to eliminate concerns from a partially complete upgrade. The wizard also exports a Windows PowerShell script that contains all the options that were specified during the graphical installation.

Taken together, the AD DS installation changes simplify the DC role installation process and reduce the likelihood of administrative errors, especially when you're deploying multiple domain controllers across global regions and domains.
More detailed information on GUI and Windows PowerShell-based installations, including command line syntax and step-by-step wizard instructions, see [Install Active Directory Domain Services](./install-active-directory-domain-services--level-100-.md). For administrators that want to control the introduction of schema changes in an Active Directory forest independent of the installation of Windows Server 2012 DCs in an existing forest, Adprep.exe commands can still be run at an elevated command prompt.

## <a name="BKMK_DeprecatedFeatures"></a>Deprecated features and behavior changes related to AD DS in Windows Server 2012

There are some changes related to AD DS:

- **Deprecation of Adprep32.exe**
   - There's only one version of Adprep.exe and it can be run as needed on 64-bit servers that run Windows Server 2008 or later. It can be run remotely, and must be run remotely if that targeted operations master role is hosted on a 32-bit operating system or Windows Server 2003.
- **Deprecation of Dcpromo.exe**
   - Dcpromo is deprecated although in  Windows Server 2012  only it can still be run with an answer file or command line parameters to give organizations time to transition existing automation to the new Windows PowerShell installation options.
- **LMHash is disabled on user accounts**
  - Secure defaults in Security templates on Windows Server 2008, Windows Server 2008 R2 and Windows Server 2012 enable the NoLMHash policy which is disabled in the security templates of Windows 2000 and Windows Server 2003 domain controllers. Disable the NoLMHash policy for LMHash-dependent clients as required, using the steps described in the page [How to prevent Windows from storing a LAN manager hash of your password in Active Directory and local SAM databases](/troubleshoot/windows-server/windows-security/prevent-windows-store-lm-hash-password).

Beginning with  Windows Server 2008 , domain controllers also have the following secure default settings, compared to domain controllers that run Windows Server 2003 or Windows 2000:

| Encryption type or policy | Windows Server 2008 default | Windows Server 2012 and Windows Server 2008 R2 default | Comment |
|--|--|--|--|
| AllowNT4Crypto | Disabled | Disabled | Third-party Server Message Block (SMB) clients may be incompatible with the secure default settings on domain controllers. In all cases, these settings can be relaxed to allow interoperability, but only at the expense of security. For more information, see [Disable the AllowNT4Crypto setting on all affected domain controllers](/services-hub/unified/health/remediation-steps-ad/disable-the-allownt4crypto-setting-on-all-affected-domain-controllers) in the Microsoft Knowledge Base (/services-hub/unified/health/remediation-steps-ad/disable-the-allownt4crypto-setting-on-all-affected-domain-controllers). |
| DES | Enabled | Disabled | [Article 977321](/troubleshoot/windows-server/windows-security/kdc-event-16-27-des-encryption-disabled) in the Microsoft Knowledge Base (https://go.microsoft.com/fwlink/?LinkId=177717) |
| CBT/Extended Protection for Integrated Authentication | N/A | Enabled | See [Microsoft Security Advisory (937811)](https://go.microsoft.com/fwlink/?LinkId=164559) (https://go.microsoft.com/fwlink/?LinkId=164559) and [article 976918](/troubleshoot/windows-server/windows-security/authentication-fails-non-windows-ntlm-kerberos-server) in the Microsoft Knowledge Base (https://go.microsoft.com/fwlink/?LinkId=178251).<p>Review and install the hotfix in [Install Service Packs and Hotfixes - Windows Client](/troubleshoot/windows-client/deployment/install-service-packs-hotfixes) (/troubleshoot/windows-client/deployment/install-service-packs-hotfixes) in the Microsoft Knowledge Base as required. |
| LMv2 | Enabled | Disabled | [Article 976918](/troubleshoot/windows-server/windows-security/authentication-fails-non-windows-ntlm-kerberos-server) in the Microsoft Knowledge Base (https://go.microsoft.com/fwlink/?LinkId=178251) |

## <a name="BKMK_SysReqs"></a>Operating system requirements

The minimum system requirements for  Windows Server 2012  are listed in the following table. For more information about system requirements and pre-installation information, see [Installing Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134246(v=ws.11)). There are no additional system requirements to install a new Active Directory forest, but you should add sufficient memory to cache the contents of Active Directory database in order to improve performance for domain controllers, LDAP client requests, and Active Directory-enabled applications. If you are upgrading an existing domain controller or adding a new domain controller to an existing forest, review the next section to ensure the server meets disk space requirements.

| Requirement | Value |
| ---------- | ----- |
| Processor | 1.4 Ghz 64-bit processor |
| RAM | 512 MB |
| Free disk space requirements | 32 GB |
| Screen resolution | 800 x 600 or higher |
| Miscellaneous | DVD drive, keyboard, Internet access |

### <a name="BKMK_DiskSpaceDCWin8"></a>Disk space requirements for upgrading domain controllers

This section covers disk space requirements only for upgrading domain controllers from  Windows Server 2008  or  Windows Server 2008 R2 . For more information about disk space requirements for upgrading domain controllers to earlier versions of Windows Server, see [Disk space requirements for upgrading to Windows Server 2008](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754463(v=ws.10)#BKMK_2008) or [Disk space requirements for upgrading to Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754463(v=ws.10)#BKMK_2008R2).

Size the disk that hosts the Active Directory database and log files in order to accommodate the custom and application-driven schema extensions, application and administrator-initiated indexes, plus space for the objects and attributes that you'll be added to the directory over deployment life of the domain controller (typically 5 to 8 years). Right sizing at deployment time is typically a good investment compared to greater touch costs required to expand disk storage after deployment. For more information, see [Capacity Planning for Active Directory Domain Services](../../../administration/performance-tuning/role/active-directory-server/capacity-planning-for-active-directory-domain-services.md).

On domain controllers that you plan to upgrade, make sure that the drive that hosts the Active Directory database (NTDS.DIT) has free disk space that represents at least 20% of the NTDS.DIT file before you begin the operating system upgrade. If there's insufficient free disk space on the volume, the upgrade can fail and the upgrade compatibility report returns an error indicating insufficient free disk space:

In this case, you can try an offline defragmentation of the Active Directory database to recapture additional space, and then retry the upgrade. For more information, see [Compact the Directory Database File (Offline Defragmentation)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc794920(v=ws.10)).

### Available SKUs

There are 4 editions of Windows Server: Foundation, Essentials, Standard and Datacenter.
The two editions that support the AD DS role are Standard and Datacenter.

In previous releases, Windows Server editions differed in their support of server roles, processor counts and large memory support. The Standard and Datacenter editions of Windows Server support all features and underlying hardware but vary in their virtualization rights - two virtual instances are allowed for Standard edition and unlimited virtual instances are allowed for Datacenter edition.

### Windows client and Windows Server operating systems that are supported to join Windows Server domains

The following Windows client and Windows Server operating systems are supported for domain member computers with domain controllers that run Windows Server 2012 or later:

- Server operating systems: Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008, Windows Server 2003 R2, Windows Server 2003

## <a name="BKMK_UpgradePaths"></a>Supported in-place upgrade paths

Domain controllers that run 64-bit versions of Windows Server 2008 or Windows Server 2008 R2 can be upgraded to  Windows Server 2012 . You can't upgrade domain controllers that run Windows Server 2003 or 32-bit versions of Windows Server 2008. To replace them, install domain controllers that run a later version of Windows Server in the domain, and then remove the domain controllers that Windows Server 2003.

| If you're running these editions | You can upgrade to these editions |
|--|--|
| Windows Server 2008 Standard with SP2<p>OR<p>Windows Server 2008 Enterprise with SP2 | Windows Server 2012 Standard<p>OR<p>Windows Server 2012 Datacenter |
| Windows Server 2008 Datacenter with SP2 | Windows Server 2012 Datacenter |
| Windows Web Server 2008 | Windows Server 2012 Standard |
| Windows Server 2008 R2 Standard with SP1<p>OR<p>Windows Server 2008 R2 Enterprise with SP1 | Windows Server 2012 Standard<p>OR<p>Windows Server 2012 Datacenter |
| Windows Server 2008 R2 Datacenter with SP1 | Windows Server 2012 Datacenter |
| Windows Web Server 2008 R2 | Windows Server 2012 Standard |

For more information about supported upgrade paths, see [Evaluation Versions and Upgrade Options for Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj574204(v=ws.11)). Note that you can't convert a domain controller that runs an evaluation version of Windows Server 2012 directly to a retail version. Instead, install an additional domain controller on a server that runs a retail version and remove AD DS from the domain controller that runs on the evaluation version.

Due to a known issue, you can't upgrade a domain controller that runs a Server Core installation of Windows Server 2008 R2 to a Server Core installation of  Windows Server 2012 . The upgrade will hang on a solid black screen late in the upgrade process. Rebooting such DCs exposes an option in boot.ini file to roll back to the previous operating system version. An additional reboot triggers the automatic rollback to the previous operating system version. Until a solution is available, it's recommended that you install a new domain controller running a Server Core installation of  Windows Server 2012  instead of in-place upgrading an existing domain controller that runs a Server Core installation of Windows Server 2008 R2. For more information, see KB article [2734222](/troubleshoot/developer/visualstudio/installation/installation-hangs-install-kb-update).

## <a name="BKMK_FunctionalLevels"></a>Functional level features and requirements

Windows Server 2012  requires a Windows Server 2003 forest functional level. That is, before you can add a domain controller that runs  Windows Server 2012  to an existing Active Directory forest, the forest functional level must be Windows Server 2003 or higher. This means that domain controllers that run Windows Server 2008 R2, Windows Server 2008, or Windows Server 2003 can operate in the same forest, but domain controllers that run Windows 2000 Server aren't supported and will block installation of a domain controller that runs Windows Server 2012. If the forest contains domain controllers running Windows Server 2003 or later but the forest functional level is still Windows 2000, the installation is also blocked.

Windows 2000 domain controllers must be removed prior to adding Windows Server 2012 domain controllers to your forest. In this case, consider the following workflow:

1. Install domain controllers that run Windows Server 2003 or later. These domain controllers can be deployed on an evaluation version of Windows Server. This step also requires [running adprep.exe](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd464018(v=ws.10)) for that operating system release as a prerequisite.
2. Remove the Windows 2000 domain controllers. Specifically, gracefully demote or forcibly remove Windows Server 2000 domain controllers from the domain and used Active Directory Users and Computers to remove the domain controller accounts for all removed domain controllers.
3. Raise the forest functional level to Windows Server 2003 or higher.
4. Install domain controllers that run Windows Server 2012.
5. Remove domain controllers that run earlier versions of Windows Server.

The new  Windows Server 2012  domain functional level enables one new feature: the **KDC support for claims, compound authentication, and Kerberos armoring** KDC administrative template policy has two settings (**Always provide claims** and **Fail unarmored authentication requests**) that require  Windows Server 2012  domain functional level.

The  Windows Server 2012  forest functional level doesn't provide any new features, but it ensures that any new domain created in the forest will automatically operate at the  Windows Server 2012  domain functional level. The  Windows Server 2012  domain functional level doesn't provide other new features beyond KDC support for claims, compound authentication, and Kerberos armoring. But it ensures that any domain controller in the domain runs  Windows Server 2012 . For more information about other features that are available at different functional levels, see [Understanding Active Directory Domain Services (AD DS) Functional Levels](../active-directory-functional-levels.md).

After you set the forest functional level to a certain value, you can't roll back or lower the forest functional level, with the following exceptions: after you raise the forest functional level to  Windows Server 2012 , you can lower it to  Windows Server 2008 R2 . If Active Directory Recycle Bin hasn't been enabled, you can also lower the forest functional level from  Windows Server 2012  to  Windows Server 2008 R2  or  Windows Server 2008  or from  Windows Server 2008 R2  back to  Windows Server 2008 . If the forest functional level is set to  Windows Server 2008 R2 , it can't be rolled back, for example, to Windows Server 2003.

After you set the domain functional level to a certain value, you can't roll back or lower the domain functional level, with the following exceptions: when you raise the domain functional level to  Windows Server 2008 R2  or  Windows Server 2012 , and if the forest functional level is  Windows Server 2008  or lower, you have the option of rolling the domain functional level back to  Windows Server 2008  or  Windows Server 2008 R2 . You can lower the domain functional level only from  Windows Server 2012  to  Windows Server 2008 R2  or  Windows Server 2008  or from  Windows Server 2008 R2  to  Windows Server 2008 . If the domain functional level is set to  Windows Server 2008 R2 , it can't be rolled back, for example, to Windows Server 2003.

For more information about features that are available at lower functional levels, see [Understanding Active Directory Domain Services (AD DS) Functional Levels](../active-directory-functional-levels.md).

Beyond functional levels, a domain controller that runs  Windows Server 2012  provides additional features that are not available on a domain controller that runs an earlier version of Windows Server. For example, a domain controller that runs  Windows Server 2012  can be used for virtual domain controller cloning, whereas a domain controller that runs an earlier version of Windows Server can't. But virtual domain controller cloning and virtual domain controller safeguards in  Windows Server 2012  don't have any functional level requirements.

> [!NOTE]
> Microsoft Exchange Server 2013 requires a forest functional level of Windows server 2003 or higher.

## <a name="BKMK_ServerRoles"></a>AD DS interoperability with other server roles and Windows operating systems

AD DS isn't supported on the following Windows operating systems:

- Windows MultiPoint Server
- Windows Server 2012 Essentials

AD DS can't be installed on a server that also runs the following server roles or role services:

- Hyper-V Server
- Remote Desktop Connection Broker

## <a name="BKMK_OpsMasters"></a>Operations master roles

Some new features in  Windows Server 2012  affect operations master roles:

- The PDC emulator must be running  Windows Server 2012  to support cloning virtual domain controllers. There are additional prerequisites for cloning DCs. For more information, see [Active Directory Domain Services (AD DS) Virtualization](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd464018(v=ws.10)).
- New security principals are created when the PDC emulator runs  Windows Server 2012 .
- The RID Master has new RID issuance and monitoring functionality. The improvements include better event logging, more appropriate limits, and the ability to - in an emergency - increase the overall RID pool allocation by one bit. For more information, see [Managing RID Issuance](../../ad-ds/manage/Managing-RID-Issuance.md).

> [!NOTE]
> Though they are not operations master roles, another change in AD DS installation is that DNS server role and the global catalog are installed by default on all domain controllers that run  Windows Server 2012 .

## <a name="BKMK_Virtual"></a>Virtualizing domain controllers

Improvements in AD DS beginning in  Windows Server 2012  enable safer virtualization of domain controllers and the ability to clone domain controllers. Cloning domain controllers in turn enables rapid deployment of additional domain controllers in a new domain and other benefits. For more information, see [Introduction to Active Directory Domain Services &#40;AD DS&#41; Virtualization &#40;Level 100&#41;](../../ad-ds/Introduction-to-Active-Directory-Domain-Services-AD-DS-Virtualization-Level-100.md).

## <a name="BKMK_Admin"></a>Administration of Windows Server 2012 servers

Use the [Remote Server Administration Tools for Windows 8](https://www.microsoft.com/download/details.aspx?id=28972) to manage domain controllers and other servers that run  Windows Server 2012 . You can run the  Windows Server 2012  Remote Server Administration Tools on a computer that runs Windows 8.

## <a name="BKMK_AppCompat"></a>Application compatibility

The following table covers common Active Directory-integrated Microsoft applications. The table covers what versions of Windows Server that the applications can be installed on and whether the introduction of Windows Server 2012 DCs affects application compatibility.

|Product|Notes|
|-----------|---------|
|[Microsoft SharePoint 2010](/lifecycle/products/microsoft-sharepoint-server-2010)|SharePoint 2010 Service Pack 2 is required to install and operate <br />SharePoint 2010 on Windows Server 2012 Servers<p>SharePoint 2010 Foundation Service Pack 2 is required to install and operate SharePoint 2010 Foundation on Windows Server 2012 Servers<p>The SharePoint Server 2010 (without service packs) installation process fails on Windows Server 2012<p>The SharePoint Server 2010 prerequisite installer (PrerequisiteInstaller.exe) fails with error "This program has compatibility issues." Clicking "Run the program without getting help" displays the error "Verifying if SharePoint can be installed &#124; SharePoint Server 2010 (without service packs) can't be installed on Windows Server 2012."|
|[Microsoft SharePoint 2013](/sharepoint/install/hardware-software-requirements-2013)|Minimum requirements for a database server in a farm<p>The 64-bit edition of Windows Server 2008 R2 Service Pack 1 (SP1) Standard, Enterprise, or Datacenter or the 64-bit edition of Windows Server 2012 Standard or Datacenter<p>Minimum requirements for a single server with built-in database:<p>The 64-bit edition of Windows Server 2008 R2 Service Pack 1 (SP1) Standard, Enterprise, or Datacenter or the 64-bit edition of Windows Server 2012 Standard or Datacenter<p>Minimum requirements for front-end web servers and application servers in a farm:<p>The 64-bit edition of Windows Server 2008 R2 Service Pack 1 (SP1) Standard, Enterprise, or Datacenter or the 64-bit edition of Windows Server 2012 Standard or Datacenter.|
|[Configuration Manager 2012](/sharepoint/install/hardware-software-requirements-2013)|Configuration Manager 2012 Service Pack 1:<p>Microsoft will add the following operating systems to our client support matrix with the release of Service Pack 1:<p>-   Windows 8 Pro<br />-   Windows 8 Enterprise<br />-   Windows Server 2012 Standard<br />-   Windows Server 2012 Datacenter<p>All site server roles - including site servers, SMS providers, and management points - can be deployed to servers with the following operating system editions:<p>-   Windows Server 2012 Standard<br />-   Windows Server 2012 Datacenter|
|[Microsoft Endpoint Configuration Manager (current branch)](/configmgr/core/plan-design/configs/supported-configurations)|[Supported operating systems for Configuration Manager site system servers](/configmgr/core/plan-design/configs/supported-operating-systems-for-site-system-servers).|
|[Microsoft Lync Server 2013](/lyncserver/lync-server-2013-server-and-tools-operating-system-support)|Lync Server 2013 requires with Windows Server 2008 R2 or Windows Server 2012. It can't be run on a Server Core installation. It can be run on [virtual servers](/lyncserver/lync-server-2013-running-lync-server-on-virtual-servers).|
|[Lync Server 2010](https://support.microsoft.com/kb/2777359)|Lync Server 2010 can be installed on a new (not upgraded) installation Windows Server 2012 if [October 2012 cumulative updates for Lync Server](https://support.microsoft.com/?kbid=2493736) are installed. Upgrading the operating system to Windows Server 2012 for an existing installation of Lync Server 2010 isn't supported. Microsoft Lync Server 2010 Group Chat Server is also not supported on Windows Server 2012.|
|[System Center 2012 Endpoint Protection](/sharepoint/install/hardware-software-requirements-2013)|System Center 2012 Endpoint Protection Service Pack 1 will update the client support matrix to include the following operating systems<p>-   Windows 8 Pro<br />-   Windows 8 Enterprise<br />-   Windows Server 2012 Standard<br />-   Windows Server 2012 Datacenter|
|[System Center 2012 Forefront Endpoint Protection](/sharepoint/install/hardware-software-requirements-2013)|FEP 2010 with Update Rollup 1 will update the client support matrix to include the following operating systems:<p>-   Windows 8 Pro<br />-   Windows 8 Enterprise<br />-   Windows Server 2012 Standard<br />-   Windows Server 2012 Datacenter|
|Forefront Threat Management Gateway (TMG)|TMG is supported to run only on Windows Server 2008 and Windows Server 2008 R2. For more information, see [System requirements for Forefront TMG](/previous-versions/tn-archive/dd896981(v=technet.10)).|
|Windows Server Update Services|This release of WSUS already supports Windows 8-based computers or Windows Server 2012-based computers as clients.|
|Windows Server Update Services 3.0|Update KB article [2734608](https://support.microsoft.com/kb/2734608) lets servers that are running Windows Server Update Services (WSUS) 3.0 SP2 provide updates to computers that are running Windows 8 or Windows Server 2012: **Note:** Customers with standalone WSUS 3.0 SP2 environments or Configuration Manager 2007 Service Pack 2 environments with WSUS 3.0 SP2 require [2734608](https://support.microsoft.com/kb/2734608) to properly manage Windows 8-based computers or Windows Server 2012-based computers as clients.|
|[Exchange 2013](/Exchange/plan-and-deploy/prerequisites)|Windows Server 2012 Standard and Datacenter are supported for the following roles: schema master, global catalog server, domain controller, mailbox and client access server role<p>Forest Functional Level: Windows Server 2003 or higher<p>Source: Exchange 2013 System Requirements|
|Exchange 2010|[Source: Exchange 2010 Service Pack 3](https://techcommunity.microsoft.com/t5/exchange-team-blog/bg-p/Exchange)<p>Exchange 2010 with Service Pack 3 can be installed on Windows Server 2012 member servers.<p>[Exchange 2010 System Requirements](/previous-versions/office/exchange-server-2010/aa996719(v=exchg.141)) lists the latest supported schema master, global catalog and domain controller as Windows Server 2008 R2.<p>Forest Functional Level: Windows Server 2003 or higher|
|SQL Server 2012|Source: KB [2681562](https://support.microsoft.com/kb/2681562)<p>SQL Server 2012 RTM is supported on Windows Server 2012.|
|SQL Server 2008 R2|Source: KB [2681562](https://support.microsoft.com/kb/2681562)<p>Requires SQL Server 2008 R2 with Service Pack 1 or later to install on Windows Server 2012.|
|SQL Server 2008|Source: KB [2681562](https://support.microsoft.com/kb/2681562)<p>Requires SQL Server 2008 with Service Pack 3 or later to install on Windows Server 2012.|
|SQL Server 2005|Source: KB [2681562](https://support.microsoft.com/kb/2681562)<p>Not supported to install on Windows Server 2012.|

## <a name="BKMK_KnownIssues"></a>Known issues

The following table lists known issues related to AD DS installation:

| KB article number and title | Technology area impacted | Issue/description |
|--|--|--|
| [2830145](https://support.microsoft.com/kb/2830145): SID S-1-18-1 and SID S-1-18-2 can't be mapped on Windows 7 or Windows Server 2008 R2-based computers in a domain environment | AD DS Management/App compat | Applications that map SID S-1-18-1 and SID S-1-18-2, which are new in Windows Server 2012, may fail because the SIDs can't be resolved on Windows 7-based or Windows Server 2008 R2-based computers. To resolve this issue, install the hotfix on the Windows 7-based and Windows Server 2008 R2-based computers in the domain. |
| [2737129](https://support.microsoft.com/kb/2737129): Group Policy preparation isn't performed when you automatically prepare an existing domain for Windows Server 2012 | AD DS Installation | Adprep /domainprep /gpprep isn't automatically run as part of installing the first DC that runs Windows Server 2012 in a domain. If it has never been run previously in the domain, it must be run manually. |
| [2737416](/windows-server/identity/ad-ds/deploy/upgrade-domain-controllers-to-windows-server-2012-r2-and-windows-server-2012): Windows PowerShell-based domain controller deployment repeats warnings | AD DS Installation | Warnings can appear during prerequisite validation and then reappear during the installation. |
| [2737424](/windows-server/identity/ad-ds/deploy/troubleshooting-domain-controller-deployment): "Format of the specified domain name is invalid" error when you try to remove Active Directory Domain Services from a domain controller | AD DS Installation | This error appears if you're removing the last DC in a domain where pre-created RODC accounts still exist. This affects Windows Server 2012, Windows Server 2008 R2, and Windows Server 2008. |
| [2737463](https://support.microsoft.com/kb/2737463): Domain controller doesn't start, c00002e2 error occurs, or "Choose an option" is displayed | AD DS Installation | A DC doesn't start because an administrator used Dism.exe, Pkgmgr.exe, or Ocsetup.exe to remove the DirectoryServices-DomainController role. |
| [2737535](/powershell/module/addsdeployment/install-addsdomaincontroller): Install-AddsDomainController cmdlet returns parameter set error for RODC | AD DS Installation | You can receive an error when you try to attach a server to an RODC account if you specify arguments that are already populated on the pre-created RODC account. |
| [2737560](/mem/configmgr/core/servers/deploy/install/list-of-prerequisite-checks): "Unable to perform Exchange schema conflict check" error, and prerequisites check fails | AD DS Installation | Prerequisite check fails when you configure the first Windows Server 2012 DC in an existing domain because DCs are missing the SeServiceLogonRight for Network Service or because WMI or DCOM protocols are blocked. |
| [2737797](/powershell/module/addsdeployment/): AddsDeployment module with the -Whatif argument shows incorrect DNS results | AD DS Installation | The -WhatIf parameter shows DNS server won't be installed but it will be. |
| [2737807](/biztalk/adapters-and-accelerators/accelerator-swift/step-3-configuring-the-domain-controller): The Next button isn't available on the Domain Controller Options page | AD DS Installation | The Next button is disabled on the Domain Controller Options page because the IP address of the target DC doesn't map to an existing subnet or site, or because the DSRM password isn't typed and confirmed correctly. |
| [2737935](https://support.microsoft.com/kb/2737935): Active Directory installation stalls at the "Creating the NTDS settings object" stage | AD DS Installation | The installation hangs because the local Administrator password matches the domain Administrator password, or because networking problems prevent critical replication from completing. |
| [2738060](/troubleshoot/windows-server/identity/access-denied-create-ntds-settings-object): "Access is denied" error message when you create a child domain remotely by using Install-AddsDomain | AD DS Installation | You receive the error when you run Install-ADDSDomain with the Invoke-Command cmdlet if the DNSDelegationCredential has a bad password. |
| [2738697](https://support.microsoft.com/kb/2738697): "The server isn't operational" domain controller configuration error when you configure a server by using Server Manager | AD DS Installation | You receive this error when you try to install AD DS on a workgroup computer because NTLM authentication is disabled. |
| [2738746](https://support.microsoft.com/kb/2738746): You receive access denied errors after you log on to a local administrator domain account | AD DS Installation | When you log on using a local Administrator account rather than the built-in Administrator account and then create a new domain, the account isn't added to the Domain Admins group. |
| [2743345](https://support.microsoft.com/kb/2743345): "The system can't find the file specified" Adprep /gpprep error, or tool crashes | AD DS Installation | You receive this error when you run adprep /gpprep because the infrastructure master is implements a disjoint namespace |
| [2753560](/troubleshoot/windows-server/identity/supplied-password-not-match-encryption-keys-password): ADMT 3.2 and PES 3.1 installation errors on Windows Server 2012 | ADMT | ADMT 3.2 can't be installed on Windows Server 2012 by design. |
| [2750857](https://support.microsoft.com/kb/2750857): DFS Replication diagnostic reports don't display correctly in Internet Explorer 10 | DFS Replication | DFS Replication diagnostic report doesn't display correctly because of changes in Internet Explorer 10. |
| [2741537](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj134201(v=ws.11)): Remote Group Policy updates are visible to users | Group Policy | This is due to scheduled tasks run in the context of each user who is logged on. The Windows Task Scheduler design requires an interactive prompt in this scenario. |
| [2741591](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj134176(v=ws.11)): ADM files aren't present in SYSVOL in the GPMC Infrastructure Status option | Group Policy | GP replication can report "replication in progress" because GPMC Infrastructure Status doesn't follow customized filtering rules. |
| [2737880](https://support.microsoft.com/kb/2737880): "The service can't be started" error during AD DS configuration | Virtual DC cloning | You receive this error while installing or removing AD DS, or cloning, because the DS Role Server service is disabled. |
| [2742836](/windows-server/identity/ad-ds/reference/virtual-dc/virtualized-domain-controller-cloning-test-guidance-for-application-vendors): Two DHCP leases are created for each domain controller when you use the VDC cloning feature | Virtual DC cloning | This happens because the cloned domain controller received a lease before cloning and again when cloning was complete. |
| [2742844](/troubleshoot/windows-server/identity/dcpromo-demotion-fails): Domain controller cloning fails and the server restarts in DSRM in Windows Server 2012 | Virtual DC cloning | The cloned DC starts in DSRM because cloning failed for any of a variety of reasons listed in the KB article. |
| [2742874](/windows-server/identity/ad-ds/reference/virtual-dc/virtualized-domain-controller-cloning-test-guidance-for-application-vendors): Domain controller cloning doesn't re-create all service principal names | Virtual DC cloning | Some three-part SPNs aren't recreated on the cloned DC because of a limitation of the domain rename process. |
| [2742908](https://support.microsoft.com/kb/2742908): "No logon servers are available" error after cloning domain controller | Virtual DC cloning | You receive this error when you try to log on after cloning a virtualized DC because cloning failed and the DC is started in DSRM. Log on as .\administrator to troubleshoot the cloning failure. |
| [2742916](/troubleshoot/windows-server/identity/dcpromo-demotion-fails): Domain controller cloning fails with error 8610 in dcpromo.log | Virtual DC cloning | Cloning fails because the PDC emulator hasn't performed inbound replication of the domain partition, likely because the role was transferred. |
| [2742927](/powershell/module/activedirectory/new-addccloneconfigfile): "Index was out of range" New-AdDcCloneConfig error | Virtual DC cloning | You receive the error after you run New-ADDCCloneConfigFile cmdlet while cloning virtual DCs, either because the cmdlet wasn't run from an elevated command prompt or because your access token doesn't contain the Administrators group. |
| [2742959](/troubleshoot/windows-server/identity/dcpromo-demotion-fails): Domain controller cloning fails with error 8437: "invalid parameter was specified for this replication operation" | Virtual DC cloning | Cloning failed because an invalid clone name or a duplicate NetBIOS name was specified. |
| [2742970](/troubleshoot/windows-server/identity/dcpromo-demotion-fails): DC Cloning fails with no DSRM, duplicate source and clone computer | Virtual DC cloning | The cloned virtual DC boots in Directory Services Repair Mode (DSRM), using a duplicate name as the source DC because the DCCloneConfig.xml file wasn't created in the correct location or because the source DC was rebooted before cloning. |
| [2743278](/troubleshoot/windows-server/identity/fail-to-configure-server-using-server-manager): Domain controller cloning error 0x80041005 | Virtual DC cloning | The cloned DC boots into DSRM because only one WINS server was specified. If any WINS server is specified, both Preferred and Alternate WINS servers must be specified. |
| [2745013](/troubleshoot/windows-server/identity/fail-to-configure-server-using-server-manager): "Server is not operational" error message if you run New-AdDcCloneConfigFile in Windows Server 2012 | Virtual DC cloning | You receive this error after you run the New-ADDCCloneConfigFile cmdlet because the server can't contact a global catalog server. |
| [2747974](/windows-server/identity/ad-ds/manage/virtual-dc/virtualized-domain-controller-troubleshooting): Domain controller cloning event 2224 provides incorrect guidance | Virtual DC cloning | Event ID 2224 incorrectly states that managed service accounts must be removed before cloning. Standalone MSAs must be removed but Group MSAs don't block cloning. |
| [2748266](/windows/security/information-protection/bitlocker/bitlocker-recovery-guide-plan): You can't unlock a BitLocker-encrypted drive after you upgrade to Windows 8 | BitLocker | You receive an "Application not found" error when you try to unlock a drive on a computer that was upgraded from Windows 7. |

## See Also

[Windows Server 2012 Evaluation Resources](https://www.microsoft.com/en-us/evalcenter/)
[Windows Server 2012 Evaluation Guide](https://download.microsoft.com/download/5/B/2/5B254183-FA53-4317-B577-7561058CEF42/WS%202012%20Evaluation%20Guide.pdf)
[Install and Deploy Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831620(v=ws.11))
