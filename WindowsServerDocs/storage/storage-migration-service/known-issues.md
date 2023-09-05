---
title: Storage Migration Service known issues
description: Known issues and troubleshooting support for Storage Migration Service, such as how to collect logs for Microsoft Support.
author: nedpyle
ms.author: nedpyle
manager: tiaascs
ms.date: 04/24/2023
ms.topic: article
---
# Storage Migration Service known issues

This article contains answers to known issues when using [Storage Migration Service](overview.md) to migrate servers.

Storage Migration Service is released in two parts: the service in Windows Server, and the user interface in Windows Admin Center. The service is available in Windows Server, Long-Term Servicing Channel, and Windows Server, Semi-Annual Channel; while Windows Admin Center is available as a separate download. We also periodically include changes in cumulative updates for Windows Server, released via Windows Update.

For example, Windows Server, version 1903 includes new features and fixes for Storage Migration Service, which are also available for Windows Server 2019 and Windows Server, version 1809 by installing [KB4512534](https://support.microsoft.com/help/4512534/windows-10-update-kb4512534).

## <a name="collecting-logs"></a> How to collect log files when working with Microsoft Support

The Storage Migration Service contains event logs for the Orchestrator service and the Proxy Service. The orchestrator server always contains both event logs, and destination servers with the proxy service installed contain the proxy logs. These logs are located under:

- Application and Services Logs \ Microsoft \ Windows \ StorageMigrationService
- Application and Services Logs \ Microsoft \ Windows \ StorageMigrationService-Proxy

If you need to gather these logs for offline viewing or to send to Microsoft Support, there's an open-source PowerShell script available on GitHub:

 [Storage Migration Service Helper](https://aka.ms/smslogs)

Review the README for usage.

## Storage Migration Service doesn't show up in Windows Admin Center unless managing Windows Server 2019

When using the 1809 version of Windows Admin Center to manage a Windows Server 2019 orchestrator, you don't see the tool option for Storage Migration Service.

The Windows Admin Center Storage Migration Service extension is version-bound to only manage Windows Server 2019 version 1809 or later operating systems. If you use it to manage older Windows Server operating systems or insider previews, the tool doesn't appear. This behavior is by design.

To resolve, use or upgrade to Windows Server 2019 build 1809 or later.

## Storage Migration Service cutover validation fails with error "Access is denied for the token filter policy on destination computer"

When running cutover validation, you receive error "Fail: Access is denied for the token filter policy on destination computer." This occurs even if you provided correct local administrator credentials for both the source and destination computers.

This issue was fixed in the [KB4512534](https://support.microsoft.com/help/4512534/windows-10-update-kb4512534) update.

## Storage Migration Service isn't included in Windows Server 2019 Evaluation or Windows Server 2019 Essentials edition

When using Windows Admin Center to connect to a [Windows Server 2019 Evaluation release](https://www.microsoft.com/evalcenter/evaluate-windows-server-2019) or Windows Server 2019 Essentials edition, there isn't an option to manage the Storage Migration Service. Storage Migration Service also isn't included in Roles and Features.

This issue is caused by a servicing issue in the Evaluation media of Windows Server 2019 and Windows Server 2019 Essentials.

To work around this issue for evaluation, install a retail, MSDN, OEM, or Volume License version of Windows Server 2019 and don't activate it. Without activation, all editions of Windows Server operate in evaluation mode for 180 days.

We've fixed this issue in a later release of Windows Server.

## Storage Migration Service times out downloading the transfer or errors CSV

When using Windows Admin Center or PowerShell to download the transfer operations detailed CSV log, you receive error:

```
Transfer Log - Please check file sharing is allowed in your firewall. : This request operation sent to net.tcp://localhost:28940/sms/service/1/transfer did not receive a reply within the configured timeout (00:01:00). The time allotted to this operation may have been a portion of a longer timeout. This may be because the service is still processing the operation or because the service was unable to send a reply message. Please consider increasing the operation timeout (by casting the channel/proxy to IContextChannel and setting the OperationTimeout property) and ensure that the service is able to connect to the client.
```

This issue is caused by an extremely large number of transferred files that can't be filtered in the default one-minute timeout allowed by Storage Migration Service.

To work around this issue:

1. On the orchestrator computer, edit the *%SYSTEMROOT%\SMS\Microsoft.StorageMigration.Service.exe.config* file using Notepad.exe to change the "sendTimeout" from its 1-minute default to 10 hours.

    ```
    <bindings>
      <netTcpBinding>
        <binding name="NetTcpBindingSms"
                 sendTimeout="10:00:00"
    ```

2. Restart the "Storage Migration Service" service on the orchestrator computer.

3. On the orchestrator computer, start Regedit.exe

4. Create the following registry subkey if it doesn't already exist:

    `HKEY_LOCAL_MACHINE\Software\Microsoft\SMSPowershell`

5. On the Edit menu, point to New, and then select DWORD Value.

6. Type "WcfOperationTimeoutInMinutes" for the name of the DWORD, and then press ENTER.

7. Right-click "WcfOperationTimeoutInMinutes", and then select Modify.

8. In the Base data box, select "Decimal"

9. In the Value data box, type "600", and then select OK.

10. Exit Registry Editor.

11. Attempt to download the errors-only CSV file again.

If still seeing issues while using WAC, instead use PowerShell. Run one of the following commands on the Orchestrator computer, setting your own job name and source server FQDN values:

   ```PowerShell
   Get-SmsState -Name job -TransferFileDetail -computername sourcefqdn | export-csv -path log.csv
   Get-SmsState -Name job -TransferFileDetail -ErrorsOnly -computername sourcefqdn | export-csv -path errlog.csv
   ```

## Validation warnings for destination proxy and credential administrative privileges

When validating a transfer job, you see the following warnings:

```
The credential has administrative privileges.
Warning: Action isn't available remotely.
The destination proxy is registered.
Warning: The destination proxy wasn't found.
```

If you haven't installed the Storage Migration Service Proxy service on the Windows Server 2019 destination computer, this behavior is by design. You also receive this message if the destination computer is Windows Server 2016 or Windows Server 2012 R2. We recommend migrating to a Windows Server 2019 computer with the proxy installed for improved transfer performance.

## Certain files don't inventory or transfer, error 5 "Access is denied"

When inventorying or transferring files from source to destination computers, files from which a user has removed permissions for the Administrators group fail to migrate. Examining the Storage Migration Service-Proxy debug shows:

```
Log Name: Microsoft-Windows-StorageMigrationService-Proxy/Debug
Source: Microsoft-Windows-StorageMigrationService-Proxy
Date: 2/26/2019 9:00:04 AM
Event ID: 10000
Task Category: None
Level: Error
Keywords:
User: NETWORK SERVICE
Computer: srv1.contoso.com
Description:

02/26/2019-09:00:04.860 [Error] Transfer error for \\srv1.contoso.com\public\indy.png: (5) Access is denied.
Stack Trace:
at Microsoft.StorageMigration.Proxy.Service.Transfer.FileDirUtils.OpenFile(String fileName, DesiredAccess desiredAccess, ShareMode shareMode, CreationDisposition creationDisposition, FlagsAndAttributes flagsAndAttributes)
at Microsoft.StorageMigration.Proxy.Service.Transfer.FileDirUtils.GetTargetFile(String path)
at Microsoft.StorageMigration.Proxy.Service.Transfer.FileDirUtils.GetTargetFile(FileInfo file)
at Microsoft.StorageMigration.Proxy.Service.Transfer.FileTransfer.InitializeSourceFileInfo()
     at Microsoft.StorageMigration.Proxy.Service.Transfer.FileTransfer.Transfer()
at Microsoft.StorageMigration.Proxy.Service.Transfer.FileTransfer.TryTransfer()
```

This issue is caused by a code defect in the Storage Migration Service where the backup privilege wasn't being invoked.

To resolve this issue, install [Windows Update April 2, 2019—KB4490481 (OS Build 17763.404)](https://support.microsoft.com/help/4490481/windows-10-update-kb4490481) on the orchestrator computer and the destination computer if the proxy service is installed there. Ensure that the source migration user account is a local administrator on the source computer and the Storage Migration Service orchestrator. Ensure that the destination migration user account is a local administrator on the destination computer and the Storage Migration Service orchestrator.

## DFSR hashes mismatch when using Storage Migration Service to preseed data

When using the Storage Migration Service to transfer files to a new destination, then configuring DFS Replication to replicate that data with an existing server through preseeded replication or DFS Replication database cloning, all files experience a hash mismatch and are re-replicated. The data streams, security streams, sizes, and attributes all appear to be perfectly matched after using Storage Migration Service to transfer them. Examining the files with ICACLS or the DFS Replication database cloning debug log reveals:

### Source file

```
  icacls d:\test\Source:

  icacls d:\test\thatcher.png /save out.txt /t thatcher.png
  D:AI(A;;FA;;;BA)(A;;0x1200a9;;;DD)(A;;0x1301bf;;;DU)(A;ID;FA;;;BA)(A;ID;FA;;;SY)(A;ID;0x1200a9;;;BU)
```

### Destination file

```
  icacls d:\test\thatcher.png /save out.txt /t thatcher.png
  D:AI(A;;FA;;;BA)(A;;0x1301bf;;;DU)(A;;0x1200a9;;;DD)(A;ID;FA;;;BA)(A;ID;FA;;;SY)(A;ID;0x1200a9;;;BU)**S:PAINO_ACCESS_CONTROL**
```

### DFSR Debug Log

```
   20190308 10:18:53.116 3948 DBCL  4045 [WARN] DBClone::IDTableImportUpdate Mismatch record was found.

   Local ACL hash:1BCDFE03-A18BCE01-D1AE9859-23A0A5F6
   LastWriteTime:20190308 18:09:44.876
   FileSizeLow:1131654
   FileSizeHigh:0
   Attributes:32

   Clone ACL hash:**DDC4FCE4-DDF329C4-977CED6D-F4D72A5B**
   LastWriteTime:20190308 18:09:44.876
   FileSizeLow:1131654
   FileSizeHigh:0
   Attributes:32
```

This issue is fixed by the [KB4512534](https://support.microsoft.com/help/4512534/windows-10-update-kb4512534) update.

## Error "Couldn't transfer storage on any of the endpoints" when transferring from Windows Server 2008 R2

When attempting to transfer data from a Windows Server 2008 R2 source computer, no data transfers and you receive error:

```
Couldn't transfer storage on any of the endpoints.
0x9044
```

This error is expected if your Windows Server 2008 R2 computer isn't fully patched with all Critical and Important updates from Windows Update. It's especially important to keep a Windows Server 2008 R2 computer updated for security purposes, as that operating system doesn't contain the security improvements of newer versions of Windows Server.

## Error "Couldn't transfer storage on any of the endpoints" and "Check if the source device is online - we couldn't access it."

When attempting to transfer data from a source computer, some or all shares don't transfer, with the error:

```
Couldn't transfer storage on any of the endpoints.
0x9044
```

Examining the SMB transfer details shows error:

```
Check if the source device is online - we couldn't access it.
```

Examining the StorageMigrationService/Admin event log shows:

```
Couldn't transfer storage.

Job: Job1
ID:
State: Failed
Error: 36931
Error Message:

Guidance: Check the detailed error and make sure the transfer requirements are met. The transfer job couldn't transfer any source and destination computers. This could be because the orchestrator computer couldn't reach any source or destination computers, possibly due to a firewall rule, or missing permissions.
```

Examining the StorageMigrationService-Proxy/Debug log shows:

```
07/02/2019-13:35:57.231 [Error] Transfer validation failed. ErrorCode: 40961, Source endpoint is not reachable, or doesn't exist, or source credentials are invalid, or authenticated user doesn't have sufficient permissions to access it.
at Microsoft.StorageMigration.Proxy.Service.Transfer.TransferOperation.Validate()
at Microsoft.StorageMigration.Proxy.Service.Transfer.TransferRequestHandler.ProcessRequest(FileTransferRequest fileTransferRequest, Guid operationId)
```

This was a code defect that would manifest if your migration account doesn't have at least Read permissions to the SMB shares. This issue was first fixed in cumulative update [4520062](https://support.microsoft.com/help/4520062/windows-10-update-kb4520062).

Another possible cause might be insufficient access rights to the source file server. While examining the "Microsoft.StorageMigration.Proxy.Service.exe" process with Process Monitor, you might see the below result:
```
Date: 6/04/2022 15:36:09,1943419
Thread: 1688
Class: File System
Operation: CreateFile
Result: PRIVILEGE_NOT_HELD
Path: \\srv1.contoso.com\F$\\public
Duration: 0.0002573

Desired Access: Read Attributes, Read Control, Synchronize, Access System Security
Disposition: Open
Options: Synchronous IO Non-Alert, Open For Backup
Attributes: N
ShareMode: Read, Write
AllocationSize: n/a
Impersonating: CONTOSO\ServiceAccount
OpenResult: PRIVILEGE_NOT_HELD
```
The actual operation being performed needs the "Open For Backup"-privileges on the source file server. Verify that your user account used to access the source file server is granted the necessary permissions via the following Local Security Policy on this server or using a Group Policy Object:
    `Security Settings > Local Policies > User Rights Assignment > Back up files and directories`

## Error 0x80005000 when running inventory

After installing [KB4512534](https://support.microsoft.com/help/4512534/windows-10-update-kb4512534) and attempting to run inventory, inventory fails with errors:

```
EXCEPTION FROM HRESULT: 0x80005000

Log Name:      Microsoft-Windows-StorageMigrationService/Admin
Source:        Microsoft-Windows-StorageMigrationService
Date:          9/9/2019 5:21:42 PM
Event ID:      2503
Task Category: None
Level:         Error
Keywords:
User:          NETWORK SERVICE
Computer:      FS02.TailwindTraders.net
Description:
Couldn't inventory the computers.
Job: foo2
ID: 20ac3f75-4945-41d1-9a79-d11dbb57798b
State: Failed
Error: 36934
Error Message: Inventory failed for all devices
Guidance: Check the detailed error and make sure the inventory requirements are met. The job couldn't inventory any of the specified source computers. This could be because the orchestrator computer couldn't reach it over the network, possibly due to a firewall rule or missing permissions.

Log Name:      Microsoft-Windows-StorageMigrationService/Admin
Source:        Microsoft-Windows-StorageMigrationService
Date:          9/9/2019 5:21:42 PM
Event ID:      2509
Task Category: None
Level:         Error
Keywords:
User:          NETWORK SERVICE
Computer:      FS02.TailwindTraders.net
Description:
Couldn't inventory a computer.
Job: foo2
Computer: FS01.TailwindTraders.net
State: Failed
Error: -2147463168
Error Message:
Guidance: Check the detailed error and make sure the inventory requirements are met. The inventory couldn't determine any aspects of the specified source computer. This could be because of missing permissions or privileges on the source or a blocked firewall port.

Log Name:      Microsoft-Windows-StorageMigrationService-Proxy/Debug
Source:        Microsoft-Windows-StorageMigrationService-Proxy
Date:          2/14/2020 1:18:21 PM
Event ID:      10000
Task Category: None
Level:         Error
Keywords:
User:          NETWORK SERVICE
Computer:      2019-rtm-orc.ned.contoso.com
Description:
02/14/2020-13:18:21.097 [Erro] Failed device discovery stage SystemInfo with error: (0x80005000) Unknown error (0x80005000)
```

This error is caused by a code defect in Storage Migration Service when you provide migration credentials in the form of a User Principal Name (UPN), such as 'meghan@contoso.com'. The Storage Migration Service orchestrator service fails to parse this format correctly, which leads to a failure in a domain lookup that was added for cluster migration support in KB4512534 and 19H1.

To work around this issue, provide credentials in the domain\user format, such as 'Contoso\Meghan'.

## Error "ServiceError0x9006" or "The proxy isn't currently available." when migrating to a Windows Server failover cluster

When attempting to transfer data against a clustered File Server, you receive errors such as:

```
Make sure the proxy service is installed and running, and then try again. The proxy isn't currently available.
0x9006
ServiceError0x9006,Microsoft.StorageMigration.Commands.UnregisterSmsProxyCommand
```

This error is expected if the File Server resource moved from its original Windows Server 2019 cluster owner node to a new node and the Storage Migration Service Proxy feature wasn't installed on that node.

As a workaround, move the destination File Server resource back to the original owner cluster node that was in use when you first configured transfer pairings.

As an alternative workaround:

1. Install the Storage Migration Service Proxy feature on all nodes in a cluster.
2. Run the following Storage Migration Service PowerShell command on the orchestrator computer:

   ```PowerShell
   Register-SMSProxy -ComputerName <destination server> -Force
   ```

## Error "Dll was not found" when running inventory from a cluster node

When attempting to run inventory with the Storage Migration Service and targeting a Windows Server failover cluster general use file server source, you receive the following errors:

```
DLL not found
[Error] Failed device discovery stage VolumeInfo with error: (0x80131524) Unable to load DLL 'Microsoft.FailoverClusters.FrameworkSupport.dll': The specified module could not be found. (Exception from HRESULT: 0x8007007E)
```

To work around this issue, install the "Failover Cluster Management Tools" (RSAT-Clustering-Mgmt) on the server running the Storage Migration Service orchestrator.

## Error "There are no more endpoints available from the endpoint mapper" when running inventory against a Windows Server 2003 source computer

When attempting to run inventory with the Storage Migration Service orchestrator against a Windows Server 2003 source computer, you receive the following error:

```
There are no more endpoints available from the endpoint mapper
```

This issue is resolved by the [KB4537818](https://support.microsoft.com/help/4537818/windows-10-update-kb4537818) update.

## Uninstalling a cumulative update prevents Storage Migration Service from starting

Uninstalling Windows Server cumulative updates may prevent the Storage Migration Service from starting. To resolve this issue, you can back up and delete the Storage Migration Service database:

1. Open an elevated cmd prompt, where you're a member of Administrators on the Storage Migration Service orchestrator server, and run:

     ```DOS
     TAKEOWN /d y /a /r /f c:\ProgramData\Microsoft\StorageMigrationService

     MD c:\ProgramData\Microsoft\StorageMigrationService\backup

     ICACLS c:\ProgramData\Microsoft\StorageMigrationService\* /grant Administrators:(GA)

     XCOPY c:\ProgramData\Microsoft\StorageMigrationService\* .\backup\*

     DEL c:\ProgramData\Microsoft\StorageMigrationService\* /q

     ICACLS c:\ProgramData\Microsoft\StorageMigrationService  /GRANT networkservice:F /T /C

     ICACLS c:\ProgramData\Microsoft\StorageMigrationService /GRANT networkservice:(GA) /T /C
     ```

2. Start the Storage Migration Service service, which will create a new database.

## Error "CLUSCTL_RESOURCE_NETNAME_REPAIR_VCO failed against netName resource" and Windows Server 2008 R2 cluster cutover fails

When attempting to run cut over of a Windows Server 2008 R2 cluster source, the cut over gets stuck at phase "Renaming the source computer..." and you receive the following error:

```
Log Name:      Microsoft-Windows-StorageMigrationService-Proxy/Debug
Source:        Microsoft-Windows-StorageMigrationService-Proxy
Date:          10/17/2019 6:44:48 PM
Event ID:      10000
Task Category: None
Level:         Error
Keywords:
User:          NETWORK SERVICE
Computer:      WIN-RNS0D0PMPJH.contoso.com
Description:
10/17/2019-18:44:48.727 [Erro] Exception error: 0x1. Message: Control code CLUSCTL_RESOURCE_NETNAME_REPAIR_VCO failed against netName resource 2008r2FS., stackTrace:    at Microsoft.FailoverClusters.Framework.ClusterUtils.NetnameRepairVCO(SafeClusterResourceHandle netNameResourceHandle, String netName)
at Microsoft.FailoverClusters.Framework.ClusterUtils.RenameFSNetName(SafeClusterHandle ClusterHandle, String clusterName, String FsResourceId, String NetNameResourceId, String newDnsName, CancellationToken ct)
at Microsoft.StorageMigration.Proxy.Cutover.CutoverUtils.RenameFSNetName(NetworkCredential networkCredential, Boolean isLocal, String clusterName, String fsResourceId, String nnResourceId, String newDnsName, CancellationToken ct)    [d:\os\src\base\dms\proxy\cutover\cutoverproxy\CutoverUtils.cs::RenameFSNetName::1510]
```

This issue is caused by a missing API in older versions of Windows Server. Currently there's no way to migrate Windows Server 2008 and Windows Server 2003 clusters. You can perform inventory and transfer without issue on Windows Server 2008 R2 clusters, then manually perform cutover by manually changing the cluster's source file server resource netname and IP address, then changing the destination cluster netname and IP address to match the original source.

## Cutover hangs on "38% Mapping network interfaces on the source computer..." when using static IPs

When attempting to run cut over of a source computer, having set the source computer to use a new static (not DHCP) IP address on one or more network interfaces, the cut over gets stuck at phase "38% Mapping network interfaces on the source computer..." and you receive the following error in the Storage Migration Service event log:

```
Log Name:      Microsoft-Windows-StorageMigrationService-Proxy/Admin
Source:        Microsoft-Windows-StorageMigrationService-Proxy
Date:          11/13/2019 3:47:06 PM
Event ID:      20494
Task Category: None
Level:         Error
Keywords:
User:          NETWORK SERVICE
Computer:      orc2019-rtm.corp.contoso.com
Description:
Couldn't set the IP address on the network adapter.

Computer: fs12.corp.contoso.com
Adapter: microsoft hyper-v network adapter
IP address: 10.0.0.99
Network mask: 16
Error: 40970
Error Message: Unknown error (0xa00a)

Guidance: Confirm that the Netlogon service on the computer is reachable through RPC and that the credentials provided are correct.
```

Examining the source computer shows that the original IP address fails to change.

This issue doesn't happen if you selected "Use DHCP" on the Windows Admin Center "configure cutover" screen, only if you specify a new static IP address.

There are two solutions for this issue:

1. This issue was first resolved by the [KB4537818](https://support.microsoft.com/help/4537818/windows-10-update-kb4537818) update. That earlier code defect prevented all use of static IP addresses.

2. If you haven't specified a default gateway IP address on the source computer's network interfaces, this issue occurs even with the KB4537818 update. To work around this issue, set a valid default IP address on the network interfaces using the Network Connections applet (NCPA.CPL) or [Set-NetRoute](/powershell/module/nettcpip/set-netroute) PowerShell cmdlet.

## Slower than expected retransfer performance

After completing a transfer, then running a subsequent retransfer of the same data, you may not see much improvement in transfer time even when little data has changed in the meantime on the source server. 

This issue is resolved by [kb4580390](https://support.microsoft.com/help/4580390/windows-10-update-kb4580390). To tune performance further, review [Optimizing Inventory and Transfer Performance](./faq.yml#optimizing-inventory-and-transfer-performance).

## Slower than expected inventory performance

While inventorying a source server, you find the file inventory taking a long time when there are many files or nested folders. Millions of files and folders may lead to inventories taking many hours even on fast storage configurations. 

This issue is resolved by [kb4580390](https://support.microsoft.com/help/4580390/windows-10-update-kb4580390).

## Data doesn't transfer, user renamed when migrating to or from a domain controller

After starting the transfer from or to a domain controller:

 1. No data is migrated and no shares are created on the destination.
 2. There's a red error symbol shown in Windows Admin Center with no error message
 3. One or more AD users and Domain Local groups have their name and/or pre-Windows 2000 logon attribute changed

 4. You see event 3509 on the Storage Migration Service orchestrator:

    ```
    Log Name:      Microsoft-Windows-StorageMigrationService/Admin
    Source:        Microsoft-Windows-StorageMigrationService
    Date:          1/10/2020 2:53:48 PM
    Event ID:      3509
    Task Category: None
    Level:         Error
    Keywords:
    User:          NETWORK SERVICE
    Computer:      orc2019-rtm.corp.contoso.com
    Description:
    Couldn't transfer storage for a computer.

    Job: dctest3
    Computer: dc02-2019.corp.contoso.com
    Destination Computer: dc03-2019.corp.contoso.com
    State: Failed
    Error: 53251
    Error Message: Local accounts migration failed with error System.Exception: -2147467259
        at Microsoft.StorageMigration.Service.DeviceHelper.MigrateSecurity(IDeviceRecord sourceDeviceRecord, IDeviceRecord destinationDeviceRecord, TransferConfiguration config, Guid proxyId, CancellationToken cancelToken)
    ```

    This is expected behavior if you attempted to migrate from or to a domain controller with Storage Migration Service and used the "migrate users and groups" option to rename or reuse accounts. instead of selecting "Don't transfer users and groups". [DC migration isn't supported with Storage Migration Service](faq.yml#is-domain-controller-migration-supported-). Because a DC doesn't have true local users and groups, Storage Migration Service treats these security principals as it would when migrating between two member servers and attempts to adjust ACLs as instructed, leading to the errors and mangled or copied accounts.

If you have already run transfer one ore more times:

 1. Use the following AD PowerShell command against a DC to locate any modified users or groups (changing SearchBase to match your domain distinguished name):

    ```PowerShell
    Get-ADObject -Filter 'Description -like "*storage migration service renamed*"' -SearchBase 'DC=<domain>,DC=<TLD>' | ft name,distinguishedname
    ```

 2. For any users returned with their original name, edit their "User Logon Name (pre-Windows 2000)" to remove the random character suffix added by Storage Migration Service, so that this user can log on.

 3. For any groups returned with their original name, edit their "Group Name (pre-Windows 2000)" to remove the random character suffix added by Storage Migration Service.

 4. For any disabled users or groups with names that now contain a suffix added by Storage Migration Service, you can delete these accounts. You can confirm that user accounts were added later because they'll only contain the Domain Users group and will have a created date/time matching the Storage Migration Service transfer start time.

    If you wish to use Storage Migration Service with domain controllers for transfer purposes, ensure you always select "Don't transfer users and groups" on the transfer settings page in Windows Admin Center.

## Error 53, "failed to inventory all specified devices" when running inventory,

When attempting to run inventory, you receive:

```
Failed to inventory all specified devices

Log Name:      Microsoft-Windows-StorageMigrationService/Admin
Source:        Microsoft-Windows-StorageMigrationService
Date:          1/16/2020 8:31:17 AM
Event ID:      2516
Task Category: None
Level:         Error
Keywords:
User:          NETWORK SERVICE
Computer:      ned.corp.contoso.com
Description:
Couldn't inventory files on the specified endpoint.
Job: ned1
Computer: ned.corp.contoso.com
Endpoint: hithere
State: Failed
File Count: 0
File Size in KB: 0
Error: 53
Error Message: Endpoint scan failed
Guidance: Check the detailed error and make sure the inventory requirements are met. This could be because of missing permissions on the source computer.

Log Name:      Microsoft-Windows-StorageMigrationService-Proxy/Debug
Source:        Microsoft-Windows-StorageMigrationService-Proxy
Date:          1/16/2020 8:31:17 AM
Event ID:      10004
Task Category: None
Level:         Critical
Keywords:
User:          NETWORK SERVICE
Computer:      ned.corp.contoso.com
Description:
01/16/2020-08:31:17.031 [Crit] Consumer Task failed with error:The network path was not found.
. StackTrace=   at Microsoft.Win32.RegistryKey.Win32ErrorStatic(Int32 errorCode, String str)
    at Microsoft.Win32.RegistryKey.OpenRemoteBaseKey(RegistryHive hKey, String machineName, RegistryView view)
    at Microsoft.StorageMigration.Proxy.Service.Transfer.FileDirUtils.GetEnvironmentPathFolders(String ServerName, Boolean IsServerLocal)
    at Microsoft.StorageMigration.Proxy.Service.Discovery.ScanUtils.<ScanSMBEndpoint>d__3.MoveNext()
    at Microsoft.StorageMigration.Proxy.EndpointScanOperation.Run()
    at Microsoft.StorageMigration.Proxy.Service.Discovery.EndpointScanRequestHandler.ProcessRequest(EndpointScanRequest scanRequest, Guid operationId)
    at Microsoft.StorageMigration.Proxy.Service.Discovery.EndpointScanRequestHandler.ProcessRequest(Object request)
    at Microsoft.StorageMigration.Proxy.Common.ProducerConsumerManager`3.Consume(CancellationToken token)

01/16/2020-08:31:10.015 [Erro] Endpoint Scan failed. Error: (53) The network path was not found.
Stack trace:
    at Microsoft.Win32.RegistryKey.Win32ErrorStatic(Int32 errorCode, String str)
    at Microsoft.Win32.RegistryKey.OpenRemoteBaseKey(RegistryHive hKey, String machineName, RegistryView view)
```

At this stage, Storage Migration Service orchestrator is attempting remote registry reads to determine source machine configuration, but is being rejected by the source server saying the registry path doesn't exist. This can be caused by:

- The Remote Registry service isn't running on the source computer.
- firewall doesn't allow remote registry connections to the source server from the Orchestrator.
- The source migration account doesn't have remote registry permissions to connect to the source computer.
- The source migration account doesn't have read permissions within the registry of the source computer, under "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" or under "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer"

## Cutover hangs on "38% Mapping network interfaces on the source computer..."

When attempting to run cut over of a source computer, the cut over gets stuck at phase "38% Mapping network interfaces on the source computer..." and you receive the following error in the Storage Migration Service event log:

```
Log Name:      Microsoft-Windows-StorageMigrationService-Proxy/Admin
Source:        Microsoft-Windows-StorageMigrationService-Proxy
Date:          1/11/2020 8:51:14 AM
Event ID:      20505
Task Category: None
Level:         Error
Keywords:
User:          NETWORK SERVICE
Computer:      nedwardo.contosocom
Description:
Couldn't establish a CIM session with the computer.

Computer: 172.16.10.37
User Name: nedwardo\MsftSmsStorMigratSvc
Error: 40970
Error Message: Unknown error (0xa00a)

Guidance: Confirm that the Netlogon service on the computer is reachable through RPC and that the credentials provided are correct.
```

This issue is caused by Group Policy that sets the following registry value on the source computer: "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\LocalAccountTokenFilterPolicy = 0"

This setting isn't part of standard Group Policy, it's an add-on configured using the [Microsoft Security Compliance Toolkit](https://www.microsoft.com/download/details.aspx?id=55319):

- Windows Server 2012 R2: "Computer Configuration\Administrative Templates\SCM: Pass the Hash Mitigations\Apply UAC restrictions to local accounts on network logons"

- Widows Server 2016: "Computer Configuration\Administrative Templates\MS Security Guide\Apply UAC restrictions to local accounts on network logons"

It can also be set using Group Policy Preferences with a custom registry setting. You can use the GPRESULT tool to determine which policy is applying this setting to the source computer.

The Storage Migration Service temporarily enables the [LocalAccountTokenFilterPolicy](https://support.microsoft.com/help/951016/description-of-user-account-control-and-remote-restrictions-in-windows) as part of the cut over process, then removes it when done. When Group Policy applies a conflicting Group Policy Object (GPO), it overrides the Storage Migration Service and prevents cut over.

To work around this issue, use one of the following options:

1. Temporarily move the source computer from the Active Directory OU that applies this conflicting GPO.
2. Temporarily disable the GPO that applies this conflicting policy.
3. Temporarily create a new GPO that sets this setting to Disabled and applies to specific OU of source servers, with a higher precedence than any other GPOs.

## Inventory or transfer fail when using credentials from a different domain

When attempting to run inventory or transfer with the Storage Migration Service and targeting a Windows Server while using migration credentials from a different domain than the targeted server, you receive the following errors

```
Exception from HRESULT:0x80131505

The server was unable to process the request due to an internal error

04/28/2020-11:31:01.169 [Error] Failed device discovery stage SystemInfo with error: (0x490) Could not find computer object 'myserver' in Active Directory    [d:\os\src\base\dms\proxy\discovery\discoveryproxy\DeviceDiscoveryOperation.cs::TryStage::1042]
```

Examining the logs further shows that the migration account and the server being migrated from or two are in different domains:

```
06/25/2020-10:11:16.543 [Info] Creating new job=NedJob user=**CONTOSO**\ned
[d:\os\src\base\dms\service\StorageMigrationService.IInventory.cs::CreateJob::133]
```

```
GetOsVersion(fileserver75.**corp**.contoso.com)    [d:\os\src\base\dms\proxy\common\proxycommon\CimSessionHelper.cs::GetOsVersion::66] 06/25/2020-10:20:45.368 [Info] Computer 'fileserver75.corp.contoso.com': OS version
```

This issue is caused by a code defect in the Storage Migration Service. To work around this issue, use migration credentials from the same domain that the source and destination computer belong to. For instance, if the source and destination computer belong to the "corp.contoso.com" domain in the "contoso.com" forest, use 'corp\myaccount' to perform the migration, not a 'contoso\myaccount' credential.

## Inventory fails with "Element not found"

Consider the following scenario:

You have a source server with a DNS Host Name and Active Directory name more than 15 unicode characters, such as "iamaverylongcomputername". By design, Windows didn't let you set the legacy NetBIOS name to be set this long and warned when the server was named that the NetBIOS name would be truncated to 15 unicode wide characters (example: "iamaverylongcom"). When you attempt to inventory this computer, you receive in Windows Admin Center and the event log:

```DOS
"Element not found"
========================

Log Name:      Microsoft-Windows-StorageMigrationService/Admin
Source:        Microsoft-Windows-StorageMigrationService
Date:          4/10/2020 10:49:19 AM
Event ID:      2509
Task Category: None
Level:         Error
Keywords:
User:          NETWORK SERVICE
Computer:      WIN-6PJAG3DHPLF.corp.contoso.com
Description:
Couldn't inventory a computer.

Job: longnametest
Computer: iamaverylongcomputername.corp.contoso.com
State: Failed
Error: 1168
Error Message:

Guidance: Check the detailed error and make sure the inventory requirements are met. The inventory couldn't determine any aspects of the specified source computer. This could be because of missing permissions or privileges on the source or a blocked firewall port.
```

This issue is caused by a code defect in the Storage Migration Service. The only workaround currently is to rename the computer to have the same name as the NetBIOS name, then use [NETDOM COMPUTERNAME /ADD](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc835082(v=ws.11)) to add an alternate computer name that contains the longer name that was in use prior to starting Inventory. Storage Migration Service supports migrating alternate computer names.

## Storage Migration Service inventory fails with "a parameter can't be found that matches parameter name 'IncludeDFSN'" 

When using the 2009 version of Windows Admin Center to manage a Windows Server 2019 orchestrator, you receive the following error when you attempt to inventory a source computer:

```
Remote exception : a parameter cannot be found that matches parameter name 'IncludeDFSN'" 
```

To resolve, update the Storage Migration Service extension to at least version 1.113.0 in Windows Admin Center. The update should automatically appear in the feed and prompt for installation.

## Storage Migration Service transfer validation returns 'Error HRESULT E_FAIL has been returned from a call to a COM component'

After installing the Windows Server 2019 November cumulative update [KB4586793](https://support.microsoft.com/office/november-10-2020%E2%80%94kb4586793-os-build-17763-1577-e6a24f90-5659-8b80-5a50-8752de3d90b7), some transfer validations may fail with:

```
Error HRESULT E_FAIL has been returned from a call to a COM component
```

It doesn't necessarily happen for all source computers. We're working to diagnose this issue. As a workaround, install the 1.115 or later Storage Migration Service tool in Windows Admin Center. The update should automatically appear in the Windows Admin Center feed and prompt for installation, and will allow you to ignore this error. To work around it:

1. Navigate to the "Adjust Settings" step of the Transfer phase.
2. Enable "Override Transfer Validation".
3. Proceed with your transfer, either without running "Validate" or running it and ignoring the E_FAIL error.

> [!IMPORTANT]
> Don't uninstall [KB4586793](https://support.microsoft.com/office/november-10-2020%E2%80%94kb4586793-os-build-17763-1577-e6a24f90-5659-8b80-5a50-8752de3d90b7). This update upgrades the Storage Migration Service database and removing the update will require you to delete your database.

## Transfer fails with "Failed to get file handle" and one or no shares transfer from a particular volume

When you attempt to transfer data from a source computer, you find that no files for a particular volume transfer even though they do transfer for other volumes. You receive the following errors in Windows Admin Center and the event log:

```
"Couldn't transfer storage on any of the endpoints"

========================

SMS Admin log:
06/11/2021 08:44:17  3515 Error Couldn't transfer all of the files in the endpoint on the computer.

Job: test1
Computer: nedsrv1.corp.contoso.com
Destination Computer: nedsrv2.corp.contoso.com
Endpoint: foo
State: Failed
Source File Count: 0
Source File Size in KB: 0
Succeeded File Count: 0
Succeeded File Size in KB: 0
New File Count: 0
New File Size in KB: 0
Failed File Count: 0
Error: -2146233088
Error Message: 

Guidance: Check the detailed error and make sure the transfer requirements are met. This could be because the orchestrator computer couldn't reach a source or destination computer, possibly due to a firewall rule, or missing permissions.

========================

```
If you dump the SMS debug logs using the [Get-SMSLogs](https://aka.ms/smslogs) command, you also see:

```
SMS Debug log:

06/11/2021-08:44:17.236 [Erro] End file transfer failed with -2146233088 exception:ErrorCode: -2146233088, Transfer failed
    at Microsoft.StorageMigration.Service.EndpointHelper.TransferFiles(String source, String destination, String sourceOSVersion, IEndpointRecord endpointRecord, TransferConfiguration config, String sourcePath, String destinationPath, ProxyInformation transferProxyInformation, Int64& skippedSystemObjectCount, CancellationToken cancelToken, SourceType sourceType, Protocol protocol, String sourceClusterSharedVolumesRoot, String targetClusterSharedVolumesRoot, ServerType sourceServerType, ServerType targetServerType, Boolean isTieredAFSEnabled, Int32 volumeMinimumFreeSpace, String targetVolume, String[] mountedVolumes)    [d:\os\src\base\dms\service\OperationManager\EndpointHelper.cs::TransferFiles::510]

SMS Proxy Debug log:

14090 06/11/2021-08:44:17.123 [Crit] Failed to create root of the share \\nedsrv1.corp.contoso.com\D$ with error -2147467259 and message Failed to get file handle    [d:\os\src\base\dms\proxy\transfer\transferproxy\stages\DirectoryEnumerationStage.cs::ProcessItem::112]
14091 06/11/2021-08:44:17.124 [Erro] Stage DirectoryEnumerationStage cancelled. Received error: Failed to get file handle    [d:\os\src\base\dms\proxy\transfer\transferproxy\stages\StageBase.cs::DoStage::50]
14124 06/11/2021-08:44:17.141 [Erro] Failed pipeline execution. System.AggregateException: One or more errors occurred. ---> System.ComponentModel.Win32Exception: Failed to get file handle 
14125    at Microsoft.StorageMigration.Proxy.Service.Transfer.DirectoryEnumerationStage.ProcessItem(DirEnumResultWithParent input)
14126    at Microsoft.StorageMigration.Proxy.Service.Transfer.StageBase`3.DoStage(CancellationTokenSource cts)
14127    at System.Threading.Tasks.Task.Execute()
14128    --- End of inner exception stack trace ---
14129    at System.Threading.Tasks.Task.WaitAll(Task[] tasks, Int32 millisecondsTimeout, CancellationToken cancellationToken)
14130    at Microsoft.StorageMigration.Proxy.Service.Transfer.Pipeline.Run(CancellationToken token)
14131    at Microsoft.StorageMigration.Proxy.Service.Transfer.TransferOperation.Run()
14132    at Microsoft.StorageMigration.Proxy.Service.Transfer.TransferRequestHandler.ProcessRequest(FileTransferRequest fileTransferRequest, Guid operationId)
14133 ---> (Inner Exception #0) System.ComponentModel.Win32Exception (0x80004005): Failed to get file handle
14134    at Microsoft.StorageMigration.Proxy.Service.Transfer.DirectoryEnumerationStage.ProcessItem(DirEnumResultWithParent input)
14135    at Microsoft.StorageMigration.Proxy.Service.Transfer.StageBase`3.DoStage(CancellationTokenSource cts)
14136    at System.Threading.Tasks.Task.Execute()<---
14137     [d:\os\src\base\dms\proxy\transfer\transferproxy\TransferRequestHandler.cs::ProcessRequest::132]

```

This issue is caused by a limitation in the Storage Migration Service Proxy service when an entire NTFS volume has been configured with the Compression flag. To work around this issue, remove the compression flag from the destination volume:

1. Open File Explorer, right-click the destination drive letter, and select **Properties**.
2. Uncheck "Compress this drive to save disk space"
3. Rerun the transfer.

Alternatively, you can perform the same steps on the source computer if its volume was compressed and if it has free space to hold the expanded files. NTFS-compressed files are always decompressed while copying or moving, compressing them doesn't reduce transfer time.

## An error requires resetting the Storage Migration Service database

Under rare circumstances you may need to reset the Storage Migration Service database. To do this:

1. Open an elevated cmd prompt, where you're a member of Administrators on the Storage Migration Service orchestrator server, and run:

     ```CMD
     NET STOP SMS
     NET STOP SMSPROXY
     
     TAKEOWN /d y /a /r /f c:\ProgramData\Microsoft\StorageMigrationService

     MD c:\ProgramData\Microsoft\StorageMigrationService\backup

     ICACLS c:\ProgramData\Microsoft\StorageMigrationService\* /grant Administrators:(GA)

     XCOPY c:\ProgramData\Microsoft\StorageMigrationService\* .\backup\*

     DEL c:\ProgramData\Microsoft\StorageMigrationService\* /q

     ICACLS c:\ProgramData\Microsoft\StorageMigrationService  /GRANT networkservice:F /T /C

     ICACLS c:\ProgramData\Microsoft\StorageMigrationService /GRANT networkservice:(GA) /T /C
     ```

2. Validate that there were no errors in the above commands. Then start the Storage Migration Service service, which will create a new database.

     ```CMD
     NET START SMS
     NET START SMSPROXY

## Transfers halts with error: Unable to translate Unicode character 

A running transfer halts. You receive event log error:

```
Log Name:      Microsoft-Windows-StorageMigrationService/Admin
Source:        Microsoft-Windows-StorageMigrationService
Date:          
Event ID:      3515
Task Category: None
Level:         Error
Keywords:      
User:          NETWORK SERVICE
Computer:      
Description:
Couldn't transfer all of the files in the endpoint on the computer.
Job: 
Computer: 
Destination Computer:
Endpoint:
State: Failed
Source File Count: 833617
Source File Size in KB: 45919696
Succeeded File Count: 833438
Succeeded File Size in KB: 45919696
New File Count: 0
New File Size in KB: 0
Failed File Count: 179
Error: -2146233087
Error Message: The socket connection was aborted. This could be caused by an error processing your message or a receive timeout being exceeded by the remote host, or an underlying network resource issue. Local socket timeout was '00:00:59.9970000'.
```

Examining the [Storage Migration Service debug log](https://aka.ms/smslogs) shows:

```
03. 07. 2023-23:28:08.647 [Erro] ExceptionMessage : (Unable to translate Unicode character \uDB71 at index 1 to specified code page.), ExceptionToString: (System.Text.EncoderFallbackException: Unable to translate Unicode character \uDB71 at index 1 to specified code page.
```

This issue is caused by an unhandled unicode character that the Storage Migration Service can't translate. To locate the name of the file(s) with the invalid character, edit the following sample PowerShell script and run it on the source computer, then examine the results and rename or remove the files:

```
# Sample PowerShell script to find files with unhandled unicode characters

$FolderPath = "C:\temp"
$OutputFilePath = "C:\temp\invalid_char_results.txt"
$UnhandledChar = "\uDB71"

Get-ChildItem -path $FolderPath -Recurse | ForEach-Object {
 if ($_ -is [System.IO.FileInfo]) {
  if ($_.Name -match $UnhandledChar) {
   Add-Content $outputFilePath "$($_.FullName)"
  }
 }
}
```

## Cut over fails at 77% or 30%

When you're performing cut over, the operation hangs at "77% - adding the destination computer to the domain" or "30% - Can't unjoin domain." The issue only happens when:

- A user who isn't a member of a built-in admin group in AD created the source or destination computer account in Active Directory.

    Or

- The migration user account isn't the same user who created the source computer account.

Windows updates released on and after October 11, 2022 contain extra protections to address [CVE-2022-38042](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2022-38042), these extra protections caused the issue. The protections were further updated with the March 14, 2023 monthly cumulative update, adding a workaround option for this issue. The protections intentionally prevent domain join operations from reusing an existing computer account in the target domain unless:

- The user attempting the operation is the creator of the existing account.

- The user attempting the operation is a member of Active Directory built-in groups Domain Administrators, Enterprise Administrators or Administrators created the computer account.

- The user attempting the operation is a member of the "Domain controller: Allow computer account reuse during domain join." Group Policy setting for the computer account.

To resolve this issue, use one of the following solutions.

### Solution 1 - Use "Allow computer account re-use during domain join"

1. Ensure all domain controllers, the source computer, destination computer, and SMS migration computer have installed the March 14, 2023 cumulative update and have been rebooted.
1. Follow the steps in detailed in the Take Action section of [KB5020276](https://support.microsoft.com/topic/kb5020276-netjoin-domain-join-hardening-changes-2b65a0f3-1f4c-42ef-ac0f-1caaf421baf8#bkmk_take_action).
1. In Windows Admin Center, go to **Server Manager > Storage Migration Service**, create or continue an existing job.
1. On the **Cut over to the new servers > Adjust Settings** page, ensure the account used for *AD Credentials* is the same account that was allowed to reuse computer accounts in step 2."

### Solution 2 - Use the original account for migration

1. In Windows Admin Center, go to **Server Manager > Storage Migration Service**, create or continue an existing job.
1. On the **Cut over to the new servers > Adjust Settings** page, ensure the account used for *AD Credentials* is the same account that created or joined the source and destination computer to the domain.

### Solution 3 (not recommended) - Use a high-privilege group

1. In Windows Admin Center, go to **Server Manager > Storage Migration Service**, create or continue an existing job.
1. On the **Cut over to the new servers > Adjust Settings** page, ensure the account used for *AD Credentials* is a member of one of the high-privilege Active Directory built-in groups Domain Administrators, Enterprise Administrators or Administrators.

> [!IMPORTANT]
> If you have followed Solution 1 and the unjoin operation fails "33% - can't unjoin domain" with error 0x6D1 "The procedure is out of range", the March 14, 2024 cumulative update has not been installed on the source computer, or it was installed but the computer was not restarted.

## Cut over fails for Windows Server 2008 R2

When you're performing cut over from a source computer running Windows Server 2008 R2 or older, you
receive the error "Couldn’t rename the computer from the domain." Using the Storage Migration
Service Helper [Get-SmsLog](https://aka.ms/smslogs) command shows error `0x6D1` and "Object
reference not set to an instance of an object". The following example is the log file output from
the PowerShell `Get-SmsLog` command.

```Log
Line 360: 04/02/2023-14:06:02.877 [Info] UnjoinDomain(isLocal=False, server='2008R2.corp.contoso.com')    [d:\os\src\base\dms\proxy\cutover\cutoverproxy\CutoverUtils.cs::UnjoinDomain::2151]
Line 361: 04/02/2023-14:06:02.948 [Erro] Attempt #1 failed to unjoin machine '2008R2.corp.contoso' from the domain with credential 'corp\ned'. Error 0x6D1.    [d:\os\src\base\dms\proxy\cutover\cutoverproxy\CutoverUtils.cs::UnjoinDomain::2184]
Line 362: 04/02/2023-14:06:02.954 [Erro] Fatal exception during cutover stage processing. Source: 2008R2.corp.contoso.com, CutoverStage: UnjoinSource, ErrorCode: 0x80004003, Message: Object reference not set to an instance of an object.    [d:\os\src\base\dms\proxy\cutover\cutoverproxy\CutoverOperation.cs::Run::1116]
```

Changes introduced in [KB5020276](https://support.microsoft.com/topic/kb5020276-netjoin-domain-join-hardening-changes-2b65a0f3-1f4c-42ef-ac0f-1caaf421baf8) to combat [CVE-2022-38042](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2022-38042) cause this error.

To resolve this issue, use one of the following solutions.

### Solution 1 (using Windows Server 2008 R2 with valid ESU)

For a source computer running Windows Server 2008 R2 with valid
[Extended Support Updates](../../get-started/extended-security-updates-overview.md), first install
the latest cumulative update. Once the cumulative update has been successfully installed, follow the
steps detailed in the article
[Cut over fails at 77% or 30%](#cut-over-fails-at-77-or-30)
to resolve the issue.

### Solution 2 (using Windows Server 2008 R2 without a valid ESU, Windows Server 2008 or Windows Server 2003)

If your source computer is running Windows Server 2008 R2 without ESU, Windows Server 2008 or
Windows Server 2003, you need to perform a manual cutover using the steps described in
[How cutover works in Storage Migration Service](cutover.md), but with the following changes.

1. Skip steps 3 and 4
1. For step 5, you must sign in to the computer and remove it from the domain manually using
   `SYSDM.CPL`, `NETDOM.exe`, or the `Remove-Compuer` PowerShell command. You can't remotely remove
   the computer from the domain after
   [KB5020276](https://support.microsoft.com/topic/kb5020276-netjoin-domain-join-hardening-changes-2b65a0f3-1f4c-42ef-ac0f-1caaf421baf8).

## Transfer validation warning "The destination proxy wasn't found"

If you didn't already have the SMS Proxy service installed on the destination server before starting the transfer, Windows Admin Center installs it automatically. But under certain circumstances it fails to register and display validation error "The destination proxy wasn't found".

To resolve this issue, ensure the SMS Proxy service feature is installed on the destination server, then run the following PowerShell command on the Orchestrator server:

```powershell
Register-SMSProxy -ComputerName <destination server FQDN> -Force
```

Validation now passes.

## See also

- [Storage Migration Service overview](overview.md)
