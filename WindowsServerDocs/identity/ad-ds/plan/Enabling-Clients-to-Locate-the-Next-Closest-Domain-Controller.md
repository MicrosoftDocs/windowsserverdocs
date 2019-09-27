---
ms.assetid: 7dd905ea-4235-4519-8400-31b4fa0ed1bf
title: Enabling Clients to Locate the Next Closest Domain Controller
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/08/2018
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---
# Enabling Clients to Locate the Next Closest Domain Controller

>Applies To: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

If you have a domain controller that runs Windows Server 2008 or newer, you can make it possible for client computers that run Windows Vista or newer or Windows Server 2008 or newer to locate domain controllers more efficiently by enabling the **Try Next Closest Site** Group Policy setting. This setting improves the Domain Controller Locator (DC Locator) by helping to streamline network traffic, especially in large enterprises that have many branch offices and sites.

This new setting can affect how you configure site link costs because it affects the order in which domain controllers are located. For enterprises that have many hub sites and branch offices, you can significantly reduce Active Directory traffic on the network by ensuring that clients fail over to the next closest hub site when they cannot find a domain controller in the closest hub site.

As a general best practice, you should simplify your site topology and site link costs as much as possible if you enable the **Try Next Closest Site** setting. In enterprises with many hub sites, this can simplify any plans that you make for handling situations in which clients in one site need to fail over to a domain controller in another site.

By default, the **Try Next Closest Site** setting is not enabled. When the setting is not enabled, DC Locator uses the following algorithm to locate a domain controller:

- Try to find a domain controller in the same site.
- If no domain controller is available in the same site, try to find any domain controller in the domain.

> [!NOTE]
> This is the same algorithm that DC Locator used in previous versions of Active Directory. For more information, see the article [How DNS Support for Active Directory Works](https://go.microsoft.com/fwlink/?LinkId=108587).

If you enable the **Try Next Closest Site** setting, DC Locator uses the following algorithm to locate a domain controller:

- Try to find a domain controller in the same site.
- If no domain controller is available in the same site, try to find a domain controller in the next closest site. A site is closer if it has a lower site-link cost than another site with a higher site-link cost.
- If no domain controller is available in the next closest site, try to find any domain controller in the domain.

The **Try Next Closest Site** setting works in coordination with automatic site coverage. For example, if the next closest site has no domain controller, DC Locator tries to find the domain controller that performs automatic site coverage for that site.

By default, DC Locator does not consider any site that contains a read-only domain controller (RODC) when it determines the next closest site. In addition, when the client gets a response from a domain controller that runs a version earlier than Windows Server 2008, the DC Locator behavior is the same as when then setting is not enabled.

For example, assume that a site topology has four sites with the site link values in the following illustration. In this example, all the domain controllers are writable domain controllers that run Windows Server 2008 or newer.

![enabling clients to locate dc](media/Enabling-Clients-to-Locate-the-Next-Closest-Domain-Controller/beff4087-fb2a-463b-96ac-d440a9e29b75.gif)

When the **Try Next Closest Site** Group Policy setting is enabled in this example, if a client computer in Site_B tries to locate a domain controller, it first tries to find a domain controller in its own Site_B. If none is available in Site_B, it tries to find a domain controller in Site_A.

If the setting is not enabled, the client tries to find a domain controller in Site_A, Site_C, or Site_D if no domain controller is available in Site_B.

> [!NOTE]
> The **Try Next Closest Site** setting works in coordination with automatic site coverage. For example, if the next closest site has no domain controller, DC Locator tries to find the domain controller that performs automatic site coverage for that site.

To apply the **Try Next Closest Site** setting, you can create a Group Policy object (GPO) and link it to the appropriate object for your organization, or you can modify the Default Domain Policy to have it affect all clients that run Windows Vista or newer and Windows Server 2008 or newer in the domain. For more information about how to set the **Try Next Closest Site** setting, see [Enable Clients to Locate a Domain Controller in the Next Closest Site](https://technet.microsoft.com/library/cc772592.aspx).
