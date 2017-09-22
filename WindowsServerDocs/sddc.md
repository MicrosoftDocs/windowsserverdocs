---
title: Windows Server Software-Defined Datacenter
description: "Windows Server SDDC Overview"
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: SDDC
ms.tgt_pltfrm: na
ms.topic: get-started article
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 08/28/2017
---

>Applies To: Windows Server 2016

# Windows Server Software-Defined Datacenter


![](media/sddc/heading.png)

## What is Windows Server Software-Defined Datacenter? ##
edit
Software-Defined Datacenter (SDDC) is a common industry term that generally refers to a datacenter where all of the infrastructure is virtualized. Virtualization is the key, and it simply means that the hardware and software in the datacenter expand beyond a traditional one-to-one ratio. With a software hypervisor emulating hardware, operating systems and applications can be abstracted away from physical hardware, and multiplied to form elastic resource pools of processors, memory, I/O and networks.
 
Microsoft's implementation of the SDDC consists of the Windows Server technologies highlighted in this article. It starts with the Hyper-V hypervisor that provides the virtualization platform upon which networking and storage are built. Security technologies, developed for the unique challenges of virtualized infrastructure, mitigate internal and external threats. With PowerShell built into Windows Server, and the addition of [System Center](https://docs.microsoft.com/en-us/system-center/) and/or [Operations Management Suite](https://docs.microsoft.com/en-us/azure/operations-management-suite/operations-management-suite-overview), you can program and automate provisioning, deployment, configuration and management.

The technologies built into Windows Server and System Center are the main building blocks of the Windows Server SDDC experience. But even though it's a virtualized platform, it still requires the right hardware underneath. Microsoft partners participating in the **Windows Server Software-Defined (WSSD) Solutions** program can help your enterprise acquire the right hardware and get it up and running on day zero.

