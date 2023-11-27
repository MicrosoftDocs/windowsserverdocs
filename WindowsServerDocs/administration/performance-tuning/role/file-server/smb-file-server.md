---
title: Performance Tuning for SMB File Servers
description: Performance Tuning for SMB File Servers
ms.topic: article
author: phstee
ms.author: nedpyle
ms.date: 11/27/2023
---
# Performance tuning for SMB file servers

## SMB configuration considerations

Don't enable any services or features that your file server and clients don't require. Unnecessary services or features might include SMB signing, client-side caching, file system mini-filters, search service, scheduled tasks, NTFS encryption, NTFS compression, IPSEC, firewall filters, Teredo, or SMB encryption.

Ensure that the BIOS and operating system power management modes are set as needed, which might include High Performance mode or altered C-State. Ensure that the latest, most resilient, and fastest storage and networking device drivers are installed.

Copying files is a common operation performed on a file server. Windows Server has several built-in file copy utilities that you can run by using a command prompt. Robocopy is recommended. Introduced in Windows Server 2008 R2, the `/mt` option of Robocopy can significantly improve speed on remote file transfers by using multiple threads when copying multiple small files. We also recommend using the `/log` option to reduce console output by redirecting logs to a NUL device or to a file. When you use Xcopy, we recommend adding the `/q` and `/k` options to your existing parameters. The former option reduces CPU overhead by reducing console output and the latter reduces network traffic.

## SMB performance tuning

File server performance and available tunings depend on the SMB protocol that is negotiated between each client and the server, and on the deployed file server features. The highest protocol version currently available is SMB 3.1.1 in Windows Server 2022, Windows Server 2016 and Windows 10. You can check which version of SMB is in use on your network by using Windows PowerShell `Get-SMBConnection` on clients and `Get-SMBSession | FL` on servers.

### SMB 3.0 protocol family

