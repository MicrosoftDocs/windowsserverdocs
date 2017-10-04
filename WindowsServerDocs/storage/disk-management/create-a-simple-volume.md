Applies To: Windows 7, Windows Server 2008 R2

A simple volume is a dynamic volume that is made up of disk space from a single dynamic disk. A simple volume can consist of a single region on a disk or multiple regions of the same disk that are linked together. You can create simple volumes only on dynamic disks.

Simple volumes are not fault tolerant.

**Backup Operator** or **Administrator** is the minimum membership required to complete the actions below.

Creating a simple volume
------------------------

-   [Using the Windows interface](#BKMK_WINUI)
-   [Using a command line](#BKMK_CMD)

<a href="" id="BKMK_WINUI"></a>
**To create a simple volume using the Windows interface**
1.  In Disk Management, right-click the unallocated space on the dynamic disk on which you want to create the simple volume, and then click **New Simple Volume**.

2.  In the New Volume Wizard, click **Next**, click **Simple**, and then follow the instructions on your screen.

<a href="" id="BKMK_CMD"></a>
**To create a simple volume using a command line**
1.  Open a command prompt and type `diskpart`.

2.  At the **DISKPART** prompt, type `list disk`. Make note of the number of the disk where you want to create a simple volume.

3.  At the **DISKPART** prompt, type `create volume simple [size=<size>] [disk=<disknumber>]`.

4.  At the **DISKPART** prompt, type `assign letter=<driveletter>`.

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
<td><p>**assign letter**=<em>driveletter</em></p></td>
<td><p>Assigns a drive letter, <em>driveletter</em>, to the volume with focus. If no drive letter or mount point is specified, the next available drive letter is assigned. If the drive letter or mount point is already in use, an error is generated.</p></td>
</tr>
</tbody>
</table>

#### Additional references

-   [Command-line syntax notation](https://technet.microsoft.com/en-us/library/cc742449(v=ws.11).aspx)


