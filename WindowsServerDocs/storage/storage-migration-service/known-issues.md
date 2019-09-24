---
title: Storage Migration Service known issues
description: Known issues and troubleshooting support for Storage Migration Service, such as how to collect logs for Microsoft Support.
author: nedpyle
ms.author: nedpyle
manager: siroy
ms.date: 07/09/2019
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: storage
---
# Storage Migration Service known issues

This topic contains answers to known issues when using [Storage Migration Service](overview.md) to migrate servers.

Storage Migration Service is released in two parts: the service in Windows Server, and the user interface in Windows Admin Center. The service is available in Windows Server, Long-Term Servicing Channel, as well as Windows Server, Semi-Annual Channel; while Windows Admin Center is available as a separate download. We also periodically include changes in cumulative updates for Windows Server, released via Windows Update. 

For example, Windows Server, version 1903 includes new features and fixes for Storage Migration Service, which are also available for Windows Server 2019 and Windows Server, version 1809 by installing [KB4512534](https://support.microsoft.com/help/4512534/windows-10-update-kb4512534).

## <a name="collecting-logs"></a> How to collect log files when working with Microsoft Support

The Storage Migration Service contains event logs for the Orchestrator service and the Proxy Service. The urchestrator server always contains both event logs, and destination servers with the proxy service installed contain the proxy logs. These logs are located under:

- Application and Services Logs \ Microsoft \ Windows \ StorageMigrationService
- Application and Services Logs \ Microsoft \ Windows \ StorageMigrationService-Proxy

If you need to gather these logs for offline viewing or to send to Microsoft Support, there is an open source PowerShell script available on GitHub:

 [Storage Migration Service Helper](https://aka.ms/smslogs) 

Review the README for usage.

## Storage Migration Service doesn't show up in Windows Admin Center unless managing Windows Server 2019

When using the 1809 version of Windows Admin Center to manage a Windows Server 2019 orchestrator, you don't see the tool option for Storage Migration Service. 

The Windows Admin Center Storage Migration Service extension is version-bound to only manage Windows Server 2019 version 1809 or later operating systems. If you use it to manage older Windows Server operating systems or insider previews, the tool will not appear. This behavior is by design. 

To resolve, use or upgrade to Windows Server 2019 build 1809 or later.

## Storage Migration Service doesn't let you choose static IP on cutover

When using the 0.57 version of the Storage Migration Service extension in Windows Admin Center and you reach the Cutover phase, you cannot select a static IP for an address. You are forced to use DHCP.

To resolve this issue, in Windows Admin Center, look under **Settings** > **Extensions** for an alert stating that updated version Storage Migration Service 0.57.2 is available to install. You may need to restart your browser tab for Windows Admin center.

## Storage Migration Service cutover validation fails with error "Access is denied for the token filter policy on destination computer"

When running cutover validation, you receive error "Fail: Access is denied for the token filter policy on destination computer." This occurs even if you provided correct local administrator credentials for both the source and destination computers.

This issue is caused by a code defect in Windows Server 2019. The issue will occur when you are using the destination computer as a Storage Migration Service Orchestrator.

To work around this issue, install the Storage Migration Service on a Windows Server 2019 computer that is not the intended migration destination, then connect to that server with Windows Admin Center and perform the migration.

We have fixed this in a later release of Windows Server. Please open a support case via [Microsoft Support](https://support.microsoft.com) to request a backport of this fix be created.

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

## Cutover fails when migrating between networks

When migrating to a destination computer running in a different network than the source, such as an Azure IaaS instance, cutover fails to complete when the source was using a static IP address. 

This behavior is by design, to prevent connectivity issues after migration from users, applications, and scripts connecting via IP address. When the IP address is moved from the old source computer to the new destination target, it won't match the new network subnet information and perhaps DNS and WINS.

To workaround this issue, perform a migration to a computer on the same network. Then move that computer to a new network and reassign its IP information. For instance, if migrating to Azure IaaS, first migrate to a local VM, then use Azure Migrate to shift the VM to Azure.  

We have fixed this issue in a later release of Windows Admin Center. We now allow you to specify migrations that don't alter the destination server's network settings. The updated extension will be listed here when released. 

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
   at Microsoft.StorageMigration.Proxy.Service.Transfer.FileTransfer.TryTransfer()    [d:\os\src\base\dms\proxy\transfer\transferproxy\FileTransfer.cs::TryTransfer::55]


This issue is caused by a code defect in the Storage Migration Service where the backup privilege was not being invoked. 

To resolve this issue, install [Windows Update April 2, 2019—KB4490481 (OS Build 17763.404)](https://support.microsoft.com/help/4490481/windows-10-update-kb4490481) on the orchestrator computer and the destination computer if the proxy service is installed there. Ensure that the source migration user account is a local administrator on the source computer and the Storage Migration Service orchestrator. Ensure that the destination migration user account is a local administrator on the destination computer and the Storage Migration Service orchestrator. 

## DFSR hashes mismatch when using Storage Migration Service to preseed data

When using the Storage Migration Service to transfer files to a new destination, then configuring the DFS Replication (DFSR) to replicate that data with an existing DFSR server through preseeded replication or DFSR database cloning, all files experiemce a hash mismatch and are re-replicated. The data streams, security streams, sizes, and attributes all appear to be perfectly matched after using SMS to transfer them. Examining the files with ICACLS or the DFSR Database cloning debug log reveals:

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

This issue is caused by a code defect in a library used by the Storage Migration Service to set security audit ACLs (SACL). A non-null SACL is unintentionally set when the SACL was empty, leading DFSR to correctly identify a hash mismatch. 

To workaround this issue, continue using Robocopy for [DFSR pre-seeding and DFSR Database cloning operations](../dfs-replication/preseed-dfsr-with-robocopy.md) instead of the Storage Migration Service. We are investigating this issue and intend to resolve this in a later version of Windows Server and possibly a backported Windows Update. 

## Error 404 when downloading CSV logs

When attempting to download the transfer or error logs at the end of a transfer operation, you receive error:

  $jobname : Transfer log : ajax error 404

This error is expected if you have not enabled the "File and Printer Sharing (SMB-In)" firewall rule on the orchestrator server. Windows Admin Center file downloads require port TCP/445 (SMB) on connected computers.  

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
   at Microsoft.StorageMigration.Proxy.Service.Transfer.TransferRequestHandler.ProcessRequest(FileTransferRequest fileTransferRequest, Guid operationId)    [d:\os\src\base\dms\proxy\transfer\transferproxy\TransferRequestHandler.cs::

This error is expected if your migration account does not have at least Read access permissions to the SMB shares. To workaround this error, add a security group containing the source migration account to the SMB shares on the source computer and grant it Read, Change, or Full Control. After the migration completes, you can remove this group.

## Error 0x80005000 when running inventory

After installing [KB4512534](https://support.microsoft.com/en-us/help/4512534/windows-10-update-kb4512534) and attempting to run inventory, inventory fails with errors:

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

When attempting to run inventory with the Storage Migration Service orchestrator installed on a Windows Server 2019 failover cluster node and targeting a Windows Server failover cluster general use file server source, you receive the following error:

    DLL not found
    [Error] Failed device discovery stage VolumeInfo with error: (0x80131524) Unable to load DLL 'Microsoft.FailoverClusters.FrameworkSupport.dll': The specified module could not be found. (Exception from HRESULT: 0x8007007E)   

To workaround this issue, install the "Failover Cluster Management Tools" (RSAT-Clustering-Mgmt) on the server running the Storage Migration Service orchestrator. 


## See also

- [Storage Migration Service overview](overview.md)
