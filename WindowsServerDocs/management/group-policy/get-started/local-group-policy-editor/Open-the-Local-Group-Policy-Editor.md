---
title: Open the Local Group Policy Editor
description: "Group Policy"
ms.prod: windows-server-threshold
ms.technology: manage-group-policy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1a85a590-20fb-4832-8eb1-54b10eb3b927
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/04/2016
---


# Open the Local Group Policy Editor
You can open the Local Group Policy Editor by using the command line or by using the Microsoft Management Console (MMC).

### To open the Local Group Policy

-   At a command prompt or in Search, type **gpedit.msc**, and then click **OK** or press **ENTER**.

### To open the Local Group Policy Editor as an MMC snap-in

1.  Search for MMC, and then press **ENTER**.)

2.  On the **File** menu, click **Add/Remove Snap-in**.

3.  In the **Add or Remove Snap-ins** dialog box, click **Local Group Policy Editor**, and then click **Add**.

4.  In the **Select Group Policy Object** dialog box, click **Browse**.

5.  Click **This computer** to edit the Local Group Policy object, or click **Users** to edit Administrator, Non-Administrator, or per-user Local Group Policy objects.

6.  Click **Finish**, click **Close**, and then click **OK**. The Local Group Policy Editor opens the Group Policy object (GPO) for you to edit.

> [!NOTE]
> If you want to save a Local Group Policy Editor console and choose which GPO opens in it from the command line, select the **Allow focus of the Group Policy Snap-in to be changed when launching from the command line** check box in the **Select Group Policy Object** dialog box.


