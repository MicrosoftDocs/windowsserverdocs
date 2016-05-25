---
title: BitLocker Overview
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c0aab4fa-411c-4151-b694-09e2f72374f0
---
# BitLocker Overview
This topic provides a high\-level overview of BitLocker including a list of new and changed features, system requirements, practical applications, and deprecated features. It provides links to additional content that will help you to learn more about working with BitLocker.  
  
**Did you mean…**  
  
-   [AppLocker](http://go.microsoft.com/fwlink/p/?LinkId=243126)  
  
-   [EFS](http://go.microsoft.com/fwlink/p/?LinkId=243130)  
  
-   [BitLocker Drive Encryption Provider](http://go.microsoft.com/fwlink/p/?LinkId=243131)  
  
## <a name="BKMK_OVER"></a>Feature description  
BitLocker Drive Encryption is a data protection feature of the operating system that was first made available in Windows Vista. Subsequent operating system releases have continued to improve the security offered by BitLocker to allow the operating system to provide BitLocker protection to more drives and devices. Having BitLocker integrated with the operating system addresses the threats of data theft or exposure from lost, stolen, or inappropriately decommissioned computers. Manage\-bde is the command\-line tool that can also be used to perform tasks on the computer related to BitLocker. When installing the BitLocker optional component on a server you will also need to install the Enhanced Storage feature, which is used to support hardware encrypted drives. On servers, an additional BitLocker feature that can be installed is BitLocker Network Unlock. Computers running [!INCLUDE[winrt_2](../Token/winrt_2_md.md)], [!INCLUDE[winblue_winrt_2](../Token/winblue_winrt_2_md.md)], or [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] can be protected by using Device Encryption, which is a customized version of BitLocker.  
  
BitLocker provides the most protection when used with a Trusted Platform Module \(TPM\) version 1.2 or later. The TPM is a hardware component installed in many newer computers by the computer manufacturers. It works with BitLocker to help protect user data and to ensure that a computer has not been tampered with while the system was offline.  
  
On computers that do not have a TPM version 1.2 or later, you can still use BitLocker to encrypt the Windows operating system drive. However, this implementation will require the user to insert a USB startup key to start the computer or resume from hibernation. In [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] using an operating system volume password is another option to protect the operating system volume on a computer without TPM. Both options do not provide the pre\-startup system integrity verification offered by BitLocker with a TPM.  
  
In addition to the TPM, BitLocker offers the option to lock the normal startup process until the user supplies a personal identification number \(PIN\) or inserts a removable device, such as a USB flash drive, that contains a startup key. These additional security measures provide multifactor authentication and assurance that the computer will not start or resume from hibernation until the correct PIN or startup key is presented.  
  
## <a name="BKMK_APP"></a>Practical applications  
Data on a lost or stolen computer is vulnerable to unauthorized access, either by running a software\-attack tool against it or by transferring the computer's hard disk to a different computer. BitLocker helps mitigate unauthorized data access by enhancing file and system protections. BitLocker also helps render data inaccessible when BitLocker\-protected computers are decommissioned or recycled.  
  
There are two additional tools in the Remote Server Administration Tools, which you can use to manage BitLocker.  
  
-   **BitLocker Recovery Password Viewer**. The BitLocker Recovery Password Viewer enables you to locate and view BitLocker Drive Encryption recovery passwords that have been backed up to Active Directory Domain Services \(AD DS\). You can use this tool to help recover data that is stored on a drive that has been encrypted by using BitLocker. The BitLocker Recovery Password Viewer tool is an extension for the Active Directory Users and Computers Microsoft Management Console \(MMC\) snap\-in.  
  
    By using this tool, you can examine a computer object's **Properties** dialog box to view the corresponding BitLocker recovery passwords. Additionally, you can right\-click a domain container and then search for a BitLocker recovery password across all the domains in the Active Directory forest. To view recovery passwords, you must be a domain administrator, or you must have been delegated permissions by a domain administrator.  
  
-   **BitLocker Drive Encryption Tools**. BitLocker Drive Encryption Tools include the command\-line tools manage\-bde and repair\-bde and the BitLocker cmdlets for Windows PowerShell. Both manage\-bde and the BitLocker cmdlets can be used to perform any task that can be accomplished through the BitLocker control panel, and they are appropriate to use for automated deployments and other scripting scenarios. Repair\-bde is provided for disaster recovery scenarios in which a BitLocker protected drive cannot be unlocked normally or by using the recovery console.  
  
## <a name="BKMK_NEW"></a>New and changed functionality  
The following table identifies the new and changed functionality for BitLocker in [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. Check out [What's New in BitLocker](../Topic/What-s-New-in-BitLocker.md).  
  
|Feature\/functionality|Windows 7|[!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|  
|--------------------------|-------------|-----------------------------------------------------------------------------------------------------------------------|  
|Reset the BitLocker PIN or password|Administrator privileges are required to reset the BitLocker PIN on an operating system drive and the password on a fixed or removable data drive.|Standard users can reset the BitLocker PIN and password on operating system drives, fixed data drives, and removable data drives.|  
|Disk encryption|The entire disk is encrypted when BitLocker is enabled.|You can choose to encrypt the entire disk or just the used space on the disk when BitLocker is enabled. As disk space is consumed the disk will be encrypted.|  
|Hardware Encrypted Drive support|Not natively supported by BitLocker.|BitLocker can support hard drives with the Windows logo that come pre\-encrypted from the manufacturer.|  
|Unlocking using a network based key to provide dual\-factor authentication|Not available. Physical presence at the computer was required to have dual\-factor authentication.|A new type of key protector allows for a special network key to be used to unlock and skip the PIN entry prompt in situations where computers are rebooted on trusted wired networks. This allows for remote maintenance on computers that are protected by using a PIN during non\-work hours, and it provides dual\-factor authentication without requiring physical presence at the computer, while still ensuring user authentication is required when the computer is not connected to the trusted network.|  
|Protection for clusters|Not available.|Windows Server 2012 includes BitLocker support for Windows Cluster Shared Volumes and Windows Failover Clusters that are running in domain established by a Windows Server 2012 domain controller that has enabled the Kerberos Key Distribution Center Service.|  
|Linking a BitLocker key protector to an Active Directory account|Not available.|Allows a BitLocker key protector to be tied to a user, group, or computer account in Active Directory. That key protector can be used to unlock BitLocker protected data volumes when a user is signed in with the correct credentials or signed on to a computer with the correct credentials.|  
  
## <a name="BKMK_DEP"></a>Removed or deprecated functionality  
The Diffuser option is no longer available to be added to the Advanced Encryption Standard \(AES\) encryption algorithm.  
  
The "Configure TPM validation profile" Group Policy setting is deprecated in [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  It has been replaced with system specific policies for BIOS\-based and UEFI\-based computers.  
  
The **–tpm** option is no longer supported by manage\-bde.  
  
## System requirements  
BitLocker has the following hardware requirements:  
  
For BitLocker to use the system integrity check provided by a Trusted Platform Module \(TPM\), the computer must have TPM 1.2 or TPM 2.0. If your computer does not have a TPM, enabling BitLocker requires that you save a startup key on a removable device, such as a USB flash drive.  
  
A computer with a TPM must also have a Trusted Computing Group \(TCG\)\-compliant BIOS or UEFI firmware. The BIOS or UEFI firmware establishes a chain of trust for the pre\-operating system startup, and it must include support for TCG\-specified Static Root of Trust Measurement. A computer without a TPM does not require TCG\-compliant firmware.  
  
The system BIOS or UEFI firmware \(for TPM and non\-TPM computers\) must support the USB mass storage device class, including reading small files on a USB flash drive in the pre\-operating system environment. For more information about USB, see the USB Mass Storage Bulk\-Only and the Mass Storage UFI Command specifications on the [USB Web site](http://go.microsoft.com/fwlink/p/?LinkId=83120).  
  
The hard disk must be partitioned with at least two drives:  
  
-   The operating system drive \(or boot drive\) contains the operating system and its support files. It must be formatted with the NTFS file system.  
  
-   The system drive contains the files that are needed to load Windows after the firmware has prepared the system hardware. BitLocker is not enabled on this drive. For BitLocker to work, the system drive must not be encrypted, must differ from the operating system drive, and must be formatted with the FAT32 file system on computers that use UEFI\-based firmware or with the NTFS file system on computers that use BIOS firmware. We recommend that system drive be approximately 350 MB in size. After BitLocker is turned on it should have approximately 250 MB of free space.  
  
When installed on a new computer, Windows will automatically create the partitions that are required for BitLocker.  
  
## <a name="BKMK_LINKS"></a>In this library  
  
-   [What's New in BitLocker](../Topic/What-s-New-in-BitLocker.md)  
  
-   [What's New in BitLocker for Windows 8 and Windows Server 2012 \[redirected\]](assetId:///2a2af536-3d99-4d86-a492-2a663dc60b4a)  
  
-   [BitLocker Frequently Asked Questions &#40;FAQ&#41;](../Topic/BitLocker-Frequently-Asked-Questions--FAQ-.md)  
  
-   [BitLocker Basic Deployment](../Topic/BitLocker-Basic-Deployment.md)  
  
-   [BitLocker: How to deploy on Windows Server 2012](../Topic/BitLocker--How-to-deploy-on-Windows-Server-2012.md)  
  
-   [BitLocker: How to enable network unlock](assetId:///a7929b61-ce42-4aa4-8600-5fc581a8dddf)  
  
-   [BitLocker: Use BitLocker Drive Encryption Tools to manage BitLocker](../Topic/BitLocker--Use-BitLocker-Drive-Encryption-Tools-to-manage-BitLocker.md)  
  
-   [BitLocker: Use BitLocker Recovery Password Viewer](../Topic/BitLocker--Use-BitLocker-Recovery-Password-Viewer.md)  
  
-   [BitLocker Group Policy settings](assetId:///688b39ad-876b-40e3-a1f6-b506bb42ac17)  
  
-   [BCD Settings and BitLocker](assetId:///8266c027-85ab-488a-8caf-b7a4e408a0ec)  
  
-   [BitLocker Recovery Guide](../Topic/BitLocker-Recovery-Guide.md)  
  
-   [Protecting cluster shared volumes and storage area networks with BitLocker](../Topic/Protecting-cluster-shared-volumes-and-storage-area-networks-with-BitLocker.md)  
  
## See also  
  
-   [Prepare your organization for BitLocker: Planning and Policies](assetId:///94c445de-a32c-44d8-b520-1ec2e507f2f6)  
  
-   [Protect BitLocker from Pre\-Boot Attacks](assetId:///b47afad6-8b51-43a1-a1d1-611d88c3ae82)  
  
-   [Encrypted Hard Drive](../Topic/Encrypted-Hard-Drive.md)  
  
-   [BitLocker Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/jj649829.aspx)  
  
-   [TechNet Wiki Articles](http://social.technet.microsoft.com/wiki/contents/articles/tags/BitLocker+Drive+Encryption/default.aspx)  
  
-   [Security and Protection](../Topic/Security-and-Protection.md)  
  
-   [Server Roles and Technologies in Windows Server 2012 R2 and Windows Server 2012](assetId:///9dc8aceb-175c-469e-8b58-afd097cb8006)  
  
