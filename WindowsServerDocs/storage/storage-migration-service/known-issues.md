---
title: Storage Migration Service known issues
description: Known issues and troubleshooting support for Storage Migration Service, such as how to collect logs for Microsoft Support.
author: nedpyle
ms.author: nedpyle
manager: siroy
ms.date: 02/27/2019
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: storage
---
# Storage Migration Service known issues

This topic contains answers to known issues when using [Storage Migration Service](overview.md) to migrate servers.

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

We intend to fix this issue in a later release of Windows Server. Please open a support case via [Microsoft Support](https://support.microsoft.com) to request a backport of this fix be created.

## Storage Migration Service isn't included in Windows Server 2019 Evaluation edition

When using Windows Admin Center to connect to a [Windows Server 2019 Evaluation release](https://www.microsoft.com/evalcenter/evaluate-windows-server-2019) there isn't an option to manage the Storage Migration Service. Storage Migration Service also isn't included in Roles and Features.

This issue is caused by a servicing issue in the Evaluation media of Windows Server 2019. 

To work around this issue, install a retail, MSDN, OEM, or Volume License version of Windows Server 2019 and don't activate it. Without activation, all editions of Windows Server operate in evaluation mode for 180 days. 

We have fixed this issue in a later release of Windows Server 2019.  

## Storage Migration Service times out downloading the transfer error CSV

When using Windows Admin Center or PowerShell to download the transfer operations detailed errors-only CSV log, you receive error:

 >   Transfer Log - Please check file sharing is allowed in your firewall. : This request operation sent to net.tcp://localhost:28940/sms/service/1/transfer did not receive a reply within the configured timeout (00:01:00). The time allotted to this operation may have been a portion of a longer timeout. This may be because the service is still processing the operation or because the service was unable to send a reply message. Please consider increasing the operation timeout (by casting the channel/proxy to IContextChannel and setting the OperationTimeout property) and ensure that the service is able to connect to the client.

This issue is caused by an extremely large number of transferred files that cannot be filtered in the default one minute timeout allowed by Storage MIgration Service. 

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

   `HKEY_LOCAL_MACHINE\\Software\\Microsoft\\SMSPowershell`

5. On the Edit menu, point to New, and then click DWORD Value. 
6. Type "WcfOperationTimeoutInMinutes" for the name of the DWORD, and then press ENTER.
7. Right-click "WcfOperationTimeoutInMinutes", and then click Modify. 
8. In the Base data box, click "Decimal"
9. In the Value data box, type "10", and then click OK.
10. Exit Registry Editor.
11. Attempt to download the errors-only CSV file again. 

We intend to change this behavior in a later release of Windows Server 2019.  

## Cutover fails when migrating between networks

When migrating to a destination VM running in a different network than the source, such as an Azure IaaS instance, cutover fails to complete when the source was using a static IP address. 

This behavior is by design, to prevent connectivity issues after migration from users, applications, and scripts connecting via IP address. When the IP address is moved from the old source computer to the new destination target, it won't match the new network subnet information and perhaps DNS and WINS.

To workaround this issue, perform a migration to a computer on the same network. Then move that computer to a new network and reassign its IP information. For instance, if migrating to Azure IaaS, first migrate to a local VM, then use Azure Migrate to shift the VM to Azure.  

We have fixed this issue in a later release of Windows Server 2019. We'll now allow you to specify migrations that don't alter the destination server's network settings. We may release an update to the existing version of Windows Server 2019 as part of the normal monthly update cycle. 


## See also

- [Storage Migration Service overview](overview.md)