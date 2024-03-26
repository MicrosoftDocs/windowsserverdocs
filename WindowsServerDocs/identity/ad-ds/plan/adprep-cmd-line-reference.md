---
title: Adprep
description: Learn about Adprep command line tool to prepare a forest and domain for a domain controller for Windows Server.
ms.topic: reference
author: gswashington
ms.author: 
ms.date: 04/14/2024

---

# Adprep

Applies to: Windows Server (All supported versions)

Extends the Active Directory schema and updates permissions as necessary to prepare a forest and domain for a domain controller that runs Windows Server.

Adprep.exe is a command-line tool available in Windows Server. You must run **adprep** from an elevated command prompt. To open an elevated command prompt, select **Start**, right-select **Command Prompt**, and then select **Run as administrator**.

Adprep is available in a 32-bit version and a 64-bit version. The 64-bit version runs by default. If you need to run Adprep on a 32-bit computer, run the 32-bit version (Adprep32.exe).

For more information about running Adprep.exe and how to resolve errors that can occur when you run it, see [Running Adprep.exe](https://go.microsoft.com/fwlink/?linkid=142597).

For examples of how this command can be used, see [Examples]().

For more information about running **adprep /forestprep**, see Prepare a Windows 2000 or Windows Server 2003 Forest Schema for a Domain Controller That Runs Windows Server 2008 or Windows Server 2008 R2 ([https://go.microsoft.com/fwlink/?LinkID=93242](https://go.microsoft.com/fwlink/?linkid=93242)).

For more information about running **adprep /domainprep /gpprep**, see Prepare a Windows 2000 or Windows Server 2003 Domain for a Domain Controller That Runs Windows Server 2008 or Windows Server 2008 R2 ([https://go.microsoft.com/fwlink/?LinkID=93243](https://go.microsoft.com/fwlink/?linkid=93243)).

For more information about running **adprep /rodcprep**, see Prepare a Forest for a Read-Only Domain Controller ([https://go.microsoft.com/fwlink/?LinkID=93244](https://go.microsoft.com/fwlink/?linkid=93244)).

## Syntax

    adprep {/forestprep | /domainprep | /domainprep /gpprep | /rodcprep | /wssg | /silent }

## Parameters

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Parameter</p></th>
<th><p>Description</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>/forestprep</p></td>
<td><p>Prepares a forest for the introduction of a domain controller that runs Windows Server 2008. You run this command only once in the forest. You must run this command on the domain controller that holds the schema operations master role (also known as flexible single master operations or FSMO) for the forest. You must be a member of all the following groups to run this command:</p>
<ul>
<li><p>The Enterprise Admins group</p></li>
<li><p>The Schema Admins group</p></li>
<li><p>The Domain Admins group of the domain that hosts the schema master</p></li>
</ul></td>
</tr>
<tr class="even">
<td><p>/domainprep</p></td>
<td><p>Prepares a domain for the introduction of a domain controller that runs Windows Server 2008. You run this command after the <strong>forestprep</strong> command finishes and after the changes replicate to all the domain controllers in the forest.</p>
<p>Run this command in each domain where you plan to add a domain controller that runs Windows Server 2008. You must run this command on the domain controller that holds the infrastructure operations master role for the domain. You must be a member of the Domain Admins group to run this command.</p></td>
</tr>
<tr class="odd">
<td><p>/domainprep /gpprep</p></td>
<td><p>Performs similar updates as <strong>domainprep</strong>. However, this command also provides updates that are necessary to enable Resultant Set of Policy (RSOP) Planning Mode functionality.</p>
<p>In Active Directory environments that run Microsoft Windows® 2000, this command performs updates during off-peak hours. This minimizes replication traffic that is created in those environments by updates to file system permissions and Active Directory permissions on existing Group Policy objects (GPOs). This command is also available on Microsoft Windows Server 2003 with Service Pack 1 (SP1) or later.</p>
<p>Run this command after the <strong>forestprep</strong> command finishes and after the changes replicate to all domain controllers in the forest. You must run this command on the infrastructure master for the domain. For more information about running this command in Windows 2000 Active Directory environments, see Prepare Your Infrastructure for Upgrade (<a href="https://go.microsoft.com/fwlink/?linkid=94798">https://go.microsoft.com/fwlink/?LinkId=94798</a>).</p></td>
</tr>
<tr class="even">
<td><p>/rodcprep</p></td>
<td><p>Updates permissions on application directory partitions to enable replication of the partitions to read-only domain controllers (RODCs). This operation runs remotely; it contacts the infrastructure master in each domain to update the permissions. You need to run this command only once in the forest. However, you can rerun this command any time if it fails to complete successfully because an infrastructure master is not available. You can run this command on any computer in the forest. You must be a member of the Enterprise Admins group to run this command.</p></td>
</tr>
<tr class="odd">
<td><p>/wssg</p></td>
<td><p>Returns an expanded set of exit codes, instead of just 0 (Success) and 1 (Failure).</p></td>
</tr>
<tr class="even">
<td><p>/silent</p></td>
<td><p>Specifies that no standard output is returned from an operation. This parameter can be used only if <strong>/wssg</strong> is also used.</p></td>
</tr>
<tr class="odd">
<td><p>quit</p></td>
<td><p>Returns to the prior menu.</p></td>
</tr>
<tr class="even">
<td><p>Help</p></td>
<td><p>Displays Help for this command.</p></td>
</tr>
<tr class="odd">
<td><p>?</p></td>
<td><p>Displays Help for this command.</p></td>
</tr>
</tbody>
</table>

## Remarks

- To prepare an existing Windows 2000 or Windows Server 2003 Active Directory environment for a Windows Server 2008 domain controller, be sure to run the version of Adprep that is included in the Windows Server 2008 installation media.

- If you run Adprep on a domain controller running Windows 2000 Server, the domain controller must be running Windows 2000 Server Service Pack 4 (SP4) or later.

- You can also perform verification steps before and after you run the **adprep** command to help ensure that the operations complete successfully. For more information, see Steps for Extending the Schema ([https://go.microsoft.com/fwlink/?LinkId=94799](https://go.microsoft.com/fwlink/?linkid=94799)).

## Exit Codes

The following table lists exit codes that Adprep can return after an operation completes.

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Return Code</p></th>
<th><p>Description</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>0</p></td>
<td><p>Success</p></td>
</tr>
<tr class="even">
<td><p>1</p></td>
<td><p>Failure</p></td>
</tr>
<tr class="odd">
<td><p>2</p></td>
<td><p>Schema conflict error</p></td>
</tr>
<tr class="even">
<td><p>3</p></td>
<td><p>FSMO role error</p></td>
</tr>
<tr class="odd">
<td><p>4</p></td>
<td><p>Connection error</p></td>
</tr>
<tr class="even">
<td><p>5</p></td>
<td><p>Schema upgrade error</p></td>
</tr>
<tr class="odd">
<td><p>6</p></td>
<td><p>Unable to modify error</p></td>
</tr>
<tr class="even">
<td><p>7</p></td>
<td><p>Server busy error</p></td>
</tr>
<tr class="odd">
<td><p>8</p></td>
<td><p>Permission error</p></td>
</tr>
<tr class="even">
<td><p>9</p></td>
<td><p>Unable to initialize log file error</p></td>
</tr>
<tr class="odd">
<td><p>10</p></td>
<td><p>Not a domain controller</p></td>
</tr>
<tr class="even">
<td><p>11</p></td>
<td><p>In nonnative mode</p></td>
</tr>
<tr class="odd">
<td><p>12</p></td>
<td><p>Need to run forest update first</p></td>
</tr>
<tr class="even">
<td><p>13</p></td>
<td><p>Forest update already done</p></td>
</tr>
<tr class="odd">
<td><p>14</p></td>
<td><p>Domain update already done</p></td>
</tr>
<tr class="even">
<td><p>15</p></td>
<td><p>GPO update already done</p></td>
</tr>
<tr class="odd">
<td><p>16</p></td>
<td><p>Forest update wait replication</p></td>
</tr>
</tbody>
</table>

## Examples

The following example prepares a forest for a domain controller that runs Windows Server 2008:

    adprep /forestprep

The following example prepares a domain for a domain controller that runs Windows Server 2008:

    adprep /domainprep

The following example prepares a domain for an RODC:

    adprep /rodcprep

## See also

[Command-Line Syntax Key](cc771080\(v=ws.11\).md)

