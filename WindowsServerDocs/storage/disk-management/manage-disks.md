Applies To: Windows 7, Windows Server 2008 R2

This section includes the most common disk management tasks, including moving disks between computers, changing disks between basic and dynamic types, and changing the partition style of disks.

#### Converting disk types

Although Disk Management allows you to change disks between various types and partition styles, some of the operations are irreversible (unless you reformat the drive). You should carefully consider the disk type and partition style that is most appropriate for your application.

For more information about considerations for using basic versus dynamic disks, see <http://go.microsoft.com/fwlink/?LinkId=64117> and <http://go.microsoft.com/fwlink/?LinkId=64119>.

The following table shows the options for converting disks between the various partition styles:

### Â 

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<thead>
<tr class="header">
<th>Disk type</th>
<th>Convert to MBR</th>
<th>Convert to GPT</th>
<th>Convert to dynamic</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Master boot record (MBR)</p></td>
<td><p>--</p></td>
<td><p>Allowed (if no volumes on disk).</p></td>
<td><p>Allowed, but disk might become unbootable. See Note.</p></td>
</tr>
<tr class="even">
<td><p>GUID partition table (GPT)</p></td>
<td><p>Allowed (if no volumes on disk).</p></td>
<td><p>--</p></td>
<td><p>Allowed, but disk might become unbootable. See Note.</p></td>
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
<td>In a multiboot scenario, if you are booted into one operating system, and you convert a basic MBR disk that contains an alternate operating system to a dynamic disk, you will not be able to boot into the alternate operating system.
<p></p></td>
</tr>
</tbody>
</table>

#### Online and offline status

Disk Management displays the online and offline status of disks. In WindowsÂ Vista, the default is that all newly discovered disks are brought online with read and write access. In Windows ServerÂ 2008 Enterprise and Windows ServerÂ 2008 Datacenter, the default is that newly discovered disks are brought online with read and write access unless they are on a shared bus (such as SCSI, iSCSI, Serial Attached SCSI, or Fibre Channel). Disks on a shared bus will be offline the first time they are detected.

If a disk is offline, you must bring it online before you can initialize it or create volumes on it. Bring a disk online or take it offline by right-clicking the disk name and then clicking the appropriate action.

-   [Initialize New Disks](https://technet.microsoft.com/en-us/library/cc771486(v=ws.11).aspx)
-   [Move Disks to Another Computer](https://technet.microsoft.com/en-us/library/cc753750(v=ws.11).aspx)
-   [Reactivate a Missing or Offline Dynamic Disk](https://technet.microsoft.com/en-us/library/cc732026(v=ws.11).aspx)
-   [Change a Basic Disk into a Dynamic Disk](https://technet.microsoft.com/en-us/library/cc731274(v=ws.11).aspx)
-   [Change a Dynamic Disk Back to a Basic Disk](https://technet.microsoft.com/en-us/library/cc755238(v=ws.11).aspx)
-   [Change a Master Boot Record Disk into a GUID Partition Table Disk](https://technet.microsoft.com/en-us/library/cc725671(v=ws.11).aspx)
-   [Change a GUID Partition Table Disk into a Master Boot Record Disk](https://technet.microsoft.com/en-us/library/cc725797(v=ws.11).aspx)
-   [Remove a Missing Dynamic Disk](https://technet.microsoft.com/en-us/library/cc753029(v=ws.11).aspx)
-   [Manage Disks Remotely](https://technet.microsoft.com/en-us/library/dd759223(v=ws.11).aspx)
-   [Manage Virtual Hard Disks](https://technet.microsoft.com/en-us/library/dd851645(v=ws.11).aspx)


