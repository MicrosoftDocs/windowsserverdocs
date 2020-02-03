---
ms.assetid: 85ca191c-0cc7-4453-a72c-42060ddf2ea2
title: Executive Summary
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/08/2018
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Executive Summary

>Applies To: Windows Server 2012

>[!IMPORTANT] 
>The following documentation was written in 2013 and is provided for historical purposes only.  Currently we are reviewing this documentation and it is subject to change.  It may not reflect current best practices.

No organization with an information technology (IT) infrastructure is immune from attack, but if appropriate policies, processes, and controls are implemented to protect key segments of an organization's computing infrastructure, it might be possible to prevent a breach event from growing to a wholesale compromise of the computing environment.  
  
This executive summary is intended to be useful as a standalone document summarizing the content of the document, which contains recommendations that will assist organizations in enhancing the security of their Active Directory installations. By implementing these recommendations, organizations will be able to identify and prioritize security activities, protect key segments of their organization's computing infrastructure, and create controls that significantly decrease the likelihood of successful attacks against critical components of the IT environment.  
  
Although this document discusses the most common attacks against Active Directory and countermeasures to reduce the attack surface, it also contains recommendations for recovery in the event of complete compromise. The only sure way to recover in the event of a complete compromise of Active Directory is to be prepared for the compromise before it happens.  
  
The major sections of this document are:  
  
-   Avenues to Compromise  
  
-   Reducing the Active Directory Attack Surface  
  
-   Monitoring Active Directory for Signs of Compromise  
  
-   Planning for Compromise  
  
## Avenues to Compromise  
This section provides information about some of the most commonly leveraged vulnerabilities used by attackers to compromise customers' infrastructures. It contains general categories of vulnerabilities and how they're used to initially penetrate customers' infrastructures, propagate compromise across additional systems, and eventually target Active Directory and domain controllers to obtain complete control of the organizations' forests. It does not provide detailed recommendations about addressing each type of vulnerability, particularly in the areas in which the vulnerabilities are not used to directly target Active Directory. However, for each type of vulnerability, we have provided links to additional information to use to develop countermeasures and reduce the organization's attack surface.  
  
Included are the following subjects:  
  
-   **Initial breach targets** - Most information security breaches start with the compromise of small pieces of an organization's infrastructure-often one or two systems at a time. These initial events, or entry points into the network, often exploit vulnerabilities that could have been fixed, but weren't. Commonly seen vulnerabilities are:  
  
    -   Gaps in antivirus and antimalware deployments  
  
    -   Incomplete patching  
  
    -   Outdated applications and operating systems  
  
    -   Misconfiguration  
  
    -   Lack of secure application development practices  
  
-   **Attractive Accounts for Credential Theft** - Credential theft attacks are those in which an attacker initially gains privileged access to a computer on a network and then uses freely available tooling to extract credentials from the sessions of other logged-on accounts.   
    Included in this section are the following:  
  
    -   **Activities that Increase the Likelihood of Compromise** - Because the target of credential theft is usually highly privileged domain accounts and "very important person" (VIP) accounts, it is important for administrators to be conscious of activities that increase the likelihood of a success of a credential-theft attack. These activities are:  
  
        -   Logging on to unsecured computers with privileged accounts  
  
        -   Browsing the Internet with a highly privileged account  
  
        -   Configuring local privileged accounts with the same credentials across systems  
  
        -   Overpopulation and overuse of privileged domain groups  
  
        -   Insufficient management of the security of domain controllers.  
  
    -   **Privilege Elevation and Propagation** - Specific accounts, servers, and infrastructure components are usually the primary targets of attacks against Active Directory. These accounts are:  
  
        -   Permanently privileged accounts  
  
        -   VIP accounts  
  
        -   "Privilege-Attached" Active Directory accounts  
  
        -   Domain controllers  
  
        -   Other infrastructure services that affect identity, access, and configuration management, such as public key infrastructure (PKI) servers and systems management servers  
  
