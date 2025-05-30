---
title: Purge Utilization Data
description: Learn how to delete utilization data from the IPAM database.
ms.topic: how-to
ms.author: alalve
author: xelu86
ms.date: 08/07/2020
---
# Purge Utilization Data

You can use this topic to learn how to delete utilization data from the IPAM database.

You must be a member of **IPAM Administrators**, the local computer **Administrators** group, or equivalent, to perform this procedure.

## To purge the IPAM database
1. Open Server Manager, and then browse to the IPAM client interface.
2. Browse to one of the following locations: **IP Address Blocks**, **IP Address Inventory**, or **IP Address Range Groups**.
3. Click **TASKS**, and then click **Purge Utilization Data**. The **Purge Utilization Data** dialog box opens.
4. In **Purge all utilization data on or before**, click **Select a date**.
5. Choose the date for which you want to delete all database records both on and before that date.
6. Click **OK**. IPAM deletes all the records that you have specified.
