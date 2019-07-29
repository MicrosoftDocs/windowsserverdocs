---
title: Remote laptop disconnects from wireless network
description: Troubleshooting an issue in which remote laptop disconnects from wireless network.
audience: itpro ​
ms.custom: na
ms.reviewer: rklemen
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: troubleshooting
ms.assetid: 
author: kaushika-msft
manager: 
ms.author: delhan
ms.date: 07/24/2019
ms.localizationpriority: medium
---

# Remote laptop disconnects from wireless network

This issue may occur when a Remote Desktop client connects to a laptop computer by using an 802.1x wireless network. The laptop intermittently disconnects from the wireless network and doesn't automatically reconnect.

This is a known issue that occurs when the network authentication setting for the wireless network connection is **User authentication**.

To work around this issue, set the network authentication setting to **User or computer authentication** or **Computer authentication**.

 > [!NOTE]  
> To change the network authentication settings on a single computer, you may need to use the Network and Sharing Center control panel to create a new wireless connection with the new settings.

For a full description of how to configure wireless network settings using GPOs, see [Configure Wireless Network (IEEE 802.11) Policies](../../../networking/core-network-guide/cncg/wireless/e-wireless-access-deployment.md#bkmk_policies).
