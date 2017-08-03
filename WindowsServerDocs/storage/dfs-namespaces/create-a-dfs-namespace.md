Published: October 22, 2009

Updated: October 16, 2013

Applies To: Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2

To create a new namespace, you can use Server Manager to create the namespace when you install the DFS Namespaces role service. You can also use the [New-DfsnRoot cmdlet](https://technet.microsoft.com/library/jj884286.aspx) from a Windows PowerShell session. The DFSN Windows PowerShell module was introduced in Windows Server 2012. Or you can use the following procedure to create a namespace after installing the role service.

#### To create a namespace

1.  Click **Start** , point to **Administrative Tools** , and then click **DFS Management** .

2.  In the console tree, right-click the **Namespaces** node, and then click **New Namespace** .

3.  Follow the instructions in the **New Namespace Wizard** .

    To create a stand-alone namespace on a failover cluster, specify the name of a clustered file server instance on the **Namespace Server** page of the **New Namespace Wizard** .

    <table>
    <colgroup>
    <col width="100%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th><img src="https://i-technet.sec.s-msft.com/areas/global/content/clear.gif" title="Important" alt="Important" id="Important" class="cl_IC160177" />Important</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>Do not attempt to create a domain-based namespace using the Windows ServerÂ 2008 mode unless the forest functional level is Windows ServerÂ 2003 or higher. Doing so can result in a namespace for which you cannot delete DFS folders, yielding the following error message: â€œThe folder cannot be deleted. Cannot complete this function.â€?
    <p></p></td>
    </tr>
    </tbody>
    </table>

#### Additional references

-   [Deploying DFS Namespaces](https://technet.microsoft.com/en-us/library/cc771424(v=ws.11).aspx)
-   [Choose a Namespace Type](https://technet.microsoft.com/en-us/library/cc770287(v=ws.11).aspx)
-   [Add Namespace Servers to a Domain-based DFS Namespace](https://technet.microsoft.com/en-us/library/cc732807(v=ws.11).aspx)
-   [Delegate Management Permissions for DFS Namespaces](https://technet.microsoft.com/en-us/library/cc754770(v=ws.11).aspx).


