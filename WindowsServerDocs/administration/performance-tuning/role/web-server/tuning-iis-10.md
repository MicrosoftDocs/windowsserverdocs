---
title: Tuning IIS 10.0
description: Performance tuning recommmendations for IIS 10.0 web servers on Windows Server 16
ms.prod: windows-server-threshold
ms.technology: performance-tuning-guide
ms.topic: landing-page
ms.author: DavSo; Ericam; YaShi
author: phstee
ms.date: 10/16/2017
---

# Tuning IIS 10.0

Internet Information Services (IIS) 10.0 is included with Windows ServerÂ 2016. It uses a process model similar to that of IIS 8.5 and IIS 7.0. A kernel-mode web driver (http.sys) receives and routes HTTP requests, and satisfies requests from its response cache. Worker processes register for URL subspaces, and http.sys routes the request to the appropriate process (or set of processes for application pools).

HTTP.sys is responsible for connection management and request handling. The request can be served from the HTTP.sys cache or passed to a worker process for further handling. Multiple worker processes can be configured, which provides isolation at a reduced cost. For more info on how request handling works, see the following figure:

![request handling in iis 10.0](../../media/perftune-guide-iis-request-handling.png)

HTTP.sys includes a response cache. When a request matches an entry in the response cache, HTTP.sys sends the cache response directly from kernel mode. Some web application platforms, such as ASP.NET, provide mechanisms to enable any dynamic content to be cached in the kernel-mode cache. The static file handler in IIS 10.0 automatically caches frequently requested files in http.sys.

Because a web server has kernel-mode and user-mode components, both components must be tuned for optimal performance. Therefore, tuning IIS 10.0 for a specific workload includes configuring the following:

-   HTTP.sys and the associated kernel-mode cache

-   Worker processes and user-mode IIS, including the application pool configuration

-   Certain tuning parameters that affect performance

The following sections discuss how to configure the kernel-mode and user-mode aspects of IIS 10.0.

## Kernel-mode settings

Performance-related HTTP.sys settings fall into two broad categories: cache management and connection and request management. All registry settings are stored under the following registry entry:

``` syntax
HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Http\Parameters
```

**Note** 
If the HTTP service is already running, you must restart it for the changes to take effect.

Â 

## Cache management settings

One benefit that HTTP.sys provides is a kernel-mode cache. If the response is in the kernel-mode cache, you can satisfy an HTTP request entirely from the kernel mode, which significantly lowers the CPU cost of handling the request. However, the kernel-mode cache of IIS 10.0 is based on physical memory, and the cost of an entry is the memory that it occupies.

An entry in the cache is helpful only when it is used. However, the entry always consumes physical memory, whether or not the entry is being used. You must evaluate the usefulness of an item in the cache (the savings from being able to serve it from the cache) and its cost (the physical memory occupied) over the lifetime of the entry by considering the available resources (CPU and physical memory) and the workload requirements. HTTP.sys tries to keep only useful, actively accessed items in the cache, but you can increase the performance of the web server by tuning the HTTP.sys cache for particular workloads.

The following are some useful settings for the HTTP.sys kernel-mode cache:

-   **UriEnableCache** Default value: 1

    A non-zero value enables the kernel-mode response and fragment caching. For most workloads, the cache should remain enabled. Consider disabling the cache if you expect a very low response and fragment caching.

-   **UriMaxCacheMegabyteCount** Default value: 0

    A non-zero value that specifies the maximum memory that is available to the kernel-mode cache. The default value, 0, enables the system to automatically adjust how much memory is available to the cache.

    **Note**
    Specifying the size sets only the maximum, and the system might not let the cache grow to the maximum set size.

    Â 

-   **UriMaxUriBytes** Default value: 262144 bytes (256 KB)

    The maximum size of an entry in the kernel-mode cache. Responses or fragments larger than this are not cached. If you have enough memory, consider increasing the limit. If memory is limited and large entries are crowding out smaller ones, it might be helpful to lower the limit.

