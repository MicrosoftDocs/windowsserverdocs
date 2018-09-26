---
title: Release Notes - Important issues in Windows Server 2019
description: "Summarizes critical issues requiring workarounds to avoid crashes, hanging, installation failure and data loss"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 134aab85-664f-4d55-87ef-9e5fd098371f
author: dawnwood
ms.author: dawnwood
manager: jasgroce
ms.localizationpriority: medium
---
# Release Notes - Important issues in Windows Server 2019

>Applies To: Windows Server 2019

These release notes summarize the most critical issues in the Windows Server&reg; 2019 operating system, including ways to avoid or work around the issues, if known. For information about by-design changes, new features, and fixes in this release, see [What's New in Windows Server 2019](whats-new-19.md) and announcements from the specific feature teams. Unless otherwise specified, each reported issue applies to all editions and installation options of Windows Server 2019.  

This document is continuously updated. As critical issues requiring a workaround are discovered, they are added, as are new workarounds and fixes as they become available.  
  
## Release Notes

**Installation option menu during server setup has truncated German text**
When running setup from German server media, on the operating system selection window titled, “Select the operating system you want to install”, the description for Desktop Experience installation options will have missing and incorrect characters at the very end of the sentence. Here is the full German text with a line through the missing characters in the product.  This only impacts the German media released at Public Availability of Windows Server 2019, Windows Server, version 1809, Windows Server Essentials 2019, and Microsoft Hyper-V Server 2019.

*Durch diese Option wird die vollständige grafische Umgebung von Windows installiert, wodurch zusätzlicher Speicherplatz verbraucht wird. Sie kann hilfreich sein, wenn Sie den Windows-Desktop verwenden möchten oder über eine App verfügen, die die grafische Um~~gebung benötigt~~.*

**Missing Windows display language for Windows Server 2019 Desktop Experience**
Customers using the Desktop Experience on Windows Server 2019 are currently unable to install language packs using the Settings app’s Language page without first adding a new Windows display language. In order to add a new Windows display language, follow the procedure in [this]() KB article.

### Copyright  
This document is provided "as-is". Information and views expressed in this document, including URL and other Internet Web site references, may change without notice.  

This document does not provide you with any legal rights to any intellectual property in any Microsoft product. You may copy and use this document for your internal, reference purposes.  

&copy; 2019 Microsoft Corporation. All rights reserved.  

Microsoft, Active Directory, Hyper-V, Windows, and Windows Server are either registered trademarks or trademarks of Microsoft Corporation in the United States and/or other countries.  

This product contains graphics filter software; this software is based in part on the work of the Independent JPEG Group.  


1.0  
