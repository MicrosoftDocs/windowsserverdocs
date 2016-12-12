---
ms.assetid: e4b58d6a-c347-4b1c-8110-73c2d238305d
title: Appendix J - Third-Party RBAC Vendors
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 09/29/2016
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Appendix J: Third-Party RBAC Vendors

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


## Appendix J: Third-Party RBAC Vendors  

> [!NOTE]  
> Descriptions of software described in this appendix were obtained from the respective vendors' websites. No endorsement of or preference for any solution is intended or implied.  

## The Dot Net Factory  
[EmpowerID](http://www.empowerid.com/products/authorizationservices) includes an advanced authorization policy engine that allows organizations to define a user's access to a diverse set of corporate and cloud-hosted resources via flexible RBAC and ABAC rules. This "resultant access" information is then consumed or "pulled" by systems that support leveraging an external authorization engine to make access decisions or "pushed" down onto systems that don't.  

Examples of systems supporting the "pull" model are applications that can leverage SAML or WS-Trust Identity and Claims Providers or applications supporting the Microsoft .NET Membership and Role Provider. These would include applications like Microsoft SharePoint 2010, SaaS applications, and internally developed corporate applications. EmpowerID falls into the category of a system supporting "pull" or external authorization.  

Unfortunately, the majority of an enterprise's systems do not yet support external authorization. For these systems, access is defined and controlled within each application's security database or via ACLs. EmpowerID supports a "push" model for such cases in which the RBAC engine allows organizations to dynamically define who has access to these resources. The EmpowerID sync engine then enforces these policies by translating them into native system permissions or roles, pushing down the changes onto these systems. Additionally, the systems are monitored for permission changes so the EmpowerID engine can detect changes and roll them back when set up to do so. Examples of systems that require the "push" model are Windows Shared Folders, Group membership, Exchange mailboxes, custom database application roles and permissions, and directory ACLs.  

Powerful RBAC policies leverage EmpowerID's multitiered model to pre-calculate access to all known enterprise applications and resources based on an organization's structure, a person's job function, and all directly assigned access. These rules allow information from authoritative systems to drive changes in application access and provisioning policies.  

ABAC policies on the other hand, provide more fine-grained on-the-fly decisions regarding a user's access level and the actions they are authorized to perform. ABAC rules benefit from the ability to analyze contextual "in the moment" information to make decisions without the overhead and maintenance of an RBAC structure. However, ABAC rules are more limited in their use of an organization's structural information as they must real-time decisions and cannot wait for complex analyses or pre-compilation of hierarchical information from multiple sources. The EmpowerID authorization engine is a hybrid of the RBAC and ABAC models, leveraging the best of each. It offers RBAC authorization to leverage diverse information sources for automating role-based access control and ABAC authorization, which further refines RBAC access with fine-grained controls.  

### Key Features and Benefits:  

-   Manages and enforces access control for applications that support external authorization and for enterprise systems that require permissions to be pushed down onto them  

-   A powerful security model supporting Role-Based Access Control (RBAC), Attribute-Based Access Control (ABAC), and Separation of Duties enforcement (SoD)  

-   Reduces the time to market when developing new applications by eliminating the need to write complex security code into each application  

-   Supports enterprise compliance initiatives by centralizing authorization into an auditable system  

-   Reduces risk by reducing the number of places where security logic is maintained and can be modified  

-   Increases agility by reducing the impact of changes in infrastructure and application providers  

-   Standards-based support for SAML and WS-Trust applications such as Microsoft SharePoint 2010  

-   Unique Rights-Based Approval Routing (RBAR) technology automatically routes requests for approval based on delegations without hard-coded logic maintained inside workflows  

-   Fully programmable supporting integration with custom systems via connectors or a secure web services API  

## IBM  

### Domain RBAC  
[Role-based access control (RBAC)](http://pic.dhe.ibm.com/infocenter/aix/v7r1/index.jsp?topic=%2Fcom.ibm.aix.security%2Fdoc%2Fsecurity%2Fdomain_rbac.htm), introduced in AIX 6.1, provides a mechanism to split the various functions of the super user root into roles, which can be delegated to other users on the system. RBAC provides the facility to delegate duties and improves the security of the system because the auditing and tracking of activities on the system is easier. RBAC provide delegation of responsibility to another user (referred as an authorized user), but it does not provide a mechanism to limit the administrative rights of an authorized user to specific resources of the system. For example, a user that has network administrative rights can manage every network interface on the system. You cannot restrict the authorized user to modify a set of interfaces.  

The domain feature for RBAC is used to restrict access to authorized users. The users and resources of the system are labeled by attaching tags called domains, and the specific access rules determine access to resources by the users.  

## Oracle  

### Oracle Solaris RBAC Elements and Basic Concepts  
[The RBAC model](http://docs.oracle.com/cd/E19082-01/819-3321/6n5i4b7ap/index.html) in the Oracle Solaris Operating System introduces the following elements:  

**Authorization** - A permission that enables a user or role to perform a class of actions that require additional rights. For example, security policy at installation gives regular users the solaris.device.cdrw authorization. This authorization enables users to read and write to a CD-ROM device.  

**Privilege** - A discrete right that can be granted to a command, a user, a role, or a system. Privileges enable a process to succeed. For example, the proc_exec privilege allows a process to call execve(). Regular users have basic privileges.  

**Security attributes** - An attribute that enables a process to perform an operation. In a typical UNIX environment, a security attribute enables a process to perform an operation that is otherwise forbidden to regular users. For example, setuid and setgid programs have security attributes. In the RBAC model, authorizations and privileges are security attributes in addition to setuid and setgid programs. These attributes can be assigned to a user. For example, a user with the solaris.device.allocate authorization can allocate a device for exclusive use. Privileges can be placed on a process. For example, a process with the file_flag_set privilege can set immutable, no-unlink, or append-only file attributes.  

**Privileged application** - An application or command that can override system controls by checking for security attributes. In a typical UNIX environment and in the RBAC model, programs that use setuid and setgid are privileged applications. In the RBAC model, programs that require privileges or authorizations to succeed are also privileged applications.  

**Rights profile** - A collection of administrative capabilities that can be assigned to a role or to a user. A rights profile can consist of authorizations, of commands with security attributes, and of other rights profiles. Rights profiles offer a convenient way to group security attributes.  

**Role** - A special identity for running privileged applications. The special identity can be assumed by assigned users only. In a system that is run by roles, superuser is unnecessary. Superuser capabilities are distributed to different roles. For example, in a two-role system, security tasks would be handled by a security role. The second role would handle system administration tasks that are not security-related. Roles can be more fine-grained. For example, a system could include separate administrative roles for handling the cryptographic framework, printers, system time, file systems, and auditing.  

## Centrify  

### IT Security & Access Control  
Strengthen IT security with [Active Directory-centric access control](http://www.centrify.com/solutions/it-security-access-control.asp) and policy enforcement for UNIX, Linux and Mac systems and applications.  

### The Challenge  
One of the most difficult questions asked of IT security managers in cross-platform environments is: Can you prove which users have access to a specific business-critical system or application?  

For Linux and UNIX systems in particular, access controls might be stored in insecure legacy systems such as NIS or managed locally system by system. Passwords to superuser accounts may be shared among many individuals. Or a single user may have multiple identities across systems.  

### The Centrify Solution  
Centrify addresses this challenge by giving organizations a global view of access controls and user permissions, tied to a single, centrally managed Active Directory identity. With the Centrify Suite, you can:  

-   Associate all access rights and permissions on audited systems to individual Active Directory accounts  

-   Define logical sets of systems that can have their own authorized users, administrators, and security policies, with centralized reporting of who has access to what systems  

-   Implement role-based access controls and limit superuser privileges to only the set of commands they need to perform their jobs  

-   Add additional layers of security by isolating and protecting systems holding sensitive information.  

-   Capture detailed logs of all user actions, and system responses, to monitor for suspicious activity  

-   Globally enforce consistent security and configuration policies (via Windows Group Policy) across a heterogeneous enterprise  
