---
ms.assetid: 87bca912-b912-4bbe-9533-2c34a7abc52d
title: Determining the Number of Domains Required
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/08/2018
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Determining the Number of Domains Required

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Every forest starts with a single domain. The maximum number of users that a single domain forest can contain is based on the slowest link that must accommodate replication between domain controllers and the available bandwidth that you want to allocate to Active Directory Domain Services (AD DS). The following table lists the maximum recommended number of users that a domain can contain based on a single domain forest, the speed of the slowest link, and the percentage of bandwidth that you want to reserve for replication. This information applies to forests that contain a maximum of 100,000 users and that have a connectivity of 28.8 kilobits per second (Kbps) or higher. For recommendations that apply to forests that contain more than 100,000 users or connectivity of less than 28.8 Kbps, consult an experienced Active Directory designer. The values in the following table are based on the replication traffic generated in an environment that has the following characteristics:  
  
- New users join the forest at a rate of 20 percent per year.  
- Users leave the forest at a rate of 15 percent per year.  
- Each user is a member of five global groups and five universal groups.  
- The ratio of users to computers is 1:1.  
- Active Directory-integrated Domain Name System (DNS) is used.  
- DNS scavenging is used.  

> [!NOTE]  
> The figures listed in the following table are approximations. The quantity of replication traffic depends largely on the number of changes made to the directory in a given amount of time. Confirm that your network can accommodate your replication traffic by testing the estimated quantity and rate of changes on your design in a lab before deploying your domains.  
  
|Slowest link connecting a domain controller (Kbps)|Maximum number of users if 1-percent bandwidth is available|Maximum number of users if 5-percent bandwidth is available|Maximum number of users if 10-percent bandwidth is available|  
| --- | --- | --- | --- |  
|28.8|10,000|25,000|40,000|  
|32|10,000|25,000|50,000|  
|56|10,000|50,000|100,000|  
|64|10,000|50,000|100,000|  
|128|25,000|100,000|100,000|  
|256|50,000|100,000|100,000|  
|512|80,000|100,000|100,000|  
|1,500|100,000|100,000|100,000|  

To use this table:  

1. In the **Slowest link connecting a domain controller** column, locate the value that matches the speed of the slowest link across which AD DS will replicate in your domain.  

2. In the row that corresponds to your slowest link speed, locate the column that represents the percentage bandwidth you want to allocate to AD DS. The value at that location is the maximum number of users that the domain in a single domain forest can contain.  

If you determine that the total number of users in your forest is less than the maximum number of users that your domain can contain, you can use a single domain. Be sure to accommodate for planned future growth when you make this determination. If you determine that the total number of users in your forest is greater than the maximum number of users that your domain can contain, you need to reserve a higher percentage of bandwidth for replication, increase your link speed, or divide your organization into regional domains.  
  
## Dividing the organization into regional domains

If you cannot accommodate all of your users in a single domain, you must select the regional domain model. Divide your organization into regions in a way that makes sense for your organization and your existing network. For example, you might create regions based on continental boundaries.  
  
Note that because you need to create an Active Directory domain for each region that you establish, we recommend that you minimize the number of regions that you define for AD DS. Although it is possible to include an unlimited number of domains in a forest, for manageability we recommend that a forest include no more than 10 domains. You must establish the appropriate balance between optimizing your replication bandwidth and minimizing your administrative complexity when dividing your organization into regional domains.  
  
First, determine the maximum number of users that your forest can host. Base this on the slowest link in the forest across which domain controllers will replicate and the average amount of bandwidth you want to allocate to Active Directory replication. The following table lists the maximum recommended number of users that a forest can contain. This is based on the speed of the slowest link and the percentage bandwidth that you want to reserve for replication. This information applies to forests that contain a maximum of 100,000 users and that have a connectivity of 28.8 Kbps or higher. The values in the following table are based on the following assumptions:  

- All domain controllers are global catalog servers.  
- New users join the forest at a rate of 20 percent per year.  
- Users leave the forest at a rate of 15 percent per year.  
- Users are members of five global groups and five universal groups.  
- The ratio of users to computers is 1:1.  
- Active Directory-integrated DNS is used.  
- DNS scavenging is used.  

> [!NOTE]  
> The figures listed in the following table are approximations. The quantity of replication traffic depends largely on the number of changes made to the directory in a given amount of time. Confirm that your network can accommodate your replication traffic by testing the estimated quantity and rate of changes on your design in a lab before deploying your domains.  
  
