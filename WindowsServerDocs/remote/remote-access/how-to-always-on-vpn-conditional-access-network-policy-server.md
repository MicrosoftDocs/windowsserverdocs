---
title: Configure VPN conditional access on the Network Policy Server (NPS) on Windows Server
description: Learn how to configure VPN conditional access on the Network Policy Server (NPS)
ms.topic: article
ms.date: 05/04/2023
ms.author: wscontent
author: anaharris-ms

---

# Configure VPN conditional access on the Network Policy Server (NPS)

Conditional access and device compliance can require that managed devices meet standards before they can connect to the VPN. VPN conditional access allows you to restrict the VPN connections to devices whose client authentication certificate contains the Microsoft Entra Conditional Access OID of **1.3.6.1.4.1.311.87**.  VPN clients that try to connect by using a certificate other than the short-lived **1.3.6.1.4.1.311.87** cloud certificate will fail to connect.

This article shows you how to configure VPN conditional access directly on the NPS server. To learn how to restrict the VPN connections with Microsoft Entra Conditional Access, see [Conditional access for VPN connectivity using Microsoft Entra ID](how-to-aovpn-conditional-access.md).

## Restrict the VPN connections

To restrict VPN connections:

1. On the NPS server, open the **Network Policy Server** snap-in.

1. Expand **Policies** > **Network Policies**. Right-click the **Virtual Private Network (VPN) Connections** Network Policy and then select **Properties**

1. Select the **Settings** tab.

1. Select **Vendor Specific**, and then select **Add**.

1. Select the **Allowed-Certificate-OID** option, and then select **Add**.

1. Paste the Microsoft Entra Conditional Access OID of **1.3.6.1.4.1.311.87** as the attribute value, and then select **OK**.

1. Select **OK** again.

1. Select **Close**, and then select **Apply**.

VPN clients that try to connect by using certificate other than the short-lived **1.3.6.1.4.1.311.87** cloud certificate will now fail to connect.

## Related topics

- [VPN and conditional access](/windows/access-protection/vpn/vpn-conditional-access)

- [Microsoft Entra Conditional Access](/azure/active-directory/active-directory-conditional-access-azure-portal)
