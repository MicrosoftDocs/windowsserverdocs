---
title: Assess Hardware Requirements
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 1cd1de42-a15b-4359-80fd-3798a7c58c44
author: Femila
---
# Assess Hardware Requirements
Review and document the existing hardware configuration of each domain controller that you plan to upgrade. Use this information to identify the domain controllers in your environment that you can upgrade and the domain controllers that do not meet the hardware requirements necessary to run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. You can retain domain controllers that do not meet the necessary hardware requirements to serve as rollback servers if you must roll back your deployment. In most cases, a Windows 2000–based domain controller meets the requirements to be upgraded to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] as long as it has adequate disk space.  
  
At minimum, a domain controller requires available free disk space for the Active Directory Domain Services \(AD DS\) database, AD DS log files, SYSVOL, and the operating system. Use the following guidelines to determine how much disk space to allot for your AD DS installation:  
  
-   On the drive that will contain the AD DS database, NTDS.dit, provide 0.4 gigabytes \(GB\) of storage for each 1,000 users. For example, for a forest with two domains \(domain A and domain B\) with 10,000 users and 5,000 users, respectively, provide a minimum of 4 GB of disk space for each domain controller that hosts domain A and provide a minimum of 2 GB of disk space for each domain controller that hosts domain B. Available space must equal at least 10 percent of your existing database size or at least 250 megabytes \(MB\), whichever is greater.  
  
-   On the drive containing the AD DS log files, provide at least 500 MB of available space.  
  
-   On the drive containing the SYSVOL shared folder, provide at least 500 MB of available space.  
  
-   On the drive containing the operating system files, to run setup, provide at least 1.25 GB to 2 GB of available space.  
  
## <a name="BKMK_2008"></a>Disk space requirements for upgrading to Windows Server 2008  
The upgrade process from Windows Server 2003 to Windows Server 2008 requires free disk space for the new operating system image, for the Setup process, and for any installed server roles. An error is logged when the domain controller role detects insufficient disk space to perform the upgrade.  
  
Additional disk space information may appear in the compatibility report that Setup displays.  
  
For the domain controller role, the volume or volumes that host the following resources also have specific free disk space requirements:  
  
-   Application Data \(%AppData%\)  
  
-   Program Files \(%ProgramFiles%\)  
  
-   Users Data \(%SystemDrive%\\Documents and Settings\)  
  
-   Windows Directory \(%WinDir%\)  
  
The free space on the %WinDir% volume must be equal or greater than the current size of the resources listed above and their subordinate folders when they are located on the %WinDir% volume. By default, Dcpromo.exe places the Active Directory database and log files under %Windir%, in which case, their size is included in the free disk space requirements for the %Windir% folder.  
  
For example, suppose that you have the following resources located on the %WinDir% volume, with the sizes listed in the following table.  
  
|Resource|Size|  
|------------|--------|  
|Application Data \(%AppData%\)|100 MB|  
|Program Files \(%ProgramFiles%\)|100 MB|  
|Users Data \(%SystemDrive%\\Documents and Settings\)|50 MB|  
|Windows Directory \(%WinDir%\)|1 GB|  
|Total size|1.25 GB|  
  
In this example, the free space on the %WinDir% volume must be equal to 1.25 GB or greater.  
  
However, if the Active Directory database is hosted outside any of the folders above, then the hosting volume or volumes must only contain additional free space equal to at least 10 percent of the current database size or 250 MB, whichever is greater. Finally, the free space on the volume that hosts the log files must be at least 50 MB.  
  
A default installation of Active Directory in Windows Server 2003 has the Active Directory database and log files under %WinDir%\\NTDS. With this configuration, the Ntds.dit database file and all the log files are temporarily copied over to the quarantine location and then copied back to their original location; this is why additional free space is required for those resources. Although the SYSVOL directory is also under %WinDir% \(that is, %WinDir%\\SYSVOL\), it is moved and not copied. Therefore, it does not require any additional free space.  
  
After the upgrade, the space that was reserved for the copied resources will be returned to the file system.  
  
## <a name="BKMK_2008R2"></a>Disk space requirements for upgrading to Windows Server 2008 R2  
The Active Directory database, NTDS.dit, on [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers can be larger than in previous versions of Windows for the following reasons:  
  
-   The "partial merge" feature is disabled on [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers.  
  
-   [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers add two new indices on the large link table.  
  
-   The Active Directory Recycle Bin [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] preserves attributes on deleted objects for the Recycle object lifetime.  
  
    For Active Directory Recycle Bin, the database increases in size at the following moments:  
  
    -   After [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] **adprep \/forestprep** completes and the first [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller is installed, there is a new indexed attribute, **isRecycled**, whose value is set for all deleted objects.  
  
    -   After the Active Directory Recycle Bin is enabled, all attributes are kept on deleted objects. More disk space is required as more object deletions occur.  
  
    In a production [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain at Microsoft, the Active Directory Recycle Bin feature increased the size of the AD DS database by an additional 15 to 20 percent of the original database size, using the default **deletedObjectLifetime** and **recycledObjectLifetime** values of 180 days. Additional space requirements depend on the size and count of the objects that are recycled.  
  
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
  
-   <i> \= 15 GB \(the minimum amount of free space on a Windows hard drive that Windows setup requires\)  
  
-   The original size of Ntds.dit was 5 GB.  
  
|Ntds.dit location|Free space \(GB\) on the system drive|Result|  
|---------------------|-----------------------------------------|----------|  
|Ntds.dit is located on the same drive as the system, but it is out of %windir%.|1|In this scenario, Ntds.dit does not have to be copied from the Windows.old folder to the Windows folder, but there is not enough space to copy Windows setup files.<br /><br />The compatibility report finds there is not enough space to copy Windows files.<br /><br />The upgrade is blocked at the compatibility report.|  
|Ntds.dit is located on a different drive than the system.|<i>|In this scenario, the disk meets the minimum free\-space requirements for the Windows files to be installed, and Ntds.dit does not have to be copied from the Windows.old folder to the Windows folder.<br /><br />The compatibility report warns the user that the amount of free space meets the minimum requirements and that the upgrade process would take longer.<br /><br />The domain controller is upgraded successfully.|  
|Ntds.dit is located on the default folder:<br /><br />%windir%\\ntds\\|<i> \+ 1|In this scenario, the disk meets the minimum free\-space requirements for the Windows Files to be installed, which causes the compatibility report to be bypassed. However, Ntds.dit is located under the Windows folder, which causes the upgrade to copy it from the Windows.old folder to the Windows folder. This last step fails because there is not enough space on the disk to fit Ntds.dit because the database was not copied to the new operating system. On its first start, [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] is not able to locate Ntds.dit, which causes an error and forces the computer to roll back to the previous operating system.<br /><br />ERROR\_CODE: \(NTSTATUS\) 0xc00002ec \- Directory Services could not start because of the following error:  %hs  Error Status: 0x%x. Click **OK** to shut down the system. You can use the recovery console to diagnose the system further.<br /><br />Err 0xc00002ec \= STATUS\_DS\_INIT\_FAILURE\_CONSOLE<br /><br />The domain controller is rolled back to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] successfully.|  
|Ntds.dit is located on the same drive as the system, but it is out of %windir%.|<i>|In this scenario, the disk meets the minimum free\-space requirements for the Windows Files to be installed, and Ntds.dit does not have to be copied from the Windows.old folder to the Windows folder.<br /><br />The compatibility report warns the user that the amount of free space meets the minimum requirements and that the upgrade process would take longer.<br /><br />The domain controller is upgraded successfully.|  
  
