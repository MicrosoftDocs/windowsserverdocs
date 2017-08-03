Published: October 22, 2009

Updated: October 16, 2013

Applies To: Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2

A referral is an ordered list of servers that a client computer receives from a domain controller or namespace server when the user accesses a namespace root or DFS folder with targets. After the computer receives the referral, the computer attempts to access the first server in the list. If the server is not available, the client computer attempts to access the next server. If a server becomes unavailable, you can configure clients to fail back to the preferred server after it becomes available.

The following sections provide information about how to enable or disable referrals or enable client fail back.

Enable or disable referrals
---------------------------

By disabling a namespace serverâ€™s or folder targetâ€™s referral, you can prevent users from being directed to that namespace server or folder target. This is useful if you need to temporarily take a server offline for maintenance.

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
<td>To enable or disable referrals by using Windows PowerShell, use the <a href="https://technet.microsoft.com/library/jj884266.aspx">Set-DfsnRootTarget â€“State</a> or <a href="https://technet.microsoft.com/library/jj884277.aspx">Set-DfsnServerConfiguration</a> cmdlets, which were introduced in Windows ServerÂ 2012.
<p></p></td>
</tr>
</tbody>
</table>

#### To enable or disable referrals

-   To enable or disable referrals to a folder target, use the following steps:

    1.  In the DFS Management console tree, under the **Namespaces** node, click a folder with targets, and then click the **Folder Targets** tab in the details pane.
    2.  Right-click the folder target, and then click either **Disable Folder Target** or **Enable Folder Target** .
-   To enable or disable referrals to a namespace server, use the following steps:

    1.  In the DFS Management console tree, select the appropriate namespace and then click the **Namespace Servers** tab.
    2.  Right-click the appropriate namespace server and then click either **Disable Namespace Server** or **Enable Namespace Server** .

Enable client fail back
-----------------------

If a target becomes unavailable, you can configure clients to fail back to the target after it is restored. For fail back to work, client computers must meet the requirements listed in the following topic: [Review DFS Namespaces Client Requirements](https://technet.microsoft.com/en-us/library/cc771913(v=ws.11).aspx).

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
<td>To enable client fail back on a namespace root by using Windows PowerSHell, use the <a href="https://technet.microsoft.com/library/jj884281.aspx">Set-DfsnRoot</a> cmdlet. To enable client fail back on a DFS folder, use the <a href="https://technet.microsoft.com/library/jj884283.aspx">Set-DfsnFolder</a> cmdlet.
<p></p></td>
</tr>
</tbody>
</table>

#### To enable client failback for a namespace root

1.  Click **Start** , point to **Administrative Tools** , and then click **DFS Management** .

2.  In the console tree, under the **Namespaces** node, right-click a namespace, and then click **Properties** .

3.  On the **Referrals** tab, select the **Clients fail back to preferred targets** check box.

Folders with targets inherit client failback settings from the namespace root. If client failback is disabled on the namespace root, you can use the following procedure to enable the client to fail back on a folder with targets.

#### To enable client fail back for a folder with targets

1.  Click **Start** , point to **Administrative Tools** , and then click **DFS Management** .

2.  In the console tree, under the **Namespaces** node, right-click a folder with targets, and then click **Properties** .

3.  On the **Referrals** tab, click the **Clients fail back to preferred targets** check box.

#### Additional references

-   [Tuning DFS Namespaces](https://technet.microsoft.com/en-us/library/cc771083(v=ws.11).aspx)
-   [Review DFS Namespaces Client Requirements](https://technet.microsoft.com/en-us/library/cc771913(v=ws.11).aspx)
-   [Delegate Management Permissions for DFS Namespaces](https://technet.microsoft.com/en-us/library/cc754770(v=ws.11).aspx)