SMB 3.0 was introduced in Windows Server 2012 and further enhanced in Windows Server 2012 R2 (SMB 3.02) and Windows Server 2016 (SMB 3.1.1). This version introduced technologies that may significantly improve performance and availability of the file server. For more info, see [SMB in Windows Server 2012 and 2012 R2 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831795(v=ws.11)) and [What's new in SMB 3.1.1](https://aka.ms/smb311).

### SMB Direct

SMB Direct introduced the ability to use RDMA network interfaces for high throughput with low latency and low CPU utilization.

Whenever SMB detects an RDMA-capable network, it automatically tries to use the RDMA capability. However, if for any reason the SMB client fails to connect using the RDMA path, it continues to use TCP/IP connections instead. All RDMA interfaces that are compatible with SMB Direct are required to also implement a TCP/IP stack, and SMB Multichannel is aware of that.

SMB Direct isn't required in any SMB configuration, but it's always recommended for those who want lower latency and lower CPU utilization.

For more info about SMB Direct, see [Improve Performance of a File Server with SMB Direct](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134210(v=ws.11)).

### SMB Multichannel

SMB Multichannel allows file servers to use multiple network connections simultaneously and provides increased throughput.

For more info about SMB Multichannel, see [Deploy SMB Multichannel](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn610980(v=ws.11)).

### SMB Scale-Out

SMB Scale-out allows SMB 3.0 in a cluster configuration to show a share in all nodes of a cluster. This active/active configuration makes it possible to scale file server clusters further, without a complex configuration with multiple volumes, shares and cluster resources. The maximum share bandwidth is the total bandwidth of all file server cluster nodes. The total bandwidth is no longer limited by the bandwidth of a single cluster node, but rather depends on the capability of the backing storage system. You can increase the total bandwidth by adding nodes.

For more info about SMB Scale-Out, see [Scale-Out File Server for Application Data Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831349(v=ws.11)) and the blog post [To scale out or not to scale out, that is the question](https://aka.ms/scaleoutornot).

### Performance counters for SMB 3.0

The following SMB performance counters were introduced in Windows Server 2012, they're considered the base set of counters when you monitor the resource usage of SMB 2 and higher versions. Log the performance counters to a local, raw (.blg) performance counter log. It's less expensive to collect all instances by using the wildcard character (\*), and then extract particular instances during post-processing by using Relog.exe.

- **SMB Client Shares**

    These counters display information about file shares on the server that are being accessed by a client that is using SMB 2.0 or higher versions.

    If you' re familiar with the regular disk counters in Windows, you might notice a certain resemblance. That' s not by accident. The SMB client shares performance counters were designed to exactly match the disk counters. This way you can easily reuse any guidance on application disk performance tuning you currently have. For more info about counter mapping, see [Per share client performance counters blog](/archive/blogs/josebda/windows-server-2012-file-server-tip-new-per-share-smb-client-performance-counters-provide-great-insight).

- **SMB Server Shares**

    These counters display information about the SMB 2.0 or higher file shares on the server.

- **SMB Server Sessions**

    These counters display information about SMB server sessions that are using SMB 2.0 or higher.

    Turning on counters on server side (server shares or server sessions) may have significant performance impact for high IO workloads.

- **Resume Key Filter**

    These counters display information about the Resume Key Filter.

- **SMB Direct Connection**

    These counters measure different aspects of connection activity. A computer can have multiple SMB Direct connections. SMB Direct Connection counters represent each connection as a pair of IP addresses and ports, where the first IP address and port represent the connection's local endpoint, and the second IP address and port represent the connection's remote endpoint.

- **Physical Disk, SMB, CSV FS performance counters relationships**

    For more info on how Physical Disk, SMB, and CSV FS (file system) counters are related, see the following blog post: [Cluster Shared Volume Performance Counters](https://aka.ms/clusterperfcount).

## Tuning parameters for SMB file servers

The following `REG_DWORD` registry settings can affect the performance of SMB file servers:

- **Smb2CreditsMin** and **Smb2CreditsMax**

  ```registry
  HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters\Smb2CreditsMin
  ```

  ```registry
  HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters\Smb2CreditsMax
  ```

  The defaults are 512 and 8192 for Windows Server, respectively. These parameters allow the server to throttle client operation concurrency dynamically within the specified boundaries. Some clients might achieve increased throughput with higher concurrency limits, for example, copying files over high-bandwidth, high-latency links. These default values apply to Windows Server, not Windows.

  > [!TIP]
  > Prior to Windows 10 and Windows Server 2016, the number of credits granted to the client varied dynamically between Smb2CreditsMin and Smb2CreditsMax based on an algorithm that attempted to determine the optimal number of credits to grant based on network latency and credit usage. In Windows 10 and Windows Server 2016, the SMB server was changed to unconditionally grant credits upon request up to the configured maximum number of credits. As part of this change, the credit throttling mechanism, which reduces the size of each connection's credit window when the server is under memory pressure, was removed. The kernel's low memory event that triggered throttling is only signaled when the server is so low on memory (< a few MB) as to be useless. Since the server no longer shrinks credit windows the Smb2CreditsMin setting is no longer necessary and is now ignored.
  >
  > You can monitor SMB Client Shares\\Credit Stalls /Sec to see if there are any issues with credits.

- **AdditionalCriticalWorkerThreads**

    ```registry
    HKLM\System\CurrentControlSet\Control\Session Manager\Executive\AdditionalCriticalWorkerThreads
    ```

    The default is 0, which means that no more critical kernel worker threads are added. This value affects the number of threads that the file system cache uses for read-ahead and write-behind requests. Raising this value can allow for more queued I/O in the storage subsystem, and it can improve I/O performance, particularly on systems with many logical processors and powerful storage hardware.

  > [!Note]
  > This setting mainly applies to Windows 7, Windows Server 2008 R2, and older operating systems. In later operating systems, while Cache Manager still indirectly consumes this value, Cache Manager does not create dedicated worker threads in later operating systems; rather, this value indirectly influences how many work-items of each type (generic workers, lazy writers, etc.) Cache Manager will allocate for later submission to the kernel thread pool.

  > [!TIP]
  > The value may need to be increased if the amount of cache manager dirty data (performance counter Cache\\Dirty Pages) is growing to consume a large portion (over ~25%) of memory or if the system is doing lots of synchronous read I/Os.

- **MaxThreadsPerNumaNode**

  ```registry
  HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters\MaxThreadsPerNumaNode
  ```

  The default is 20. Increasing this value raises the number of threads that the file server can use to service concurrent requests. When a large number of active connections need to be serviced, increasing the value might improve performance when inefficient third party filter drivers are affecting IO. It's better to install updated third party filter drivers and print drivers that process IO more efficiently instead of altering this setting. 

  >[!TIP]
  > An indication that the value may need to be increased is if the SMB2 work queues are growing very large (performance counter ‘Server Work Queues\\Queue Length\\SMB2 NonBlocking \*'  is consistently over ~100).

  >[!Note]
  >In SMB1 and in Windows Server 2012 and Windows Server 2008, MaxThreadsPerQueue was used to control this setting. SMB1 is deprecated and no longer installed, and this setting itself is now defunct.

- **AsynchronousCredits**

  ```registry
  HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters\AsynchronousCredits
  ```

  The default is 512. This parameter limits the number of concurrent asynchronous SMB commands that are allowed on a single connection. Some cases (such as when there's a front-end server with a back-end IIS server) require a large amount of concurrency (for file change notification requests, in particular). The value of this entry can be increased to support these cases. The default value is for Windows Server, not Windows.
  
- **RemoteFileDirtyPageThreshold**

```registry
  HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\RemoteFileDirtyPageThreshold
```

  The default is 5GB. This value determines the maximum number of dirty pages in the cache (on a per file basis) for a remote write before an inline flush is performed. We don't recommend changing this value unless the system experiences consistent slowdowns during heavy remote writes. This slowdown behavior would typically be seen where the client has faster storage IO performance than the remote server. The setting change is applied to the server. Client and server refer to the distributed system architecture, not to particular operating systems; for example, a Windows Server copying data to another Windows Server over SMB would still involve an SMB client and an SMB server. For more information, see [Troubleshoot Cache and Memory Manager Performance Issues](../../subsystem/cache-memory-management/troubleshoot.md).

### SMB server tuning example

The following settings can optimize a computer for file server performance in many cases. The settings aren't optimal or appropriate on all computers. You should evaluate the impact of individual settings before applying them.

| Parameter                       | Value | Default |
|---------------------------------|-------|---------|
| AdditionalCriticalWorkerThreads | 64    | 0       |

### SMB client performance monitor counters

For more info about SMB client counters, see [Windows Server 2012 File Server Tip: New per-share SMB client performance counters provide great insight](/archive/blogs/josebda/windows-server-2012-file-server-tip-new-per-share-smb-client-performance-counters-provide-great-insight).
