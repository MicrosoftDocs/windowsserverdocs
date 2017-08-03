Published: October 22, 2009

Updated: October 16, 2013

Applies To: Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2

You can increase the availability of a domain-based namespace by specifying additional namespace servers to host the namespace. To do so using DFS Management, use the following procedure.

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
<td>To add a namespace server by using Windows PowerShell, use the <a href="https://technet.microsoft.com/library/jj884284.aspx">New-DfsnRootTarget</a> cmdlet. The DFSN Windows PowerShell module was introduced in Windows Server 2012.
<p></p></td>
</tr>
</tbody>
</table>

#### To add a namespace server to a domain-based namespace

1.  Click **Start** , point to **Administrative Tools** , and then click **DFS Management** .

2.  In the console tree, under the **Namespaces** node, right-click a domain-based namespace, and then click **Add Namespace Server** .

3.  Enter the path to another server, or click **Browse** to locate a server.

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
<td>This procedure is not applicable for stand-alone namespaces because stand-alone namespaces support only a single namespace server. To increase the availability of a stand-alone namespace, specify a failover cluster as the namespace server in the New Namespace Wizard.
<p></p></td>
</tr>
</tbody>
</table>

#### Additional references

-   [Deploying DFS Namespaces](https://technet.microsoft.com/en-us/library/cc771424(v=ws.11).aspx)
-   [Review DFS Namespaces Server Requirements](https://technet.microsoft.com/en-us/library/cc753448(v=ws.11).aspx)
-   [Create a DFS Namespace](https://technet.microsoft.com/en-us/library/cc731531(v=ws.11).aspx)
-   [Delegate Management Permissions for DFS Namespaces](https://technet.microsoft.com/en-us/library/cc754770(v=ws.11).aspx)


