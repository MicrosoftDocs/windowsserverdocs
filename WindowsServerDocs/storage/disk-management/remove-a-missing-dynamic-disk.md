Applies To: Windows 7, Windows Server 2008 R2

A dynamic disk may become **Missing** when it is corrupted, powered down, or disconnected.

**Backup Operators** or **Administrator** is the minimum membership required.

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
<td>Do not delete the volumes from a missing dynamic disk unless you are certain that the disk will not be powered up, reconnected, repaired or otherwise returned to the computer. Otherwise, you will not be able to access those volumes when the disk is returned to the computer.
<p></p></td>
</tr>
</tbody>
</table>

Removing a missing dynamic disk
-------------------------------

-   [Using the Windows interface](#BKMK_WINUI)
-   [Using a command line](#BKMK_CMD)

<a href="" id="BKMK_WINUI"></a>
**To remove a missing dynamic disk using the Windows interface**
1.  In Disk Manager, right-click each volume on the dynamic disk marked **Missing**, and then click **Delete Volume** to remove all volumes on the **Missing** disk.

2.  Right-click the dynamic disk marked **Missing**, and then click **Remove Disk**.

<a href="" id="BKMK_CMD"></a>
**To remove a missing dynamic disk using a command line**
1.  Open a command prompt and type `diskpart`.

2.  At the **DISKPART** prompt, type `list disk`. Make note of the disk number you want to remove from the disk list. Missing disks are numbered M0, M1, M2, and so on.

3.  At the **DISKPART** prompt, type `select disk <disknumber>`.

4.  At the **DISKPART** prompt, type `delete disk`.

### Â 

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th>Value</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>**list disk**</p></td>
<td><p>Displays a list of disks and information about them, such as their size, amount of available free space, whether the disk is a basic or dynamic disk, and whether the disk uses the master boot record (MBR) or GUID partition table (GPT) partition style. The disk marked with an asterisk (*) has focus.</p></td>
</tr>
<tr class="even">
<td><p>**select disk** <em>disknumber</em></p></td>
<td><p>Selects the specified disk, where <em>disknumber</em> is the disk number, and gives it focus.</p></td>
</tr>
<tr class="odd">
<td><p>**delete disk**</p></td>
<td><p>Deletes a missing dynamic disk from the disk list.</p></td>
</tr>
</tbody>
</table>

#### Additional references

-   [Command-line syntax notation](https://technet.microsoft.com/en-us/library/cc742449(v=ws.11).aspx)