## Reducing the Active Directory Attack Surface  
This section focuses on technical controls to reduce the attack surface of an Active Directory installation. Included in this section are the following subjects:  
  
-   The **Privileged Accounts and Groups in Active Directory** section discusses the highest privileged accounts and groups in Active Directory and the mechanisms by which privileged accounts are protected. Within Active Directory, three built-in groups are the highest privilege groups in the directory (Enterprise Admins, Domain Admins, and Administrators), although a number of additional groups and accounts should also be protected.  
  
-   The **Implementing Least-Privilege Administrative Models** section focuses on identifying the risk that the use of highly privileged accounts for day-to-day administration presents, in addition to providing recommendations to reduce that risk.  
  
Excessive privilege isn't only found in Active Directory in compromised environments. When an organization has developed the habit of granting more privilege than is required, it is typically found throughout the infrastructure:  
  
-   In Active Directory  
  
-   On member servers  
  
-   On workstations  
  
-   In applications  
  
-   In data repositories  
  
-   The **Implementing Secure Administrative Hosts** section describes secure administrative hosts, which are computers that are configured to support administration of Active Directory and connected systems. These hosts are dedicated to administrative functionality and do not run software such as email applications, web browsers, or productivity software (such as Microsoft Office).  
  
Included in this section are the following:  
  
-   **Principles for Creating Secure Administrative Hosts** - The general principles to keep in mind are:  
  
    -   Never administer a trusted system from a less-trusted host.  
  
    -   Do not rely on a single authentication factor when performing privileged activities.  
  
    -   Do not forget physical security when designing and implementing secure administrative hosts.  
  
-   **Securing Domain Controllers Against Attack** - If a malicious user obtains privileged access to a domain controller, that user can modify, corrupt, and destroy the Active Directory database, and by extension, all of the systems and accounts that are managed by Active Directory.  
  
Included in this section are the following subjects:  
  
-   **Physical Security for Domain Controllers** - Contains recommendations for providing physical security for domain controllers in datacenters, branch offices, and remote locations.  
  
-   **Domain Controller Operating Systems** - Contains recommendations for securing the domain controller operating systems.  
  
-   **Secure Configuration of Domain Controllers** - Native and freely available configuration tools and settings can be used to create security configuration baselines for domain controllers that can subsequently be enforced by Group Policy Objects (GPOs).  
  
## Monitoring Active Directory for Signs of Compromise  
This section provides information about legacy audit categories and audit policy subcategories (which were introduced in Windows Vista and Windows Server 2008), and Advanced Audit Policy (which was introduced in Windows Server 2008 R2). Also provided is information about events and objects to monitor that can indicate attempts to compromise the environment and some additional references that can be used to construct a comprehensive audit policy for Active Directory.  
  
Included in this section are the following subjects:  
  
-   **Windows Audit Policy** - Windows security event logs have categories and subcategories that determine which security events are tracked and recorded.  
  
-   **Audit Policy Recommendations** - This section describes the Windows default audit policy settings, audit policy settings that are recommended by Microsoft, and more aggressive recommendations for organizations to use to audit critical servers and workstations.  
  
## Planning for Compromise  
This section contains recommendations that will help organizations prepare for a compromise before it happens, implement controls that can detect a compromise event before a full breach has occurred, and provide response and recovery guidelines for cases in which a complete compromise of the directory is achieved by attackers. Included in this section are the following subjects:  
  
-   **Rethinking the Approach** - Contains principles and guidelines to create secure environments into which an organization can place their most critical assets. These guidelines are as follows:  
  
    -   Identifying principles for segregating and securing critical assets  
  
    -   Defining a limited, risk-based migration plan  
  
    -   Leveraging "nonmigratory" migrations where necessary  
  
    -   Implementing "creative destruction"  
  
    -   Isolating legacy systems and applications  
  
    -   Simplifying security for end users  
  
