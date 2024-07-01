---
title: Flexible Single Master Operations roles in Windows Server
description: Learn about the Flexible Single Master Operations (FSMO) roles in Active Directory Domain Services (AD DS) and how to place them effectively.
author: Orin-Thomas
ms.topic: conceptual
ms.author: orthomas
contributor: orthomas
ms.date: 07/01/2024
#customer intent: As an Active Directory Domain Services administrator, I need to understand the Flexible Single Master Operations (FSMO) roles so that I can place them effectively.
---

# Flexible Single Master Operations roles in Active Directory Domain Services

Domain controllers that hold operations master roles, also known as flexible single master operations (FSMO) roles, keep the directory functioning properly by performing a unique set of domain and forest management tasks.

## Operations master roles

Three operations master roles exist in each domain:

- PDC Emulator

- RID Master

- Infrastructure Master

Two operations master roles are present at the forest level:

- Schema Master

- Domain Naming Master

### PDC Emulator

The primary domain controller (PDC) emulator receives preferential replication of password changes that that occur through other domain controllers in the domain. The PDC emulator is the source for the latest password information whenever a sign-in attempt fails as a result of a bad password. It's a preferred point of administration for services (examples are Group Policy and Distributed File System, DFS). For this reason, of all operations master roles, the PDC emulator operations master role has the highest impact on the performance of the domain controller that hosts that role. The PDC emulator in the forest root domain is also the default Windows Time service (`W32time`) time source for the forest.

### RID Master

The relative ID (RID)  master allocates RID pools to all domain controllers to ensure that new security principals can be created with a unique identifier. Relative Identifier (RID) pool is used to assign unique Security Identifiers (SIDs) to objects within a domain. Each domain controller in an Active Directory domain is allocated a pool of RIDs from which it can draw to create unique SIDs for new security principals (such as users, groups, and computers). When a domain controller needs more SIDs, it requests a block of RIDs from the RID Master.

### Infrastructure Master

The infrastructure master manages references from objects in its domain to objects in other domains. It also updates group-to-user references when the members of groups are renamed or changed.

### Schema Master

The schema master governs all changes to the schema. The Active Directory schema defines the structure and rules for the directory's data. The schema determines what types of objects (such as users, computers, and groups) can exist in the directory, the attributes that these objects can have, and the relationships between different object types. There's only one schema master in an AD DS forest.

The schema master governs all changes to the schema. The Active Directory schema defines the structure and rules for the directory's data. The schema determines what types of objects can exist, their attributes, and the relationships between them. There is only one schema master in an AD DS forest.

### Domain Naming Master

The domain naming master adds and removes domain directory partitions and application directory partitions to and from the forest. This FSMO role is responsible for ensuring the uniqueness of domain names within a forest and for authorizing changes to forest namespace structure.

## Role placement guidelines

To perform their respective operations, the domain controllers that host operations master roles must be consistently available and they must be located in areas where network reliability is high. Careful placement of your operations masters becomes more important as you add more domains and sites to your forest.

Although you can assign the forest-level and domain-level operations master roles to any domain controller in the forest and domain, respectively, improper infrastructure master role placement can cause the infrastructure master to perform incorrectly. Other improper operations master configurations can increase administrative overhead. The following guidelines help to minimize administrative overhead and ensure the proper performance of Active Directory Domain Services (AD DS). The guidelines also simplifies the recovery process if a domain controller that is hosting an operations master role fails.

Guidelines for operations master role placement:

- Configure another domain controller as the standby operations master for the forest-level roles.

- Configure another domain controller as the standby operations master for the domain-level roles.

- Place domain-level roles on a high-performance domain controller.

- Leave forest-level roles on a domain controller in the forest root domain.

- In your forest root domain, transfer the three domain-level roles from the first domain controller that you installed in the forest root domain to another domain controller that has a high performance level.

- In all other domains, leave the domain-level roles on the first domain controller.

- Adjust the workload of the PDC emulator, if necessary.

The PDC emulator role requires a powerful and reliable domain controller to ensure that the domain controller is available and capable of handling the workload. Of all the operations master roles, the PDC emulator role creates the most overhead on the server that is hosting the role. It has the most intensive daily interaction with other systems on the network. The PDC emulator has the greatest potential to affect daily operations of the directory.

## Next steps

- [Transfer Flexible Single Master Operations (FSMO) roles](manage-fsmo-roles.md)
- [Managing RID Issuance](Managing-RID-Issuance.md)
