---
title: STEP 2 Configure EDGE1
description: Learn how to configure DirectAccess on the EDGE1 server.
manager: brianlic
ms.topic: article
ms.assetid: 84457351-1ca7-4e7c-8e2c-53d55b1fcdc0
ms.author: jgerend
author: JasonGerend
ms.date: 08/07/2020
---
# STEP 2 Configure EDGE1

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

The following procedure is performed on the DirectAccess server:

## To configure DirectAccess on EDGE1

1.  On the **Start** screen, type**RAMgmtUI.exe**, and then press ENTER. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.

2.  In the Remote Access Management console, in the left pane, click **Configuration**.

3.  In the middle pane of the console, in the **Step 2 Remote Access Server** area, click **Edit**.

4.  In the **Remote Access Server Setup** wizard, click **Prefix Configuration**. On the **Prefix Configuration** page, in **IPv6 prefix assigned to DirectAccess client computers**, enter **2001:db8:1:1000::/59**, and then click **Next**.

5.  Click **Finish**.

6.  In the middle pane of the console, click **Finish**.

7.  On the **Remote Access Review** dialog box, review the configuration settings, and then click **Apply**. On the **Applying Remote Access Setup Wizard Settings** dialog box, click **Close**.
