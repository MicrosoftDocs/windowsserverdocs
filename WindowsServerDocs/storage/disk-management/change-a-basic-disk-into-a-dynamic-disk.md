Applies To: Windows 7, Windows Server 2008 R2

When you change a basic disk to dynamic, you can create volumes that span multiple disks (spanned and striped volumes). Dynamic volumes can be used in most but not all situations.

Basic disks support only primary partitions, extended partitions, and logical drives. Basic disks have been supported in operating systems since MS-DOS, while dynamic disks have been supported in operating systems since WindowsÂ 2000.

**Backup Operators** or **Administrator** is the minimum membership required.

<table>
<colgroup>
<col width="100%" />
</colgroup>
<thead>
<tr class="header">
<th><img src="https://i-technet.sec.s-msft.com/dynimg/IC1429.gif" title="Caution" alt="Caution" id="Caution" />Caution</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Do not convert disks to dynamic that contain multiple installations of WindowsÂ 2000, Windows XP Professional, or the Windows ServerÂ 2003 family of operating systems. It is likely that you will no longer be able to start the second installation. For more information, see <a href="http://go.microsoft.com/fwlink/?LinkId=64134" class="uri">http://go.microsoft.com/fwlink/?LinkId=64134</a>.
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
<td>The decision to convert a basic disk to a dynamic disk has implications that should be considered carefully. For more information about basic and dynamic disks and how to choose which type to use, see <a href="http://go.microsoft.com/fwlink/?LinkId=64133" class="uri">http://go.microsoft.com/fwlink/?LinkId=64133</a>.
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

Changing a basic disk into a dynamic disk
-----------------------------------------

-   [Using the Windows interface](#BKMK_WINUI)
-   [Using a command line](#BKMK_CMD)

<a href="" id="BKMK_WINUI"></a>
**To change a basic disk into a dynamic disk using the Windows interface**
1.  In Disk Management, right-click the basic disk you want to convert.

2.  Click **Convert to Dynamic Diskâ€¦**.

3.  Follow the instructions on your screen.

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
    <td>If you do not see this menu item, you might be right-clicking a volume instead of a disk, the disk might have been previously converted to a dynamic disk, or the computer is a portable computer. (Dynamic disks are not supported on portable computers, removable disks, detachable disks that use Universal Serial Bus (USB) or IEEE 1394 (also called FireWire) interfaces, or on disks connected to shared SCSI buses.) In addition, you cannot convert cluster disks connected to shared SCSI or Fibre Channel buses to dynamic disks. The Cluster service supports basic disks only.)
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
    <th><img src="https://i-technet.sec.s-msft.com/dynimg/IC1429.gif" title="Caution" alt="Caution" id="Caution" />Caution</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>If you are using a basic disk as a storage area for shadow copies and you intend to convert the disk into a dynamic disk, it is important to take the following precaution to avoid data loss. If the disk is a non-boot volume and is a different volume from where the original files reside, you must first dismount and take offline the volume containing the original files before you convert the disk containing shadow copies to a dynamic disk. You must bring the volume containing the original files back online within 20 minutes, otherwise, you will lose the data stored in the existing shadow copies. If the shadow copies are located on a boot volume, you can convert the disk to dynamic without losing shadow copies. You can use the **mountvol** command with the **/p** option to dismount the volume and take it offline. You can mount the volume and bring it online using the **mountvol** command or the Disk Management snap-in.
    <p></p></td>
    </tr>
    </tbody>
    </table>

#### Additional considerations

-   For additional information about converting basic disks to dynamic disks, see <http://go.microsoft.com/fwlink/?LinkId=64136>.
-   After you convert a basic disk to a dynamic disk, you cannot change the dynamic volumes back to partitions. Instead, you must delete all dynamic volumes on the disk and then use the **Convert To Basic Disk** command. If you want to keep your data, you must first back it up or move it to another volume.
-   Once converted, a dynamic disk will not contain basic volumes (primary partitions or logical drives).
-   When you convert a basic disk to a dynamic disk, any existing partitions or logical drives on the basic disk become simple volumes on the dynamic disk.
-   For the conversion to succeed, any master boot record (MBR) disks to be converted must contain at least 1 MB of space for the dynamic disk database.

<a href="" id="BKMK_CMD"></a>
**To change a basic disk into a dynamic disk using a command line**
1.  Open a command prompt and type `diskpart`.

2.  At the **DISKPART** prompt, type `list disk`. Make note of the disk number you want to convert to dynamic.

3.  At the **DISKPART** prompt, type `select disk <disknumber>`.

4.  At the **DISKPART** prompt, type `convert dynamic`.

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
<td><p>**convert dynamic**</p></td>
<td><p>Converts a basic disk into a dynamic disk. Any existing partitions on the disk become simple volumes.</p></td>
</tr>
</tbody>
</table>

<table>
<colgroup>
<col width="100%" />
</colgroup>
<thead>
<tr class="header">
<th><img src="https://i-technet.sec.s-msft.com/dynimg/IC1429.gif" title="Caution" alt="Caution" id="Caution" />Caution</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>If you are using a basic disk as a storage area for shadow copies and you intend to convert the disk into a dynamic disk, it is important to take the following precaution to avoid data loss. If the disk is a non-boot volume and is a different volume from where the original files reside, you must first dismount and take offline the volume containing the original files before you convert the disk containing shadow copies to a dynamic disk. You must bring the volume containing the original files back online within 20 minutes, otherwise, you will lose the data stored in the existing shadow copies. If the shadow copies are located on a boot volume, you can convert the disk to dynamic without losing shadow copies. You can use the **mountvol** command with the **/p** option to dismount the volume and take it offline. You can mount the volume and bring it online using the **mountvol** command or the Disk Management snap-in.
<p></p></td>
</tr>
</tbody>
</table>

#### Additional considerations

-   For additional information about converting basic disks to dynamic disks, see <http://go.microsoft.com/fwlink/?LinkId=64136>.
-   After you convert a basic disk to a dynamic disk, you cannot change the dynamic volumes back to partitions. Instead, you must delete all dynamic volumes on the disk and then use the **Convert To Basic Disk** command. If you want to keep your data, you must first back it up or move it to another volume.
-   Once converted, a dynamic disk will not contain basic volumes (primary partitions or logical drives).
-   When you convert a basic disk to a dynamic disk, any existing partitions or logical drives on the basic disk become simple volumes on the dynamic disk.
-   For the conversion to succeed, any master boot record (MBR) disks to be converted must contain at least 1 MB of space for the dynamic disk database.

#### Additional references

-   [Command-line syntax notation](https://technet.microsoft.com/en-us/library/cc742449(v=ws.11).aspx)