-   **Maintaining a More Secure Environment** - Contains high-level recommendations meant to be used as guidelines to use in developing not only effective security, but effective lifecycle management. Included in this section are the following subjects:  
  
    -   **Creating Business-Centric Security Practices for Active Directory** - To effectively manage the lifecycle of the users, data, applications and systems managed by Active Directory, follow these principles.  
  
        -   **Assign a Business Ownership to Active Directory Data** - Assign ownership of infrastructure components to IT; for data that is added to Active Directory Domain Services (AD DS) to support the business, for example, new employees, new applications, and new information repositories, a designated business unit or user should be associated with the data.  
  
        -   **Implement Business-Driven Lifecycle Management** - Lifecycle management should be implemented for data in Active Directory.  
  
        -   **Classify all Active Directory Data** - Business owners should provide classification for data in Active Directory. Within the data classification model, classification for the following Active Directory data should be included:  
  
            -   **Systems** - Classify server populations, their operating system, their role, the applications running on them, and the IT and business owners of record.  
  
            -   **Applications** - Classify applications by functionality, user base, and their operating system.  
  
            -   **Users** - The accounts in the Active Directory installations that are most likely to be targeted by attackers should be tagged and monitored.  
  
## Summary of Best Practices for Securing Active Directory Domain Services  
The following table provides a summary of the recommendations provided in this document for securing an AD DS installation. Some best practices are strategic in nature and require comprehensive planning and implementation projects; others are tactical and focused on specific components of Active Directory and related infrastructure.  
  
Practices are listed in approximate order of priority, that is., lower numbers indicate higher priority. Where applicable, best practices are identified as preventative or detective in nature. All of these recommendations should be thoroughly tested and modified as needed for your organization's characteristics and requirements.  
  
  
||**Best Practice**|**Tactical or Strategic**|**Preventative or Detective**|  
|-|-|-|-|  
|1|Patch applications.|Tactical|Preventative|  
|2|Patch operating systems.|Tactical|Preventative|  
|3|Deploy and promptly update antivirus and antimalware software across all systems and monitor for attempts to remove or disable it.|Tactical|Both|  
|4|Monitor sensitive Active Directory objects for modification attempts and Windows for events that may indicate attempted compromise.|Tactical|Detective|  
|5|Protect and monitor accounts for users who have access to sensitive data|Tactical|Both|  
|6|Prevent powerful accounts from being used on unauthorized systems.|Tactical|Preventative|  
|7|Eliminate permanent membership in highly privileged groups.|Tactical|Preventative|  
|8|Implement controls to grant temporary membership in privileged groups when needed.|Tactical|Preventative|  
|9|Implement secure administrative hosts.|Tactical|Preventative|  
|10|Use application whitelisting on domain controllers, administrative hosts, and other sensitive systems.|Tactical|Preventative|  
|11|Identify critical assets, and prioritize their security and monitoring.|Tactical|Both|  
|12|Implement least-privilege, role-based access controls for administration of the directory, its supporting infrastructure, and domain-joined systems.|Strategic|Preventative|  
|13|Isolate legacy systems and applications.|Tactical|Preventative|  
|14|Decommission legacy systems and applications.|Strategic|Preventative|  
|15|Implement secure development lifecycle programs for custom applications.|Strategic|Preventative|  
|16|Implement configuration management, review compliance regularly, and evaluate settings with each new hardware or software version.|Strategic|Preventative|  
|17|Migrate critical assets to pristine forests with stringent security and monitoring requirements.|Strategic|Both|  
|18|Simplify security for end users.|Strategic|Preventative|  
|19|Use host-based firewalls to control and secure communications.|Tactical|Preventative|  
|20|Patch devices.|Tactical|Preventative|  
|21|Implement business-centric lifecycle management for IT assets.|Strategic|N/A|  
|22|Create or update incident recovery plans.|Strategic|N/A|  
  


