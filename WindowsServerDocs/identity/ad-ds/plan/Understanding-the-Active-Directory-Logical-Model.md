---
ms.assetid: 62708b2e-4090-4cf7-8ae6-a557f31f561f
title: Understanding the Active Directory Logical Model
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Understanding the Active Directory Logical Model

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Designing your logical structure for Active Directory Domain Services (AD DS) involves defining the relationships between the containers in your directory. These relationships might be based on administrative requirements, such as delegation of authority, or they might be defined by operational requirements, such as the need to control replication.  
  
Before you design your Active Directory logical structure, it is important to understand the Active Directory logical model. AD DS is a distributed database that stores and manages information about network resources as well as application-specific data from directory-enabled applications. AD DS allows administrators to organize elements of a network (such as users, computers, and devices) into a hierarchical containment structure. The top-level container is the forest. Within forests are domains, and within domains are organizational units (OUs). This is called the logical model because it is independent of the physical aspects of the deployment, such as the number of domain controllers required within each domain and network topology.  
  
## Active Directory forest  
A forest is a collection of one or more Active Directory domains that share a common logical structure, directory schema (class and attribute definitions), directory configuration (site and replication information), and global catalog (forest-wide search capabilities). Domains in the same forest are automatically linked with two-way, transitive trust relationships.  
  
## Active Directory domain  
A domain is a partition in an Active Directory forest. Partitioning data enables organizations to replicate data only to where it is needed. In this way, the directory can scale globally over a network that has limited available bandwidth. In addition, the domain supports a number of other core functions related to administration, including:  
  
-   Network-wide user identity. Domains allow user identities to be created once and referenced on any computer joined to the forest in which the domain is located. Domain controllers that make up a domain are used to store user accounts and user credentials (such as passwords or certificates) securely.  
  
-   Authentication. Domain controllers provide authentication services for users and supply additional authorization data such as user group memberships, which can be used to control access to resources on the network.  
  
-   Trust relationships. Domains can extend authentication services to users in domains outside their own forest by means of trusts.  
  
-   Replication. The domain defines a partition of the directory that contains sufficient data to provide domain services and then replicates it between the domain controllers. In this way, all domain controllers are peers in a domain and are managed as a unit.  
  
## Active Directory organizational units  
OUs can be used to form a hierarchy of containers within a domain. OUs are used to group objects for administrative purposes such as the application of Group Policy or delegation of authority. Control (over an OU and the objects within it) is determined by the access control lists (ACLs) on the OU and on the objects in the OU. To facilitate the management of large numbers of objects, AD DS supports the concept of delegation of authority. By means of delegation, owners can transfer full or limited administrative control over objects to other users or groups. Delegation is important because it helps to distribute the management of large numbers of objects across a number of people who are trusted to perform management tasks.  
  


