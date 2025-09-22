---
title: Performance tuning for file servers
description: Performance tuning for file servers running Windows Server
ms.topic: best-practice
author: dknappettmsft
ms.author: daknappe
ms.date: 02/24/2025
audience: Admin
---

# Performance tuning for file servers

You should select the proper hardware to satisfy the expected file server load, considering average load, peak load, capacity, growth plans, and response times. Hardware bottlenecks limit the effectiveness of software tuning.

## General tuning parameters for clients

The following REG_DWORD registry settings can affect the performance of client computers that interact with Server Message Block (SMB) file servers:

| Registry entry                         | Registry path                                                                                          | Default | Valid range | Description                                                                                                                                                                                                 |
|----------------------------------------|--------------------------------------------------------------------------------------------------------|---------|-------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ConnectionCountPerNetworkInterface     | `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\ConnectionCountPerNetworkInterface` | 1     | 1-16        | Maximum number of connections per interface to be established with a server for non-RSS interfaces. |
| ConnectionCountPerRssNetworkInterface  | `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\ConnectionCountPerRssNetworkInterface` | 4  | 1-16        | Maximum number of connections per interface to be established with a server for RSS interfaces. |
| ConnectionCountPerRdmaNetworkInterface | `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\ConnectionCountPerRdmaNetworkInterface` | 2 | 1-16        | Maximum number of connections per interface to be established with a server for RDMA interfaces. |
| MaximumConnectionCountPerServer        | `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\MaximumConnectionCountPerServer`    | 32    | 1-64        | Maximum number of connections to be established with a single server running Windows Server 2012 across all interfaces. |
| DormantDirectoryTimeout                | `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\DormantDirectoryTimeout`            | 600   |             | Maximum time server directory handles held open with directory leases in seconds. |
| FileInfoCacheLifetime                  | `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\FileInfoCacheLifetime`              | 10    |             | File information cache timeout period in seconds. |
| DirectoryCacheLifetime<sup>1</sup>     | `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\DirectoryCacheLifetime`             | 10    |             | Directory cache timeout in seconds. |
| DirectoryCacheEntrySizeMax             | `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\DirectoryCacheEntrySizeMax`         | 64 KB |             | Maximum size of directory cache entries in kilobytes. |
| FileNotFoundCacheLifetime              | `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\FileNotFoundCacheLifetime`          | 5     |             | File not found cache timeout period in seconds. |
| CacheFileTimeout                       | `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\CacheFileTimeout`                   | 10    |             | Length of time in seconds that the redirector will hold on to cached data for a file after the last handle to the file can be closed by an application. |
| DisableBandwidthThrottling             | `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\DisableBandwidthThrottling`         | 0     |             | Setting this value to **1** disables throttling and allows for higher file transfer throughput over high-latency network connections.  |
| DisableLargeMtu                        | `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\DisableLargeMtu`                    |       |             | The SMB redirector transfers payloads as large as 1 MB per request, which can improve file transfer speed. Setting this registry value to **1** limits the request size to 64 KB. You should evaluate the impact of this setting before applying it. The default value for Windows 8 is **0**. |
| RequireSecuritySignature               | `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\RequireSecuritySignature`           | 0     |             | Changing this value to **1** enables SMB signing for all SMB communication, preventing SMB communication with computers where SMB signing is disabled. SMB signing can increase CPU cost and network round trips, but helps block adversary-in-the-middle attacks. If SMB signing isn't required, ensure that this registry value is **0** on all clients and servers. |
| FileInfoCacheEntriesMax                | `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\FileInfoCacheEntriesMax`            | 64    | 1-65536     | Determines the amount of file metadata that can be cached by the client. Increasing the value can reduce network traffic and increase performance when a large number of files are accessed. |
| DirectoryCacheEntriesMax               | `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\DirectoryCacheEntriesMax`           | 16    | 1-4096      | Determines the amount of directory information that can be cached by the client. Increasing the value can reduce network traffic and increase performance when large directories are accessed. |
| FileNotFoundCacheEntriesMax            | `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\FileNotFoundCacheEntriesMax`        | 128   | 1-65536     | Determines the amount of file name information that can be cached by the client. Increasing the value can reduce network traffic and increase performance when a large number of file names are accessed. |
| MaxCmds                                | `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\MaxCmds`                            | 15    |             | Limits the number of outstanding requests on a session. Increasing the value can use more memory, but it can improve performance by enabling a deeper request pipeline. Increasing the value with **MaxMpxCt** can also eliminate errors that are encountered due to large numbers of outstanding long-term file requests, such as **FindFirstChangeNotification** calls. This parameter doesn't affect connections with SMB 2.0 servers. |
| DormantFileLimit                       | `HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\DormantFileLimit`                   | 1023  |             | Specifies the maximum number of files that should be left open on a shared resource after the application closes the file. |

> [!NOTE]
> <sup>1</sup> The **DirectoryCacheLifetime** registry entry controls caching of directory metadata in the absence of directory leases.
>
> A known issue in Windows 10, version 1803, affects the ability of Windows 10 to cache large directories. To resolve this issue, install Windows 10, version 1809 or a later.
>
> To work around this issue, set **DirectoryCacheLifetime** to **0**. This issue affects the following editions of Windows 10:
>
> - Windows 10 Enterprise, version 1803
> - Windows 10 Pro for Workstations, version 1803
> - Windows 10 Pro Education, version 1803
> - Windows 10 Professional, version 1803
> - Windows 10 Education, version 1803
> - Windows 10 Home, version 1803

### Client tuning example

The general tuning parameters for client computers can optimize a computer for accessing remote file shares, particularly over some high-latency networks (such as branch offices, cross-datacenter communication, home offices, and mobile broadband). These settings aren't optimal or appropriate on all computers. You should evaluate the impact of individual settings before applying them.

| Registry entry              | Value | Default |
|-----------------------------|-------|---------|
| DisableBandwidthThrottling  | 1     | 0       |
| FileInfoCacheEntriesMax     | 32768 | 64      |
| DirectoryCacheEntriesMax    | 4096  | 16      |
| FileNotFoundCacheEntriesMax | 32768 | 128     |
| MaxCmds                     | 32768 | 15      |

Starting in Windows 8, you can configure many of these SMB settings by using the `Set-SmbClientConfiguration` and `Set-SmbServerConfiguration` Windows PowerShell cmdlets. Registry-only settings can be configured by using Windows PowerShell as well, for example:

```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" RequireSecuritySignature -Value 0 -Force
```

