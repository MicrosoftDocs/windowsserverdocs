---
title: Trusted Platform Module Technology Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1d593278-ab8b-4d29-89d6-ef3ccb45eb55
---
# Trusted Platform Module Technology Overview
This topic for the IT professional describes the Trusted Platform Module \(TPM\) and how Windows uses it for access control and authentication. The topic provides links to other resources about the TPM.  
  
## <a name="BKMK_OVER"></a>Feature description  
Trusted Platform Module \(TPM\) technology is designed to provide hardware\-based, security\-related functions. A TPM chip is a secure crypto\-processor that is designed to carry out cryptographic operations. The chip includes multiple physical security mechanisms to make it tamper resistant, and malicious software is unable to tamper with the security functions of the TPM. Some of the key advantages of using TPM technology are that you can:  
  
-   Generate, store, and limit the use of cryptographic keys.  
  
-   Use TPM technology for platform device authentication by using the TPM’s unique RSA key, which is burned into itself.  
  
-   Help ensure platform integrity by taking and storing security measurements.  
  
The most common TPM functions are used for system integrity measurements and for key creation and use. During the boot process of a system, the boot code that is loaded \(including firmware and the operating system components\) can be measured and recorded in the TPM. The integrity measurements can be used as evidence for how a system started and to make sure that a TPM\-based key was used only when the correct software was used to boot the system.  
  
TPM\-based keys can be configured in a variety of ways. One option is to make a TPM\-based key unavailable outside the TPM. This is good to mitigate phishing attacks because it prevents the key from being copied and used without the TPM. TPM\-based keys can also be configured to require an authorization value to use them. If too many incorrect authorization guesses occur, the TPM will activate its dictionary attack logic and prevent further authorization value guesses.  
  
