---
title: File Management Tasks
description: This article describes the process of automating file management tasks 
ms.date: 7/7/2017
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---

# File Management Tasks

> Applies to: Windows Server 2019, Windows Server 2016, Windows Server (Semi-Annual Channel), Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

File management tasks automate the process of finding subsets of files on a server and applying simple commands. These tasks can be scheduled to occur periodically to reduce repetitive costs. Files that will be processed by a file management task can be defined through any of the following properties:

-   Location
-   Classification properties
-   Creation time
-   Modification time
-   Last accessed time

File management tasks can also be configured to notify file owners of any impending policy that will be applied to their files.

> [!Note]
> Individual File Management tasks are run on independent schedules.

<br />
This section includes the following topics:

-   [Create a File Expiration Task](create-file-expiration-task.md)
-   [Create a Custom File Management Task](create-custom-file-management-task.md)

> [!Note]
> To set e-mail notifications and certain reporting capabilities, you must first configure the general File Server Resource Manager options.

## See also

-   [Setting File Server Resource Manager Options](setting-file-server-resource-manager-options.md)


