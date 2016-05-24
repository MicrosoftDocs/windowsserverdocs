---
title: Troubleshoot the iSCSI Software Target Migration
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9a642468-5728-4a39-8a37-5cc9ef883f65
---
# Troubleshoot the iSCSI Software Target Migration
Troubleshooting iSCSI Software Target migration issues involves first viewing the contents of the Windows Server Migration Tools deployment log and the result objects. For more information, see [Locate the deployment log file](assetId:///2c804519-a397-4247-b7f2-1fee496f90c5#bkmk_deploymentlogfile) and [View the content of Windows Server Migration Tools result objects](assetId:///2c804519-a397-4247-b7f2-1fee496f90c5#bkmk_migrationtoolsresultobjects).  
  
## Understanding the messages from the iSCSI Target Migration tool  
The iSCSI migration tool does not produce a log file, but it prints diagnostics messages on the console. These messages show the outcome of the operations that are being attempted and performed.  
  
For example, the following message shows information about saved settings:  
  
```  
PS C:\Windows\System32\WindowsPowerSehll\V1.0\Modules\IscsiTarget>  
.\iSCSITargetSettings.PS1 -Export -FileName $env:temp\test00000000.xml  
  
Number of Target(s) saved in the Export settings: 4.  
Target Names:  
   test000  
   test001  
   test002  
   test1111  
  
Number of Virtual Disk(s) saved in the Export settings: 3.  
Virtual Disk DevicePaths:  
   s:\test000.vhd  
   t:\test000.vhd  
   z:\test000.vhd  
  
Number of Virtual Disk(s) NOT saved in the Export settings: 0.  
Virtual Disk DevicePaths:  
  
```  
  
The following message shows that not all the virtual disks are eligible for migration:  
  
```  
PS D:\Program Files\ISCSI Target> .\iSCSITargetSettings.PS1 -Export -FileName $env:temp\test00000001.xml  
  
Number of Target(s) saved in the Export settings: 4.  
Target Names:  
   test000  
   test001  
   test002  
   test1111  
  
Number of Virtual Disk(s) saved in the Export settings: 3.  
Virtual Disk DevicePaths:  
   s:\test000.vhd  
   t:\test000.vhd  
   z:\test000.vhd  
  
Number of Virtual Disk(s) NOT saved in the Export settings: 1.  
Virtual Disk DevicePaths:  
    \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy{B6B3C77C-93CC-11DF-B3FE-001CC0C60A6E}\test000.vhd  
  
```  
  
The following message shows information about the settings restore phase:  
  
```  
PS C:\Program Files\ISCSI Target> .\iSCSITargetSettings.PS1 -Import -file $env:temp\test00000000.xml  
  
Importing settings from file 'E:\Users\administrator\AppData\Local\Temp\test00000001.xml'.  
The operation may take a long time.  
  
Number of Target(s) imported from the Import settings: 4.  
Targets:  
    test000  
    test001  
    test002  
    test1111  
  
Number of Virtual Disk(s) imported from the Import settings: 3.  
Virtual Disk:  
   s:\test000.vhd  
   t:\test000.vhd  
   z:\test000.vhd  
```  
  
## See Also  
[Migrate File and Storage Services to Windows Server 2012 R2](../Topic/Migrate-File-and-Storage-Services-to-Windows-Server-2012-R2.md)  
[File and Storage Services: Migrate an iSCSI Software Target](../Topic/File-and-Storage-Services--Migrate-an-iSCSI-Software-Target.md)  
[Prepare to Migrate iSCSI Software Target](../Topic/Prepare-to-Migrate-iSCSI-Software-Target.md)  
[Migrate iSCSI Software Target](../Topic/Migrate-iSCSI-Software-Target.md)  
[Verify the iSCSI Software Target Migration](../Topic/Verify-the-iSCSI-Software-Target-Migration.md)  
[Roll Back a Failed iSCSI Software Target Migration](../Topic/Roll-Back-a-Failed-iSCSI-Software-Target-Migration.md)  
  
