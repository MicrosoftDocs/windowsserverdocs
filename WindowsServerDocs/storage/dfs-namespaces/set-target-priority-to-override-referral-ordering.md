Published: October 22, 2009

Updated: October 16, 2013

Applies To: Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2

A referral is an ordered list of targets that a client computer receives from a domain controller or namespace server when the user accesses a namespace root or folder with targets in the namespace. Each target in a referral is ordered according to the ordering method for the namespace root or folder. To refine how targets are ordered, you can set priority on individual targets. For example, you can specify that the target is first among all targets, last among all targets, or first (or last) among all targets of equal cost.

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
<td>To set target priorities by using Windows PowerShell, use the <a href="https://technet.microsoft.com/library/jj884266.aspx">Set-DfsnRootTarget</a> and <a href="https://technet.microsoft.com/library/jj884264.aspx">Set-DfsnFolderTarget</a> cmdlets with the <code>ReferralPriorityClass</code> and <code>ReferralPriorityRank</code> parameters. These cmdlets were introduced in Windows ServerÂ 2012.
<p></p></td>
</tr>
</tbody>
</table>

To set target priority on a root target for a domain-based namespace, use the following procedure.

#### To set target priority on a root target for a domain-based namespace

1.  Click **Start** , point to **Administrative Tools** , and then click **DFS Management** .

2.  In the console tree, under the **Namespaces** node, click the domain-based namespace for the root targets that you want to set priority on.

3.  In the details pane, on the **Namespace Servers** tab, right-click the root target with the priority that you want to change, and then click **Properties** .

4.  On the **Advanced** tab, click **Override referral ordering** , and then click the priority that you want.

    -   **First among all targets** Â Â Â Specifies that users should always be referred to this target if the target is available.
    -   **Last among all targets** Â Â Â Specifies that users should never be referred to this target unless all other targets are unavailable.
    -   **First among targets of equal cost** Â Â Â Specifies that users should be referred to this target before other targets of equal cost (which usually means other targets in the same site).
    -   **Last among targets of equal cost** Â Â Â Specifies that users should never be referred to this target if there are other targets of equal cost available (which usually means other targets in the same site).

To set target priority on a folder target, use the following procedure.

#### To set target priority on a folder target

1.  Click **Start** , point to **Administrative Tools** , and then click **DFS Management** .

2.  In the console tree, under the **Namespaces** node, click the folder of the targets that you want to set priority on.

3.  In the details pane, on the **Folder Targets** tab, right-click the folder target with the priority that you want to change, and then click **Properties** .

4.  On the **Advanced** tab, click **Override referral ordering** , and then click the priority that you want.

#### Additional references

-   [Tuning DFS Namespaces](https://technet.microsoft.com/en-us/library/cc771083(v=ws.11).aspx)
-   [Delegate Management Permissions for DFS Namespaces](https://technet.microsoft.com/en-us/library/cc754770(v=ws.11).aspx)


