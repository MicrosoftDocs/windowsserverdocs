---
title: Performance Tuning for SMB File Servers
description: Performance Tuning for SMB File Servers
---

# Performance Tuning For SMB File Servers

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

 



### SMB client performance monitor counters

For more info about SMB client counters, see [Windows Server 2012 File Server Tip: New per-share SMB client performance counters provide great insight](http://blogs.technet.com/b/josebda/archive/2012/11/19/windows-server-2012-file-server-tip-new-per-share-smb-client-performance-counters-provide-great-insight.aspx).
