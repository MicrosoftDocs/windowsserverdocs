---
title: Release Notes - Important issues in Windows Server 2019
description: "Summarizes critical issues requiring workarounds to avoid crashes, hanging, installation failure and data loss"
ms.prod: windows-server-threshold
ms.technology: server-general
ms.topic: article
ms.assetid: 134aab85-664f-4d55-87ef-9e5fd098371f
author: jasongerend
ms.author: jgerend
manager: jasgroce
ms.localizationpriority: medium
ms.date: 06/07/2019
---
# Release Notes - Important issues in Windows Server 2019

>Applies To: Windows Server 2019

These release notes summarize the most critical issues in the Windows Server 2019 operating system, including ways to avoid or work around the issues, if known. For information about by-design changes, new features, and fixes in this release, see [What's New in Windows Server 2019](whats-new-19.md) and announcements from the specific feature teams. Unless otherwise specified, each reported issue applies to all editions and installation options of Windows Server 2019.  

This document is continuously updated. As critical issues requiring a workaround are discovered, they are added, as are new workarounds and fixes as they become available.  

## Release Notes

The following known issues are present in Windows Server 2019.

| Title         | Description                            |
| -----         | -----------                            |
| Installation option menu during server setup has truncated German text | When running setup from German server media, on the operating system selection window titled, “Select the operating system you want to install,” the description for Desktop Experience installation options will have missing and incorrect characters at the very end of the sentence. Here is the full German text as it should appear.<br/>      <br/>`Durch diese Option wird die vollständige grafische Umgebung von Windows installiert, wodurch zusätzlicher Speicherplatz verbraucht wird. Sie kann hilfreich sein, wenn Sie den Windows-Desktop verwenden möchten oder über eine App verfügen, die die grafische Umgebung benötigt.` <br><br>This only impacts the German media released at Public Availability of Windows Server 2019, Windows Server, version 1809, and Microsoft Hyper-V Server 2019.|
| Windows Server branding image incorrect during setup of Windows Server, version 1809 | During the setup experience for Windows Server, version 1809, the background image on some initial screens shows &quot;Windows Server 2019&quot;.  As with Windows Server, versions 1709 and 1803, this should simply say &quot;Windows Server&quot;.  There are no other impacts anywhere else in the product, and there is no impact to the Windows Server 2019 product.  The issue is limited to this one image during setup of Windows Server, version 1809, available only to volume license customers accessing the Volume License Service Center.<br/> |

### Copyright

This document is provided "as-is". Information and views expressed in this document, including URL and other Internet Web site references, may change without notice.  

This document does not provide you with any legal rights to any intellectual property in any Microsoft product. You may copy and use this document for your internal, reference purposes.

&copy; 2019 Microsoft Corporation. All rights reserved.  

Microsoft, Active Directory, Hyper-V, Windows, and Windows Server are either registered trademarks or trademarks of Microsoft Corporation in the United States and/or other countries.  

This product contains graphics filter software; this software is based in part on the work of the Independent JPEG Group.  


1.0  
