---
title: Prehash and Preload Content on the Hosted Cache Server (Optional)
description: This guide provides instructions on deploying BranchCache in hosted cache mode on computers running Windows Server 2016 and Windows 10
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: article
ms.assetid: 7e79c66a-8555-4d8e-8691-d6c37377aab4
ms.author: lizross
author: eross-msft
---

# Prehash and Preload Content on the Hosted Cache Server \(Optional\)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can use the procedures in this section to prehash content on your content servers, add the content to data packages, and then preload the content on your hosted cache servers. 

These procedures are optional because you are not required to prehash and preload content on your hosted cache servers. 

If you do not preload content, data is added to the hosted cache automatically as clients download it over the WAN connection.

>[!IMPORTANT]
>Although these procedures are collectively optional, if you decide to prehash and preload content on your hosted cache servers, performing both procedures is required.

- [Create Content Server Data Packages for Web and File Content &#40;Optional&#41;](8-Bc-Data-Packages.md)
  
- [Import Data Packages on the Hosted Cache Server &#40;Optional&#41;](9-Bc-Import-Data.md)

To continue with this guide, see [Create Content Server Data Packages for Web and File Content &#40;Optional&#41;](8-Bc-Data-Packages.md).