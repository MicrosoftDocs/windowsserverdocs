---
description: "Learn more about: Active Directory Domain Services Overview"
ms.assetid: f052dfcd-dace-4485-8d0a-cc7df5cf3751
title: Active Directory Domain Services Overview
author: iainfoulds
ms.author: daveba
manager: daveba
ms.date: 08/16/2022
ms.topic: article
---

# Active Directory Domain Services Overview

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


A directory is a hierarchical structure that stores information about objects on the network. A directory service, such as Active Directory Domain Services (AD DS), provides the methods for storing directory data and making this data available to network users and administrators. For example, AD DS stores information about user accounts, such as names, passwords, phone numbers, and so on, and enables other authorized users on the same network to access this information.

Active Directory stores information about objects on the network and makes this information easy for administrators and users to find and use. Active Directory uses a structured data store as the basis for a logical, hierarchical organization of directory information.

This data store, also known as the directory, contains information about Active Directory objects. These objects typically include shared resources such as servers, volumes, printers, and the network user and computer accounts. For more information about the Active Directory data store, see [Directory data store](/previous-versions/windows/it-pro/windows-server-2003/cc736627(v=ws.10)).

Security is integrated with Active Directory through logon authentication and access control to objects in the directory. With a single network logon, administrators can manage directory data and organization throughout their network, and authorized network users can access resources anywhere on the network. Policy-based administration eases the management of even the most complex network. For more information about Active Directory security, see [Security overview](../../plan/security-best-practices/best-practices-for-securing-active-directory.md).

Active Directory also includes:
* A set of rules, **the schema**, that defines the classes of objects and attributes contained in the directory, the constraints and limits on instances of these objects, and the format of their names. For more information about the schema, see [Schema](/previous-versions/windows/it-pro/windows-server-2003/cc756876(v=ws.10)).


* A **global catalog** that contains information about every object in the directory. This allows users and administrators to find directory information regardless of which domain in the directory actually contains the data. For more information about the global catalog, see [Global catalog](/windows/win32/ad/global-catalog).


* A **query and index mechanism**, so that objects and their properties can be published and found by network users or applications. For more information about querying the directory, see [Searching in Active Directory Domain Services](/windows/win32/ad/searching-in-active-directory-domain-services).


* A **replication service** that distributes directory data across a network. All domain controllers in a domain participate in replication and contain a complete copy of all directory information for their domain. Any change to directory data is replicated to all domain controllers in the domain. For more information about Active Directory replication, see [Active Directory Replication Concepts](../replication/Active-Directory-Replication-Concepts.md).

## Understanding Active Directory
 This section provides links to core Active Directory concepts:

* [Active Directory Structure and Storage Technologies](/previous-versions/windows/it-pro/windows-server-2003/cc759186(v=ws.10))
* [Domain Controller Roles](/previous-versions/windows/it-pro/windows-server-2003/cc786438(v=ws.10))
* [Active Directory Schema](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc771796(v=ws.10))
* [Understanding Trusts](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc771568(v=ws.10))
* [Active Directory Replication Technologies](/previous-versions/windows/it-pro/windows-server-2003/cc776877(v=ws.10))
* [Active Directory Search and Publication Technologies](/previous-versions/windows/it-pro/windows-server-2003/cc775686(v=ws.10))
* [Interoperating with DNS and Group Policy](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd197486(v=ws.10))
* [Understanding Schema](/previous-versions/windows/it-pro/windows-server-2003/cc759402(v=ws.10))

For a detailed list of Active Directory concepts, see [Understanding Active Directory](/previous-versions/windows/it-pro/windows-server-2003/cc781408(v=ws.10)).
