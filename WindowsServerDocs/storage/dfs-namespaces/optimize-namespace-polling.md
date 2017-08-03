Published: October 22, 2009

Updated: October 16, 2013

Applies To: Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2

To maintain a consistent domain-based namespace across namespace servers, it is necessary for namespace servers to periodically poll Active Directory Domain Services (ADÂ DS) to obtain the most current namespace data. You can use this procedure to optimize how this polling occurs.

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
<td>To set the namespace polling mode by using Windows PowerShell, use the <a href="https://technet.microsoft.com/library/jj884281.aspx">Set-DfsnRoot â€“EnableRootScalability</a> cmdlet, which was introduced in Windows ServerÂ 2012.
<p></p></td>
</tr>
</tbody>
</table>

#### To optimize namespace polling

1.  Click **Start** , point to **Administrative Tools** , and then click **DFS Management** .

2.  In the console tree, under the **Namespaces** node, right-click a domain-based namespace, and then click **Properties** .

3.  On the **Advanced** tab, select whether the namespace will be optimized for consistency or scalability.

    -   Choose **Optimize for consistency** if there are 16 or fewer namespace servers hosting the namespace.
    -   Choose **Optimize for scalability** if there are more than 16 namespace servers. This reduces the load on the Primary Domain Controller (PDC) Emulator, but increases the time it requires for changes to the namespace to replicate to all namespace servers. Until changes replicate to all servers, users might have an inconsistent view of the namespace.

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
    <td>Namespace servers running WindowsÂ 2000Â Server continue to poll the PDC emulator every hour by default, even if you enable <strong>Optimize for scalability</strong> on the namespace.
    <p></p></td>
    </tr>
    </tbody>
    </table>

#### Additional references

-   [Tuning DFS Namespaces](https://technet.microsoft.com/en-us/library/cc771083(v=ws.11).aspx)
-   [Delegate Management Permissions for DFS Namespaces](https://technet.microsoft.com/en-us/library/cc754770(v=ws.11).aspx)


