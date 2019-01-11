---
title: Cross Domain Cluster Migration in Windows Server 2019
ms.prod: windows-server-threshold
ms.manager: eldenc
ms.technology: failover-clustering
ms.topic: article
author: johnmarlin-msft
ms.date: 01/11/2019
description: This article describes moving a Windows Server 2019 Cluster from one domain to another
ms.localizationpriority: medium
---

# Failover Cluster Domain Migration

> Applies To: Windows Server 2019

This topic provides an overview for moving Windows Server 2019 failover clusters from one domain to another.

## Overview

In previous versions of Failover Clustering, the Cluster Service did not have the capability of moving from one domain to another.  This was due to the increased dependence on Active Directory Domain Services and the virtual names created.   

## Options

In order to do such a move, there are two options.

The first option is destructive as it involves destroying the cluster and rebuilding it in the new domain.

![Destroy and Rebuild](media\Cross-Domain-Cluster-Migration\Cross-Cluster-Domain-Migration-1.gif)

The second option is less destructive but requires additional hardware as a new cluster would need to be built in the new domain.

![Build and Migrate](media\Cross-Domain-Cluster-Migration\Cross-Cluster-Domain-Migration-2.gif)

## New Feature



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
