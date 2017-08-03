Published: October 22, 2009

Updated: October 16, 2013

Applies To: Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2

DFSÂ Namespaces and DFSÂ Replication can be used to publish documents, software, and line-of-business data to users throughout an organization. Although DFSÂ Replication alone is sufficient to distribute data, you can use DFSÂ Namespaces to configure the namespace so that a folder is hosted by multiple servers, each of which holds an updated copy of the folder. This increases data availability and distributes the client load across servers.

When browsing a folder in the namespace, users are not aware that the folder is hosted by multiple servers. When a user opens the folder, the client computer is automatically referred to a server on its site. If no same-site servers are available, you can configure the namespace to refer the client to a server that has the lowest connection cost as defined in ADÂ DS.

To deploy DFS Namespaces, perform the following tasks:

### Â 

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th>Task</th>
<th>Reference</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Review the basic concepts of DFS Namespaces</p></td>
<td><p><a href="https://technet.microsoft.com/en-us/library/cc730736(v=ws.11).aspx">Overview of DFS Namespaces</a></p></td>
</tr>
<tr class="even">
<td><p>Review requirements and prepare to deploy DFS Namespaces</p></td>
<td><p><a href="https://technet.microsoft.com/en-us/library/cc771575(v=ws.11).aspx">Prepare to Deploy DFS Namespaces</a></p></td>
</tr>
<tr class="odd">
<td><p>Install DFS Management</p></td>
<td><p><a href="https://technet.microsoft.com/en-us/library/cc731089(v=ws.11).aspx">Installing DFS</a></p></td>
</tr>
<tr class="even">
<td><p>Create a DFS namespace</p></td>
<td><p><a href="https://technet.microsoft.com/en-us/library/cc731531(v=ws.11).aspx">Create a DFS Namespace</a></p></td>
</tr>
<tr class="odd">
<td><p>Migrate existing domain-based namespaces to Windows ServerÂ 2008 mode domain-based namespaces</p></td>
<td><p><a href="https://technet.microsoft.com/en-us/library/cc753875(v=ws.11).aspx">Migrate a Domain-based Namespace to Windows Server 2008 Mode</a></p></td>
</tr>
<tr class="even">
<td><p>Increase availability by adding namespace servers to a domain-based namespace</p></td>
<td><p><a href="https://technet.microsoft.com/en-us/library/cc732807(v=ws.11).aspx">Add Namespace Servers to a Domain-based DFS Namespace</a></p></td>
</tr>
<tr class="odd">
<td><p>Add folders to a namespace</p></td>
<td><p><a href="https://technet.microsoft.com/en-us/library/cc753986(v=ws.11).aspx">Create a Folder in a DFS Namespace</a></p></td>
</tr>
<tr class="even">
<td><p>Add folder targets to folders in a namespace</p></td>
<td><p><a href="https://technet.microsoft.com/en-us/library/cc732105(v=ws.11).aspx">Add Folder Targets</a></p></td>
</tr>
<tr class="odd">
<td><p>Replicate content between folder targets using DFS Replication (optional)</p></td>
<td><p><a href="https://technet.microsoft.com/en-us/library/cc771488(v=ws.11).aspx">Replicate Folder Targets Using DFS Replication</a></p></td>
</tr>
</tbody>
</table>

#### Additional references

-   [Namespaces](https://technet.microsoft.com/en-us/library/cc771914(v=ws.11).aspx)
-   [Checklist: Tune a DFS Namespace](https://technet.microsoft.com/en-us/library/cc731998(v=ws.11).aspx)
-   [Replication](https://technet.microsoft.com/en-us/library/cc770278(v=ws.11).aspx)


