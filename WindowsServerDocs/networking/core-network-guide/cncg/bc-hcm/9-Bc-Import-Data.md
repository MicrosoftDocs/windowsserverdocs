---
title: Import Data Packages on the Hosted Cache Server (Optional)
description: This guide provides instructions on deploying BranchCache in hosted cache mode on computers running Windows Server 2016 and Windows 10
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: article
ms.assetid: d6159e91-f77c-42ec-9180-14bbb230ad17
ms.author: lizross
author: eross-msft
---

# Import Data Packages on the Hosted Cache Server \(Optional\)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can use this procedure to import data packages and preload content on your hosted cache servers.

This procedure is optional because you are not required to prehash and preload content on your hosted cache servers.

If you do not pre\-load content, data is added to the hosted cache automatically as clients download it over the WAN connection.

You must be a member of the Administrators group to perform this procedure.

## To import data packages on the hosted cache server  

1. On the server computer, open Windows PowerShell with Administrator privileges.

2. Type the following command, replacing the value for the –Path parameter with the folder location where you have stored your data packages, and then press ENTER.

    ```  
    Import-BCCachePackage –Path D:\temp\PeerDistPackage.zip
    ```  

3. If you have more than one hosted cache server where you want to preload content, perform this procedure on each hosted cache server.

To continue with this guide, see [Configure Client Automatic Hosted Cache Discovery by Service Connection Point](10-Bc-Client-By-Scp.md).
