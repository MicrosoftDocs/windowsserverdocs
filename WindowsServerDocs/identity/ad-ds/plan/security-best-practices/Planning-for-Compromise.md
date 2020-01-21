---
ms.assetid: 6f50476c-a1f1-48fb-999b-76c4c3816496
title: Planning for Compromise
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Planning for Compromise

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

*Law Number One: Nobody believes anything bad can happen to them, until it does.* - [10 Immutable Laws of Security Administration](https://technet.microsoft.com/library/cc722488.aspx)  
  
Disaster recovery plans in many organizations focus on recovering from regional disasters or failures that result in loss of computing services. However, when working with compromised customers, we often find that recovering from intentional compromise is absent in their disaster recovery plans. This is particularly true when the compromise results in theft of intellectual property or intentional destruction that leverages logical boundaries (such as destruction of all Active Directory domains or all servers) rather than physical boundaries (such as destruction of a datacenter). Although an organization may have incident response plans that define initial activities to take when a compromise is discovered, these plans often omit steps to recover from a compromise that affects the entire computing infrastructure.  
  
Because Active Directory provides rich identity and access management capabilities for users, servers, workstations, and applications, it is invariably targeted by attackers. If an attacker gains highly privileged access to an Active Directory domain or domain controller, that access can be leveraged to access, control, or even destroy the entire Active Directory forest.  
  
This document has discussed some of the most common attacks against Windows and Active Directory and countermeasures you can implement to reduce your attack surface, but the only sure way to recover in the event of a complete compromise of Active Directory is to be prepared for the compromise before it happens. This section focuses less on technical implementation details than previous sections of this document, and more on high-level recommendations that you can use to create a holistic, comprehensive approach to secure and manage your organization's critical business and IT assets.  
  
Whether your infrastructure has never been attacked, has resisted attempted breaches, or has succumbed to attacks and been fully compromised, you should plan for the inevitable reality that you will be attacked again and again. It is not possible to prevent attacks, but it may indeed be possible to prevent significant breaches or wholesale compromise. Every organization should closely evaluate their existing risk management programs, and make necessary adjustments to help reduce their overall level of vulnerability by making balanced investments in prevention, detection, containment, and recovery.  
  
To create effective defenses while still providing services to the users and businesses that depend on your infrastructure and applications, you may need to consider novel ways to prevent, detect, and contain compromise in your environment, and then recover from the compromise. The approaches and recommendations in this document may not help you repair a compromised Active Directory installation, but can help you secure your next one.  
  
Recommendations for recovering an Active Directory forest are presented in [Windows Server 2012: Planning for Active Directory Forest Recovery](https://www.microsoft.com/download/details.aspx?id=16506). You may be able to prevent your new environment from being completely compromised, but even if you can't, you will have tools to recover and regain control of your environment.  
  
## Rethinking the Approach  
*Law Number Eight: The difficulty of defending a network is directly proportional to its complexity.* - [10 Immutable Laws of Security Administration](https://technet.microsoft.com/library/cc722488.aspx)  
  
It is generally well-accepted that if an attacker has obtained SYSTEM, Administrator, root, or equivalent access to a computer, regardless of operating system, that computer can no longer be considered trustworthy, no matter how many efforts are made to "clean" the system. Active Directory is no different. If an attacker has obtained privileged access to a domain controller or a highly privileged account in Active Directory, unless you have a record of every modification the attacker makes or a known good backup, you can never restore the directory to a completely trustworthy state.  
  
When a member server or a workstation is compromised and altered by an attacker, the computer is no longer trustworthy, but neighboring uncompromised servers and workstations can still be trusted. Compromise of one computer does not imply that all computers are compromised.  
  
However, in an Active Directory domain, all domain controllers host replicas of the same AD DS database. If a single domain controller is compromised and an attacker modifies the AD DS database, those modifications replicate to every other domain controller in the domain, and depending on the partition in which the modifications are made, the forest. Even if you reinstall every domain controller in the forest, you are simply reinstalling the hosts on which the AD DS database resides. Malicious modifications to Active Directory will replicate to freshly installed domain controllers as easily as they will replicate to domain controllers that have been running for years.  
  
In assessing compromised environments, we commonly find that what was believed to be the first breach "event" was actually triggered after weeks, months, or even years after attackers had initially compromised the environment. Attackers usually obtained the credentials for highly privileged accounts long before a breach was detected, and they leveraged those accounts to compromise the directory, domain controllers, member servers, workstations, and even connected non-Windows systems.  
  
These findings are consistent with several findings in Verizon's 2012 Data Breach Investigations Report, which states that:  
  
-   98 percent of data breaches stemmed from external agents  
  
-   85 percent of data breaches took weeks or more to discover  
  
-   92 percent of incidents were discovered by a third party, and  
  
-   97 percent of breaches were avoidable though simple or intermediate controls.  
  
A compromise to the degree described earlier is effectively irreparable, and the standard advice to "flatten and rebuild" every compromised system is simply not feasible or even possible if Active Directory has been compromised or destroyed. Even restoring to a known good state does not eliminate the flaws that allowed the environment to be compromised in the first place.  
  
Although you must defend every facet of your infrastructure, an attacker only needs to find enough flaws in your defenses to get to their desired goal. If your environment is relatively simple and pristine, and historically well-managed, then implementing the recommendations provided earlier in this document may be a straightforward proposition.  
  
However, we have found that the older, larger, and more complex the environment, the more likely it is that the recommendations in this document will be infeasible or even impossible to implement. It is much harder to secure an infrastructure after the fact than it is to start fresh and to construct an environment that is resistant to attack and compromise. But as previously noted, it is no small undertaking to rebuild an entire Active Directory forest. For these reasons, we recommend a more focused, targeted approach to secure your Active Directory forests.  
  
Rather than focusing on and trying to fix all of the things that are "broken," consider an approach in which you prioritize based on what is most important to your business and in your infrastructure. Instead of trying to remediate an environment filled with outdated, misconfigured systems and applications, consider creating a new small, secure environment into which you can safely port the users, systems, and information that are most critical to your business.  
  
In this section, we describe an approach by which you can create a pristine AD DS forest that serves as a "life boat" or "secure cell" for your core business infrastructure. A pristine forest is simply a newly installed Active Directory forest that is typically limited in size and scope, and which is built by using current operating systems, applications, and with the principles described in [Reducing the Active Directory Attack Surface](../../../ad-ds/plan/security-best-practices/../../../ad-ds/plan/security-best-practices/Reducing-the-Active-Directory-Attack-Surface.md).  
  
By implementing the recommended configuration settings in a newly built forest, you can create an AD DS installation that is built from the ground up with secure settings and practices, and you can reduce the challenges that accompany supporting legacy systems and applications. While detailed instructions for the design and implementation of a pristine AD DS installation are outside the scope of this document, you should follow some general principles and guidelines to create a "secure cell" into which you can house your most critical assets. These guidelines are as follows:  
  
1.  Identify principles for segregating and securing critical assets.  
  
2.  Define a limited, risk-based migration plan.  
  
3.  Leverage "nonmigratory" migrations where necessary.  
  
4.  Implement "creative destruction."  
  
5.  Isolate legacy systems and applications.  
  
6.  Simplify security for end users.  
  
### Identifying Principles for Segregating and Securing Critical Assets  

The characteristics of the pristine environment that you create to house critical assets can vary widely. For example, you may choose to create a pristine forest into which you migrate only VIP users and sensitive data that only those users can access. You may create a pristine forest in which you migrate not only VIP users, but which you implement as an administrative forest, implementing the principles described in [Reducing the Active Directory Attack Surface](../../../ad-ds/plan/security-best-practices/../../../ad-ds/plan/security-best-practices/Reducing-the-Active-Directory-Attack-Surface.md) to create secure administrative accounts and hosts that can be used to manage your legacy forests from the pristine forest. You might implement a "purpose-built" forest that houses VIP accounts, privileged accounts, and systems requiring additional security such as servers running Active Directory Certificate Services (AD CS) with the sole goal of segregating them from less-secure forests. Finally, you might implement a pristine forest that becomes the de facto location for all new users, systems, applications and data, allowing you to eventually decommission your legacy forest via attrition.  
  
Regardless of whether your pristine forest contains a handful of users and systems or it forms the basis for a more aggressive migration, you should follow these principles in your planning:  
  
1.  Assume that your legacy forests have been compromised.  
  
2.  Do not configure a pristine environment to trust a legacy forest, although you can configure a legacy environment to trust a pristine forest.  
  
3.  Do not migrate user accounts or groups from a legacy forest to a pristine environment if there is a possibility that the accounts' group memberships, SID history, or other attributes may have been maliciously modified. Instead, use "nonmigratory" approaches to populate a pristine forest. (Nonmigratory approaches are described later in this section.)  
  
4.  Do not migrate computers from legacy forests to pristine forests. Implement freshly installed servers in the pristine forest, install applications on the freshly installed servers, and migrate application data to the newly installed systems. For file servers, copy data to freshly installed servers, set ACLs by using users and groups in the new forest, and then create print servers in a similar fashion.  
  
5.  Do not permit the installation of legacy operating systems or applications in the pristine forest. If an application cannot be updated and freshly installed, leave it in the legacy forest and consider creative destruction to replace the application's functionality.  
  
### Defining a Limited, Risk-Based Migration Plan  
Creating a limited, risk-based migration plan simply means that when deciding which users, applications, and data to migrate into your pristine forest, you should identify migration targets based on the degree of risk to which your organization is exposed if one of the users or systems is compromised. VIP users whose accounts are most likely to be targeted by attackers should be housed in the pristine forest. Applications that provide vital business functions should be installed on freshly built servers in the pristine forest, and highly sensitive data should be moved to secured servers in the pristine forest.  
  
If you do not already have a clear picture of the most business-critical users, systems, applications, and data in your Active Directory environment, work with business units to identify them. Any application required for the business to operate should be identified, as should any servers on which critical applications run or critical data is stored. By identifying the users and resources that are required for your organization to continue to function, you create a naturally prioritized collection of assets on which to focus your efforts.  
  
### Leveraging "Nonmigratory" Migrations  
Whether you know that your environment has been compromised, suspect that it has been compromised, or simply prefer not to migrate legacy data and objects from a legacy Active Directory installation to a new one, consider migration approaches that do not technically "migrate" objects.  
  
### User Accounts  
In a traditional Active Directory migration from one forest to another, the SIDHistory (SID history) attribute on user objects is used to store users' SID and the SIDs of groups that users were members of in the legacy forest. If users accounts are migrated to a new forest, and they access resources in the legacy forest, the SIDs in the SID history are used to create an access token that allows the users to access resources to which they had access before the accounts were migrated.  
  
Maintaining SID history, however, has proven problematic in some environments because populating users' access tokens with current and historical SIDs can result in token bloat. Token bloat is an issue in which the number of SIDs that must be stored in a user's access token uses or exceeds the amount of space available in the token.  
  
Although token sizes can be increased to a limited extent, the ultimate solution to token bloat is to reduce the number of SIDs associated with user accounts, whether by rationalizing group memberships, eliminating SID history, or a combination of both. For more information about token bloat, see [MaxTokenSize and Kerberos Token Bloat](https://blogs.technet.com/b/shanecothran/archive/2010/07/16/maxtokensize-and-kerberos-token-bloat.aspx).  
  
Rather than migrating users from a legacy environment (particularly one in which group memberships and SID histories may be compromised) by using SID history, consider leveraging metadirectory applications to "migrate" users, without carrying SID histories into the new forest. When user accounts are created in the new forest, you can use a metadirectory application to map the accounts to their corresponding accounts in the legacy forest.  
  
To provide the new user accounts access to resources in the legacy forest, you can use the metadirectory tooling to identify resource groups into which the users' legacy accounts were granted access, and then add the users' new accounts to those groups. Depending on your group strategy in the legacy forest, you may need to create domain local groups for resource access or convert existing groups to domain local groups to allow the new accounts to be added to resource groups. By focusing first on the most critical applications and data and migrating them to the new environment (with or without SID history), you can limit the amount of effort expended in the legacy environment.  
  

  
### Servers and Workstations  
In a traditional migration from one Active Directory forest to another, migrating computers is often relatively simple compared to migrating users, groups, and applications. Depending on the computer role, migrating to a new forest can be as simple as disjoining an old domain and joining a new one. However, migrating computer accounts intact into a pristine forest defeats the purpose of creating a fresh environment. Rather than migrating (potentially compromised, misconfigured, or outdated) computer accounts to a new forest, you should freshly install servers and workstations in the new environment. You can migrate data from systems in the legacy forest to systems in the pristine forest, but not the systems that house the data.  
  
### Applications  

Applications can present the most significant challenge in any migration from one forest to another, but in the case of a "nonmigratory" migration, one of the most basic principles you should apply is that applications in the pristine forest should be current, supported, and freshly installed. Data can be migrated from application instances in the old forest where possible. In situations in which an application cannot be "recreated" in the pristine forest, you should consider approaches such as creative destruction or isolation of legacy applications as described in the following section.  
  
### Implementing Creative Destruction  
Creative destruction is an economics term that describes economic development created by the destruction of a prior order. In recent years, the term has been applied to information technology. It typically refers to mechanisms by which old infrastructure is eliminated, not by upgrading it, but by replacing it with something altogether new. The 2011 [Gartner Symposium ITXPO](http://www.gartner.com/technology/symposium/orlando/) for CIOs and senior IT executives presented creative destruction as one of its key themes for cost reduction and increases in efficiency. Improvements in security are possible as a natural outgrowth of the process.  

For example, an organization may be composed of multiple business units that use a different application that performs similar functionality, with varying degrees of modernity and vendor support. Historically, IT might be responsible for maintaining each business unit's application separately, and consolidation efforts would consist of attempting to figure out which application offered the best functionality and then migrating data into that application from the others.  
  
In creative destruction, rather than maintaining outdated or redundant applications, you implement entirely new applications to replace the old, migrate data into the new applications, and decommission the old applications and the systems on which they run. In some cases, you can implement creative destruction of legacy applications by deploying a new application in your own infrastructure, but wherever possible, you should consider porting the application to a cloud-based solution instead.  
  
By deploying cloud-based applications to replace legacy in-house applications, you not only reduce maintenance efforts and costs, but you reduce your organization's attack surface by eliminating legacy systems and applications that present vulnerabilities for attackers to leverage. This approach provides a faster way for an organization to obtain desired functionality while simultaneously eliminating legacy targets in the infrastructure. Although the principle of creative destruction does not apply to all IT assets, it provides an often viable option to eliminating legacy systems and applications while simultaneously deploying robust, secure, cloud-based applications.  
  
### Isolating Legacy Systems and Applications  
A natural outgrowth of migrating your business-critical users and systems to a pristine, secure environment is that your legacy forest will be contain less valuable information and systems. Although the legacy systems and applications that remain in the less secure environment may present elevated risk of compromise, they also represent a reduced severity of compromise. By rehoming and modernizing your critical business assets, you can focus on deploying effective management and monitoring while not needing to accommodate legacy settings and protocols.  
  
When you have rehomed your critical data to a pristine forest, you can evaluate options to further isolating legacy systems and applications in your "main" AD DS forest. Although you might implement creative destruction to replace one application and the servers on which it runs, in other cases you might consider additional isolation of the least secure systems and applications. For example, an application that is used by a handful of users, but which requires legacy credentials like LAN Manager hashes can be migrated to a small domain you create to support systems for which you have no replacement options.  
  
By removing these systems from domains where they forced implementation of legacy settings, you can subsequently increase the security of the domains by configuring them to support only current operating systems and applications. Although, it is preferable to decommission legacy systems and applications whenever possible. If decommissioning is simply not feasible for a small segment of your legacy population, segregating it into a separate domain (or forest) allows you to perform incremental improvements in the rest of the legacy installation.  
  
### Simplifying Security for End Users  
In most organizations, users who have access to the most sensitive information due to the nature of their roles in the organization often have the least amount of time to devote to learning complex access restrictions and controls. Although you should have a comprehensive security education program for all users in your organization, you should also focus on making security as simple to use as possible by implementing controls that are transparent and simplifying principles to which users adhere.  
  
For example, you may define a policy in which executives and other VIPs are required to use secure workstations to access sensitive data and systems, allowing them to use their other devices to access less sensitive data. This is a simple principle for users to remember, but you can implement a number of backend controls to help to enforce the approach.  

You can use [Authentication Mechanism Assurance](https://technet.microsoft.com/library/dd391847(v=WS.10).aspx) to permit the users to access sensitive data only if they've logged on to their secure systems using their smart cards, and can use IPsec and user rights restrictions to control the systems from which they can connect to sensitive data repositories. You can use the [Microsoft Data Classification Toolkit](https://www.microsoft.com/download/details.aspx?id=27123) to build a robust file classification infrastructure, and you can implement [Dynamic Access Control](https://blogs.technet.com/b/windowsserver/archive/2012/05/22/introduction-to-windows-server-2012-dynamic-access-control.aspx) to restrict access to data based on characteristics of an access attempt, translating business rules into technical controls.  
  
From the perspective of the user, accessing sensitive data from a secured system "just works," and attempting to do so from an unsecured system "just doesn't." However, from the perspective of monitoring and managing your environment, you're helping to create identifiable patterns in how users access sensitive data and systems, making it easier for you to detect anomalous access attempts.  
  
In environments in which user resistance to long, complex passwords has resulted in insufficient password policies, particularly for VIP users, consider alternate approaches to authentication, whether via smart cards (which come in a number of form factors and with additional features to strengthen authentication), biometric controls such as finger-swipe readers, or even authentication data that is secured by trusted platform module (TPM) chips in users' computers. Although multifactor authentication does not prevent credential theft attacks if a computer is already compromised, by giving your users easy-to-use authentication controls, you can assign more robust passwords to the accounts of users for whom traditional user name and password controls are unwieldy.  
