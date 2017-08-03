Published: October 22, 2009

Updated: October 16, 2013

Applies To: Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2

When creating a namespace, you must choose one of two namespace types: a stand-alone namespace or a domain-based namespace. In addition, if you choose a domain-based namespace, you must choose a namespace mode: Windows 2000Â Server mode or Windows ServerÂ 2008 mode.

Choosing a namespace type
-------------------------

Choose a stand-alone namespace if any of the following conditions apply to your environment:

-   Your organization does not use Active Directory Domain Services (ADÂ DS).
-   You want to increase the availability of the namespace by using a failover cluster.
-   You need to create a single namespace with more than 5,000 DFS folders in a domain that does not meet the requirements for a domain-based namespace (Windows ServerÂ 2008 mode)â€”as described later in this topic.
    <table>
    <colgroup>
    <col width="100%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th><img src="https://i-technet.sec.s-msft.com/areas/global/content/clear.gif" title="note" alt="note" id="note" class="cl_IC101471" />Note</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>To check the size of a namespace, right-click the namespace in the DFS Management console tree, click <strong>Properties</strong> , and then view the namespace size in the <strong>Namespace Properties</strong> dialog box. For more information about DFS Namespace scalability, see the Microsoft Web site (<a href="http://go.microsoft.com/fwlink/?LinkId=92838" class="uri">http://go.microsoft.com/fwlink/?LinkId=92838</a>).
    <p></p></td>
    </tr>
    </tbody>
    </table>

Choose a domain-based namespace if any of the following conditions apply to your environment:

-   You want to ensure the availability of the namespace by using multiple namespace servers.
-   You want to hide the name of the namespace server from users. This makes it easier to replace the namespace server or migrate the namespace to another server.

Choosing a domain-based namespace mode
--------------------------------------

If you choose a domain-based namespace, you must choose whether to use the WindowsÂ 2000Â Server mode or the Windows ServerÂ 2008 mode. The Windows ServerÂ 2008 mode includes support for access-based enumeration and increased scalability. The domain-based namespace introduced in WindowsÂ 2000Â Server is now referred to as "domain-based namespace (WindowsÂ 2000Â Server mode)."

To use the Windows ServerÂ 2008 mode, the domain and namespace must meet the following minimum requirements:

-   The forest uses the Windows Server 2003 or higher forest functional level.
-   The domain uses the Windows ServerÂ 2008 or higher domain functional level.
-   All namespace servers are running Windows ServerÂ 2012Â R2, Windows ServerÂ 2012, Windows ServerÂ 2008Â R2, or Windows ServerÂ 2008.

If your environment supports it, choose the Windows ServerÂ 2008 mode when you create new domain-based namespaces. This mode provides additional features and scalability, and also eliminates the possible need to migrate a namespace from the WindowsÂ 2000Â Server mode.

For information about migrating a namespace to Windows ServerÂ 2008 mode, see [Migrate a Domain-based Namespace to Windows Server 2008 Mode](https://technet.microsoft.com/en-us/library/cc753875(v=ws.11).aspx).

If your environment does not support domain-based namespaces in Windows ServerÂ 2008 mode, use the existing WindowsÂ 2000Â Server mode for the namespace.

Comparing namespace types and modes
-----------------------------------

The characteristics of each namespace type and mode are described in the following table.

### Â 

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<thead>
<tr class="header">
<th>Characteristic</th>
<th>Stand-Alone Namespace</th>
<th>Domain-based Namespace (Windows 2000Â Server Mode)</th>
<th>Domain-based Namespace (Windows ServerÂ 2008 Mode)</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Path to namespace</p></td>
<td><p>\\ <em>ServerName\RootName</em></p></td>
<td><p>\\ <em>NetBIOSDomainName\RootName</em></p>
<p>\\ <em>DNSDomainName\RootName</em></p></td>
<td><p>\\ <em>NetBIOSDomainName\RootName</em></p>
<p>\\ <em>DNSDomainName\RootName</em></p></td>
</tr>
<tr class="even">
<td><p>Namespace information storage location</p></td>
<td><p>In the registry and in a memory cache on the namespace server</p></td>
<td><p>In ADÂ DS and in a memory cache on each namespace server</p></td>
<td><p>In ADÂ DS and in a memory cache on each namespace server</p></td>
</tr>
<tr class="odd">
<td><p>Namespace size recommendations</p></td>
<td><p>The namespace can contain more than 5,000 folders with targets; the recommended limit is 50,000 folders with targets</p></td>
<td><p>The size of the namespace object in ADÂ DS should be less than 5Â megabytes (MB) to maintain compatibility with domain controllers that are not running Windows ServerÂ 2008. This means no more than approximately 5,000 folders with targets.</p></td>
<td><p>The namespace can contain more than 5,000 folders with targets; the recommended limit is 50,000 folders with targets</p></td>
</tr>
<tr class="even">
<td><p>Minimum ADÂ DS forest functional level</p></td>
<td><p>ADÂ DS is not required</p></td>
<td><p>WindowsÂ 2000</p></td>
<td><p>Windows ServerÂ 2003</p></td>
</tr>
<tr class="odd">
<td><p>Minimum ADÂ DS domain functional level</p></td>
<td><p>ADÂ DS is not required</p></td>
<td><p>Windows 2000 mixed</p></td>
<td><p>Windows ServerÂ 2008</p></td>
</tr>
<tr class="even">
<td><p>Minimum supported namespace servers</p></td>
<td><p>Windows 2000Â Server</p></td>
<td><p>Windows 2000Â Server</p></td>
<td><p>Windows ServerÂ 2008</p></td>
</tr>
<tr class="odd">
<td><p>Support for access-based enumeration (if enabled)</p></td>
<td><p>Yes, requires Windows ServerÂ 2008 namespace server</p></td>
<td><p>No</p></td>
<td><p>Yes</p></td>
</tr>
<tr class="even">
<td><p>Supported methods to ensure namespace availability</p></td>
<td><p>Create a stand-alone namespace on a failover cluster.</p></td>
<td><p>Use multiple namespace servers to host the namespace. (The namespace servers must be in the same domain.)</p></td>
<td><p>Use multiple namespace servers to host the namespace. (The namespace servers must be in the same domain.)</p></td>
</tr>
<tr class="odd">
<td><p>Support for using DFS Replication to replicate folder targets</p></td>
<td><p>Supported when joined to an AD DS domain</p></td>
<td><p>Supported</p></td>
<td><p>Supported</p></td>
</tr>
</tbody>
</table>

#### Additional references

-   [Deploying DFS Namespaces](https://technet.microsoft.com/en-us/library/cc771424(v=ws.11).aspx)
-   [Migrate a Domain-based Namespace to Windows Server 2008 Mode](https://technet.microsoft.com/en-us/library/cc753875(v=ws.11).aspx)


