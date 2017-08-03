Published: October 22, 2009

Updated: October 16, 2013

Applies To: Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2

A referral is an ordered list of targets that a client computer receives from a domain controller or namespace server when the user accesses a namespace root or folder with targets in the namespace. You can adjust how long clients cache a referral before requesting a new one.

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
<td>To change the amount of time that clients cache namespace root referrals by using Windows PowerShell, use the <a href="https://technet.microsoft.com/library/jj884281.aspx">Set-DfsnRoot â€“TimeToLiveSec</a> cmdlet. To change the amount of time that clients cache folder referrals, use the <a href="https://technet.microsoft.com/library/jj884283.aspx">Set-DfsnFolder â€“TimeToLiveSec</a> cmdlet. These cmdlets were introduced in Windows ServerÂ 2012.
<p></p></td>
</tr>
</tbody>
</table>

#### To change the amount of time that clients cache namespace root referrals

1.  Click **Start** , point to **Administrative Tools** , and then click **DFS Management** .

2.  In the console tree, under the **Namespaces** node, right-click a namespace, and then click **Properties** .

3.  On the **Referrals** tab, in the **Cache duration (in seconds)** text box, type the amount of time (in seconds) that clients cache namespace root referrals. The default setting is 300 seconds (five minutes).

#### To change the amount of time that clients cache folder referrals

1.  Click **Start** , point to **Administrative Tools** , and then click **DFS Management** .

2.  In the console tree, under the **Namespaces** node, right-click a folder that has targets, and then click **Properties** .

3.  On the **Referrals** tab, in the **Cache duration (in seconds)** text box, type the amount of time (in seconds) that clients cache folder referrals. The default setting is 1800 seconds (30 minutes).

#### Additional references

-   [Tuning DFS Namespaces](https://technet.microsoft.com/en-us/library/cc771083(v=ws.11).aspx)
-   [Delegate Management Permissions for DFS Namespaces](https://technet.microsoft.com/en-us/library/cc754770(v=ws.11).aspx)