Different versions of the TPM are defined in specifications by the Trusted Computing Group \(TCG\). For more information, consult the TCG Web site \([http:\/\/www.trustedcomputinggroup.org\/developers\/trusted\_platform\_module](http://www.trustedcomputinggroup.org/developers/trusted_platform_module)\).  
  
The [supported versions](#BKMK_SupportedVersions) of the Windows operating system can automatically provision and manage the TPM. Group Policy settings can be configured to control whether the TPM owner authorization value is backed up in Active Directory. Because the TPM state persists across operating system installations, TPM information is stored in a location in Active Directory that is separate from computer objects. Depending on an enterprise’s security goals, Group Policy can be configured to allow or prevent local administrators from resetting the TPM’s dictionary attack logic. Standard users can use the TPM, but Group Policy controls limit how many authorization failures standard users can attempt so that one user is unable to prevent other users or the administrator from using the TPM. TPM technology can also be used as a virtual smart card and for secure certificate storage. With BitLocker Network Unlock, domain\-joined computers are not prompted for a BitLocker PIN.  
  
## <a name="BKMK_APP"></a>Practical applications  
Certificates can be installed or created on computers that are using the TPM. After a computer is provisioned, the RSA private key for a certificate is bound to the TPM and cannot be exported. The TPM can also be used as a replacement for smart cards, which reduces the costs associated with creating and disbursing smart cards.  
  
Automated provisioning in the TPM reduces the cost of TPM deployment in an enterprise. New APIs for TPM management can determine if TPM provisioning actions require physical presence of a service technician to approve TPM state change requests during the boot process.  
  
Antimalware software can use the boot measurements of the operating system start state to prove the integrity of a computer running [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)][!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. These measurements include the launch of Hyper\-V to test that datacenters using virtualization are not running untrusted hypervisors. With BitLocker Network Unlock, IT administrators can push an update without concerns that a computer is waiting for PIN entry.  
  
The TPM has several Group Policy settings that can be used to manage how it is used. These settings can be used to manage the owner authorization value, the blocked TPM commands, the standard user lockout, and the backup of the TPM to AD DS. For additional details, see [Trusted Platform Module Services Group Policy Settings](assetId:///58a88c36-df44-45d9-953f-a0bef9e7ae40).  
  
## <a name="BKMK_NEW"></a>New and changed functionality  
For information about new and changed functionality in the TPM for [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], see [What's New for the TPM in Windows 8.1](assetId:///c06b976c-0d22-4e3f-85d3-7d497200c8dc).  
  
The following sections describe the new and changed functionalities in the TPM for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]:  
  
-   [Automated provisioning and management of the TPM](#BKMK_AutoProv)  
  
-   [Measured Boot with support for attestation](#BKMK_MeasuredBoot)  
  
-   [TPM\-based Virtual Smart Card](#BKMK_VSC)  
  
-   [TPM Owner Authorization Value](#BKMK_AuthValue)  
  
-   [TPM Cmdlets](#BKMK_TPMcmdlets)  
  
### <a name="BKMK_AutoProv"></a>Automated provisioning and management of the TPM  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] deliver a number of enhancements that streamline TPM provisioning, making it easier to deploy systems that are ready for BitLocker and other TPM\-dependent features. These enhancements include simplifying the TPM state model to report **Ready**, **Ready with reduced functionality**, or **Not ready**. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] also include automatic provisioning of TPMs in the **Ready** state, remote provisioning to remove the requirement for the physical presence of a technician for the initial deployment. In addition, the TPM stack is available in the Windows Preinstallation Environment \(Windows PE\).  
  
A number of management settings have been added for easier management and configuration of the TPM through Group Policy. The primary new settings include Active Directory\-based backup of TPM owner authentication, the level of owner authentication that should be stored locally on the TPM, and the software\-based TPM lockout settings for standard users. For more information about backing up owner authentication to Windows Server 2008 R2 AD DS domains, see [Schema Extensions for Windows Server 2008 R2 to support AD DS backup of TPM information from Windows 8 clients](../Topic/Schema-Extensions-for-Windows-Server-2008-R2-to-support-AD-DS-backup-of-TPM-information-from-Windows-8-clients.md)  
  
### <a name="BKMK_MeasuredBoot"></a>Measured Boot with support for attestation  
The Measured Boot feature provides antimalware software with a trusted \(resistant to spoofing and tampering\) log of all boot components. Antimalware software can use the log to determine whether components that ran before it are trustworthy versus infected with malware. It can also send the Measured Boot logs to a remote server for evaluation. The remote server can initiate remediation actions by interacting with software on the client or through out\-of\-band mechanisms, as appropriate.  
  
### <a name="BKMK_VSC"></a>TPM\-based Virtual Smart Card  
The Virtual Smart Card emulates the functionality of traditional smart cards, but Virtual Smart Cards use the TPM chip that is available on an organization’s computers, rather than requiring the use of a separate physical smart card and reader. This greatly reduces the management and deployment cost of smart cards in an enterprise. To the end user, the Virtual Smart Card is always available on the computer. If a user needs to use more than one computer, a Virtual Smart Card must be issued to the user for each computer. A computer that is shared among multiple users can host multiple Virtual Smart Cards, one for each user.  
  
For more information, see [Virtual Smart Card Overview](assetId:///eaf01ad1-2b9d-4c26-a0ff-5199bbcd1e8a).  
  
### TPM\-based certificate storage  
The TPM can be used to protect certificates and RSA keys. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes a new key storage provider \(KSP\), which provides easy, convenient use of the TPM as a way of strongly protecting private keys. The TPM KSP can be used to generate keys when an organization enrolls for certificates, and the KSP is managed by templates in the UI. The TPM can also be used to protect certificates that are imported from an outside source. TPM\-based certificates can be used exactly as standard certificates with the added functionality that the certificate can never leave the TPM from which the keys were generated. The TPM can now be used for crypto\-operations through Cryptography API: Next Generation \(CNG\). For more information, see [Cryptography API: Next Generation](http://msdn.microsoft.com/library/windows/desktop/aa376210(v=vs.85).aspx).  
  
### <a name="BKMK_AuthValue"></a>TPM Owner Authorization Value  
For Windows 8 a change to how the TPM owner authorization value is stored in AD DS was implemented in the AD DS schema. The TPM owner authorization value is now stored in a separate object which is linked to the Computer object. This value was stored as a property in the Computer object itself for the default Windows Server 2008 R2 schemas. Windows Server 2012 domain controllers have the default schema to backup TPM owner authorization information in the separate object. If you are not upgrading your domain controller to Windows Server 2012 you need to extend the schema to support this change. If Active Directory backup of the TPM owner authorization value is enabled in a Windows Server 2008 R2 environment without extending the schema, the TPM provisioning will fail and the TPM will remain in a Not Ready state for computers running Windows 8.  
  
If your computer is not being joined to a domain the TPM owner authorization value will be stored in the local computer registry. Using BitLocker to encrypt the operating system drive will protect the owner authorization value from being disclosed when the computer is at rest, but there is a risk that a malicious user could obtain the TPM owner authorization value when the computer is unlocked. Therefore, we recommend that in this situation you configure your computer to automatically lock after 30 seconds of inactivity. If automatic locking is not used, then you should consider removing full owner authorization from the computer registry.  
  
**Registry information**  
  
Registry key: HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Policies\\Microsoft\\TPM  
  
DWORD: OSManagedAuthLevel  
  
|Value Data|Setting|  
|--------------|-----------|  
|0|None|  
|2|Delegated|  
|4|Full|  
  
> [!NOTE]  
> If the operating system managed TPM authentication setting is changed from "Full" to "Delegated" the full TPM owner authorization value will be regenerated and any copies of the original TPM owner authorization value will be invalid. If you are backing up the TPM owner authorization value to AD DS, the new owner authorization value will be automatically backed up to AD DS when it is changed.  
  
### <a name="BKMK_TPMcmdlets"></a>TPM Cmdlets  
If you are using PowerShell to script and manage your computers, you can now manage the TPM using Windows PowerShell as well. To install the TPM cmdlets use the following command:  
  
**dism \/online \/enable\-feature \/FeatureName:tpm\-psh\-cmdlets**  
  
For details about the individual cmdlets, see [TPM Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/jj603116.aspx)  
  
## <a name="BKMK_SupportedVersions"></a>Supported versions  
  
|TPM version|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] and [!INCLUDE[winrt_2](../Token/winrt_2_md.md)]|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[winrt_2](../Token/winrt_2_md.md)]|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)]|  
|---------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------|  
|TPM 1.2|X|X|X|  
|TPM 2.0|X|X||  
  
## <a name="BKMK_AdditionalResources"></a>Additional Resources  
[TPM Fundamentals \[Windows 8\]](assetId:///ff2bb100-f5c8-4270-a069-603c18df132f)  
  
[How the TPM mitigates dictionary attacks](assetId:///d4645593-0d4b-42ca-b599-0907809070b9)  
  
[Trusted Platform Module Services Group Policy Settings](assetId:///58a88c36-df44-45d9-953f-a0bef9e7ae40)  
  
[TPM Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/jj603116.aspx)  
  
[Schema Extensions for Windows Server 2008 R2 to support AD DS backup of TPM information from Windows 8 clients](http://technet.microsoft.com/en-us/library/jj635854.aspx)  
  
[Prepare your organization for BitLocker: Planning and Policies \- TPM configurations](http://technet.microsoft.com/library/jj592683.aspx)  
  
[What's New in Smart Cards](http://technet.microsoft.com/library/hh849637.aspx)  
  
