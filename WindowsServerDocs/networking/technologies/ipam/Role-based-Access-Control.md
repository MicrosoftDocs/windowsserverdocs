---
title: Role-based Access Control
description: Learn how to use role-based access control in IPAM.
manager: brianlic
ms.topic: article
ms.assetid: ecdfc589-fa14-4bb3-ab7e-456ebc719385
ms.author: jgerend
author: JasonGerend
ms.date: 08/07/2020
---
# Role-based Access Control

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic provides information about using role-based access control in IPAM.

> [!NOTE]
> In addition to this topic, the following IPAM access control  documentation is available in this section.
>
> -   [Manage Role Based Access Control with Server Manager](../../technologies/ipam/Manage-Role-Based-Access-Control-with-Server-Manager.md)
> -   [Manage Role Based Access Control with Windows PowerShell](../../technologies/ipam/Manage-Role-Based-Access-Control-with-Windows-PowerShell.md)

Role-based access control allows you to specify access privileges at various levels, including the DNS server, DNS zone, and DNS resource record levels.
By using role based access control, you can specify who has granular control over operations to create, edit, and delete different types of DNS resource records.

You can configure access control so that users are restricted to the following permissions.

-   Users can edit only specific DNS resource records

-   Users can edit DNS resource records of a specific type, such as PTR or MX

-   Users can edit DNS resource records for specific zones

## See Also
[Manage Role Based Access Control with Server Manager](../../technologies/ipam/Manage-Role-Based-Access-Control-with-Server-Manager.md)
[Manage Role Based Access Control with Windows PowerShell](../../technologies/ipam/Manage-Role-Based-Access-Control-with-Windows-PowerShell.md)
[Manage IPAM](Manage-IPAM.md)



