Applies To: Windows Server 2008 R2

The Virtual Hard Disk (VHD) format is a publicly available image format specification that specifies a virtual hard disk encapsulated in a single file, capable of hosting native file systems while supporting standard disk and file operations. They are commonly used as part of the Hyper-V feature of Windows ServerÂ 2008Â R2, for example. For more information about VHDs, see Additional references.

You can use Disk Management to create, attach, and detach virtual hard disks (VHDs).

Membership in **Backup Operators** or **Administrators**, or equivalent, is the minimum required to complete these procedures.

Viewing VHDs in Disk Management
-------------------------------

VHDs appear just like physical disks in Disk Management. When a VHD has been attached (that is, made available to the system for use), it appears blue. If the disk is detached (that is, made unavailable), its icon reverts to gray.

Creating a VHD
--------------

**To create a VHD**
1.  On the **Action** menu, select **Create VHD**.

2.  In the **Create and Attach Virtual Hard Disk** dialog box, specify the location on the physical computer where you want the VHD file to be stored and the size of the VHD.

3.  In **Virtual hard disk format**, select **Dynamically expanding** or **Fixed size**, and then click **OK**.

Attaching and detaching a VHD
-----------------------------

To make a VHD available for use (either one you have just created or another existing VHD), on the **Action** menu, select **Attach VHD**, and then specify the location of the VHD, using a fully qualified path.

To detach the VHD, which will make it unavailable, on the **Action** menu, select **Detach VHD**, or right-click the VHD in the volume list or graphical view, and then select **Detach VHD**. Detaching a VHD does not delete the VHD or any data stored in it.

Additional considerations
-------------------------

-   The path specifying the location for the VHD must be fully qualified and cannot be in the \\Windows directory.
-   The minimum size for a VHD is 3 megabytes (MB).
-   A VHD can only be a basic disk.
-   Because a VHD is initialized when it is created, creating a large fixed-size VHD might take some time.

Additional references
---------------------

-   Virtual Hard Disk Image Format Specification (<http://go.microsoft.com/fwlink/?LinkId=139201>)
-   Virtual Server 2005 Administratorâ€™s Guide Glossary (<http://go.microsoft.com/fwlink/?LinkId=143882>)


