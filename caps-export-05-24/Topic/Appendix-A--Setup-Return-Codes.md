---
title: Appendix A: Setup Return Codes
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1e404f17-7e6b-4ce0-ad81-1e0d03bbaf39
author: jaimeo
---
# Appendix A: Setup Return Codes
[!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] 3.0 SP2 uses return codes to determine the success or the failure of the Setup operation. The following table describes these return codes.  
  
> [!NOTE]  
> A return code of **0** indicates success. All other return codes indicate a failure.  
  
|Return Code|Return String|Meaning|  
|---------------|-----------------|-----------|  
|0x001450|SUS\_LAUNCH\_ERROR|Setup conditions are not satisfied.|  
|0x001451|SUS\_UNKNOWN\_ERROR|Unknown error.|  
|0x001452|SUS\_REBOOT\_REQUIRED|Reboot is required to complete the installation. This error most commonly occurs when installing [!INCLUDE[firstref_wyukon](../Token/firstref_wyukon_md.md)].|  
|0x001453|SUS\_INVALID\_COMMANDLINE|Invalid command line entry.|  
|0x001454|SUS\_LOWSQLVERSION|Invalid SQL Server version. WSUS supports only computers running at least SQL Server 2005 SP2.|  
|0x001455|SUS\_TRIGGERSNOTSET|Triggers are not set in SQL Server. For instructions about how to enable nested triggers, see [How to: Configure the nested triggers Option \(SQL Server Management Studio\)](http://go.microsoft.com/fwlink/?LinkID=202951).|  
|0x001456|SUS\_INVALIDPATH|Invalid content path is specified.|  
|0x001457|SUS\_NETWORKPATH|Specified content path is a network path.|  
|0x001458|SUS\_NONNTFS\_PATH|Specified content path is not NTFS.|  
|0x001459|SUS\_NONFIXEDDRIVE|Specified content path is not on a fixed drive.|  
|0x00145a|SUS\_NONTFS\_DRIVES\_PRESENT|No NTFS drives exist on the system.|  
|0x00145b|SUS\_INSUFFICIENT\_SPACE|Not enough space is available at the given path. At least 6 GB of space is required.|  
|0x00145c|SUS\_NEED\_SERVER\_AND\_PORT|Both server name and port are required for replica mode.|  
|0x00145d|SUS\_MSCOM\_SERVER|Specified server name ends in **.microsoft.com**.|  
|0x001460|SUS\_ERROR\_PREREQCHECK\_FAIL|Prerequisite check failed.|  
|0x001461|SUS\_LOWDBSCHEMAUPGRADE\_VERSION|This database schema is too old to be upgraded.|  
|0x001462|SUS\_UPGRADE\_REQUIRED|WSUS Setup must upgrade. Use the **\/G** parameter to avoid this error.|  
  
