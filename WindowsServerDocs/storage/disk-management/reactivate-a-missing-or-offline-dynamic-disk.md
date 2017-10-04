Applies To: Windows 7, Windows Server 2008 R2

A dynamic disk may become **Missing** when it is corrupted, powered down, or disconnected.

A dynamic disk may become **Offline** if it is corrupted or intermittently unavailable. A dynamic disk may also become **Offline** if you attempt to import a foreign (dynamic) disk and the import fails. An error icon appears on the **Offline** disk. Only dynamic disks display the **Missing** or **Offline** status.

Only dynamic disks can be reactivated.

**Backup** **Operator** or **Administrator** is the minimum membership required to perform these steps.

Reactivating a missing or offline dynamic disk
----------------------------------------------

-   [Using the Windows interface](#BKMK_WINUI)
-   [Using a command line](#BKMK_CMD)

<a href="" id="BKMK_WINUI"></a>
**To reactivate a dynamic disk by using the Windows interface**
1.  In Disk Management, right-click the disk marked **Missing** or **Offline**.

2.  Click **Reactivate Disk**. The disk should be marked **Online** after the disk is reactivated.

<a href="" id="BKMK_CMD"></a>
**To reactivate a dynamic disk by using a command line**
1.  Open a command prompt and type `diskpart`.

2.  At the **DISKPART** prompt, type `list disk`. Make note of the disk number of the missing or offline disk that you want to bring online. Missing disks are numbered M0, M1, M2, and so on, and offline disks are numbered 0, 1, 2, and so on.

3.  At the **DISKPART** prompt, type `select disk <disknumber>`.

4.  At the **DISKPART** prompt, type `online`.

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
<td><p>Sets the focus to the specified disk, where <em>disknumber</em> is the disk number.</p></td>
</tr>
<tr class="odd">
<td><p>**online**</p></td>
<td><p>Brings an offline disk or volume with focus online.</p></td>
</tr>
</tbody>
</table>

#### Additional references

-   [Command-line syntax notation](https://technet.microsoft.com/en-us/library/cc742449(v=ws.11).aspx)


