---
ms.assetid: eb600904-24b8-4488-a278-c1c971dc2f2d
title: Planning Regional Domain Controller Placement
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/08/2018
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Planning Regional Domain Controller Placement

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

To ensure cost efficiency, plan to place as few regional domain controllers as possible. First, review the "Geographic Locations and Communication Links" (DSSTOPO_1.doc) worksheet used in [Collecting Network Information](../../ad-ds/plan/Collecting-Network-Information.md) to determine whether a location is a hub.  
  
Plan to place regional domain controllers for each domain that is represented in each hub location. After you place regional domain controllers in all hub locations, evaluate the need for placing regional domain controllers at satellite locations. Eliminating unnecessary regional domain controllers from satellite locations reduces the support costs required to maintain a remote server infrastructure.  
  
In addition, ensure the physical security of domain controllers in hub and satellite locations so that unauthorized personnel cannot access them. Do not place writable domain controllers in hub and satellite locations in which you cannot guarantee the physical security of the domain controller. A person who has physical access to a writable domain controller can attack the system by:  
  
- Accessing physical disks by starting an alternate operating system on a domain controller.  
- Removing (and possibly replacing) physical disks on a domain controller.  
- Obtaining and manipulating a copy of a domain controller system state backup.  
  
Add writable regional domain controllers only to locations in which you can guarantee their physical security.  
  
In locations with inadequate physical security, deploying a read-only domain controller (RODC) is the recommended solution. Except for account passwords, an RODC holds all the Active Directory objects and attributes that a writable domain controller holds. However, changes cannot be made to the database that is stored on the RODC. Changes must be made on a writable domain controller and then replicated back to the RODC.  
  
To authenticate client logons and access to local file servers, most organizations place regional domain controllers for all regional domains that are represented in a given location. However, you must consider many variables when evaluating whether a business location requires its clients to have local authentication or the clients can rely on authentication and query over a wide area network (WAN) link. The following illustration shows how to determine whether to place domain controllers at satellite locations.  
  
![plan regional dc placement](media/Planning-Regional-Domain-Controller-Placement/49892c8c-2c99-4aab-92ba-808dbc8048e2.gif)  
  
## Onsite technical expertise availability

Domain controllers need to be managed continuously for various reasons. Place a regional domain controller only in locations that include personnel who can administer the domain controller, or be sure that the domain controller can be managed remotely.  
  
In branch office environments with typically poor physical security and personnel with little information technology knowledge, deploying an RODC is often the recommended solution. Local administrative permissions for an RODC can be delegated to any domain user without granting that user any user rights for the domain or other domain controllers. This permits a local branch user to log on to an RODC and perform maintenance work on the server, such as upgrading a driver. However, the branch user cannot log on to any other domain controller or perform any other administrative task in the domain. In this way, the branch user can be delegated the ability to effectively manage the RODC in the branch office without compromising the security of the rest of the domain or the forest.  
  
## WAN link availability

WAN links that experience frequent outages can cause significant productivity loss to users if the location does not include a domain controller that can authenticate the users. If your WAN link availability is not 100 percent and your remote sites cannot tolerate a service outage, place a regional domain controller in locations where the users require the ability to log on or exchange server access when the WAN link is down.  
  
## Authentication availability

Certain organizations, such as banks, require that users be authenticated at all times. Place a regional domain controller in a location where the WAN link availability is not 100 percent but users require authentication at all times.  
  
## Logon performance over WAN links

If your WAN link availability is highly reliable, placing a domain controller at the location depends on the logon performance requirements over the WAN link. Factors that influence logon performance over the WAN include link speed and available bandwidth, number of users and usage profiles, and the amount of logon network traffic versus replication traffic.  
  
### WAN link speed and bandwidth utilization

The activities of a single user can congest a slow WAN link. Place a domain controller at a location if logon performance over the WAN link is unacceptable.  
  
The average percentage of bandwidth utilization indicates how congested a network link is. If a network link has average bandwidth utilization that is greater than an acceptable value, place a domain controller at that location.  
  
### Number of users and usage profiles

The number of users and their usage profiles at a given location can help determine whether you need to place regional domain controllers at that location. To avoid productivity loss if a WAN link fails, place a regional domain controller at a location that has 100 or more users.  
  
The usage profiles indicate how the users use the network resources. You do not need to place a domain controller in a location that contains only a few users who do not frequently access network resources.  
  
### Logon network traffic vs. replication traffic

If a domain controller is not available within the same location as the Active Directory client, the client creates logon traffic on the network. The amount of logon network traffic that is created on the physical network is influenced by several factors, including group memberships; number and size of Group Policy objects (GPOs); logon scripts; and features such as offline folders, folder redirection, and roaming profiles.  
  
On the other hand, a domain controller that is placed at a given location generates replication traffic on the network. The frequency and amount of updates made on the partitions hosted on the domain controllers influence the amount of replication traffic that is created on the network. The different types of updates that can be made on the partitions hosted on the domain controllers include adding or changing users and user attributes, changing passwords, and adding or changing global groups, printers, or volumes.  
  
To determine if you need to place a regional domain controller at a location, compare the cost of logon traffic created by a location without a domain controller versus the cost of replication traffic created by placing a domain controller at the location.  
  
For example, consider a network that has branch offices that are connected through slow links to the headquarters and in which domain controllers can easily be added. If the daily logon and directory lookup traffic of a few remote site users causes more network traffic than replicating all company data to the branch, consider adding a domain controller to the branch.  
  
If reducing the cost of maintaining domain controllers is more important than network traffic, either centralize the domain controllers for that domain and do not place any regional domain controllers at the location or consider placing RODCs at the location.  
  
For a worksheet to assist you in documenting the placement of regional domain controllers and the number of users for each domain that is represented in each location, see [Job Aids for Windows Server 2003 Deployment Kit](https://go.microsoft.com/fwlink/?LinkID=102558), download Job_Aids_Designing_and_Deploying_Directory_and_Security_Services.zip, and open "Domain Controller Placement" (DSSTOPO_4.doc).  
  
You will need to refer to the information about locations in which you need to place regional domain controllers when you deploy regional domains. For more information about deploying regional domains, see [Deploying Windows Server 2008 Regional Domains](https://technet.microsoft.com/library/cc755118.aspx).  
