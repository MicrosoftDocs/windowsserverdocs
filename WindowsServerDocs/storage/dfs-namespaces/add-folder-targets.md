Published: October 22, 2009

Updated: October 16, 2013

Applies To: Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2

A folder target is the Universal Naming Convention (UNC) path of a shared folder or another namespace that is associated with a folder in a namespace. Adding multiple folder targets increases the availability of the folder in the namespace.

To add a folder target by using DFS Management, use the following procedure.

<table>
<colgroup>
<col width="100%" />
</colgroup>
<thead>
<tr class="header">
<th><img src="https://i-technet.sec.s-msft.com/dynimg/IC115537.gif" title="Tip" alt="Tip" id="Tip" />Tip</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>To add a folder target by using Windows PowerShell, use the <a href="https://technet.microsoft.com/library/jj884280.aspx">New-DfsnFolderTarget</a> cmdlet. The DFSN Windows PowerShell module was introduced in Windows Server 2012.
<p></p></td>
</tr>
</tbody>
</table>

#### To add a folder target

1.  Click **Start** , point to **Administrative Tools** , and then click **DFS Management** .

2.  In the console tree, under the **Namespaces** node, right-click a folder, and then click **Add Folder Target** .

3.  Type the path to the folder target, or click **Browse** to locate the folder target.

4.  If the folder is replicated by using DFS Replication, you can specify whether to add the new folder target to the replication group.

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
<td>Folders can contain folder targets or other DFS folders, but not both, at the same level in the folder hierarchy.
<p></p></td>
</tr>
</tbody>
</table>

#### Additional references

-   [Deploying DFS Namespaces](https://technet.microsoft.com/en-us/library/cc771424(v=ws.11).aspx)
-   [Delegate Management Permissions for DFS Namespaces](https://technet.microsoft.com/en-us/library/cc754770(v=ws.11).aspx)
-   [Replicate Folder Targets Using DFS Replication](https://technet.microsoft.com/en-us/library/cc771488(v=ws.11).aspx)


