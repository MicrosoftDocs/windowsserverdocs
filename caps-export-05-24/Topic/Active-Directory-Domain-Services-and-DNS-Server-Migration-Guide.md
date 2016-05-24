---
title: Active Directory Domain Services and DNS Server Migration Guide
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: c7acc663-7b4d-485e-850d-ec4275d72417
author: Femila
---
# Active Directory Domain Services and DNS Server Migration Guide
    
## About this guide  
 This document provides guidance for migrating the Active Directory® Domain Services \(AD DS\) Server or Domain Name System \(DNS\) Server roles from an x86\-based or x64\-based server running Windows Server® 2003, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to a new [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] server.  
  
 This document describes best practices for migration of AD DS Server and DNS Server from old hardware to new hardware. The elements of an existing installation that are migrated are entirely up to the server administrator. However, along with the server role, these elements usually include their configuration, data, system identity, and operating system settings. This document makes no assumptions about potential dependencies that exist between server roles. Instead, it is assumed for the purpose of this guide that you are migrating AD DS Server and DNS Server on one computer to another computer on the network without changes to topology, site settings, site link settings, or subnet settings.  
  
### Target audience  
 This document is intended for information technology \(IT\) administrators, IT professionals, and other knowledge workers who are responsible for the operation and deployment of AD DS Server or DNS Server in a managed environment. Some scripting knowledge may be required to perform some of the migration steps that this guide contains.  
  
### What this guide does not provide  
 The following scenarios are not supported in this guide:  
  
-   This guide does not provide any process guidance for an in\-place upgrade, in which the new operating system is installed on the existing server hardware using the **Upgrade** option during Windows setup.  
  
-   This guide does not provide instructions for migrating server roles other than AD DS Server and DNS Server.  
  
-   This guide does not provide instructions for determining which software running on the source server is compatible with the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] destination server. Consult the software documentation for supported operating systems.  
  
-   The migration process that this guide describes is for migration within a single site. This guide does not support migration scenarios in which the source server and destination server are located in different sites. In addition, some migration\-related replication issues regarding migrating server roles on a bridgehead server are not addressed.  
  
### Supported migration scenarios  
 This guide provides you with instructions for migrating an existing server that is running AD DS Server and DNS Server to a server that is running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. This guide does not contain instructions for migration when the source server is running multiple roles. If your server is running multiple roles, it is recommended that you design a custom migration procedure specific to your server environment, based on the information provided in the other role migration guides. Migration guides for additional roles are available on the [Windows Server 2008 R2 TechCenter](http://go.microsoft.com/fwlink/?LinkID=128554) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=128554\).  
  
> [!CAUTION]  
>  If your source server is running multiple roles, some migration steps in this guide, such as those for computer name and IP configuration, can cause other roles that are running on the source server to fail.  
  
 This guide also contains separate instructions for migrating the stand\-alone DNS Server role. For more information, see [AD DS and DNS Server Migration: Appendix C - Stand-Alone DNS Migration](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-C---Stand-Alone-DNS-Migration.md).  
  
 This guide provides instructions only for migrating data and settings from an existing server that is being replaced by a new physical or virtual x64\-based server that has a clean operating system installed, as described in the following table.  
  
### Supported operating systems  
  
|Source server processor|Source server operating system|Destination server operating system|Destination server processor|  
|---------------------------|----------------------------------|---------------------------------------|--------------------------------|  
|x86\- or x64\-based|Windows Server 2003 with Service Pack 2 \(SP2\)|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], both full and Server Core installation options|x64\-based|  
|x86\- or x64\-based|Windows Server 2003 R2|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], both full and Server Core installation options|x64\-based|  
|x86\- or x64\-based|Windows Server 2008, both full and Server Core installation options|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|Server Core installation option of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], both full and Server Core installation options|x64\-based|  
  
 The versions of operating systems shown in the preceding table are the oldest combinations of operating systems and service packs that are supported. Newer service packs, if available, are supported.  
  
 Foundation, Standard, Enterprise, and Datacenter editions of Windows Server are supported as either source or destination servers. The Foundation Server edition is only supported as the destination server in limited scenarios. Be sure you understand the limitations of the Foundation Server edition before using it as the destination server.  
  
 Migrations between physical operating systems and virtual operating systems are supported.  
  
 Migration from a source server to a destination server that is running an operating system that uses a different system user interface \(UI\) language \(that is, the installed language\) from the source server is not supported. The system UI language is the language of the localized installation package that was used to set up the Windows operating system. For example, you cannot migrate roles, operating system settings, data, or shared resources from a computer that is running Windows Server 2008 in the French system UI language to a computer that is running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] in the German system UI language.  
  
