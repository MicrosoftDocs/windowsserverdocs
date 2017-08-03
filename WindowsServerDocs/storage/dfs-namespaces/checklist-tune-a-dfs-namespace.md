Published: October 22, 2009

Updated: October 16, 2013

Applies To: Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2

After creating a namespace and adding folders and targets, use the following checklist to tune or optimize the way DFS Namespace handles referrals and polls Active Directory Domain Services (ADÂ DS) for updated namespace data.

In addition, by using a DFSÂ Namespaces enhancement known as target priority, you can specify the priority of servers so that a specific server is always placed first or last in the list of servers (known as a referral) that the client receives when it accesses a folder with targets in the namespace.

### Â 

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th>Task</th>
<th>Reference</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Prevent users from seeing folders in a namespace that they do not have permissions to access</p></td>
<td><p><a href="https://technet.microsoft.com/en-us/library/dd759150(v=ws.11).aspx">Enable Access-Based Enumeration on a Namespace</a></p></td>
</tr>
<tr class="even">
<td><p>Enable or prevent users from being referred to a namespace or folder target when they access a folder in the namespace</p></td>
<td><p><a href="https://technet.microsoft.com/en-us/library/cc771266(v=ws.11).aspx">Enable or Disable Referrals and Client Failback</a></p></td>
</tr>
<tr class="odd">
<td><p>Adjust how long clients cache a referral before requesting a new one</p></td>
<td><p><a href="https://technet.microsoft.com/en-us/library/cc753923(v=ws.11).aspx">Change the Amount of Time That Clients Cache Referrals</a></p></td>
</tr>
<tr class="even">
<td><p>Specify in what order users should be referred to folder targets</p></td>
<td><p><a href="https://technet.microsoft.com/en-us/library/cc732414(v=ws.11).aspx">Set the Ordering Method for Targets in Referrals</a></p></td>
</tr>
<tr class="odd">
<td><p>Override referral ordering for a specific namespace server or folder target</p></td>
<td><p><a href="https://technet.microsoft.com/en-us/library/cc770290(v=ws.11).aspx">Set Target Priority to Override Referral Ordering</a></p></td>
</tr>
<tr class="even">
<td><p>Optimize how namespace servers poll ADÂ DS to obtain the most current namespace data</p></td>
<td><p><a href="https://technet.microsoft.com/en-us/library/cc732193(v=ws.11).aspx">Optimize Namespace Polling</a></p></td>
</tr>
<tr class="odd">
<td><p>Use inherited permissions to control which users can view folders in a namespace for which access-based enumeration is enabled</p></td>
<td><p><a href="https://technet.microsoft.com/en-us/library/dd834874(v=ws.11).aspx">Using Inherited Permissions with Access-Based Enumeration</a></p></td>
</tr>
</tbody>
</table>

#### Additional references

-   [Namespaces](https://technet.microsoft.com/en-us/library/cc771914(v=ws.11).aspx)
-   [Checklist: Deploy DFS Namespaces](https://technet.microsoft.com/en-us/library/cc725830(v=ws.11).aspx)
-   [Tuning DFS Namespaces](https://technet.microsoft.com/en-us/library/cc771083(v=ws.11).aspx)