-   **UriScavengerPeriod** Default value: 120 seconds

    The HTTP.sys cache is periodically scanned by a scavenger, and entries that are not accessed between scavenger scans are removed. Setting the scavenger period to a high value reduces the number of scavenger scans. However, the cache memory usage might increase because older, less frequently accessed entries can remain in the cache. Setting the period too low causes more frequent scavenger scans, and it can result in too many flushes and cache churn.

## Request and connection management settings

In Windows Server 2016, HTTP.sys manages connections automatically. The following registry settings are no longer used:

-   **MaxConnections**

    ``` syntax
    HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Http\Parameters\MaxConnections
    ```

-   **IdleConnectionsHighMark**

    ``` syntax
    HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Http\Parameters\IdleConnectionsHighMark
    ```

-   **IdleConnectionsLowMark**

    ``` syntax
    HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Http\Parameters\IdleConnectionsLowMark
    ```

-   **IdleListTrimmerPeriod**

    ``` syntax
    HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Http\Parameters\IdleListTrimmerPeriod
    ```

-   **RequestBufferLookasideDepth**

    ``` syntax
    HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Http\Parameters\RequestBufferLookasideDepth
    ```

-   **InternalRequestLookasideDepth**

    ``` syntax
    HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Http\Parameters\InternalRequestLookasideDepth
    ```


## User-mode settings

The settings in this section affect the IISÂ 10.0 worker process behavior. Most of these settings can be found in the following XML configuration file:

%SystemRoot%\\system32\\inetsrv\\config\\applicationHost.config

