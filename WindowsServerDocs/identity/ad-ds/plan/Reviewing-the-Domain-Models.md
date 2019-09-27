---
ms.assetid: e727a33d-133b-43c9-b6a4-7c00f9cb6000
title: Reviewing the Domain Models
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/08/2018
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---
# Reviewing the Domain Models

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The following factors impact the domain design model that you select:  
  
- Amount of available capacity on your network that you are willing to allocate to Active Directory Domain Services (AD DS). The goal is to select a model that provides efficient replication of information with minimal impact on available network bandwidth.  

- Number of users in your organization. If your organization includes a large number of users, deploying more than one domain enables you to partition your data and gives you more control over the amount of replication traffic that will pass through a given network connection. This makes it possible for you to control where data is replicated and reduce the load created by replication traffic on slow links in your network.  

The simplest domain design is a single domain. In a single domain design, all information is replicated to all of the domain controllers. If necessary, however, you can deploy additional regional domains. This might occur if portions of the network infrastructure are connected by slow links, and the forest owner wants to be sure that replication traffic does not exceed the capacity that has been allocated to AD DS.  

It is best to minimize the number of domains that you deploy in your forest. This reduces the overall complexity of the deployment and, as a result, reduces total cost of ownership. The following table lists the administrative costs associated with adding regional domains.  

|Cost|Implications|  
|--------|----------------|  
|Management of multiple service administrator groups|Each domain has its own service administrator groups that need to be managed independently. The membership of these service administrator groups must be carefully controlled.|  
|Maintaining consistency among Group Policy settings that are common to multiple domains|Group Policy settings that need to be applied forest-wide must be applied separately to each individual domain in the forest.|  
|Maintaining consistency among access control and auditing settings that are common to multiple domains|Access control and auditing settings that need to be applied across the forest must be applied separately to each individual domain in the forest.|  
|Increased likelihood of objects moving between domains|The greater the number of domains, the greater the likelihood that users will need to move from one domain to another. This move can potentially impact end users.|  

> [!NOTE]  
> Windows Server fine-grained password and account lockout policies can also impact the domain design model that you select. Before this release of  Windows Server 2008, you could apply only one password and account lockout policy, which is specified in the domain Default Domain Policy, to all users in the domain. As a result, if you wanted different password and account lockout settings for different sets of users, you had to either create a password filter or deploy multiple domains. You can now use fine-grained password policies to specify multiple password policies and to apply different password restrictions and account lockout policies to different sets of users within a single domain. For more information about fine-grained password and account lockout policies, see the article [Step-by-Step Guide for Fine-Grained Password and Account Lockout Policy Configuration](https://go.microsoft.com/fwlink/?LinkID=91477).  

## Single domain model

A single domain model is the easiest to administer and the least expensive to maintain. It consists of a forest that contains a single domain. This domain is the forest root domain, and it contains all of the user and group accounts in the forest.  

A single domain forest model reduces administrative complexity by providing the following advantages:  

- Any domain controller can authenticate any user in the forest.  

- All domain controllers can be global catalogs, so you do not need to plan for global catalog server placement.  
  
In a single domain forest, all directory data is replicated to all geographic locations that host domain controllers. While this model is the easiest to manage, it also creates the most replication traffic of the two domain models. Partitioning the directory into multiple domains limits the replication of objects to specific geographic regions but results in more administrative overhead.  
  
## Regional domain model

All object data within a domain is replicated to all domain controllers in that domain. For this reason, if your forest includes a large number of users that are distributed across different geographic locations connected by a wide area network (WAN), you might need to deploy regional domains to reduce replication traffic over the WAN links. Geographically based regional domains can be organized according to network WAN connectivity.  
  
The regional domain model enables you to maintain a stable environment over time. Base the regions used to define domains in your model on stable elements, such as continental boundaries. Domains based on other factors, such as groups within the organization, can change frequently and might require you to restructure your environment.  
  
The regional domain model consists of a forest root domain and one or more regional domains. Creating a regional domain model design involves identifying what domain is the forest root domain and determining the number of additional domains that are required to meet your replication requirements. If your organization includes groups that require data isolation or service isolation from other groups in the organization, create a separate forest for these groups. Domains do not provide data isolation or service isolation.  
