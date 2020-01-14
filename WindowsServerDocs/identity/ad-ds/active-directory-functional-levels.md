---
ms.assetid: f964d056-11bf-4d9b-b5ab-dceaad8bfbc3
title: Windows Server 2016 Functional Levels
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 10/29/2018
ms.topic: article
ms.prod: windows-server
ms.custom: it-pro
ms.reviewer: maheshu

ms.technology: identity-adds
---
# Forest and Domain Functional Levels

>Applies To: Windows Server

Functional levels determine the available Active Directory Domain Services (AD DS) domain or forest capabilities. They also determine which Windows Server operating systems you can run on domain controllers in the domain or forest. However, functional levels do not affect which operating systems you can run on workstations and member servers that are joined to the domain or forest.

When you deploy AD DS, set the domain and forest functional levels to the highest value that your environment can support. This way, you can use as many AD DS features as possible. When you deploy a new forest, you are prompted to set the forest functional level and then set the domain functional level. You can set the domain functional level to a value that is higher than the forest functional level, but you cannot set the domain functional level to a value that is lower than the forest functional level.

With the end of life of Windows 2003, Windows 2003 domain controllers (DCs) need to be updated to Windows Server 2008, 2008R2, 2012, 2012R2, 2016, or 2019. As a result, any domain controller that runs Windows Server 2003 should be removed from the domain.

