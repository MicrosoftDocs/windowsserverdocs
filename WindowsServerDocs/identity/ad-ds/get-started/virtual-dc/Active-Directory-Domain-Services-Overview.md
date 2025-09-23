---
description: Find out about Active Directory Domain Services, a directory service that makes network resource data available to authorized network users and administrators.
title: Active Directory Domain Services overview
author: dknappettmsft
ms.author: daknappe
ms.date: 03/10/2025
ms.topic: overview

# customer intent: As an administrator, I want to become familiar with Active Directory Domain Services so that I can store data on network resources and make this data available to authorized network users and administrators.
---

# Active Directory Domain Services overview

A directory is a hierarchical structure that stores information about objects on a network. A directory service, such as Active Directory Domain Services (AD DS), provides the methods for storing directory data and making this data available to network users and administrators. For example, AD DS stores information about user accounts, such as names, passwords, phone numbers, and so on. AD DS also provides a way for authorized users on the same network to access this information.

AD DS stores information about objects on the network and makes this information easy for administrators and users to find and use. AD DS uses a structured data store as the basis for a logical, hierarchical organization of directory information.

This data store, also known as the directory, contains information about AD DS objects. These objects typically include shared resources such as servers, volumes, printers, and the network user and computer accounts. For more information about the AD DS data store, see [Directory data store](/previous-versions/windows/it-pro/windows-server-2003/cc736627(v=ws.10)).

Security is integrated with AD DS through sign-in authentication and access control to objects in the directory. With a single network username and password, administrators can manage directory data and organization throughout their network, and authorized network users can access resources anywhere on the network. Policy-based administration eases the management of even the most complex network. For more information about AD DS security, see [Best practices for securing Active Directory](../../plan/security-best-practices/best-practices-for-securing-active-directory.md).

AD DS also includes:

* A set of rules, the **schema**, that defines the classes of objects and attributes contained in the directory, the constraints and limits on instances of these objects, and the format of their names. For more information about the schema, see [Schema](/previous-versions/windows/it-pro/windows-server-2003/cc756876(v=ws.10)).

* A **global catalog** that contains information about every object in the directory. Users and administrators can use the catalog to find directory information regardless of the directory domain that actually contains the data. For more information about the global catalog, see [Global catalog](/windows/win32/ad/global-catalog).

* A **query and index mechanism**, so that objects and their properties can be published and found by network users or applications. For more information about querying the directory, see [Searching in Active Directory Domain Services](/windows/win32/ad/searching-in-active-directory-domain-services).

* A **replication service** that distributes directory data across a network. All domain controllers in a domain participate in replication and contain a complete copy of all directory information for their domain. Any change to directory data is replicated to all domain controllers in the domain. For more information about AD DS replication, see [Active Directory Replication Concepts](../replication/Active-Directory-Replication-Concepts.md).

## Understand AD DS

 This section provides links to core AD DS concepts:

* [Active Directory Structure and Storage Technologies](/previous-versions/windows/it-pro/windows-server-2003/cc759186(v=ws.10))
* [Domain Controller Roles](/previous-versions/windows/it-pro/windows-server-2003/cc786438(v=ws.10))
* [Active Directory Schema](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc771796(v=ws.10))
* [Managing Trusts](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc771568(v=ws.10))
* [Active Directory Replication Technologies](/previous-versions/windows/it-pro/windows-server-2003/cc776877(v=ws.10))
* [Active Directory Search and Publication Technologies](/previous-versions/windows/it-pro/windows-server-2003/cc775686(v=ws.10))
* [DNS Group Policy Settings](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd197486(v=ws.10))
* [Active Directory Schema Technical Reference](/previous-versions/windows/it-pro/windows-server-2003/cc759402(v=ws.10))

For a detailed list of AD DS concepts, see [Understanding Active Directory](/previous-versions/windows/it-pro/windows-server-2003/cc781408(v=ws.10)).


