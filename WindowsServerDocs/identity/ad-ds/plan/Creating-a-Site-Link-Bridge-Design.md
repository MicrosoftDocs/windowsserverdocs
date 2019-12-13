---
ms.assetid: 64142026-07b5-4601-840a-c8dcf6ab9814
title: Creating a Site Link Bridge Design
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/08/2018
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---
# Creating a Site Link Bridge Design

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

A site link bridge connects two or more site links and enables transitivity between site links. Each site link in a bridge must have a site in common with another site link in the bridge. The Knowledge Consistency Checker (KCC) uses the information on each site link to compute the cost of replication between sites in one site link and sites in the other site links of the bridge. Without the presence of a common site between site links, the KCC also cannot establish direct connections between domain controllers in the sites that are connected by the same site link bridge.  
  
By default, all site links are transitive. We recommend that you keep transitivity enabled by not changing the default value of **Bridge all site links** (enabled by default). However, you will need to disable **Bridge all site links** and complete a site link bridge design if:  

- Your IP network is not fully routed. When you disable **Bridge all site links**, all site links are considered nontransitive, and you can create and configure site link bridge objects to model the actual routing behavior of your network.  
- You need to control the replication flow of the changes made in Active Directory Domain Services (AD DS). By disabling **Bridge all site links** for the site link IP transport and configuring a site link bridge, the site link bridge becomes the equivalent of a disjointed network. All site links within the site link bridge can route transitively, but they do not route outside of the site link bridge.  

For more information about how to use the Active Directory Sites and Services snap-in to disable the **Bridge all site links** setting, see the article [Enable or disable site link bridges](https://go.microsoft.com/fwlink/?LinkId=107073).  
  
## Controlling AD DS replication flow

Two scenarios in which you need a site link bridge design to control replication flow include controlling replication failover and controlling replication through a firewall.  
  
### Controlling replication failover

If your organization has a hub-and-spoke network topology, you generally do not want the satellite sites to create replication connections to other satellite sites if all domain controllers in the hub site fail. In such scenarios, you must disable **Bridge all site links** and create site link bridges so that replication connections are created between the satellite site and another hub site that is just one or two hops away from the satellite site.  
  
### Controlling replication through a firewall

If two domain controllers representing the same domain in two different sites are specifically allowed to communicate with each other only through a firewall, you can disable **Bridge all site links** and create site link bridges for sites on the same side of the firewall. Therefore, if your network is separated by firewalls, we recommend that you disable transitivity of site links and create site link bridges for the network on one side of the firewall. For information about managing replication through firewalls, see the article [Active Directory in Networks Segmented by Firewalls](https://go.microsoft.com/fwlink/?LinkId=107074).