|Slowest link connecting a domain controller (Kbps)|Maximum number of users if 1-percent bandwidth is available|Maximum number of users if 5-percent bandwidth is available|Maximum number of users if 10-percent bandwidth is available|  
| --- | --- | --- | --- |  
|28.8|10,000|50,000|75,000|  
|32|10,000|50,000|75,000|  
|56|10,000|75,000|100,000|  
|64|25,000|75,000|100,000|  
|128|50,000|100,000|100,000|  
|256|75,000|100,000|100,000|  
|512|100,000|100,000|100,000|  
|1,500|100,000|100,000|100,000|  

To use this table:  

1. In the **Slowest link connecting a domain controller** column, locate the value that matches the speed of the slowest link across which AD DS will replicate in your forest.  

2. In the row that corresponds to your slowest link speed, locate the column that represents the percentage bandwidth that you want to allocate to AD DS. The value at that location is the maximum number of users that your forest can host.  

If the maximum number of users that your forest can host is greater than the number of users that you need to host, a single forest will work for your design. If you need to host more users than the maximum number that you identified, you need to increase the minimum link speed, allocate a greater percentage of bandwidth for AD DS, or deploy additional forests.  

If you determine that a single forest will accommodate the number of users that you need to host, the next step is to determine the maximum number of users that each region can support based on the slowest link located in that region. Divide your forest into regions that make sense to you. Make sure that you base your decision on something that is not likely to change. For example, use continents instead of sales regions. These regions will be the basis of your domain structure when you have identified the maximum number of users.  

Determine the number of users that need to be hosted in each region, and then verify that they do not exceed the maximum allowed based on the slowest link speed and the bandwidth allocated to AD DS in that region. The following table lists the maximum recommended number of users that a regional domain can contain. It is based on the speed of the slowest link and the percentage of bandwidth you want to reserve for replication. This information applies to forests that contain a maximum of 100,000 users and that have a connectivity of 28.8 Kbps or higher. The values in the following table are based on the following assumptions:  

- All domain controllers are global catalog servers.  
- New users join the forest at a rate of 20 percent per year.  
- Users leave the forest at a rate of 15 percent per year.  
- Users are members of five global groups and five universal groups.  
- The ratio of users to computers is 1:1.  
- Active Directory-integrated DNS is used.  
- DNS scavenging is used.  
  
> [!NOTE]  
> The figures listed in the following table are approximations. The quantity of replication traffic depends largely on the number of changes made to the directory in a given amount of time. Confirm that your network can accommodate your replication traffic by testing the estimated quantity and rate of changes on your design in a lab before deploying your domains.  
  
|Slowest link connecting a domain controller (Kbps)|Maximum number of users if 1-percent bandwidth is available|Maximum number of users if 5-percent bandwidth is available|Maximum number of users if 10-percent bandwidth is available|  
| --- | --- | --- | --- |  
|28.8|10,000|18,000|40,000|  
|32|10,000|20,000|50,000|  
|56|10,000|40,000|100,000|  
|64|10,000|50,000|100,000|  
|128|15,000|100,000|100,000|  
|256|30,000|100,000|100,000|  
|512|80,000|100,000|100,000|  
|1,500|100,000|100,000|100,000|  

To use this table:  

1. In the **Slowest link connecting a domain controller** column, locate the value that matches the speed of the slowest link across which AD DS will replicate in your region.  

2. In the row that corresponds to your slowest link speed, locate the column that represents the percentage bandwidth that you want to allocate to AD DS. That value represents the maximum number of users that the region can host.  

Evaluate each proposed region and determine if the maximum number of users in each region is less than the recommended maximum number of users that a domain can contain. If you determine that the region can host the number of users that you require, you can create a domain for that region. If you determine that you cannot host that many users, consider dividing your design into smaller regions and recalculating the maximum number of users that can be hosted in each region. The other alternatives are to allocate more bandwidth or increase your link speed.  

Although the total number of users that you can put in a domain in a multidomain forest is smaller than the number of users in the domain in a single domain forest, the overall number of users in the multidomain forest can be higher. The smaller number of users per domain in a multidomain forest accommodates the additional replication overhead created by maintaining the global catalog in that environment. For recommendations that apply to forests that contain more than 100,000 users or connectivity of less than 28.8 Kbps, consult an experienced Active Directory designer.  
  
## Documenting the regions identified

After you divide your organization into regional domains, document the regions that you want represented and the number of users that will exist in each region. In addition, note the speed of the slowest links in each region that you will use for Active Directory replication. This information is used to determine if additional domains or forests are required.  

For a worksheet to assist you in documenting the regions you identified, download Job_Aids_Designing_and_Deploying_Directory_and_Security_Services.zip from [Job Aids for Windows Server 2003 Deployment Kit](https://go.microsoft.com/fwlink/?LinkID=102558) and open "Identifying Regions" (DSSLOGI_4.doc).  
