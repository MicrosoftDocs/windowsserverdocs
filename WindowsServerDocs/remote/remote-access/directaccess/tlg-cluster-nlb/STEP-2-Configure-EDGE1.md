---
title: STEP 2 Configure EDGE1
description: This topic is part of the Test Lab Guide - Demonstrate DirectAccess in a Cluster with Windows NLB for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 84457351-1ca7-4e7c-8e2c-53d55b1fcdc0
ms.author: lizross
author: eross-msft
---
# STEP 2 Configure EDGE1

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

The following procedure is performed on the DirectAccess server:

## To configure DirectAccess on EDGE1
  
1.  On the **Start** screen, type**RAMgmtUI.exe**, and then press ENTER. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  In the Remote Access Management console, in the left pane, click **Configuration**.  
  
3.  In the middle pane of the console, in the **Step 2 Remote Access Server** area, click **Edit**.  
  
4.  In the **Remote Access Server Setup** wizard, click **Prefix Configuration**. On the **Prefix Configuration** page, in **IPv6 prefix assigned to DirectAccess client computers**, enter **2001:db8:1:1000::/59**, and then click **Next**.  
  
5.  Click **Finish**.  
  
6.  In the middle pane of the console, click **Finish**.  
  
7.  On the **Remote Access Review** dialog box, review the configuration settings, and then click **Apply**. On the **Applying Remote Access Setup Wizard Settings** dialog box, click **Close**.
