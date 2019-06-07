---
title: Customize the Active Directory Administrative Center Navigation Pane
ms.prod: windows-server-threshold
description: "Windows Server Security"
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: c9933d16-e153-435a-b5b7-3e594db42d5c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Customize the Active Directory Administrative Center Navigation Pane

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

  You can browse through the Active Directory Administrative Center navigation pane by using the tree view, which is similar to the Active Directory Users and Computers console tree, or by using the list view.

 Whether you use the tree view or the list view, you can customize your Active Directory Administrative Center navigation pane anytime by adding various containers from the local domain or any foreign domain \(that is, a domain other than the local domain that has an established trust with the local domain\) to the navigation pane as separate nodes. Customizing the Active Directory Administrative Center navigation pane can provide quicker access to Active Directory objects. For more information, see [Manage Different Domains in Active Directory Administrative Center](manage-different-domains-in-active-directory-administrative-center.md).

 Also, to further customize the navigation pane, you can rename or remove these manually added navigation pane nodes, create duplicates of these nodes, or move them up or down in the navigation pane.

> [!NOTE]
>  You cannot customize the default local domain node.

### To customize the Active Directory Administrative Center navigation pane

1. In the Active Directory Administrative Center navigation pane, right\-click the node that you want to modify. You can modify the position or name of the node, or you can create a duplicate of it.

2. Click one of the following commands:

   -   **Rename**

   -   **Create duplicate node**

   -   **Remove**

   -   **Move up**

   -   **Move down**

   By using the list view, you can take advantage of the Most Recently Used \(MRU\) list. The MRU list automatically appears under a navigation node when you visit at least one container in this navigation node. You can also view the current MRU list by expanding the breadcrumb bar at the top of the Active Directory Administrative Center window. The MRU list always contains the last three containers that you visited in a particular navigation node. Every time that you select a particular container, this container is added to the top of the MRU list and the last container in the MRU list is removed from it.

  

