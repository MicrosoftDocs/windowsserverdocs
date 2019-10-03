---
title: Steps for migrating MultiPoint Services
description: Walks you through the steps to migrate to MultiPoint Services in Windows Server 2016
ms.custom: na
ms.date: 07/29/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3ee77efa-7cc5-4ddf-aaff-b5634a717014
author: lizap
manager: dongill
ms.author: elizapo
---
# Migrate to  MultiPoint Services in Windows Server 2016

>Applies To: Windows Server 2016

Use the following steps plus the information you gathered in the migration planning worksheet to migrate to MultiPoint Services in Windows Server 2016.

## Transfer server settings
On the destination server, open MultiPoint Manager. Click **Edit server settings**. Apply the settings according to the migration planning worksheet.

> [!NOTE]
> If you need to enable disk protection on the destination server, wait until after you configure MultiPoint Services.

## Transfer station settings
Ensure that the stations are connected to the destination server and all mapped before you apply the station settings. The stations will be automatically detected. Follow the instructions on each station screen to define the server mapping of user stations and connected USB devices. Apply your preferred station settings as outlined in the migration planning worksheet.

## Migrate the VDI template

Before you can import the VDI template from the source server, enabled virtual desktops on the destination server by using MultiPoint Manager:

1. Go to the **Virtual Desktops** tab in MultiPoint Manager.
2. Click **Enabled Virtual Desktops**. The server will install the Hyper-V role, and then restart.
3. Open MultiPoint Manager and navigate back to **Virtual Desktops**.
4. Click **Import virtual desktop template**. Follow the instructions to import the template from the source server.

> [!NOTE]
> When you import a virtual desktop template,  any customization applied to the template will be reset. 

## Next step
[Validate your new MultiPoint Services deployment.](multipoint-services-post-migration-steps.md)