Applies To: Windows 7, Windows Server 2008 R2

A spanned volume is a dynamic volume consisting of disk space on more than one physical disk. If a simple volume is not a system volume or boot volume, you can extend it across additional disks to create a spanned volume, or you can create a spanned volume in unallocated space on a dynamic disk.

You need at least two dynamic disks in addition to the startup disk to create a spanned volume. You can extend a spanned volume onto a maximum of 32 dynamic disks.

Spanned volumes are not fault tolerant.

**Backup Operator** or **Administrator** is the minimum membership required to complete the actions below.

Creating a spanned volume
-------------------------

-   [Using the Windows interface](#BKMK_WINUI)
-   [Using a command line](#BKMK_CMD)

<a href="" id="BKMK_WINUI"></a>
**To create a spanned volume using the Windows interface**
1.  In Disk Management, right-click the unallocated space on one of the dynamic disks where you want to create the spanned volume.

2.  Click **New Spanned Volumeâ€¦**.

3.  Follow the instructions on your screen.

<a href="" id="BKMK_CMD"></a>
**To create a spanned volume using a command line**
1.  Open a command prompt and type `diskpart`.

2.  At the **DISKPART** prompt, type `list disk`. Make note of the number of the disk where you want to create a simple volume.

3.  At the **DISKPART** prompt, type `create volume simple [size=<size>] [disk=<disknumber>]`.

4.  At the **DISKPART** prompt, type `list volume`. Make note of the number of the simple volume you want to extend onto another disk.

5.  At the **DISKPART** prompt, type `select volume <volumenumber>`. Select the simple volume *volumenumber* you want to extend onto another disk.

6.  At the **DISKPART** prompt, type `list disk`. Make note of the number of the disk you want to extend the simple volume onto.

7.  At the DISKPART prompt, type `extend [size=<size>] [disk=<disknumber>]`. Extends the selected volume onto disk *disknumber* and makes the extension size=*size* megabytes (MB).

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
<td><p>**create volume simple**</p></td>
<td><p>Creates a simple volume. After you create the volume, the focus automatically shifts to the new volume.</p></td>
</tr>
<tr class="odd">
<td><p>**size=** <em>size</em></p></td>
<td><p>The size of the volume in megabytes (MB). If no size is given, the new volume takes up the remaining free space on the disk.</p></td>
</tr>
<tr class="even">
<td><p>**disk=** <em>disknumber</em></p></td>
<td><p>The dynamic disk on which to create the volume. If no disk is given, the current disk is used.</p></td>
</tr>
<tr class="odd">
<td><p>**list volume**</p></td>
<td><p>Displays a list of basic and dynamic volumes on all disks.</p></td>
</tr>
<tr class="even">
<td><p>**select volume**</p></td>
<td><p>Selects the specified volume, where <em>volumenumber</em> is the volume number, and gives it focus. If no volume is specified, the **select** command lists the current volume with focus. You can specify the volume by number, drive letter, or mount point path. On a basic disk, selecting a volume also gives the corresponding partition focus.</p></td>
</tr>
<tr class="odd">
<td><p>**extend**</p></td>
<td><p>Extends the volume with focus into next contiguous unallocated space. For basic volumes, the unallocated space must be on the same disk as, and must follow (be of higher sector offset than) the partition with focus. A dynamic simple or spanned volume can be extended to any empty space on any dynamic disk. Using this command, you can extend an existing volume into newly created space.</p>
<p>If the partition was previously formatted with the NTFS file system, the file system is automatically extended to occupy the larger partition. No data loss occurs. If the partition was previously formatted with any file system format other than NTFS, the command fails with no change to the partition.</p>
<p>You cannot extend the current system or boot partitions.</p></td>
</tr>
<tr class="even">
<td><p>**disk=** <em>disknumber</em></p></td>
<td><p>The dynamic disk on which to extend the volume. An amount of space equal to **size=**<em>size</em> is allocated on the disk. If no disk is specified, the volume is extended on the current disk.</p></td>
</tr>
<tr class="odd">
<td><p>**size=** <em>size</em></p></td>
<td><p>The amount of space, in megabytes (MB), to add to the current partition. If you do not specify a size, the disk is extended to take up all of the next contiguous unallocated space.</p></td>
</tr>
</tbody>
</table>

#### Additional references

-   [Command-line syntax notation](https://technet.microsoft.com/en-us/library/cc742449(v=ws.11).aspx)


