---
title: Live Migration Overview
description: Gives overview of live migration functionality in Windows Server 2016.
ms.topic: article
ms.assetid: 5cc875ab-05c4-439e-b27d-6bfc77054660
ms.author: benarm
author: BenjaminArmstrong
ms.date: 06/27/2017
---

# Live Migration Overview

Live migration is a Hyper-V feature in Windows Server.  It allows you to transparently move running Virtual Machines from one Hyper-V host to another without perceived downtime.  The primary benefit of live migration is flexibility; running Virtual Machines are not tied to a single host machine.  This allows actions like draining a specific host of Virtual Machines before decommissioning or upgrading it.  When paired with Windows Failover Clustering, live migration allows the creation of highly available and fault tolerant systems.

## Related Technologies and Documentation

Live migration is often used in conjunction with a few related technologies like Failover Clustering and System Center Virtual Machine Manager.  If you're using Live Migration via these technologies, here are pointers to their latest documentation:
* [Failover Clustering](../../../failover-clustering/failover-clustering-overview.md) (Windows Server 2016)
* [System Center Virtual Machine Manager](/system-center/vmm/) (System Center 2016)

If you're using older versions of Windows Server, or need details on features introduced in older versions of Windows Server, here are pointers to historical documentation:
* [Live Migration](/previous-versions/windows/it-pro/microsoft-hyper-v-server-2008-R2/ee815293(v=ws.10)) (Windows Server 2008 R2)
* [Live Migration](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831435(v=ws.11)) (Windows Server 2012 R2)
* [Failover Clustering](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831579(v=ws.11)) (Windows Server 2012 R2)
* [Failover Clustering](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff182338(v=ws.10)) (Windows Server 2008 R2)
* [System Center Virtual Machine Manager](/previous-versions/system-center/system-center-2012-R2/gg610610(v=sc.12)) (System Center 2012 R2)
* [System Center Virtual Machine Manager](https://technet.microsoft.com/library/cc917964.aspx) (System Center 2008 R2)

## Live Migration in Windows Server 2016

In Windows Server 2016, there are fewer restrictions on live migration deployment.  It now works without Failover Clustering.  Other functionality remains unchanged from previous releases of Live Migration.  For more details on configuring and using live migration without Failover Clustering:
* [Set up hosts for live migration without Failover Clustering](../deploy/set-up-hosts-for-live-migration-without-failover-clustering.md)
* [Use live migration without Failover Clustering to move a virtual machine](use-live-migration-without-failover-clustering-to-move-a-virtual-machine.md)