---
title: Using the SPECsfs2008 File Server
description: Using the SPECsfs2008 File Server
---

# Using the SPECsfs2008 File Server


SPECsfs2008 is a file server benchmark suite from Standard Performance Evaluation Corporation that measures file server throughput and response time, providing a standardized method for comparing performance across different vendor platforms. SPECsfs2008 results summarize the server's capabilities with respect to the number of operations that can be handled per second, and the overall latency of the operations.

To ensure accurate results, you should format the data volumes between tests to flush and clean up the working set. For improved performance and scalability, we recommend that you partition client data over multiple data volumes. The networking, storage, and interrupt affinity sections of this guide contain additional tuning information that might apply to specific hardware.

## Tuning parameters for NFS file servers


You can tune the following registry parameters to enhance the performance of NFS servers:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Recommended value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>AdditionalDelayedWorkerThreads</p></td>
<td><p>16</p></td>
</tr>
<tr class="even">
<td><p>NtfsDisable8dot3NameCreation</p></td>
<td><p>1</p></td>
</tr>
<tr class="odd">
<td><p>NtfsDisableLastAccessUpdate</p></td>
<td><p>1</p></td>
</tr>
<tr class="even">
<td><p>OptimalReads</p></td>
<td><p>1</p></td>
</tr>
<tr class="odd">
<td><p>RdWrHandleLifeTime</p></td>
<td><p>10</p></td>
</tr>
<tr class="even">
<td><p>RdWrNfsHandleLifeTime</p></td>
<td><p>60</p></td>
</tr>
<tr class="odd">
<td><p>RdWrNfsReadHandlesLifeTime</p></td>
<td><p>10</p></td>
</tr>
<tr class="even">
<td><p>RdWrThreadSleepTime</p></td>
<td><p>60</p></td>
</tr>
<tr class="odd">
<td><p>FileHandleCacheSizeinMB</p></td>
<td><p>1*1024*1024*1024 (1073741824)</p></td>
</tr>
<tr class="even">
<td><p>LockFileHandleCacheInMemory</p></td>
<td><p>1</p></td>
</tr>
<tr class="odd">
<td><p>MaxIcbNfsReadHandlesCacheSize</p></td>
<td><p>30000</p></td>
</tr>
<tr class="even">
<td><p>HandleSigningEnabled</p></td>
<td><p>0</p></td>
</tr>
<tr class="odd">
<td><p>RdWrNfsDeferredWritesFlushDelay</p></td>
<td><p>60</p></td>
</tr>
<tr class="even">
<td><p>CacheAddFromCreateAndMkDir</p></td>
<td><p>1</p></td>
</tr>
</tbody>
</table>

 

## Related topics


[Performance Tuning for Workloads](performance-tuning-for-workloads.md)

[Performance Tuning for File Servers](performance-tuning-for-file-servers.md)
