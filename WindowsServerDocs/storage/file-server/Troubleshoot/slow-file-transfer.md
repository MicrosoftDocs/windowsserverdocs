---
title: Slow SMB files transfer speed
description: Introduces how to troubleshoot SMB files transfer performance issue.
author: Deland-Han
manager: dcscontentpm
audience: ITPro
ms.topic: article
ms.author: delhan
ms.date: 12/25/2019
---

# Slow SMB files transfer speed

This article provides suggested troubleshooting procedures for slow file transfer speeds through SMB.

## Large file transfer is slow

If you observe slow transfers of large files, consider the following
steps:

- Try the file copy command for unbuffered IO (**xcopy /J** or  **robocopy /J**).

- Test the storage speed. This is because file copy speeds are limited by storage speed.

- File copies sometimes start fast and then slow down. Follow these guidelines to verify this situation:
    
  - This usually occurs when the initial copy is cached or buffered (either in memory or in the RAID controller’s memory cache) and the cache runs out. This forces data to be written directly to disk (write-through). This is a slower process.
    
  - Use storage performance monitor counters to determine whether storage performance degrades over time. For more information, see [Performance tuning for SMB file servers](https://docs.microsoft.com/windows-server/administration/performance-tuning/role/file-server/smb-file-server).

- Use RAMMap (SysInternals) to determine whether “Mapped File” usage in memory stops growing because of free memory exhaustion.

- Look for packet loss in the trace. This can cause throttling by the TCP congestion provider.

- For SMBv3 and later versions, make sure that SMB Multichannel is enabled and working.

- On the SMB client, enable large MTU in SMB, and disable bandwidth throttling. To do this, run the following command:  
  
  ```PowerShell
  Set-SmbClientConfiguration -EnableBandwidthThrottling 0 -EnableLargeMtu 1
  ```

## Small file transfer is slow

Slow transfer of small files through SMB occurs most commonly if there are many files. This is an expected behavior.

During file transfer, file creation causes both high protocol overhead and high file system overhead. For large file transfers, these costs occur only one time. When a large number of small files are transferred, the cost is repetitive and causes slow transfers.

The following are technical details about this problem:

- SMB calls a create command to request that the file be created. Some code will check whether the file exists, and then create the file. Or some variation of the create command creates the actual file.

- Each create command generates activity on the file system.

- After the data is written, the file is closed.

- All some time, the process suffers from network latency and SMB     server latency. This is because the SMB request is first translated to a file system command and then to the actual file system latency to complete the operation.

- If any antivirus program is running, the transfer slows down even more. This is because the data is typically scanned one time by the packet sniffer and a second time when it is written to disk. In some scenarios, these actions are repeated thousands of time. You potentially observe speeds of less than 1 MB/s.

## Opening Office documents is slow

This problem generally occurs on a WAN connection. This is common and typically is caused by the manner in which Office apps (Microsoft Excel, in particular) access and read data.

We recommend that you make sure that the Office and SMB binaries are up-to-date, and then test by having leasing disabled on the SMB server. To do this, follow these steps:
   
1. Run the following PowerShell command in Windows 8 and Windows Server 2012 or later versions of Windows:
      
   ```PowerShell
   Set-SmbServerConfiguration -EnableLeasing $false  
   ```
      
   Or, run the following command in an elevated Command Prompt window:  

   ```cmd
   REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters /v DisableLeasing /t REG\_DWORD /d 1 /f  
   ```
      
   > [!NOTE]
   > After you set this registry key, SMB2 leases are no longer granted, but oplocks are still available. This setting is used primarily for troubleshooting.
    
2. Restart the file server or restart the **Server** service. To restart the service, run the following commands:

   ```cmd  
   NET STOP SERVER 
   NET START SERVER
   ```

To avoid this issue, you can also replicate the file to a local file server. For more information, see [aving Office documents to a network server is slow when using EFS](https://docs.microsoft.com/office/troubleshoot/office/saving-file-to-network-server-slow).
