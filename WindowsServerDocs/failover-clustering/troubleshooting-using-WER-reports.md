---
title: Troubleshooting a Failover Cluster using WER Reports
description: Troubleshooting a Failover Cluster using WER Reports, with specific details on how to gather reports and diagnose common issues.
keywords: Failover Cluster,WER Reports,Diagnostics,Cluster
ms.assetid: 
ms.prod: 
ms.author: adagashe
ms.manager: eldenc
ms.technology: storage-failover-clustering
ms.topic: article
author: adagashe
ms.date: 03/01/2018
ms.localizationpriority: 
---
# Troubleshooting a Failover Cluster using WER Reports

>Applies To: Windows Server 2016

Windows Error Reporting (WER) is a flexible event-based feedback infrastructure designed to gather information about the hardware and software problems that Windows can detect, report the information to Microsoft, and provide users with any available solutions. This [reference](https://docs.microsoft.com/en-us/powershell/module/windowserrorreporting/) provides cmdlet descriptions and syntax for all Windows Error Reporting cmdlets.

## Gathering WER reports

The WER Reports created by the cluster are stored along with all other WER reports in ``` C:\ProgramData\Microsoft\Windows\WER ```

Inside the WER folder, the ReportsQueue folder contains reports that are waiting to be uploaded to the Watson.

```
PS C:\Windows\system32> dir c:\ProgramData\Microsoft\Windows\WER\ReportQueue
Volume in drive C is INSTALLTO
Volume Serial Number is 4031-E397

Directory of C:\ProgramData\Microsoft\Windows\WER\ReportQueue

12/13/2017  12:03 PM    <DIR>          .
12/13/2017  12:03 PM    <DIR>          ..
12/13/2017  04:54 AM    <DIR>          Critical_Physical Disk_1cbd8ffecbc8a1a0e7819e4262e3ece2909a157a_00000000_02d10a3f
12/13/2017  02:51 AM    <DIR>          Critical_Physical Disk_1cbd8ffecbc8a1a0e7819e4262e3ece2909a157a_00000000_0588dd06
12/13/2017  08:59 AM    <DIR>          Critical_Physical Disk_1cbd8ffecbc8a1a0e7819e4262e3ece2909a157a_00000000_10d55ef5
12/13/2017  11:01 AM    <DIR>          Critical_Physical Disk_1cbd8ffecbc8a1a0e7819e4262e3ece2909a157a_00000000_13258c8c
12/13/2017  01:50 AM    <DIR>          Critical_Physical Disk_1cbd8ffecbc8a1a0e7819e4262e3ece2909a157a_00000000_13a8c4ac
12/13/2017  03:52 AM    <DIR>          Critical_Physical Disk_1cbd8ffecbc8a1a0e7819e4262e3ece2909a157a_00000000_13dcf4d3
12/13/2017  12:03 PM    <DIR>          Critical_Physical Disk_1cbd8ffecbc8a1a0e7819e4262e3ece2909a157a_00000000_1721a0b0
12/13/2017  10:00 AM    <DIR>          Critical_Physical Disk_1cbd8ffecbc8a1a0e7819e4262e3ece2909a157a_00000000_1839758a
12/13/2017  06:56 AM    <DIR>          Critical_Physical Disk_1cbd8ffecbc8a1a0e7819e4262e3ece2909a157a_00000000_1d4131cb
12/13/2017  05:55 AM    <DIR>          Critical_Physical Disk_1cbd8ffecbc8a1a0e7819e4262e3ece2909a157a_00000000_23551d79
12/13/2017  12:49 AM    <DIR>          Critical_Physical Disk_1cbd8ffecbc8a1a0e7819e4262e3ece2909a157a_00000000_2468ad4c
12/13/2017  07:58 AM    <DIR>          Critical_Physical Disk_1cbd8ffecbc8a1a0e7819e4262e3ece2909a157a_00000000_255d4d61
12/12/2017  11:47 PM    <DIR>          Critical_Physical Disk_1cbd8ffecbc8a1a0e7819e4262e3ece2909a157a_00000000_cab_08289734
12/12/2017  10:46 PM    <DIR>          Critical_Physical Disk_64acaf7e4590828ae8a3ac3c8b31da9a789586d4_00000000_cab_1d94712e
12/07/2017  09:46 AM    <DIR>          Critical_Physical Disk_ae39f5243a104f21ac5b04a39efeac4c126754_00000000_003359cb
12/04/2017  10:52 PM    <DIR>          Critical_Physical Disk_ae39f5243a104f21ac5b04a39efeac4c126754_00000000_cab_1b293b17
12/12/2017  10:38 PM    <DIR>          Critical_Physical Disk_b46b8883d892cfa8a26263afca228b17df8133d_00000000_cab_08abc39c
12/12/2017  10:46 PM    <DIR>          Kernel_166_1234dacd2d1a219a3696b6e64a736408fc785cc_00000000_cab_19c8a127
               0 File(s)              0 bytes
              20 Dir(s)  23,291,658,240 bytes free
```

Inside the WER folder, the ReportsArchive folder contains reports that have already been uploaded to Watson. Data in these reports is deleted, but the Report.wer remains.

```
PS C:\Windows\system32> dir C:\ProgramData\Microsoft\Windows\WER\ReportArchive
Volume in drive C is INSTALLTO
Volume Serial Number is 4031-E397

Directory of c:\ProgramData\Microsoft\Windows\WER\ReportArchive

12/04/2017  08:28 PM    <DIR>          .
12/04/2017  08:28 PM    <DIR>          ..
12/04/2017  08:28 PM    <DIR>          Critical_powershell.exe_7dd54f49935ce48b2dd99d1c64df29a5cfb73db_00000000_cab_096cc802
               0 File(s)              0 bytes
               3 Dir(s)  23,291,658,240 bytes free

```

If your report has been uploaded to Watson, a Microsoft Employee might be able to get your reports from [https://watson/](https://watson) by searching for your report ID and/or bucket ID (these can be found in Report.wer).

```
OriginalFilename=PowerShell.EXE.MUI
Response.BucketId=f4bbb1850ee0c2c8ad7231a4f1c7aa8a
Response.BucketTable=5
Response.LegacyBucketId=2121812958945716874
Response.type=4
Response.CabId=2154498584323680636
Response.CabGuid=1701c157-8fe6-4c22-9de6-510c23b1e97c
```

Windows Error Reporting (WER) provides many settings to customize the problem reporting experience. Read their [documentation](https://msdn.microsoft.com/en-us/library/windows/desktop/bb513638(v=vs.85).aspx) for more information.

## Troubleshooting using WER Reports

### Physical Disk Failed to Come Online

To diagnose this issue, navigate to the physical disk folder.

```
PS C:\Windows\system32> dir C:\ProgramData\Microsoft\Windows\WER\ReportArchive\Critical_Physical Disk_b46b8883d892cfa8a26263afca228b17df8133d_00000000_cab_08abc39c
Volume in drive C is INSTALLTO
Volume Serial Number is 4031-E397

12/13/2017  10:30 AM    <DIR>          .
12/13/2017  10:30 AM    <DIR>          ..
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_1.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_10.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_11.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_12.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_13.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_14.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_15.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_16.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_17.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_18.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_19.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_2.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_20.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_21.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_22.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_23.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_24.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_25.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_26.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_27.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_28.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_29.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_3.evtx
12/12/2017  10:38 PM         1,118,208 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_30.evtx
12/12/2017  10:38 PM         1,118,208 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_31.evtx
12/12/2017  10:38 PM         1,118,208 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_32.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_33.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_34.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_35.evtx
12/12/2017  10:38 PM         2,166,784 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_36.evtx
12/12/2017  10:38 PM         1,118,208 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_37.evtx
12/12/2017  10:38 PM            33,194 Report.wer
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_38.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_39.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_4.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_40.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_41.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_5.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_6.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_7.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_8.evtx
12/12/2017  10:38 PM            69,632 CLUSWER_RHS_ERROR_8d06c544-47a4-4396-96ec-af644f45c70a_9.evtx
12/12/2017  10:38 PM             7,382 WERC263.tmp.WERInternalMetadata.xml
12/12/2017  10:38 PM            59,202 WERC36D.tmp.csv
12/12/2017  10:38 PM            13,340 WERC38D.tmp.txt
```

Next, start triaging from Report.wer — this will tell you what failed.

```
EventType=Failover_clustering_resource_error 
<skip>
Sig[0].Name=ResourceType
Sig[0].Value=Physical Disk
Sig[1].Name=CallType
Sig[1].Value=ONLINERESOURCE
Sig[2].Name=RHSCallResult
Sig[2].Value=5018
Sig[3].Name=ApplicationCallResult
Sig[3].Value=999
Sig[4].Name=DumpPolicy
Sig[4].Value=5225058577
DynamicSig[1].Name=OS Version
DynamicSig[1].Value=10.0.17051.2.0.0.400.8
DynamicSig[2].Name=Locale ID
DynamicSig[2].Value=1033
DynamicSig[27].Name=ResourceName
DynamicSig[27].Value=Cluster Disk 10
DynamicSig[28].Name=ReportId
DynamicSig[28].Value=8d06c544-47a4-4396-96ec-af644f45c70a
DynamicSig[29].Name=FailureTime
DynamicSig[29].Value=2017//12//12-22:38:05.485
```
