---
title: Core Network Companion Guide: Group Policy Deployment
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 80670b54-b71a-46a2-8e1a-8f4e2c3e3576
author: coreyp
---
# Core Network Companion Guide: Group Policy Deployment
This is a companion guide to the [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] Core Network Guide, which is available for download in Microsoft Office Word format at the Microsoft Download Center \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=255199](http://go.microsoft.com/fwlink/?LinkId=255199)\) and in HTML format in the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Technical Library \([http:\/\/technet.microsoft.com\/library\/hh911995.aspx](http://technet.microsoft.com/library/hh911995.aspx)\).  
  
The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Core Network Guide provides instructions for planning and deploying the core components required for a fully functioning network and a new Active Directory domain in a new forest.  
  
This guide explains how to build on the core network by providing instructions for deploying Group Policy Objects \(GPOs\) by using membership groups instead of the organizational units \(OUs\) that form the hierarchy of an Active Directory domain.  
  
This guide contains the following sections.  
  
-   [About this guide](#bkmk_about)  
  
-   [Requirements](#bkmk_req)  
  
-   [What this guide does not provide](#bkmk_not)  
  
-   [Technology overview of Group Policy](#bkmk_overview)  
  
-   [Group Policy Deployment Overview](../Topic/Group-Policy-Deployment-Overview.md)  
  
-   [Group Policy Deployment Planning](../Topic/Group-Policy-Deployment-Planning.md)  
  
-   [Group Policy Deployment](../Topic/Group-Policy-Deployment.md)  
  
-   [Additional Resources_41](../Topic/Additional-Resources_41.md)  
  
> [!NOTE]  
> This guide is available at the following locations.  
>   
> -   The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)][Core Network Companion Guide: Group Policy Deployment](http://www.microsoft.com/download/details.aspx?id=36050) in Word format in the Microsoft Download Center.  
> -   The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)][Core Network Companion Guide: Group Policy Deployment](../Topic/Core-Network-Companion-Guide--Group-Policy-Deployment.md) in HTML format in the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Technical Library.  
  
## <a name="bkmk_about"></a>About this guide  
This guide provides instructions for deploying Group Policy settings to a set of client computers or users by using membership groups rather than account location in the OU hierarchy of a domain.  
  
The method described in this guide shows you how to create a single membership group into which you can add the user or computer accounts that are to receive a configuration through the use of GPOs. Membership in the group, rather than the account location in the OU hierarchy, determines whether the computer receives one of the GPOs associated with the membership group. In addition, Windows Management Instrumentation \(WMI\) filters are used to ensure that only the GPO with the settings that correspond to the version of Windows running on the computer is applied.  
  
There are two main benefits to using this method to deploy GPOs:  
  
-   It is totally independent of the OU structure of your domain. To apply a GPO to one computer no longer means moving computers to another OU or restructuring your OU hierarchy.  
  
-   It is very easy to apply or stop applying the settings in a GPO. You simply remove the user or computer account from the membership group. This removes the user or computer from the scope of the GPO without affecting any other GPOs that apply to the user or computer.  
  
This guide is designed for network and system administrators who have followed the instructions in the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Core Network Guide to deploy a core network, or for those who have previously deployed the core technologies included in the core network, including Active Directory Domain Services \(AD DS\), Domain Name Service \(DNS\), Dynamic Host Configuration Protocol \(DHCP\), TCP\/IP, and Windows Internet Name Service \(WINS\) \(optional\).  
  
It is recommended that you review the design and deployment guides for each of the technologies that are used in this deployment scenario. These guides can help you determine whether this deployment scenario provides the services and configuration that you need for your organization's network.  
  
### <a name="bkmk_req"></a>Requirements  
  
> [!CAUTION]  
> We recommend that you use the methods documented in this guide only for GPOs that must be deployed to the majority of the computers in your organization, and only when the OU hierarchy in your Active Directory domain does not match up well with the deployment needs of these GPOs. When the OU hierarchy supports it, deploy a GPO by linking it to the lowest level OU that contains all of the accounts to which the GPO will apply.  
>   
> In a large enterprise environment with hundreds or thousands of GPOs, the use of this method can result in user or computer accounts that are made members of an excessive number of groups; this can result in network connectivity problems when network protocol limits have been exceeded. For more information about the problems associated with excessive group membership, see the following articles in the Microsoft Knowledge Base:  
>   
> -   What’s New for Kerberos in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides information about improvements to reduce authentication failures due to large service tickets, see [http:\/\/technet.microsoft.com\/library\/hh831747.aspx](http://technet.microsoft.com/library/hh831747.aspx)  
> -   Article 327825 “New resolution for problems with Kerberos authentication when users belong to many groups” \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=23044](http://go.microsoft.com/fwlink/?LinkId=23044)\)  
> -   Article 263693 “Group Policy may not be applied to users belonging to many groups” \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=126293](http://go.microsoft.com/fwlink/?LinkId=126293)\)  
> -   Article 328889 “Users who are members of more than 1,015 groups may fail logon authentication” \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=115213](http://go.microsoft.com/fwlink/?LinkId=115213)\)  
  
Following are the requirements for using Group Policy:  
  
-   To deploy Group Policy, you must have an Active Directory domain controller hosting a domain and computers that are joined to the domain.  
  
-   To configure GPOs, create membership groups, and assign members to them, you must be logged on as a member of the Domain Admins group.  
  
## <a name="bkmk_not"></a>What this guide does not provide  
This guide does not provide comprehensive instructions for designing and deploying a Group Policy infrastructure by using AD DS. It is recommended that you review AD DS and Group Policy documentation before you deploy the technologies in this guide. For more information, see [Additional Resources_41](../Topic/Additional-Resources_41.md).  
  
## <a name="bkmk_overview"></a>Technology overview of Group Policy  
Group Policy is a management technology that provides users with consistent access to their applications, application settings, roaming user profiles, and user data, from any managed computer—even when they are disconnected from the network. Group Policy settings are contained in GPOs, which are linked to sites, domains, or OUs within an Active Directory domain. The settings within GPOs are then evaluated and applied by the targeted computers and users. Group Policy is one of the top reasons to deploy Active Directory Domain Services \(AD DS\) because it allows you to manage user and computer objects.  
  
Most administrators associate GPO deployment with the OU hierarchy of an Active Directory domain. You can link a GPO to an OU, and any computers or users in that OU or one of its descendants receive and apply the policy. However, an Active Directory domain can contain only a single hierarchy of OUs, and computer and user accounts can be placed into only a single OU. For this reason, there are times when an OU hierarchy that is appropriate for solving one problem is inappropriate for another. For example, many organizations design the OU hierarchy to support delegated administration. Computer and user accounts are placed into OUs for which an IT team has been assigned responsibility. By granting the IT team administrative permissions on the OU container, they can manage the computers and users whose accounts are in the OU. This same hierarchy might be ineffective for deploying Group Policy settings that affect computers across the entire organization, for example, when deploying Internet Protocol security \(IPsec\) settings for server and domain isolation scenarios.  
  
In addition, configuring one version of Windows might require you to use a policy setting that is different from the policy setting used in another version of Windows. For example, IPsec rules in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Windows Server 2008, [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], Windows 7, and Windows Vista are managed by a different part of the GPO than the IPsec rules for Windows Server 2003 and earlier versions of Windows. This means that you might have six separate GPOs that all perform the same function, one each for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Windows Server 2003, [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], Windows 7, and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)]. The Windows Server 2003 GPO also applies to earlier versions of Windows.  
  
