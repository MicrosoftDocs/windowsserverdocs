---
title: Known Issues for Installing and Removing AD DS
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 6c438941-f9b5-4edb-a9ee-1781526389e5
author: Femila
---
# Known Issues for Installing and Removing AD DS
  Review the following known issues before you install Active Directory Domain Services \(AD DS\):  
  
-   [Adprep.exe issues](../Topic/Known-Issues-for-Installing-and-Removing-AD-DS.md#BKMK_Adprep)  
  
-   [Active Directory Domain Services Installation Wizard (Dcpromo.exe) issues](../Topic/Known-Issues-for-Installing-and-Removing-AD-DS.md#BKMK_Dcpromo)  
  
-   [Disk space and component location issues](../Topic/Known-Issues-for-Installing-and-Removing-AD-DS.md#BKMK_Space)  
  
-   [Other AD DS server role issues](../Topic/Known-Issues-for-Installing-and-Removing-AD-DS.md#BKMK_Other)  
  
-   [Changes to performance counters](../Topic/Known-Issues-for-Installing-and-Removing-AD-DS.md#BKMK_Perf)  
  
##  <a name="BKMK_Adprep"></a> Adprep.exe issues  
  
-   The location for Adprep.exe is different in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. You must run Adprep.exe before you can add a domain controller that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to an existing Windows 2000 Server or Windows Server 2003 Active Directory environment. In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Adprep.exe is located in the \/Sources\/adprep folder of the operating system installation disk. In [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], Adprep.exe is located in the \/Support\/adprep folder. [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] includes a 32\-bit and 64\-bit version of Adprep.exe. The 64\-bit version runs by default. If you want to run one of the Adprep.exe commands on a 32\-bit computer, you must use the 32\-bit version of Adprep.exe.  
  
-   The **adprep \/rodcprep** command can log an error if the infrastructure operations master for an application directory partition is not available when you run the command. The error indicates the name of the application directory partition whose infrastructure operations master role is not available. For more information about how to fix this issue, see article 949257 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=114419](http://go.microsoft.com/fwlink/?LinkId=114419)\). This issue affects the **adprep \/rodcprep** command in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. However, if you have already run the **adprep \/rodcprep** command for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you do not have to run it again for [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
-   If you have not run the **adprep \/rodcprep** command, Dcdiag.exe returns an error when it runs the NCSecDesc test. This test checks that the security descriptors on the naming context heads have appropriate permissions for replication. The error indicates that the Enterprise Domain Controllers group does not have Replicating Directory Changes In Filtered Set access rights for the DNS application directory partitions. If you do not plan to add an RODC to the forest, you can disregard this error. If you plan to add an RODC to the forest, you must run **adprep \/rodcprep**. For **adprep \/rodcprep**, you can run the version of Adprep.exe that appears in either [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] because that parameter performs the same set of operations in each version. For more information about running **adprep \/rodcprep**, see [Prepare a Forest for a Read-Only Domain Controller](../Topic/Prepare-a-Forest-for-a-Read-Only-Domain-Controller.md).  
  
-   When you run **adprep \/forestprep** for [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], Windows 2000 domain controllers that are configured as global catalog servers perform a full synchronization of their partial domain replicas. This occurs because the **\/forestprep** operation modifies the global catalog's partial attribute set \(PAS\). A reduction in the performance of Windows 2000 domain controllers is possible during the rebuild process. This is expected behavior for Windows 2000 domain controllers only; later versions of Windows Server add the additional attributes incrementally. To avoid the full synchronization, upgrade the Windows 2000 domain controllers to Windows Server 2003. Demoting the Windows 2000 domain controllers is also possible, but this action requires sufficient planning to ensure that no service outages are experienced.  
  
-   If you run Adprep.exe or Adprep32.exe on a non\-English version of Windows, the status and progress information does not appear.  
  
##  <a name="BKMK_Dcpromo"></a> Active Directory Domain Services Installation Wizard \(Dcpromo.exe\) issues  
  
-   When you install a new [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller with DNS server into a domain such as treyresearch5.net, you might encounter the following error:  
  
     A delegation for this DNS server cannot be created because the authoritative parent zone cannot be found or it does not run Windows DNS server. If you are integrating with an existing DNS infrastructure, you should manually create a delegation to this DNS server in the parent zone to ensure reliable name resolution from outside the domain “treyresearch5.net”. Otherwise, no action is required.  
  
     ![](../Image/ADDS_CannotCreateDelegationRecordss.gif)  
  
     If you are not concerned that people in other domains or on the Internet will not resolve DNS name queries for computer names in the local domain, you can disregard the message and click **Yes**.  
  
     The error occurs when:  
  
    -   The Active Directory Domain Services Installation Wizard \(Dcpromo.exe\) has been configured to install the DNS server role.  
  
         \-and\-  
  
         Enough delegations do not already exist between DNS servers in the immediate parent DNS zone and the subdomain where you are installing the new domain controller.  
  
         \-and\-  
  
         The domain controller you are installing is unable to create a delegation to the DNS subdomain on a DNS server that is authoritative for the parent zone.  
  
     Dcpromo.exe tries to create the delegation to ensure that computers in other domains can resolve DNS queries for hosts, including domain controllers and member computers, in the DNS subdomain.  
  
     Dcpromo.exe can auto\-create such delegations only on Microsoft DNS servers and will always fail if the parent DNS domain zone resides on third party DNS servers such as BIND.  
  
     You can see this error when you install domain controllers in forest root domains with two or three\-part names \(such as contoso.com or corp.contoso.com\) that are immediately subordinate to top\-level domains on the internet such as .COM, GOV, .BIZ, .EDU or two\-letter country code domains such as .NZ and .AU.  
  
     If your Active Directory domain was to be registered on the Internet by the time it was promoted, the logging of this warning text may indicate that your ISP or DNS hosting provider has not yet created the necessary delegation to your Active Directory subdomain.  
  
     Administrators may also encounter this error when creating domain controllers in a forest root domain that is subordinate to an existing corporate intranet namespace. For example, if the internal domain contoso.com is owned by BIND DNS Servers, this error will be encountered when Dcpromo.exe attempts to create the delegation from contoso.com to the Active Directory forest root domain corp.contoso.com subdomain.  
  
     In order for Dcpromo.exe to create the delegation on authoritative DNS servers in the parent domain:  
  
    1.  The parent DNS server must run the Microsoft DNS Server service.  
  
    2.  The Microsoft DNS server in the parent domain must be online and accessible over the network from the domain controller you are installing.  
  
    3.  The user running Dcpromo.exe on the domain controller that you are installing must have Domain Admins, Enterprise Admins, or DNS Admin credentials in the parent DNS zone.  
  
     Given that many Active Directory domains are not registered with an Internet registrar, and that the DNS servers for top level domains \(TLDs\) run BIND, this error message can safely be ignored by clicking **Yes** to continue the promotion.  
  
     Where delegations should exist between the parent domain and the subdomain being promoted, they can be created and validated before or after the Dcpromo.exe promotion. There is no reason to delay the promotion of a new domain controller presenting this error.  
  
     To avoid this error message in future Dcpromo.exe promotions, either:  
  
    1.  Pre\-create the delegation on third\-party DNS Servers in the immediate parent domain.  
  
    2.  Make sure that domain controllers that are being promoted have network connectivity and the necessary administrative credentials to create delegations on Microsoft DNS servers that host the parent DNS zone.  
  
     Alternatively, specify the \/CreateDNSDelegation:No argument in the Dcpromo.exe command line or answer file.  
  
     For more information about delegation, see [Understanding Zone Delegation](http://go.microsoft.com/fwlink/?LinkId=164773) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164773\). If zone delegation is not possible in your situation, you might consider other methods for providing name resolution from other domains to the hosts in your domain. For example, the DNS administrator of another domain could configure conditional forwarding, stub\-zones, or secondary zones in order to resolve names in your domain. For more information, see the following topics:  
  
    -   [Understanding zone types](http://go.microsoft.com/fwlink/?LinkID=157399) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=157399\)  
  
    -   [Understanding stub zones](http://go.microsoft.com/fwlink/?LinkId=164776) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164776\)  
  
    -   [Understanding forwarders](http://go.microsoft.com/fwlink/?LinkId=164778) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=164778\)  
  
-   If you cancel the Active Directory Domain Services Installation Wizard, the wizard closes, but the AD DS binary files are not removed.  
  
     If you want to uninstall the binary files, use Server Manager to uninstall the AD DS role or run **dcpromo \/uninstallBinaries** at a command line, and then restart the computer. This applies to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
##  <a name="BKMK_Space"></a> Disk space and component location issues  
  
-   [Disk space requirements for upgrading to Windows Server 2008](../Topic/Known-Issues-for-Installing-and-Removing-AD-DS.md#BKMK_2008)  
  
-   [Disk space requirements for upgrading to Windows Server 2008 R2](../Topic/Known-Issues-for-Installing-and-Removing-AD-DS.md#BKMK_2008R2)  
  
-   [SYSVOL location on an RODC](../Topic/Known-Issues-for-Installing-and-Removing-AD-DS.md#BKMK_SYSVOLOnRODC)  
  
-   [AD DS installation failure if SYSVOL is located at the root of a drive](../Topic/Known-Issues-for-Installing-and-Removing-AD-DS.md#BKMK_SYSVOLATROOT)  
  
-   [A Stop error occurs if Active Directory database and log files are located in the root of a directory of a disk that does not contain %systemroot%](../Topic/Known-Issues-for-Installing-and-Removing-AD-DS.md#BKMK_Stop)  
  
-   [AD DS installation can fail if directory components or operating system files are placed on advanced drive types such as iSCSI devices](../Topic/Known-Issues-for-Installing-and-Removing-AD-DS.md#BKMK_iSCSI)  
  
###  <a name="BKMK_2008"></a> Disk space requirements for upgrading to Windows Server 2008  
 The upgrade process from Windows Server 2003 to Windows Server 2008 requires free disk space for the new operating system image, for the Setup process, and for any installed server roles. An error is logged when the domain controller role has detected insufficient disk space to perform the upgrade.  
  
 Additional disk space information may appear in the compatibility report displayed by Setup.  
  
 In some cases, the upgrade from Windows Server 2003 to Windows Server 2008 or Windows Server 2008 R2 \(or from Windows Server 2008 to Windows Server 2008 R2\) can fail silently if there is insufficient disk space. In this situation, the installation rolls back to the previous operating system.  
  
 You may also find more information in the Setupact.log file located in the *Drive*:\\$WINDOWS.~BT\\Sources\\Panther folder, where *Drive* represents the drive that contains the existing Windows installation.  
  
 For the domain controller role, the volume or volumes that host the following resources also have specific free disk space requirements:  
  
-   Application Data \(%AppData%\)  
  
-   Program Files \(%ProgramFiles%\)  
  
-   Users Data \(%SystemDrive%\\Documents and Settings\)  
  
-   Windows Directory \(%WinDir%\)  
  
 The free space on the %WinDir% volume must be equal or greater than the current size of the resources listed above and their subordinate folders when they are located on the %WinDir% volume. By default, Dcpromo.exe places the Active Directory database and log files under %Windir%, in which case, their size would be included in the free disk space requirements for the %Windir% folder.  
  
 For example, suppose that you have the following resources located on the %WinDir% volume, with the sizes listed in the following table.  
  
|Resource|Size|  
|--------------|----------|  
|Application Data \(%AppData%\)|100 MB|  
|Program Files \(%ProgramFiles%\)|100 MB|  
|Users Data \(%SystemDrive%\\Documents and Settings\)|50 MB|  
|Windows Directory \(%WinDir%\)|1 GB|  
|Total size|1.25 GB|  
  
 In this example, the free space on the %WinDir% volume must be equal to 1.25 gigabytes \(GB\) or greater.  
  
 However, if the Active Directory database is hosted outside any of the folders above, then the hosting volume or volumes must only contain additional free space equal to at least 10 percent of the current database size or 250 megabytes \(MB\), whichever is greater. Finally, the free space on the volume that hosts the log files must be at least 50 MB.  
  
 A default installation of Active Directory in Windows Server 2003 has the Active Directory database and log files under %WinDir%\\NTDS. With this configuration, the Ntds.dit database file and all the log files are temporarily copied over to the quarantine location and then copied back to their original location; this is why additional free space is required for those resources. Although the SYSVOL directory is also under %WinDir% \(that is, %WinDir%\\SYSVOL\), it is moved and not copied. Therefore, it does not require any additional free space.  
  
 After the upgrade, the space that was reserved for the copied resources will be returned to the file system.  
  
###  <a name="BKMK_2008R2"></a> Disk space requirements for upgrading to Windows Server 2008 R2  
 The Active Directory database, NTDS.dit, on [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers can be larger than in previous versions of Windows for the following reasons:  
  
-   The changes in the online defragmentation process on [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers.  
  
-   [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers add two new indices on the large link table.  
  
-   The [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] Recycle Bin preserves attributes on deleted objects for the Recycle object lifetime.  
  
     For Recycle Bin, the database increases in size at the following moments:  
  
    -   After [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] **adprep \/forestprep** completes and the first [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller is installed, there is a new indexed attribute, **isRecycled**, whose value is set for all deleted objects.  
  
    -   After the Recycle Bin is enabled, all attributes are kept on deleted objects. More disk space is required as more object deletions occur.  
  
     In a production [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain at Microsoft, the Recycle Bin feature increased the AD DS database size by an additional 15 to 20 percent of the original database size, using the default **deletedObjectLifetime** and **recycledObjectLifetime** values of 180 days. Additional space requirements depend on the size and count of the objects that are recycled.  
  
 An in\-place upgrade of a domain controller to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] requires sufficient disk space for the upgrade process to copy the following folders:  
  
-   %SystemRoot%  
  
-   %ProgramFiles%  
  
-   %SystemDrive%\\Program Files  
  
-   %ProgramFiles\(x86\)%  
  
-   %SystemDrive%\\build  
  
-   %SystemDrive%\\InstalledRepository  
  
-   %ProfilesFolder%  
  
-   %ProgramData%  
  
-   %SystemDrive%\\Documents and Settings  
  
 The following table shows the test results for an upgrade of a domain controller from [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. In this table:  
  
-   \<i\> \= 15 GB \(the minimum amount of free space on a Windows hard drive that Windows setup requires\)  
  
-   The original size of Ntds.dit was 5 GB.  
  
|Ntds.dit location|Free space \(GB\) on the system drive|Result|  
|-----------------------|-------------------------------------------|------------|  
|Ntds.dit is located on the same drive as the system, but it is out of %windir%.|1|In this scenario, Ntds.dit does not have to be copied from the Windows.old folder to the Windows folder, but there is not enough space to copy Windows setup files.<br /><br /> The compatibility report finds there is not enough space to copy Windows files.<br /><br /> The upgrade is blocked at the compatibility report.|  
|Ntds.dit is located on a different drive than the system.|\<i\>|In this scenario, the disk meets the minimum free\-space requirements for the Windows files to be installed, and Ntds.dit does not have to be copied from the Windows.old folder to the Windows folder.<br /><br /> The compatibility report warns the user that the amount of free space meets the minimum requirements and that the upgrade process would take longer.<br /><br /> The domain controller is upgraded successfully.|  
|Ntds.dit is located on the default folder:<br /><br /> %windir%\\ntds\\|\<i\> \+ 1|In this scenario, the disk meets the minimum free\-space requirements for the Windows Files to be installed, which causes the compatibility report to be bypassed. However, Ntds.dit is located under the Windows folder, which causes the upgrade to copy it from the Windows.old folder to the Windows folder. This last step fails because there is not enough space on the disk to fit Ntds.dit because the database was not copied to the new operating system. On its first start, [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] is not able to locate Ntds.dit, which causes an error and forces the computer to roll back to the previous operating system.<br /><br /> ERROR\_CODE: \(NTSTATUS\) 0xc00002ec \- Directory Services could not start because of the following error:  %hs  Error Status: 0x%x. Click **OK** to shut down the system. You can use the recovery console to diagnose the system further.<br /><br /> Err 0xc00002ec \= STATUS\_DS\_INIT\_FAILURE\_CONSOLE<br /><br /> The domain controller is rolled back to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] successfully.|  
|Ntds.dit is located on the same drive as the system, but it is out of %windir%.|\<i\>|In this scenario, the disk meets the minimum free\-space requirements for the Windows Files to be installed, and Ntds.dit does not have to be copied from the Windows.old folder to the Windows folder.<br /><br /> The compatibility report warns the user that the amount of free space meets the minimum requirements and that the upgrade process would take longer.<br /><br /> The domain controller is upgraded successfully.|  
  
###  <a name="BKMK_SYSVOLOnRODC"></a> SYSVOL location on an RODC  
 On an RODC that uses Distributed File System \(DFS\) Replication for SYSVOL, you should place the SYSVOL shared folder on a separate volume than the Windows folder. Storing a DFS, read\-only, replicated folder on the same volume as the Windows installation will result in decreased performance for that volume, unless there are other minifilter drivers installed, such as an antivirus program or a backup program.  
  
###  <a name="BKMK_SYSVOLATROOT"></a> AD DS installation failure if SYSVOL is located at the root of a drive  
 You cannot place SYSVOL at the root of drive, such as C:\\. Although the Active Directory Domain Services Installation Wizard allows you to specify the root of a drive as the SYSVOL location, the AD DS installation will subsequently fail.  
  
###  <a name="BKMK_Stop"></a> A Stop error occurs if Active Directory database and log files are located in the root of a directory of a disk that does not contain %systemroot%  
 If you place the Active Directory database and log files in the root directory of a disk other than the disk that contains %systemroot%, a Stop error will occur. You will also receive a Stop error if you place these files on an iSCSI drive that is not available as a boot device. This applies to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], and it applies to new AD DS installations and upgrades.  
  
 To avoid this, ensure that the Active Directory database and log files are in a volume other than the root volume of a local, nonremovable drive.  
  
 Some iSCSI devices incorrectly report that they are local drives even when they are not. If this occurs, contact the drive vendor to determine if the hardware can be configured as a boot device. If the hardware cannot be configured as a boot device, perform the following procedure.  
  
##### To move the Active Directory database and log files  
  
1.  Restart the computer, and then enter Directory Services Restore Mode \(DSRM\) by pressing F8 while the computer starts.  
  
2.  Move the Active Directory database and log files to a subdirectory at least one level beneath the root of a local drive.  
  
3.  Use Regedit.exe to find this registry key: **HKLM\\System\\CurrentControlSet\\Services\\NTDS\\Parameters**  
  
4.  Change the **DSA Database File** value to the new path from step 2, for example, x:\\ntds.  
  
5.  Change the **DSA Working Directory** value to the new path from step 2, for example, x:\\ntds\\logs.  
  
###  <a name="BKMK_iSCSI"></a> AD DS installation can fail if directory components or operating system files are placed on advanced drive types such as iSCSI devices  
 The AD DS installation in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] can fail if you place Active Directory components, such as the Active Directory database or SYSVOL, on an advanced drive type such as an iSCSI device. In [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], the AD DS installation can fail to find an NTFS formatted drive if the operating system files are installed on an iSCSI device.  
  
 The issue with placing Active Directory components on an advanced drive type can occur after the AD DS installation wizard is finished and the server is restarted inn order to complete the installation. After the restart, the server fails to start in normal mode. You might see error 0xc00002e1 in the dcpromoui.log file or a Stop error with code c00002e2 appearing on screen.  
  
 The error is caused by Active Directory components such as the database not being available at startup. Placing the Active Directory database on a Storage Area Network \(SAN\) is supported only if the database is available at startup. Generally, if you cannot install the operating system onto the device in question and have the operating system boot off of it, you cannot host the Active Directory database on it, because Active Directory is a key part of the operating system boot process on computers hosting the domain controller server role.  
  
 As a workaround in this situation, install the Active Directory components on a hard drive that is accessible at startup.  
  
 The issue with AD DS installation failing to find an NTFS formatted drive if the operating system files are installed on an iSCSI device occurs only in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and will be fixed in Service Pack 1. In this situation, the AD DS installation wizard fails with the following error:  
  
 This computer has no disk drives formatted for the NTFS file system. Because the SYSVOL folder is replicated among Active Directory domain controllers, that folder must be on a disk formatted with NTFS  
  
 \(You can convert drives formatted with the FAT file system with the convert.exe command\-line tool.\)  
  
##  <a name="BKMK_Other"></a> Other AD DS server role issues  
  
-   Servers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] have a change to the default startup type for the Computer Browser service. The default startup type is changed to Disabled. In previous versions of Windows Server, the default startup type was Automatic. The change in default startup type was made so that anonymous access is no longer allowed, which helps improve the default security of a new server installation.  
  
     However, applications and services that depend on the Computer Browser service to be running can be adversely affected. For example, Remote Desktop can rely on the Computer Browser service to locate remote computers.  
  
     Because the default startup type is changed, as you retire domain controllers that run Windows Server 2000 and Windows Serer 2003 and add domain controllers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you might be inadvertently dismantling the Computer Browser service infrastructure.  
  
     If you need the Computer Browser service—for example, for application or service support—create a policy that changes the startup type for Computer Browser from Disabled to Automatic.  
  
-   An additional domain controller that is running Windows Server 2008 and that has the Japanese language locale installed does not receive updates to some attributes on an object during inbound replication. There are steps that you can take to prevent this issue from occurring and steps that you can take to recover if the issue has already occurred. For more information, see article 949189 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=114418](http://go.microsoft.com/fwlink/?LinkId=114418)\). This issue does not affect domain controllers that run [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
-   If you are upgrading a domain controller that runs Windows Server 2003 to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], some error event messages for the Netlogon service and the Windows Time service are logged by design and you can safely disregard them.  
  
     In the System log in Event Viewer, Event ID 5706 for the Netlogon service is logged because the SYSVOL directory is moved at the end of the upgrade process. This avoids replication during the upgrade. Event ID 46 for Windows Time service indicates a failure to start because the Netlogon service is not started. After the last reboot of the upgrade process, the SYSVOL directory is already moved and the Netlogon service and the Windows Time service start successfully.  
  
-   Clients that support only the Data Encryption Standard \(DES\) will not be able to establish a secure channel with Netlogon on domain controllers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. As a result, unsecure domain join operations will fail, including operations that are performed by Windows Deployment Services and the Active Directory Migration Tool \(ADMT\). In addition, non\-Microsoft Server Message Block \(SMB\) and network\-attached storage \(NAS\) devices that do not support MD5 will also fail to establish a secure channel.  
  
     To avoid this, upgrade all client computers and domain controllers to Windows 2000 or later. Contact the vendor of any non\-Microsoft SMB and NAS devices to obtain a version that supports MD5.  
  
     If you must support DES, enable support for Windows NT 4.0 cryptography. Open the Group Policy Management snap\-in, click **Computer Configuration**, click **Administrative Templates**, click **System**, and then click **Netlogon**. Right\-click **Allow cryptography algorithms compatible with Windows NT 4.0**, click **Properties**, click **Enabled**, and then click **OK**.  
  
     For more information about similar errors that can occur if older cryptography methods are used to communicate with domain controllers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], see [article 942564](http://go.microsoft.com/fwlink/?LinkId=198011) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=198011\) in the Microsoft Knowledge base.  
  
-   If the domain naming master operations master role is hosted on a domain controller that runs Windows 2000 Server, the **msDS\-BehaviorVersion** attribute is not stamped on the crossRef object when you create a new [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] child domain or domain tree. This might lead to some application compatibility problems. In particular, replication tests that you can perform with Dcdiag.exe will fail. To avoid this problem, transfer the domain naming master role to a domain controller that runs Windows Server 2003, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] before you create the new child domain or new tree root.  
  
##  <a name="BKMK_Perf"></a> Changes to performance counters  
 In Windows 2000 and Windows Server 2003, the Active Directory performance counters are single\-instance and located under **NTDS**. Also, in Windows Server 2003, the Active Directory Application Mode \(ADAM\) performance counters were multi\-instance and located under ADAM. In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], performance counters for both AD DS and Active Directory Lightweight Directory Services \(AD LDS\) are located under those same locations and also under **DirectoryServices**, which is multi\-instance. The AD DS performance counters are under the **NTDS** instance, while the AD LDS performance counters are located under the instance that corresponds to the AD LDS service name \(the same as they were in Windows Server 2003\).  
  
 For example, on a computer running Windows Server 2003 with Active Directory installed and two ADAM services named ADAM\_instance1 and ADAM\_instance2, the following names appear under **Instances of selected object** in Performance Monitor \(where the square brackets indicate the names shown\):  
  
-   **NTDS**  
  
-   **ADAM \[ADAM\_instance1\]**  
  
-   **ADAM \[ADAM\_instance2\]**  
  
 On a computer running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], the following names appear:  
  
-   **NTDS**  
  
-   **DirectoryServices \[NTDS\]**  
  
-   **DirectoryServices \[ADAM\_instance1\]**  
  
-   **DirectoryServices \[ADAM\_instance2\]**  
  
 On a computer running Windows Server 2003 that has only Active Directory installed, the following name appears:  
  
-   **NTDS**  
  
 On a computer running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] that has only AD DS installed, the following name appears:  
  
-   **NTDS**  
  
-   **DirectoryServices \[NTDS\]**  
  
 On a computer running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] that has only AD LDS instances named ADAM\_instance1 and ADAM\_instance2 installed, the following name appears:  
  
-   **DirectoryServices \[ADAM\_instance1\]**  
  
-   **DirectoryServices \[ADAM\_instance2\]**  
  
 The counters in the NTDS block are an exact copy of those in the DirectoryServices \[NTDS\] block. In the future, applications should start to use the DirectoryServices \[NTDS\] counters. The NTDS block is simply for backwards compatibility and may not continue to exist in future versions of Windows.  
  
  