## AD DS and DNS server migration overview  
 Before any migration procedures or preparations begin, the following conditions are assumed:  
  
-   The source server is a functioning domain controller with DNS Server installed.  
  
-   The destination server has [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] installed. It has also been added to the network as a member server with a unique \(static\) IP address and server name.  
  
-   When the migration of roles from the source server to the destination server is complete, the destination server begins performing the functions of the source server. The source server becomes a member server, it is retired and removed from the network, or it remains as an additional domain controller.  
  
### Overview of the migration process for these roles  
 When you perform a migration, you complete the following steps:  
  
-   Plan the migration. See [Plan migration](../Topic/AD-DS-and-DNS-Server-Migration--Preparing-to-Migrate.md#BKMK_GenPrep).  
  
-   Prepare the source server. See [Prepare your source server](../Topic/AD-DS-and-DNS-Server-Migration--Preparing-to-Migrate.md#BKMK_PrepSource).  
  
     Before migration begins, collect Active Directory or DNS settings from the source server. This guide provides a worksheet that you can use to collect this data. See [AD DS and DNS Server Migration: Appendix A - Migration Data Collection Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-A---Migration-Data-Collection-Worksheet.md).  
  
-   Add the new [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] x64\-based server to the network and make it a domain controller. See [Prepare your destination server](../Topic/AD-DS-and-DNS-Server-Migration--Preparing-to-Migrate.md#BKMK_PrepDest).  
  
-   Migrate mandatory settings. See [AD DS and DNS Server Migration: Migrating the AD DS and DNS Server Roles](../Topic/AD-DS-and-DNS-Server-Migration--Migrating-the-AD-DS-and-DNS-Server-Roles.md).  
  
-   Verify that migration is successful. See [AD DS and DNS Server Migration: Verifying the Migration](../Topic/AD-DS-and-DNS-Server-Migration--Verifying-the-Migration.md).  
  
-   Perform post\-migration tasks, possibly including demotion of the source server. See [AD DS and DNS Server Migration: Post-Migration Tasks](../Topic/AD-DS-and-DNS-Server-Migration--Post-Migration-Tasks.md).  
  
-   Migrate only the DNS server role by following separate instructions in [AD DS and DNS Server Migration: Appendix C - Stand-Alone DNS Migration](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-C---Stand-Alone-DNS-Migration.md).  
  
 Details of these steps are provided in the other topics in this guide.  
  
 The following illustration shows the migration process.  
  
 ![](../Image/13a42d6a-0ca4-462d-96aa-f3ea0f64716b.gif)  
  
### Differences between migration and upgrade  
 There are three options for deploying a new [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] operating system:  
  
-   In\-place upgrade  
  
-   Clean install  
  
-   Migration  
  
 In\-place upgrade and clean install both have advantages and disadvantages. This guide describes the third option: migration.  
  
 There is a difference between migration and an in\-place upgrade. Migration is required when hardware differences do not permit an upgrade. Because [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] is an x64\-only\-based operating system, it is impossible to upgrade x86\-based versions of Windows Server 2003 or Windows Server 2008 to a computer running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
 In addition, server migration can be a preferred deployment mechanism in a number of other scenarios:  
  
-   When the performance of the old server has degraded as a result of numerous software installations, updates, and patches  
  
-   When a physical server must be migrated to a virtual server  
  
-   When your scenario calls for migration from a full installation option to a Server Core installation option  
  
 You can use the instructions in this guide to migrate legacy settings and data to the new operating system.  
  
> [!NOTE]  
>  If your existing hardware is x64\-based but it is running an x86\-based operating system, you must still use the instructions in this guide to migrate your server roles.  
  
### Upgrade and migration methods  
  
|Method|Advantage|Disadvantage|  
|----------|-------------|----------------|  
|In\-place upgrade \(not discussed in this guide\)|All your current settings and configurations are retained.|The upgraded server retains all the old data.<br /><br />In\-place upgrade requires more downtime because the existing operating system is being replaced with the new operating system.<br /><br />If the in\-place upgrade is not successful, roll\-back is more complex.|  
|Clean install \(not discussed in this guide\)|Removes all the old data and configuration that you no longer need.|You must reconfigure the new computer.|  
|Migration \(discussed in this guide\)|All your current settings and configuration are retained, while all the old data and configuration that you no longer need are removed.<br /><br />Provides a transition path from a physical environment to a virtualized environment and from a full installation to a Server Core installation.<br /><br />Requires less downtime because the old server remains operational for the most of the migration process.|More planning and verification are required to ensure a successful migration.|  
  
## Impact of migration  
 The objective of the migration process is that the destination server performs the same functions as the source server did, without any disruption of services to client computers on the network. When the migration is complete, the destination server should be able to authenticate users and computers. Client computers that use the services of the source server should not have to be modified, and client computers should experience little or no service outage. The replacement destination server for AD DS Server or DNS Server handles all Lightweight Directory Access Protocol \(LDAP\) queries as the source server did.  
  
 In an environment in which client computers are configured with a single DNS server, which is also the source server, it is critical to note that DNS services may be disrupted temporarily during the migration. In this situation, the client computers will not be able to resolve domain names to IP addresses. We recommend that during this time one or more additional DNS servers be configured so that clients continue to be able to resolve names while the primary source server is being migrated.  
  
## Permissions required to complete migration  
 You must have Domain Administrator permissions to access all the tools, data, and settings that are necessary for the migration process.  
  
## Estimated duration  
 Normally, you can expect the migration of AD DS Server and DNS Server in a simple environment to take two to three hours, including testing. Additional time is required for promotion of the new server to domain controller. In larger, more\-complicated environments, domain controller promotion can vary widely, depending on the quantity of data that must be replicated on the new server and on the connectivity of the network. However, using certain tools and the install from media \(IFM\) option to move the entire database at one time is the recommended process.  
  
## AD DS and DNS Server migration scenario  
 We recommend that you develop a migration scenario for your servers that accounts for all the special circumstances, configurations, or topologies that might affect your migration. You may have to answer questions about your migration, such as the following:  
  
-   Do you have multiple Active Directory instances that are replicated on various physical servers or virtual servers?  
  
-   Is AD DS located only on the same physical server or virtual server?  
  
 If you are migrating DNS Server, determine how AD DS is distributed in your domain. For example, will DNS Server be migrated with AD DS Server from the same computer? While DNS Server can be migrated separately from AD DS Server, in most cases both server roles are likely to be hosted on the same computer, and they must be migrated together at the same time. Therefore, we recommend that you develop a DNS Server migration scenario that accounts for any special circumstances, configurations, or topologies that affect your DNS Server migration.  
  
 However, this guide does contain separate instructions for migrating the stand\-alone DNS Server role in [AD DS and DNS Server Migration: Appendix C - Stand-Alone DNS Migration](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-C---Stand-Alone-DNS-Migration.md).  
  
## Special migration considerations  
 There are certain server configurations that require special steps before, during, or after migration. Migration instructions for some of these configurations are not provided in this guide at this time. These special cases are described in the next section.  
  
### Properly functioning servers vs. noncompliant servers  
 Migration can be affected by the “health” of the source server. Server health is a measure of server problems or lack of problems. Windows Server provides various ways to collect and save many different types of server data. You can use this data to establish a baseline that describes a healthy, properly functioning server. If a server becomes unhealthy, you can determine what has changed by comparing current measurements with the baseline data that you collected when the server was healthy.  
  
 If the source server event logs show that the source server is not healthy, there are two ways that you can migrate the source server:  
  
-   Bring up the new destination server and ignore the problems of the source server.  
  
-   Fix all the source server issues and then migrate all the settings to the destination server.  
  
 If there are any known issues or problems with the source server, consider the possible impact that such issues can have on the migration. It is a best practice to migrate from a healthy source server to a healthy destination server. However, situations can occur in which you might perform a migration from an unhealthy source server. These special cases require careful analysis.  
  
## See Also  
 [AD DS and DNS Server Migration: Preparing to Migrate](../Topic/AD-DS-and-DNS-Server-Migration--Preparing-to-Migrate.md)   
 [AD DS and DNS Server Migration: Migrating the AD DS and DNS Server Roles](../Topic/AD-DS-and-DNS-Server-Migration--Migrating-the-AD-DS-and-DNS-Server-Roles.md)   
 [AD DS and DNS Server Migration: Verifying the Migration](../Topic/AD-DS-and-DNS-Server-Migration--Verifying-the-Migration.md)   
 [AD DS and DNS Server Migration: Post-Migration Tasks](../Topic/AD-DS-and-DNS-Server-Migration--Post-Migration-Tasks.md)   
 [AD DS and DNS Server Migration: Appendix A - Migration Data Collection Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-A---Migration-Data-Collection-Worksheet.md)   
 [AD DS and DNS Server Migration: Appendix B - Migration Verification Worksheet](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-B---Migration-Verification-Worksheet.md)   
 [AD DS and DNS Server Migration: Appendix C - Stand-Alone DNS Migration](../Topic/AD-DS-and-DNS-Server-Migration--Appendix-C---Stand-Alone-DNS-Migration.md)  
  
  