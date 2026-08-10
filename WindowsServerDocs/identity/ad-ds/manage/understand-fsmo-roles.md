---
title: Flexible Single Master Operations roles in Windows Server
description: Learn about the Flexible Single Master Operations (FSMO) roles in Active Directory Domain Services (AD DS) and how to place them effectively.
author: Orin-Thomas
ms.topic: concept-article
ms.author: orthomas
contributor: orthomas
ms.date: 07/01/2024
#customer intent: As an Active Directory Domain Services administrator, I need to understand the Flexible Single Master Operations (FSMO) roles so that I can place them effectively.
---

# Flexible Single Master Operations roles in Active Directory Domain Services

Domain controllers that hold operations master roles, also known as flexible single master operations (FSMO) roles, to keep the directory functioning properly by performing a unique set of domain and forest management tasks. FSMO roles prevent conflicts in the directory by ensuring that certain updates are processed by only one domain controller at a time. This article explains the five FSMO roles and provides guidelines for placing them effectively.

## Operations master roles

Three operations master roles exist in each domain:

- PDC Emulator

- RID Master

- Infrastructure Master

Two operations master roles are present at the forest level:

- Schema Master

- Domain Naming Master

### PDC Emulator

The primary domain controller (PDC) emulator receives preferential replication of password changes that that occur through other domain controllers in the domain. The PDC emulator is the source for the latest password information whenever a sign-in attempt fails as a result of a bad password. It also processes account lockouts. It's a preferred point of administration for services (examples are Group Policy and Distributed File System, DFS). For this reason, of all operations master roles, the PDC emulator operations master role has the highest impact on the performance of the domain controller that hosts that role. The PDC emulator in the forest root domain is the authoritative Windows Time service (`W32time`) time source for the forest.

### RID Master

The relative ID (RID)  master allocates RID pools to all domain controllers to ensure that new security principals can be created with a unique identifier. Relative Identifier (RID) pool is used to assign unique Security Identifiers (SIDs) to objects within a domain. Each domain controller in an Active Directory domain is allocated a pool of RIDs from which it can draw to create unique SIDs for new security principals (such as users, groups, and computers). When a domain controller needs more SIDs, it requests a block of RIDs from the RID Master.

### Infrastructure Master

The infrastructure master manages references from objects in its domain to objects in other domains. It also updates group-to-user references when the members of groups are renamed or changed. The infrastructure master represents references by  GUID, SID, or DN of the object being referenced.

### Schema Master

The schema master governs all changes to the schema naming context or `LDAP://cn=schema,cn=configuration,dc=<domain>`. The Active Directory schema defines the structure and rules for the directory's data. The schema determines what types of objects can exist in the directory, the attributes that these objects can have, and the relationships between different object types. For example, such as users, computers, and groups. There's only one schema master in an AD DS forest.

### Domain Naming Master

The domain naming master adds and removes domain directory partitions and application directory partitions to and from the forest. It's responsible for the partitions configuration naming context or `LDAP://CN=Partitions, CN=Configuration, DC=<domain>`. This FSMO role is responsible for ensuring the uniqueness of domain names within a forest and for authorizing changes to forest namespace structure. It can also add or remove cross references to domains in external directories.

## Role placement guidelines

You can assign the forest-level and domain-level operations master roles to any domain controller in the forest and domain. However, careful placement of your operations masters becomes more important as you add more domains and sites to your forest. To perform their respective operations, the domain controllers that host operations master roles must be consistently available. Operation masters must be located in areas where network reliability is high.

The following guidelines help to minimize administrative overhead and ensure the proper performance of Active Directory Domain Services (AD DS). The guidelines simplify the recovery process if a domain controller that is hosting an operations master role fails.

Guidelines for operations master role placement:

- Configure another domain controller as the standby operations master for the forest-level roles.

- Configure another domain controller as the standby operations master for the domain-level roles.

- Place domain-level roles on a high-performance domain controller.

- Leave forest-level roles on a domain controller in the forest root domain.

- In your forest root domain, transfer the three domain-level roles to another domain controller that has a high performance level.

- In all other domains, leave the domain-level roles on the first domain controller.

- Adjust the workload of the PDC emulator, if necessary.

The PDC emulator role requires a powerful and reliable domain controller to ensure that the domain controller is available and capable of handling the workload. Of all the operations master roles, the PDC emulator role creates the most overhead on the server that is hosting the role. It has the most intensive daily interaction with other systems on the network. The PDC emulator has the greatest potential to affect daily operations of the directory.

Improper placement of infrastructure master role can cause the infrastructure master to perform incorrectly. If all the domain controllers in a domain also host the global catalog, all the domain controllers have the current data. When the Infrastructure Master runs on a Global Catalog server, it stops updating object information because it doesn't contain any references to objects that it doesn't hold. As a result, cross-domain object references in that domain aren't updated and a warning to that effect is logged on that domain controller's event log. When the Recycle Bin optional feature is enabled, every domain controller is responsible to update its cross-domain object references when the referenced object is moved, renamed, or deleted. In this case, there are no tasks associated with the Infrastructure FSMO role.

## Next steps

- [Transfer Flexible Single Master Operations (FSMO) roles](manage-fsmo-roles.md)

- [Managing RID Issuance](Managing-RID-Issuance.md)
