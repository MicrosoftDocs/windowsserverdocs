---
title: What&#39;s New in DHCP
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: c6f36998-5b64-45d1-b1f0-0f0d6604dbe3
---
# What&#39;s New in DHCP
This topic describes the Dynamic Host Configuration Protocol (DHCP) functionality that is new or changed in [!INCLUDE[winthreshold_server_1](includes/winthreshold_server_1_md.md)].

DHCP is an Internet Engineering Task Force (IETF) standard that is designed to reduce the administrative burden and complexity of configuring hosts on a TCP/IP-based network, such as a private intranet. By using the DHCP Server service, the process of configuring TCP/IP on DHCP clients is automatic.

## <a name="BKMK_DHCP2012R2"></a>What’s new in DHCP
Network Access Protection (NAP) is deprecated in [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)], and in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] the DHCP Server role no longer supports NAP. For more information, see [Features Removed or Deprecated in Windows Server 2012 R2](http://technet.microsoft.com/library/dn303411.aspx).

NAP support was introduced to the DHCP Server role with [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)] and is supported in Windows client and server operating systems prior to [!INCLUDE[winthreshold_client_2](includes/winthreshold_client_2_md.md)] and [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)]. The following table summarizes support for NAP in Windows Server.

|Operating system|NAP support|
|--------------------|---------------|
|[!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)]|Supported|
|[!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)]|Supported|
|[!INCLUDE[win8_server_2](includes/win8_server_2_md.md)]|Supported|
|[!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)]|Supported|
|[!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)]|Not supported|

In a NAP deployment, a DHCP server running an operating system that supports NAP can function as a NAP enforcement point for the NAP DHCP enforcement method. For more information about DHCP in NAP, see [Checklist: Implementing a DHCP Enforcement Design](http://technet.microsoft.com/library/dd314186.aspx).

In [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], DHCP servers will not enforce NAP policies, and DHCP scopes cannot be NAP-enabled. DHCP client computers that are also NAP clients will send a statement of health (SoH) with the DHCP request. If the DHCP server is running [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], these requests will be treated as if no SoH is present and will grant a normal DHCP lease. If servers running [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] are RADIUS proxies that forward authentication requests to a Network Policy Server (NPS) that supports NAP, these NAP clients will be evaluated as non NAP-capable.

## See also

-   [Dynamic Host Configuration Protocol (DHCP) Overview](assetId:///eb9ac71c-9eb7-4d51-b98c-8d50b9ddeaec)


