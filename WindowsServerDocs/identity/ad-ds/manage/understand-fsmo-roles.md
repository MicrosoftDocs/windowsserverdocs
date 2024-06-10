---
title: Understand Flexible Single Master Operations (FSMO) roles
description: Understand FSMO roles.
author: Orin-Thomas
ms.topic: how-to
ms.author: orthomas
contributor: orthomas
ms.date: 06/95/2024
---
# Flexible Single Master Operations roles

Domain controllers that hold operations master (also known as flexible single master operations or FSMO) roles keep the directory functioning properly by performing a unique set of domain and forest management tasks.

Three operations master roles exist in each domain:
- PDC Emulator
- RID Master
- Infrastructure Master

Two operations master roles are present at the forest level:
- Schema Master
- Domain Naming Master

## PDC Emulator

The primary domain controller (PDC) emulator operations master. The PDC emulator receives preferential replication of password changes that that occur through other domain controllers in the domain. The PDC emulator is the source for the latest password information whenever a sign-in attempt fails as a result of a bad password. It is a preferred point of administration for services (examples are Group Policy and Distributed File System, DFS). For this reason, of all operations master roles, the PDC emulator operations master role has the highest impact on the performance of the domain controller that hosts that role. The PDC emulator in the forest root domain is also the default Windows Time service (W32time) time source for the forest.

## RID Master

The relative ID (RID) operations master. The RID master allocates RID pools to all domain controllers to ensure that new security principals can be created with a unique identifier. Relative Identifier (RID) pool is used to assign unique Security Identifiers (SIDs) to objects within a domain. Each domain controller in an Active Directory domain is allocated a pool of RIDs from which it can draw to create unique SIDs for new security principals (such as users, groups, and computers). When a domain controller needs a new SID, it requests a block of RIDs from the RID Master.

## Infrastructure Master

The infrastructure operations master. The infrastructure master manages references from objects in its domain to objects in other domains. It also updates group-to-user references when the members of groups are renamed or changed.

## Schema Master

The Schema Master operations master. The schema master governs all changes to the schema. The Active Directory Schema defines the structure and rules for the directory's data. The Schema determines what types of objects (such as users, computers, and groups) can exist in the directory, the attributes that these objects can have, and the relationships between different object types. There is only one Schema Master in an AD DS forest.

## Domain Naming Master

The Domain Naming Master operations master. The domain naming master adds and removes domain directory partitions and application directory partitions to and from the forest. This FSMO role is responsible for ensuring the iniqueness of domain names within a forest and for authorizing changes to forest namespace structure.

## Role placement guidelines

To perform their respective operations, the domain controllers that host operations master roles must be consistently available and they must be located in areas where network reliability is high. Careful placement of your operations masters becomes more important as you add more domains and sites as you build your forest.

Although you can assign the forest-level and domain-level operations master roles to any domain controller in the forest and domain, respectively, improper infrastructure master role placement can cause the infrastructure master to perform incorrectly. Other improper operations master configurations can increase administrative overhead. Following these guidelines will help to minimize administrative overhead and ensure the proper performance of Active Directory Domain Services (AD DS). Following these guidelines will simplify the recovery process if a domain controller that is hosting an operations master role fails.

Follow these guidelines for operations master role placement:

- Configure an additional domain controller as the standby operations master for the forest-level roles. Configure an additional domain controller as the standby operations master for the domain-level roles.
- Place the domain-level roles on a high-performance domain controller.
- Leave the two forest-level roles on a domain controller in the forest root domain.
- In the forest root domain, transfer the three domain-level roles from the first domain controller that you installed in the forest root domain to an additional domain controller that has a high performance level.
- In all other domains, leave the domain-level roles on the first domain controller.
- Adjust the workload of the PDC emulator, if necessary.

The PDC emulator role requires a powerful and reliable domain controller to ensure that the domain controller is available and capable of handling the workload. Of all the operations master roles, the PDC emulator role creates the most overhead on the server that is hosting the role. It has the most intensive daily interaction with other systems on the network. The PDC emulator has the greatest potential to affect daily operations of the directory.
