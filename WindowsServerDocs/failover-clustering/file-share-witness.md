---
title: File share witness in Windows Server 2019
ms.prod: windows-server-threshold
ms.manager: eldenc
ms.technology: failover-clustering
ms.topic: article
author: johnmarlin-msft
ms.date: 01/17/2019
description: This article describes the new file share witness feature in Windows Server 2019
ms.localizationpriority: medium
---
# File share witness

> Applies To: Windows Server 2019

A file share witness is an SMB share that Failover Cluster will connect to and utilize as a vote in the cluster. This topic provides an overview for the new feature set included with Windows Server 2019.

The recommendations for using a file share witness are:

- SMB file share on a Windows server
- Must have a minimum of 5 megabytes of free space
- The file share can be used by multiple clusters
- The Cluster Name Object (CNO) must have write permissions on the share
- For high availability, the file share can be located on a separate Failover Cluster

In Windows 2016 and below, to use a file share witness, the Failover Cluster nodes and the file share witness server needed to be domain joined and part of the same forest.  This is due to the use of Kerberos for authentication to the share.  There are some scenarios at the edge where a file share witness cannot be used:

- No or extremely poor Internet access because of a remote location, so cannot use a Cloud Witness
- No shared drives for a disk witness. This could be a Storage Spaces Direct hyper-converged configuration, SQL Server Always On Availability Groups (AG), Exchange Database Availability Group (DAG), etc.  All of which do not utilize shared disks
- A domain controller connection is not available as the cluster has been dropped behind a DMZ
- A workgroup or cross-domain cluster where there is no Active Directory CNO object

## What's new in Windows Server 2019

In Windows Server 2019, the Kerberos requirement has been removed when using PowerShell to create the witness resource type.  With **Set-ClusterQuorum**, a new switch of **-Credential** has been added so that a local non-administrative account on the server can be used.  When creating a file share witness through Cluster Manager, it will still use kerberos.

With this new **-Credential** switch, the edge scenarios previously can now use a file share witness.  Devices other than just Windows servers can house the file share witness, such as:

1.	NAS appliances
2.	Non-domain joined Windows machines
3.	USB port on a router

The only requirement is that it must be able to create a local account on the device and use at least Server Message Block (SMB) 2.

## Example

At [Microsoft Ignite 2018](https://azure.microsoft.com/en-us/ignite/), [DataOn Storage](http://www.dataonstorage.com/) had a Storage Spaces Direct Cluster in their kiosk area.  This cluster was connected to a [NetGear](https://www.netgear.com) Nighthawk X4S WiFi Router using the USB port as a file share witness similar to this.

![NetGear witness](media\File-Share-Witness\FSW1.png)

The steps for creating a file share witness using a USB device on this particular router are listed below.  Please note that steps on other routers and NAS appliances will vary and should be accomplished using the vendor supplied directions.

## Creating a file share witness on a router with a USB device

1. Log into the router with the USB device plugged in.

   ![NetGear Interface](media\File-Share-Witness\FSW2.png)

2. From the list of options, select ReadySHARE which is where shares can be created.

   ![NetGear ReadySHARE](media\File-Share-Witness\FSW3.png)

3. For a file share witness, a basic share is all that is needed.  Selecting the Edit button will pop up a dialog where the share can be created on the USB device.

   ![NetGear Share Interface](media\File-Share-Witness\FSW4.png)

4. Once selecting the Apply button, the share is created and can be seen in the list.

   ![NetGear Shares](media\File-Share-Witness\FSW5.png)

5. Once the share has been created, creating the file share witness for Cluster is done with PowerShell.

   ```PowerShell
   Set-ClusterQuorum -FileShareWitness \\readyshare\Witness -Credential ($Get-Credential)
   ```

   This displays a dialog box to enter the credentials for the account to log onto the share.

These same similar steps can be done on other routers with USB capabilities, NAS devices, or other Windows devices.