At the Windows Server 2008 and higher domain functional levels, Distributed File Service (DFS) Replication is used to replicate SYSVOL folder contents between domain controllers. If you create a new domain at the Windows Server 2008 domain functional level or higher, DFS Replication is automatically used to replicate SYSVOL. If you created the domain at a lower functional level, you will need to migrate from using FRS to DFS replication for SYSVOL. For migration steps, you can either follow the [procedures on TechNet](https://technet.microsoft.com/library/dd640019(v=WS.10).aspx) or you can refer to the [streamlined set of steps on the Storage Team File Cabinet blog](https://blogs.technet.com/b/filecab/archive/2014/06/25/streamlined-migration-of-frs-to-dfsr-sysvol.aspx).

## Windows Server 2019

There are no new forest or domain functional levels added in this release.

The minimum requirement to add a Windows Server 2019 Domain Controller is a Windows Server 2008 functional level. The domain also has to use DFS-R as the engine to replicate SYSVOL.

## Windows Server 2016

Supported Domain Controller Operating System:

* Windows Server 2019
* Windows Server 2016

### Windows Server 2016 forest functional level features

* All of the features that are available at the Windows Server 2012R2 forest functional level, and the following features, are available:
   * [Privileged access management (PAM) using Microsoft Identity Manager (MIM)](https://docs.microsoft.com/windows-server/identity/whats-new-active-directory-domain-services#a-namebkmkpamaprivileged-access-management)

### Windows Server 2016 domain functional level features

* All default Active Directory features, all features from the Windows Server 2012R2 domain functional level, plus the following features:
   * DCs can support automatic rolling of the NTLM and other password-based secrets on a user account configured to require PKI authentication. This configuration is also known as “Smart card required for interactive logon”
   * DCs can support allowing network NTLM when a user is restricted to specific domain-joined devices.
   * Kerberos clients successfully authenticating with the PKInit Freshness Extension will get the fresh public key identity SID.

    For more information see [What's New in Kerberos Authentication](https://docs.microsoft.com/windows-server/security/kerberos/whats-new-in-kerberos-authentication) and [What's new in Credential Protection](https://docs.microsoft.com/windows-server/security/credentials-protection-and-management/whats-new-in-credential-protection)

## Windows Server 2012R2

Supported Domain Controller Operating System:

* Windows Server 2019
* Windows Server 2016
* Windows Server 2012 R2

### Windows Server 2012R2 forest functional level features

* All of the features that are available at the Windows Server 2012 forest functional level, but no additional features.

### Windows Server 2012R2 domain functional level features

* All default Active Directory features, all features from the Windows Server 2012 domain functional level, plus the following features:
   * DC-side protections for Protected Users. Protected Users authenticating to a Windows Server 2012 R2 domain can no longer:
      * Authenticate with NTLM authentication
      * Use DES or RC4 cipher suites in Kerberos pre-authentication
      * Be delegated with unconstrained or constrained delegation
      * Renew user tickets (TGTs) beyond the initial 4 hour lifetime
   * Authentication Policies
      * New forest-based Active Directory policies which can be applied to accounts in Windows Server 2012 R2 domains to control which hosts an account can sign-on from and apply access control conditions for authentication to services running as an account.
   * Authentication Policy Silos
      * New forest-based Active Directory object, which can create a relationship between user, managed service and computer, accounts to be used to classify accounts for authentication policies or for authentication isolation.

## Windows Server 2012

Supported Domain Controller Operating System:

* Windows Server 2019
* Windows Server 2016
* Windows Server 2012 R2
* Windows Server 2012

### Windows Server 2012 forest functional level features

* All of the features that are available at the Windows Server 2008 R2 forest functional level, but no additional features.

### Windows Server 2012 domain functional level features

* All default Active Directory features, all features from the Windows Server 2008R2 domain functional level, plus the following features:
   * The KDC support for claims, compound authentication, and Kerberos armoring KDC administrative template policy has two settings (Always provide claims and Fail unarmored authentication requests) that require Windows Server 2012 domain functional level. For more information, see [What's New in Kerberos Authentication](https://technet.microsoft.com/library/hh831747.aspx)

## Windows Server 2008R2

Supported Domain Controller Operating System:

* Windows Server 2019
* Windows Server 2016
* Windows Server 2012 R2
* Windows Server 2012
* Windows Server 2008 R2

### Windows Server 2008R2 forest functional level features

* All of the features that are available at the Windows Server 2003 forest functional level, plus the following features:
   * Active Directory Recycle Bin, which provides the ability to restore deleted objects in their entirety while AD DS is running.

### Windows Server 2008R2 domain functional level features

* All default Active Directory features, all features from the Windows Server 2008 domain functional level, plus the following features:
   * Authentication mechanism assurance, which packages information about the type of logon method (smart card or user name/password) that is used to authenticate domain users inside each user's Kerberos token. When this feature is enabled in a network environment that has deployed a federated identity management infrastructure, such as Active Directory Federation Services (AD FS), the information in the token can then be extracted whenever a user attempts to access any claims-aware application that has been developed to determine authorization based on a user's logon method.
   * Automatic SPN management for services running on a particular computer under the context of a Managed Service Account when the name or DNS host name of the machine account changes. For more information about Managed Service Accounts, see [Service Accounts Step-by-Step Guide](https://go.microsoft.com/fwlink/?LinkId=180401).

## Windows Server 2008

Supported Domain Controller Operating System:

* Windows Server 2019
* Windows Server 2016
* Windows Server 2012 R2
* Windows Server 2012
* Windows Server 2008 R2
* Windows Server 2008

### Windows Server 2008 forest functional level features

* All of the features that are available at the Windows Server 2003 forest functional level, but no additional features are available. 

### Windows Server 2008 domain functional level features

* All of the default AD DS features, all of the features from the Windows Server 2003 domain functional level, and the following features are available:
  * Distributed File System (DFS) replication support for the Windows Server 2003 System Volume (SYSVOL)
    * DFS replication support provides more robust and detailed replication of SYSVOL contents.

      > [!NOTE]
      > Beginning with Windows Server 2012 R2, File Replication Service (FRS) is deprecated. A new domain that is created on a domain controller that runs at least Windows Server 2012 R2 must be set to the Windows Server 2008 domain functional level or higher.

  * Domain-based DFS namespaces running in Windows Server 2008 Mode, which includes support for access-based enumeration and increased scalability. Domain-based namespaces in Windows Server 2008 mode also require the forest to use the Windows Server 2003 forest functional level. For more information, see [Choose a Namespace Type](https://go.microsoft.com/fwlink/?LinkId=180400).
  * Advanced Encryption Standard (AES 128 and AES 256) support for the Kerberos protocol. In order for TGTs to be issued using AES, the domain functional level must be Windows Server 2008 or higher and the domain password needs to be changed. 
    * For more information, see [Kerberos Enhancements](https://technet.microsoft.com/library/cc749438(ws.10).aspx).

      > [!NOTE]
      >Authentication errors may occur on a domain controller after the domain functional level is raised to Windows Server 2008 or higher if the domain controller has already replicated the DFL change but has not yet refreshed the krbtgt password. In this case, a restart of the KDC service on the domain controller will trigger an in-memory refresh of the new krbtgt password and resolve related authentication errors.

  * [Last Interactive Logon](https://go.microsoft.com/fwlink/?LinkId=180387) Information displays the following information:
     * The total number of failed logon attempts at a domain-joined Windows Server 2008 server or a Windows Vista workstation
     * The total number of failed logon attempts after a successful logon to a Windows Server 2008 server or a Windows Vista workstation
     * The time of the last failed logon attempt at a Windows Server 2008 or a Windows Vista workstation
     * The time of the last successful logon attempt at a Windows Server 2008 server or a Windows Vista workstation
  * Fine-grained password policies make it possible for you to specify password and account lockout policies for users and global security groups in a domain. For more information, see [Step-by-Step Guide for Fine-Grained Password and Account Lockout Policy Configuration](https://go.microsoft.com/fwlink/?LinkID=91477).
  * Personal Virtual Desktops
     * To use the added functionality provided by the Personal Virtual Desktop tab in the User Account Properties dialog box in Active Directory Users and Computers, your AD DS schema must be extended for Windows Server 2008 R2 (schema object version = 47). For more information, see [Deploying Personal Virtual Desktops by Using RemoteApp and Desktop Connection Step-by-Step Guide](https://go.microsoft.com/fwlink/?LinkId=183552).

## Windows Server 2003

Supported Domain Controller Operating System:

* Windows Server 2012 R2
* Windows Server 2012
* Windows Server 2008 R2
* Windows Server 2008
* Windows Server 2003

### Windows Server 2003 forest functional level features

* All of the default AD DS features, and the following features, are available:
   * Forest trust
   * Domain rename
   * Linked-value replication
      - Linked-value replication makes it possible for you to change group membership to store and replicate values for individual members instead of replicating the entire membership as a single unit. Storing and replicating the values of individual members uses less network bandwidth and fewer processor cycles during replication, and prevents you from losing updates when you add or remove multiple members concurrently at different domain controllers.
   * The ability to deploy a read-only domain controller (RODC)
   * Improved Knowledge Consistency Checker (KCC) algorithms and scalability
      - The intersite topology generator (ISTG) uses improved algorithms that scale to support forests with a greater number of sites than AD DS can support at the Windows 2000 forest functional level. The improved ISTG election algorithm is a less-intrusive mechanism for choosing the ISTG at the Windows 2000 forest functional level.
   * The ability to create instances of the dynamic auxiliary class named **dynamicObject** in a domain directory partition
   * The ability to convert an **inetOrgPerson** object instance into a **User** object instance, and to complete the conversion in the opposite direction
   * The ability to create instances of new group types to support role-based authorization. 
      - These types are called application basic groups and LDAP query groups.
   * Deactivation and redefinition of attributes and classes in the schema. The following attributes can be reused: ldapDisplayName, schemaIdGuid, OID, and mapiID.
   * Domain-based DFS namespaces running in Windows Server 2008 Mode, which includes support for access-based enumeration and increased scalability. For more information, see [Choose a Namespace Type](https://go.microsoft.com/fwlink/?LinkId=180400).

### Windows Server 2003 domain functional level features

* All the default AD DS features, all the features that are available at the Windows 2000 native domain functional level, and the following features are available:
   * The domain management tool, Netdom.exe, which makes it possible for you to rename domain controllers
   * Logon time stamp updates
      * The **lastLogonTimestamp** attribute is updated with the last logon time of the user or computer. This attribute is replicated within the domain.
   * The ability to set the **userPassword** attribute as the effective password on **inetOrgPerson** and user objects
   * The ability to redirect Users and Computers containers
      * By default, two well-known containers are provided for housing computer and user accounts, namely, cn=Computers,<domain root> and cn=Users,<domain root>. This feature allows the definition of a new, well-known location for these accounts.
   * The ability for Authorization Manager to store its authorization policies in AD DS
   * Constrained delegation
      * Constrained delegation makes it possible for applications to take advantage of the secure delegation of user credentials by means of Kerberos-based authentication.
      * You can restrict delegation to specific destination services only.
   * Selective authentication
      * Selective authentication makes it is possible for you to specify the users and groups from a trusted forest who are allowed to authenticate to resource servers in a trusting forest.

## Windows 2000

Supported Domain Controller Operating System:

* Windows Server 2008 R2
* Windows Server 2008
* Windows Server 2003
* Windows 2000

### Windows 2000 native forest functional level features

* All of the default AD DS features are available.

### Windows 2000 native domain functional level features

* All of the default AD DS features and the following directory features are available including:
   * Universal groups for both distribution and security groups.
   * Group nesting
   * Group conversion, which allows conversion between security and distribution groups
   * Security identifier (SID) history

## Next Steps

* [Raise the Domain Functional Level](https://technet.microsoft.com/library/cc753104.aspx)  
* [Raise the Forest Functional Level](https://technet.microsoft.com/library/cc730985.aspx)
