Applies To: Windows 7, Windows Server 2008 R2

You can add more space to existing primary partitions and logical drives by extending them into adjacent unallocated space on the same disk. To extend a basic volume, it must be raw or formatted with the NTFS file system. You can extend a logical drive within contiguous free space in the extended partition that contains it. If you extend a logical drive beyond the free space available in the extended partition, the extended partition grows to contain the logical drive.

For logical drives, boot, or system volumes, you can extend the volume only into contiguous space and only if the disk can be upgraded to a dynamic disk. For other volumes, you can extend the volume into noncontiguous space, but you will be prompted to convert the disk to dynamic.

Extending a basic volume
------------------------

-   [Using the Windows interface](#BKMK_WINUI)
-   [Using a command line](#BKMK_CMD)

<a href="" id="BKMK_WINUI"></a>
#### To extend a basic volume using the Windows interface

1.  In Disk Manager, right-click the basic volume you want to extend.

2.  Click **Extend Volumeâ€¦**.

3.  Follow the instructions on your screen.

<a href="" id="BKMK_CMD"></a>
#### To extend a basic volume using a command line

1.  Open a command prompt and type `diskpart`.

2.  At the **DISKPART** prompt, type `list volume`. Make note of the basic volume you want to extend.

3.  At the **DISKPART** prompt, type `select volume <volumenumber>`. This selects the basic volume *volumenumber* that you want to extend into contiguous, empty space on the same disk.

4.  At the **DISKPART** prompt, type `extend [size=<size>]`. This extends the selected volume by *size* megabytes (MB).

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
<p>If the partition was previously formatted with the NTFS file system, the file system is automatically extended to occupy the larger partition. No data loss occurs. If the partition was previously formatted with any file system format other than NTFS, the command fails with no change to the partition.</p></td>
</tr>
<tr class="even">
<td><p>**size=** <em>size</em></p></td>
<td><p>The amount of space, in megabytes (MB), to add to the current partition. If you do not specify a size, the disk is extended to take up all of the next contiguous unallocated space.</p></td>
</tr>
</tbody>
</table>

#### Additional considerations

-   To extend a basic volume, it must either raw (not formatted with a file system), or it must be formatted with the NTFS file system.
-   If the disk does not contain boot or system partitions, you can extend the volume into other non-boot or non-system disks, but the disk will be converted to a dynamic disk (if it can be upgraded).

#### Additional references

-   [Command-line syntax notation](https://technet.microsoft.com/en-us/library/cc742449(v=ws.11).aspx)


