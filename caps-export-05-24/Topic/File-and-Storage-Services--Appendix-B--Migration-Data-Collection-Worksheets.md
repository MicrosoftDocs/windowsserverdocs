---
title: File and Storage Services: Appendix B: Migration Data Collection Worksheets
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 35dc2562-bc47-45aa-b466-817806123ba4
---
# File and Storage Services: Appendix B: Migration Data Collection Worksheets
  
## <a name="BKMK_SMBdatacollectionworksheet"></a>SMB data collection worksheet  
Use this server message block \(SMB\) data collection worksheet to record data for SMB policies that are set on the source server.  
  
|\#|Source Server Essential Settings|Setting Identification|  
|------|------------------------------------|--------------------------|  
|01|Idle time<br /><br />The setting name is: **Microsoft network server: Amount of idle time required before suspending a session**.|Idle time \(in minutes\): \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_<br /><br />Group or Local Policy:<br />\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_|  
|02|S4USelf<br /><br />The setting name is: **Microsoft network server: Attempt S4USelf to obtain claim information**.|Claim information: \_\_ Default \_\_ Enabled or \_\_ Disabled<br /><br />Group or Local Policy:<br />\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_|  
|03|Sign \(always\)<br /><br />The setting name is: **Microsoft network server: Digitally sign communications \(always\)**.|Sign always: \_\_ Enabled or \_\_ Disabled<br /><br />Group or Local Policy:<br />\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_|  
|04|Sign \(if client agrees\)<br /><br />The setting name is: **Microsoft network server: Digitally sign communications \(if client agrees\)**.|Sign if client agrees: \_\_ Enabled or \_\_ Disabled<br /><br />Group or Local Policy:<br />\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_|  
|05|Disconnect when logon hours expire<br /><br />The setting name is: **Microsoft network server: Disconnect clients when logon hours expire**.|Disconnect: \_\_ Enabled or \_\_ Disabled<br /><br />Group or Local Policy:<br />\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_|  
  
## <a name="BKMK_CSCdatacollectionworksheet"></a>BranchCache data collection worksheet  
Use this BranchCache data collection worksheet to record data for the BranchCache policies that are set on the source server.  
  
|\#|Source Server Essential Settings|Setting Identification|  
|------|------------------------------------|--------------------------|  
|01|BranchCache<br /><br />The setting name is: **Hash Publication for BranchCache**.|BranchCache:<br /><br />\_\_  Not configured, \_\_  Enabled, or \_\_  Disabled<br /><br />Group or Local Policy:<br />\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_|  
||BranchCache<br /><br />The setting name is: **Hash Version support for BranchCache**.|BranchCache:<br /><br />\_\_  Not configured, \_\_  Enabled, or \_\_  Disabled<br /><br />Group or Local Policy:<br />\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_|  
  
## See Also  
[Migrate File and Storage Services to Windows Server 2012 R2](../Topic/Migrate-File-and-Storage-Services-to-Windows-Server-2012-R2.md)  
[File and Storage Services: Prepare to Migrate](../Topic/File-and-Storage-Services--Prepare-to-Migrate.md)  
[File and Storage Services: Migrate the File and Storage Services Role](../Topic/File-and-Storage-Services--Migrate-the-File-and-Storage-Services-Role.md)  
[File and Storage Services: Verify the Migration](../Topic/File-and-Storage-Services--Verify-the-Migration.md)  
[File and Storage Services: Migrate an iSCSI Software Target](../Topic/File-and-Storage-Services--Migrate-an-iSCSI-Software-Target.md)  
[File and Storage Services: Migrate Network File System](../Topic/File-and-Storage-Services--Migrate-Network-File-System.md)  
[File and Storage Services: Post-Migration Tasks](../Topic/File-and-Storage-Services--Post-Migration-Tasks.md)  
[File and Storage Services: Appendix A: Optional Procedures](../Topic/File-and-Storage-Services--Appendix-A--Optional-Procedures.md)  
  
