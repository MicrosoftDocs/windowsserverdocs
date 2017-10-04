Applies To: Windows 7, Windows Server 2008 R2

Master boot record (MBR) disks use the standard BIOS partition table. GUID partition table (GPT) disks use unified extensible firmware interface (UEFI). MBR disks do not support more than four partitions on each disk. The MBR partition method is not recommended for disks larger than 2 terabytes.

You can change a disk from GPT to MBR partition style as long as the disk is empty and contains no volumes.

**Backup Operators** or **Administrator** is the minimum membership required.

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
<td>Before you convert disks, close any programs that are running on those disks.
<p></p></td>
</tr>
</tbody>
</table>

Changing a GUID partition table disk into a master boot record disk
-------------------------------------------------------------------

-   [Using the Windows interface](#BKMK_WINUI)
-   [Using a command line](#BKMK_CMD)

<a href="" id="BKMK_WINUI"></a>
#### To change a GUID partition table disk into a master boot record disk using the Windows interface

1.  Back up or move all volumes on the basic GUID partition table (GPT) disk you want to convert into a master boot record (MBR) disk.

2.  If the disk contains any partitions or volumes, right-click any volumes on the disk and then click **Delete Volume**.

3.  Right-click the GPT disk that you want to change into an MBR disk, and then click **Convert to MBR disk**.

<a href="" id="BKMK_CMD"></a>
#### To change a GUID partition table disk into a master boot record disk using command line

1.  Back up or move all volumes on the basic GUID partition table (GPT) disk you want to convert into a master boot record (MBR) disk.

2.  Open an elevated command prompt and type `diskpart`. If the disk does not contain any partitions or volumes, skip to step 6.

3.  At the **DISKPART** prompt (right-click **Command Prompt**, and then click **Run as Administrator**), type `list disk`. Make note of the disk number you want to delete.

4.  At the **DISKPART** prompt, type `select disk <disknumber>`.

5.  At the **DISKPART** prompt, type `clean`.

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
    <td>Running the **clean** command will delete all partitions or volumes on the disk.
    <p></p></td>
    </tr>
    </tbody>
    </table>

6.  At the **DISKPART** prompt, type `convert mbr`.

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
<td><p>**select disk**</p></td>
<td><p>Selects the specified disk, where <em>disknumber</em> is the disk number, and gives it focus.</p></td>
</tr>
<tr class="odd">
<td><p>**clean**</p></td>
<td><p>Removes all partitions or volumes from the disk with focus.</p></td>
</tr>
<tr class="even">
<td><p>**convert mbr**</p></td>
<td><p>Converts an empty basic disk with the GUID Partition Table (GPT) partition style to a basic disk with the master boot record (MBR) partition style.</p></td>
</tr>
</tbody>
</table>

#### Additional references

-   [Command-line syntax notation](https://technet.microsoft.com/en-us/library/cc742449(v=ws.11).aspx)


