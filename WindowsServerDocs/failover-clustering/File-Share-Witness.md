---
title: File Share Witness in Windows Server 2019
ms.prod: windows-server-threshold
ms.manager: eldenc
ms.technology: failover-clustering
ms.topic: article
author: johnmarlin-msft
ms.date: 12/27/2018
description: This article describes the new File Share Witness feature in Windows Server 2019
ms.localizationpriority: medium
---

# File Share Witness

> Applies To: Windows Server 2019

File Share Witness is a witness resource in Windows Failover Clustering that was first introduced in Windows Server 2003.  This topic provides an overview for the new feature set included with Windows Server 2019.

## Overview

A File Share Witness is an SMB Share that Failover Cluster will connect to and utilize as a vote in the cluster.  The recommendations for using a File Share Witness are:

- SMB file share on a Windows Server
- Must have a minimum of 5 megabytes of free space
- The file share can be used by multiple clusters
- The Cluster Name Object (CNO) must have write permissions on the share
- For high availability, the file share can be located on a separate Failover Cluster

In Windows 2016 and below, to use a File Share Witness, the Failover Cluster nodes and the File Share Witness server needed to be domain joined and part of the same forest.  This is due to the use of Kerberos for authentication to the share.  There are some scenarios at the edge where a File Share Witness cannot be used:

- No or extremely poor Internet access because of a remote location, so cannot use a Cloud Witness
- No shared drives for a disk witness. This could be a Storage Spaces Direct hyper-converged configuration, SQL Server Always On Availability Groups (AG), Exchange Database Availability Group (DAG), etc.  All of which do not utilize shared disks
- A domain controller connection is not available as the Cluster has been dropped behind a DMZ
- A workgroup or cross-domain cluster where there is no active directory CNO object

## What's New

In Windows Server 2019, the Kerberos requirement has been removed when using PowerShell to create the witness resource type.  With **Set-ClusterQuorum**, a new switch of **-Credential** has been added so that a local non-administrative account on the server can be used.  When creating a File Share Witness through Cluster Manager, it will still use kerberos.

With this new **-Credential** switch, the edge scenarios previously can now use a File Share Witness.  Devices other than just Windows Servers can house the File Share Witness, such as:

1.	NAS appliances
2.	Non-domain joined Windows machines
3.	USB port on a router

The only requirement is that it must be able to create a local account on the device and use at least Server Message Block (SMB) 2.

## Example

At [Microsoft Ignite 2018](https://azure.microsoft.com/en-us/ignite/), [DataOn Storage](http://www.dataonstorage.com/) had a Storage Spaces Direct Cluster in their kiosk area.  This cluster was connected to a [NetGear](https://www.netgear.com) Nighthawk X4S WiFi Router using the USB port as a File Share Witness similar to this.

![NetGear witness](media\File-Share-Witness\FSW1.png)

The steps for creating a File Share Witness using a USB device on this particular router are listed below.  Please note that steps on other routers and NAS appliances will vary and should be accomplished using the vendor supplied directions.

## Steps for creating

Step 1: Log into the router with the USB device plugged in.

![NetGear Interface](media\File-Share-Witness\FSW2.png)

Step 2: From the list of options, select ReadySHARE which is where shares can be created.

![NetGear ReadySHARE](media\File-Share-Witness\FSW3.png)

Step 3: For a File Share Witness, a basic share is all that is needed.  Selecting the Edit button will pop up a dialog where the share can be created on the USB device.

![NetGear Share Interface](media\File-Share-Witness\FSW4.png)

Step 4: Once selecting the Apply button, the share is created and can be seen in the list.

![NetGear Shares](media\File-Share-Witness\FSW5.png)

Step 5: Once the share has been created, creating the File Share Witness for Cluster is done with PowerShell.

    Set-ClusterQuorum -FileShareWitness \\readyshare\Witness -Credential ($Get-Credential)

This will popup a dialog box to enter the credentials for the account to log onto the share.

These same similar steps can be done on other routers with USB capabilities, NAS devices, or other Windows devices.
