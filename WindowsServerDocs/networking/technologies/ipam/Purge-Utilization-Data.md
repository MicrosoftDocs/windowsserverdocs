---
title: Purge Utilization Data
description: This topic is part of the IP Address Management (IPAM) Management guide in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ipam
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 45cada9e-69b9-43df-b6f5-6d3942435809
ms.author: pashort
author: shortpatti
---
# Purge Utilization Data

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn how to delete utilization data from the IPAM database.  

You must be a member of **IPAM Administrators**, the local computer **Administrators** group, or equivalent, to perform this procedure.

## To purge the IPAM database  
1. Open Server Manager, and then browse to the IPAM client interface.
2. Browse to one of the following locations: **IP Address Blocks**, **IP Address Inventory**, or **IP Address Range Groups**.  
3. Click **TASKS**, and then click **Purge Utilization Data**. The **Purge Utilization Data** dialog box opens.
4. In **Purge all utilization data on or before**, click **Select a date**.
5. Choose the date for which you want to delete all database records both on and before that date.
6. Click **OK**. IPAM deletes all the records that you have specified.
