---
title: Slow SMB files transfer speed
description: Learn how to resolve transfer performance issues with SMB files by using the provided troubleshooting steps.
author: Deland-Han
manager: dcscontentpm
ms.topic: troubleshooting-problem-resolution
ms.author: delhan
ms.date: 03/27/2023
---

# Slow SMB files transfer speed

Server Message Block (SMB) file transfer speeds can slow down depending on the size and quantity of your files, your connection type, and the version of apps you use. This article provides troubleshooting procedures for slow file transfer speeds through SMB.

## Slow transfer

You can troubleshoot slow file transfers by checking your current storage use. If you observe slow transfers of files, consider the following steps:

- Try the file copy command for unbuffered IO:
  - `xcopy /J`
  - `robocopy /J`

- Test the storage speed. Copy speeds are limited by storage speed.

- File copies sometimes start fast and then slow down. A change in copy speed occurs when the initial copy is cached or buffered, in memory or in the RAID controller's memory cache, and the cache runs out. This change forces data to be written directly to disk (write-through).

  To verify this situation, use storage performance monitor counters to determine whether storage performance degrades over time. For more information, see [Performance tuning for SMB file servers](../../../administration/performance-tuning/role/file-server/smb-file-server.md).

- Use RAMMap (SysInternals) to determine whether "Mapped File" usage in memory stops growing because of free memory exhaustion.

- Look for packet loss in the trace. Packet loss can cause throttling by the TCP congestion provider.

- For SMBv3 and later versions, verify that SMB Multichannel is enabled and working.

- On the SMB client, enable large MTU in SMB, and disable bandwidth throttling by running the following command:

  ```powershell
  Set-SmbClientConfiguration -EnableBandwidthThrottling 0 -EnableLargeMtu 1
  ```

## Slow transfer of small files

A slow transfer of small files occurs most commonly when there are many files. This occurrence is an expected behavior.

During file transfer, file creation causes both high protocol overhead and high file system overhead. For large file transfers, these costs occur only one time. When a large number of small files are transferred, the cost is repetitive and causes slow transfers.

### Issue details

Network latency, `create` commands, and antivirus programs contribute to a slower transfer of small files. The following are technical details about this problem:

- SMB calls a `create` command to request that the file is created. Code checks whether the file exists and then creates the file. Otherwise, some variation of the `create` command creates the actual file.

  - Each `create` command generates activity on the file system.
  - After the data is written, the file is closed.

- The process can suffer from network latency and SMB server latency. This latency occurs because the SMB request is first translated to a file system command and then to the actual file system to complete the operation.

- The transfer continues to slow while an antivirus program is running. This change happens because the data is typically scanned once by the packet sniffer and a second time when the data is written to disk. In some scenarios, these actions are repeated thousands of times. You can potentially observe speeds of less than 1 MB/s.

## Slow open of Office documents

Office documents can open slowly, which generally occurs on a WAN connection. The manner in which Office apps (Microsoft Excel, in particular) access and read data is typically what causes the documents to open slowly.

You should verify that the Office and SMB binaries are up-to-date, and then test by having leasing disabled on the SMB server. To verify both conditions have resolved, follow these steps:

1. Run the following PowerShell command in Windows 8 and Windows Server 2012 or later versions of Windows:

   ```powershell
   Set-SmbServerConfiguration -EnableLeasing $false  
   ```

   You can also run the following command in an elevated Command Prompt window:

   ```cmd
   REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters /v DisableLeasing /t REG\_DWORD /d 1 /f  
   ```

   > [!NOTE]
   > After you set this registry key, SMB2 leases are no longer granted, but oplocks are still available. This setting is used primarily for troubleshooting.

1. Restart the file server or restart the **Server** service. To restart the service, run the following commands:

   ```cmd  
   NET STOP SERVER 
   NET START SERVER
   ```

To avoid this issue, you can also replicate the file to a local file server. For more information, see [saving Office documents to a network server is slow when using EFS](/office/troubleshoot/office/saving-file-to-network-server-slow).
