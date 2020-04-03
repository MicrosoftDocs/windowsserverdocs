---
title: Storage Migration Service known issues
description: Known issues and troubleshooting support for Storage Migration Service, such as how to collect logs for Microsoft Support.
author: nedpyle
ms.author: nedpyle
manager: tiaascs
ms.date: 02/10/2020
ms.topic: article
ms.prod: windows-server
ms.technology: storage
---
# Storage Migration Service known issues

This topic contains answers to known issues when using [Storage Migration Service](overview.md) to migrate servers.

Storage Migration Service is released in two parts: the service in Windows Server, and the user interface in Windows Admin Center. The service is available in Windows Server, Long-Term Servicing Channel, as well as Windows Server, Semi-Annual Channel; while Windows Admin Center is available as a separate download. We also periodically include changes in cumulative updates for Windows Server, released via Windows Update. 

For example, Windows Server, version 1903 includes new features and fixes for Storage Migration Service, which are also available for Windows Server 2019 and Windows Server, version 1809 by installing [KB4512534](https://support.microsoft.com/help/4512534/windows-10-update-kb4512534).

## <a name="collecting-logs"></a> How to collect log files when working with Microsoft Support

The Storage Migration Service contains event logs for the Orchestrator service and the Proxy Service. The orchestrator server always contains both event logs, and destination servers with the proxy service installed contain the proxy logs. These logs are located under:

- Application and Services Logs \ Microsoft \ Windows \ StorageMigrationService
- Application and Services Logs \ Microsoft \ Windows \ StorageMigrationService-Proxy

If you need to gather these logs for offline viewing or to send to Microsoft Support, there is an open source PowerShell script available on GitHub:

 [Storage Migration Service Helper](https://aka.ms/smslogs) 

Review the README for usage.

## Storage Migration Service doesn't show up in Windows Admin Center unless managing Windows Server 2019

When using the 1809 version of Windows Admin Center to manage a Windows Server 2019 orchestrator, you don't see the tool option for Storage Migration Service. 

The Windows Admin Center Storage Migration Service extension is version-bound to only manage Windows Server 2019 version 1809 or later operating systems. If you use it to manage older Windows Server operating systems or insider previews, the tool will not appear. This behavior is by design. 

To resolve, use or upgrade to Windows Server 2019 build 1809 or later.

## Storage Migration Service cutover validation fails with error "Access is denied for the token filter policy on destination computer"

When running cutover validation, you receive error "Fail: Access is denied for the token filter policy on destination computer." This occurs even if you provided correct local administrator credentials for both the source and destination computers.

This issue was fixed in the [KB4512534](https://support.microsoft.com/help/4512534/windows-10-update-kb4512534) update. 

## Storage Migration Service isn't included in Windows Server 2019 Evaluation or Windows Server 2019 Essentials edition

When using Windows Admin Center to connect to a [Windows Server 2019 Evaluation release](https://www.microsoft.com/evalcenter/evaluate-windows-server-2019) or Windows Server 2019 Essentials edition, there isn't an option to manage the Storage Migration Service. Storage Migration Service also isn't included in Roles and Features.

This issue is caused by a servicing issue in the Evaluation media of Windows Server 2019 and Windows Server 2019 Essentials. 

To work around this issue for evaluation, install a retail, MSDN, OEM, or Volume License version of Windows Server 2019 and don't activate it. Without activation, all editions of Windows Server operate in evaluation mode for 180 days. 

We have fixed this issue in a later release of Windows Server.  

## Storage Migration Service times out downloading the transfer error CSV

When using Windows Admin Center or PowerShell to download the transfer operations detailed errors-only CSV log, you receive error:

 >   Transfer Log - Please check file sharing is allowed in your firewall. : This request operation sent to net.tcp://localhost:28940/sms/service/1/transfer did not receive a reply within the configured timeout (00:01:00). The time allotted to this operation may have been a portion of a longer timeout. This may be because the service is still processing the operation or because the service was unable to send a reply message. Please consider increasing the operation timeout (by casting the channel/proxy to IContextChannel and setting the OperationTimeout property) and ensure that the service is able to connect to the client.

This issue is caused by an extremely large number of transferred files that cannot be filtered in the default one minute timeout allowed by Storage Migration Service. 

To work around this issue:

1. On the orchestrator computer, edit the *%SYSTEMROOT%\SMS\Microsoft.StorageMigration.Service.exe.config* file using Notepad.exe to change the "sendTimeout" from its 1 minute default to 10 minutes

   ```
     <bindings>
      <netTcpBinding>
        <binding name="NetTcpBindingSms"
                 sendTimeout="00:01:00"
   ```

2. Restart the "Storage Migration Service" service on the orchestrator computer. 
3. On the orchestrator computer, start Regedit.exe
4. Locate and then click the following registry subkey: 

   `HKEY_LOCAL_MACHINE\Software\Microsoft\SMSPowershell`

5. On the Edit menu, point to New, and then click DWORD Value. 
6. Type "WcfOperationTimeoutInMinutes" for the name of the DWORD, and then press ENTER.
7. Right-click "WcfOperationTimeoutInMinutes", and then click Modify. 
8. In the Base data box, click "Decimal"
9. In the Value data box, type "10", and then click OK.
10. Exit Registry Editor.
11. Attempt to download the errors-only CSV file again. 

We intend to change this behavior in a later release of Windows Server 2019.  

## Validation warnings for destination proxy and credential administrative privileges

When validating a transfer job, you see the following warnings:

 > **The credential has administrative privileges.**
 > Warning: Action isn't available remotely.
 > **The destination proxy is registered.**
 > Warning: The destination proxy wasn't found.

If you have not installed the Storage Migration Service Proxy service on the Windows Server 2019 destination computer, or the destination computer is Windows Server 2016 or Windows Server 2012 R2, this behavior is by design. We recommend migrating to a Windows Server 2019 computer with the proxy installed for significantly improved transfer performance.  

## Certain files do not inventory or transfer, error 5 "Access is denied"

When inventorying or transferring files from source to destination computers, files from which a user has removed Administrators group permissions fail to migrate. Examining the Storage Migration Service-Proxy debug shows:

    Log Name:      Microsoft-Windows-StorageMigrationService-Proxy/Debug
    Source:        Microsoft-Windows-StorageMigrationService-Proxy
    Date:          2/26/2019 9:00:04 AM
    Event ID:      10000
    Task Category: None
    Level:         Error
    Keywords:      
    User:          NETWORK SERVICE
    Computer:      srv1.contoso.com
    Description:

    02/26/2019-09:00:04.860 [Error] Transfer error for \\srv1.contoso.com\public\indy.png: (5) Access is denied.
    Stack Trace:
     at Microsoft.StorageMigration.Proxy.Service.Transfer.FileDirUtils.OpenFile(String fileName, DesiredAccess desiredAccess, ShareMode shareMode, CreationDisposition creationDisposition, FlagsAndAttributes flagsAndAttributes)
     at Microsoft.StorageMigration.Proxy.Service.Transfer.FileDirUtils.GetTargetFile(String path)
     at Microsoft.StorageMigration.Proxy.Service.Transfer.FileDirUtils.GetTargetFile(FileInfo file)
     at Microsoft.StorageMigration.Proxy.Service.Transfer.FileTransfer.InitializeSourceFileInfo()
     at Microsoft.StorageMigration.Proxy.Service.Transfer.FileTransfer.Transfer()
     at Microsoft.StorageMigration.Proxy.Service.Transfer.FileTransfer.TryTransfer()   

This issue is caused by a code defect in the Storage Migration Service where the backup privilege was not being invoked. 

To resolve this issue, install [Windows Update April 2, 2019—KB4490481 (OS Build 17763.404)](https://support.microsoft.com/help/4490481/windows-10-update-kb4490481) on the orchestrator computer and the destination computer if the proxy service is installed there. Ensure that the source migration user account is a local administrator on the source computer and the Storage Migration Service orchestrator. Ensure that the destination migration user account is a local administrator on the destination computer and the Storage Migration Service orchestrator. 

## DFSR hashes mismatch when using Storage Migration Service to preseed data

When using the Storage Migration Service to transfer files to a new destination, then configuring the DFS Replication (DFSR) to replicate that data with an existing DFSR server through preseeded replication or DFSR database cloning, all files experience a hash mismatch and are re-replicated. The data streams, security streams, sizes, and attributes all appear to be perfectly matched after using SMS to transfer them. Examining the files with ICACLS or the DFSR Database cloning debug log reveals:

Source file:

  icacls d:\test\Source:

  icacls d:\test\thatcher.png /save out.txt /t
  thatcher.png
  D:AI(A;;FA;;;BA)(A;;0x1200a9;;;DD)(A;;0x1301bf;;;DU)(A;ID;FA;;;BA)(A;ID;FA;;;SY)(A;ID;0x1200a9;;;BU)

Destination file:

  icacls d:\test\thatcher.png /save out.txt /t
  thatcher.png
  D:AI(A;;FA;;;BA)(A;;0x1301bf;;;DU)(A;;0x1200a9;;;DD)(A;ID;FA;;;BA)(A;ID;FA;;;SY)(A;ID;0x1200a9;;;BU)**S:PAINO_ACCESS_CONTROL**

DFSR Debug Log:

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

This issue is fixed by the [KB4512534](https://support.microsoft.com/help/4512534/windows-10-update-kb4512534) update

## Error "Couldn't transfer storage on any of the endpoints" when transferring from Windows Server 2008 R2

When attempting to transfer data from a Windows Server 2008 R2 source computer, no data transfers and you receive error:  

    Couldn't transfer storage on any of the endpoints.
    0x9044

This error is expected if your Windows Server 2008 R2 computer isn't fully patched with all Critical and Important updates from Windows Update. Irrespective of Storage Migration Service, we always recommend patching a Windows Server 2008 R2 computer for security purposes, as that operating system doesn't contain the security improvements of newer versions of Windows Server.

## Error "Couldn't transfer storage on any of the endpoints" and "Check if the source device is online - we couldn't access it."

When attempting to transfer data from a source computer, some or all shares do not transfer, with summary error:

    Couldn't transfer storage on any of the endpoints.
    0x9044

Examining the SMB transfer details shows error:

    Check if the source device is online - we couldn't access it.

Examining the StorageMigrationService/Admin event log shows:

    Couldn't transfer storage.

    Job: Job1
    ID:  
    State: Failed
    Error: 36931
    Error Message: 

   Guidance: Check the detailed error and make sure the transfer requirements are met. The transfer job couldn't transfer any source and destination computers. This could be because the orchestrator computer couldn't reach any source or destination computers, possibly due to a firewall rule, or missing permissions.

Examining the StorageMigrationService-Proxy/Debug log shows:

    07/02/2019-13:35:57.231 [Error] Transfer validation failed. ErrorCode: 40961, Source endpoint is not reachable, or doesn't exist, or source credentials are invalid, or authenticated user doesn't have sufficient permissions to access it.
    at Microsoft.StorageMigration.Proxy.Service.Transfer.TransferOperation.Validate()
    at Microsoft.StorageMigration.Proxy.Service.Transfer.TransferRequestHandler.ProcessRequest(FileTransferRequest fileTransferRequest, Guid operationId)    

This was a code defect that would manifest if your migration account does not have at least Read permissions to the SMB shares. This issue was first fixed in cumulative update [4520062](https://support.microsoft.com/help/4520062/windows-10-update-kb4520062). 

## Error 0x80005000 when running inventory

After installing [KB4512534](https://support.microsoft.com/help/4512534/windows-10-update-kb4512534) and attempting to run inventory, inventory fails with errors:

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
  
This error is caused by a code defect in Storage Migration Service when you provide migration credentials in the form of a User Principal Name (UPN), such as 'meghan@contoso.com'. The Storage Migration Service orchestrator service fails to parse this format correctly, which leads to a failure in a domain lookup that was added for cluster migration support in KB4512534 and 19H1.

To workaround this issue, provide credentials in the domain\user format, such as 'Contoso\Meghan'.

## Error "ServiceError0x9006" or "The proxy isn't currently available." when migrating to a Windows Server failover cluster

When attempting to transfer data against a clustered File Server, you receive errors such as: 

    Make sure the proxy service is installed and running, and then try again. The proxy isn't currently available.
    0x9006
    ServiceError0x9006,Microsoft.StorageMigration.Commands.UnregisterSmsProxyCommand

This error is expected if the File Server resource moved from its original Windows Server 2019 cluster owner node to a new node and the Storage Migration Service Proxy feature wasn't installed on that node.

As a workaround, move the destination File Server resource back to the original owner cluster node that was in use when you first configured transfer pairings.

As an alternative workaround:

1. Install the Storage Migration Service Proxy feature on all nodes in a cluster.
2. Run the following Storage Migration Service PowerShell command on the orchestrator computer: 

   ```PowerShell
   Register-SMSProxy -ComputerName *destination server* -Force
   ```
## Error "Dll was not found" when running inventory from a cluster node

When attempting to run inventory with the Storage Migration Service and targeting a Windows Server failover cluster general use file server source, you receive the following errors:

    DLL not found
    [Error] Failed device discovery stage VolumeInfo with error: (0x80131524) Unable to load DLL 'Microsoft.FailoverClusters.FrameworkSupport.dll': The specified module could not be found. (Exception from HRESULT: 0x8007007E)   

To workaround this issue, install the "Failover Cluster Management Tools" (RSAT-Clustering-Mgmt) on the server running the Storage Migration Service orchestrator. 

## Error "There are no more endpoints available from the endpoint mapper" when running inventory against a Windows Server 2003 source computer

When attempting to run inventory with the Storage Migration Service orchestrator against a Windows Server 2003 source computer, you receive the following error:

    There are no more endpoints available from the endpoint mapper  

This issue is resolved by the [KB4537818](https://support.microsoft.com/help/4537818/windows-10-update-kb4537818) update.

## Uninstalling a cumulutative update prevents Storage Migration Service from starting

Uninstalling Windows Server cumulative updates may prevent the Storage Migration Service from starting. To resolve this issue, you can backup and delete the Storage Migration Service database:

1.	Open an elevated cmd prompt, where you are a member of Administrators on the Storage Migration Service orchestrator server, and run:

     ```
     TAKEOWN /d y /a /r /f c:\ProgramData\Microsoft\StorageMigrationService
     
     MD c:\ProgramData\Microsoft\StorageMigrationService\backup

     ICACLS c:\ProgramData\Microsoft\StorageMigrationService\* /grant Administrators:(GA)

     XCOPY c:\ProgramData\Microsoft\StorageMigrationService\* .\backup\*

     DEL c:\ProgramData\Microsoft\StorageMigrationService\* /q

     ICACLS c:\ProgramData\Microsoft\StorageMigrationService  /GRANT networkservice:F /T /C

     ICACLS c:\ProgramData\Microsoft\StorageMigrationService /GRANT networkservice:(GA) /T /C
     ```
   
2.	Start the Storage Migration Service service, which will create a new database.

## Error "CLUSCTL_RESOURCE_NETNAME_REPAIR_VCO failed against netName resource" and Windows Server 2008 R2 cluster cutover fails

When attempting to run cut over of a Windows Server 2008 R2 cluster source, the cut over gets stuck at phase "Renaming the source computer..." and you receive the following error:

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

This issue is caused by a missing API in older versions of Windows Server. Currently there is no way to migrate Windows Server 2008 and Windows Server 2003 clusters. You can perform inventory and transfer without issue on Windows Server 2008 R2 clusters, then manually perform cutover by manually changing the cluster's source file server resource netname and IP address, then changing the the destination cluster netname and IP address to match the original source. 

## Cutover hangs on "38% Mapping network interfaces on the source computer..." when using DHCP 

When attempting to run cut over of a source computer, having set the source computer to use a new static (not DHCP) IP address on one or more network interfaces, the cut over gets stuck at phase "38% Mapping network interfaces on the source comnputer..." and you receive the following error in the SMS event log:

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

Examining the source computer shows that the original IP address fails to change. 

This issue does not happen if you selected "Use DHCP" on the Windows Admin Center "configure cutover" screen, only if you specify a new static IP address, subnet, and gateway. 

This issue is resolved by the [KB4537818](https://support.microsoft.com/help/4537818/windows-10-update-kb4537818) update.

## Slower than expected re-transfer performance

After completing a transfer, then running a subsequent re-transfer of the same data, you may not see much improvement in transfer time even when little data has changed in the meantime on the source server.

This is expected behavior when transferring a very large number of files and nested folders. The size of the data isn't relevant. We first made improvements to this behavior in [KB4512534](https://support.microsoft.com/help/4512534/windows-10-update-kb4512534) and are continuing to optimize transfer performance. To tune performance further, review [Optimizing Inventory and Transfer Performance](https://docs.microsoft.com/windows-server/storage/storage-migration-service/faq#optimizing-inventory-and-transfer-performance).

## Data does not transfer, user renamed when migrating to or from a domain controller

After starting the transfer from or to a domain controller:

 1. No data is migrated and no shares are created on the destination.
 2. There is a red error symbol shown in Windows Admin Center with no error message
 3. One or more AD users and Domain Local groups have their name and/or pre-Windows 2000 logon attribute changed
 4. You see event 3509 on the SMS orchestrator:
 
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

This is expected behavior if you attempted to migrate from or to a domain controller with Storage Migration Service and used the "migrate users and groups" option to rename or reuse accounts. instead of selecting "Don't transfer users and groups". DC migration is [not supported with Storage Migration Service](faq.md). Because a DC doesn't have true local users and groups, Storage Migration Service treats these security principals as it would when migrating between two member servers and attempts to adjust ACLs as instructed, leading to the errors and mangled or copied accounts. 

If you have already run transfer one ore more times:

 1. Use the following AD PowerShell command against a DC to locate any modified users or groups (changing SearchBase to match your domain dinstringuished name): 

    ```PowerShell
    Get-ADObject -Filter 'Description -like "*storage migration service renamed*"' -SearchBase 'DC=<domain>,DC=<TLD>' | ft name,distinguishedname
    ```
   
 2. For any users returned with their original name, edit their "User Logon Name (pre-Windows 2000)" to remove the random character suffix added by Storage Migration Service, so that this user can logon.
 3. For any groups returned with their original name, edit their "Group Name (pre-Windows 2000)" to remove the random character suffix added by Storage Migration Service.
 4. For any disabled users or groups with names that now contain a suffix added by Storage Migration Service, you can delete these accounts. You can confirm that user accounts were added later because they will only contain the Domain Users group and will have a created date/time matching the Storage Migration Service transfer start time.
 
 If you wish to use Storage Migration Service with domain controllers for transfer purposes, ensure you always select "Don't transfer users and groups" on the transfer settings page in Windows Admin Center.
 
 ## Error 53, "failed to inventory all specified devices" when running inventory, 

When attempting to run inventory, you receive:

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

At this stage, Storage Migration Service orchestrator is attempting remote registry reads to determine source machine configuration, but is being rejected by the source server saying the registry path does not exist. This can be caused by:

 - The Remote Registry service is not running on the source computer.
 - firewall does not allow remote registry connections to the source server from the Orchestrator.
 - The source migration account does not have remote registry permissions to connect to the source computer.
 - The source migration account does not have read permissions within the registry of the source computer, under "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" or under "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer"
 
 ## Cutover hangs on "38% Mapping network interfaces on the source computer..." 

When attempting to run cut over of a source computer, the cut over gets stuck at phase "38% Mapping network interfaces on the source comnputer..." and you receive the following error in the SMS event log:

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

This issue is caused by Group Policy that sets the following registry value on the source computer:

 "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
 LocalAccountTokenFilterPolicy = 0"
 
This setting is not part of standard Group Policy, it's an add-on configured using the [Microsoft Security Compliance Toolkit](https://www.microsoft.com/download/details.aspx?id=55319):
 
 - Windows Server 2012 R2: "Computer Configuration\Administrative Templates\SCM: Pass the Hash Mitigations\Apply UAC restrictions to local accounts on network logons"
 - Widows Server 2016: "Computer Configuration\Administrative Templates\MS Security Guide\Apply UAC restrictions to local accounts on network logons"
 
It can also be set using Group Policy Preferences with a custom registry setting. You can use the GPRESULT tool to determine which policy is applying this setting to the source computer.

The Storage Migration Service temporarily enables the [LocalAccountTokenFilterPolicy](https://support.microsoft.com/help/951016/description-of-user-account-control-and-remote-restrictions-in-windows) as part of the cut over process, then removes it when done. When Group Policy applies a conflicting Group Policy Object (GPO), it overrides the Storage Migration Service and prevents cut over.

To workaround this issue, use one of the following options:

1. Temporarily move the source computer from the Active Directory OU that applies this conflicting GPO. 
2. Temporarily disable the GPO that applies this conflicting policy.
3. Temporarily create a new GPO that sets this setting to Disabled and applies to specific OU of source servers, with a higher precedence than any other GPOs.

## See also

- [Storage Migration Service overview](overview.md)
