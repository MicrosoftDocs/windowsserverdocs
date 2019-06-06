---
title: Express updates for Windows Server 2016 re-enabled for November 2018 update
description: Provides information about Express Updates in Windows Server 2016
ms.prod: windows-server-threshold
ms.technology: server-general
ms.topic: article
author: lizap
ms.author: elizapo
ms.localizationpriority: medium
---

# Express updates for Windows Server 2016 re-enabled for November 2018 update

> By Joel Frauenheim
> 
> Applies To: Windows Server 2016

Starting with the November 13, 2018 Update Tuesday, Windows will again publish Express updates for Windows Server 2016. Express updates for Windows Server 2016 stopped in mid-2017 after a significant issue was found that kept the updates from installing correctly. While the issue was fixed in November 2017, the update team took a conservative approach to publishing the Express packages to ensure most customers would have the November 14, 2017 update ([KB 4048953](https://support.microsoft.com/help/4048953/windows-10-update-kb4048953)) installed on their server environments and not be impacted by the issue.

System administrators for WSUS and System Center Configuration Manager (SCCM) need to be aware that in November 2018 they will once again see two packages for the Windows Server 2016 update: a Full update and an Express update. System administrators who want to use Express for their server environments need to confirm that the device has taken a full update since November 14, 2017 ([KB 4048953](https://support.microsoft.com/help/4048953/windows-10-update-kb4048953)) to ensure the Express update installs correctly. Any device which has not been updated since the November 14, 2017 update ([KB 4048953](https://support.microsoft.com/help/4048953/windows-10-update-kb4048953)) will see repeated failures that consume bandwidth and CPU resources in an infinite loop if the Express update is attempted.  Remediation for that state would be for the system administrator to stop pushing the Express update and push a recent Full update to stop the failure loop.

With the November 13, 2018 Express update customers will see an immediate reduction of package size between their management system and the Windows Server 2016 end points.  