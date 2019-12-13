---
ms.assetid: 8f994e2e-6c07-43f0-aef4-75f8b2c9a144
title: Maintaining a More Secure Environment
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Maintaining a More Secure Environment

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

*Law Number Ten: Technology is not a panacea.* - [10 Immutable Laws of Security Administration](https://technet.microsoft.com/library/cc722488.aspx)  
  
When you have created a manageable, secure environment for your critical business assets, your focus should shift to ensuring that it is maintained securely. Although you've been given specific technical controls to increase the security of your AD DS installations, technology alone will not protect an environment in which IT does not work in partnership with the business to maintain a secure, usable infrastructure. The high level recommendations in this section are meant to be used as guidelines that you can use to develop not only effective security, but effective lifecycle management.  
  
In some cases, your IT organization might already have a close working relationship with business units, which will ease implementing these recommendations. In organizations in which IT and business units are not closely tied, you might need to first obtain executive sponsorship for efforts to forge a closer relationship between IT and business units. The [Executive Summary](../../../ad-ds/manage/component-updates/Executive-Summary.md) is intended to be useful as a standalone document for executive review, and it can be disseminated to decision makers in your organization.  
  
## Creating Business-Centric Security Practices for Active Directory  
In the past, information technology within many organizations was viewed as a support structure and a cost center. IT departments were often largely segregated from business users, and interactions limited to a request-response model in which the business requested resources and IT responded.  
  
As technology has evolved and proliferated, the vision of "a computer on every desktop" has effectively come to pass for much of the world, and even been eclipsed by the broad range of easily accessible technologies available today. Information technology is no longer a support function, it is a core business function. If your organization could not continue to function if all IT services were unavailable, your organization's business is, at least in part, information technology.  
  
To create effective compromise recovery plans, IT services must work closely with business units in your organization to identify not only the most critical components of the IT landscape, but the critical functions required by the business. By identifying what is important to your organization as a whole, you can focus on securing the components that have the most value. This is not a recommendation to shirk the security of low value systems and data. Rather, like you define levels of service for system uptime, you should consider defining levels of security control and monitoring based on criticality of asset.  
  
When you have invested in creating a current, secure, manageable environment, you can shift focus to managing it effectively and ensuring that you have effective lifecycle management processes that aren't determined only by IT, but by the business. To achieve this, you need not only to partner with the business, but to invest the business in "ownership" of data and systems in Active Directory.  
  
When data and systems are introduced into Active Directory without designated owners, business owners and IT owners, there is no clear chain of responsibility for the provisioning, management, monitoring, updating, and eventually decommissioning the system. This results in infrastructures in which systems expose the organization to risk but cannot be decommissioned because ownership is unclear. To effectively manage the lifecycle of the users, data, applications, and systems managed by your Active Directory installation, you should follow the principles described in this section.  
  
### Assign a Business Owner to Active Directory Data  
Data in Active Directory should have an identified business owner, that is, a specified department or user who is the point of contact for decisions about the lifecycle of the asset. In some cases, the business owner of a component of Active Directory will be an IT department or user. Infrastructure components such as domain controllers, DHCP and DNS servers, and Active Directory will most likely be "owned" by IT. For data that is added to AD DS to support the business (for example, new employees, new applications, and new information repositories), a designated business unit or user should be associated with the data.  
  
Whether you use Active Directory to record ownership of data in the directory, or whether you implement a separate database for tracking IT assets, no user account should be created, no server or workstation should be installed, and no application should be deployed without a designated owner of record. Trying to establish ownership of systems after they've been deployed in production can be challenging at best, and impossible in some cases. Therefore, ownership should be established at the time the data is introduced into Active Directory.  
  
### Implement Business-Driven Lifecycle Management  
Lifecycle management should be implemented for all data in Active Directory. For example, when a new application is introduced into an Active Directory domain, the application's business owner should, at regular intervals, be expected to attest to the continued use of the application. When a new version of an application is released, the application's business owner should be informed and should decide if and when the new version will be implemented.  
  
If a business owner chooses not to approve deployment of a new version of an application, that business owner should also be notified of the date when the current version will no longer be supported and should be responsible for determining whether the application will be decommissioned or replaced. Keeping legacy applications running and unsupported should not be an option.  
  
When user accounts are created in Active Directory, their managers of record should be notified at object creation and required to attest to the validity of the account at regular intervals. By implementing a business driven lifecycle and regular attestation of the validity of the data, the people who are best equipped to identify anomalies in the data are the people who review the data.  
  
For example, attackers might create user accounts that appear to be valid accounts, following your organization's naming conventions and object placement. To detect these account creations, you might implement a daily task that returns all user objects without a designated business owner so that you can investigate the accounts. If attackers create accounts and assign a business owner, by implementing a task that reports new object creation to the designated business owner, the business owner can quickly identify whether the account is legitimate.  
  
You should implement similar approaches to security and distribution groups. Although some groups may be functional groups created by IT, by creating every group with a designated owner, you can retrieve all groups owned by a designated user and require the user to attest to the validity of their memberships. Similar to the approach taken with user account creation, you can trigger reporting group modifications to the designated business owner. The more routine it becomes for a business owner to attest to the validity or invalidity of data in Active Directory, the more equipped you are to identify anomalies that can indicate process failures or actual compromise.  
  
### Classify all Active Directory Data  
In addition to recording a business owner for all Active Directory data at the time it is added to the directory, you should also require business owners to provide classification for the data. For example, if an application stores business-critical data, the business owner should label the application as such, in accordance with your organization's classification infrastructure.  
  
Some organizations implement data classification policies that label data according to the damage that exposure of the data would incur if it were stolen or exposed. Other organizations implement data classification that labels data by criticality, by access requirements, and by retention. Regardless of the data classification model in use in your organization, you should ensure that you are able to apply classification to Active Directory data, not only to "file" data. If a user's account is a VIP account, it should be identified in your asset classification database (whether you implement this via the use of attributes on the objects in AD DS, or whether you deploy separate asset classification databases).  
  
Within your data classification model, you should include classification for AD DS data such as the following.  
  
### Systems  
You should not only classify data, but also their server populations. For each server, you should know what operating system is installed, what general roles the server provides, what applications are running on the server, the IT owner of record, and the business owner of record, where applicable. For all data or applications running on the server, you should require classification, and the server should be secured according to the requirements for the workloads it supports and the classifications applied to the system and data. You can also group servers by the classification of their workloads, which allows you to quickly identify the servers that should be the most closely monitored and most stringently configured.  
  
### Applications  
You should classify applications by functionality (what they do), user base (who uses the applications), and the operating system on which they run. You should maintain records that contain version information, patch status, and any other pertinent information. You should also classify applications by the types of data they handle, as previously described.  
  
### Users  
Whether you call them "VIP" users, critical accounts, or use a different label, the accounts in your Active Directory installations that are most likely to be targeted by attackers should be tagged and monitored. In most organizations, it is simply not feasible to monitor all of the activities of all users. However, if you are able to identify the critical accounts in your Active Directory installation, you can monitor those accounts for changes as described earlier in this document.  
  
You can also begin to build a database of "expected behaviors" for these accounts as you audit the accounts. For example, if you find that a given executive uses his secured workstation to access business-critical data from his office and from his home, but rarely from other locations, if you see attempts to access data by using his account from an unauthorized computer or a location halfway around the planet where you know the executive is not currently located, you can more quickly identify and investigate this anomalous behavior.  
  
By integrating business information with your infrastructure, you can use that business information to help you identify false positives. For example, if executive travel is recorded in a calendar that is accessible to IT staff responsible for monitoring the environment, you can correlate connection attempts with the executives' known locations.  
  
Let's say Executive A is normally located in Chicago and uses a secured workstation to access business-critical data from his desk, and an event is triggered by a failed attempt to access the data from an unsecured workstation located in Atlanta. If you are able to verify that the executive is currently in Atlanta, you can resolve the event by contacting the executive or the executive's assistant to determine if the access failure was the result of the executive forgetting to use the secured workstation to access the data. By constructing a program that uses the approaches described in [Planning for Compromise](../../../ad-ds/plan/security-best-practices/Planning-for-Compromise.md), you can begin to build a database of expected behaviors for the most "important" accounts in your Active Directory installation that can potentially help you more quickly discover and respond to attacks.  
  


