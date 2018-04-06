---
title: Manage Hyper-Converged Clusters with Hyper-Converged Cluster Manager
description: Manage Hyper-Converged Clusters with Hyper-Converged Cluster Manager Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 04/05/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Manage Hyper-Converged Clusters with Hyper-Converged Cluster Manager

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

[Content goes here]

[TODO:legacy-content-begin]

## What is Hyper-Converged Infrastructure?

Hyper-Converged Infrastructure (HCI) consolidates compute, storage and networking into a single set of servers with a Software-Defined Datacenter solution that virtualizes these components. 

Microsoft provides a complete software-defined
compute and storage solution with Hyper-V and Storage Spaces Direct in Windows Server and Windows Server 2016, and you can now manage your Windows Server hyper-converged infrastructure using Project Honolulu. [Learn more about Windows Server 2016 Software-Defined Datacenter solutions](../../../sddc.md).

Honolulu will support managing hyper-converged infrastructure running future Windows Server releases after RS3. For now, you can use Honolulu to manage HCI running recent releases of [Windows Server Insider Preview](https://www.microsoft.com/en-us/software-download/windowsinsiderpreviewserver). Project Honolulu does not currently support HCI running Windows Server RS1.

## How to deploy and configure a hyper-converged cluster

For production environments, we recommend acquiring a [Windows Server Software-Defined hardware/software offering](https://www.microsoft.com/en-us/cloud-platform/software-defined-datacenter) (WSSD), which includes production deployment tools and procedures. To evaluate the Windows Server 2016 hyper-converged solution, you can also use Hyper-V virtual machines. [Learn more about deploying and configuring hyper-converged infrastructure with Windows Server 2016](https://docs.microsoft.com/en-us/windows-server/storage/storage-spaces/hyper-converged-solution-using-storage-spaces-direct).

## How to manage a hyper-converged cluster with Honolulu

Once you have deployed and configured your hyper-converged cluster, you can manage it using Honolulu.

**Connect to a hyper-converged cluster**

1.  Click **+ Add** under **All Connections**. 
2.  Choose to add a Hyper-Converged Cluster Connection.
3.  Type the name of the hyper-converged cluster to manage and  then click **Submit**. 

The cluster will be added to your connection list on the overview page.

[TODO:legacy-content-end]

## Tools

Hyper-Converged Cluster Manager comes installed with the following tools by default:

| Tool | Description |
| ---- | ----------- |
| [Overview](#Overview) | View hyper-converged cluster details | 
| [Drives](#Drives) | View and modify drives | 
| [Servers](#Servers) | View and modify servers | 
| [Virtual Machines](#VirtualMachines) | View and control virtual machines | 
| [Virtual Switches](#VirtualSwitches) | View and control virtual switches | 
| [Volumes](#Volumes) | View and modify volumes | 

# <a id="Overview"></a>Overview

## Description

[Tool description]

## Features

The following features are supported in Hyper-Converged Cluster Manager Overview:

Cluster dashboard visualizing health alerts, storage performance metrics, compute/storage resource consumption and inventory of servers, virtual machines, drives and volumes

Historical performance charts supporting up to a year of data.

## Proposed Features

The following features are either in progress or have been proposed for Hyper-Converged Cluster Manager Overview:

|Feature|Status|Vote on User Voice|
|-------|------|------------------|
|Feature 1|In Progress||
|Feature 2|Investigating|[Vote](todo:url)|
|Feature 3|Proposed|[Vote](todo:url)|

# <a id="Drives"></a>Drives

## Description

[Tool description]

## Features

The following features are supported in Drives:

Drives summary and inventory view and a single drive view with drive properties and commands for blinking the drive indicator light and retiring disk.


## Proposed Features

The following features are either in progress or have been proposed for Drives:

|Feature|Status|Vote on User Voice|
|-------|------|------------------|
|Feature 1|In Progress||
|Feature 2|Investigating|[Vote](todo:url)|
|Feature 3|Proposed|[Vote](todo:url)|

# <a id="Servers"></a>Servers

## Description

[Tool description]

## Features

The following features are supported in Servers:

Servers summary and inventory view and a single server view with server properties and commands for pausing a server for maintenance. There is also a command to launch the Project Honolulu standalone server experience to further manage your server.

## Proposed Features

The following features are either in progress or have been proposed for Servers:

|Feature|Status|Vote on User Voice|
|-------|------|------------------|
|Feature 1|In Progress||
|Feature 2|Investigating|[Vote](todo:url)|
|Feature 3|Proposed|[Vote](todo:url)|

# <a id="VirtualMachines"></a>Virtual Machines

## Description

[Tool description]

## Features

The following features are supported in Virtual Machines:

Virtual machines summary and inventory view and a single virtual machine view with commands for creating a VM, starting/stopping/resetting/pausing/saving/deleting a VM, move (live migration), changing VM settings, creating and managing checkpoints, connecting to a VM with remote desktop connection, and protecting a VM with Azure Site Recovery.

## Proposed Features

The following features are either in progress or have been proposed for Virtual Machines:

|Feature|Status|Vote on User Voice|
|-------|------|------------------|
|Feature 1|In Progress||
|Feature 2|Investigating|[Vote](todo:url)|
|Feature 3|Proposed|[Vote](todo:url)|

# <a id="Virtual Switches"></a>Virtual Switches

## Description

[Tool description]

## Features

The following features are supported in Virtual Switches:

Virtual switches list view and commands to create a new virtual switch and change settings for existing switches.

## Proposed Features

The following features are either in progress or have been proposed for Virtual Switches:

|Feature|Status|Vote on User Voice|
|-------|------|------------------|
|Feature 1|In Progress||
|Feature 2|Investigating|[Vote](todo:url)|
|Feature 3|Proposed|[Vote](todo:url)|

# <a id="Volumes"></a>Volumes

## Description

[Tool description]

## Features

The following features are supported in Volumes:

Volumes summary and inventory view and a single volume view with commands for creating a new volume, resizing/deleting an existing volume and switching a volume to offline.

## Proposed Features

The following features are either in progress or have been proposed for Volumes:

|Feature|Status|Vote on User Voice|
|-------|------|------------------|
|Feature 1|In Progress||
|Feature 2|Investigating|[Vote](todo:url)|
|Feature 3|Proposed|[Vote](todo:url)|

