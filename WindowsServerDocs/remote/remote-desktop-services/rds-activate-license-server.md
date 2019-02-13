---
title: Activate the Remote Desktop Services license server
description: Install and activate the RD license server
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eb24ddd2-0361-41fe-bd6b-c7c63427cb71
author: lizap
ms.author: elizapo
ms.date: 09/20/2016
manager: dongill
---
# Activate the Remote Desktop Services license server

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

The Remote Desktop Services license server issues client access licenses (CALs) to users and devices when they access the RD Session Host. You can activate the license server by using the Remote Desktop Licensing Manager. 

## Install the RD Licensing role

1. Sign into the server you want to use as the license server using an administrator account.
2. In Server Manager, click **Roles Summary**, and then click **Add Roles**.
   Click **Next** on the first page of the roles wizard.
3. Select **Remote Desktop Services**, and then click **Next**, and then **Next** on the Remote Desktop Services page.
4. Select **Remote Desktop Licensing**, and then click **Next**.
5. Configure the domain - select **Configure a discovery scope for this license server**, click **This domain**, and then click **Next**.
6. Click **Install**.

## Activate the license server

1. Open the Remote Desktop Licensing Manager: click **Start > Administrative Tools > Remote Desktop Services > Remote Desktop Licensing Manager**.
2. Right-click the license server, and then click **Activate Server**.
3. Click **Next** on the welcome page.
4. For the connection method, select **Automatic connection (recommended)**, and then click **Next**.
5. Enter your company information (your name, the company name, your geographic region), and then click **Next**.
6. Optionally enter any other company information (for example, email and company addresses), and then click **Next**. 
7. Make sure that **Start Install Licenses Wizard now** is not selected (we'll install the licenses in a later step), and then click **Next**.

Your license server is now ready to start issuing and managing licenses. 