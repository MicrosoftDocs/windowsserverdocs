---
ms.assetid: 84754c23-f039-4de4-a378-853942e662df
title: Introduction
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Introduction

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Attacks against computing infrastructures, whether simple or complex, have existed as long as computers have. However, within the past decade, increasing numbers of organizations of all sizes, in all parts of the world have been attacked and compromised in ways that have significantly changed the threat landscape. Cyber-warfare and cybercrime have increased at record rates. "Hacktivism," in which attacks are motivated by activist positions, has been claimed as the motivation for a number of breaches intended to expose organizations' secret information, to create denials-of-service, or even to destroy infrastructure. Attacks against public and private institutions with the goal of exfiltrating the organizations' intellectual property (IP) have become ubiquitous.  
  
No organization with an information technology (IT) infrastructure is immune from attack, but if appropriate policies, processes, and controls are implemented to protect key segments of an organization's computing infrastructure, escalation of attacks from penetration to complete compromise might be preventable. Because the number and scale of attacks originating from outside an organization has eclipsed insider threat in recent years, this document often discusses external attackers rather than misuse of the environment by authorized users. Nonetheless, the principles and recommendations provided in this document are intended to help secure your environment against external attackers and misguided or malicious insiders.  
  
The information and recommendations provided in this document are drawn from a number of sources and derived from practices designed to protect Active Directory installations against compromise. Although it is not possible to prevent attacks, it is possible to reduce the Active Directory attack surface and to implement controls that make compromise of the directory much more difficult for attackers. This document presents the most common types of vulnerabilities we have observed in compromised environments and the most common recommendations we have made to customers to improve the security of their Active Directory installations.  
  
## Account and Group Naming Conventions  
The following table provides a guide to the naming conventions used in this document for the groups and accounts referenced throughout the document. Included in the table is the location of each account/group, its name, and how these accounts/groups are referenced in this document.  
  


|**Account/Group Location**|**Name of Account/Group**|**How It is Referenced in this Document**|
| --- | --- | --- |   
|Active Directory - each domain|Administrator|Built-in Administrator account|  
|Active Directory - each domain|Administrators|Built-in Administrators (BA) group|  
|Active Directory - each domain|Domain Admins|Domain Admins (DA) group|  
|Active Directory - forest root domain|Enterprise Admins|Enterprise Admins (EA) group|  
|Local computer security accounts manager (SAM) database on computers running Windows Server and workstations that are not domain controllers|Administrator|Local Administrator account|  
|Local computer security accounts manager (SAM) database on computers running Windows Server and workstations that are not domain controllers|Administrators|Local Administrators group|  
  
## About This Document  
The Microsoft Information Security and Risk Management (ISRM) organization, which is part of Microsoft Information Technology (MSIT), works with internal business units, external customers, and industry peers to gather, disseminate, and define policies, practices, and controls. This information can be used by Microsoft and our customers to increase the security and reduce the attack surface of their IT infrastructures. The recommendations provided in this document are based on a number of information sources and practices used within MSIT and ISRM. The following sections present more information about the origins of this document.  
  
### Microsoft IT and ISRM  
A number of practices and controls have been developed within MSIT and ISRM to secure the Microsoft AD DS forests and domains. Where these controls are broadly applicable, they have been integrated into this document. SAFE-T (Solution Accelerators for Emerging Technologies) is a team within ISRM whose charter is to identify emerging technologies, and to define security requirements and controls to accelerate their adoption.  
  
### Active Directory Security Assessments  
Within Microsoft ISRM, the Assessment, Consulting, and Engineering (ACE) Team works with internal Microsoft business units and external customers to assess application and infrastructure security and to provide tactical and strategic guidance to increase the organization's security posture. One ACE service offering is the Active Directory Security Assessment (ADSA), which is a holistic assessment of an organization's AD DS environment that assesses people, process, and technology and produces customer-specific recommendations. Customers are provided with recommendations that are based on the organization's unique characteristics, practices, and risk appetite. ADSAs have been performed for Active Directory installations at Microsoft in addition to those of our customers. Over time, a number of recommendations have been found to be applicable across customers of varying sizes and industries.  
  
### Content Origin and Organization  
Much of the content of this document is derived from the ADSA and other ACE Team assessments performed for compromised customers and customers who have not experienced significant compromise. Although individual customer data was not used to create this document, we have collected the most commonly exploited vulnerabilities we have identified in our assessments and the recommendations we have made to customers to improve the security of their AD DS installations. Not all vulnerabilities are applicable to all environments, nor are all recommendations feasible to implement in every organization.  
  
This document is organized as follows:  
  
## Executive Summary  
The Executive Summary, which can be read as a standalone document or in combination with the full document, provides a high-level summary of this document. Included in the Executive Summary are the most common attack vectors we have observed used to compromise customer environments, summary recommendations for securing Active Directory installations, and basic objectives for customers who plan to deploy new AD DS forests now or in the future.  
  
### Introduction  
This is the section you are reading now.  
  
### Avenues to Compromise  
This section provides information about some of the most commonly leveraged vulnerabilities we have found to be used by attackers to compromise customers' infrastructures. This section begins with general categories of vulnerabilities and how they are leveraged to initially penetrate customers' infrastructures, propagate compromise across additional systems, and eventually target AD DS and domain controllers to obtain complete control of organizations' forests.  
  
This section does not provide detailed recommendations about addressing each type of vulnerability, particularly in the areas in which the vulnerabilities are not used to directly target Active Directory. However, for each type of vulnerability, we have provided links to additional information that you can use to develop countermeasures and reduce your organization's attack surface.  
  
