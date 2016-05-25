---
title: Forcing Replication
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 853b4a1f-726c-43fd-b917-83fc8f828a4a
author: Femila
---
# Forcing Replication
  When you need updates to be replicated sooner than the intersite replication schedule allows, or when replication between sites is impossible because of configuration errors, you can force replication to and from domain controllers. You can use the following two methods of forcing replication:  
  
-   Force replication of all directory partition updates from one server to another server over a connection  
  
-   Force replication of configuration directory partition updates from one server to another server  
  
## Forcing replication of all directory updates over a connection  
 If you want to replicate certain updates, such as a significant addition of new passwords or user accounts, to another domain controller in the domain, you can use the **Replicate now** option in the Active Directory Sites and Services snap\-in to force replication of all directory partitions over a connection object that represents inbound replication from a specific domain controller. A connection object for a server object that represents a domain controller identifies the replication partner from which the domain controller receives replication. If the changes are made on one domain controller, you can select the connection from that domain controller and force replication to its replication partner.  
  
 You can also use the Repadmin.exe command\-line tool to replication changes from a server to one or more other servers or to all servers.  
  
## Forcing replication of configuration updates  
 Active Directory replication uses a pull model, in which one domain controller requests changes from another domain controller. For this reason, connection objects always represent one\-way, inbound replication from a source server to a destination server. All objects that are required for replication are contained in the configuration directory partition, which is replicated to every domain controller in the forest.  
  
 If a site link is deleted inadvertently, the domain controllers in the respective sites drop connection objects that represent servers in any site to which the domain controller’s site is no longer linked. The only way for these connection objects to be recreated is for a new site link to be created and for domain controllers in each site in the site link to recreate the connection objects. However, the change to the configuration directory partition \(the new site link\) cannot be replicated from the site where the change occurs to the other site because the domain controllers in the other site have dropped their inbound connection objects from servers in the site where the site link has been recreated. The **Replicate now** option does not fix the problem because the ability to use **Replicate now** depends on the existence of a from\-server connection object.  
  
 On writable domain controllers running Windows Server 2003, the only way to resolve this issue is to create the new site link object twice, once on a domain controller in each site. When the domain controller has a site link, the Knowledge Consistency Checker \(KCC\) on the domain controller can then create connection objects from servers in the other site.  
  
 On writable domain controllers running Windows Server 2008, a new option is available that you can use to force replication of only the configuration directory partition to a domain controller in another site, even though a connection object from a server in the site does not exist in the configuration directory partition. In this case, you can recreate the site link in one site and force replication of this configuration change to a domain controller in the other site. When replication of the new site link object is received on the domain controller in the other site, that domain controller can then create new connection objects from servers in the other sites in the site link.  
  
 This functionality is particularly useful if the only domain controller in a site is a read\-only domain controller \(RODC\). In this case, you cannot recreate the site link on a domain controller in both sites because you cannot write to the RODC. When you recreate the site link in the hub site and then force replication of the configuration directory partition to the site of the RODC, you enable the RODC to create connection objects from replication partners in the hub site.  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   Active Directory Sites and Services  
  
-   Repadmin.exe  
  
 To complete this task, perform the following procedures:  
  
1.  [Force Replication Between Domain Controllers](../Topic/Force-Replication-Between-Domain-Controllers.md)  
  
2.  [Update a Server with Configuration Changes](../Topic/Update-a-Server-with-Configuration-Changes.md)  
  
3.  [Synchronize Replication with All Partners](../Topic/Synchronize-Replication-with-All-Partners.md)  
  
4.  [Verify Successful Replication to a Domain Controller](../Topic/Verify-Successful-Replication-to-a-Domain-Controller.md)  
  
  