Use Appcmd.exe, the IIS 10.0 Management Console, the WebAdministration or IISAdministration PowerShell Cmdlets to change them. Most settings are automatically detected, and they do not require a restart of the IIS 10.0 worker processes or web application server. For more info about the applicationHost.config file, see [Introduction to ApplicationHost.config](http://www.iis.net/learn/get-started/planning-your-iis-architecture/introduction-to-applicationhostconfig).


## Ideal CPU setting for NUMA hardware

Starting from Windows 2016, IIS 10.0 supports automatic ideal CPU assignment for its thread pool threads to enhance the performance and scalability on NUMA hardware. This feature is enabled by default and can be configured through the following registry key:

``` syntax
HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\ThreadPoolUseIdealCpu
```

With this feature enabled, IIS thread manager makes its best effort to evenly distribute IIS thread pool threads across all CPUs in all NUMA nodes based on their current loads. In general, it is recommended to keep this default setting unchanged for NUMA hardware.

**Note** 
The ideal CPU setting is different from the worker process NUMA node assignment settings (numaNodeAssignment and numaNodeAffinityMode) introduced in [CPU Settings for an Application Pool](https://www.iis.net/configreference/system.applicationhost/applicationpools/add/cpu). The ideal CPU setting affects how IIS distributes its thread pool threads, while the worker process NUMA node assignment settings determine on which NUMA node a worker process starts.

## User-mode cache behavior settings

This section describes the settings that affect caching behavior in IISÂ 10.0. The user-mode cache is implemented as a module that listens to the global caching events that are raised by the integrated pipeline. To completely disable the user-mode cache, remove the FileCacheModule (cachfile.dll) module from the list of installed modules in the system.webServer/globalModules configuration section in applicationHost.config.

**system.webServer/caching**

|Attribute|Description|Default|
|--- |--- |--- |
|Enabled|Disables the user-mode IIS cache when set to **False**. When the cache hit rate is very small, you can disable the cache completely to avoid the overhead that is associated with the cache code path. Disabling the user-mode cache does not disable the kernel-mode cache.|True|
|enableKernelCache|Disables the kernel-mode cache when set to **False**.|True|
|maxCacheSize|Limits the IIS user-mode cache size to the specified size in Megabytes. IIS adjusts the default depending on available memory. Choose the value carefully based on the size of the set of frequently accessed files versus the amount of RAM or the IIS process address space.|0|
|maxResponseSize|Caches files up to the specified size. The actual value depends on the number and size of the largest files in the data set versus the available RAM. Caching large, frequently requested files can reduce CPU usage, disk access, and associated latencies.|262144|

## Compression behavior settings

IIS starting from 7.0 compresses static content by default. Also, compression of dynamic content is enabled by default when the DynamicCompressionModule is installed. Compression reduces bandwidth usage but increases CPU usage. Compressed content is cached in the kernel-mode cache if possible. Starting from 8.5, IIS lets compression be controlled independently for static and dynamic content. Static content typically refers to content that does not change, such as GIF or HTM files. Dynamic content is typically generated by scripts or code on the server, that is, ASP.NET pages. You can customize the classification of any particular extension as static or dynamic.

To completely disable compression, remove StaticCompressionModule and DynamicCompressionModule from the list of modules in the system.webServer/globalModules section in applicationHost.config.

**system.webServer/httpCompression**

|Attribute|Description|Default|
|--- |--- |--- |
|staticCompression-EnableCpuUsage<br><br>staticCompression-DisableCpuUsage<br><br>dynamicCompression-EnableCpuUsage<br><br>dynamicCompression-DisableCpuUsage|Enables or disables compression if the current percentage CPU usage goes above or below specified limits.<br><br>Starting with IIS 7.0, compression is automatically disabled if steady-state CPU increases above the disable threshold. Compression is enabled if CPU drops below the enable threshold.|50, 100, 50, and 90 respectively|
|directory|Specifies the directory in which compressed versions of static files are temporarily stored and cached. Consider moving this directory off the system drive if it is accessed frequently.|%SystemDrive%\inetpub\temp\IIS Temporary Compressed Files|
|doDiskSpaceLimiting|Specifies whether a limit exists for how much disk space all compressed files can occupy. Compressed files are stored in the compression directory that is specified by the **directory** attribute.|True|
|maxDiskSpaceUsage|Specifies the number of bytes of disk space that compressed files can occupy in the compression directory.<br><br>This setting might need to be increased if the total size of all compressed content is too large.|100 MB|

**system.webServer/urlCompression**

|Attribute|Description|Default|
|--- |--- |--- |
|doStaticCompression|Specifies whether static content is compressed.|True|
|doDynamicCompression|Specifies whether dynamic content is compressed.|True|

**Note**
For servers running IIS 10.0 that have low average CPU usage, consider enabling compression for dynamic content, especially if responses are large. This should first be done in a test environment to assess the effect on the CPU usage from the baseline.


### Tuning the default document list

The default document module handles HTTP requests for the root of a directory and translates them into requests for a specific file, such as Default.htm or Index.htm. On average, aroundÂ 25 percent of all requests on the Internet go through the default document path. This varies significantly for individual sites. When an HTTP request does not specify a file name, the default document module searches the list of allowed default documents for each name in the file system. This can adversely affect performance, especially if reaching the content requires making a network round trip or touching a disk.

You can avoid the overhead by selectively disabling default documents and by reducing or ordering the list of documents. For websites that use a default document, you should reduce the list to only the default document types that are used. Additionally, order the list so that it begins with the most frequently accessed default document file name.

You can selectively set the default document behavior on particular URLs by customizing the configuration inside a location tag in applicationHost.config or by inserting a web.config file directly in the content directory. This allows a hybrid approach, which enables default documents only where they are necessary and sets the list to the correct file name for each URL.

To disable default documents completely, remove DefaultDocumentModule from the list of modules in the system.webServer/globalModules section in applicationHost.config.

**system.webServer/defaultDocument**

|Attribute|Description|Default|
|--- |--- |--- |
|enabled|Specifies that default documents are enabled.|True|
|&lt;files&gt; element|Specifies the file names that are configured as default documents.|The default list is Default.htm, Default.asp, Index.htm, Index.html, Iisstart.htm, and Default.aspx.|

## Central binary logging

When the server session has numerous URL groups under it, the process of creating hundreds of formatted log files for individual URL groups and writing the log data to a disk can quickly consume valuable CPU and memory resources, thereby creating performance and scalability issues. Centralized binary logging minimizes the amount of system resources that are used for logging, while at the same time providing detailed log data for organizations that require it. Parsing binary-format logs requires a post-processing tool.

You can enable central binary logging by setting the centralLogFileMode attribute to CentralBinary and setting the **enabled** attribute to **True**. Consider moving the location of the central log file off the system partition and onto a dedicated logging drive to avoid contention between system activities and logging activities.

**system.applicationHost/log**

|Attribute|Description|Default|
|--- |--- |--- |
|centralLogFileMode|Specifies the logging mode for a server. Change this value to CentralBinary to enable central binary logging.|Site|

**system.applicationHost/log/centralBinaryLogFile**

|Attribute|Description|Default|
|--- |--- |--- |
|enabled|Specifies whether central binary logging is enabled.|False|
|directory|Specifies the directory where log entries are written.|%SystemDrive%\inetpub\logs\LogFiles|


## Application and site tunings

The following settings relate to application pool and site tunings.

**system.applicationHost/applicationPools/applicationPoolDefaults**

|Attribute|Description|Default|
|--- |--- |--- |
|queueLength|Indicates to HTTP.sys how many requests are queued for an application pool before future requests are rejected. When the value for this property is exceeded, IIS rejects subsequent requests with a 503 error.<br><br>Consider increasing this for applications that communicate with high-latency back-end data stores if 503 errors are observed.|1000|
|enable32BitAppOnWin64|When True, enables a 32-bit application to run on a computer that has a 64-bit processor.<br><br>Consider enabling 32-bit mode if memory consumption is a concern. Because pointer sizes and instruction sizes are smaller, 32-bit applications use less memory than 64-bit applications. The drawback to running 32-bit applications on a 64-bit computer is that user-mode address space is limited to 4 GB.|False|

**system.applicationHost/sites/VirtualDirectoryDefault**

|Attribute|Description|Default|
|--- |--- |--- |
|allowSubDirConfig|Specifies whether IIS looks for web.config files in content directories lower than the current level (True) or does not look for web.config files in content directories lower than the current level (False). By imposing a simple limitation, which allows configuration only in virtual directories, IISÂ 10.0 can know that, unless **/&lt;name&gt;.htm** is a virtual directory, it should not look for a configuration file. Skipping the additional file operations can significantly improve performance of websites that have a very large set of randomly accessed static content.|True|

## Managing IIS 10.0 modules

IIS 10.0 has been factored into multiple, user-extensible modules to support a modular structure. This factorization has a small cost. For each module the integrated pipeline must call the module for every event that is relevant to the module. This happens regardless of whether the module must do any work. You can conserve CPU cycles and memory by removing all modules that are not relevant to a particular website.

A web server that is tuned for simple static files might include only the following five modules: UriCacheModule, HttpCacheModule, StaticFileModule, AnonymousAuthenticationModule, and HttpLoggingModule.

To remove modules from applicationHost.config, remove all references to the module from the system.webServer/handlers and system.webServer/modules sections in addition to removing the module declaration in system.webServer/globalModules.

## Classic ASP settings

The major cost of processing a classic ASP request includes initializing a script engine, compiling the requested ASP script into an ASP template, and executing the template on the script engine. While the template execution cost depends on the complexity of the requested ASP script, IIS classic ASP module can cache script engines in memory and cache templates in both memory and disk (only if in-memory template cache overflows) to boost performance in CPU-bound scenarios.

The following settings are used to configure the classic ASP template cache and script engine cache, and they do not affect ASP.NET settings.

**system.webServer/asp/cache**

|Attribute|Description|Default|
|--- |--- |--- |
|diskTemplateCacheDirectory|The name of the directory that ASP uses to store compiled templates when the in-memory cache overflows.<br><br>Recommendation: Set to a directory that is not heavily used, for example, a drive that is not shared with the operating system, IIS log, or other frequently accessed content.|%SystemDrive%\inetpub\temp\ASP Compiled Templates|
|maxDiskTemplateCacheFiles|Specifies the maximum number of compiled ASP templates that can be cached on disk.<br><br>Recommendation: Set to the maximum value of 0x7FFFFFFF.|2000|
|scriptFileCacheSize|This attribute specifies the maximum number of compiled ASP templates that can be cached in memory.<br><br>Recommendation: Set to at least as many as the number of frequently-requested ASP scripts served by an application pool. If possible, set to as many ASP templates as memory limits allow.|500|
|scriptEngineCacheMax|Specifies the maximum number of script engines that will keep cached in memory.<br><br>Recommendation: Set to at least as many as the number of frequently-requested ASP scripts served by an application pool. If possible, set to as many script engines as the memory limit allows.|250|

**system.webServer/asp/limits**

|Attribute|Description|Default|
|--- |--- |--- |
|processorThreadMax|Specifies the maximum number of worker threads per processor that ASP can create. Increase if the current setting is insufficient to handle the load, which can cause errors when it is serving requests or cause under-usage of CPU resources.|25|

**system.webServer/asp/comPlus**

|Attribute|Description|Default|
|--- |--- |--- |
|executeInMta|Set to **True** if errors or failures are detected while IIS is serving ASP content. This can occur, for example, when hosting multiple isolated sites in which each site runs under its own worker process. Errors are typically reported from COM+ in the Event Viewer. This setting enables the multi-threaded apartment model in ASP.|False|


## ASP.NET concurrency setting

### ASP.NET 3.5
By default, ASP.NET limits request concurrency to reduce steady-state memory consumption on the server. High concurrency applications might need to adjust some settings to improve overall performance. You can change this setting in aspnet.config file:

``` syntax
<system.web>
  <applicationPool maxConcurrentRequestsPerCPU="5000"/>
</system.web>
```

The following setting is useful to fully use resources on a system:

-   **maxConcurrentRequestPerCpu** Default value: 5000

    This setting limits the maximum number of concurrently executing ASP.NET requests on a system. The default value is conservative to reduce memory consumption of ASP.NET applications. Consider increasing this limit on systems that run applications that perform long, synchronous I/O operations. Otherwise, users can experience high latency because of queuing or request failures due to exceeding queue limits under a high load when the default setting is used.

### ASP.NET 4.6
Besides the maxConcurrentRequestPerCpu setting, ASP.NET 4.7 also provides settings to improve the performance in the applications which heavily rely on asynchronous operation. The setting can be changed in aspnet.config file.

``` syntax
<system.web>
  <applicationPool percentCpuLimit="90" percentCpuLimitMinActiveRequestPerCpu="100"/>
</system.web>
```

-   **percentCpuLimit** Default value: 90
Asynchronous request has some scalability issues when a huge load (beyond the hardware capabilities) is put on such scenario. The problem is due to the nature of allocation on asynchronous scenarios. In these conditions, allocation will happen when the asynchronous operation starts, and it will be consumed when it completes. By that time, itâs very possible the objects have been moved to generation 1 or 2 by GC. When this happens, increasing the load will show increase on request per second (rps) until a point. Once we pass that point, the time spent in GC will start to become a problem and the rps will start to dip, having a negative scaling effect. To fix the problem, when the cpu usage exceeds percentCpuLimit setting, requests will be sent to the ASP.NET native queue.
-   **percentCpuLimitMinActiveRequestPerCpu** Default value: 100
CPU throttling(percentCpuLimit setting) is not based on number of requests but on how expensive they are. As a result, there could be just a few CPU-intensive requests causing a backup in the native queue with no way to empty it aside from incoming requests. To solve this problme, percentCpuLimitMinActiveRequestPerCpu can be used to ensure a minimum number of requests are being served before throttling kicks in.

## Worker process and recycling options

You can configure options for recycling IIS worker processes and provide practical solutions to acute situations or events without requiring intervention or resetting a service or computer. Such situations and events include memory leaks, increasing memory load, or unresponsive or idle worker processes. Under ordinary conditions, recycling options might not be needed and recycling can be turned off or the system can be configured to recycle very infrequently.

You can enable process recycling for a particular application by adding attributes to the **recycling/periodicRestart** element. The recycle event can be triggered by several events including memory usage, a fixed number of requests, and a fixed time period. When a worker process is recycled, the queued and executing requests are drained, and a new process is simultaneously started to service new requests. The **recycling/periodicRestart** element is per-application, which means that each attribute in the following table is partitioned on a per-application basis.

**system.applicationHost/applicationPools/ApplicationPoolDefaults/recycling/periodicRestart**

|Attribute|Description|Default|
|--- |--- |--- |
|memory|Enable process recycling if virtual memory consumption exceeds the specified limit in kilobytes. This is a useful setting for 32-bit computers that have a small, 2 GB address space. It can help avoid failed requests due to out-of-memory errors.|0|
|privateMemory|Enable process recycling if private memory allocations exceed a specified limit in kilobytes.|0|
|requests|Enable process recycling after a certain number of requests.|0|
|time|Enable process recycling after a specified time period.|29:00:00|


## Dynamic worker-process page-out tuning

Starting in Windows Server 2012 R2, IIS offers the option of configuring worker process to suspend after they have been idle for a while (in addition to the option of terminate, which existed since IIS 7).

The main purpose of both the idle worker process page-out and idle worker process termination features is to conserve memory utilization on the server, since a site can consume a lot of memory even if it's just sitting there, listening. Depending on the technology used on the site (static content vs ASP.NET vs other frameworks), the memory used can be anywhere from about 10 MB to hundreds of MBs, and this means that if your server is configured with many sites, figuring out the most effective settings for your sites can dramatically improve performance of both active and suspended sites.

Before we go into specifics, we must keep in mind that if there are no memory constraints, then it's probably best to simply set the sites to never suspend or terminate. After all, thereâs little value in terminating a worker process if it's the only one on the machine.

**Note** 
In case the site runs unstable code, such as code with a memory leak, or otherwise unstable, setting the site to terminate on idle can be a quick-and-dirty alternative to fixing the code bug. This isn't something we would encourage, but in a crunch, it may be better to use this feature as a clean-up mechanism while a more permanent solution is in the works.\]

Â 

Another factor to consider is that if the site does use a lot of memory, then the suspension process itself takes a toll, because the computer has to write the data used by the worker process to disk. If the worker process is using a large chunk of memory, then suspending it might be more expensive than the cost of having to wait for it to start back up.

To make the best of the worker process suspension feature, you need to review your sites in each application pool, and decide which should be suspended, which should be terminated, and which should be active indefinitely. For each action and each site, you need to figure out the ideal time-out period.

Ideally, the sites that you will configure for suspension or termination are those that have visitors every day, but not enough to warrant keeping it active all the time. These are usually sites with around 20 unique visitors a day or less. You can analyze the traffic patterns using the site's log files and calculate the average daily traffic.

Keep in mind that once a specific user connects to the site, they will typically stay on it for at least a while, making additional requests, and so just counting daily requests may not accurately reflect the real traffic patterns. To get a more accurate reading, you can also use a tool, such as Microsoft Excel, to calculate the average time between requests. For example:

||Request URL|Request time|Delta|
|--- |--- |--- |--- |
|1|/SourceSilverLight/Geosource.web/grosource.html|10:01||
|2|/SourceSilverLight/Geosource.web/sliverlight.js|10:10|0:09|
|3|/SourceSilverLight/Geosource.web/clientbin/geo/1.aspx|10:11|0:01|
|4|/lClientAccessPolicy.xml|10:12|0:01|
|5|/ SourceSilverLight/GeosourcewebService/Service.asmx|10:23|0:11|
|6|/ SourceSilverLight/Geosource.web/GeoSearchServer...¦.|11:50|1:27|
|7|/rest/Services/CachedServices/Silverlight_load_la...¦|12:50|1:00|
|8|/rest/Services/CachedServices/Silverlight_basemap...¦.|12:51|0:01|
|9|/rest/Services/DynamicService/ Silverlight_basemap...¦.|12:59|0:08|
|10|/rest/Services/CachedServices/Ortho_2004_cache.as...|13:40|0:41|
|11|/rest/Services/CachedServices/Ortho_2005_cache.js|13:40|0:00|
|12|/rest/Services/CachedServices/OrthoBaseEngine.aspx|13:41|0:01|

The hard part, though, is figuring out what setting to apply to make sense. In our case, the site gets a bunch of requests from users, and the table above shows that a total of 4 unique sessions occurred in a period of 4 hours. With the default settings for worker process suspension of the application pool, the site would be terminated after the default timeout of 20 minutes, which means each of these users would experience the site spin-up cycle. This makes it an ideal candidate for worker process suspension, because for most of the time, the site is idle, and so suspending it would conserve resources, and allow the users to reach the site almost instantly.

A final, and very important note about this is that disk performance is crucial for this feature. Because the suspension and wake-up process involve writing and reading large amount of data to the hard drive, we strongly recommend using a fast disk for this. Solid State Drives (SSDs) are ideal and highly recommended for this, and you should make sure that the Windows page file is stored on it (if the operating system itself is not installed on the SSD, configure the operating system to move the page file to it).

Whether you use an SSD or not, we also recommend fixing the size of the page file to accommodate writing the page-out data to it without file-resizing. Page-file resizing might happen when the operating system needs to store data in the page file, because by default, Windows is configured to automatically adjust its size based on need. By setting the size to a fixed one, you can prevent resizing and improve performance a lot.

To configure a pre-fixed page file size, you need to calculate its ideal size, which depends on how many sites you will be suspending, and how much memory they consume. If the average is 200 MB for an active worker process and you have 500 sites on the servers that will be suspending, then the page file should be at least (200 \* 500) MB over the base size of the page file (so base + 100 GB in our example).

**Note**
When sites are suspended, they will consume approximately 6 MB each, so in our case, memory usage if all sites are suspended would be around 3 GB. In reality, though, youâre probably never going to have them all suspended at the same time.

 
## Transport Layer Security tuning parameters

The use of Transport Layer Security (TLS) imposes additional CPU cost. The most expensive component of TLS is the cost of establishing a session establishment because it involves a full handshake. Reconnection, encryption, and decryption also add to the cost. For better TLS performance, do the following:

-   Enable HTTP keep-alives for TLS sessions. This eliminates the session establishment costs.

-   Reuse sessions when appropriate, especially with non-keep-alive traffic.

-   Selectively apply encryption only to pages or parts of the site that need it, rather to the entire site.

**Note**
-   Larger keys provide more security, but they also use more CPU time.

-   All components might not need to be encrypted. However, mixing plain HTTP and HTTPS might result in a pop-up warning that not all content on the page is secure.

 
## Internet Server Application Programming Interface (ISAPI)

No special tuning parameters are needed for ISAPI applications. If you write a private ISAPI extension, make sure that it is written for performance and resource use.

## Managed code tuning guidelines

The integrated pipeline model in IIS 10.0 enables a high degree of flexibility and extensibility. Custom modules that are implemented in native or managed code can be inserted into the pipeline, or they can replace existing modules. Although this extensibility model offers convenience and simplicity, you should be careful before you insert new managed modules that hook into global events. Adding a global managed module means that all requests, including static file requests, must touch managed code. Custom modules are susceptible to events such as garbage collection. In addition, custom modules add significant CPU cost due to marshaling data between native and managed code. If possible, you should set preCondition to managedHandler for managed module.

To get better cold startup performance, make sure that you precompile the ASP.NET web site or leverage IIS Application Initialization feature to warm up the application.

If session state is not needed, make sure that you turn it off for each page.

If there are many I/O bound operations, try to use asynchronous version of relevant APIs which will give you much better scalability.

Also using Output Cache properly will also boost the performance of your web site.

When you run multiple hosts that contain ASP.NET scripts in isolated mode (one application pool per site), monitor the memory usage. Make sure that the server has enough RAM for the expected number of concurrently running application pools. Consider using multiple application domains instead of multiple isolated processes.


## Other issues that affect IIS performance

The following issues can affect IIS performance:

-   Installation of filters that are not cache-aware

    The installation of a filter that is not HTTP-cache-aware causes IIS to completely disable caching, which results in poor performance. ISAPI filters that were written before IISÂ 6.0 can cause this behavior.

-   Common Gateway Interface (CGI) requests

    For performance reasons, the use of CGI applications to serve requests is not recommended with IIS. Frequently creating and deleting CGI processes involves significant overhead. Better alternatives include using FastCGI, ISAPI application scripts and ASP or ASP.NET scripts. Isolation is available for each of these options.

# See also
- [Web Server performance tuning](index.md) 
- [HTTP 1.1/2 tuning](http-performance.md)
