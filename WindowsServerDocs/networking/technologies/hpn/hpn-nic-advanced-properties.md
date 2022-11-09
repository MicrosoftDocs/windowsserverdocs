---
title: NIC advanced properties
description: You can manage NICs and all the features via Windows PowerShell or the Network Control Panel.
ms.topic: article
ms.assetid: 0cafb1cc-5798-42f5-89b6-3ffe7ac024ba
manager: dougkim
ms.author: jgerend
author: JasonGerend
ms.date: 10/26/2021
---

# NIC advanced properties

>Applies to: Windows Server 2022, Windows Server 2019, Azure Stack HCI, versions 21H2 and 20H2

You can manage NICs and all the features via Windows PowerShell using the [NetAdapter](/powershell/module/netadapter/) cmdlet.  You can also manage NICs and all the features using Network Control Panel (ncpa.cpl). To learn more, see [Host network requirements for Azure Stack HCI](/azure-stack/hci/concepts/host-network-requirements).

1. In **Windows PowerShell**, run the `Get‑NetAdapterAdvancedProperty` cmdlet against two different make/model of NICs.

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
