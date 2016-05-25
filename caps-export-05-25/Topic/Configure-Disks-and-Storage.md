---
title: Configure Disks and Storage
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2aab516b-c1fc-4cbd-882a-162627b7ef4b
author: cwatsonmsft
---
# Configure Disks and Storage
You can use virtual hard disks as a storage option on the management operating system, and then make the storage available to virtual machines.  
  
You can create and manage virtual hard disks using the Hyper\-V Manager tool. To create a new virtual hard disk, you would use either the New Virtual Hard Disk Wizard or the New Virtual Machine Wizard. If you are creating dynamically expanding disks, the New Virtual Machine Wizard provides a way to create storage for the new virtual machine without running the New Virtual Hard Disk Wizard. This can be useful if you want to install a guest operating system in a virtual machine soon after you create it.  
  
When creating a new virtual hard disk, a name and storage location is required. The disks are stored as .vhd files, which makes them portable but also poses a potential security risk. You should mitigate this risk by taking precautions such as storing the .vhd files in a secure location. Do not create the virtual hard disk in a folder that is marked for encryption. Hyper\-V does not support the use of storage media if Encrypting File System has been used to encrypt the .vhd file. However, you can use files stored on a volume that uses Windows Bitlocker Drive Encryption.  
  
### To create a virtual hard disk  
  
1.  Open Hyper\-V Manager. Click **Start**, point to **Administrative Tools**, and then click **Hyper\-V Manager**.  
  
2.  In the Action pane, click **New**, and then click **Hard Disk**.  
  
3.  Proceed through the pages of the wizard to customize the virtual hard disk. You can click **Next** to move through each page of the wizard, or you can click the name of a page in the left pane to move directly to that page.  
  
4.  After you have finished configuring the virtual hard disk, click **Finish**.  
  
## <a name="BKMK_configpassthrough"></a>How to configure physical disks that are directly attached to a virtual machine  
You can use physical disks that are directly attached to a virtual machine as a storage option on the management operating system. This allows virtual machines to access storage that is mapped directly to the server running Hyper\-V without first configuring the volume. The storage can be either a physical disk which is internal to the server, or a SAN logical unit number \(LUN\) that is mapped to the server \(a LUN is a logical reference to a portion of a storage subsystem\). The virtual machine must have exclusive access to the storage, so the storage must be set in an Offline state in Disk Management. The storage is not limited in size, so it can be a multiterabyte LUN.  
  
When using physical disks that are directly attached to a virtual machine, you should be aware of the following:  
  
-   This type of disk cannot be dynamically expanded.  
  
-   You cannot use differencing disks with them.  
  
-   You cannot take virtual hard disk snapshots.  
  
#### To configure physical disks that are directly attached to a virtual machine  
  
1.  Map the storage device you plan to use to the server running Hyper\-V. In Disk Management, the storage appears as a raw volume and is in an Offline state.  
  
2.  To initialize the raw volume, in Disk Management, right\-click the disk you want to initialize, and then click **Initialize Disk**. Note that before you can initialize the disk, it must be in an Online state.  
  
3.  In the **Initialize Disk** dialog box, select the disk to initialize. You can select whether to use the master boot record \(MBR\) or GUID partition table \(GPT\) partition style.  
  
4.  After a disk is initialized, return it to an Offline state. If the disk is not in an Offline state, it will not be available when configuring storage for a virtual machine.  
  
5.  Open Hyper\-V Manager. Click **Start**, point to **Administrative Tools**, and then click **Hyper\-V Manager**.  
  
6.  If you have not yet created the virtual machine where you want to attach the physical hard disk, create it by using the **New Virtual Machine Wizard** in Hyper\-V Manager, and on the **Connect Virtual Hard Disk** page, select **Attach a virtual hard disk later**.  
  
7.  On Hyper\-V Manager, under **Virtual Machines**, select the virtual machine where you want to attach the physical hard disk.  
  
8.  In the **Action** pane, under the virtual machine name, click **Settings**.  
  
9. In the navigation pane \(left pane\), click the controller that you want to attach the disk to. If you plan to use the disk as a startup disk, make sure you attach it to an IDE controller. Click **Add**.  
  
10. On the **Hard Drive** page, select the location on the controller to attach the disk.  
  
11. Under **Media**, specify the physical hard disk. If the disk does not appear in the drop\-down list under **Physical hard disks**, make sure the disk is in an Offline state in Disk Management.  
  
12. Once the physical disk is configured, you can start the virtual machine and store data on the disk. If installing an operating system, the installation process automatically prepares the disk for use. If you are using the physical disk to store data, it must first be prepared by the virtual machine.  
  
    If you are installing an operating system on the physical disk and it is in an Online state before the virtual machine is started, the virtual machine will fail to start. You must store the virtual machine configuration file in an alternate location because the physical disk is used by the operating system installation. For example, locate the configuration file on another internal drive on the server running Hyper\-V.  
  
## How to configure iSCSI\-based storage  
From the guest operating system, you can connect directly to iSCSI LUNs on a storage array. Direct connectivity using iSCSI offers the following advantages over other iSCSI LUN options:  
  
-   You can transparently operate SAN management applications.  
  
-   Supports guest clustering.  
  
-   You can connect to iSCSI LUNs without shutting down and restarting the guest operating system.  
  
-   You can manage LUNs in the guest operating system in the same way that LUNs are managed in the physical environment.  
  
-   Support for VSS hardware snapshots in the guest operating system.  
  
#### To configure iSCSI direct connections on a guest operating system running Windows Server 2008 or Windows Vista  
  
1.  From Control Panel, double\-click **iSCSI Initiator**.  
  
2.  Click the **Discovery** tab, and then click **Add** to enter the IP address or DNS name of the iSCSI target device.  
  
3.  Click the **Targets** tab, and then select the target device that you want to connect to.  
  
4.  Click **Log On**, and then, in the **Log On to Target** dialog box, configure the log on parameters. Click **OK** when finished.  
  
5.  Open Computer Management, and then bring the iSCSI disk online and create partitions on the new iSCSI LUN.  
  
> [!NOTE]  
> For guest operating systems running Windows Server 2003 or Windows XP, you will need to download the Microsoft iSCSI Initiator from the [Microsoft Download Center](http://go.microsoft.com/fwlink/?LinkId=160332) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=160332\).  
  
