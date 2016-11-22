---
title: Open the Local Group Policy editor
description: Open the Local Group Policy editor
ms.prod: windows-server-threshold
ms.technology: manage-group-policy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1a85a590-20fb-4832-8eb1-54b10eb3b927
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Open the Local Group Policy editor

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can open the Local Group Policy editor by using the command line or by using the Microsoft Management Console (mmc).

### To open the Local Group Policy

-   at a command prompt or in Search, type **gpedit.msc**, and then click **OK** or press **ENTER**.

### To open the Local Group Policy editor as an mmc snap-in

1.  Search for mmc, and then press **ENTER**.)

2.  On the **File** menu, click **add/remove Snap-in**.

3.  In the **add or remove Snap-ins** dialog box, click **Local Group Policy editor**, and then click **add**.

4.  In the **select Group Policy Object** dialog box, click **Browse**.

5.  Click **This computer** to edit the Local Group Policy object, or click **Users** to edit Administrator, Non-Administrator, or per-user Local Group Policy objects.

6.  Click **Finish**, click **Close**, and then click **OK**. The Local Group Policy editor opens the Group Policy object (GPO) for you to edit.

> [!NOTE]
> if you want to save a Local Group Policy editor console and choose which GPO opens in it from the command line, select the **Allow focus of the Group Policy Snap-in to be changed when launching from the command line** check box in the **select Group Policy Object** dialog box.
