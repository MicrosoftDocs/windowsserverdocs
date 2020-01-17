---
title: Performance Tuning for SMB File Servers
description: Performance Tuning for SMB File Servers
ms.prod: windows-server
ms.technology: performance-tuning-guide
ms.topic: article
author: phstee
ms.author: NedPyle; Danlo; DKruse
ms.date: 4/14/2017
---
# Performance tuning for SMB file servers

## SMB configuration considerations
Do not enable any services or features that your file server and clients do not require. These might include SMB signing, client-side caching, file system mini-filters, search service, scheduled tasks, NTFS encryption, NTFS compression, IPSEC, firewall filters, Teredo, and SMB encryption.

Ensure that the BIOS and operating system power management modes are set as needed, which might include High Performance mode or altered C-State. Ensure that the latest, most resilient, and fastest storage and networking device drivers are installed.

Copying files is a common operation performed on a file server. Windows Server has several built-in file copy utilities that you can run by using a command prompt. Robocopy is recommended. Introduced in Windows Server 2008 R2, the **/mt** option of Robocopy can significantly improve speed on remote file transfers by using multiple threads when copying multiple small files. We also recommend using the **/log** option to reduce console output by redirecting logs to a NUL device or to a file. When you use Xcopy, we recommend adding the **/q** and **/k** options to your existing parameters. The former option reduces CPU overhead by reducing console output and the latter reduces network traffic.

## SMB performance tuning


File server performance and available tunings depend on the SMB protocol that is negotiated between each client and the server, and on the deployed file server features. The highest protocol version currently available is SMB 3.1.1 in Windows Server 2016 and Windows 10. You can check which version of SMB is in use on your network by using Windows PowerShell **Get-SMBConnection** on clients and **Get-SMBSession | FL** on servers.

### SMB 3.0 protocol family

