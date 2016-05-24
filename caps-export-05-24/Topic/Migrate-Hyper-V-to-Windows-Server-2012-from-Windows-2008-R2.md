---
title: Migrate Hyper-V to Windows Server 2012 from Windows 2008 R2
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 35214e93-b43f-4457-97f5-6d27901c22c3
author: cwatsonmsft
---
# Migrate Hyper-V to Windows Server 2012 from Windows 2008 R2
Hyper\-V enables you to create a virtualized server computing environment using a technology that is part of Windows. This guide provides information and instructions about migrating the Hyper\-V role—including virtual machines, data, and operating system settings—from the source server running Hyper\-V in an earlier version of Windows to the destination server that is running the [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] operating system.  
  
## About this guide  
  
> [!NOTE]  
> Your detailed feedback is very important, and helps us to make Windows Server Migration Guides as reliable, complete, and easy to use as possible. Please take a moment to rate this topic, and then add comments that support your rating. If you are viewing this topic in Lightweight View, click **Rate this topic** at the top of the page. In Classic View, click the stars in the upper\-right corner of the page \(1\=poor, 5\=excellent\). Describe what you liked, did not like, or want to see in future versions of the topic. To submit additional suggestions about how to improve Migration guides or utilities, post on the [Windows Server Migration forum](http://go.microsoft.com/fwlink/?LinkId=247606).  
  
This guide describes how to migrate the Hyper\-V role by providing preparation, migration, and verification steps.  
  
Migration documentation and tools ease the migration of server role settings and data from an existing server to a destination server that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. By using the tools that are described in this guide, you can simplify the migration process, reduce migration time, increase the accuracy of the migration process, and help to eliminate possible conflicts that might otherwise occur during the migration process. For more information about installing and using the migration tools on both source and destination servers, see the [Windows Server Migration Tools Installation, Access, and Removal Guide](http://go.microsoft.com/fwlink/?LinkId=247607).  
  
### Target audience  
This document is intended for information technology \(IT\) professionals who are responsible for operating and deploying Hyper\-V in a managed environment.  
  
## What this guide does not provide  
The following items are not covered in this guide because they are not supported by the migration tools:  
  
-   Clustering scenarios are not supported by this migration process. For information about how to perform a migration in a clustered environment, see the Migrating Clustered Services and Applications to Windows Server 2012 Step\-by\-Step Guide [Migrating Clustered Services and Applications to Windows Server 2012 Step\-by\-Step Guide](assetId:///40adc868-a787-4062-bacb-61207538d4ce).  
  
-   Upgrading roles on the same computer is out of scope for this guide.  
  
-   Migrating more than one server role at one time.  
  
-   Migrating Hyper\-V from one server running Windows Server 2012 to another server running 2012. Instead, this process is supported by several of the new Hyper\-V management tools and features. The general process is as follows:  
  
    -   Determine whether you will use export and import or live migration to move the virtual machines. Export and import can be used in either a workgroup or a domain environment but requires that the virtual machine is turned off. Live migration requires a domain environment as well as some configuration, but allows you to move running virtual machines.  
  
    -   Add the Hyper\-V role to the destination server. You can configure default storage locations and live migration when you add the role. For instructions, see [Install the Hyper\-V role and configure a virtual machine](assetId:///243b5705-96c9-4ec7-9ec5-c68a22b0d42d).  
  
    -   Configure virtual switches and, optionally, other networking features on the destination server. Management tools include the cmdlets [New\-VMSwitch](http://technet.microsoft.com/library/hh848455) and [Set\-VMSwitch](http://technet.microsoft.com/library/hh848515) in the Hyper\-V module, and the Virtual Switch Manager in the Hyper\-V Manager snap\-in.  
  
    -   Move the virtual machines by exporting and importing them, or performing live migrations. Management tools include the cmdlets [Export\-VM](http://technet.microsoft.com/library/hh848491) and [Import\-VM](http://technet.microsoft.com/library/hh848495), and the **Export**, **Import**, and **Move** menu commands in Hyper\-V Manager. For more information about using live migration to move a virtual machine, see [Configure Live Migration and Migrating Virtual Machines without Failover Clustering](../Topic/Configure-Live-Migration-and-Migrating-Virtual-Machines-without-Failover-Clustering.md).  
  
-   For a list of the cmdlets included in the Hyper\-V module, see [http:\/\/technet.microsoft.com\/library\/hh848559](http://technet.microsoft.com/library/hh848559).  
  
## Supported migration scenarios  
This guide provides you with instructions for migrating an existing server that is running the Hyper\-V role on an earlier version of Windows Server to a server that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. This guide does not contain instructions for migration when the source server is running multiple roles. If your server is running multiple roles, it is recommended that you design a custom migration procedure specific to your server environment, based on the information provided in other role migration guides. Migration guides for additional roles are available on the [Windows Server Migration Portal](http://go.microsoft.com/fwlink/?LinkId=247608).  
  
> [!CAUTION]  
> If your source server is running multiple roles, some migration steps in this guide, such as those for computer name and IP configuration, can cause other roles that are running on the source server to fail.  
  
### Supported operating systems  
  
|Source server processor|Source server operating system|Destination server operating system|Destination server processor|  
|---------------------------|----------------------------------|---------------------------------------|--------------------------------|  
|x64\-based|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] with Service Pack 2, full installation option only|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|Server Core installation option of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], both full and Server Core installation options|x64\-based|  
  
The versions of operating systems shown in the preceding table are the oldest combinations of operating systems and service packs that are supported. Newer service packs, if available, are supported. If an operating system is not listed, then it is not supported. The stand\-alone product Microsoft Hyper\-V Server is not supported.  
  
Standard, Enterprise, and Datacenter editions of Windows Server running Hyper\-V are supported as either source or destination servers.  
  
Migration from a source server to a destination server that is running an operating system in a different system UI language \(that is, the installed language\) than the source server is not supported. For example, you cannot use [!INCLUDE[wsmt](../Token/wsmt_md.md)] to migrate roles, operating system settings, data, or shares from a computer that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] in the French system UI language to a computer that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] in the German system UI language.  
  
> [!NOTE]  
> The system UI language is the language of the localized installation package that was used to set up the Windows operating system.  
  
### Supported role configurations and settings  
This section identifies the configurations and settings that can be migrated by using the migration tools, and the configurations and settings that must be migrated manually. The following table provides a summary.  
  
|Configurations and settings|Type of migration|  
|-------------------------------|---------------------|  
|Virtual machine \(configuration and data\)|Automated, except as noted below|  
|Hyper\-V settings|Automated|  
|Virtual network adapter settings in the management operating system|Automated|  
|External virtual networks|Partially automated, as described below|  
|Virtual machine queue \(VMQ\) networking settings|Automated|  
|Customized remote administration settings|Manual|  
  
The following configurations and settings can be migrated automatically:  
  
-   **Most virtual machine configurations**. Virtual machines and their data are moved as part of the migration, but some configurations require manual intervention, as described below.  
  
-   **Hyper\-V settings**. These include the system\-wide settings and the authorization store.  
  
    > [!NOTE]  
    > If you are migrating from a source server running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and have set a MAC address range, that value also is automatically migrated to the destination server.  
  
-   **Internal and private virtual networks**.  
  
-   **Virtual network adapter settings in the management operating system**. When Hyper\-V is configured to use a physical network adapter as a bridge that virtual machines can use to access a physical network, a virtual network adapter is created in the management operating system \(which runs the Hyper\-V role\). For this virtual network adapter, the migration process automatically migrates the IP settings, bindings, and MAC address of this virtual network adapter. However, the connection between the virtual network adapter and the physical network adapter must be re\-established manually, as described in the migration steps.  
  
-   **Virtual machine queue \(VMQ\) settings for networking**.  
  
The following configurations and settings require manual intervention after the migration tools are used:  
  
-   **Firewall settings**. Firewall settings are recreated on the destination server using the default values that Hyper\-V is installed with. If you have modified any of the firewall settings from these default values, you will need to make the same modifications on the destination server.  
  
-   **External virtual networks**. The migration tool recreates the virtual networks on the destination server, but recreates external virtual networks as internal virtual networks. You will need to modify each of these networks to connect it to the appropriate physical network adapter on the destination server, as described in the migration steps.  
  
-   **VFD and ISO files**. These files are not migrated because they are not required for the virtual machine to operate and are not supported by the Import and Export cmdlets. To make them available to a migrated virtual machine, manually copy these files to the destination server and then reattach them to the virtual machine after it is migrated.  
  
-   **Connections to physical disks directly attached to virtual machines**. These connections \(sometimes referred to as “pass\-through disks”\) are not migrated because the disk references might not be valid on the destination server. To make a physical disk available to a migrated virtual machine, connect the disk to the destination server and then to the virtual machine after it is migrated, as described in the migration steps.  
  
-   **Customized remote administration settings**. If you have customized Hyper\-V for remote access, you will need to perform some additional procedures to recreate the DCOM and WMI Namespace settings. The migration steps identify the point at which you should take perform these procedures, as well as provide a recommended tool or script to complete the procedure.  
  
### Migration dependencies  
The Hyper\-V role is not dependent on any other roles. As a best practice, we recommend that no other roles are installed on a server running Hyper\-V.  
  
## Migration scenarios that are not supported  
The following migration scenarios are not supported:  
  
-   The saved state of a virtual machine.  
  
-   Virtual machine configuration under one of the following conditions:  
  
    -   When the number of virtual processors configured for the virtual machine is more than the number of logical processors on the destination server.  
  
    -   When the memory configured for a virtual machine is greater than the available memory on the destination server.  
  
-   Consolidation of physical servers to virtual machines, or consolidation of multiple instances of Hyper\-V to one instance.  
  
## Hyper\-V migration overview  
Hyper\-V role migration involves moving the virtual machines, virtual networks, and all the associated settings from one physical computer to another physical computer in the enterprise. The process supports moving from a server running Hyper\-V in [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)] to a server running Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. The Hyper\-V role is not dependent on any other roles.  
  
The migration tools include cmdlets that you use to perform some of the tasks required to migrate the Hyper\-V role. The Export cmdlet captures the majority of the Hyper\-V settings that are required to perform a successful migration, including the virtual machine configurations, virtual networks, and virtual hard disks. The DCOM and WMI namespace security settings must be migrated separately. The instructions for this are provided later in the guide. On the destination server, the import cmdlets will recreate the virtual machines.  
  
## Impact of migration  
The following section describes the impact of migration on the source server and on other computers in the enterprise.  
  
### Impact of migration on the source server  
The source server should be turned off or removed from the network before you run the import cmdlets on the destination server so that there are no conflicts between the virtual machines running on the source server and the virtual machines that will be recreated on the destination server. The point at which you should perform this task is identified in the migration steps, later in this guide.  
  
### Impact of migration on other computers in the enterprise  
This migration may impact any computer \(either virtual or physical\) that relies on the applications or workloads running in the virtual machines to be migrated as part of the Hyper\-V role migration, because the virtual machines will be offline for the duration of the migration. For example, if a virtual machine hosts a database, any applications in the enterprise that require access to that database will be impacted. As a result, you will need to plan for this downtime by either scheduling a planned outage or by redirecting traffic to other servers to provide the services.  
  
## Access rights required to complete migration  
The user account that runs the cmdlets and tools must be a member of the local Administrators group on the source server and the destination server.  
  
## Estimated duration  
The length of time it takes to migrate the Hyper\-V role depends on the size of the data to be transferred. Of the various types of files to be transferred, the .vhd files have the largest file sizes \(from a few gigabytes to many gigabytes in size\). The length of time is affected by the size of the .vhd files and by the network bandwidth.  
  
## Additional references  
  
-   [Hyper-V: Prepare to Migrate](../Topic/Hyper-V--Prepare-to-Migrate.md)  
  
-   [Hyper\-V: Migrate the Hyper\-V Role](assetId:///fa4f4b48-ecbb-4c0d-8ef1-34da57c81ce6)  
  
-   [Hyper-V: Verify the Migration](../Topic/Hyper-V--Verify-the-Migration.md)  
  
-   [Hyper\-V: Post\-migration Tasks](assetId:///dfea5e27-6361-4fb1-8217-8197ae2284b0)  
  
-   [Hyper\-V Overview](assetId:///5aad349f-ef06-464a-b36f-366fbb040143)  
  
-   [Hyper\-V Migration Guide](http://technet.microsoft.com/library/ee849855(v=ws.10)) \(for migration of Hyper\-V running in Windows Server 2008 to Windows Server 2008 R2.\)  
  
-   [Windows Server Migration Portal](http://go.microsoft.com/fwlink/?LinkId=247608)  
  