### Reducing the Active Directory Attack Surface  
This section begins by providing background information about privileged accounts and groups in Active Directory to provide the information that helps clarify the reasons for the subsequent recommendations for securing and managing privileged groups and accounts. We then discuss approaches to reduce the need to use highly privileged accounts for day-to-day administration, which does not require the level of privilege that is granted to groups such as the Enterprise Admins (EA), Domain Admins (DA), and Built-in Administrators (BA) groups in Active Directory. Next, we provide guidance for securing the privileged groups and accounts and for implementing secure administrative practices and systems.  
  
Although this section provides detailed information about these configuration settings, we have also included appendices for each recommendation that provide step-by-step configuration instructions that can be used "as is" or can be modified for the organization's needs. This section finishes by providing information to securely deploy and manage domain controllers, which should be among the most stringently secured systems in the infrastructure.  
  
### Monitoring Active Directory for Signs of Compromise  
Whether you have implemented robust security information and event monitoring (SIEM) in your environment or are using other mechanisms to monitor the security of the infrastructure, this section provides information that can be used to identify events on Windows systems that may indicate that an organization is being attacked. We discuss traditional and advanced audit policies, including effective configuration of audit subcategories in the Windows 7 and Windows Vista operating systems. This section includes comprehensive lists of objects and systems to audit, and an associated appendix lists events for which you should monitor if the goal is to detect compromise attempts.  
  
### Planning for Compromise  
This section begins by "stepping back" from technical detail to focus on principles and processes that can be implemented to identify the users, applications, and systems that are most critical not only to the IT infrastructure, but to the business. After identifying what is most critical to the stability and operations of your organization, you can focus on segregating and securing these assets, whether they are intellectual property, people, or systems. In some cases, segregating and securing assets may be performed in your existing AD DS environment, while in other cases, you should consider implementing small, separate "cells" that allow you to establish a secure boundary around critical assets and monitor those assets more stringently than less-critical components. A concept called "creative destruction," which is a mechanism by which legacy applications and systems can be eliminated by creating new solutions is discussed, and the section ends with recommendations that can help to maintain a more secure environment by combining business and IT information to construct a detailed picture of what is a normal operational state. By knowing what is normal for an organization, abnormalities that may indicate attacks and compromises can be more easily identified.  
  
### Summary of Best Practice Recommendations  
This section provides a table that summarizes the recommendations made in this document and orders them by relative priority, in addition to providing links to where more information about each recommendation can be found in the document and its appendices.  
  
### Appendices  
Appendices are included in this document to augment the information contained in the body of the document. The list of appendices and a brief description of each is included the following table.  
  
 
|**Appendix**|**Description**|
| --- | --- | 
|[Appendix B: Privileged Accounts and Groups in Active Directory](../../../ad-ds/plan/security-best-practices/Appendix-B--Privileged-Accounts-and-Groups-in-Active-Directory.md)|Provides background information that helps you to identify the users and groups you should focus on securing because they can be leveraged by attackers to compromise and even destroy your Active Directory installation.|  
|[Appendix C: Protected Accounts and Groups in Active Directory](../../../ad-ds/plan/security-best-practices/Appendix-C--Protected-Accounts-and-Groups-in-Active-Directory.md)|Contains information about protected groups in Active Directory. It also contains information for limited customization (removal) of groups that are considered protected groups and are affected by AdminSDHolder and SDProp.|  
|[Appendix D: Securing Built-In Administrator Accounts in Active Directory](../../../ad-ds/plan/security-best-practices/Appendix-D--Securing-Built-In-Administrator-Accounts-in-Active-Directory.md)|Contains guidelines to help secure the Administrator account in each domain in the forest.|  
|[Appendix E: Securing Enterprise Admins Groups in Active Directory](../../../ad-ds/plan/security-best-practices/Appendix-E--Securing-Enterprise-Admins-Groups-in-Active-Directory.md)|Contains guidelines to help secure the Enterprise Admins group in the forest.|  
|[Appendix F: Securing Domain Admins Groups in Active Directory](../../../ad-ds/plan/security-best-practices/Appendix-F--Securing-Domain-Admins-Groups-in-Active-Directory.md)|Contains guidelines to help secure the Domain Admins group in each domain in the forest.|  
|[Appendix G: Securing Administrators Groups in Active Directory](../../../ad-ds/plan/security-best-practices/Appendix-G--Securing-Administrators-Groups-in-Active-Directory.md)|Contains guidelines to help secure the Built-in Administrators group in each domain in the forest.|  
|[Appendix H: Securing Local Administrator Accounts and Groups](../../../ad-ds/plan/security-best-practices/Appendix-H--Securing-Local-Administrator-Accounts-and-Groups.md)|Contains guidelines to help secure local Administrator accounts and Administrators groups on domain-joined servers and workstations.|  
|[Appendix I: Creating Management Accounts for Protected Accounts and Groups in Active Directory](../../../ad-ds/manage/component-updates/Appendix-I--Creating-Management-Accounts-for-Protected-Accounts-and-Groups-in-Active-Directory.md)|Provides information to create accounts that have limited privileges and can be stringently controlled, but can be used to populate privileged groups in Active Directory when temporary elevation is required.|  
|[Appendix L: Events to Monitor](../../../ad-ds/plan/Appendix-L--Events-to-Monitor.md)|Lists events for which you should monitor in your environment.|  
|[Appendix M: Document Links and Recommended Reading](../../../ad-ds/manage/Appendix-M--Document-Links-and-Recommended-Reading.md)|Contains a list of recommended reading. Also contains a list of links to external documents and their URLs so that readers of hard copies of this document can access this information.|  
  


