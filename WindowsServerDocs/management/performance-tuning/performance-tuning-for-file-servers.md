---
title: Performance Tuning for File Servers
description: Performance Tuning for File Servers
---

# Performance Tuning for File Servers


Applies To: Windows Server 2008 R2, Windows Server 2008, Windows Server 2012, Windows Server 2012 R2

You should select the proper hardware to satisfy the expected file server load, considering average load, peak load, capacity, growth plans, and response times. Hardware bottlenecks limit the effectiveness of software tuning. For hardware recommendations, see [Performance Tuning for Server Hardware](performance-tuning-for-server-hardware.md). The following subsystem performance tuning topics also apply to file servers: [Performance Tuning for Network Subsystems](performance-tuning-for-network-subsystems.md) and [Performance Tuning for Storage Subsystems](performance-tuning-for-storage-subsystems.md).

**In this topic:**

-   [SMB configuration considerations](#smb)

-   [SMB performance tuning](#smbperftuning)

-   [Tuning parameters for SMB file servers](#smbtuningpars)

-   [Services for NFS model](#servicesnfs)

-   [General tuning parameters for clients](#clients)

## <a href="" id="smb"></a>SMB configuration considerations


Do not enable any services or features that your file server and clients do not require. These might include SMB signing, client-side caching, file system mini-filters, search service, scheduled tasks, NTFS encryption, NTFS compression, IPSEC, firewall filters, Teredo, and SMB encryption.

Ensure that the BIOS and operating system power management modes are set as needed, which might include High Performance mode or altered C-State. Ensure that the latest, most resilient, and fastest storage and networking device drivers are installed.

Copying files is a common operation performed on a file server. Windows Server has several built-in file copy utilities that you can run by using a command prompt. Robocopy is recommended. Introduced in Windows Server 2008 R2, the **/mt** option of Robocopy can significantly improve speed on remote file transfers by using multiple threads when copying multiple small files. We also recommend the /log option to reduce console output by redirecting to NUL device or to a file. When you use Xcopy, we recommend adding the **/q** and **/k** options to your existing parameters. The former option reduces CPU overhead by reducing console output and the latter reduces network traffic.

## <a href="" id="smbperftuning"></a>SMB performance tuning


File server performance and available tunings depend on the SMB protocol that is negotiated between each client and the server, and on the deployed file server features. The highest protocol version currently available is SMB 3.02. You can check which version of SMB is in use on your network by using Windows PowerShell, as described in [Windows Server 2012: Which version of the SMB protocol (SMB 1.0, SMB 2.0, SMB 2.1, SMB 3.0, or SMB 3.02) are you using on your File Server?](http://blogs.technet.com/b/josebda/archive/2013/10/02/windows-server-2012-r2-which-version-of-the-smb-protocol-smb-1-0-smb-2-0-smb-2-1-smb-3-0-or-smb-3-02-you-are-using.aspx).

### SMB 3.0 protocol

SMB 3.0 was introduced in Windows Server 2012 and further enhanced in Windows Server 2012 R2. This version introduced technologies that may significantly improve performance and availability of the file server. For more info on what’s new in SMB 3.0 for Windows Server 2012 R2, see [What's New for SMB in Windows Server 2012 R2](http://technet.microsoft.com/library/hh831474.aspx).

The following figure shows a basic scenario with a single channel, single client, and single server. The scenario shows the optional paths of SMB packets that use either TCP/IP or RDMA.

![smb 3.0 packet flow options](../media/performance-tuning/perftune-guide-smb3-packet-flow.png)

The following sections describe what can be achieved by combining these techniques across multiple channels (multiple interfaces in the server) and multiple nodes joined in SMB file server cluster. For more info about SMB 3.0, see [Updated Links on Windows Server 2012 File Server and SMB 3.0](http://blogs.technet.com/b/josebda/archive/2013/05/05/updated-links-on-windows-server-2012-file-server-and-smb-3-0.aspx) and [Updated Links on Windows Server 2012 R2 File Server and SMB 3.02](http://blogs.technet.com/b/josebda/archive/2013/07/31/updated-links-on-windows-server-2012-r2-file-server-and-smb-3-0.aspx).

### SMB Direct

SMB Direct introduced the ability to use RDMA network interfaces for high throughput with low latency and low CPU utilization.

Whenever SMB detects an RDMA-capable network, it automatically tries to use the RDMA capability. However, if for any reason the SMB client fails to connect using the RDMA path, it will simply continue to use TCP/IP connections instead. All RDMA interfaces that are compatible with SMB Direct are required to also implement a TCP/IP stack, and SMB Multichannel is aware of that.

SMB Direct is not required in any SMB configuration, but it’s always recommended for those who want lower latency and lower CPU utilization.

For more info about SMB Direct, see [Improve Performance of a File Server with SMB Direct](http://technet.microsoft.com/library/jj134210.aspx).

### SMB Multichannel

SMB Multichannel allows file servers to use multiple network connections simultaneously and provides increased throughput.

For more info about SMB Multichannel, see [The basics of SMB Multichannel, a feature of Windows Server 2012 and SMB 3.0](http://blogs.technet.com/b/josebda/archive/2012/06/28/the-basics-of-smb-multichannel-a-feature-of-windows-server-2012-and-smb-3-0.aspx).

### SMB Transparent Failover

SMB Transparent Failover is a feature that allows an SMB client to continue to work uninterrupted when there’s a failure in the SMB Scale-out file server cluster node that the client is using. This includes preserving information on the server side plus allowing the client to automatically reconnect to the same share and files on a surviving file server cluster node.

For more info about SMB Transparent Failover, see [SMB Transparent Failover – making file shares continuously available](http://blogs.technet.com/b/clausjor/archive/2012/06/07/smb-transparent-failover-making-file-shares-continuously-available.aspx).

### SMB Scale-Out

SMB Scale-out allows SMB 3.0 in a cluster configuration to show a share in all nodes of a cluster. This active/active configuration makes it possible to scale file server clusters further, without a complex configuration with multiple volumes, shares and cluster resources. The maximum share bandwidth is the total bandwidth of all file server cluster nodes. The total bandwidth is no longer limited by the bandwidth of a single cluster node, but rather depends on the capability of the backing storage system. You can increase the total bandwidth by adding nodes.

For more info about SMB Scale-Out, see [Scale-Out File Server for Application Data Overview](http://technet.microsoft.com/library/hh831349.aspx) and the blog post [To scale out or not to scale out, that is the question](http://blogs.technet.com/b/filecab/archive/2013/12/05/to-scale-out-or-not-to-scale-out-that-is-the-question.aspx).

### <a href="" id="smbcounters"></a>Performance counters for SMB 3.0

The following SMB performance counters were introduced in Windows Server 2012, and they are considered a base set of counters when you monitor the resource usage of SMB 2 and higher versions. Log the performance counters to a local, raw (.blg) performance counter log. It is less expensive to collect all instances by using the wildcard character (\*), and then extract particular instances during postprocessing by using Relog.exe.

-   **SMB client shares**

    These counters display information about file shares on the server that are being accessed by a client that is using SMB 2.0 or higher versions.

    If you’re familiar with the regular disk counters in Windows, you might notice a certain resemblance. That’s not by accident. The SMB client shares performance counters were designed to exactly match the disk counters. This way you can easily reuse any guidance on application disk performance tuning you currently have. For more info about counter mapping, see [Per share client performance counters blog](http://blogs.technet.com/b/josebda/archive/2012/11/19/windows-server-2012-file-server-tip-new-per-share-smb-client-performance-counters-provide-great-insight.aspx).

-   **SMB server shares**

    These counters display information about the SMB 2.0 or higher file shares on the server.

-   **SMB server sessions**

    These counters display information about SMB server sessions that are using SMB 2.0 or higher.

    Turning on counters on server side (server shares or server sessions) may have significant performance impact for high IO workloads.

-   **Resume key filter**

    These counters display information about the Resume Key Filter.

-   **SMB direct connection**

    These counters measure different aspects of connection activity. A computer can have multiple SMB Direct connections. The SMB Direct Connection counters represent each connection as a pair of IP addresses and ports, where the first IP address and port represent the connection's local endpoint, and the second IP address and port represent the connection's remote endpoint.

-   **Physical disk, SMB, CSV File system performance counters relationship**

    For more info on how physical disk, SMB, and CSV file system counters are related, see the following blog post: [Cluster Shared Volume Performance Counters](http://blogs.msdn.com/b/clustering/archive/2014/06/05/10531462.aspx).

## <a href="" id="smbtuningpars"></a>Tuning parameters for SMB file servers


The following REG\_DWORD registry settings can affect the performance of SMB file servers:

-   **Smb2CreditsMin** and **Smb2CreditsMax**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters\Smb2CreditsMin
    ```

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters\Smb2CreditsMax
    ```

    The defaults are 512 and 8192, respectively. These parameters allow the server to throttle client operation concurrency dynamically within the specified boundaries. Some clients might achieve increased throughput with higher concurrency limits, for example, copying files over high-bandwidth, high-latency links.

    **Tip**  
    You can monitor SMB Client Shares\\Credit Stalls /Sec to see if there are any issues with credits.

     

-   **AdditionalCriticalWorkerThreads**

    ``` syntax
    HKLM\System\CurrentControlSet\Control\Session Manager\Executive\AdditionalCriticalWorkerThreads
    ```

    The default is 0, which means that no additional critical kernel worker threads are added. This value affects the number of threads that the file system cache uses for read-ahead and write-behind requests. Raising this value can allow for more queued I/O in the storage subsystem, and it can improve I/O performance, particularly on systems with many logical processors and powerful storage hardware.

    **Tip**  
    The value may need to be increased if the amount of cache manager dirty data (performance counter Cache\\Dirty Pages) is growing to consume a large portion (over ~25%) of memory or if the system is doing lots of synchronous read I/Os.

     

-   **MaxThreadsPerQueue**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters\MaxThreadsPerQueue
    ```

    The default is 20. Increasing this value raises the number of threads that the file server can use to service concurrent requests. When a large number of active connections need to be serviced, and hardware resources, such as storage bandwidth, are sufficient, increasing the value can improve server scalability, performance, and response times.

    **Tip**  
    An indication that the value may need to be increased is if the SMB2 work queues are growing very large (performance counter ‘Server Work Queues\\Queue Length\\SMB2 NonBlocking \*’ is consistently above ~100).

     

-   **AsynchronousCredits**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters\MaxThreadsPerQueue
    ```

    The default is 512. This parameter limits the number of concurrent asynchronous SMB commands that are allowed on a single connection. Some cases (such as when there is a front-end server with a back-end IIS server) require a large amount of concurrency (for file change notification requests, in particular). The value of this entry can be increased to support these cases.

### SMB server tuning example

The following settings can optimize a computer for file server performance in many cases. The settings are not optimal or appropriate on all computers. You should evaluate the impact of individual settings before applying them.

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Value</th>
<th>Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>AdditionalCriticalWorkerThreads</p></td>
<td><p>64</p></td>
<td><p>0</p></td>
</tr>
<tr class="even">
<td><p>MaxThreadsPerQueue</p></td>
<td><p>64</p></td>
<td><p>20</p></td>
</tr>
<tr class="odd">
<td><p>MaxMpxCt (only applicable to SMB 1.0 clients)</p></td>
<td><p>32768</p></td>
<td><p>50</p></td>
</tr>
</tbody>
</table>

 

## <a href="" id="servicesnfs"></a>Services for NFS model


The following sections provide information about the Microsoft Services for Network File System (NFS) model for client-server communication. Since NFS v2 and NFS v3 are still the most widely deployed versions of the protocol, all of the registry keys except for MaxConcurrentConnectionsPerIp apply to NFS v2 and NFS v3 only.

No registry tuning is required for NFS v4.1 protocol.

### Service for NFS model overview

Microsoft Services for NFS provides a file-sharing solution for enterprises that have a mixed Windows and UNIX environment. This communication model consists of client computers and a server. Applications on the client request files that are located on the server through the redirector (Rdbss.sys) and NFS mini-redirector (Nfsrdr.sys). The mini-redirector uses the NFS protocol to send its request through TCP/IP. The server receives multiple requests from the clients through TCP/IP and routes the requests to the local file system (Ntfs.sys), which accesses the storage stack.

The following figure shows the communication model for NFS.

![nfs communication model](../media/performance-tuning/perftune-guide-nfs-model.png)

### Tuning parameters for NFS file servers

The following REG\_DWORD registry settings can affect the performance of NFS file servers:

-   **OptimalReads**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\NfsServer\Parameters\OptimalReads
    ```

    The default is 0. This parameter determines whether files are opened for FILE\_RANDOM\_ACCESS or for FILE\_SEQUENTIAL\_ONLY, depending on the workload I/O characteristics. Set this value to 1 to force files to be opened for FILE\_RANDOM\_ACCESS. FILE\_RANDOM\_ACCESS prevents the file system and cache manager from prefetching.

    **Note**  
    This setting must be carefully evaluated because it may have potential impact on system file cache grow.

     

-   **RdWrHandleLifeTime**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\NfsServer\Parameters\RdWrHandleLifeTime
    ```

    The default is 5. This parameter controls the lifetime of an NFS cache entry in the file handle cache. The parameter refers to cache entries that have an associated open NTFS file handle. Actual lifetime is approximately equal to RdWrHandleLifeTime multiplied by RdWrThreadSleepTime. The minimum is 1 and the maximum is 60.

-   **RdWrNfsHandleLifeTime**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\NfsServer\Parameters\RdWrNfsHandleLifeTime
    ```

    The default is 5. This parameter controls the lifetime of an NFS cache entry in the file handle cache. The parameter refers to cache entries that do not have an associated open NTFS file handle. Services for NFS uses these cache entries to store file attributes for a file without keeping an open handle with the file system. Actual lifetime is approximately equal to RdWrNfsHandleLifeTime multiplied by RdWrThreadSleepTime. The minimum is 1 and the maximum is 60.

-   **RdWrNfsReadHandlesLifeTime**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\NfsServer\Parameters\RdWrNfsReadHandlesLifeTime
    ```

    The default is 5. This parameter controls the lifetime of an NFS read cache entry in the file handle cache. Actual lifetime is approximately equal to RdWrNfsReadHandlesLifeTime multiplied by RdWrThreadSleepTime. The minimum is 1 and the maximum is 60.

-   **RdWrThreadSleepTime**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\NfsServer\Parameters\RdWrThreadSleepTime
    ```

    The default is 5. This parameter controls the wait interval before running the cleanup thread on the file handle cache. The value is in ticks, and it is non-deterministic. A tick is equivalent to approximately 100 nanoseconds. The minimum is 1 and the maximum is 60.

-   **FileHandleCacheSizeinMB**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\NfsServer\Parameters\FileHandleCacheSizeinMB
    ```

    The default is 4. This parameter specifies the maximum memory to be consumed by file handle cache entries. The minimum is 1 and the maximum is 1\*1024\*1024\*1024 (1073741824).

-   **LockFileHandleCacheInMemory**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\NfsServer\Parameters\LockFileHandleCacheInMemory
    ```

    The default is 0. This parameter specifies whether the physical pages that are allocated for the cache size specified by FileHandleCacheSizeInMB are locked in memory. Setting this value to 1 enables this activity. Pages are locked in memory (not paged to disk), which improves the performance of resolving file handles, but reduces the memory that is available to applications.

-   **MaxIcbNfsReadHandlesCacheSize**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\NfsServer\Parameters\MaxIcbNfsReadHandlesCacheSize
    ```

    The default is 64. This parameter specifies the maximum number of handles per volume for the read data cache. Read cache entries are created only on systems that have more than 1 GB of memory. The minimum is 0 and the maximum is 0xFFFFFFFF.

-   **HandleSigningEnabled**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\NfsServer\Parameters\HandleSigningEnabled
    ```

    The default is 1. This parameter controls whether handles that are given out by NFS File Server are signed cryptographically. Setting it to 0 disables handle signing.

-   **RdWrNfsDeferredWritesFlushDelay**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\NfsServer\Parameters\RdWrNfsDeferredWritesFlushDelay
    ```

    The default is 60. This parameter is a soft timeout that controls the duration of NFS V3 UNSTABLE Write data caching. The minimum is 1, and the maximum is 600. Actual lifetime is approximately equal to RdWrNfsDeferredWritesFlushDelay multiplied by RdWrThreadSleepTime.

-   **CacheAddFromCreateAndMkDir**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\NfsServer\Parameters\CacheAddFromCreateAndMkDir
    ```

    The default is 1 (enabled). This parameter controls whether handles that are opened during NFS V2 and V3 CREATE and MKDIR RPC procedure handlers are retained in the file handle cache. Set this value to 0 to disable adding entries to the cache in CREATE and MKDIR code paths.

-   **AdditionalDelayedWorkerThreads**

    ``` syntax
    HKLM\SYSTEM\CurrentControlSet\Control\SessionManager\Executive\AdditionalDelayedWorkerThreads
    ```

    Increases the number of delayed worker threads that are created for the specified work queue. Delayed worker threads process work items that are not considered time-critical and that can have their memory stack paged out while waiting for work items. An insufficient number of threads reduces the rate at which work items are serviced; a value that is too high consumes system resources unnecessarily.

-   **NtfsDisable8dot3NameCreation**

    ``` syntax
    HKLM\System\CurrentControlSet\Control\FileSystem\NtfsDisable8dot3NameCreation
    ```

    The default in Windows Server 2012 and Windows Server 2012 R2 is 2. In releases prior to Windows Server 2012, the default is 0. This parameter determines whether NTFS generates a short name in the 8dot3 (MSDOS) naming convention for long file names and for file names that contain characters from the extended character set. If the value of this entry is 0, files can have two names: the name that the user specifies and the short name that NTFS generates. If the user-specified name follows the 8dot3 naming convention, NTFS does not generate a short name. A value of 2 means that this parameter can be configured per volume.

    **Note**  
    The system volume has 8dot3 enabled by default. All other volumes in Windows Server 2012 and Windows Server 2012 R2 have 8dot3 disabled by default. Changing this value does not change the contents of a file, but it avoids the short-name attribute creation for the file, which also changes how NTFS displays and manages the file. For most file servers, the recommended setting is 1 (disabled).

     

-   **NtfsDisableLastAccessUpdate**

    ``` syntax
    HKLM\System\CurrentControlSet\Control\FileSystem\NtfsDisableLastAccessUpdate
    ```

    The default is 1. This system-global switch reduces disk I/O load and latencies by disabling the updating of the date and time stamp for the last file or directory access.

-   **MaxConcurrentConnectionsPerIp**

    ``` syntax
    HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Rpcxdr\Parameters\MaxConcurrentConnectionsPerIp
    ```

    The default value of the MaxConcurrentConnectionsPerIp parameter is 16. You can increase this value up to a maximum of 8192 to increase the number of connections per IP address.

## <a href="" id="clients"></a>General tuning parameters for clients


The following REG\_DWORD registry settings can affect the performance of client computers that interact with SMB or NFS file servers:

-   **ConnectionCountPerNetworkInterface**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\ConnectionCountPerNetworkInterface
    ```

    Applies to Windows 8.1, Windows 8, Windows Server 2012, and Windows Server 2012 R2

    The default is 1, with a valid range from 1-16. The maximum number of connections per interface to be established with a server running Windows Server 2012 for non-RSS interfaces.

-   **ConnectionCountPerRssNetworkInterface**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\ConnectionCountPerRssNetworkInterface
    ```

    Applies to Windows 8.1, Windows 8, Windows Server 2012, and Windows Server 2012 R2

    The default is 4, with a valid range from 1-16. The maximum number of connections per interface to be established with a server running Windows Server 2012 for RSS interfaces.

-   **ConnectionCountPerRdmaNetworkInterface**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\ConnectionCountPerRdmaNetworkInterface
    ```

    Applies to Windows 8.1, Windows 8, Windows Server 2012, and Windows Server 2012 R2

    The default is 2, with a valid range from 1-16. The maximum number of connections per interface to be established with server running Windows Server 2012 for RDMA interfaces.

-   **MaximumConnectionCountPerServer**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\MaximumConnectionCountPerServer
    ```

    Applies to Windows 8.1, Windows 8, Windows Server 2012, and Windows Server 2012 R2

    The default is 32, with a valid range from 1-64. The maximum number of connections to be established with a single server running Windows Server 2012 across all interfaces.

-   **DormantDirectoryTimeout**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\DormantDirectoryTimeout
    ```

    Applies to Windows 8.1, Windows 8, Windows Server 2012, and Windows Server 2012 R2

    The default is 600 seconds. The maximum time server directory handles held open with directory leases.

-   **FileInfoCacheLifetime**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\FileInfoCacheLifetime
    ```

    Applies to Windows 8.1, Windows 8, Windows Server 2012, Windows Server 2012 R2, Windows 7, and Windows Vista

    The default is 10 seconds. The file information cache timeout period.

-   **DirectoryCacheLifetime**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\DirectoryCacheLifetime
    ```

    Applies to Windows 7 and Windows Vista

    The default is 10 seconds. This is the directory cache timeout.

    **Note**  
    This parameter controls caching of directory metadata in the absence of directory leases.

     

-   **DirectoryCacheEntrySizeMax**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\DirectoryCacheEntrySizeMax
    ```

    Applies to Windows 8.1, Windows 8, Windows Server 2012, Windows Server 2012 R2, Windows 7, and Windows Vista

    The default is 64 KB. This is the maximum size of directory cache entries.

-   **FileNotFoundCacheLifetime**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\FileNotFoundCacheLifetime
    ```

    Applies to Windows 8.1, Windows 8, Windows Server 2012, Windows Server 2012 R2, Windows 7, and Windows Vista

    The default is 5 seconds. The file not found cache timeout period.

-   **CacheFileTimeout**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\CacheFileTimeout
    ```

    Applies to Windows 8.1, Windows 8, Windows Server 2012, Windows Server 2012 R2, and Windows 7

    The default is 10 seconds. This setting controls the length of time (in seconds) that the redirector will hold on to cached data for a file after the last handle to the file is closed by an application.

-   **DisableBandwidthThrottling**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\DisableBandwidthThrottling
    ```

    Applies to Windows 8.1, Windows 8, Windows Server 2012, Windows Server 2012 R2, Windows 7, and Windows Vista

    The default is 0. By default, the SMB redirector throttles throughput across high-latency network connections, in some cases to avoid network-related timeouts. Setting this registry value to 1 disables this throttling, enabling higher file transfer throughput over high-latency network connections.

-   **DisableLargeMtu**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\DisableLargeMtu
    ```

    Applies to Windows 8.1, Windows 8, Windows Server 2012, Windows Server 2012 R2, Windows 7, and Windows Vista

    The default is 0 for Windows 8 only. In Windows 8, the SMB redirector transfers payloads as large as 1 MB per request, which can improve file transfer speed. Setting this registry value to 1 limits the request size to 64 KB. You should evaluate the impact of this setting before applying it.

-   **RequireSecuritySignature**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\RequireSecuritySignature
    ```

    Applies to Windows 8.1, Windows 8, Windows Server 2012, Windows Server 2012 R2, Windows 7, and Windows Vista

    The default is 0. Changing this value to 1 prevents SMB communication with computers where SMB signing is disabled. In addition, a value of 1 causes SMB signing to be used for all SMB communication. SMB signing can increase CPU cost and network round trips. If SMB signing is not required, ensure that this registry value is 0 on all clients and servers.

-   **FileInfoCacheEntriesMax**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\FileInfoCacheEntriesMax
    ```

    Applies to Windows 8.1, Windows 8, Windows Server 2012, Windows Server 2012 R2, Windows 7, and Windows Vista

    The default is 64, with a valid range of 1 to 65536. This value is used to determine the amount of file metadata that can be cached by the client. Increasing the value can reduce network traffic and increase performance when a large number of files are accessed.

-   **DirectoryCacheEntriesMax**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\DirectoryCacheEntriesMax
    ```

    Applies to Windows 8.1, Windows 8, Windows Server 2012, Windows Server 2012 R2, Windows 7, and Windows Vista

    The default is 16, with a valid range of 1 to 4096. This value is used to determine the amount of directory information that can be cached by the client. Increasing the value can reduce network traffic and increase performance when large directories are accessed.

-   **FileNotFoundCacheEntriesMax**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\FileNotFoundCacheEntriesMax
    ```

    Applies to Windows 8.1, Windows 8, Windows Server 2012, Windows Server 2012 R2, Windows 7, and Windows Vista

    The default is 128, with a valid range of 1 to 65536. This value is used to determine the amount of file name information that can be cached by the client. Increasing the value can reduce network traffic and increase performance when a large number of file names are accessed.

-   **MaxCmds**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\MaxCmds
    ```

    Applies to Windows 8.1, Windows 8, Windows Server 2012, Windows Server 2012 R2, Windows 7, and Windows Vista

    The default is 15. This parameter limits the number of outstanding requests on a session. Increasing the value can use more memory, but it can improve performance by enabling a deeper request pipeline. Increasing the value in conjunction with MaxMpxCt can also eliminate errors that are encountered due to large numbers of outstanding long-term file requests, such as FindFirstChangeNotification calls. This parameter does not affect connections with SMB 2.0 servers.

-   **DormantFileLimit**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\DormantFileLimit
    ```

    Applies to Windows 8.1, Windows 8, Windows Server 2012, Windows Server 2012 R2, Windows 7, Windows Vista, and Windows XP

    The default is 1023. This parameter specifies the maximum number of files that should be left open on a shared resource after the application has closed the file.

### Client tuning example

The general tuning parameters for client computers can optimize a computer for accessing remote file shares, particularly over some high-latency networks (such as branch offices, cross-datacenter communication, home offices, and mobile broadband). The settings are not optimal or appropriate on all computers. You should evaluate the impact of individual settings before applying them.

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Value</th>
<th>Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>DisableBandwidthThrottling</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
</tr>
<tr class="even">
<td><p>RequireSecuritySignature</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
</tr>
<tr class="odd">
<td><p>FileInfoCacheEntriesMax</p></td>
<td><p>32768</p></td>
<td><p>64</p></td>
</tr>
<tr class="even">
<td><p>DirectoryCacheEntriesMax</p></td>
<td><p>4096</p></td>
<td><p>16</p></td>
</tr>
<tr class="odd">
<td><p>FileNotFoundCacheEntriesMax</p></td>
<td><p>32768</p></td>
<td><p>128</p></td>
</tr>
<tr class="even">
<td><p>MaxCmds</p></td>
<td><p>32768</p></td>
<td><p>15</p></td>
</tr>
<tr class="odd">
<td><p>DormantFileLimit [Windows XP only]</p></td>
<td><p>32768</p></td>
<td><p>1023</p></td>
</tr>
<tr class="even">
<td><p>ScavengerTimeLimit [Windows XP only]</p></td>
<td><p>60</p></td>
<td><p>10</p></td>
</tr>
</tbody>
</table>

 

Starting in Windows 8, you can configure many of these file server settings by using the **Get-SmbServerConfiguration** and **Set-SmbServerConfiguration** Windows PowerShell cmdlets. Registry-only settings can be configured by using Windows PowerShell as well.

``` syntax
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" RequireSecuritySignature -Value 0 -Force
```

### SMB client performance monitor counters

For more info about SMB client counters, see [Windows Server 2012 File Server Tip: New per-share SMB client performance counters provide great insight](http://blogs.technet.com/b/josebda/archive/2012/11/19/windows-server-2012-file-server-tip-new-per-share-smb-client-performance-counters-provide-great-insight.aspx).

## Related topics


[Performance Tuning for Server Roles](performance-tuning-for-server-roles.md)

[Using the File Server Capacity Tool (FSCT)](using-the-file-server-capacity-tool--fsct-.md)

[Using the SPECsfs2008 File Server](using-the-specsfs2008-file-server.md)

