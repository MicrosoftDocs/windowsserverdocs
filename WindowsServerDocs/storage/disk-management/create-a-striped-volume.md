Applies To: Windows 7, Windows Server 2008 R2

A striped volume is a dynamic volume that stores data in stripes on two or more physical disks. Data in a striped volume is allocated alternately and evenly (in stripes) across the disks. Striped volumes offer the best performance of all the volumes that are available in Windows, but they do not provide fault tolerance. If a disk in a striped volume fails, the data in the entire volume is lost.

You can create striped volumes only on dynamic disks. Striped volumes cannot be extended. You can create a striped volume onto a maximum of 32 dynamic disks.

**Backup Operator** or **Administrator** is the minimum membership required to complete the actions below.

Creating a striped volume
-------------------------

-   [Using the Windows interface](#BKMK_WINUI)
-   [Using a command line](#BKMK_CMD)

<a href="" id="BKMK_WINUI"></a>
**To create a striped volume using the Windows interface**
1.  In Disk Management, right-click the unallocated space on one of the dynamic disks where you want to create the striped volume, and then click **New Striped Volumeâ€¦**.

2.  Follow the instructions on your screen.

<a href="" id="BKMK_CMD"></a>
**To create a striped volume using a command line**
1.  Open a command prompt and type `diskpart`.

2.  At the **DISKPART** prompt, type `list disk`. Make note of the number of the disk where you want to create a striped volume.

3.  At the **DISKPART** prompt, type `create volume stripe [size=<size>] [disk=<disknumber>[,[<seconddisknumber>,â€¦]]`.

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
<td><p>**create volume stripe**</p></td>
<td><p>Creates a striped volume on the specified disks. After you create the volume, the focus automatically shifts to the new volume.</p></td>
</tr>
<tr class="odd">
<td><p>**size=** <em>size</em></p></td>
<td><p>The amount of disk space, in megabytes (MB), that the volume will occupy on each disk. If no size is given, the new volume takes up the remaining free space on the smallest disk and an equal amount of space on each subsequent disk.</p></td>
</tr>
<tr class="even">
<td><p>**disk=** <em>disknumber</em></p></td>
<td><p>The dynamic disks on which to create the volume. An amount of space equal to **size=**<em>size</em> is allocated on each disk.</p></td>
</tr>
</tbody>
</table>

#### Additional references

-   [Command-line syntax notation](https://technet.microsoft.com/en-us/library/cc742449(v=ws.11).aspx)


