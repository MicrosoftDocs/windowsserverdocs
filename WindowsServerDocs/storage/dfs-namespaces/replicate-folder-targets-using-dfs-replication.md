Published: October 22, 2009

Updated: October 16, 2013

Applies To: Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2

You can use DFS Replication to keep the contents of folder targets in sync so that users see the same files regardless of which folder target the client computer is referred to.

#### To replicate folder targets using DFS Replication

1.  Click **Start** , point to **Administrative Tools** , and then click **DFS Management** .

2.  In the console tree, under the **Namespaces** node, right-click a folder that has two or more folder targets, and then click **Replicate Folder** .

3.  Follow the instructions in the Replicate Folder Wizard.

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
<td>Configuration changes are not applied immediately to all members except when using the Suspend-DfsReplicationGroup and Sync-DfsReplicationGroup cmdlets. The new configuration must be replicated to all domain controllers, and each member in the replication group must poll its closest domain controller to obtain the changes. The amount of time this takes depends on ADÂ DS replication latency and the long polling interval (60 minutes) on each member. To poll immediately for configuration changes, open a command prompt window and then type the following command once for each member of the replication group: <code>dfsrdiag.exe PollAD /Member:DOMAIN\Server1</code>. To do so from a Windows PowerShell session, use the <code>Update-DfsrConfigurationFromAD</code> cmdlet, which was introduced on Windows ServerÂ 2012Â R2.
<p></p></td>
</tr>
</tbody>
</table>

#### Additional references

-   [Deploying DFS Namespaces](https://technet.microsoft.com/en-us/library/cc771424(v=ws.11).aspx)
-   [Delegate Management Permissions for DFS Namespaces](https://technet.microsoft.com/en-us/library/cc754770(v=ws.11).aspx)
-   [Replication](https://technet.microsoft.com/en-us/library/cc770278(v=ws.11).aspx)