SMB 3.0 was introduced in Windows Server 2012 and further enhanced in Windows Server 2012 R2 (SMB 3.02) and Windows Server 2016 (SMB 3.1.1). This version introduced technologies that may significantly improve performance and availability of the file server. For more info, see [SMB in Windows Server 2012 and 2012 R2 2012](https://aka.ms/smb3plus) and [What's new in SMB 3.1.1](https://aka.ms/smb311).



### SMB Direct

SMB Direct introduced the ability to use RDMA network interfaces for high throughput with low latency and low CPU utilization.

Whenever SMB detects an RDMA-capable network, it automatically tries to use the RDMA capability. However, if for any reason the SMB client fails to connect using the RDMA path, it will simply continue to use TCP/IP connections instead. All RDMA interfaces that are compatible with SMB Direct are required to also implement a TCP/IP stack, and SMB Multichannel is aware of that.

SMB Direct is not required in any SMB configuration, but it' s always recommended for those who want lower latency and lower CPU utilization.

For more info about SMB Direct, see [Improve Performance of a File Server with SMB Direct](https://aka.ms/smbdirect).

### SMB Multichannel

SMB Multichannel allows file servers to use multiple network connections simultaneously and provides increased throughput.

For more info about SMB Multichannel, see [Deploy SMB Multichannel](https://aka.ms/smbmulti).

### SMB Scale-Out

SMB Scale-out allows SMB 3.0 in a cluster configuration to show a share in all nodes of a cluster. This active/active configuration makes it possible to scale file server clusters further, without a complex configuration with multiple volumes, shares and cluster resources. The maximum share bandwidth is the total bandwidth of all file server cluster nodes. The total bandwidth is no longer limited by the bandwidth of a single cluster node, but rather depends on the capability of the backing storage system. You can increase the total bandwidth by adding nodes.

For more info about SMB Scale-Out, see [Scale-Out File Server for Application Data Overview](https://technet.microsoft.com/library/hh831349.aspx) and the blog post [To scale out or not to scale out, that is the question](https://blogs.technet.com/b/filecab/archive/2013/12/05/to-scale-out-or-not-to-scale-out-that-is-the-question.aspx).

### Performance counters for SMB 3.0

The following SMB performance counters were introduced in Windows Server 2012, and they are considered a base set of counters when you monitor the resource usage of SMB 2 and higher versions. Log the performance counters to a local, raw (.blg) performance counter log. It is less expensive to collect all instances by using the wildcard character (\*), and then extract particular instances during post-processing by using Relog.exe.

-   **SMB Client Shares**

    These counters display information about file shares on the server that are being accessed by a client that is using SMB 2.0 or higher versions.

    If you' re familiar with the regular disk counters in Windows, you might notice a certain resemblance. That' s not by accident. The SMB client shares performance counters were designed to exactly match the disk counters. This way you can easily reuse any guidance on application disk performance tuning you currently have. For more info about counter mapping, see [Per share client performance counters blog](https://blogs.technet.com/b/josebda/archive/2012/11/19/windows-server-2012-file-server-tip-new-per-share-smb-client-performance-counters-provide-great-insight.aspx).

-   **SMB Server Shares**

    These counters display information about the SMB 2.0 or higher file shares on the server.

-   **SMB Server Sessions**

    These counters display information about SMB server sessions that are using SMB 2.0 or higher.

    Turning on counters on server side (server shares or server sessions) may have significant performance impact for high IO workloads.

-   **Resume Key Filter**

    These counters display information about the Resume Key Filter.

-   **SMB Direct Connection**

    These counters measure different aspects of connection activity. A computer can have multiple SMB Direct connections. The SMB Direct Connection counters represent each connection as a pair of IP addresses and ports, where the first IP address and port represent the connection's local endpoint, and the second IP address and port represent the connection's remote endpoint.

-   **Physical Disk, SMB, CSV FS performance counters relationships**

    For more info on how Physical Disk, SMB, and CSV FS (file system) counters are related, see the following blog post: [Cluster Shared Volume Performance Counters](https://blogs.msdn.com/b/clustering/archive/2014/06/05/10531462.aspx).

## Tuning parameters for SMB file servers


The following REG\_DWORD registry settings can affect the performance of SMB file servers:

- **Smb2CreditsMin** and **Smb2CreditsMax**

  ```
  HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters\Smb2CreditsMin
  ```

  ```
  HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters\Smb2CreditsMax
  ```

  The defaults are 512 and 8192, respectively. These parameters allow the server to throttle client operation concurrency dynamically within the specified boundaries. Some clients might achieve increased throughput with higher concurrency limits, for example, copying files over high-bandwidth, high-latency links.
    
  > [!TIP]
  > Prior to Windows 10 and Windows Server 2016, the number of credits granted to the client varied dynamically between Smb2CreditsMin and Smb2CreditsMax based on an algorithm that attempted to determine the optimal number of credits to grant based on network latency and credit usage. In Windows 10 and Windows Server 2016, the SMB server was changed to unconditionally grant credits upon request up to the configured maximum number of credits. As part of this change, the credit throttling mechanism, which reduces the size of each connection's credit window when the server is under memory pressure, was removed. The kernel's low memory event that triggered throttling is only signaled when the server is so low on memory (< a few MB) as to be useless. Since the server no longer shrinks credit windows the Smb2CreditsMin setting is no longer necessary and is now ignored.
  > 
  > You can monitor SMB Client Shares\\Credit Stalls /Sec to see if there are any issues with credits.

- **AdditionalCriticalWorkerThreads**

    ```
    HKLM\System\CurrentControlSet\Control\Session Manager\Executive\AdditionalCriticalWorkerThreads
    ```

    The default is 0, which means that no additional critical kernel worker threads are added. This value affects the number of threads that the file system cache uses for read-ahead and write-behind requests. Raising this value can allow for more queued I/O in the storage subsystem, and it can improve I/O performance, particularly on systems with many logical processors and powerful storage hardware.

    >[!TIP]
    > The value may need to be increased if the amount of cache manager dirty data (performance counter Cache\\Dirty Pages) is growing to consume a large portion (over ~25%) of memory or if the system is doing lots of synchronous read I/Os.

- **MaxThreadsPerQueue**

  ```
  HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters\MaxThreadsPerQueue
  ```

  The default is 20. Increasing this value raises the number of threads that the file server can use to service concurrent requests. When a large number of active connections need to be serviced, and hardware resources, such as storage bandwidth, are sufficient, increasing the value can improve server scalability, performance, and response times.

  >[!TIP]
  > An indication that the value may need to be increased is if the SMB2 work queues are growing very large (performance counter ‘Server Work Queues\\Queue Length\\SMB2 NonBlocking \*'  is consistently above ~100).

  >[!Note]
  >In Windows 10 and Windows Server 2016, MaxThreadsPerQueue is unavailable. The number of threads for a thread pool will be "20 * the number of processors in a NUMA node".
     

- **AsynchronousCredits**

  ``` 
  HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters\AsynchronousCredits
  ```

  The default is 512. This parameter limits the number of concurrent asynchronous SMB commands that are allowed on a single connection. Some cases (such as when there is a front-end server with a back-end IIS server) require a large amount of concurrency (for file change notification requests, in particular). The value of this entry can be increased to support these cases.

### SMB server tuning example

The following settings can optimize a computer for file server performance in many cases. The settings are not optimal or appropriate on all computers. You should evaluate the impact of individual settings before applying them.

| Parameter                       | Value | Default |
|---------------------------------|-------|---------|
| AdditionalCriticalWorkerThreads | 64    | 0       |
| MaxThreadsPerQueue              | 64    | 20      |


### SMB client performance monitor counters

For more info about SMB client counters, see [Windows Server 2012 File Server Tip: New per-share SMB client performance counters provide great insight](https://blogs.technet.com/b/josebda/archive/2012/11/19/windows-server-2012-file-server-tip-new-per-share-smb-client-performance-counters-provide-great-insight.aspx).
