Published: October 22, 2009

Updated: October 16, 2013

Applies To: Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2

A referral is an ordered list of targets that a client computer receives from a domain controller or namespace server when the user accesses a namespace root or folder with targets. After the client receives the referral, the client attempts to access the first target in the list. If the target is not available, the client attempts to access the next target.

Targets on the client's site are always listed first in a referral. Targets outside of the client's site are listed according to the ordering method.

Use the following sections to specify in what order targets should be referred to clients and to understand the different methods of ordering target referrals.

Set the ordering method
-----------------------

Use the following procedure to set the ordering method on the namespace root.

#### To set the ordering method for targets in namespace root referrals

1.  Click **Start** , point to **Administrative Tools** , and then click **DFS Management** .

2.  In the console tree, under the **Namespaces** node, right-click a namespace, and then click **Properties** .

3.  On the **Referrals** tab, select an ordering method.

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
<td>To use Windows PowerShell to set the ordering method for targets in namespace root referrals, use the <a href="https://technet.microsoft.com/library/jj884281.aspx">Set-DfsnRoot</a> cmdlet with one of the following parameters:
<p></p>
<ul>
<li><code>EnableSiteCosting</code> specifies the <strong>Lowest cost ordering</strong> method<br />
<br />
</li>
<li><code>EnableInsiteReferrals</code> specifies the <strong>Exclude targets outside of the clientâ€™s site</strong> ordering method<br />
<br />
</li>
<li>Omitting either parameter specifies the <strong>Random order</strong> referral ordering method.<br />
<br />
</li>
</ul>
The DFSN Windows PowerShell module was introduced in Windows ServerÂ 2012.
<p></p></td>
</tr>
</tbody>
</table>

Folders with targets inherit the ordering method from the namespace root. You can override the ordering method by using the following procedure.

#### To set the ordering method for targets in folder referrals

1.  Click **Start** , point to **Administrative Tools** , and then click **DFS Management** .

2.  In the console tree, under the **Namespaces** node, right-click a folder with targets, and then click **Properties** .

3.  On the **Referrals** tab, select the **Exclude targets outside of the client's site** check box.

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
<td>To use Windows PowerShell to exclude folder targets outside of the clientâ€™s site, use the <a href="https://technet.microsoft.com/library/jj884283.aspx">Set-DfsnFolder â€“EnableInsiteReferrals</a> cmdlet.
<p></p></td>
</tr>
</tbody>
</table>

Target referral ordering methods
--------------------------------

The three ordering methods are:

-   Random order
-   Lowest cost
-   Exclude targets outside of the client's site

#### Random order

In this method, targets are ordered as follows:

1.  Targets in the same ADÂ DS site as the client are listed in random order at the top of the referral.
2.  Targets outside of the clientâ€™s site are listed in random order.

If no same-site target servers are available, the client computer is referred to a random target server regardless of how expensive the connection is or how distant the target is.

#### Lowest cost

In this method, targets are ordered as follows:

1.  Targets in the same site as the client are listed in random order at the top of the referral.
2.  Targets outside of the clientâ€™s site are listed in order of lowest cost to highest cost. Referrals with the same cost are grouped together, and the targets are listed in random order within each group.

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
<td>Site link costs are not shown in the DFS Management snap-in. To view site link costs, use the Active Directory Sites and Services snap-in.
<p></p></td>
</tr>
</tbody>
</table>

#### Exclude targets outside of the client's site

In this method, the referral contains only the targets that are in the same site as the client. These same-site targets are listed in random order. If no same-site targets exist, the client does not receive a referral and cannot access that portion of the namespace.

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
<td>Targets that have target priority set to &quot;First among all targets&quot; or &quot;Last among all targets&quot; are still listed in the referral, even if the ordering method is set to <strong>Exclude targets outside of the client's site</strong> .
<p></p></td>
</tr>
</tbody>
</table>

#### Additional references

-   [Tuning DFS Namespaces](https://technet.microsoft.com/en-us/library/cc771083(v=ws.11).aspx)
-   [Delegate Management Permissions for DFS Namespaces](https://technet.microsoft.com/en-us/library/cc754770(v=ws.11).aspx)


