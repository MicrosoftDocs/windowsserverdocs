---
title: Security guide for Hyper-V in Windows Server 2012
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cf1bc2b1-0572-4157-8de2-47673f1b58d5
author: cwatsonmsft
---
# Security guide for Hyper-V in Windows Server 2012
This guide provides instructions and recommendations to help strengthen the security of computers running the *Hyper\-V role* on Windows Server 2012.  
  
## Who Should Read This Guide  
The *Hyper\-V Security Guide* is primarily for IT professionals, security professionals, systems architects, computer engineers, and other IT consultants who plan application or infrastructure development and deployments of Windows Server 2012 for servers in an enterprise environment. The guide is not intended for home users. This guide is for individuals whose jobs may include one or more of the following roles:  
  
-   **Security professional.** Individuals in this role focus on how to provide security across computing platforms within an organization. Security professionals require a reliable reference guide that addresses the security needs of all segments of their organizations and also offers proven methods to implement security countermeasures. They identify security features and settings, and then provide recommendations on how their customers can most effectively use them in high risk environments.  
  
-   **IT operations and deployment staff.** Individuals in all of these roles troubleshoot security issues as well as application installation, configuration, usability, and manageability issues. They monitor these types of issues to define measurable security improvements with minimal impact on critical business applications. Individuals in IT operations focus on integrating security and controlling change in the deployment process, and deployment personnel focus on administering security updates quickly.  
  
-   **Systems architect and planner.** Individuals in this role drive the architecture efforts for computer systems in their organizations.  
  
-   **Consultant.** Individuals in this role are aware of security scenarios that span all the business levels of an organization. IT consultants from both Microsoft Services and partners take advantage of knowledge transfer tools for enterprise customers and partners.  
  
## Prerequisites  
The following knowledge and skills are required for consultants, operations, help desk and deployment staff, and security professionals who develop, deploy, and secure server systems running Windows Server 2012 in an enterprise organization:  
  
-   Experience using Hyper\-V Manager and System Center Virtual Machine Manager 2012.  
  
-   Detailed knowledge of the organization’s domain and Active Directory environments.  
  
-   Experience in the administration of Group Policy using the Group Policy Management Console \(GPMC\), which provides a single solution for managing all Group Policy–related tasks.  
  
-   Experience using management tools including Microsoft Management Console \(MMC\), Gpupdate, and Gpresult.  
  
-   Experience using the Security Configuration Wizard \(SCW\).  
  
-   Experience deploying applications and server computers in enterprise environments.  
  
## Chapter Summaries  
This release of the *Hyper\-V Security Guide* consists of this Overview and chapters that discuss methods and best practices that will help you secure your Hyper\-V environment. Brief descriptions follow for each chapter.  
  
**[Chapter 1: Overview](../Topic/Chapter-1--Overview.md)**  
  
This chapter provides necessary prerequisite information on Hyper\-V to set the groundwork for subsequent material. In addition to the architecture of Hyper\-V it also covers the administrator taxonomy in Hyper\-V.  
  
**[Chapter 2: Hardening the Hyper\-V host](../Topic/Chapter-2--Hardening-the-Hyper-V-host.md)**  
  
This chapter focuses on hardening servers that run the Hyper\-V role of Windows Server 2012, in both Full and Server Core installations. It contains security best practice recommendations to help protect against unauthorized access and resource tampering.  
  
**[Chapter 3: Roles & Delegation](../Topic/Chapter-3--Roles---Delegation.md)**  
  
This chapter covers details on delegation of access to resources. Additionally, it includes guidance on effective delegation of administrative roles to ensure security.  
  
**[Chapter 4: Protecting Virtual Machines](../Topic/Chapter-4--Protecting-Virtual-Machines.md)**  
  
This chapter provides prescriptive guidance for securing virtual machine resources. It discusses best practices and includes detailed steps for protecting virtual machines by using a combination of file system permissions, encryption, and auditing. Also included are resources for hardening and updating the operating system instances running within your virtual machines.  
  
**[Chapter 5: Best Practices Checklist](../Topic/Chapter-5--Best-Practices-Checklist.md)**  
  
The chapter covers recommended best practices that help enhance the security of a Hyper\-V deployment.  
  
