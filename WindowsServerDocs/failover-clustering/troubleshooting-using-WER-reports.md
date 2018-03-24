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

>Applies To: Windows Server

Windows Error Reporting (WER) is a flexible event-based feedback infrastructure designed to gather information about the hardware and software problems that Windows can detect, report the information to Microsoft, and provide users with any available solutions. This [reference](https://docs.microsoft.com/en-us/powershell/module/windowserrorreporting/) provides cmdlet descriptions and syntax for all Windows Error Reporting cmdlets.

## Enabling event channels

When Windows Server is installed, many event channels are disabled by default. We want to be able to enable some of these event channels when we enable Storage Spaces Direct on our cluster since it will help in triaging and diagnosing system issues.

You could enable additional event channels on each server node in your cluster as needed; however, this approach presents two problems:

1. You have to remember to enable the same event channels on every new server node that you add to your cluster.
2. When diagnosing, it can be tedious to enable specific event channels, reproduce the error, and repeat this process until you root cause.

To avoid these issues, you can enable event channels on cluster startup. The list of enabled event channels on your cluster can be configured using the public property *EnabledEventLogs*. By default, the following event channels are enabled:

```
PS C:\Windows\system32> (get-cluster).EnabledEventLogs
Microsoft-Windows-Hyper-V-VmSwitch-Diagnostic,4,0xFFFFFFFD
Microsoft-Windows-SMBDirect/Debug,4
Microsoft-Windows-SMBServer/Analytic
Microsoft-Windows-Kernel-LiveDump/Analytic
```

The ```EnabledEventLogs``` property is a multistring, where each string is in the form: ```  channel-name, log-level, keyword-mask ```. The ``` keyword-mask ``` can be a hexadecimal (prefix 0x), octal (prefix 0), or decimal number (no prefix) number. For instance, to add a new event channel to the list and to configure both ```log-level``` and ```keyword-mask```, you can run:

```
(get-cluster).EnabledEventLogs += "Microsoft-Windows-WinINet/Analytic,2,321"
```

If you want to set the ```log-level```, but keep the ```keyword-mask``` at its default value, you can use either of the following commands:

```
(get-cluster).EnabledEventLogs += "Microsoft-Windows-WinINet/Analytic,2"
(get-cluster).EnabledEventLogs += "Microsoft-Windows-WinINet/Analytic,2,"
```

If you want to keep the ```log-level``` at its default value, but set the ```keyword-mask```, you can run the following command:

```
(get-cluster).EnabledEventLogs += "Microsoft-Windows-WinINet/Analytic,,0xf1"
```

If you want to keep both the ```log-level``` and the ```keyword-mask``` at their default values, you can run any of the following commands:

```
(get-cluster).EnabledEventLogs += "Microsoft-Windows-WinINet/Analytic"
(get-cluster).EnabledEventLogs += "Microsoft-Windows-WinINet/Analytic,"
(get-cluster).EnabledEventLogs += "Microsoft-Windows-WinINet/Analytic,,"
```

These event channels will be enabled on every cluster node when the cluster service starts or whenever the ```EnabledEventLogs``` property is changed.


<!--
## Collecting live dumps

Windows will trigger the collection of a ``` LiveDump ``` when there are known resources that are hanging in kernel calls. ``` RHS ``` will trigger ```LiveDump``` collection if both the resource type and cluster ``` DumpPolicy ``` are set to 1. For physical disk it is set out of the box
-->

## Gathering WER reports

WER Reports are stored in ``` %ProgramData%\Microsoft\Windows\WER ```

Inside the folder, the ``` ReportsQueue ``` folder contains reports that are waiting to be uploaded to Watson.

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

Inside the ``` WER ``` folder, the ``` ReportsArchive ``` folder contains reports that have already been uploaded to Watson. Data in these reports is deleted, but the ``` Report.wer ``` file persists.

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

<!--
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
-->

Windows Error Reporting (WER) provides many settings to customize the problem reporting experience. Read their [documentation](https://msdn.microsoft.com/en-us/library/windows/desktop/bb513638(v=vs.85).aspx) for more information.


## Troubleshooting using WER reports

### Physical disk failed to come online

To diagnose this issue, navigate to the WER report folder:

```
PS C:\Windows\system32> dir C:\ProgramData\Microsoft\Windows\WER\ReportArchive\Critical_PhysicalDisk_b46b8883d892cfa8a26263afca228b17df8133d_00000000_cab_08abc39c
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

Next, start triaging from the ``` Report.wer ``` file — this will tell you what failed.

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

Since the resource failed to come online, no dumps were collected, but the WER report did collect logs. If you open all ``` .evtx ``` files using Microsoft Message Analyzer, you will see all of the information that was collected using the following queries through the system channel, application channel, failover cluster diagnostic channels, and a few other generic channels.

```
PS C:\Windows\system32> (Get-ClusterResourceType -Name "Physical Disk").DumpLogQuery
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-Kernel-PnP/Configuration">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-ReFS/Operational">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-Ntfs/Operational">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-Ntfs/WHC">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-Storage-Storport/Operational">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-Storage-Storport/Health">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-Storage-Storport/Admin">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-Storage-ClassPnP/Operational">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-Storage-ClassPnP/Admin">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-PersistentMemory-ScmBus/Certification">*[System[TimeCreated[timediff(@SystemTime) &lt;= 86400000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-PersistentMemory-ScmBus/Operational">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-PersistentMemory-PmemDisk/Operational">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-PersistentMemory-NvdimmN/Operational">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-PersistentMemory-INvdimm/Operational">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-PersistentMemory-VirtualNvdimm/Operational">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-Storage-Disk/Admin">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-Storage-Disk/Operational">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-ScmDisk0101/Operational">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-Partition/Diagnostic">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-Volume/Diagnostic">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-VolumeSnapshot-Driver/Operational">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-FailoverClustering-Clusport/Operational">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-FailoverClustering-ClusBflt/Operational">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-StorageSpaces-Driver/Diagnostic">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-StorageManagement/Operational">*[System[TimeCreated[timediff(@SystemTime) &lt;= 86400000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-StorageSpaces-Driver/Operational">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-Storage-Tiering/Admin">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-Hyper-V-VmSwitch-Operational">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
<QueryList><Query Id="0"><Select Path="Microsoft-Windows-Hyper-V-VmSwitch-Diagnostic">*[System[TimeCreated[timediff(@SystemTime) &lt;= 600000]]]</Select></Query></QueryList>
```

Message Analyzer enables you to capture, display, and analyze protocol messaging traffic. It also lets you trace and assess system events and other messages from Windows components. You can download [Microsoft Message Analyzer from here](https://www.microsoft.com/en-us/download/details.aspx?id=44226). When you load the logs into Message Analyzer, you will see the following providers and messages from the log channels.

![Loading logs into Message Analyzer](media\troubleshooting-using-WER-reports\loading-logs-into-message-analyzer.png)

You can also group by providers to get the following view:

![Logs grouped by providers](media\troubleshooting-using-WER-reports\logs-grouped-by-providers.png)

To identify why the disk failed, navigate to the events under ``` FailoverClustering/Diagnostic ``` and ``` FailoverClustering/DiagnosticVerbose ```. Then run the following query: ``` EventLog.EventData["LogString"] contains "Cluster Disk 10" ```.  This will give you give you the following output:

![Output of running log query](media\troubleshooting-using-WER-reports\output-of-running-log-query.png)


### Physical disk timed out

To diagnose this issue, navigate to the WER report folder. The folder contains log files and dump files for ``` RHS ```, ``` clussvc.exe ```, and of the process that hosts the “``` smphost ```” service, as shown below:

```
PS C:\Windows\system32> dir C:\ProgramData\Microsoft\Windows\WER\ReportArchive\Critical_PhysicalDisk_64acaf7e4590828ae8a3ac3c8b31da9a789586d4_00000000_cab_1d94712e
Volume in drive C is INSTALLTO
Volume Serial Number is 4031-E397

12/13/2017  10:30 AM    <DIR>          .
12/13/2017  10:30 AM    <DIR>          ..
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_1.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_10.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_11.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_12.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_13.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_14.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_15.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_16.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_17.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_18.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_19.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_2.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_20.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_21.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_22.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_23.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_24.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_25.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_26.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_27.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_28.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_29.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_3.evtx
12/12/2017  10:46 PM         1,118,208 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_30.evtx
12/12/2017  10:46 PM         1,118,208 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_31.evtx
12/12/2017  10:46 PM         1,118,208 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_32.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_33.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_34.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_35.evtx
12/12/2017  10:46 PM         2,166,784 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_36.evtx
12/12/2017  10:46 PM         1,118,208 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_37.evtx
12/12/2017  10:46 PM        28,340,500 memory.hdmp
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_38.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_39.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_4.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_40.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_41.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_5.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_6.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_7.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_8.evtx
12/12/2017  10:46 PM            69,632 CLUSWER_RHS_HANG_75e60318-50c9-41e4-94d9-fb0f589cd224_9.evtx
12/12/2017  10:46 PM         4,466,943 minidump.0f14.mdmp
12/12/2017  10:46 PM         1,735,776 minidump.2200.mdmp
12/12/2017  10:46 PM            33,890 Report.wer
12/12/2017  10:46 PM            49,267 WER69FA.tmp.mdmp
12/12/2017  10:46 PM             5,706 WER70A2.tmp.WERInternalMetadata.xml
12/12/2017  10:46 PM            63,206 WER70E0.tmp.csv
12/12/2017  10:46 PM            13,340 WER7100.tmp.txt
```

Next, start triaging from the ``` Report.wer ``` file — this will tell you what call or resource is hanging.

```
EventType=Failover_clustering_resource_timeout_2
<skip>
Sig[0].Name=ResourceType
Sig[0].Value=Physical Disk
Sig[1].Name=CallType
Sig[1].Value=ONLINERESOURCE
Sig[2].Name=DumpPolicy
Sig[2].Value=5225058577
Sig[3].Name=ControlCode
Sig[3].Value=18
DynamicSig[1].Name=OS Version
DynamicSig[1].Value=10.0.17051.2.0.0.400.8
DynamicSig[2].Name=Locale ID
DynamicSig[2].Value=1033
DynamicSig[26].Name=ResourceName
DynamicSig[26].Value=Cluster Disk 10
DynamicSig[27].Name=ReportId
DynamicSig[27].Value=75e60318-50c9-41e4-94d9-fb0f589cd224
DynamicSig[29].Name=HangThreadId
DynamicSig[29].Value=10008
```

The list of services and processes that we collect in a dump is controlled by the following property: ``` PS C:\Windows\system32> (Get-ClusterResourceType -Name "Physical Disk").DumpServicesSmphost ```

To identify why the hang happened, open the dum files. Then run the following query: ``` EventLog.EventData["LogString"] contains "Cluster Disk 10" ```.  This will give you give you the following output:

![Output of running log query 2](media\troubleshooting-using-WER-reports\output-of-running-log-query-2.png)

We can cross-examine this with the thread from the ``` memory.hdmp ``` file:

```
# 21  Id: 1d98.2718 Suspend: 0 Teb: 0000000b`f1f7b000 Unfrozen
# Child-SP          RetAddr           Call Site
00 0000000b`f3c7ec38 00007ff8`455d25ca ntdll!ZwDelayExecution+0x14 
01 0000000b`f3c7ec40 00007ff8`2ef19710 KERNELBASE!SleepEx+0x9a 
02 0000000b`f3c7ece0 00007ff8`3bdf7fbf clusres!ResHardDiskOnlineOrTurnOffMMThread+0x2b0 
03 0000000b`f3c7f960 00007ff8`391eed34 resutils!ClusWorkerStart+0x5f 
04 0000000b`f3c7f9d0 00000000`00000000 vfbasics+0xed34
```

### Event logs collected on cluster resource call failure and timeouts

The public resource type property ``` DumpLogQuery ``` is a mutistring value. Each string is an [XPATH query as described here](https://msdn.microsoft.com/en-us/library/windows/desktop/dd996910(v=vs.85).aspx).

When troubleshooting, if you need to collect additional event channels, you can a modify the ``` DumpLogQuery ``` property by adding additional queries or modifying the list.

To do this, first test your XPATH query using the [get-WinEvent powershell command](https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Diagnostics/Get-WinEvent?view=powershell-5.1):

``` 
get-WinEvent -FilterXML "<QueryList><Query><Select Path='Microsoft-Windows-GroupPolicy/Operational'>*[System[TimeCreated[timediff(@SystemTime) &gt;= 600000]]]</Select></Query></QueryList>"
```

Next, append your query to the ``` DumpLogQuery ``` property of the resource:

```
(Get-ClusterResourceType -Name "Physical Disk".DumpLogQuery += "<QueryList><Query><Select Path='Microsoft-Windows-GroupPolicy/Operational'>*[System[TimeCreated[timediff(@SystemTime) &gt;= 600000]]]</Select></Query></QueryList>"
```

And if you want to get a list of queries to use, run:
```
(Get-ClusterResourceType -Name "Physical Disk").DumpLogQuery
```

These are the most common issues that WER reports can help you diagnose. 

Thanks!

Vladimir Petter

Principal Software Engineer Lead

High-Availability & Storage

Microsoft