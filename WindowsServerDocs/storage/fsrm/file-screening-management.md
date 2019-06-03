---
title: File Screening Management
description: This article describes how to create file screens, generate notifications, define file screening templates, and create file screening exceptions
ms.date: 7/7/2017
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---

# File Screening Management

> Applies to: Windows Server 2019, Windows Server 2016, Windows Server (Semi-Annual Channel), Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

On the **File Screening Management** node of the File Server Resource Manager MMC snap-in, you can perform the following tasks:

-   Create file screens to control the types of files that users can save, and generate notifications when users attempt to save unauthorized files.
-   Define file screening templates that can be applied to new volumes or folders and that can be used across an organization.
-   Create file screening exceptions that extend the flexibility of the file screening rules.

For example, you can:

-   Ensure that no music files are stored on personal folders on a server, yet you could allow storage of specific types of media files that support legal rights management or comply with company policies. In the same scenario, you might want to give a vice president in the company special privileges to store any type of files in his personal folder.
-   Implement a screening process to notify you by e-mail when an executable file is stored on a shared folder, including information about the user who stored the file and the file's exact location, so that you can take the appropriate precautionary steps.

This section includes the following topics:

-   [Define File Groups for Screening](define-file-groups-for-screening.md)
-   [Create a File Screen](create-file-screen.md)
-   [Create a File Screen Exception](create-file-screen-exception.md)
-   [Create a File Screen Template](create-file-screen-template.md)
-   [Edit File Screen Template Properties](edit-file-screen-template-properties.md)

> [!Note]
> To set e-mail notifications and certain reporting capabilities, you must first configure the general File Server Resource Manager options.

## See also

-   [Setting File Server Resource Manager Options](setting-file-server-resource-manager-options.md)


