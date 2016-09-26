---
title: Performance Tuning for the Sales and Distribution Workload
description: Performance Tuning for the Sales and Distribution Workload
---

# Performance Tuning for the Sales and Distribution Workload


SAP AG has developed several standard application benchmarks. The Sales and Distribution workload represents one of the important classes of workloads that are used to benchmark SAP enterprise resource planning installations. The updates to SAP include added requirements, such as sub-second response time and a Unicode code page. For more information, see [SAP with Microsoft SQL Server 2008 and SQL Server 2005: Best Practices for High Availability, Maximum Performance, and Scalability](http://www.sdn.sap.com/?rid=/library/uuid/4ab89e84-0d01-0010-cda2-82ddc3548c65).

You can perform multidimensional tuning of the operating system level, application server, database server, network, and storage to achieve optimal throughput and good response times as the number of concurrent sales and distribution users increases before performance levels off because of resource limitations.

The following sections provide guidelines that can benefit two and three tier configurations for sales and distribution benchmarks for SAP enterprise resource planning in Windows Server 2012. Some of these recommendations might not apply to the same degree for production systems.

**In this topic:**

-   [Operating system tunings on the server](#os)

-   [Database server tunings](#db)

-   [SAP application server tunings](#sapapp)

-   [Monitoring and data collection](#monitoring)

## <a href="" id="os"></a>Operating system tunings on the server


Configure the following in advanced system settings:

-   Under the **Performance** heading, click **Settings**, click **Advanced**, and then click **Change**. Set one or more fixed-size page files where the **Initial Size** equals **Maximum Size**. The page file size should meet the total virtual memory requirements of the workload. Make sure that no system-managed page files are in virtual memory on the application server.

-   Under the **Performance** heading, click **Settings**, click **Visual Effects**, and then click the **Adjust for best performance** option.

-   To enable SQL to use large pages, configure the **Lock pages in memory** user right assignment for the account that will run the SQL and SAP services by using Group Policy.

-   Disable User Account Control (UAC), and then restart the computer

    **Note**  
    Disabling UAC can be used for benchmark environments, but enabling UAC might be a security compliance requirement in production environments.

     

For virtualized environments, these settings apply across the host and virtual machine operating systems. For latency sensitive virtualized configurations, to partition network I/O processing from SAP computing resources, consider limiting the number of logical processors that are available for the VMQ interrupt processing. You can do this by configuring the base and maximum RSS logical processors.

## <a href="" id="db"></a>Database server tunings


When the database server is running Microsoft SQL Server, you should set the following SQL Server configuration options by using the sp\_configure stored procedure. For more info about sp\_configure, see [Server Configuration Options](http://msdn.microsoft.com/library/ms189631.aspx).

-   **Apply CPU affinity for the SQL Server process** Set an affinity mask to partition the SQL Server process on specific cores. If required, use the affinity64 mask server configuration option to set the affinity on more than 32 cores. In SQL Server 2012 and SQL Server 2008 R2, you can apply equivalent settings for configuring CPU affinity on as many as 640 logical processors by using the ALTER SERVER CONFIGURATION Transact-SQL statement because the sp\_configure affinity mask options are announced for deprecation.

    **Note**  
    For the current two-tier SAP Sales and Distribution benchmarks, it is typically sufficient to run SQL Server on one-eighth or fewer of the existing cores.

     

-   **Set a fixed amount of memory that the SQL Server process will use** Set the **max server memory** and **min server memory** equal and large enough to satisfy the workload (2500 MB is a good starting value).

On hardware that supports NUMA, you can do the following:

-   For information about how to subdivide the CPUs in a hardware NUMA node into more CPU nodes (known as Soft-NUMA), see Configure SQL Server to Use Soft-NUMA.

-   To provide NUMA node locality for SQL Server, set the preferred NUMA node hints (applies to Windows Server 2012 R2, Windows Server 2012, and Windows Server 2008 R2).

    -   Set the NUMA preferred node from an elevated command prompt:

        ``` syntax
        %windir%\system32\sc.exe [server] preferrednode <SQL Server service name> <NUMA node number>
        ```

    -   Query the setting:

        ``` syntax
        %windir%\system32\sc.exe [server] qpreferrednode <SQL Server service name>
        ```

    -   Remove the setting:

        ``` syntax
        %windir%\system32\sc.exe [server] preferrednode <SQL Server service name> -1
        ```

On a two-tier native enterprise resource planning SAP setup, consider enabling and using only the Named Pipes protocol and disabling the rest of the available protocols from the SQL Server Configuration Manager for the local SQL connections.

If SQL Server is running in a dedicated system or virtual machine, you should use TCP/IP.

## <a href="" id="sapapp"></a>SAP application server tunings


-   The ratio between the number of Dialog (D) processes versus Update (U) processes in the SAP enterprise resource planning installation might vary, but usually a ratio of 1D:1U or 2D:1U per logical processor is a good start for the Sales and Distribution workload. Ensure that in a SAP dialog instance, the number of worker processes and users does not exceed the capacity of the SAP dispatcher for that dialog instance (the current maximum is approximately 2,000 users per instance).

    On hardware that supports NUMA, consider installing one or more SAP dialog instances per NUMA node (depending on the number of logical processors per NUMA node that you want to use with SAP worker processes). The D:U ratio, and the overall number of SAP dialog instances per NUMA node or system, might be improved based on the analysis of previous experiments. For large virtual machines that span multiple NUMA nodes, virtual NUMA is available by default and can be used to partition dialog instances. For more information, see [Virtualizing SAP Applications on Windows](http://www.sdn.sap.com/?QuickLink=index&overridelayout=true&52102248287084).

-   For smaller virtual machines without virtual NUMA, the preferred NUMA node can be configured for each virtual machine for better load balancing and performance.

-   To further partition computing resources within an SAP instance, use the processor affinity capabilities in the SAP instance profiles to partition each worker process to a subset of the available logical processors. This provides better CPU and memory locality. The affinity setting in the SAP instance profiles is supported for 64 logical processors. The affinity setting is not recommended when running SAP worker processes inside a virtual machine because experiments have shown that SAP latency can be improved by allowing the guest and hypervisor schedulers to better allocate CPU resources.

-   For large scale virtual benchmark deployments, one needs to use at least D-VMQ and should enable RSS in the Microsoft Virtual Network Adapter properties of the virtual machine when using a 3-Tier configuration. For 2-Tier, configuration usage of RSS within the virtual machine is not necessary. On the host consider restricting the VMQ processors to logical processors (and NUMA nodes) on which contention with SAP virtual machines is minimized. For 2-Tier benchmark workloads, you should use SR-IOV-enabled network adapters. For 3-Tier configurations, the SR-IOV network adapters need to support RSS over SR-IOV since RSS within the virtual machine is required.

-   Running SAP SD benchmarks in virtual machines, the SAP memory should use large pages. For this purpose, the user context starting SAP requires the **Lock Pages in memory** user right assignment. The SAP profile parameter to enable large pages is em/largepages=yes

-   In Windows Server 2012 R2, Windows Server 2012, and Windows Server 2008 R2, the operating system supports more than 64 logical processors. On hardware that supports NUMA, you should set the preferred NUMA nodes in addition to setting hard affinities by using the following steps:

    -   Set the NUMA preferred node from an elevated command prompt:

        ``` syntax
        %windir%\system32\sc.exe [server] preferrednode <SQL Server service name> <NUMA node number>
        ```

    -   Query the setting:

        ``` syntax
        %windir%\system32\sc.exe [server] qpreferrednode <SQL Server service name>
        ```

    -   Remove the setting:

        ``` syntax
        %windir%\system32\sc.exe [server] preferrednode <SQL Server service name> -1
        ```

-   To allow each SAP worker process in a dialog instance to inherit the ideal NUMA node from its Win32 service, create the following REG\_DWORD registry entries for each of the Sapstartsrv.exe, Msg\_server.exe, Gwrd.exe, and Disp+work.exe images, and then set the "NodeOptions"=dword:00000100 value as follows:

    ``` syntax
    HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\
    ```

You can use [Coreinfo](http://technet.microsoft.com/sysinternals/cc835722.aspx) to provide topology details about logical and physical processors, processor sockets, NUMA nodes, and processor cache. For more info, see [Map TCP/IP Ports to NUMA Nodes](http://msdn.microsoft.com/library/ms345346.aspx).

## <a href="" id="monitoring"></a>Monitoring and data collection


The following list of performance counters is considered a base set of counters when you monitor the resource usage of the Application Server while you are running a non-virtualized SAP enterprise resource planning Sales and Distribution workload. Log the performance counters to a local (.blg) performance counter log. It is less expensive to collect all instances by using the wildcard character (\*), and then extract particular instances while post-processing by using Relog.exe as follows:

-   Cache\\\*

-   IPv4\\\*

-   LogicalDisk(\*)\\\*

-   Memory\\\*\\

-   Network Interface(\*)\\\*

-   Paging File(\*)\\\*

-   PhysicalDisk(\*)\\\*

-   Process(\*)\\\*

-   Processor Information(\*)\\\*

-   Synchronization(\*)\\\*

-   System\\\*

-   TCPv4\\\*

-   SQLServer:Buffer Manager\\Lazy writes/sec

**Note**  
If applicable, add the \\IPv6\\\* and \\TCPv6\\\* objects.

 

For virtualized configurations of the SAP enterprise resource planning Sales and Distribution workload, use the following list of performance counters to monitor the Hyper-V host:

-   \\Hyper-V Hypervisor Partition(\*)\\\*

-   \\Hyper-V Hypervisor Root Partition(\*)\\\*

-   \\Hyper-V Hypervisor Logical Processor(\*)\\\*

-   \\Hyper-V Hypervisor Root Virtual Processor(\*)\\\*

-   \\Hyper-V Hypervisor Virtual Processor(\*)\\\*

-   \\Hyper-V Dynamic Memory Balancer(\*)\\\*

-   \\Hyper-V Dynamic Memory VM(\*)\\\*

-   \\Hyper-V VM Vid Numa Node(\*)\\\*

-   \\Hyper-V VM Vid Partition(\*)\\\*

-   \\PhysicalDisk(\*)\\\*

-   \\Hyper-V Virtual Storage Device(\*)\\\*

-   \\Network Interface(\*)\\\*

-   \\Hyper-V Virtual Network Adapter(\*)\\\*

-   \\Hyper-V Virtual Switch(\*)\\\*

-   \\Hyper-V Virtual Switch Processor(\*)\\\*

## Related topics


[Performance Tuning for Workloads](performance-tuning-for-workloads.md)
