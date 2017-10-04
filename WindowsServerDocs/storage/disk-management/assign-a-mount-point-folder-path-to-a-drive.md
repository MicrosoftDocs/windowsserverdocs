Applies To: Windows 7, Windows Server 2008 R2

You can use Disk Management to assign a mount-point folder path (rather than a drive letter) to the drive. Mount-point folder paths are available only on empty folders on basic or dynamic NTFS volumes.

**Backup Operator** or **Administrator** is the minimum membership required.

Assigning a mount-point folder path to a drive
----------------------------------------------

-   [Using the Windows interface](#BKMK_WINUI)
-   [Using a command line](#BKMK_CMD)

<a href="" id="BKMK_WINUI"></a>
**To assign a mount-point folder path to a drive by using the Windows interface**
1.  In Disk Manager, right-click the partition or volume where you want to assign the mount-point folder path, and then click **Change Drive Letter and Paths**.

2.  Do one of the following:

    -   To assign a mount-point folder path, click **Add**. Click **Mount in the following empty NTFS folder**, type the path to an empty folder on an NTFS volume, or click **Browse** to locate it.
    -   To remove the mount-point folder path, click it and then click **Remove**.

#### Additional considerations

-   If you are administering a local or remote computer, you can browse NTFS folders on that computer.
-   When assigning a mount-point folder path to a drive, use **Event Viewer** to check the system log for any Cluster service errors or warnings indicating mount point failures. These errors would be listed as ClusSvc in the **Source** column and Physical Disk Resource in the **Category** column.

<a href="" id="BKMK_CMD"></a>
**To assign a mount-point folder path to a drive using a command line**
1.  Open a command prompt and type `diskpart`.

2.  At the **DISKPART** prompt, type `list volume`. Make note of the volume number you want to assign the path to elsewhere.

3.  At the **DISKPART** prompt, type `select volume <volumenumber>`. Select the simple volume *volumenumber* that you want to assign the path to.

4.  At the **DISKPART** prompt, type `assign [mount=<path>]`.


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
<td><p>Selects the specified volume, where <em>volumenumber</em> is the volume number, and gives it focus. If no volume is specified, the **select** command lists the current volume with focus. You can specify the volume by number, drive letter, or mount-point folder path. On a basic disk, selecting a volume also gives the corresponding partition focus.</p></td>
</tr>
<tr class="odd">
<td><p>**assign**</p></td>
<td><p>Assigns a drive letter or mount-point folder path to the volume with focus. If no drive letter or mount-point folder path is specified, then the next available drive letter is assigned. If the drive letter or mount-point folder path is already in use, an error is generated.</p>
<p>Using the **assign** command, you can change the drive letter associated with a removable drive.</p>
<p>You cannot assign drive letters to boot volumes, or volumes that contain the paging file. In addition, you cannot assign a drive letter to an Original Equipment Manufacturer (OEM) partition, EFI system partition, or any GPT partition other than a basic data partition.</p></td>
</tr>
<tr class="even">
<td><p>**mount=** <em>path</em></p></td>
<td><p>Specifies an empty, existing NTFS folder where the mounted drive will reside.</p></td>
</tr>
</tbody>
</table>

#### Additional considerations

-   Mount-point folder paths are available only on empty folders on basic or dynamic NTFS volumes.
-   To modify a mount-point folder path, remove it, and then create a new folder path using the new location. You cannot modify the mount-point folder path directly.
-   When assigning a mount-point folder path to a drive, use **Event Viewer** to check the system log for any Cluster service errors or warnings indicating mount-point folder path failures. These errors would be listed as **ClusSvc** in the **Source** column and **Physical Disk Resource** in the **Category** column.
-   You can also create a mounted drive using the **mountvol** command. For more information, see <http://go.microsoft.com/fwlink/?linkid=64111>.

#### Additional references

-   [Command-line syntax notation](https://technet.microsoft.com/en-us/library/cc742449(v=ws.11).aspx)


