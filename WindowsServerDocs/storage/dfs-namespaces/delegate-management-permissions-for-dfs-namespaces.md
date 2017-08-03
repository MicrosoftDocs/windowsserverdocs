Published: October 22, 2009

Updated: October 16, 2013

Applies To: Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2

The following table describes the groups that can perform basic namespace tasks by default, and the method for delegating the ability to perform these tasks.

### Â 

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<thead>
<tr class="header">
<th>Task</th>
<th>Groups that Can Perform this Task by Default</th>
<th>Delegation Method</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Create a domain-based namespace</p></td>
<td><p>Domain Admins group in the domain where the namespace is configured</p></td>
<td><p>Right-click the <strong>Namespaces</strong> node in the console tree, and then click <strong>Delegate Management Permissions</strong> . Or use the <code>Set-DfsnRoot â€“GrantAdminAccounts</code> and <code>Set-DfsnRoot â€“RevokeAdminAccounts</code> Windows PowerShell cmdlets (introduced in Windows ServerÂ 2012). You must also add the user to the local Administrators group on the namespace server.</p></td>
</tr>
<tr class="even">
<td><p>Add a namespace server to a domain-based namespace</p></td>
<td><p>Domain Admins group in the domain where the namespace is configured</p></td>
<td><p>Right-click the domain-based namespace in the console tree, and then click <strong>Delegate Management Permissions</strong> . Or use the <code>Set-DfsnRoot â€“GrantAdminAccounts</code> and <code>Set-DfsnRoot â€“RevokeAdminAccounts</code> Windows PowerShell cmdlets (introduced in Windows ServerÂ 2012). You must also add the user to the local Administrators group on the namespace server to be added.</p></td>
</tr>
<tr class="odd">
<td><p>Manage a domain-based namespace</p></td>
<td><p>Local Administrators group on each namespace server</p></td>
<td><p>Right-click the domain-based namespace in the console tree, and then click <strong>Delegate Management Permissions</strong> .</p></td>
</tr>
<tr class="even">
<td><p>Create a stand-alone namespace</p></td>
<td><p>Local Administrators group on the namespace server</p></td>
<td><p>Add the user to the local Administrators group on the namespace server.</p></td>
</tr>
<tr class="odd">
<td><p>Manage a stand-alone namespace*</p></td>
<td><p>Local Administrators group on the namespace server</p></td>
<td><p>Right-click the stand-alone namespace in the console tree, and then click <strong>Delegate Management Permissions</strong> . Or use the <code>Set-DfsnRoot â€“GrantAdminAccounts</code> and <code>Set-DfsnRoot â€“RevokeAdminAccounts</code> Windows PowerShell cmdlets (introduced in Windows ServerÂ 2012).</p></td>
</tr>
<tr class="even">
<td><p>Create a replication group or enable DFS Replication on a folder</p></td>
<td><p>Domain Admins group in the domain where the namespace is configured</p></td>
<td><p>Right-click the <strong>Replication</strong> node in the console tree, and then click <strong>Delegate Management Permissions</strong> .</p></td>
</tr>
</tbody>
</table>

\* Delegating management permissions to manage a stand-alone namespace does not grant the user the ability to view and manage security by using the **Delegation** tab unless the user is a member of the local Administrators group on the namespace server. This issue occurs because the DFS Management snap-in cannot retrieve the discretionary access control lists (DACLs) for the stand-alone namespace from the registry. To enable the snap-in to display delegation information, you must follow the steps in article 314837 in the Microsoft Knowledge Base (<http://go.microsoft.com/fwlink?linkid=46803>).


