---
title: Performance Tuning for NTttcp
description: Performance Tuning for NTttcp
---

# Performance Tuning for NTttcp


NTttcp is a Winsock-based port of ttcp to Windows. It helps measure network driver performance and throughput on different network topologies and hardware setups. It provides the customer with a multithreaded, asynchronous performance workload for measuring an achievable data transfer rate on an existing network setup.

For more info on NTttcp, see [How to Use NTttcp to Test Network Performance](http://msdn.microsoft.com/windows/hardware/gg463264.aspx). You can download the latest version from [TechNet](http://gallery.technet.microsoft.com/NTttcp-Version-528-Now-f8b12769).

When setting up NTttcp, you should consider the following:

-   A single thread should be sufficient for optimal throughput.

-   Multiple threads are required only for single-to-many clients.

-   Posting enough user receive buffers (by increasing the value passed to the -a option) reduces TCP copying.

-   You should not excessively post user receive buffers because the first buffers that are posted would return before you need to use other buffers.

-   It is best to bind each set of threads to a logical processor (the second delimited parameter in the -m option).

-   Each thread creates a logical processor that connects to (listens) a different port.

The following table lists some examples:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th>Syntax</th>
<th>Details</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>NTttcp.exe -s -m 1,0,10.1.2.3 -a 2 -t 10</p></td>
<td><p>This is an example of a sender with the following characteristics:</p>
<ul>
<li><p>Single thread.</p></li>
<li><p>Bound to CPU 0.</p></li>
<li><p>Connects to a computer that uses IP 10.1.2.3.</p></li>
<li><p>Posts two send-overlapped buffers.</p></li>
<li><p>Default buffer size: 64 KB.</p></li>
<li><p>Default number of buffers to send: 20 KB.</p></li>
<li><p>Test runs for 10 seconds.</p></li>
</ul></td>
</tr>
<tr class="even">
<td><p>NTttcp.exe -r -m 1,0,10.1.2.3 -a 6 -t 10</p></td>
<td><p>This is an example of a receiver with the following characteristics:</p>
<ul>
<li><p>Single thread.</p></li>
<li><p>Bound to CPU 0.</p></li>
<li><p>Binds on local computer to IP 10.1.2.3.</p></li>
<li><p>Posts six receive-overlapped buffers.</p></li>
<li><p>Default buffer size: 64 KB.</p></li>
<li><p>Default number of buffers to receive: 20 KB.</p></li>
<li><p>Posts full-length (64 KB) receive buffers.</p></li>
<li><p>Test runs for 10 seconds.</p></li>
</ul></td>
</tr>
</tbody>
</table>

 

**Important**  
Make sure to enable all offloading features on the network adapter.

 

## TCP/IP Window Size


For 1 GB adapters, the settings shown in the table above should provide good throughput because NTttcp sets the default TCP window size to 64 KB through a specific logical processor option (SO\_RCVBUF) for the connection. This provides good performance on a low-latency network. In contrast, for high-latency networks or for 10 GB adapters, the default TCP window size value for NTttcp yields less than optimal performance. In both cases, you must adjust the TCP window size to allow for the larger bandwidth delay product. You can statically set the TCP window size to a large value by using the **-rb** option. This option disables TCP Window Auto-Tuning, and we recommend using it only if the user fully understands the resultant change in TCP/IP behavior. By default, the TCP window size is set at a sufficient value and adjusts only under heavy load or over high-latency links.

## Related topics


[Performance Tuning for Workloads](performance-tuning-for-workloads.md)
