---
title: Verify the iSCSI Software Target Migration
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 480b73c6-239a-4ec4-bc9b-c5fdf156b45e
---
# Verify the iSCSI Software Target Migration
This topic discusses the steps you can use to verify that the migration successfully completed.  
  
## Verifying the destination server configuration  
To verify that the destination server has been properly configured after migration, you can verify the listening endpoints and connectivity and run a scan with the Best Practices Analyzer.  
  
### Verify the listening endpoints  
On the iSCSI Target destination server, you can validate that the target portals have been configured as desired by using the following Windows PowerShell command:  
  
```  
PS > & netstat.exe -nao | findstr 3260 | findstr LISTENING  
  TCP    10.121.26.107:3260     0.0.0.0:0              LISTENING       1560  
  TCP    10.121.26.126:3260     0.0.0.0:0              LISTENING       1560  
  TCP    [2001:4898:0:fff:0:5efe:10.121.26.126]:3260  [::]:0                 LISTENING       1560  
  TCP    [2001:4898:f0:1001:f063:8fc5:52e6:2310]:3260  [::]:0                 LISTENING       1560  
  
```  
  
The list of IP addresses and port pairs in the listening state needs to match the desired set of target portals.  
  
> [!NOTE]  
> If ports other than the default 3260 are being used, the command needs to be altered to reflect the alternate IP ports.  
  
### Verify the basic connectivity  
To validate that the iSCSI Target Server computer is reachable from other computers on the network, from a computer that has the Telnet Client feature installed, use the following Windows PowerShell command:  
  
```  
PS > telnet.exe <iSCSI Software Target machine name or IP> 3260  
```  
  
If there is a successful connection, Telnet Client will show a blinking cursor at the top of the window. Press any key to close Telnet Client.  
  
### Perform a Best Practices Analyzer scan  
To verify that iSCSI Target Server is optimally configured on Windows Server  2012 or Windows Storage Server 2012 after migration, we recommend that you run a Best Practices Analyzer \(BPA\) scan on the role.  
  
BPA is a server management tool that is available in Windows Server 2012. After the migration of iSCSI Target 3.3 is complete, BPA can help you ensure that your server is configured according to best practices. You can use the Server Manager console UI or Windows PowerShell to perform BPA scans and view results. For detailed information about how to scan your role and view results, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://technet.microsoft.com/library/hh831400.aspx).  
  
## Verifying the configuration of iSCSI initiator computers  
Validating the migration of iSCSI Software Target to the destination server includes ensuring that the iSCSI initiators can discover and fully access all features of the iSCSI protocol.  
  
### Verify that the iSCSI initiators can discover iSCSI Target Server  
To verify that the iSCSI initiators can discover iSCSI Target Server, use the following Windows PowerShell commands:  
  
```  
PS > & iscsicli AddTargetPortal <ip-address> 3260  
PS > & iscsicli.exe ListTargets  
```  
  
If the commands execute without errors, the initiator is capable of discovering the targets that are offered by the server  
  
### Verify that the iSCSI initiators can log on  
The second step is to verify that the iSCSI initiators are able to log on to the iSCSI targets that are exposed by iSCSI Target Server. This can be accomplished by using the following Windows PowerShell command:  
  
```  
PS > & iscsicli.exe  LoginTarget <target IQN> T <ip address> 3260 Root\ISCSIPRT\0000_0 * * * * * * * * * * * * *  
  
```  
  
> [!NOTE]  
> If you are using CHAP and Reverse CHAP authentication, you may need to specify more parameters. For more information, consult the documentation in the iscsicli.exe.  
  
If the command executes without errors, the iSCSI initiator has successfully logged on to the target, and the disks are exposed to iSCSI Target Server.  
  
## See Also  
[Migrate File and Storage Services to Windows Server 2012 R2](../Topic/Migrate-File-and-Storage-Services-to-Windows-Server-2012-R2.md)  
[File and Storage Services: Migrate an iSCSI Software Target](../Topic/File-and-Storage-Services--Migrate-an-iSCSI-Software-Target.md)  
[Prepare to Migrate iSCSI Software Target](../Topic/Prepare-to-Migrate-iSCSI-Software-Target.md)  
[Migrate iSCSI Software Target](../Topic/Migrate-iSCSI-Software-Target.md)  
[Troubleshoot the iSCSI Software Target Migration](../Topic/Troubleshoot-the-iSCSI-Software-Target-Migration.md)  
[Roll Back a Failed iSCSI Software Target Migration](../Topic/Roll-Back-a-Failed-iSCSI-Software-Target-Migration.md)  
  
