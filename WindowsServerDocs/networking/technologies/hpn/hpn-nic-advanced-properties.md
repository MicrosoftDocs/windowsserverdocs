---
title: NIC advanced properties
description: You can manage NICs and all the features via Windows PowerShell or the Network Control Panel.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 0cafb1cc-5798-42f5-89b6-3ffe7ac024ba
manager: dougkim
ms.author: lizross 
author: eross-msft
ms.date: 09/20/2018 
---


# NIC advanced properties

You can manage NICs and all the features via Windows PowerShell using the [NetAdapter](https://docs.microsoft.com/powershell/module/netadapter/?view=win10-ps&viewFallbackFrom=winserverr2-ps) cmdlet.  You can also manage NICs and all the features using Network Control Panel (ncpa.cpl). 

1. In **Windows PowerShell**, run the `Get‑NetAdapterAdvancedProperties` cmdlet against two different make/model of NICs.

   ![Get-NetAdapterAdvancedProperty m1](../../media/network-offload-and-optimization/Get-NetAdapterAdvancedProperty-m1.png)

   ![Get-NetAdapterAdvancedProperty c1](../../media/network-offload-and-optimization/Get-NetAdapterAdvancedProperty-c1.png)

   There are similarities and differences in these two NIC Advanced Properties Lists.

2. In the **Network Control Panel** (ncpa.cpl), do the following:

   a. Right-click the NIC.

   ![Network connections dialog](../../media/network-offload-and-optimization/network-connections-dialog.png)

   b. In the properties dialog, click **Configure**.

    ![C1 Properties](../../media/network-offload-and-optimization/c1-properties.png)

   c. Click the **Advanced** tab to view the advanced properties.<p>The items in this list correlates to the items in the `Get-NetAdapterAdvancedProperties` output.

   ![Chelsio Network Adapter Properties](../../media/network-offload-and-optimization/chelsio-network-adapter-properties.png)

---
