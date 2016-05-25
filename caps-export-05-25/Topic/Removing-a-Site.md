---
title: Removing a Site
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d6c388c0-4e64-4fa3-9e59-6e67464ec3fa
author: Femila
---
# Removing a Site
  If domain controllers are no longer needed in a network location, you can remove them from the site and then delete the site object. Before you delete the site, you must remove each domain controller from the site either by removing domain controller completely or by moving it to a new location:  
  
-   To remove the domain controller completely, remove Active Directory Domain Services \(AD DS\) from the server and then delete the server object from the site in AD DS.  
  
-   To retain the domain controller in a different location, move the domain controller itself to the new site and then move the server object to the respective site in AD DS.  
  
 Before you remove a server object from a site, check the NTDS Settings object of the server to see if the server has a manual connection object from any server in another site. If a manual connection object exists, check the source server in the other site for a corresponding manual connection object from the server that you are removing. The Knowledge Consistency Checker \(KCC\) does not remove manual connection objects automatically. Therefore, if you leave a manually created connection object on a server and then remove the source server for the connection, the inability of the destination server to replicate from its source replication partner will cause replication errors to be generated. If a manual connection object exists in the NTDS Settings object of a server in another site, and if the server that you are removing is the source \(“replicate from”\) server for the connection, delete that manual connection object on the destination server to avoid unnecessary replication errors after you have removed the server object.  
  
 Domain controllers can host other applications that depend on site topology and publish objects as child objects of the respective server object. For example, when Microsoft Operations Manager \(MOM\) or Message Queuing is running on a domain controller, these applications create child objects beneath the server object. In addition, a server running Message Queuing that is not a domain controller and that is configured to be a routing server running Message Queuing creates a server object in the sites container. Removing the application from the server automatically removes the child object below the respective server object. However, the server object is not removed automatically.  
  
 When all applications have been removed from the server \(no child objects appear beneath the server object\), you can remove the server object. After the application is removed from the server, a replication cycle might be required before child objects are no longer visible below the server object.  
  
 After you delete or move the server objects but before you delete the site object, reconcile the following objects:  
  
 IP addresses:  
  
-   If the addresses are being reassigned to a different site, associate the subnet object or objects with that site. Any clients that use the addresses for the decommissioned site will thereafter be assigned automatically to the other site.  
  
-   If the IP addresses will no longer be used on the network, delete the corresponding subnet object or objects.  
  
 Site link objects:  
  
-   If the site that you are removing is added to a site link that contains only two sites, delete the site link object.  
  
-   If the site that you are removing is added to a site link that contains more than two sites, do not delete this site link object.  
  
 Before you remove a site, consider the implications. If the site that you are removing is added to more than one site link, it might be an interim site between other sites that are added to this site link. Deleting the site might disconnect the outer sites from each other. In this case, the site links must be reconciled according to the instructions of the design team.  
  
 **Task requirements**  
  
 The following tool is required to perform the procedures for this task:  
  
-   Active Directory Sites and Services  
  
 To complete this task, perform the following procedures:  
  
1.  [Delete a Manual Connection Object](../Topic/Delete-a-Manual-Connection-Object.md)  
  
2.  [Determine Whether a Server Object Has Child Objects](../Topic/Determine-Whether-a-Server-Object-Has-Child-Objects.md)  
  
3.  [Delete a Server Object from a Site](../Topic/Delete-a-Server-Object-from-a-Site.md)  
  
4.  [Delete a Site Link object](../Topic/Delete-a-Site-Link-object.md)  
  
5.  [Associate an Existing Subnet Object with a Site](../Topic/Associate-an-Existing-Subnet-Object-with-a-Site.md)  
  
6.  [Delete a Site object](../Topic/Delete-a-Site-object.md)  
  
7.  To avoid replication errors on bridgehead servers in other sites that received replication from the site that has been removed, generate the intersite topology in those sites by performing the following two procedures:  
  
    -   [Determine the ISTG Role Owner for a Site](../Topic/Determine-the-ISTG-Role-Owner-for-a-Site.md)  
  
    -   [Generate the Replication Topology on the ISTG](../Topic/Generate-the-Replication-Topology-on-the-ISTG.md)  
  
  