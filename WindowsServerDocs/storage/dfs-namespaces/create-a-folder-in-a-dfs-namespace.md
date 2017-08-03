Published: October 22, 2009

Updated: October 16, 2013

Applies To: Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2

You can use folders to create additional levels of hierarchy in a namespace. You can also create folders with folder targets to add shared folders to the namespace. DFS folders with folder targets cannot contain other DFS folders, so if you want to add a level of hierarchy to the namespace, do not add folder targets to the folder.

Use the following procedure to create a folder in a namespace by using DFS Management.

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
<td>To create a folder in a namespace by using Windows PowerShell, use the <a href="https://technet.microsoft.com/library/jj884271.aspx">New-DfsnFolder</a> cmdlet. The DFSN Windows PowerShell module was introduced in Windows Server 2012.
<p></p></td>
</tr>
</tbody>
</table>

#### To create a folder in a namespace

1.  Click **Start** , point to **Administrative Tools** , and then click **DFS Management** .

2.  In the console tree, under the **Namespaces** node, right-click a namespace or a folder within a namespace, and then click **New Folder** .

3.  In the **Name** text box, type the name of the new folder.

4.  To add one or more folder targets to the folder, click **Add** and specify the Universal Naming Convention (UNC) path of the folder target, and then click **OK** .

#### Additional references

-   [Deploying DFS Namespaces](https://technet.microsoft.com/en-us/library/cc771424(v=ws.11).aspx)
-   [Delegate Management Permissions for DFS Namespaces](https://technet.microsoft.com/en-us/library/cc754770(v=ws.11).aspx)


