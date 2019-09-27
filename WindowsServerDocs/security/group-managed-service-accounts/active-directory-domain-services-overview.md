---
title: Active Directory Domain Services Overview
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.service: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6cfe9479-5d17-41d5-939a-891e5233fdca

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Active Directory Domain Services Overview

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016
  
A directory is a hierarchical structure that stores information about objects on the network. A directory service, such as Active Directory Domain Services (AD DS), provides the methods for storing directory data and making this data available to network users and administrators. For example, AD DS stores information about user accounts, such as names, passwords, phone numbers, and so on, and enables other authorized users on the same network to access this information.  
  
Active Directory stores information about objects on the network and makes this information easy for administrators and users to find and use. Active Directory uses a structured data store as the basis for a logical, hierarchical organization of directory information.  
  
This data store, also known as the directory, contains information about Active Directory objects. These objects typically include shared resources such as servers, volumes, printers, and the network user and computer accounts. For more information about the Active Directory data store, see [Directory data store](https://technet.microsoft.com/library/cc736627(v=ws.10).aspx).  
  
Security is integrated with Active Directory through logon authentication and access control to objects in the directory. With a single network logon, administrators can manage directory data and organization throughout their network, and authorized network users can access resources anywhere on the network. Policy-based administration eases the management of even the most complex network. For more information about Active Directory security, see Security overview.  
  
Active Directory also includes:  
* A set of rules, **the schema**, that defines the classes of objects and attributes contained in the directory, the constraints and limits on instances of these objects, and the format of their names. For more information about the schema, see Schema.  
  
  
* A **global catalog** that contains information about every object in the directory. This allows users and administrators to find directory information regardless of which domain in the directory actually contains the data. For more information about the global catalog, see The role of the global catalog.  
  
  
* A **query and index mechanism**, so that objects and their properties can be published and found by network users or applications. For more information about querying the directory, see Finding directory information.  
  
  
* A **replication service** that distributes directory data across a network. All domain controllers in a domain participate in replication and contain a complete copy of all directory information for their domain. Any change to directory data is replicated to all domain controllers in the domain. For more information about Active Directory replication, see Replication overview.  
  
## Understanding Active Directory  
 This section provides links to core Active Directory concepts:  
   
* [Active Directory Structure and Storage Technologies](https://technet.microsoft.com/library/cc759186(v=ws.10).aspx)  
* [Domains Controller Roles](https://technet.microsoft.com/library/cc786438(v=ws.10).aspx)   
* Active Directory Schema   
* [Understanding Trusts](https://technet.microsoft.com/library/cc771294(v=ws.10).aspx)   
* [Active Directory Replication Technologies](https://technet.microsoft.com/library/cc786438(v=ws.10).aspx)   
* [Active Directory Search and Publication Technologies](https://technet.microsoft.com/library/cc775686(v=ws.10).aspx)   
* Interoperating with DNS and Group Policy   
* [Understanding Schema](https://technet.microsoft.com/library/cc759402(v=ws.10).aspx)   
  
For a detailed list of Active Directory concepts, see [Understanding Active Directory](https://technet.microsoft.com/library/cc781408(v=ws.10).aspx).   

