Applies To: Windows 7, Windows Server 2008 R2

Basic disks support only primary partitions, extended partitions, and logical drives. Basic disks have been supported in operating systems since MS-DOS, while dynamic disks have been supported in operating systems since WindowsÂ 2000.

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
<td>The decision to convert a dynamic disk to a basic disk has implications that should be considered carefully. For more information about basic and dynamic disks and how to choose which type to use, see <a href="http://go.microsoft.com/fwlink/?LinkId=64133" class="uri">http://go.microsoft.com/fwlink/?LinkId=64133</a>.
<p></p></td>
</tr>
</tbody>
</table>

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

Changing a dynamic disk back to a basic disk
--------------------------------------------

-   [Using the Windows interface](#BKMK_WINUI)
-   [Using a command line](#BKMK_CMD)

<a href="" id="BKMK_WINUI"></a>
**To change a dynamic disk back to a basic disk using the Windows interface**
1.  Back up all volumes on the disk you want to convert from dynamic to basic.

2.  In Disk Management, right-click each volume on the dynamic disk you want to convert to a basic disk, and then click **Delete Volume** for each volume on the disk.

3.  When all volumes on the disk have been deleted, right-click the disk, and then click **Convert to Basic Disk**.

#### Additional considerations

-   The disk must not have any volumes nor contain any data before you can change it back to a basic disk. If you want to keep your data, back it up or move it to another volume before you convert the disk to a basic disk.
-   Once you change a dynamic disk back to a basic disk, you can create only partitions and logical drives on that disk.

<a href="" id="BKMK_CMD"></a>
**To change a dynamic disk back to a basic disk using a command line**
1.  Back up all volumes on the disk you want to convert from dynamic to basic.

2.  Open a command prompt and type `diskpart`.

3.  At the **DISKPART** prompt, type `list disk`. Make note of the disk number you want to convert to basic.

4.  At the **DISKPART** prompt, type `select disk <disknumber>`.

5.  At the **DISKPART** prompt, type `detail disk <disknumber>`.

6.  For each volume on the disk, at the **DISKPART** prompt, type `select volume= <volumenumber>` and then type `delete volume`.

7.  At the **DISKPART** prompt, type `select disk <disknumber>`. Specify the disk number of the disk that you want to convert to a basic disk.

8.  At the **DISKPART** prompt, type `convert basic`.

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
<td><p>**detail disk** <em>disknumber</em></p></td>
<td><p>Displays the properties of the selected disk and the volumes on that disk.</p></td>
</tr>
<tr class="even">
<td><p>**select volume** <em>disknumber</em></p></td>
<td><p>Selects the specified volume, where <em>disknumber</em> is the volume number, and gives it focus. If no volume is specified, the **select** command lists the current volume with focus. You can specify the volume by number, drive letter, or mount point path. On a basic disk, selecting a volume also gives the corresponding partition focus.</p></td>
</tr>
<tr class="odd">
<td><p>**delete volume**</p></td>
<td><p>Deletes the selected volume. You cannot delete the system volume, boot volume, or any volume that contains the active paging file or crash dump (memory dump).</p></td>
</tr>
<tr class="even">
<td><p>**convert basic**</p></td>
<td><p>Converts an empty dynamic disk into a basic disk.</p></td>
</tr>
</tbody>
</table>

#### Additional considerations

-   The disk must not have any volumes or contain any data before you can change it back to a basic disk. If you want to keep your data, back it up or move it to another volume before you convert the disk to a basic disk.
-   Once you change a dynamic disk back to a basic disk, you can create only partitions and logical drives on that disk.

#### Additional references

-   [Command-line syntax notation](https://technet.microsoft.com/en-us/library/cc742449(v=ws.11).aspx)