![](media/sddc/video.png)**[Watch a video to learn more about Microsoft's SDDC](https://mva.microsoft.com/en-US/training-courses/whats-new-in-windows-server-2016-16457?l=YcsJR6sXC_1006218965)**

![](media/sddc/poster-ico.png)**[Download a poster size .pdf file of this page](https://github.com/MicrosoftDocs/windowsserverdocs/blob/master/WindowsServerDocs/media/sddc/sddc_poster_0801417_ANSI-E.pdf)**


![](media/sddc/spacer1.png)![](media/sddc/spacer1.png)<a href="https://github.com/MicrosoftDocs/windowsserverdocs/blob/master/WindowsServerDocs//media/sddc/sddc_poster_0801417_ANSI-E.pdf"><img src="media/sddc/poster.png"></a>


## Windows Server Software-Defined (WSSD) Solutions ##
Building your Windows Server Software-Defined Datacenter on the right hardware infrastructure is a crucial first step to success. That's why we've partnered with **DataON**, **Fujitsu**, **Lenovo**, **QCT**, **SuperMicro**, **Hewlett Packard Enterprise** and **Dell EMC**, to create Microsoft-validated SDDC designs and best practices for deployment. 
Microsoft partners offer an array of Windows Server Software-Defined (WSSD) solutions that work with Window Server 2016 to deliver high-performance, hyper-converged, storage and networking infrastructure. Hyper-converged solutions bring together compute, storage, and networking on industry-standard servers and components for improved datacenter intelligence and control.



![](media/sddc/learn.png)**[Learn more about WSSD Solutions](https://www.microsoft.com/en-us/cloud-platform/software-defined-datacenter)**

## Windows Server virtualized technologies ##

The remainder of this topic lists the Windows Server SDDC technologies and provides links to the documentation for each. The technologies are listed in the table below:

![](media/sddc/table.png)

![](media/sddc/virtualize.png)

### Windows Server, Hyper-Converged ###

As a virtualization platform, Windows Server can be installed in three different sizes to meet the needs of  your business:

![](media/sddc/spacer1.png)![](media/sddc/server.png)

- Nano — optimized as a lightweight operating system for running “cloud-native” applications based on containers and micro-services.
- Core — for reduced space required on disk, the potential attack surface, and especially the servicing requirements, install Server Core unless you require a graphical interface.
- Desktop — the standard user interface and all tools and client experience features Server roles and features are installed with Server Manager. Compared with the Server Core, it requires more space on disk, and has higher servicing requirements.

![](media/sddc/learn.png)**[Learn more about  Windows Server, Hyper-converged](https://docs.microsoft.com/en-us/windows-server/get-started/what-s-new-in-windows-server-2016#computevirtualizationvirtualizationmd)**
 


### Guest Clustering with Shared VHDX ###

![](media/sddc/virtualize-line.png)

Flexible and secure, and not bound to the underlying storage topology, Shared VHDX removes the need to present the physical underlying storage to a guest OS. The new Shared VHDX supports online resize.

![](media/sddc/spacer1.png)![](media/sddc/cluster.png)

- Shared VHDX can reside on a Cluster Shared Volume (CSV) on block storage, or on SMB file-based storage.
- Protected: Shared VHDX supports Hyper-V Replica and host-level backup.

![](media/sddc/learn.png)**[Learn more about  Guest Clustering with Shared VHDX](https://technet.microsoft.com/en-us/library/dn281956(v=ws.11).aspx)**

### Hyper-V Replica ###

![](media/sddc/virtualize-line.png)

Integrated software-based VM replication across the network with certificates. Not bound to server, network or storage hardware on either site.

![](media/sddc/spacer1.png)![](media/sddc/replica.png)

No need for other virtual machine replication technologies, reducing costs.
- Handles live migration automatically.
- Simple configuration and management — either through Hyper-V Manager, PowerShell, or with Azure Site Recovery.

![](media/sddc/learn.png)**[Learn more about Hyper-V Replica](https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/manage/set-up-hyper-v-replica)**

![](media/sddc/networking.png)

### Network Controller ###

![](media/sddc/networking-line.png)

A centralized, programmable point of automation to manage, configure, monitor, and troubleshoot virtual and physical network infrastructure in your datacenter.

![](media/sddc/spacer1.png)![](media/sddc/netcontroller.png)

Administrators use a Management Tool that interacts directly with Network Controller. Network Controller provides information about the network infrastructure, including both virtual and physical infrastructure, to the Management Tool.

![](media/sddc/learn.png)**[Learn more about Network Controller](https://docs.microsoft.com/en-us/windows-server/networking/sdn/technologies/network-controller/network-controller)**

### Datacenter Firewall ###

![](media/sddc/networking-line.png)

When deployed and offered as a service, tenant administrators can install and configure firewall policies to help protect virtual networks from unwanted traffic from Internet and intranet networks.

![](media/sddc/spacer1.png)![](media/sddc/firewall.png)

The service provider administrator or the tenant administrator can manage the Datacenter Firewall policies via the network controller.

![](media/sddc/learn.png)**[Learn More about Datacenter Firewall](https://docs.microsoft.com/en-us/windows-server/networking/sdn/technologies/network-function-virtualization/datacenter-firewall-overview)**

### Switch Embedded Teaming ###

![](media/sddc/networking-line.png)

SET is an alternative NIC Teaming solution that you can use in environments that include Hyper-V and the [Software Defined Networking (SDN)](https://docs.microsoft.com/en-us/windows-server/networking/sdn/software-defined-networking) stack.

![](media/sddc/spacer1.png)![](media/sddc/teaming.png)

![](media/sddc/learn.png)**[Learn more about Switch Embedded Teaming](https://docs.microsoft.com/en-us/windows-server/networking/sdn/technologies/set-for-sdn)**

### Software Load Balancing ###

![](media/sddc/networking-line.png)

SLB enables multiple servers to host the same workload, providing high availability and scalability. Scale out load balancing capabilities using SLB VMs on the same Hyper-V servers you use for your other VM workloads. SLB supports the rapid creation and deletion of load balancing endpoints for Cloud Service Provider operations. SLB supports tens of gigabytes per cluster, provides a simple provisioning model, and is easy to scale out and in.

![](media/sddc/spacer1.png)![](media/sddc/balancer.png)

![](media/sddc/learn.png)**[Learn more about Software Load Balancing](https://docs.microsoft.com/en-us/windows-server/networking/sdn/technologies/network-function-virtualization/software-load-balancing-for-sdn)**


![](media/sddc/storage.png)

### Storage Spaces Direct ###

![](media/sddc/storage-line.png)

Using industry-standard servers with local-attached drives, SSD provides highly available, highly scalable software-defined storage at a fraction of the cost of traditional SAN or NAS arrays. Its architecture radically simplifies procurement and deployment.

![](media/sddc/spacer1.png)![](media/sddc/ssd.png)

SSD introduces the new Software Storage Bus and leverages many of the features you know today in Windows Server, such as Failover Clustering, the Cluster Shared Volume (CSV) file system, Server Message Block (SMB) 3, and Storage Spaces.

![](media/sddc/learn.png)**[Learn more about Storage Spaces Direct](https://docs.microsoft.com/en-us/windows-server/storage/storage-spaces/storage-spaces-direct-overview)**
### Storage Quality of Service ###


![](media/sddc/storage-line.png)

Centrally monitor and manage storage performance for virtual machines using Hyper-V and the Scale-Out File Server roles, improving storage resource fairness between multiple virtual machines.

![](media/sddc/spacer1.png)![](media/sddc/qos.png)

Storage QoS is built into the Microsoft software-defined storage solution provided by Scale-Out File Server and Hyper-V using SMB3 protocol. A new Policy Manager provides central storage performance monitoring.

![](media/sddc/learn.png)**[Learn more about Storage QoS](https://docs.microsoft.com/en-us/windows-server/storage/storage-qos/storage-qos-overview)**

### Storage Replica ###


![](media/sddc/storage-line.png)

Disaster recovery and preparedness make possible zero data loss, with the ability to synchronously protect data on different racks, floors, buildings, campuses, cities, and countries with more efficient use of multiple datacenters.

![](media/sddc/spacer1.png)
![](media/sddc/storage-replica.png)

Synchronous Replication

1. Application writes data
2. Log data is written and the data is replicated to the remote site
3. Log data is written at the remote site
4. Acknowledgement from the remote site
5. Application write acknowledged

t & t1 : Data flushed to the volume, logs always write through


![](media/sddc/learn.png)**[Learn more about Storage Replica](https://docs.microsoft.com/en-us/windows-server/storage/storage-replica/storage-replica-overview)**


![](media/sddc/security.png)


### Guarded fabric ###


![](media/sddc/security-line.png)

As a cloud service provider or enterprise private cloud administrator, you can use a guarded fabric to provide a more secure environment for VMs. A guarded fabric consists of one Host Guardian Service (HGS) - typically, a cluster of three nodes - plus one or more guarded hosts, and a set of shielded virtual machines (VMs).

![](media/sddc/spacer1.png)![](media/sddc/guarded-fabric.png)

![](media/sddc/learn.png)**[Learn more about guarded fabric](https://docs.microsoft.com/en-us/windows-server/virtualization/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms)**

### Shielded VMs ###

![](media/sddc/security-line.png)

The data and state of a shielded VM are protected against inspection, theft and tampering, from both malware and datacenter administrators.

![](media/sddc/spacer1.png)![](media/sddc/shielded.png)

- Shielded VMs will only run in fabrics designated as owners of the VM.
- Shielded VMs are encrypted by BitLocker, or other means, so that only designated owners can run them.
- Running VMs can be converted to shielded.

![](media/sddc/learn.png)**[Learn more about shielded VMs](https://docs.microsoft.com/en-us/windows-server/virtualization/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms)**

### Host Guardian Service ###

![](media/sddc/security-line.png)

Host Guardian Service holds the keys to legitimate fabrics, as well as encrypted virtual machines.

![](media/sddc/spacer1.png)![](media/sddc/guardian.png)

![](media/sddc/learn.png)**[Learn more about the Host Guardian Service](https://docs.microsoft.com/en-us/windows-server/virtualization/guarded-fabric-shielded-vm/guarded-fabric-manage-hgs)**

### Device Health Attestation ###

![](media/sddc/security-line.png)

Attestation enables enterprises to raise the security bar of their organization to hardware monitored and attested security, with minimal or no impact on operation costs.


![](media/sddc/spacer1.png)![](media/sddc/attestation.png)


Hardware trusted mode, shown above, provides the highest
level of assurance, with TPM v2.0 hardware rooted trust and compliance with code-integrity policy for key-release.


![](media/sddc/learn.png)**[Learn more about Device Health Attestation](https://docs.microsoft.com/en-us/windows-server/security/device-health-attestation)**

![](media/sddc/management.png)

### PowerShell DSC ###

![](media/sddc/management-line.png)

Windows PowerShell Desired State Configuration is a configuration management platform built into Windows that is based on open standards. DSC is flexible enough to function reliably and consistently in each stage of the deployment lifecycle (development, test, pre-production, production), as well as during scale-out.

![](media/sddc/spacer1.png)![](media/sddc/dsc.png)

DSC supports  “continuous deployments,” so you can deploy configurations over and over without breaking anything.

-  DSC configurations only apply settings that have changed from the original for faster deployments.
-  DSC can be used on-premise, in a public, or in a private Cloud environment.
-  You can integrate DSC with any Microsoft or non-Microsoft solution as long as you can execute a PowerShell script on the target system.

![](media/sddc/learn.png)**[Learn more about PowerShell DSC](https://docs.microsoft.com/en-us/powershell/dsc/overview)**


### System Center VMM ###

![](media/sddc/management-line.png)

Virtual Machine Manager is part of the System Center suite, used to configure, manage and transform traditional datacenters to provide a unified management experience across on-premises, service provider, and the Azure cloud.

![](media/sddc/spacer1.png)![](media/sddc/vmm.png)

- Datacenter: Configure and manage datacenter components as a single fabric in VMM. 
- Virtualization hosts: VMM can add, provision, and manage Hyper-V and VMware virtualization hosts and clusters.
- Networking: VMM provides network virtualization, including support for creating and manage virtual networks and network gateways. 
- Storage: VMM can discover, classify, provision, allocate, and assign local and remote storage.

![](media/sddc/learn.png)**[Learn more about System Center VMM](https://docs.microsoft.com/en-us/system-center/vmm/)**

### Operations Manager ###

![](media/sddc/management-line.png)

The core functionality of OMS is provided by a set of services that run in Azure. Each service provides a specific management function, and you can combine services to achieve different management scenarios.

![](media/sddc/spacer1.png)![](media/sddc/oms.png)

Just because OMS services run in the cloud doesn't mean that they can't effectively manage your on-premises environment. Log Analytics can help you analyze data collected from cloud or on-premises services. Use Azure Backup and Azure Site Recovery to leverage the cloud for backup and high availability for on-premises resources.

![](media/sddc/learn.png)**[Learn more about Operations Manager](https://docs.microsoft.com/en-us/system-center/scom/)**

