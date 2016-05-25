---
title: Designing Your Cloud Infrastructure
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 927fa9da-7586-4009-99de-5b9589f15597
---
# Designing Your Cloud Infrastructure
The Build Your Private Cloud Infrastructure Design Guide provides you with the information that you need to make informed decisions about the storage, network and compute design decision points to build a cloud infrastructure that meets the requirements of your organization. This guide provides information that you can use to assess [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] platform technologies that enable a cloud\-based infrastructure.  
  
This Design Guide is focused on the design of the cloud infrastructure and the components that make up a cloud infrastructure. It does not provide information on how build a complete private cloud, public cloud, or hosted cloud infrastructure as a service \(IaaS\), platform as a service \(PaaS\), or software as a service \(SaaS\) solution. The cloud infrastructure contains the building blocks on which any [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] cloud service or delivery model is built.  
  
This document is comprised of the following sections:  
  
-   **Cloud Infrastructure Technical Overview**. This section provides a short overview of cloud computing and the requirements of a cloud infrastructure.  
  
-   **Cloud Infrastructure Design**. This section provides an introduction to the cloud infrastructure design process.  
  
-   **Designing the Cloud Storage Infrastructure**. This section provides information related to design considerations for building the cloud storage infrastructure using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] platform features and capabilities.  
  
-   **Designing the Cloud Network Infrastructure**. This section provides information related to design considerations for building the cloud network infrastructure by using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] platform features and capabilities.  
  
-   **Designing the Cloud Compute \(Virtualization\) Infrastructure**. This section provides information related to design considerations for building the cloud compute \(virtualization\) infrastructure using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] platform features and capabilities.  
  
-   **Overview of Suggested Cloud Infrastructure Deployment Scenarios.** This section provides information on three suggested cloud infrastructure deployment scenarios and the design decisions that drive selecting one over the other.  
  
It should be noted from the beginning that while the terms "cloud" and "private cloud" are used throughout this document, they are used interchangeably. Private cloud, public cloud, and hybrid cloud refer to deployment models for cloud computing and it is assumed that all cloud computing infrastructures share common design considerations. This includes cloud hosting environments, which can host private or public clouds. Therefore, this documentation is topical for corporate IT organizations, private cloud hosting providers, and even public cloud providers who are interested in designing a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] cloud infrastructure.  
  
The primary focus of this Design Guide is to provide design information for the cloud infrastructure that will support the IaaS service model. Subsequent design guides will provide details on how to design, plan and implement a complete IaaS solution.  
  
## Cloud Infrastructure Technical Overview  
  
### NIST Definition of Cloud Computing  
Cloud computing is a model for enabling ubiquitous, on\-demand network access to a shared pool of computing resources \(which include networks, servers, storage, applications, and services\) that can be dynamically and rapidly provisioned and released with minimal human interaction. The United States National Institute of Standards and Technology \(NIST\) definition of cloud computing is one of the more popular and well\-received models, and therefore is used as a basis for understanding and creating a common vocabulary and definition of cloud computing. The NIST definition includes five essential characteristics, three service models, and four deployment models.  
  
#### Essential Characteristics:  
  
-   **On\-demand self\-service**. A consumer of the cloud service can unilaterally and automatically provision computing capabilities, such as server time and network storage, as needed without requiring human interaction with each service provider.  
  
-   **Broad network access**. The ability of a consumer of a cloud service to obtain access to cloud resources from any location, using a wide array of devices.  
  
-   **Resource pooling.** The provider's computing resources are pooled to serve multiple consumers using a multi\-tenant model, with different physical and virtual resources dynamically assigned and reassigned according to consumer demand.  
  
-   **Rapid elasticity.** Capabilities can be elastically provisioned and released, in some cases automatically, to scale rapidly outward and inward commensurate with demand.  
  
-   **Measured service.** Cloud systems automatically control and optimize resource use by taking advantage of a metering capability at some level of abstraction appropriate to the type of service \(for example, storage, processing, bandwidth, and active user accounts\).  
  
It should be noted that in the case of public clouds, broad network access to the cloud is crucial. Broad network access enables the cloud to be accessed through standard mechanisms that promote use by heterogeneous thin or thick client platforms \(for example, mobile phones, tablets, laptops, and workstations\).  Private clouds may or may not require support for broad network access.  
  
#### Service Models:  
  
-   **Software as a service \(SaaS\).** The capability provided to the consumer is to use the cloud service provider's applications running on a cloud infrastructure.  
  
-   **Platform as a service \(PaaS\).** The capability provided to the consumer is to deploy onto the cloud infrastructure consumer\-created or acquired applications created using programming languages, libraries, services, and tools supported by the provider.  
  
-   **Infrastructure as a service \(IaaS\).** The capability provided to the consumer is to provision processing \(compute\), storage, networks, and other fundamental computing resources where the consumer is able to deploy and run arbitrary software, which can include operating systems and applications.  
  
#### Deployment Models:  
  
-   **Private cloud.** The cloud infrastructure is provisioned for exclusive use by a single organization comprising multiple consumers \(for example, business units\).  
  
-   **Community cloud.** The cloud infrastructure is provisioned for exclusive use by a specific community of consumers from organizations that have shared concerns \(for example, mission, security requirements, policy, and compliance considerations\).  
  
-   **Public cloud.** The cloud infrastructure is provisioned for open use by the general public. It might be owned, managed, and operated by a business, academic, or government organization, or some combination of those.  
  
-   **Hybrid cloud.** The cloud infrastructure is a composition of two or more distinct cloud infrastructures \(private, community, or public\) that remain unique entities, but are bound together by standardized or proprietary technology that enables data and application portability \(for example, cloud bursting for load balancing between clouds\).  
  
It is important to note that there is no specific alignment between cloud service and delivery models. Any service model can be instantiated using any of the delivery models. For example, while Software as a Service \(SaaS\) is often considered a public cloud service model, there is no reason why SaaS cannot be delivered in an on\-premises or hosted private cloud.  
  
For more information and a detailed discussion of the NIST definition of private cloud, please see the [NIST Definition of Cloud Computing](http://csrc.nist.gov/publications/nistpubs/800-145/SP800-145.pdf).  
  
### Microsoft Private Cloud Overview  
Private cloud is a computing model that uses infrastructure dedicated to your organization. A private cloud shares many of the characteristics of public cloud computing including resource pooling, self\-service, elasticity, and metered services delivered in a standardized manner with the additional control and customization available from dedicated resources.  
  
The only fundamental difference between a private cloud and a public cloud is that a public cloud provides cloud resources to multiple organizations while the private cloud hosts resources for a single organization. However, a single organization may have multiple business units and divisions which can lend itself to being multi\-tenant in nature. In these circumstances, private cloud shares many of the security and isolation requirements of public cloud.  
  
While virtualization is an important technological enabler of private cloud, the key differentiator is the continued abstraction of computing resources from the infrastructure and the machines \(virtual or otherwise\) used to deliver those resources. Only by delivering this abstraction can you achieve the benefits of cloud computing—including improved agility and responsiveness, reduced total cost of ownership \(TCO\), and increased business alignment and focus. Most importantly, a private cloud promises to exceed the cost effectiveness of a virtualized infrastructure through higher workload density and greater resource utilization.  
  
The Microsoft Private Cloud is a unique and comprehensive offering, built on four key "pillars."  
  
-   **All About the App:** Application\-centric cloud platform that helps you focus on business value.  
  
-   **Cross\-Platform from the Metal Up:** Cross\-platform support for multi\-hypervisor environments, operating systems, and application frameworks.  
  
-   **Foundation for the Future:** Microsoft Private Cloud lets you go beyond virtualization to a true cloud platform.  
  
-   **Cloud on Your Terms:** Ability to consume cloud on your terms, providing you the choice and flexibility of a hybrid cloud model through common management, virtualization, identity, and developer tools.  
  
For further reading on the Microsoft Private Cloud, please see [Microsoft Private Cloud Overview](http://www.microsoft.com/server-cloud/private-cloud/overview.aspx)  
  
### Windows Server 2012 Cloud Infrastructure for Hosting Environments  
A Microsoft cloud infrastructure forms the core compute, storage and networking capabilities that power any of the cloud service or delivery models. This means that, in addition to enterprises, cloud service providers \(CSPs\) or private cloud hosters can also take advantage of the core [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] platform cloud technologies to build hosted cloud solutions to support hosted private and public cloud solutions. The many innovations included with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] enable you to deliver the security, isolation, performance, availability and scalability hosters require for providing commercial cloud services.  
  
### Private Cloud Architecture Principles  
Private cloud principles provide general rules and guidelines to support the evolution of a cloud infrastructure, whether they be on\-premises or in a hosted cloud environment. They are enduring, seldom amended, and inform and support the way a cloud fulfills its mission and goals. They also strive to be compelling and aspirational in some respects, since there needs to be a connection with business drivers for change. These principles are often interdependent and together form the basis on which a cloud infrastructure is planned, designed, and created:  
  
-   Resource Pooling  
  
-   Elasticity and Perception of Infinite Capacity  
  
-   Perception of Continuous Availability  
  
-   Drive Predictability  
  
-   Metering\/Chargeback \(Service Provider's Approach to Delivering IT\)  
  
-   Multi\-tenancy  
  
-   Security and Identity  
  
All decisions regarding how the cloud infrastructure is designed should keep the principles in mind. For a detailed discussion of the private cloud principles, please see [Private Cloud Principles, Concepts, and Patterns](http://social.technet.microsoft.com/wiki/contents/articles/4346.private-cloud-principles-patterns-and-concepts.aspx).  
  
### The Private Cloud Reference Model  
IaaS is an application of the private cloud architecture principles to deliver a cloud infrastructure. You can use the reference model displayed in the following figure to ensure that you are delivering a holistic solution that spans all the layers required for a mature IaaS solution. The model acts as the "guide\-rails" to assist cloud infrastructure designers' and architects' efforts to holistically address the development of a private cloud architecture. This model is used as a reference only, and some pieces are emphasized more than others in the technical reference architecture based on experience operating private clouds in real\-world environments.  
  
![](../Image/PScen_Hst_Cld_Dsgn_2_private-cloud-reference-model.gif)  
  
**Figure 1. The private cloud reference model—IaaS view**  
  
The primary focus of this document is on the Infrastructure section of the Private Cloud Reference Model, where the focus is on the core network, compute, and storage components that let you build a cloud\-ready infrastructure. However, we do not cover issues that apply to facilities considerations.  
  
For more information and comprehensive coverage of the private cloud reference model, please see [Private Cloud Reference Model](http://social.technet.microsoft.com/wiki/contents/articles/4399.private-cloud-reference-model.aspx).  
  
### Conceptual Architecture—Infrastructure  
One of the key drivers of the layered approach to the infrastructure architecture presented here is to enable complex workflow and automation to be developed over time by creating a collection of simple automation tasks, assembling them into procedures that are managed by the management layer, and then creating workflows and process automation that are controlled by the orchestration layer. However, before you can implement these key features of a cloud solution, you need to understand key definitions and design points relevant to a well architected cloud infrastructure. The cloud infrastructure should address the following components:  
  
1.  Scale Units  
  
2.  Storage  
  
3.  Networking  
  
4.  Virtualization platform  
  
#### Scale Units  
In a modular architecture, the concept of a scale unit refers to the point where a module in the architecture can scale to before another module is required. For example, an individual server is a scale unit, it can be expanded to a certain point in terms CPU and RAM but beyond its maximums, an additional server is required to continue scaling. Each scale unit also has an associated amount of physical installation labor, configuration labor, and other labor overhead. With large scale units such as a pre\-configured full rack of servers, the labor overhead can be minimized. When designing a cloud infrastructure, care should be taken to define the size of a scale unit.  
  
Server scale limits are well published and include number and speed of CPU cores, maximum amount and speed of RAM, number and type of expansion slots, and so on. Particularly important are the number and type of onboard input\/output \(I\/O\) ports and the number and type of supported I\/O cards. Infiniband, Ethernet, SAS \(Serial Attached SCSI\) and Fibre Channel expansion cards often provide multi\-port options where a single card can have 4 ports. Additionally, in blade server architectures, there are often limitations in the amount of I\/O card and\/or supported combinations. It is important to be aware of these limitations and the oversubscription ratio between blade I\/O ports and any blade chassis switch modules.  
  
A single server is not a good scale unit for a private cloud solution due to the amount of overhead required to install and configure an individual server. Instead, scale units should be designed with considerations regarding historical rates of growth and how often your organization wants to add capacity to the infrastructure while providing adequate lead time so that overall service levels are not negatively impacted at any point in time. Instead, scale units should be designed with considerations regarding historical rates of growth and how often your organization wants to add capacity to the infrastructure while providing adequate lead time so that overall service levels are not negatively impacted at any point in time. Scale units should also take advantage of the private cloud principle of homogeneity.  
  
For more information about scale units, please the [Private Cloud Principles, Concepts, and Patterns](http://social.technet.microsoft.com/wiki/contents/articles/4346.private-cloud-principles-patterns-and-concepts.aspx).  
  
#### Storage  
Storage architecture is a critical design consideration for private cloud solutions. Storage and supporting storage networking are critical to the overall performance of the environment in addition to the overall cost, because storage tends to be one of the more costly items.  
  
Storage architectures today have several layers including the storage array\(s\), the storage network, the storage protocol, and for virtualization, the file system utilizing the physical storage.  
  
The traditional approach to storage arrays and storage protocols was to install a Storage Area Network \(SAN\) solution directly connected to the cloud compute \(virtualization\) cluster using either iSCSI or Fibre Channel. This storage design pattern provided for the key performance, reliability, availability and scalability requirements for enterprise storage, all of which are critical factors when considering storage design for a cloud infrastructure.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides a new option that can satisfy these cloud infrastructure storage requirements: Storage Spaces. Storage Spaces in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] enables cost\-effective, optimally used, highly available, scalable, and flexible storage solutions for business\-critical \(virtual or physical\) deployments. You can use cost\-effective SAS drives in a JBOD \(Just a Bunch of Disks\) enclosure with Storage Spaces and benefit from many of the same capabilities of expensive SAN\-based storage arrays.  
  
Historically, iSCSI and Fibre Channel have been the storage protocols of choice. However, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] offers another option – file based storage over SMB 3.0. Using this approach, you can create separate compute and storage clusters that enable you to scale compute and storage independently. This also has the potential to greatly simplify your cloud infrastructure as management of file shared based storage is typically simpler than SAN storage. The SMB 3.0 protocol makes it possible for the compute cluster to access the storage cluster at near Direct Attached Storage \(DAS\) speeds over a 10 Gbps network fabric.  
  
In addition to highly available storage over SMB 3.0, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] cloud infrastructure administrators have the option to use another file based storage option – NFS high\-availability transparent failover. This makes it possible to deploy Server for NFS in a clustered configuration and take advantage of better resilience to hardware and software outages that may afflict individual cluster nodes.  
  
We will cover detailed cloud storage infrastructure design decisions later in this document.  
  
#### Networking  
Many network architectures include a tiered design with three or more tiers such as core, distribution, and access. Designs are driven by the port bandwidth and quantity required at the edge, in addition to the ability of the distribution and core tiers to provide higher speed uplinks to aggregate traffic. Additional considerations include Ethernet broadcast boundaries and limitations, spanning tree or other loop\-avoidance technologies.  
  
A dedicated management network is a frequent feature of advanced data center virtualization solutions. Most virtualization vendors recommend that hosts be managed via a dedicated network so that there is no competition with tenant traffic and to provide a degree of separation for security and ease of management purposes. This historically implied dedicating a network adapter per host and port per network device to the management network. However, with new technologies included with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], dedicating network adapters to each traffic class is no longer required or recommended. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes new capabilities that enable you to converge your network traffic classes to a single NIC or NIC team.  
  
With advanced data center virtualization, a frequent use case is to provide isolated networks where different owners such as particular departments or applications are provided their own dedicated networks. In the past, multi\-tenant networking referred to using technologies such as virtual local area networks \(VLANs\) or Internet Protocol Security \(IPsec\) isolation techniques to provide dedicated networks that utilize a single network infrastructure or wire. However, VLANs are complex to configure and manage, and are not scalable past 4094 VLANs. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Hyper\-V includes a number of improvements in the Hyper\-V virtual switch that enable you to get the isolation you need without using VLANs by providing new features such as Private VLANs \(PVLANs\), Port ACLs and virtual networking, sometimes referred to as software defined networking \(SDN\).  
  
Managing the network environment in a private cloud can present challenges that must be addressed. Ideally, network settings and policies are defined centrally and applied universally by the management solution, such as the Virtual Machine Manager component of Microsoft System Center 2012 with Service Pack 1 \(SP1\). In the case of IPsec\-based isolation, this can be accomplished using Active Directory Domain Services \(AD DS\) and Active Directory Group Policy to control firewall settings across the hosts and guests, in addition to the IPsec policies controlling network communication. In addition, you can optimize VM density when using IPsec because [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] now includes support for IPsec Talk Offload \(IPsecTO\) for guest virtual machines.  
  
For VLAN\-based network segmentation, several components including the host servers, host clusters, Virtual Machine Manager, and the network switches must be configured correctly to enable both rapid provisioning and network segmentation. With Hyper\-V and host clusters, identical virtual switches should be defined on all nodes in order for a virtual machine to be able to failover to any node and maintain its connection to the network. At large scale, this can be accomplished via Windows PowerShell scripting.  
  
In a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]–based cloud infrastructure, VLAN assignments are typically limited to the major traffic classes; these are the host traffic and tenant traffic classes. Bandwidth guarantees can be assigned using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Quality of Service \(QoS\) so that subclasses of traffic, such as cluster traffic, management traffic, live migration traffic, and storage traffic, have the bandwidth they require. In addition, it's important to minimize or avoid the use of VLANs for tenant traffic, as VLANs exclude the option of using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Network Virtualization. We will discuss cloud infrastructure network design decisions in detail later in this document.  
  
#### Virtualization Platform  
The virtualization layer is one of the primary enablers for private cloud. The decoupling of hardware, operating systems, data, applications, and user state opens a wide range of options for optimal management and distribution of workloads across the physical infrastructure. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Hyper\-V provides the ability to migrate running virtual machines from one server to another with zero downtime and many other Hyper\-V features that provide a rich set of capabilities. These capabilities can be utilized by the automation, management, and orchestration layers to maintain desired states \(such as load distribution\) or to proactively address decaying hardware or other issues that would otherwise cause faults or service disruptions.  
  
As with the hardware layer, the virtualization layer must be able to be managed by the automation, management, and orchestration layers. The abstraction of software from hardware that virtualization provides moves the majority of management and automation into the software space, instead of requiring you to perform manual operations on physical hardware.  
  
## Cloud Infrastructure Design  
In the next three sections we will discuss design considerations and options for designing a cloud infrastructure using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] platform capabilities. This discussion will include design discussions around:  
  
1.  Storage architecture  
  
2.  Network architecture  
  
3.  Compute \(virtualization and cluster\) architecture  
  
After a review of the design decisions you will need to make around the storage, network and compute architectures, there will be a discussion on three design patterns that based on key design decisions made in each of these domains.  
  
### Designing the Cloud Storage Infrastructure  
The storage design for any virtualization\-based solution is a critical element that is typically responsible for a large percentage of the solution's overall cost, performance, and agility.  
  
The storage solution should provide transport\-independent, seamless data access using block\-level and\/or file\-level protocols from the same platform. A storage solution can provide block\-level data access over a Fibre Channel SAN fabric using Fibre Channel Protocol \(FCP\) and over an IP\-based Ethernet network using iSCSI or Fibre Channel over Ethernet \(FCoE\). Infiniband is another option for high performance storage networking. File\-access protocols such as NFS, SMB 3.0, HTTP, or FTP provide file\-level access over an IP\-based Ethernet network.  
  
#### Storage Options  
This section discusses a number of storage options available to you that will inform some key design decisions you need to make when considering alternatives. Specific options discussed include:  
  
1.  Storage protocols  
  
2.  Storage network  
  
3.  Cluster Shared Volumes \(CSVs\)  
  
#### Storage Protocols  
Although many storage options exist, organizations should choose their storage devices based on their specific data\-management needs. Storage devices are typically modular and flexible midrange and high\-end SANs. Modular midrange SANs are procured independently and can be chained together to provide greater capacity. They are efficient, can grow with the environment as needed, and require less up\-front investment than high\-end SANs. Large enterprises and hosters might have larger storage demands and might need to serve a larger set of customers and workloads. In this case, high\-end SANs can provide the highest performance and capacity. High\-end SANs typically include more advanced features such as continuous data availability through technologies like replication and clustering. However, the price of these high\-end SANs can be prohibitive, and you should factor in the costs with the value provided over other options.  
  
Fibre Channel has historically been the storage protocol of choice for enterprise data centers for a variety of reasons, including good performance and low latency. Over the past several years, however, the advancing performance of Ethernet from 1 Gbps to 10 Gbps and beyond has led to great interest in storage protocols that make use of Ethernet transport—such as iSCSI, and more recently FCoE. SMB 3.0 can also be used for file based storage access and provide the same or superior performance when compared to iSCSI of FCoE.  
  
A key advantage of the protocols that use the Ethernet transport is the ability to use a "converged" network architecture in which a single Ethernet infrastructure serves as the transport for both LAN and storage traffic. FCoE is an emerging technology that brings the benefits of using an Ethernet transport while retaining the advantages of the Fibre Channel protocol and the ability to use Fibre Channel storage arrays. SMB 3.0 can be used to connect to file servers that host virtual machine files. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is designed to fully support a converged network infrastructure.  
  
In the past a common practice in large\-scale Hyper\-V deployments was to use both Fibre Channel and iSCSI. Fibre Channel and iSCSI can provide the host storage connectivity. Similarly, both Fibre Channel and iSCSI can be used directly by guests—for example, for the shared disks in a guest cluster. This is made possible by the new [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] feature that surfaces Fibre Channel HBAs to guest virtual machines. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] SMB 3.0 can provide the same advantages. In addition, with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] you can take advantage of a new storage option called Storage Spaces where you can attach SAS JBODs to a file server cluster and access the virtual machine files from the compute cluster from over the Ethernet network.  
  
> [!NOTE]  
> [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] now supports Offload Data Transfer \(ODX\) which is a new high performance storage protocol that significantly reduces the processing and time it takes to copy files from one storage unit to another. You can learn more about ODX at [Windows Offloaded Data Transfers overview](http://technet.microsoft.com/library/hh831628.aspx).  
  
#### Storage Network  
iSCSI, SMB 3.0 and FCoE use an Ethernet transport for storage networking. This provides another architecture choice in terms of whether to use a dedicated Ethernet network with separate switches, cables, paths, and other infrastructure or, instead, to use a converged network in which multiple traffic types are run over the same cabling and infrastructure.  
  
The storage solution must provide logical or physical isolation between storage and Ethernet I\/O. If it's a converged network, QoS must be provided to guarantee storage performance. The storage solution must provide iSCSI or Fibre Channel connectivity for guest clustering and fully redundant, independent paths for storage I\/O.  
  
Standards\-based converged network adapters, switches, and Fibre Channel storage arrays should be used for FCoE. If iSCSI, FCoE or SMB 3.0 is used, you can assign a dedicated network adapter for storage traffic or use [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] new Hyper\-V switch capabilities to create a converged network infrastructure.  
  
#### Cluster Shared Volumes  
CSVs \(Cluster Shared Volumes\) provide a distributed file\-access solution so that multiple nodes in the cluster can simultaneously access the same NTFS file system. For example, virtual machines that are distributed across multiple cluster nodes can access their virtual hard disk \(VHD\) files, even if the VHD files are on a single disk \(logical unit number \[LUN\]\) in storage. This also enables virtual machines to move to any node in the cluster, since each cluster node has access to files contained in the CSV. The clustered virtual machines can also all fail over independently of one another and no longer present themselves as a single resource group.  
  
The following is a partial list of new CSV functionality in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] that you can use to when designing the shared storage infrastructure for your private cloud:  
  
-   Storage system for scale\-out file servers, which can provide continuously available and scalable file\-based SMB server application storage. The scale\-out file server feature is used when you choose to host the virtual machine files in a storage cluster. For more information, see [Support for scale\-out file servers](http://technet.microsoft.com/library/hh831414.aspx).  
  
-   A single consistent file name space, with CSV volumes that now appear as CSV File System \(CSVFS\). The underlying technology is still the NTFS file system, and volumes are still formatted with NTFS. In a clustered environment, the CSV must be formatted as NTFS as ReFS is not supported on CSVs in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   Direct I\/O for file data access, including sparse files, which enhances virtual machine creation and copy performance. Redirected I\/O is used when Storage Spaces is deployed using either mirrored or parity based resiliency.  
  
-   No external authentication dependencies, which provides improved performance and resiliency. The cluster can now start and the CSV will be mounted even if an Active Directory domain controller is not available when the cluster reboots.  
  
-   Support for SMB 3.0 storage for Hyper\-V and applications such as SQL Server. For more information on SMB 3.0 functionality, see [Server Message Block overview](http://technet.microsoft.com/library/hh831795.aspx).  
  
-   Integration with SMB Multichannel and SMB Direct, which allow CSV traffic to stream across multiple networks in the cluster and to take advantage of network adapters that support remote direct memory access \(RDMA\). SMB also provides for transparent failover so that in the event that a member of the file server cluster becomes unavailable, connections to the virtual machine files continue to be available and with no downtime.  
  
-   Support for BitLocker Drive Encryption for CSVs in addition to traditional cluster disks. This is particularly useful when clusters are deployed in branch offices and other low security environments.  
  
-   The capability to make storage visible to only a subset of nodes, which enables scenarios for a single cluster that contains application and data nodes. This is an example of an "asymmetric storage cluster". In this design pattern, some of the nodes in the cluster are connected to storage and some of the nodes are dedicated to the compute role. The compute nodes then connect to file based storage over the SMB 3.0 protocol.  
  
-   Integration with the Storage Spaces feature in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], which can provide virtualized storage on clusters of inexpensive SAS disks. For more information about Storage Spaces, see [File and Storage Services overview](http://technet.microsoft.com/library/hh831487.aspx).  
  
-   Ability to scan and repair volumes with zero offline time due to new capabilities deliver by the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] CHKDSK application. For more information on advances in CHKDSK, please see [Multi\-terabyte volumes](http://technet.microsoft.com/library/hh831536.aspx).  
  
CSVs provide not only shared access to the disk, but also storage path I\/O fault tolerance \(dynamic I\/O redirection\). In the event the storage path on one node becomes unavailable, the I\/O for that node will be rerouted via SMB 3.0 through another node. This feature can use any Cluster Communications Network and further increases the need for high\-speed 10 GB Ethernet networks.  
  
CSVs maintain metadata information about the volume access and require that some I\/O operations take place over the cluster communications network. One node in the cluster is designated as the coordinator node and is responsible for these disk operations. Virtual machines, however, have direct I\/O access to the volumes, and only use the dedicated storage paths for disk I\/O, unless a failure scenario occurs as described above. The exception to this is with Storage Spaces when resiliency is added to the CSV.  
  
#### CSV Requirements  
Requirements for implementing a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] private cloud that uses CSVs include:  
  
-   All cluster nodes must use [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   All cluster nodes must use the same drive letter for the system disk.  
  
-   All cluster nodes must be on the same logical network subnet.  
  
-   SMB must be enabled for each network on each node that will carry CSV cluster communications.  
  
-   "Client for Microsoft Networks" and "File and Printer Sharing for Microsoft Networks" must be enabled in the network adapter's properties to enable all nodes in the cluster to communicate with the CSV.  
  
-   The Hyper\-V role must be installed on any cluster node that might host a virtual machine.  
  
Note that when you configure the failover cluster using the failover cluster wizard, most of these configuration requirements will be handled for you.  
  
#### CSV Volume Sizing  
Because all cluster nodes can access all CSV volumes simultaneously, you can now use standard LUN allocation methodologies based on performance and capacity requirements of the workloads running within the virtual machines themselves. In general, it's considered a good idea to isolate the virtual machine operating system I\/O from the application data I\/O, in addition to application\-specific I\/O considerations such as segregating databases and transaction logs and creating SAN volumes and\/or Storage Spaces–based storage pools that factor in the I\/O profile itself \(for example, random read and write operations versus sequential write operations\).  
  
CSV architecture differs from traditional clustered file systems, which frees it from common scalability limitations. As a result, there is no special guidance for scaling the number of Hyper\-V nodes or virtual machines on a CSV volume other than ensuring that the overall I\/O requirements of the expected virtual machines running on the CSV are met by the underlying storage system and storage network.  
  
While rare, disks and volumes can enter a state where a chkdsk is required, which with large disks can take a long time to complete, causing downtime of the volume during this process somewhat proportional to the volume's size. However, significant improvements have been made to the chkdsk feature in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] so that for even very large volumes with tens of millions of files, it should not take more than a minute to complete the check.  
  
Each enterprise application you plan to run within a virtual machine can have unique storage recommendations and even perhaps virtualization\-specific storage guidance. That guidance applies to use with CSV volumes as well. The important thing to keep in mind is that all virtual machine virtual disks running on a particular CSV will contend for storage I\/O.  
  
Also worth noting is that individual SAN LUNs do not necessarily equate to dedicated disk spindles. A SAN Storage Pool or redundant array of independent disks \(RAID\) array can contain many LUNs. A LUN is simply a logical representation of a disk provisioned from a pool of disks. Therefore, if an enterprise application requires specific storage I\/O per second \(IOPS\) or disk\-response times you must consider all the LUNs in use on that Storage Pool. An application which would require dedicated physical disks were it not virtualized might require dedicated Storage Pools and CSV volumes running within a VM.  
  
> [!NOTE]  
> When considering the use of Storage Spaces to host your CSVs, you might want to consider the fact that when enabling resiliency for the CSV, only a single node can write to it directly; the other nodes will use I\/O redirection to the coordinator node in this scenario. For this reason, you may want to create multiple CSVs \(perhaps one per cluster member\) and distribute your virtual machine files across the CSVs so that a single node does not receive a disproportionate amount of network traffic due to I\/O redirection.  
  
#### CSV Design Patterns  
  
##### Single CSV per Cluster  
In the Single CSV per Cluster design pattern, storage is configured to present a single large LUN to all the nodes in the cluster. The LUN is configured as a CSV in Failover Clustering. All virtual\-machine related files \(such as VHDs and configuration files\) belonging to the virtual machines hosted on the cluster are stored on the CSV. Optionally, data deduplication functionality provided by the SAN or the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] deduplication feature can be utilized. Note that when you configure a file server cluster using the scale\-out file server capability, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] deduplication will not be available. However, you can still take advantage of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] data deduplication in your virtual machine libraries.  
  
##### Multiple CSVs per Cluster  
In the Multiple CSVs per Cluster design pattern, storage is configured to present two or more large LUNs to all the nodes in the host cluster. The LUNs or Storage Spaces virtual disks are configured as a CSV in Failover Clustering. All virtual\-machine related files \(such as VHDs and configuration files\) belonging to the virtual machines hosted on the cluster are stored on the CSVs. Optionally, data deduplication functionality provided by the SAN or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] deduplication can be utilized, with some limitations as previously mentioned.  
  
For both the Single and Multiple CSV patterns, each CSV has the same I\/O characteristics, so each individual virtual machine has all its associated VHDs stored on one of the CSVs. Alternatively, you can use storage tiering and assign CSVs to different tiers. This is useful if you want to present storage options as part of your private cloud service catalog.  
  
##### Multiple I\/O Optimized CSVs per Cluster  
In the Multiple I\/O Optimized CSVs per Cluster design pattern, the SAN is configured to present multiple LUNs or Storage Spaces virtual disks to all the nodes in the cluster but they are optimized for particular I\/O patterns such as fast sequential read performance, or fast random write performance. The volumes are configured as CSVs in Failover Clustering. All VHDs belonging to the virtual machines hosted on the cluster are stored on the CSVs but targeted to the most appropriate CSV for the given I\/O needs.  
  
In the Multiple I\/O Optimized CSVs per Cluster design pattern, each individual virtual machine has all its associated VHDs stored on the appropriate CSV following required I\/O requirements.  
  
Note that a single virtual machine can have multiple VHDs, and each VHD can be stored on a different CSV \(provided all CSVs are available to the host cluster the virtual machine is created on\).  
  
In addition, you can further optimize the CSV I\/O by taking advantage of CSV read caching with write through. Learn more about this capability at [How to enable CSV Cache](http://blogs.msdn.com/b/clustering/archive/2012/03/22/10286676.aspx).  
  
#### Storage Design  
A highly available storage design, which could use either a SAN or SAS\-based JBOD solution and Storage Spaces, should have no single points of failure, including:  
  
-   Redundant power from independent power distribution units \(PDUs\)  
  
-   Redundant storage controllers  
  
-   Redundant storage paths \(supported, for example, by redundant target ports of network adapters per controller, redundant Fibre Channel or IP network switches, and redundant cabling\)  
  
-   Data storage redundancy similar to what occurs with volume mirroring or parity, or synchronous or asynchronous replication  
  
You will need to address the following elements when designing or modifying your storage solution as the basis of your Microsoft Private Cloud storage infrastructure:  
  
-   Performance  
  
-   Drive types  
  
-   Multipathing  
  
-   Fibre Channel SAN  
  
-   iSCSI SAN  
  
-   Storage Spaces  
  
-   Data deduplication  
  
-   Thin provisioning  
  
-   Volume cloning  
  
-   Volume snapshot  
  
#### Performance  
Storage performance is a mix of drive, interface, controller, cache, protocol, SAN, host bus adapter \(HBA\), driver, and operating system considerations. The overall performance of the storage architecture is typically measured in terms of maximum throughput and\/or maximum IOPS for a given latency or response time. Although each of these performance measurements is important, IOPS for a given latency is the most relevant to server virtualization in private cloud environments.  
  
Another important consideration is what type of cloud infrastructure do you want to provide? In most cases the private cloud will present a general purpose infrastructure that is not designed around specific workloads. Workloads that require specific disk performance characteristics that lie outside the capabilities of a general purpose private cloud infrastructure may be better served by creating a dedicated infrastructure for those workloads.  
  
#### Drive Types  
The type of hard drive used in the host server or the storage array has the most significant impact on the overall storage architecture performance. As with storage connectivity, high IOPS and low latency are more critical than maximum sustained throughput when it comes to host server sizing and guest performance. When selecting drives, this translates into selecting those with the highest rotational speed and lowest latency possible. Using 15K revolution per minute \(RPM\) drives over 10K RPM drives can result in up to 35 percent more IOPS per drive.  
  
You will also want to consider storage tiering, so that you can provide options to consumers of the cloud service. A storage tiering scheme might include a high\-performance tier, a medium\-performance tier, and a high\-capacity tier. These tiers can be included in the service catalog. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes support for newer 4K high\-capacity drives, which can be part of one or more storage tiers. In addition, SSD drives will become the norm in the future as prices continue to come down on this ultra\-fast storage option.  
  
#### Multipathing  
In order to support a highly resilient private cloud storage infrastructure, multipathing should be used. Among the features enabling high availability for connecting servers based on Windows to SANs is integrated Multipath I\/O \(MPIO\) support. Microsoft MPIO architecture supports iSCSI, Fibre Channel, and SAS SAN connectivity by establishing multiple sessions or connections to the storage array. Multipathing solutions use redundant physical path components—adapters, cables, and switches—to create logical paths between the server and the storage device. In the event that one or more of these components fails, causing the path to fail, multipathing logic uses an alternate path for I\/O so that applications can still access their data. Each Ethernet interface or HBA should be connected by using redundant switch infrastructures to provide continued access to storage in the event of a failure in a storage fabric component.  
  
Failover times vary by storage vendor, and can be configured by using timers in the Microsoft iSCSI Software Initiator driver, or modifying the Fibre Channel host bus adapter driver parameter settings.  
  
#### Fibre Channel SAN  
Fibre Channel is a robust and high\-speed storage protocol that supports multipathing through Microsoft [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] MPIO. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides Fibre Channel ports for both host and guest operating systems. Support for guest operating system connectivity through Fibre Channel is new in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and allows you to connect to Fibre Channel directly from within virtual machines. This feature enables you to virtualize workloads that use direct access to Fibre Channel storage and allows you to cluster guest operating systems over Fibre Channel.  
  
Mid\-range and high\-end storage arrays are capable of advanced storage functionality that helps offload certain management tasks from the hosts to the SANs. Virtual Fibre Channel presents an alternate hardware\-based I\/O path to the Windows software virtual hard disk stack. This allows you to use the advanced functionality offered by your Fibre Channel SANs directly from Hyper\-V virtual machines. For example, you can use Hyper\-V to offload storage functionality \(for example, taking a snapshot of a LUN\) on the SAN hardware by using a hardware volume shadow copy service \(VSS\) provider from within a Hyper\-V virtual machine.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Hyper\-V allows you to define virtual SANs on the host to accommodate scenarios where a single Hyper\-V host is connected to different SANs through multiple Fibre Channel ports. A virtual SAN defines a named group of physical Fibre Channel ports that are connected to the same physical SAN. For example, assume that a Hyper\-V host is connected to two SANs—a production SAN and a test SAN. The host is connected to each SAN through two physical Fibre Channel ports. In this example, you might configure two virtual SANs—one named "Production SAN" that has the two physical Fibre Channel ports connected to the production SAN, and one named "Test SAN" that has two physical Fibre Channel ports connected to the test SAN. You can use the same technique to name two separate paths to a single storage target.  
  
You can configure as many as four virtual Fibre Channel adapters on a virtual machine and associate each one with a virtual SAN. Each virtual Fibre Channel adapter connects with one WWN address or two WWN addresses to support live migration. You can set each WWN address automatically or manually.  
  
Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] can use the multipath I\/O \(MPIO\) functionality to ensure continuous connectivity to Fibre Channel storage from within a virtual machine.  
  
You can use MPIO functionality with Fibre Channel in the following ways:  
  
-   Virtualize workloads that use MPIO. Install multiple Fibre Channel ports on the host, and use MPIO to provide highly available connectivity to the LUNs accessible by the host.  
  
-   Configure multiple virtual Fibre Channel adapters inside a virtual machine, and use a separate copy of MPIO within the guest operating system of the virtual machine to connect to the LUNs that the virtual machine can access. This configuration can coexist with a host MPIO setup.  
  
-   Use different DSMs for the host or each virtual machine. This approach allows live migration of the virtual machine configuration, including the configuration of DSM and connectivity between hosts and compatibility with existing server configurations and DSMs.  
  
#### iSCSI SAN  
Unlike a Fibre Channel–connected SAN, which is on its own Fibre Channel network, the iSCSI SAN can be on its own isolated Ethernet or Infiniband network or it can benefit from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] capabilities that enable converged networking to support isolation that is so critical in a multi\-tenant architecture. Any networking standard practice method for achieving this goal is acceptable, including a physically separate, dedicated storage network and a physically shared network with the iSCSI SAN running on a private VLAN. Alternatively, you can use new QoS and port access control list \(ACL\) features in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to converge the storage network with other non\-tenant and tenant network flows.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the iSCSI Software Target is available as a built\-in feature under the File and Storage Service role. As an inbox feature, the management experience is integrated with Server Manager and the failover cluster management console.  
  
When used in a cloud infrastructure, the iSCSI Software Target is ideal for:  
  
-   **Network\/diskless boot:** By using boot\-capable network adapters or a software loader, you can deploy hundreds of diskless host servers. This is ideal for large deployments of identical operating system images, such as a Hyper\-V compute cluster.  
  
-   **Server application storage:** Some applications require block storage. The iSCSI Software Target can provide these applications with continuously available block storage. Since the storage is remotely accessible it can also consolidate block storage for central or branch office locations.  
  
-   **Heterogeneous storage:** iSCSI Software Target supports non\-Windows iSCSI initiators, making it easy to share storage on Windows Servers in a mixed environment.  
  
-   **Development\/test\/demo\/lab clouds:** When the iSCSI Software Target feature is enabled, it turns any server running Windows Server into a network\-accessible block storage device. This is ideal for testing applications prior to deployment on SAN storage.  
  
Enabling Microsoft iSCSI Software Target to provide block storage takes advantage of your existing Ethernet network. No additional hardware is needed. To obtain high availability, consider setting up a highly available storage cluster. With a highly available storage cluster, you will need shared storage for the cluster—such as Fibre Channel storage or an SAS storage array, which can be configured to use Storage Spaces.  
  
If you enable guest clustering, you need to provide block storage. Any servers running Windows Server software with Microsoft iSCSI Software Target can provide block storage. An iSCSI Target Server enables you to network boot multiple computers from a single operating system image that is stored in a centralized location. iSCSI Software Target in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] can boot hundreds of computers by using a single operating system image, and it provides the several key benefits.  
  
For example, by using differencing virtual disks, you can use a single operating system image \(the "golden image"\) to boot up to 256 computers. In a deployment of Windows Server 2008 R2 HPC Edition, the operating system image is approximately 20 GB. A common deployment is to have two mirrored disk drives that act as the boot volume. Rounding the operating system storage to 40 GB per instance, you would need approximately 10 TB of storage—for only the operating system image—to boot 256 computers. With iSCSI Software Target boot, however, you will use 40 GB for the operating system base image, and 2 GB for differencing virtual hard disks \(VHDs\) per server instance, totaling 552 GB for the operating system images. This provides a savings of over 90 percent on storage for the operating system images alone.  
  
Other advantages to using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] iSCSI Target Boot in your private cloud storage infrastructure include:  
  
-   **Controlled operating system images make it more secure and easy to manage.** Some enterprises require that data be secured by physically locking storage in a centralized location. In this scenario, servers access the data remotely, including the operating system image. With iSCSI Software Target boot, you can centrally manage the operating system boot images, and control which applications to put in the golden image.  
  
-   **Rapid deployment.** Because the golden image is a sysprepped operating system image, when the computers boot from the golden image, they skip the file copying and installation phase that occurs during Windows Setup, and they go straight to the customization phase. In our testing, we deployed 256 computers in 34 minutes.  
  
-   **Fast recovery.** Because the operating system images are hosted on the iSCSI Target Server, if the diskless client needs to be replaced, the new computer can point to the operating system image, and boot up immediately.  
  
-   **Centralized updating of the golden image.** You can update all host systems in your private cloud by updating the golden image. When cluster members are restarted they reboot from the new golden image. Post\-boot tasks can be integrated into the cloud fabric controller so that the updated server is joined back into the cluster.  
  
SAN boot is a solution that has been offered from various vendors. Now with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the new iSCSI Software Target feature provides this network boot capability on commodity hardware which can lead to significant cost savings since there are no special hardware requirements. In data centers with large\-scale deployments, the design should be validated against specific hardware.  
  
> [!NOTE]  
> For reference, Microsoft internal testing indicated that for a 256\-iSCSI boot deployment, 24 x 15k\-RPM disks in a RAID 10 configuration were required for storage. A network bandwidth of 10 GB is optimal. A general estimate is 60 iSCSI boot servers per 1 GB network adapter. However, an iSCSI boot\-capable network adapter is not required for this scenario. If the network adapter does not support it, a software boot loader can be used \(such as iPXE open source boot firmware\).  
  
#### Storage Spaces  
Storage Spaces in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] enables cost\-effective, optimally used, highly available, scalable, and flexible storage solutions for business\-critical \(virtual or physical\) deployments. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] delivers sophisticated storage virtualization capabilities, which enables you to use cost\-effective industry\-standard storage, for single\-node and scalable multi\-node deployments  
  
Storage Spaces delivers storage virtualization capabilities within [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. The storage stack has been fundamentally enhanced to incorporate two new abstractions:  
  
-   Storage pools are administrative units of physical disks. Pools permit storage aggregation, elastic capacity expansion, and delegated administration.  
  
-   Storage spaces are virtual disks with associated attributes such as a desired level of resiliency, thin or fixed provisioning, automatic or controlled allocation on heterogeneous storage media, and precise administrative control.  
  
Storage Spaces is completely integrated with failover clustering for high availability, and it is integrated with CSV for scale\-out deployments. Storage Spaces includes the following features:  
  
1.  **Storage pools**. Storage pools are the fundamental building blocks for Storage Spaces. You can flexibly create storage pools based on the needs of the deployment. For example, given a set of physical disks, you can create one pool \(by using all the available physical disks\) or multiple pools \(by dividing the physical disks as required\). Furthermore, to maximize the value from storage hardware, you can map a storage pool to combinations of hard disks as well as solid\-state drives \(SSDs\). Pools can be expanded dynamically by simply adding drives.  
  
2.  **Multitenancy**. Administration of storage pools can be controlled through access control lists \(ACLs\) and delegated on a per\-pool basis, supporting hosting scenarios that require tenant isolation. Storage Spaces follows the familiar Windows security model; therefore, it can be fully integrated with Active Directory Domain Services.  
  
3.  **Resilient storage**. Storage Spaces support two optional resiliency modes: mirroring and parity. Per\-pool support for disks that are reserved for replacing failed disks \(hot spares\), background scrubbing, and intelligent error correction allow continuous service availability despite storage component failures. Note that only the mirroring option is available when deploying resiliency to cluster shared volumes.  
  
4.  **Continuous availability**. Storage Spaces is fully integrated with failover clustering, which allows it to deliver continuously available service deployments. One or more pools can be clustered across multiple nodes within a single cluster. Storage spaces can then be instantiated on individual nodes, and the storage will seamlessly fail over to a different node when necessary \(in response to failure conditions or due to load balancing\). Integration with CSVs permits scale\-out access to data.  
  
5.  Optimal storage use. Server consolidation often results in multiple data sets sharing the same storage hardware. Storage Spaces supports thin provisioning to allow businesses to easily share storage capacity among multiple unrelated data sets and thereby maximize capacity use. Trim support permits capacity reclamation when possible.  
  
    Storage Spaces is the ideal cost\-effective solution for cloud infrastructures that are designed to support a generic population of virtual workloads that do not require specialized storage requirements or exceptional IOPS.  
  
#### Data Deduplication  
Data deduplication can yield significant storage cost savings in virtualized environments. Some common considerations are performance implications during the deduplication cycle and achieving maximum efficiency by locating similar data types on the same volume or LUN. Data deduplication can be carried out at the SAN level, or if you are using SAS storage with Storage Spaces, you can use the new [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] built\-in deduplication feature.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes the following data duplication features that you can take advantage of in your cloud storage design:  
  
-   **Capacity optimization**. Data deduplication in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] stores more data in less physical space. It achieves greater storage efficiency than was possible in previous releases with single\-instance storage \(SIS\) or NTFS compression: data deduplication that can deliver optimization ratios of 2:1 for general file servers and up to 20:1 for virtualization data.  
  
-   **Scale and performance**. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] data deduplication can run on dozens of large volumes of primary data simultaneously without affecting other workloads on the server. Low impact on the server workloads is maintained by throttling of CPU and memory resources consumed. You also have the option to set times when data deduplication should run, specify the resources available to it, and establish policies on file selection.  
  
-   **Reliability and data integrity**. When data deduplication is applied, it is essential to maintain data integrity. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] takes advantage of checksum, consistency, and identity validation to ensure data integrity. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] data deduplication also maintains redundancy to ensure that the data is recoverable in the event of data corruption.  
  
Note that data deduplication is a feature that potentially will process all of the data on a selected volume, so careful planning should be done to determine if a server and attached volumes are suitable candidates for deduplication prior to enabling the feature. We strongly advise that during deployment of deduplication, you make regular backups of important data.  
  
> [!NOTE]  
> [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] data deduplication is not available on CSVs running on a highly available scale\-out file server cluster.  
  
#### Thin Provisioning  
In private cloud virtualization environments, thin provisioning is a common practice. This allows efficient use of the available storage capacity. The LUN or Storage Spaces virtual disk and corresponding CSV can grow as needed, typically in an automated fashion. However, storage can become overprovisioned in this scenario, so careful management and capacity planning are critical. Because physical allocation of data within a thin\-provisioned volume is done on demand, theoretically the volume size can be set to a very high value that can easily keep all application data and snapshot copies.  
  
The unallocated space in the volume is not exclusively reserved for the volume itself; therefore, all other applications can benefit from the shared pool of unallocated storage. Additionally, the volume size limits when using deduplication should be taken into account because the maximum sizes depend on the storage controllers when using SAN\-based storage solutions.  
  
Sophisticated and costly storage solutions offer just\-in\-time allocations \(also known as thin provisioning\) and the ability to reclaim storage that is no longer needed \(also known as trim\). [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] integrates with these sophisticated storage solutions to enable organizations to get the most out of their storage infrastructures at no additional cost. You can maximize the benefits of sophisticated storage infrastructure that is accessed through [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
Requirements for thin provisioning by [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] include:  
  
-   Storage infrastructure that complies with the certification that is required for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]  
  
-   Standards\-compliant hardware for identification.  
  
To confidently deploy sophisticated storage solutions that support just\-in\-time allocation, you need to know that you can provision additional capacity as needed. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] identifies thinly provisioned virtual disks, provides standardized notifications when use thresholds are crossed, and provides a platform that enables applications to release storage when it is no longer needed.  
  
When designing for thin provisioning in your cloud infrastructure, consider the following [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] capabilities:  
  
-   **Identification**. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] uses a standardized method to detect and identify thinly provisioned virtual disks, thus enabling additional capabilities delivered by the storage stack that is provided in the operating system and through storage\-management applications.  
  
-   **Notification**. When configured physical storage use thresholds are reached, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] notifies the administrator through events, which helps you to take appropriate action as soon as possible. These events can also be used for automated actions by management applications, such as System Center.  
  
-   **Optimization**. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides a new application programming interface \(API\) that lets applications return storage when it is no longer needed. NTFS issues trim notifications in real time when appropriate. Additionally, trim notifications are issued as part of storage consolidation \(optimization\), which is performed regularly on a scheduled basis.  
  
    > [!NOTE]  
    > Server consolidation often results in multiple data sets sharing the same storage hardware. Storage Spaces supports thin provisioning to allow you to easily share storage capacity among multiple unrelated data sets and thereby maximize capacity use. Trim support permits capacity reclamation when possible.  
  
#### Volume Cloning  
Volume cloning is another common practice in virtualization environments. This can be used for both host and virtual machine volumes to dramatically decrease host installation times and virtual machine provisioning times.  
  
Rapid provisioning is a common feature for private cloud implementations. In these environments, the expectation is that end users or departmental administrators will deploy virtual machines. Because of this, the system needs to respond rapidly to provisioning requests, and must scale those requests to accept large numbers of simultaneous requests. Clone\-based provisioning has several key advantages over traditional copy\-based provisioning.  
  
#### Volume Snapshot  
SAN volume snapshot copies are a common method of providing a point\-in\-time, instantaneous backup of a SAN volume or LUN. These snapshot copies are typically block\-level and only use storage capacity as blocks change on the originating volume. Some SANs provide tight integration with Hyper\-V, integrating both the Hyper\-V VSS Writer on hosts and volume snapshot copies on the SAN. This integration provides a comprehensive and high\-performing backup and recovery solution.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] has the ability to create application\-consistent snapshots of the server application data. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], this is accomplished using the VSS infrastructure. VSS for SMB file shares extends the VSS infrastructure to perform application\-consistent shadow copies of data stored on remote SMB file shares for backup and restore purposes. In addition, VSS for SMB file shares enable backup applications to read the backup data directly from a shadow copy file share rather than involving the server application computer during the data transfer. Because this feature takes advantage of the existing VSS infrastructure, it is easy to integrate with existing VSS\-aware backup software and VSS\-aware applications, such as Hyper\-V.  
  
#### Storage Automation  
One of the objectives of the Microsoft private cloud solution is to enable rapid provisioning and deprovisioning of virtual machines. Doing so on a large scale requires tight integration with the storage architecture, in addition to robust automation. Provisioning a new virtual machine on an already existing LUN is a simple operation. However, provisioning a new CSV LUN and adding it to a host cluster are relatively complicated tasks that should be automated.  
  
Historically, many storage vendors have designed and implemented their own storage management systems, APIs, and command\-line utilities. This has made it a challenge to use a common set of tools and scripts across heterogeneous storage solutions.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] enables storage management that is comprehensive and fully scriptable, and administrators can manage it remotely. A WMI\-based interface provides a single mechanism through which to manage all storage, including non\-Microsoft intelligent storage subsystems and virtualized local storage \(known as Storage Spaces\). Additionally, management applications can use a single Windows API to manage different storage types by using standards\-based protocols such as Storage Management Initiative Specification \(SMI\-S\).  
  
## Designing the Cloud Network Infrastructure  
The demand for hosted cloud requires integrated protection, the ability to add virtual appliances, and the capability to adapt virtual networking to the data center infrastructure. One of the most important issues to consider while building your private cloud is to ensure that the networking infrastructure is able to provide security, high availability, high performance, predictability, and resiliency, together with the ability to adapt for future cloud requirements. These prerequisites should be provided not only on the virtual layer by taking advantage of the Hyper\-V networking features, but also in the physical layer where the switches and routers are connected. Figure 2 shows a common private cloud infrastructure and different layers that must be covered during the design phase.  
  
![](../Image/PScen_Hst_Cld_Dsgn_9_network-infrastructure-overview.gif)  
  
**Figure 2. Network infrastructure overview**  
  
This section will cover the networking design considerations to assist you with building your cloud infrastructure.  
  
### Network Infrastructure  
You must access your current network infrastructure and verify the network is capable of receiving the new set of servers that will be hosting your cloud infrastructure. As shown in Figure 2, there are virtual components and physical components. Because the physical components will be in place before the initial setup of the cloud infrastructure, it is important to review the following elements of your current network infrastructure:  
  
|||  
|-|-|  
|Requirements|Description|  
|**Switches where the Hyper\-V clusters will be connected**|-   Layer 2 or layer 3 switches that support major [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] networking features.<br />-   Ethernet 1 GB or 10 GB, Fibre Channel, or InfiBand.|  
|**Cabling system**|-   Use the cabling system that matches with your layer 1 technology \(Ethernet, Fibre Channel, or InfiBand\).|  
|**Router**|-   Border router to route traffic from the private cloud to the Internet.|  
|**Edge Firewall\/Gateway**|-   A firewall\/gateway that allows secure web access from private cloud to Internet and from remote users to the private cloud.|  
  
> [!NOTE]  
> For more information about InfiniBand technology see [InfiniBand® Roadmap](http://www.infinibandta.org/content/pages.php?pg=technology_overview).  
  
When designing network connectivity for a well\-managed cloud infrastructure, the virtualization hosts should have the following specific networking requirements:  
  
|||  
|-|-|  
|Requirements|Description|  
|**Support for 802.1q VLAN tagging**|To provide network segmentation for the virtualization hosts, supporting management infrastructure, and workloads. This is one method you can use to help secure and isolate data traffic for a private cloud.|  
|**Remote out\-of\-band management capability**|To monitor and manage servers remotely over the network regardless of whether the server is turned on or off.|  
|**Support for PXE version 2 or later**|To facilitate automated physical server provisioning.|  
|**Support for ECN switches \(RFC 3168 compliant\)**|To support [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Datacenter TCP \(DCTPC\).|  
|**Support for 802.1az and 802.1Qbb \(priority flow control\)**|To support Datacenter Bridging \(DCB\).|  
|**Network interfaces and virtual networking gateway that support GRE offload \(NVGRE\)**|To support [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Network Virtualization.|  
  
Before deploying a cloud infrastructure, you should also address the following requirements:  
  
1.  Address any network bottleneck prior to building the cloud infrastructure.  
  
    Ensure that redundant components are working. For example, if a switch has two \(or more\) power supplies, perform a failover test to validate if it is properly working.  
  
2.  Make note of the results.  
  
3.  Document \(or update the documentation\) for the current network infrastructure.  
  
4.  Additionally, a cloud infrastructure should meet the following requirements to make sure that it is highly available and well\-managed:  
  
    -   Multiple paths to the switches for redundancy. Should a switch fail this can provide resiliency in the provisioned switch. Consult the switch vendor for specific recommendations.  
  
    -   Redundant power supplies and cooling fans, to increase the number of faults the switches and routers can survive.  
  
### Traffic Flow Isolation  
In a cloud infrastructure it is important that the traffic generated by each tenant is securely isolated from other tenants. The existing Windows Server 2008 Hyper\-V Switch architecture does not allow a component outside the switch to add to the security and isolation that is already provided by the switch. The new [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Hyper\-V Extensible Switch has support for isolation policies as well as allowing for extensibility and lets third parties add in filters to provide their own forwarding rules.  
  
> [!NOTE]  
> For more information about Hyper\-V Virtual Switch, see [Hyper\-V Virtual Switch Overview](http://technet.microsoft.com/library/hh831452.aspx)  
  
Another important feature that [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Hyper\-V introduces is called Network Virtualization. This feature removes the constraints of VLAN and hierarchical IP address assignment for virtual machine provisioning. In addition, network virtualization maintains the necessary multi\-tenant isolation and security requirements. This feature introduces the concept of location\-independent addressing by virtualizing the IP address. It creates virtual Layer\-2\/Layer\-3 topologies over any physical network that supports bidirectional IP connectivity. This means that physical networks can be hierarchical three\-tier networks, with full directional bandwidth, a Clos network, or a large Layer\-2 infrastructure. The advantage is that virtual networks can dynamically be configured by software as virtual machines are added to the cloud, and it can span over multiple physical subnets and across multiple sites.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Network Virtualization can support a larger number of network isolation groups than the 4,094 maximum provided by VLANs \(per IEEE 802.1Q standard\). With VLAN\-based network isolation, all of the workloads in an isolation group must be on a single subnet. Network Virtualization also allows network isolation groups to be defined across network boundaries such as subnets. This improves flexibility by removing physical network configuration constraints in determining where workloads can be placed.  
  
> [!NOTE]  
> For more information about Hyper\-V Network Virtualization see [Hyper\-V Network Virtualization Overview](http://technet.microsoft.com/library/jj134230.aspx).  
  
Enterprises that already have a large Fibre Channel SAN installation for storage service but want to migrate away from additional investment in the Fibre Channel technology will be able to use data center bridging \(DCB\) to build an Ethernet\-based converged fabric for both storage and data networking. Having a unified Ethernet fabric can reduce the future TCO and simplify the management. For enterprises who have already adopted, or who plan to adopt iSCSI as their storage solution, DCB can also provide hardware\-assisted bandwidth reservation for iSCSI traffic to ensure performance isolation. DCB\-capable Ethernet network adapters must be installed in computers that are providing [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DCB, and DCB\-capable hardware switches must be deployed on the network that will host the cloud infrastructure.  
  
The following table summarizes the design requirements for traffic isolation and the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] feature that should be used to accomplish this:  
  
||||  
|-|-|-|  
|Design requirements|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] feature|How does it help?|  
|**Separate workloads from internal IP addresses per tenant**|Hyper\-V Network Virtualization|You can separate workloads from internal IP addresses in order to minimize configuration changes that are necessary for IP addresses, Domain Name System \(DNS\), and other virtual machine configurations.|  
|**Separate server and network administrator duties to allow operational isolation**||You can simplify management since migration and placement of workloads are independent from the underlying physical network configuration.|  
|**Provide isolation beyond VLAN configuration**||Using software based policy in conjunction with policy\-based data center networks makes it possible to implement isolation without using VLANs.|  
|**Migrate servers across data centers in a flexible way while traffic is isolated from other tenants**||You can use flexible workload placement while keeping the current IP address schema as it is not limited to a physical IP subnet or VLAN configuration.|  
|**Optimize server and network utilization to not affect other tenants**||By removing the dependency of virtual machine placement based on physical network infrastructure you will increase the flexibility for workload placement and improve the overall server and network utilization.|  
|**Automate management and deployment**||By using the Network Virtualization PowerShell cmdlet it is possible to accomplish this design requirement.|  
|**Allow lower\-level traffic inspection with rules that can be applied per tenant**|Hyper\-V Switch Extensibility|Filtering extensions can inspect, drop, modify, and insert packets.|  
|**Allow different tenants to implement different filters according to their traffic\-isolation needs**||Extensions plug in to each instance of a vSwitch on a machine, and those extensions are either filters or Windows Filtering Platform \(WFP\) providers.|  
|**Monitor tenant traffic without modifying the existing vSwitch traffic**||Capture extensions can inspect traffic and generate new traffic for reporting purposes. Capture extensions do not modify existing vSwitch traffic.|  
  
Another mechanism that can be used to assist traffic isolation between virtual machines in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is new support for Hyper\-V switch port ACLs. This feature will be covered in more detail in the Security Considerations next section of this document.  
  
### Security Considerations  
Considering what was mentioned previously in the section Cloud Architecture Considerations, security is considered to be a wrapper around the entirety of the solution. When designing network connectivity for a secure cloud infrastructure, there are a series of security considerations for the current physical network infrastructure that must be verified before deploying the cloud infrastructure.  
  
The first recommended step is to perform a network vulnerability assessment \(NVA\) in the current infrastructure. Before securing the assets you must evaluate what's in place via an analytical assessment of every control point on the network \(such as switches and routers\). When performing an NVA it is important to follow a core framework that must include at least the following items:  
  
|||  
|-|-|  
|Task|Example|  
|**Detect and document the vulnerabilities**|-   Description: Switches located in the data center do not have the latest firmware and are vulnerable to Internet Control Message Protocol \(ICMP\) Redirect Attack.|  
|**Assign risk levels to discovered vulnerabilities**|-   Criticality: Severe<br />-   Reason: If an attack successfully exploits the vulnerabilities on the switches located in the data center, they could redirect the traffic and disrupt traffic flow, causing major downtime for the hosts connected to that switch.|  
|**Identify vulnerabilities that have not been remediated and take actions to remediate**|-   Description: Two months ago the NVA Report 00001 detected that switches located in the data center were vulnerable to ICMP Redirect Attack. The problem was not fixed.<br />-   Action: Escalate the problem to upper management to address this issue immediately.|  
  
It is important to perform the NVA on the current network infrastructure because an attacker usually looks for poorly configured network devices to exploit. Besides the vulnerabilities that are resolved by applying updates the come from the device vendor, there are other vulnerabilities that need to be addressed, such as those caused by insecure administration practices, such as weak default installation settings \(including weak password\) and wide\-open access controls \(no ACLs\). The following include some of the main network threats:  
  
-   Sniffing  
  
-   Spoofing  
  
-   Session hijacking  
  
-   Denial of service  
  
Cloud operators and private cloud network administrators must have knowledge of the threats that can affect the network infrastructure in order to apply effective countermeasures.  
  
> [!NOTE]  
> For more information about Network Security, see [Advanced Network Security](http://www.microsoft.com/learning/en/us/book.aspx?ID=6788&locale=en-us).  
  
Once the current physical network infrastructure is secured, the next phase is to plan how to extend this security to the virtual network while allowing the traffic between physical and virtual to flow in a secure manner. Security considerations while designing and planning the cloud infrastructure should also include:  
  
-   Secure access control between virtual machines \(on the same host or in different hosts\)  
  
-   Traffic control to avoid tenants overloading the network  
  
-   Avoiding rogue IP distribution  
  
-   Ensure network availability and performance  
  
#### Secure Access Control  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] supports Hyper\-V port ACLs that are enforced by the Hyper\-V virtual switch. These ACLs are fine\-grained rules that can either allow or deny traffic destined to or from a virtual machine's virtual network adapter. ACL filters are based on the IP address, IP address prefix, or the MAC address of the incoming or outgoing packets.  
  
Since ACLs are a port property of the Hyper\-V virtual switch, when a virtual machine live migrates to another host, the ACLs move with the virtual machine. Although it is technically possible to provide multi\-tenancy isolation by using only ACLs, the challenge is managing and keeping all ACLs updated. For this reason, ACLs are intended to ensure that virtual machines do not spoof their IP or MAC addresses or to control specific network traffic for particular address ranges.  
  
Consider developing an access control plan that describes a method to establish a secure and usable environment. A typical access control plan might include the following sections:  
  
-   Security goals: define the resources and processes that you are protecting.  
  
-   Security risks: enumerate the types of security hazards that affect your enterprise, including what poses the threats and how significant these threats are.  
  
-   Security strategies: describe the general security strategies necessary to meet the threats and mitigate the risks.  
  
-   Security policy: policy to define and enforce your security strategy on any number of virtual machines.  
  
-   Information security strategies: define how you plan to implement information security solutions.  
  
-   Administrative policies: document policies for delegation of administrative tasks and monitoring of audit logs to detect suspicious activity.  
  
> [!NOTE]  
> For more information about Access Control List on Hyper\-V see [Hyper\-V Virtual Switch Overview](http://technet.microsoft.com/library/hh831823.aspx).  
  
#### Traffic Control  
As documented in the [Cloud Security Challenges Secondary to Cloud Essential Characteristics](http://social.technet.microsoft.com/wiki/contents/articles/6810.private-cloud-security-challenges-rapid-elasticity.aspx) document, one of the concerns as a designer of a private cloud solution is that: "A rogue application, client, or DoS attack might destabilize the data center by requesting a large amount of resources. How do I balance the requirement that individual consumers\/tenants have the perception of infinite capacity with the reality of limited shared resources?"  
  
One way to address this concern is by controlling the network traffic. QoS in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is designed to help manage network traffic on the physical network and on the virtual network. Policy\-based QoS is designed to manage network on the physical network. In addition, a new functionality in QoS, referred to as Hyper\-V QoS, is designed to manage traffic at the virtual switch level.  
  
The use of policy\-based QoS allows cloud operators to specify network bandwidth control based on application type, users, and computers. Policy\-based QoS can also be used to help control bandwidth costs and negotiate service levels with bandwidth providers or departments \(tenants\). Hyper\-V QoS enables cloud operators to guarantee specific performance levels based on service level agreements \(SLAs\). Hyper\-V QoS helps ensure that no tenant is impacted or compromised by other tenants on their shared infrastructure, which includes computing, storage, and network resources.  
  
Consider developing a QoS plan that describes how to establish a secure a usable environment. A typical QoS plan might include the following sections:  
  
-   SLA: plan QoS policy based on the tenants' SLA.  
  
-   Network utilization: gauge network utilization to understand traffic flow and how QoS can be used to optimize performance.  
  
-   Policy enforcement: enforce QoS policies on Single Root I\/O Virtualization \(SR\-IOV\) network adapters that support bandwidth reservation per virtual port.  
  
These sections should be considered per tenant because it is possible to create multiple virtual network adapters in Hyper\-V and specify QoS on each virtual network adapter individually.  
  
> [!NOTE]  
> For more information about Policy Based QoS see [Quality of Service \(QoS\) Overview](http://technet.microsoft.com/library/hh831679.aspx).  
  
#### Avoid Rogue IP Distribution  
The same core concern that a rogue application, client, or denial of service \(DoS\) attack might destabilize the data center, mentioned previously, also applies in this case. If a rogue Dynamic Host Configuration Protocol \(DHCP\) server is capable of providing IP addresses to computers in the tenant network, these computers might lose access to resources and disrupt the whole tenant network infrastructure.  
  
The DHCP server role in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces a new policy\-based IP address and option assignment feature. With the Policy Based Assignment \(PBA\) feature the cloud operator will be able to group DHCP clients by specific attributes based on fields contained in the DHCP client request packet. This feature allows a greater control of configuration parameters delivered to network devices.  
  
A typical DHCP PBA plan might include the following sections:  
  
-   Define conditions: DHCP PBA can be defined according to fields in the DHCP client request. Define which condition better fits on your cloud infrastructure network.  
  
-   IP scope: define the DHCP IP scope that will be used for the tenants.  
  
-   Lease duration: define the DHCP lease duration for each tenant network.  
  
-   Additional options: define the DHCP scope or server options that will be provided to the tenants. If policies exist at the server and scope levels, the server applies both sets of policies and evaluates the scope policies before the server policies. The processing order for a scope\-level policy defines the order of evaluation within the scope.  
  
> [!NOTE]  
> For more information about DHCP PBA see [Step\-by\-Step: Configure DHCP Using Policy\-based Assignment](http://technet.microsoft.com/library/hh831538).  
  
### Scalability and Performance Considerations  
Many network architectures include a tiered design with three or more tiers such as core, distribution, and access. When designing a cloud infrastructure the current network infrastructure should be evaluated to understand the port bandwidth and quantity required at all layers, in addition to the ability of the distribution and core tiers to provide higher\-speed uplinks to aggregate traffic. Additional considerations include Ethernet broadcast boundaries and limitations, and spanning tree and\/or other loop avoidance technologies should be considered.  
  
Physical separation of the networks should also be considered in order to provide another layer of isolation and security and increase the overall performance per segment. When designing a cloud infrastructure ensure that the servers that will be used to host the virtual machines support different traffic profiles by either using separate physical adapters for each traffic type, or by using VLAN tagging or virtual NICs. The table below describes a cloud infrastructure model with five physical network segments:  
  
|||  
|-|-|  
|Traffic|Description|  
|**Management**|Network that handles all the management traffic. This traffic will be from the host to the management workstation. Cloud operators will connect to the host system to manage the cloud infrastructure.|  
|**Cluster**|Network dedicated to cluster communications.|  
|**Storage**|Handle all the storage traffic in scenarios where you use Ethernet\-based storage protocols.|  
|**Live migration**|Responsible for handling the live migration traffic that will take place from one host to another.|  
|**Tenant**|Network dedicated to tenant traffic. An additional layer of isolation within the tenant network can be provided by using VLAN IDs in the virtual switch.|  
  
> [!NOTE]  
> It is also possible to route all these traffic profiles through a single or teamed 10 GB network adapter. This converged networking model reduces the number of network adapters and cabling required for your private cloud infrastructure.  
  
If business requirements dictate that your cloud infrastructure should have five physical network segments, the same layout can be applied to the virtual network infrastructure. When implementing those requirements it is also important to create a standard nomenclature for the network adapters names in order to reflect which network they are connected to. This not only helps to easily identify the network but also to create a standard for future automations via Windows PowerShell.  
  
Although physical separation of the traffic can be a business requirement, there will be scenarios that this is not the case and the main business requirement is to reduce implementation cost while maintaining security isolation between tenants. When the business requirements lead you to this design decision you can converge all the data center networks into basically two networks, physically isolated: a data center network can carry all the storage, live migration, clustering, and management traffic flows, and a second network can carry all of the virtual machine tenant\-generated traffic. You can still apply QoS policies to guarantee minimum traffic for each flow and use VLAN ID in the virtual switch to isolate the traffic within the tenant network.  
  
When choosing the networking hardware for your cloud infrastructure, consider the following options:  
  
||||  
|-|-|-|  
|Network technology|Advantages|Disadvantages|  
|**10 GB Ethernet**|-   Great performance<br />-   Offers QoS \(DCB\) and flexible bandwidth allocation<br />-   New hardware offloads available|-   RDMA optional \(for SMB 3.0 file access\)<br />-   Physical switch ports more expensive|  
|**InfiniBand \(32 GB and 56 GB\)**|-   Very high performance, low latency<br />-   RDMA included \(for SMB 3.0 file access\)|-   Network management different than Ethernet<br />-   More expensive to implement|  
|**1 GB Ethernet**|-   Adequate performance for many workloads|-   Not very scalable|  
  
Remote interfaces and management of the network infrastructure via Secure Shell \(SSH\) or similar protocol is important to both automation and resiliency of the data center network. Remote access and administration protocols can be used by management systems to automate complex or error prone configuration activities. For example, adding a VLAN to a distributed set of access\-tier switches can be automated to avoid the potential for human error.  
  
## Host and Virtualization Design  
There are a number of critical design decisions you need to make that apply to your virtualization infrastructure. Hardware virtualization uses software to create a virtual machine that emulates a physical computer. This creates a separate operating system environment that is logically isolated from the host server. By providing multiple virtual machines at once, this approach allows several operating systems to run simultaneously on a single physical machine.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Hyper\-V technology is based on a 64\-bit hypervisor\-based microkernel architecture that enables standard services and resources to create, manage, and execute virtual machines with the cloud infrastructure. The Windows Hypervisor runs directly above the hardware and ensures strong isolation between the partitions by enforcing access policies for critical system resources such as memory and processors. The Windows Hypervisor does not contain any third\-party device drivers or code, which minimizes its attack surface and provides a more secure architecture.  
  
In addition to the Windows Hypervisor, there are two other major elements to consider with Hyper\-V: a parent partition and child partition. The parent partition is a special virtual machine that runs [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], controls the creation and management of child partitions, and maintains direct access to hardware resources. In this model, device drivers for physical devices are installed in the parent partition. In contrast, the role of a child partition is to provide a virtual machine environment for the installation and execution of guest operating systems and applications.  
  
### Windows Server 2012 Hyper\-V Host Design  
There are many important considerations you need to make when designing the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] host and Hyper\-V components as part of your cloud infrastructure. In this section we will discuss decision points regarding:  
  
-   Licensing  
  
-   Operating system configuration  
  
-   Memory and Hyper\-V Dynamic Memory  
  
-   Storage adapters  
  
-   Hyper\-V host failover design  
  
-   Hyper\-V guest virtual machine design  
  
#### Licensing  
Different versions of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] include different virtualization rights, which is the right and license to run a specified number of virtual machines based on Windows. For a private cloud environment, you will want to use [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Datacenter Edition.  
  
#### Operating System Configuration  
The following outlines the general considerations for the Hyper\-V Host Operating system. Note that these are not meant to be installation instructions but rather the process requirements and order.  
  
To install and use the Hyper\-V role, you will need the following:  
  
-   An x64\-based processor  
  
-   Hardware\-assisted virtualization support in the processor and BIOS  
  
-   Hardware\-enforced data execution prevention \(DEP\) support in the processor and BIOS  
  
-   Use the latest hardware device drivers and system BIOS updates  
  
-   Hyper\-V parent partition operating system must be domain\-joined. This is required to support failover clustering and other management capabilities.  
  
-   Hyper\-V server roles and failover clustering features. Failover clustering will provide high availability so that virtual machines remain available even if a member of the cluster is disabled.  
  
-   Apply relevant Windows updates, including out\-of\-band \(OOB\) updates not offered on Microsoft Update  
  
-   All nodes, networks, and storage must pass the Cluster Validation Wizard  
  
Please see [Hyper\-V Overview](http://technet.microsoft.com/library/hh831531(d=lightweight,l=en-us,v=ws.11)) for more information on hardware and software requirements.  
  
#### Memory and Hyper\-V Dynamic Memory Options  
Dynamic Memory, introduced in Windows Server 2008 R2 Service Pack 1 \(SP1\), defined startup memory as the minimum amount of memory that a virtual machine can have. However, Windows requires more memory during startup than the steady state. As a result, administrators sometimes assign extra memory to a virtual machine because Hyper\-V cannot reclaim memory from these virtual machines after startup. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Dynamic Memory introduces a minimum memory setting, which allows Hyper\-V to reclaim the unused memory from the virtual machines. This is reflected as increased virtual machine consolidation numbers.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] also introduces Smart Paging for reliable virtual machine restart operations. Although minimum memory increases virtual machine consolidation numbers, it also brings a challenge. If a virtual machine has a smaller amount of memory than its startup memory and it is restarted,  
  
Hyper\-V needs additional memory to restart the virtual machine. Due to host memory pressure or virtual machine states, Hyper\-V might not always have additional memory available. This can cause sporadic virtual machine restart failures. Smart Paging is used to bridge the memory gap between minimum memory and startup memory, and allow virtual machines to restart reliably.  
  
For more information regarding Dynamic Memory, please see [Hyper\-V Dynamic Memory Overview](http://technet.microsoft.com/library/hh831766.aspx).  
  
In addition to the general guidance above, specific applications or workloads, particularly those with built\-in memory management capabilities, such as SQL Server or Exchange Server, might provide workload\-specific guidance. An example of such guidance is [Running SQL Server with Hyper\-V Dynamic Memory](http://msdn.microsoft.com/library/hh372970.aspx).  
  
When designing for memory requirements for host servers in the Hyper\-V cluster, you should consider how many virtual machines you want to support on each server. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] supports up to 4 TB of memory for the host operating system and up to 1 TB for each virtual machine.  
  
One approach you can take is to consider how many virtual machines you wish to support of each service class you plan to offer in your private cloud. For example, you may want to support up to 10 virtual machines on each host system in the cluster. You also want to offer the following service classes in terms of amount of memory offered:  
  
-   **Bronze** – 1 GB of RAM for the virtual machine  
  
-   **Silver** – 4 GB of RAM for the virtual machine  
  
-   **Gold** – 16 GB of RAM for the virtual machine  
  
You estimate that consumers of your private cloud will acquire these service offerings in the following percentages:  
  
-   **Bronze** – 30%  
  
-   **Silver** – 60%  
  
-   **Gold** – 10%  
  
You can compute the amount of RAM required in each host in this example using the following:  
  
\(1GBx3\) \+ \(4GBx6\) \+ \(16GBx1\) \+ 2GB \(for the host OS\) \= 45 GB  
  
#### Storage Adapters  
Design decisions regarding storage adapters on the Hyper\-V private cloud host are important. The type of storage adapter you choose will determine the speed, latency, reliability, performance, and cost of your cloud infrastructure storage components. In this section we will discuss:  
  
-   MPIO configuration  
  
-   Performance settings  
  
-   Network adapter teaming configurations  
  
##### MPIO Configuration  
As discussed earlier, Microsoft MPIO architecture supports iSCSI, Fibre Channel, and SAS SAN connectivity by establishing multiple sessions or connections to the storage array.  
  
##### Performance Options  
The following Hyper\-V network performance improvements should be tested and considered for production use \(note that many of these technologies require hardware support\):  
  
-   **Transmission Control Protocol \(TCP\) checksum offload** benefits both CPU and overall network throughput performance, and it is fully supported by live migration.  
  
-   **Jumbo frames** capability is extended to virtual machines with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Hyper\-V. Just as in physical network scenarios, jumbo frames add the same basic performance enhancements to virtual networking. That includes up to six times larger payloads per packet, which improves overall throughput and also reduces CPU utilization for large file transfers. For more information on jumbo frames, please see [Hyper\-V Networking Options – Jumbo Frames](http://blogs.technet.com/b/cedward/archive/2011/05/05/hyper-v-networking-optimizations-part-4-of-6-jumbo-frames.aspx).  
  
-   **Dynamic Virtual Machine Queue \(DVMQ\)** enables you to span processing of virtual machine network traffic across all processors in the host operating system. This feature enables you to scale up and scale down the CPU utilization based on demand.  
  
-   **Scale and resiliency.** The computer that runs Hyper\-V can be configured with up to 320 logical processors  and 4 TB of memory. Virtual machines can be configured with 32 virtual processors and 1 TB of memory. Improved handling of hardware errors increases the resiliency and stability of the virtualization environment. For more information on scale and resiliency features, please see [Hyper\-V Support for Scaling Up and Scaling Out Overview](http://technet.microsoft.com/library/hh831389.aspx).  
  
-   **Single root I\/O virtualization \(SR\-IOV\).** Use of SR\-IOV maximizes network throughput while minimizing network latency, in addition to the CPU overhead required for processing network traffic. SR\-IOV bypasses the virtual switch stack and enables the virtual machine direct access to the hardware. Network adapter and BIOS support is required. For more information on SR\-IOV please see [Hyper\-V Support for Scaling Up and Scaling Out Technical Preview](http://technet.microsoft.com/library/hh831389.aspx).  
  
-   **New .VDHX disk format.** The new format increases the maximum storage size per virtual hard disk, and improves the stability and efficiency of those disks. The new VDHX disk format supports up to 64 TB of storage and supports newer 4K disk architecture. It also provides built\-in protection from corruption stemming from power failures and prevents performance degradation on some large\-sector physical disks. For more information on the new VHDX disk format, please see [Hyper\-V Virtual Hard Disk Format Technical Preview](http://technet.microsoft.com/library/hh831446.aspx).  
  
-   **Virtual non\-uniform memory access \(NUMA\).** Newer operating systems and high\-performance applications such as SQL Server include optimizations that recognize a computer's NUMA topology to increase performance by considering NUMA when scheduling threads or allocating memory. The virtual NUMA feature makes it possible for the guest operating system and NUMA\-aware applications running in the virtual machine \(such as SQL Server\) to take advantage of these performance optimizations. A virtual NUMA topology is projected to the guest operating system. The default virtual NUMA topology is optimized to match the NUMA topology of the physical computer. Note that if a virtual machine uses dynamic memory, then a flat NUMA topology is reflected to that VM. In addition, in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] failover clustering, NUMA topology of members of the cluster is taken into consideration when automated decisions are made to move virtual machines.  
  
-   **Hyper\-V Offloaded Data Transfer.** To take advantage of innovations in storage hardware that provide near\-instantaneous copying of large amounts of data, Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces Offloaded Data Transfer \(ODX\). With this new feature, Hyper\-V workloads use the offload semantics of the host hardware, in addition to the virtual storage stack, to perform certain internal operations on virtual hard disks that require large amounts of data to be copied. Hyper\-V performs these operations faster than was previously possible. For more information on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] ODX, please see [Hyper\-V Offloaded Data Transfer Overview](http://technet.microsoft.com/library/hh831375.aspx).  
  
##### Network Adapter Teaming Configurations  
Network adapter teaming can be utilized to enable multiple redundant network adapters and connections between servers and access\-tier network switches. Teaming can be enabled via hardware or software\-based approaches. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes built\-in support for network adapter teaming via the new load balancing and failover \(LBFO\) feature, where any two network adapters can be teamed, regardless of make, model, or speed. Teaming can enable multiple scenarios including path redundancy, failover, and load\-balancing.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] LBFO \(Load Balancing and Failover, also known as NIC Teaming\), allows multiple network adapters on a computer to be placed into a team for the following purposes:  
  
-   Bandwidth aggregation  
  
-   Traffic failover to prevent connectivity loss in the event of a network component failure  
  
    > [!NOTE]  
    > [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] NIC Teaming enables you to configure the team in ways that can have all adapters active or reserve some adapters for standby. We recommend that you use the all active configuration for your private cloud NIC teams.  
  
This feature has been a requirement for independent hardware vendors \(IHVs\) to enter the server network adapter market, but until now network adapter teaming has not been included in Windows Server operating systems. NIC Teaming enables you to team network adapters of different speeds and from different manufacturers.  
  
> [!NOTE]  
> It is recommended that you do not team network adapters of different speeds. The reason for this is that while it is a supported configuration, if the higher speed adapter fails, performance on the slower adapter will be severely impacted.  
  
It is recommended that you do not team network adapters of different speeds. The reason for this is that while it is a supported configuration, if the higher speed adapter fails, performance on the slower adapter will be severely impacted.  
  
Network adapter teaming in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] also works within a virtual machine. This allows a virtual machine to have virtual network adapters that are connected to more than one Hyper\-V switch and still have connectivity even if the network adapter under that switch gets disconnected. This is particularly important when working with features such as SR\-IOV because SR\-IOV traffic does not go through the Hyper\-V switch. Thus, it cannot be protected by a team that is under a Hyper\-V switch. With the virtual machine teaming option, an administrator can set up two Hyper\-V switches, each connected to its own SR\-IOV\-capable network adapter. At that point:  
  
-   Each virtual machine can then install a virtual function from one or both SR\-IOV network adapters. Then, in the event of a network adapter disconnect, the virtual machine can fail over from the primary virtual function to the backup virtual function.  
  
-   Alternately, the virtual machine might have a virtual function from one network adapter and a non\-virtual function network adapter from the other switch. If the network adapter that is associated with the virtual function gets disconnected, the traffic can fail over to the other switch without loss of connectivity.  
  
    > [!NOTE]  
    > NIC Teaming is compatible with all networking capabilities in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] with three exceptions:  
  
-   SR\-IOV  
  
-   RDMA  
  
-   TCP Chimney \(TCP Chimney is disabled by default in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]\)  
  
For SR\-IOV and RDMA, data is delivered directly to the network adapter without passing through the virtual networking stack. Therefore, it is not possible for the network adapter team to look at or redirect the data to another path in the team. In addition, TCP Chimney is not supported with network adapter teaming in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. Network adapter teaming requires the presence of at least one Ethernet network adapter, which can be used for separation of traffic using VLANs. All modes that provide fault protection through failover require at least two Ethernet network adapters. The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] implementation supports up to 32 network adapters in a team.  
  
For more information on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] load balancing and failover, please see [Load Balancing and Failover Overview](http://technet.microsoft.com/library/hh831648.aspx).  
  
###### Dedicated Compute and Storage Clusters Using SMB 3.0 and Windows Server 2012 File Server  
In this design pattern, the Hyper\-V cluster providing the compute component for the cloud infrastructure is separate from the storage cluster. When you separate the compute from the storage cluster, you have the opportunity to scale compute capacity and storage capacity separately. This provides you more flexibility when designing your scale units for compute and storage. In this pattern, two 10 GbE adapters on the compute cluster are teamed which support management, cluster, live migration, and storage traffic. The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] storage cluster is also configured with teamed 10 GbE adapters and hosts VHDX and configuration files that are accessed through SMB 3.0 file shares over the network. The storage configuration on the storage cluster can connect to any type of block storage solution.  
  
#### Hyper\-V Host Failover Cluster Design  
A Hyper\-V host failover cluster is a group of independent servers that work together to increase the availability of applications and services. The clustered servers \(called nodes\) are connected by physical cables and by software. If one of the cluster nodes fails, another node begins to provide service \(a process known as failover\). In case of a planned migration \(called live migration\), users experience no perceptible service interruption.  
  
The host servers are one of the critical components of a dynamic, virtual infrastructure. Consolidation of multiple workloads onto the host servers requires that those servers be highly available. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides advances in failover clustering that enable high availability and live migration of virtual machines between physical nodes. Some of the new features which you will need to include in your private cloud design decisions for host cluster members include:  
  
-   Cluster scalability features  
  
-   CSVs  
  
-   Support for scale\-out file servers  
  
-   Cluster\-aware updating  
  
-   Virtual machine application monitoring  
  
-   Cluster validation tests  
  
-   Active Directory Domain Services integration  
  
-   Multisite support  
  
-   Cluster upgrade and migration  
  
-   iSCSI software target integration  
  
-   Windows PowerShell support  
  
For more information on each of these features and how they can fit into your cloud infrastructure design, please see [What’s New in Failover Clustering](http://technet.microsoft.com/library/hh831414.aspx).  
  
##### Private Cloud Infrastructure without Failover Clustering  
It is important to note that a private cloud infrastructure does not require failover clustering. Failover clustering provides high availability for stateful applications that are not specifically designed to work on and support cloud capabilities. Specific cloud capabilities are targeted at the stateless applications of the future.  
  
Prior to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Live Migration of virtual machines from one host to another required failover clustering; thus a failover cluster defined the scope of virtual machine and workload mobility. However, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces what is known as the "shared nothing" Live Migration feature.  
  
Shared nothing Live Migration enables the cloud service provider to move virtual machines from one Hyper\-V host to another without requiring failover clustering or shared storage. With only a network cable \(or even wireless connection\) the virtual machine and its virtual disk and configuration files can be moved from one machine to another. Private cloud service providers could take advantage of this capability to run virtual machines hosting stateless workloads and place virtual machines on specific hosts based on their fabric controller of choice.  
  
This design guide focuses on implementing failover clustering in the private cloud infrastructure because the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] failover clustering feature adds many vital capabilities for the management, monitoring and control of the overall cloud solution and is tightly integrated with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Hyper\-V technologies. In addition, we believe that, for at least the near term that stateful applications will represent the most common workload running in a private cloud.  
  
##### Host Failover Cluster Topology  
In a Microsoft Private Cloud infrastructure, we recommend two standard design patterns. The server topology should consist of at least two Hyper\-V host clusters. The first should have at least two nodes, and will be referred to as the management cluster. The second, and any additional clusters, will be referred to as fabric host clusters. The second cluster might be the compute cluster, and the third cluster might be the storage cluster. Alternatively, the second cluster can be a combined computer and storage cluster that is either symmetric or asymmetric.  
  
> [!NOTE]  
> In the current context, a symmetric cluster is a cluster where each member of the cluster is directly attached to storage. Conversely, an asymmetric cluster has some members attached to storage and others unattached to storage. Typically, the unattached cluster members are performing the compute function \(actually running the virtual machines\) and the attached members of the cluster are acting as scale\-out file servers that host the virtual machine files for the compute nodes.  
  
In some cases such as smaller\-scale scenarios or specialized solutions, the management and fabric clusters can be consolidated onto the fabric host cluster. Special care has to be taken in that case to ensure resource availability for the virtual machines that host the various parts of the management stack. There are significant security issues with this design, so assiduous attention to traditional and cloud\-based security measures is mandatory.  
  
Each host cluster can contain up to 64 nodes. However, for file server clusters running the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] scale\-out file server role that host VHDX files used by the computer cluster, there is an informal 8\-node limitation. The compute cluster can host its own storage, or can use SMB 3.0 file based storage to access storage on the file server cluster.  
  
> [!NOTE]  
> The 8\-node informal limitation is based on what has been tested as of the writing of this document. You can exceed the 8\-node limitation and customer support services will work with you in identifying and resolving issues should they arise.  
  
##### Compute Cluster Traffic Profiles  
A variety of host cluster traffic profiles or types are used in a Hyper\-V failover cluster. The network requirements to support these traffic types enable high availability and high performance.  
  
The Microsoft cloud infrastructure configurations support the following Ethernet traffic profiles:  
  
-   **Management network traffic.** The management network is required so that hosts can be managed to avoid competition with guest and other infrastructure traffic needs. The management network provides a degree of separation for security and ease of management purposes. This network is used for remote administration of the host, communication to management systems \(System Center agents\), and other administrative tasks.  
  
-   **iSCSI, Fibre Channel over Ethernet, or SMB 3.0 traffic \(Storage Traffic\)**. If using iSCSI, FCoE, or SMB 3.0, the iSCSI, FCoE, or SMB 3.0 network is configured so that storage traffic is not in contention with any other infrastructure or tenant traffic. For all these storage connections, an MPIO configuration with two independent physical ports is required. In the case of SMB 3.0 access to file storage, multiple network adapters can be used in conjunction with SMB multichannel and transparent failover to provide benefits similar to MPIO.  
  
-   **CSV\/cluster communication traffic.** Usually, when the cluster coordinator node that "owns" a virtual hard disk \(VHD\) file in CSV performs disk I\/O, the node communicates directly with the storage devices; for example, through a SAN. However, storage connectivity failures and other non\-failure scenarios sometimes prevent a given node from communicating directly with the storage device. To maintain functionality until the failure is corrected, the node redirects the disk I\/O through a cluster network \(the preferred network for CSV\) to the node where the disk is currently mounted. This is called CSV redirected I\/O mode.  
  
-   **Live migration traffic.** During live migration, the contents of the memory of the virtual machine running on the source node needs to be transferred to the destination node over a LAN connection. Large virtual machines can consume many gigabytes of memory that need to be transferred over the network. To provide a high\-speed transfer, a dedicated, redundant, 10 Gbps live migration network is required. This significantly reduces the time required to evacuate the virtual machines off a host with zero downtime during maintenance or Windows updates. The time it takes to complete an evacuation of a cluster member depends on the total amount of memory consumed by running virtual machines on that system and the amount of bandwidth available on the Live Migration network.  
  
-   **Tenant traffic.** Tenant traffic is dedicated to virtual machine LAN traffic. The tenant traffic can use two or more 1 GB or 10 GB networks using network adapter teaming, or virtual networks created from shared network adapters. You can implement one or more dedicated virtual machine networks. The amount of bandwidth required on the tenant network may be less than what you require on any of the infrastructure networks, depending on the type of workloads you expect to support on your private cloud. One way to determine the bandwidth you want to make available on your tenant network is to define your network service classes and then determine what is the total amount of bandwidth required for you to meet the SLA for your network bandwidth defined service classes for all VMs running on your host.  
  
When you look at each of the traffic profiles presented here, you can categorize each of them into one of two categories:  
  
-   Private cloud infrastructure traffic  
  
-   Private cloud tenant traffic  
  
Private cloud infrastructure traffic includes management, storage, CSV\/cluster and Live Migration traffic. Tenant traffic is defined by traffic to and from virtual machines running within the private cloud infrastructure.  
  
> [!NOTE]  
> There are some security considerations that you need to address which extend past the isolation methods we've talked about until now. While you can use Hyper\-V virtual switch port ACLs and VLAN tagging and even private VLANs to obtain a good degree of separation between host and guest traffic, you may want to introduce additional security for your Live Migration traffic. During the process of a Live Migration, tenant data, by default, is moving unencrypted over the Live Migration network. There is a reasonable chance that this data contains private information that might be of interest to intruders. If the physical or logical infrastructure of the Live Migration network were to be compromised, the Live Migration traffic could be accessible in an unencrypted format to the intruder. Because of this, we recommend that you use IPsec to secure the connections between hosts on the Live Migration network.  
  
There are several options available regarding how you manage these traffic profiles so that they receive the bandwidth they require while enforcing separation between the tenant traffic and the cloud infrastructure traffic \(management, storage, CSV\/cluster, and live migration\). These are:  
  
-   **Dedicated network adapters for each traffic profile.** This is a traditional approach that was recommended for Windows Server 2008 R2 Hyper\-V clusters. With new features included in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], this is no longer considered the preferred design. However, it simplifies upgrading the current Windows Server 2008 R2 to a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] infrastructure.  
  
-   **Dedicated network adapters for cloud infrastructure traffic and tenant traffic.** In this design pattern, separate adapters and networks are used for the cloud infrastructure traffic and the tenant traffic. This provides the required isolation between infrastructure and tenant traffic, and lessens the impact of tenant traffic on overall bandwidth availability. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] QoS policies can be used to provide minimum and maximum bandwidth availability for each cloud infrastructure traffic profile.  
  
-   **No dedicated adapters for any traffic profile.** In this design pattern, all traffic moves through the same network adapters over the same physical network. Infrastructure traffic and tenant traffic share the same physical adapter or adapter team. Hyper\-V QoS policies are applied so that each traffic profile has a guaranteed amount of bandwidth. VLAN tagging or Hyper\-V virtual switch port ACLs can be used to provide the necessary isolation between cloud infrastructure and tenant traffic. This pattern requires that infrastructure traffic flow through virtual network adapters that are created on the same Hyper\-V virtual switch through which tenant traffic also flows. The advantage of this converged networking pattern is that it is simpler to manage, is more cost effective and enables you to take advantage of security and performance capabilities included with the Hyper\-V virtual switch.  
  
Note that the conversation to this point has been focused on traffic patterns and network design for compute node cluster traffic. If you have chosen to separate your compute and file server clusters so that you can scale compute and storage separately, then you will need to consider what traffic profiles need to be defined on the file server cluster.  
  
The file server cluster will have the management, cluster\/CSV, and perhaps a storage network, depending on how you decide to present block storage to the file server cluster. There will be no Live Migration traffic profile on the storage cluster. But you may want to define a file server network traffic profile, which delineates the path that connects the compute node to the file server node using the SMB 3.0 protocol.  
  
## Hyper\-V Guest Virtual Machine Design  
Standardization is a key tenet of private cloud architectures. This also applies to virtual machines. A standardized collection of virtual machine templates can both drive predictable performance and greatly improve capacity planning capabilities. These templates also provide the foundation for your private cloud's service catalog. The service catalog can also be used to help you determine how you size the hosts in your private cloud as well as the scale units you might wish to define.  
  
As an example, the table below illustrates what a basic virtual machine template library might look like.  
  
||||||  
|-|-|-|-|-|  
|**Template**|Specs|Network|Operating System|Unit Cost|  
|**Template 1: Small**|1 vCPU, 2 GB memory, 50 GB disk, 100Mbps|VLAN 20|Windows Server 2008 R2|1|  
|**Template 2: Medium**|4 vCPU, 4 GB memory, 250 GB disk, 400Mbps|VLAN 20|Windows Server 2008 R2|2|  
|**Template 3: Extra\-Large**|16 vCPU, 16 GB memory, 500 GB disk, 800Mbps|VLAN 20|Windows Server 2008 R2|4|  
|**Template 4: Small**|1 vCPU, 2 GB memory, 50 GB disk, 100Mbps|VLAN 10|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|1|  
|**Template 5: Medium**|4 vCPU, 4 GB memory, 250 GB disk, 400Mbps|VLAN 10|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|2|  
|**Template 6: Extra\-Large**|16 vCPU, 16 GB memory, 500 GB disk, 800Mbps|VLAN 10|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|4|  
  
### Virtual Machine Storage  
This section discusses the different types of Hyper\-V disks. Note that while in the past Microsoft recommended using only fixed VHDs for production, significant improvements to the virtual disk format \(.VHDX\) have made using dynamically expanding disks a viable format for production use. Therefore, for performance reasons, you can use either fixed or dynamically expanding disks in your private cloud infrastructure.  
  
#### Dynamically Expanding Disks  
Dynamically expanding virtual hard disks provide storage capacity as needed to store data. The size of the VHDX file is small when the disk is created and grows as data is added to the disk. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] the size of the VHDX file will shrink automatically when data is deleted from the virtual hard disk. Dynamically expanding disks can be provisioned very quickly and can be used as part of your thin provisioning scheme.  
  
#### Fixed Size Disks  
Fixed virtual hard disks provide storage capacity by using a VHDX file that is in the size specified for the virtual hard disk when the disk is created. The size of the VHDX file remains 'fixed' regardless of the amount of data stored, similar to a physical hard disk. However, you can use the Edit Virtual Hard Disk Wizard to increase the size of the virtual hard disk, which increases the size of the VHDX file. By allocating the full capacity at the time of creation, fragmentation at the host level is not an issue \(fragmentation inside the VHD itself must be managed within the guest\). A disadvantage of fixed sized disks is that they can take a long time to be provisioned, the time depending on the size of the fixed size disk. Fixed disks can provide incremental performance improvement. You should weigh the advantages and disadvantages of using dynamically expanding disks versus fixed sized disks by considering whether the disk space advantages conferred by the dynamically expanding disks outweigh the incremental performance improvement in fixed sized disks.  
  
#### Differencing Disks  
Differencing virtual hard disks provide storage to enable you to make changes to a parent virtual hard disk without altering that disk. The size of the VHD file for a differencing disk grows as changes are stored to the disk. Differencing disks are useful in lab\/test environments but can also be used in private cloud infrastructure deployments.  
  
For example, you might want to configure your compute node host infrastructure to use a combination iSCSI and VHDX boot. Given that there is minimal state required on Hyper\-V compute cluster nodes, each host can have its own differencing disk. When updates to the operating system are required, the parent disk is serviced and the compute nodes are rebooted after virtual machines are migrated away from the compute node host. A new differencing disk is created at that point. This enables centralized management of a single golden image that can be used for each compute cluster host and significant reduces the amount of storage required to host the cluster node virtual disk files.  
  
#### Pass\-Through Disks  
Hyper\-V enables virtual machine guests to directly access local disks or SAN LUNs that are attached to the physical server without requiring the volume to be presented to the host server. The virtual machine guest accesses the disk directly \(utilizing the disk's GUID\) without having to utilize the host's file system. Given that the performance difference between fixed\-disk and pass\-through disks is negligible in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the decision is now based on manageability. For instance, if the data on the volume will be very large \(hundreds of gigabytes or terabytes\), a VHDX is hardly portable at that size given the extreme amounts of time it takes to copy. Also, bear in mind the backup scheme. With pass\-through disks, the data can only be backed up from within the guest. In addition, virtual machine portability will be limited.  
  
Also note that when utilizing pass\-through disks, there is no VHDX file created; the LUN is used directly by the guest. Since there is no VHDX file, there is no dynamic sizing capability or snapshot capability.  
  
#### Support for Guest Clustering  
Creating a guest cluster gives you the ability to failover or migrate your applications independently of the guest operating system and provides you the ability to decouple the application from the guest operating system in a way similar the abstraction that the guest operating system gets from virtualization. In the case of the guest operating system itself, you are decoupling the guest operating system from the hardware. With a guest cluster you decouple the application from the virtual machine. This gives you much greater flexibility and increased uptime in the event that the virtual machine has a failure in which a migration or restart of the VM will not solve.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides support for guest clustering and access to shared storage required for guest clustering with:  
  
-   In\-Guest iSCSI Initiator  
  
-   In\-Guest Fibre Channel synthetic HBA \(new in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]\)  
  
#### In\-Guest iSCSI Initiator  
Hyper\-V can also utilize iSCSI storage by directly connecting to iSCSI LUNs utilizing the guest's virtual network adapters. This is mainly used for access to large volumes, volumes on SANs that the Hyper\-V host itself is not connected to, or for guest\-clustering. Guests cannot boot from iSCSI LUNs accessed through the virtual network adapters without utilizing a third\-party iSCSI initiator. However, given that guests can boot from SMB 3.0 file shares, there is no advantage to using iSCSI boot for virtual machines.  
  
#### In\-Guest Fibre Channel Synthetic HBA  
A new feature in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] allows you to connect directly to Fibre Channel storage from within the guest operating system that runs in a virtual machine. This feature makes it possible to virtualize workloads and applications that require direct access to Fibre Channel\-based storage. It also makes it possible to configure clustering directly within the guest operating system. This feature makes HBA ports available within the guest operating system.  
  
Hyper\-V can utilize Fibre Channel storage by directly connecting to Fibre Channel LUNs utilizing the guest's virtual HBAs. This is mainly used for access to large volumes, volumes on SANs which the Hyper\-V host itself is not connected to, or for guest\-clustering. Guests cannot boot from Fibre Channel LUNs accessed through the virtual network adapters without utilizing a third\-party Fibre Channel HBA. However, similar to the situation with iSCSI boot, given that guests can boot from SMB 3.0 file shares, there is no advantage to using Fibre Channel boot for virtual machines.  
  
For more information about the in\-guest Fibre Channel HBA, see [Hyper\-V Virtual Fibre Channel Overview](http://technet.microsoft.com/library/hh831413.aspx).  
  
### Virtual Machine Network Interfaces  
Hyper\-V guests support two types of virtual network adapters: synthetic and emulated. Synthetic makes use of the Hyper\-V VMBUS architecture and is the high\-performance, native device. Synthetic devices require the Hyper\-V integration services be installed within the guest. Emulated adapters are available to all guests even if the integration services are not available. They are much slower performing, and should only be used if synthetic is unavailable.  
  
> [!NOTE]  
> When you configure a virtual machine to perform a PXE boot for installation, it will initially configure itself to use an emulated adapter. If you wish to take advantage of the synthetic adapter, you will need to change the adapter type after installation completes.  
  
You can create many virtual networks on the server running Hyper\-V to provide a variety of communications channels. For example, you can create networks to provide the following:  
  
-   Communications between virtual machines only. This type of virtual network is called a private network.  
  
-   Communications between the host server and virtual machines. This type of virtual network is called an internal network.  
  
-   Communications between a virtual machine and a physical network by creating an association to a physical network adapter on the host server. This type of virtual network is called an external network.  
  
### Virtual Processors  
In [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)], Hyper\-V supported a maximum ratio of 8 virtual processors per 1 logical processor for server workloads, and 12 virtual processors per 1 logical processor for VDI workloads. A logical processor is defined as a processing core seen by the host operating system or parent partition. In the case of Intel Hyper\-Threading Technology, each thread is considered a logical processor.  
  
Therefore a 16 logical\-processor server supports a maximum of 128 virtual processors. That would in turn equate to 128 single\-processor virtual machines, 64 dual\-processor virtual machines, or 32 quad\-processor virtual machines. The 8:1 or 12:1 virtual to logical processor ratios are maximum supported limits; it is recommended that lower limits be utilized than the maximum.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], there are no hard or soft coded virtual to logical processor ratios. The recommendation is use dual socket servers with the highest core density available. When planning on scale units and how many virtual machines the scale unit will support, it’s more effective to consider the amount of RAM you will require, as discussed earlier. If more nodes are required to provide required processing power, you can add more nodes to your scale unit. Historical trend analysis will be useful in this context. Trends and thresholds are more important than specific ratios.  
  
## Overview of Suggested Cloud Infrastructure Deployment Scenarios  
Throughout this document you have been presented with hundreds of potential options for how to design a private cloud infrastructure from the storage, networking and compute perspectives. The possible permutations are virtually limitless and you might find it a bit challenging to determine which options would work best for you, and which options work best together. You may even be interested in whether there are tested private cloud infrastructure design patterns that you can use to get your infrastructure started.  
  
To help you in your testing and evaluation of a Microsoft private cloud infrastructure, we have worked on developing and testing three private cloud infrastructure design patterns that you may want to adopt in your own private cloud environment. These design patterns:  
  
-   Represent a hardware and software configuration that has been demonstrated to work in the Microsoft Enterprise Engineering Center \(EEC\)  
  
-   Provide three options that you may want to choose from, where many of the design decisions have been made for you  
  
-   Help you to better understand how you can take advantage of the many improvements in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to get the most out of your private cloud infrastructure investments.  
  
The three design patterns that we've identified and documented are:  
  
-   The Non\-Converged Data Center Configuration  
  
-   The Converged Data Center with File Server Storage Configuration  
  
-   The Converged Data Center without Dedicated Storage Configuration  
  
It is important to note that within the context of these three configurations, the term "converged" refers to the networking configuration. A converged networking design consolidates multiple traffic profiles onto a single network adapter \(or team\) and network and then uses a variety of software constructs to provide the required isolation and Quality of Service for each profile.  
  
Finally, be aware that while these three cloud infrastructure design patterns have made a number of decisions regarding storage, networking and compute functions for you, they do not span the entire gamut of options made available to you through [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. You may want to begin with these patterns and build on top of them by taking advantage of other [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] platform capabilities.  
  
### The Non\-Converged Data Center Configuration  
The Non\-Converged Data Center Configuration cloud infrastructure design pattern is aimed at allowing for easy upgrade of an existing cloud infrastructure based on networking design decisions and hardware configuration recommendations for a Windows Server 2008 R2 infrastructure. The Non\-Converged Data Center Configuration focuses on the following key requirements in the areas of networking, compute and storage:  
  
#### Networking  
  
-   You have an existing investment in separate networks based on the recommended configuration of Hyper\-V in Windows Server 2008 R2 and you require that physical network traffic segmentation be kept in place to avoid re\-architecting your network. Each type of infrastructure traffic \(management, cluster\/CSV, Live Migration and storage\) and tenant traffic are carried over physically separate networks and network adapters. This requirement is met by installing physically separate NICs for each traffic type and assigning VLAN 802.1q tags to each adapter. Alternatively, you can avoid using VLAN tagging and use port based VLANs on your network switches.  
  
-   You require that each traffic type is dedicated to a specific adapter.  This requirement is met by configuring each of the traffic flows to use the correct subnet\/IP address on the dedicated NIC.  
  
-   You require that virtual machine workloads have access to the highest network performance possible. This requirement is met by using the new [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Single Root I\/O Virtualization \(SR\-IOV\) feature, which enables the virtual machines running on the Hyper\-V server to have direct access to the network adapter hardware, thus bypassing the virtual networking stack.  
  
#### Storage  
  
-   You have an existing investment in Fibre Channel or iSCSI SANs and require well\-connected storage so that all members of the Hyper\-V failover cluster are connected to block storage. This requirement is met by configuring your Hyper\-V hosts to keep using the traditional SAN storage. Each member of the Hyper\-V failover cluster can connect to iSCSI, Fibre Channel or Fibre Channel over Ethernet.  
  
-   You require that each member of the Hyper\-V failover cluster be able to access the shared storage. This requirement is met by using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Failover Clustering and Cluster Shared Volumes Version 2 \(CSV v2\) volumes to store virtual machine files and metadata.  
  
#### Compute  
  
1.  You require that you are able to repurpose previous Hyper\-V hardware that ran Windows Server 2008 R2 servers. This requirement is met by reusing previous hardware and making a single change to the hardware configuration, which is to add a 10 GB network adapter that supports SR\-IOV. In addition, you will need to update the BIOS if it doesn't current support SR\-IOV. Alternatively, you could use a 1 GbE adapter and not deploy SR\-IOV. In this document we will demonstrate how to use SR\-IOV.  
  
2.  You require that access to virtual machines is resilient to hardware failure. This requirement can be met by using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Failover Clustering together with the Hyper\-V Server Role.  
  
#### Overview of the Non\-Converged Data Center Configuration  
The Non\-Converged Data Center cloud configuration consists of the following:  
  
-   Multiple computers in a Hyper\-V failover cluster serving both the compute and storage roles.A Hyper\-V cluster is created using the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Failover Cluster feature. The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Failover Clustering feature set is tightly integrated with the Hyper\-V server role and enables a high level of availability from a compute and networking perspective. In addition, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Failover Clustering enhances virtual machine mobility and management which is critical in a cloud environment.  
  
-   A non\-converged networking infrastructure that supports multiple cloud traffic profiles.Each computer in the Hyper\-V failover cluster must have enough network adapters installed to support each traffic type that needs to be isolated from other traffic types. In most cases, this will include network adapters that are assigned to infrastructure traffic such as management, cluster\/CSV, and Live Migration. If you decide to use an Ethernet\-based storage protocol \(such as iSCSI or FCoE\), then you will also need a network adapter for the storage traffic. The infrastructure traffic network adapters in this scenario are non\-teamed 1 GB adapters, although you can use 10 GB adapters or mix 1 GB and 10 GB adapters for the infrastructure traffic types you need to support. In addition, you also have the option of teaming any adapters you like, with the caveat being that RDMA is not supported on teamed adapters. The tenant traffic adapter is a 10 GB adapter that supports SR\-IOV and is not teamed because SR\-IOV and NIC Teaming are not compatible.  
  
-   SAN\-based storage that can be Ethernet or non\-Ethernet based. Storage options include iSCSI, Fibre Channel, Fibre Channel over Ethernet or Infiniband \(non\-Ethernet\). You can also choose to use SAS storage together with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Storage Spaces.  
  
-   The appropriate networking hardware to connect all of the computers in the Hyper\-V cluster to each other and to a larger network from which the hosted virtual machines are available.  
  
The specific design pattern documented in the Non\-Converged Data Center Configuration scenario includes the following:  
  
-   Multiple computers in a Hyper\-V failover cluster  
  
-   Separate 1 GB network adapters over which live migration, cluster, management, and tenant traffic traverse.  
  
-   One 10 GB adapter that is dedicated to tenant traffic that supports SR\-IOV. Note that in the SR\-IOV scenario that all traffic bypasses the Hyper\-V virtual switch, so all traffic isolation depends on the capabilities the unique SR\-IOV NIC may provide in this area.  
  
-   SAN storage based on iSCSI, Fibre Channel, Fibre Channel over Ethernet or Infiniband.  
  
Figure 3 depicts the Non\-Converged Enterprise configuration.  
  
![](../Image/PScen_Hosted_Cloud_nonconverge_Hyper-v_Config.gif)  
  
**Figure 3: High level overview of cluster member networking configuration**  
  
This configuration highlights the following technologies and features of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]:  
  
-   Failover Clustering: A failover cluster is a group of independent computers that work together to increase the availability and scalability of clustered roles \(formerly called clustered applications and services\). The clustered servers \(called nodes\) are connected by physical cables and by software. If one or more of the cluster nodes fail, other nodes begin to provide service \(a process known as failover\). In addition, the clustered roles are proactively monitored to verify that they are working properly. If they are not working, they are restarted or moved to another node. With the Failover Clustering feature, users experience a minimum of disruptions in service.  
  
-   Single Root I\/O Virtualization: Single Root I\/O Virtualization \(SR\-IOV\) is a standard introduced by the PCI\-SIG. SR\-IOV works in conjunction with system chipset support for virtualization technologies. This provides remapping of interrupts and DMA and allows SR\-IOV capable devices to be assigned directly to a virtual machine. Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] enables support for SR\-IOV–capable network devices and allows an SR\-IOV virtual function of a physical network adapter to be assigned directly to a virtual machine. This increases network throughput and reduces network latency, while also reducing the host CPU overhead required for processing network traffic.  
  
> [!NOTE]  
> At least one Active Directory Domain Services \(AD DS\) domain controller is needed for centralized security and management of the cluster member computers \(not shown\). It must be reachable by all of the cluster member computers, including the members of the shared storage cluster. DNS services are also required and are not depicted.  
  
For detailed setup and configuration information that you can use to build the Non\-Converged Data Center Configuration in your own datacenter, please see [Building Your Cloud Infrastructure: Non-Converged Data Center Configuration](../Topic/Building-Your-Cloud-Infrastructure--Non-Converged-Data-Center-Configuration.md).  
  
### The Converged Data Center with File Server Storage Configuration  
The Converged Datacenter with File Server Storage cloud design pattern is essentially defined by the fact that the Hyper\-V computer cluster is separate from the storage cluster. In the Non\-Converged Datacenter Configuration cloud design pattern, the Hyper\-V cluster was attached to block storage. In contrast, the Converged Data Center with File Server Storage Configuration uses a highly available file server cluster to host the VHDX and virtual machine configuration files. The nodes on the Hyper\-V compute cluster access the virtual machine files over the network using the SMB 3.0 protocol. In addition, the Converged Data Center with File Server Storage Configuration uses a converged network pattern on the Hyper\-V compute cluster where the infrastructure traffic profiles \(management, cluster\/CSV, Live Migration and storage\) are hosted on one subnet\/NIC and the tenant traffic is hosted on a separate subnet\/NIC.  
  
The Converged Data Center with File Server Storage Configuration uses:  
  
-   Two subnets \- one for cloud infrastructure traffic \(live migration, cluster, storage and management\) one for tenant traffic.  
  
-   NIC Teaming for network bandwidth aggregation and failover for the infrastructure and tenant subnet.  
  
-   A dedicated file server storage cluster that hosts virtual machine VHDX and configuration files.  
  
-   A dedicated Hyper\-V compute cluster that runs the virtual machine workloads.  
  
#### Design Considerations and Requirements for the Converged Data Center with File Server Storage Pattern  
The Converged Data Center with File Server Storage cloud infrastructure design pattern focuses on the following key requirements in the areas of networking, compute and storage:  
  
##### Networking  
  
-   You require that cloud infrastructure traffic be physically separated from cloud tenant traffic. The requirement is met by creating separate NICs \(or teams\) for infrastructure and tenant traffic and connecting them to different subnets\/segments. The tenant subnet may use NIC Teaming if you like in this scenario.  
  
-   You require that infrastructure traffic \(i.e. live migration, cluster, storage, management\) all receive guaranteed levels of bandwidth. The requirement is met by using Windows QoS policies on the parent Hyper\-V partition.  
  
-   You require that tenant traffic from different tenants receive guaranteed levels of bandwidth. The requirement is met by using Hyper\-V virtual switch QoS policies.  
  
##### Storage  
  
-   You require the ability to scale and manage storage separately from the compute infrastructure. This requirement can be met by creating a dedicated storage cluster that will host the VHDX and virtual machine configuration files. The Hyper\-V compute cluster will connect to the file server cluster using SMB 3.0 to connect to file shares on the storage cluster. The file server cluster will be configured to use the new [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Scale\-out File Server feature so as to provide continuous availability of the virtual machine files.  
  
-   You require a low cost storage option. This requirement is met by using Serial Attached SCSI \(SAS\) disks in shared JBOD enclosures managed through Storage Spaces. Alternatively, if you have existing investments in other storage technologies, each member of the file server failover cluster can connect to iSCSI, Fibre Channel or Fibre Channel over Ethernet.  
  
-   You require a resilient storage solution. This requirement is met by using at least two file servers configured as a failover cluster, with well\-connected \(shared JBODs\) storage so that all members of the file server failover cluster are directly connected to storage with Storage Spaces configured as a mirrored space to guarantee against data loss in the case of disk failures. Each cluster member has redundant connections to the JBOD enclosure and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] MPIO is enabled. In addition, each member of the file server failover cluster is able to access the shared storage by using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Failover Clustering and Cluster Shared Volumes Version 2 \(CSV v2\) volumes to store virtual machine files and metadata.  
  
##### Compute  
  
1.  You require the ability to scale your compute infrastructure separately from your storage infrastructure. This requirement is met by creating a dedicated Hyper\-V compute cluster that connects to remote file server storage for virtual machines and virtual machine configuration files. Local disks on the compute nodes are only used for the boot partition but not for the virtual machines.  
  
2.  You require that virtual machines will be continuously available and resilient to hardware failures. This requirement can be met by using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Failover Clustering together with the Hyper\-V Server Role.  
  
3.  You require the highest number of virtual machines possible per host server \(i.e. increased VM density\). This requirement is met by using processor offload technologies, such as Remote Direct Memory Access \(RDMA\), Receive Side Scaling \(RSS\), Receive Side Coalescing \(RSC\), and Datacenter Bridging \(DCB\).  
  
##### Overview of the Converged Data Center with File Server Storage Configuration  
Based on the above requirements, the Converged Data Center with File Server Storage Configuration has the following characteristics:  
  
-   Multiple computers in a dedicated Hyper\-V compute cluster.A Hyper\-V cluster is created using the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Failover Cluster feature. The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Failover Clustering feature set is tightly integrated with the Hyper\-V server role and enables a high level of availability from a compute and networking perspective. In addition, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Failover Clustering enhances virtual machine mobility and manageability which is critical in a cloud environment. The Hyper\-V cluster is a dedicated compute cluster and does not host storage for virtual machines and virtual machine configuration files.  
  
-   Multiple computers in a dedicated Scale\-out File Server storage cluster.A File Server failover cluster is created using the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Failover Cluster feature. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes a new file server capability known as "Scale\-out File Server for applications" that enables you to store virtual machine and virtual machine configuration files in a file share and make these files continuously available. When you separate the file server cluster from the compute cluster you are able to scale compute and storage resources independently.  
  
-   A converged networking infrastructure that supports physical segmentation of infrastructure and tenant traffic.Each computer in the Hyper\-V failover cluster must have at least two network adapters so that one adapter can host the cloud infrastructure traffic and one adapter can support tenant traffic. If resiliency against NIC failures is required, then you can add additional network adapters on each of the networks, and team them using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Load Balancing and Failover \(LBFO\) NIC Teaming. The NICs can be 10 GbE or 1 GbE network adapters. These NICs will be used for live migration, cluster, storage, management \(together referred to as "infrastructure" traffic\) and tenant traffic. However, keep in mind that NIC Teaming is not compatible with RDMA and is the reason why RDMA is not enabled on the infrastructure network.  
  
-   The appropriate networking hardware \(e.g. Ethernet switches, cables, etc.\) to connect all of the computers in the Hyper\-V cluster to each other and to a larger network from which the hosted virtual machines are available.  
  
Figure 4 provides a high\-level view of the scenario layout. Key elements of the configuration include:  
  
-   A File Server cluster that hosts the virtual hard disks and virtual machine configuration files  
  
-   The File Server cluster is connected only to the infrastructure network  
  
-   The File Server cluster is connected to block storage either through HBAs or over a 10 GB Ethernet network \(as in the case of iSCSI or Fibre Channel of Ethernet \[FCoE\]\)  
  
-   A Hyper\-V compute cluster that hosts the virtual machine workloads.  
  
-   The Hyper\-V compute cluster is connected to the datacenter \(infrastructure\) network and the tenant network using teamed network adapters.  
  
-   Cloud infrastructure traffic flows to and from the host\-based 10GbE network adapter team  
  
-   Tenant network traffic to and from the virtual machines flows through the Hyper\-V virtual switch which is bound to the Tenant Network NIC team.  
  
![](../Image/PScen_Hosted_Cloud_config2_Cloud_Topology.gif)  
  
**Figure 4: High level overview of Converged Datacenter with File Server storage infrastructure design pattern**  
  
> [!NOTE]  
> Although this configuration uses SAS storage on the file server cluster, you can easily choose to use other types of storage, such as iSCSI or Fibre Channel\-based SAN storage. You can find more information about storage configuration for a non\-SAS scenario in the document [Building Your Cloud Infrastructure: Non-Converged Data Center Configuration](../Topic/Building-Your-Cloud-Infrastructure--Non-Converged-Data-Center-Configuration.md), which describes how to configure the SAN storage.  
  
> [!NOTE]  
> At least one Active Directory Domain Services \(AD DS\) domain controller is needed for centralized security and management of the cluster member computers \(not shown\). It must be reachable by all of the cluster member computers, including the members of the shared storage cluster. DNS services are also required and are not depicted.  
  
This configuration highlights the following technologies and features of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]:  
  
-   **Load Balancing and Failover \(LBFO\)**: Load Balancing and Failover \(NIC Teaming\) logically combines multiple network adapters to provide bandwidth aggregation and traffic failover to prevent connectivity loss in the event of a network component failure. Load Balancing with Failover is also known as NIC Teaming in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   **Windows Server Quality of Service \(QoS\)**: [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes improved QoS features that lets you manage bandwidth and provide predictable network performance to traffic to and from the host operating system.  
  
-   **Hyper\-V Extensible Switch Quality of Service \(QoS\)**: In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], The Hyper\-V extensible switch includes QoS features that can be applied on virtual switch ports, and that lets you manage bandwidth and provide predictable network performance to virtual machines running on that server.  
  
-   **Data Center Bridging \(DCB\)**: DCB provides hardware\-based bandwidth allocation to a specific type of traffic and enhances Ethernet transport reliability with the use of priority\-based flow control. Hardware\-based bandwidth allocation is essential if traffic bypasses the operating system and is offloaded to a converged network adapter, which might support Internet Small Computer System Interface \(iSCSI\), Remote Direct Memory Access \(RDMA\) over Converged Ethernet, or Fiber Channel over Ethernet \(FCoE\).  
  
-   **Storage Spaces**: Storage Spaces makes it possible for you to create cost\-effective disk pools that present themselves as a single mass storage location on which virtual disks or volumes can created and formatted.  
  
For detailed setup and configuration information that you can use to build the Non\-Converged Data Center Configuration in your own datacenter, please see [Building Your Cloud Infrastructure: Converged Data Center with File Server Storage Configuration](assetId:///d266e62d-8a95-4c03-9276-9aa6ac0c0474).  
  
### The Converged Data Center without Dedicated Storage Nodes Configuration  
The Converged Data Center without Dedicated Storage Nodes cloud infrastructure design pattern takes advantage of new capabilities in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] that enable you to converge all traffic profiles \(infrastructure and tenant\) to run through a single network adapter or NIC Team. This differs from the previous two design patterns, where in the first one each traffic profile was dedicated to a physical network adapter and where in the second design pattern infrastructure traffic and tenant traffic were carried over different network adapters and subnets. The Converged Data Center without Dedicated Storage Nodes cloud design pattern can greatly simplify your cloud infrastructure by reducing the number of cables and ports you need to deal with.  
  
The Converged Datacenter without Dedicated Storage Nodes Configuration includes:  
  
-   A converged network infrastructure for live migration, cluster, storage, management, and tenant traffic  
  
-   All network traffic moves through the Hyper\-V virtual switch, this includes the host operating system traffic that moves over the infrastructure network.  
  
-   Hyper\-V Virtual Switch Quality of Service \(QoS\)  
  
-   Hyper\-V Virtual Switch port ACLs and 802.1q VLAN tagging  
  
-   NIC Teaming for network bandwidth aggregation and failover  
  
-   Well\-connected storage using SAS JBOD enclosures  
  
#### Design Considerations and Requirements for the Converged Data Center without Dedicated Storage Node Pattern  
The Converged Data Center without Dedicated Storage Nodes cloud infrastructure design pattern focuses on the following key requirements in the areas of networking, compute and storage:  
  
##### Networking  
  
-   You prefer that network traffic to and from both the host operating system and the guest operating systems running on the host move through a single network adapter team. This requirement is met by using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] NIC Teaming \(LBFO\) and passing all traffic through the Hyper\-V virtual switch.  
  
-   You require that live migration, cluster, storage, management and tenant traffic all receive guaranteed levels of bandwidth. The requirement is met by using Hyper\-V virtual switch QoS policies.  
  
-   You require that infrastructure traffic \(which includes Live Migration, cluster, storage and management traffic\) and tenant traffic be isolated from each other. This requirement is met by using Hyper\-V virtual switch port ACLs and 802.1q VLAN tagging.  
  
##### Storage  
  
-   You prefer to scale your cloud infrastructure by adding scale units consisting of compute and storage capacity together. This requirement is met by connecting the Hyper\-V servers directly to SAS storage, without having dedicated file servers. Note that you can also use SAN based storage connected to the compute cluster in this design pattern.  
  
-   You require cost\-effective storage. This requirement is met by using SAS disks in shared JBOD enclosures managed through Storage Spaces.  
  
-   You require a resilient storage solution. This requirement is met by having multiple Hyper\-V servers configured as a failover cluster, and having a well\-connected \(shared JBODs\) storage so that all members of the failover cluster are directly connected to storage, and by having Storage Spaces configured as a mirrored space to guarantee against data loss in the case of disk failures  
  
-   You require that each member of the Hyper\-V failover cluster be able to access the shared storage where the VHDs are located. This requirement is met by using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Failover Clustering and Cluster Shared Volumes Version 2 \(CSV v2\) volumes to store virtual machine files and metadata.  
  
##### Compute  
  
-   You require that the virtual machines will be continuously available and resilient to hardware failures. This requirement can be met by using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Failover Clustering together with the Hyper\-V Server Role.  
  
-   You require the highest number of virtual machines possible per host server \(i.e. increased density\). This requirement is met by using processor offload technologies, such as Remote Direct Memory Access \(RDMA\), Receive Side Scaling, Receive Side Coalescing \(RSC\), and Datacenter Bridging \(DCB\). Please note that in the default configuration presented here \(without a dedicated storage access NIC\), RDMA and DCB cannot be used because these technologies require direct access to the hardware and must bypass much of the virtual networking stack and this compatible with NIC Teaming. This is similar to the situation with Single Root I\/O Virtualization \(SR\-IOV\). For optimal performance, especially in the context of network access to storage, a separate NIC team would be required to support these hardware offload acceleration technologies.  
  
The Converged Datacenter without Dedicated Storage nodes cloud infrastructure design pattern consists of the following:  
  
-   Multiple computers in a Hyper\-V failover cluster. A Hyper\-V cluster is created using the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Failover Cluster feature. The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Failover Clustering feature set is tightly integrated with the Hyper\-V server role and enables a high level of availability from a compute and networking perspective. In addition, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Failover Clustering enhances virtual machine mobility which is critical in a cloud environment. For example, Live Migration is enhanced when performed in a failover cluster deployment because the cluster can automatically evaluate which node in the cluster is optimal for migrated virtual machine placement.  
  
-   A converged networking infrastructure that supports multiple cloud traffic profiles. Each computer in the Hyper\-V failover cluster should have at least two network adapters that will be used for the converged network. This converged network will host all traffic to and from the server, which includes both host system traffic and guest\/tenant traffic. The network adapters will be teamed by using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Load Balancing and Failover \(LBFO\) NIC Teaming. The NICs can be either two or more 10 GbE or 1 GbE network adapters. These NICs will be used for live migration, cluster, storage, management \(together referred to as "infrastructure" traffic\) and tenant traffic.  
  
-   The appropriate networking hardware to connect all of the computers in the Hyper\-V cluster to each other and to a larger network from which the hosted virtual machines are available.  
  
The following figure provides a high\-level view of the scenario architecture. The teamed network adapters on each member of the failover cluster are connected to what will be referred to as a converged subnet in this document. We use the term converged subnet to make it clear that all traffic to and from the Hyper\-V cluster members and the tenant virtual machines on each cluster member must flow through the teamed converged subnet network adapter. Both the host operating system and the tenants connect to the network through the Hyper\-V virtual switch. The figure also shows an optional network adapter that is RDMA\-capable that can be used for storage traffic, such as when storage is being hosted on a share on a remote file server.  
  
![](../Image/PScen_Hosted_Cloud_config3_.gif)  
  
**Figure 5 High level overview of cluster member networking configuration**  
  
> [!NOTE]  
> At least one Active Directory Domain Services \(AD DS\) domain controller is needed for centralized security and management of the cluster member computers \(not shown\). It must be reachable by all of the cluster member computers, including the members of the shared storage cluster. DNS services are also required and are not depicted.  
  
Figure 6 provides an overview of traffic flows on each member of the Hyper\-V cluster. The figure calls out the following significant issues in the configuration:  
  
-   Each cluster node member uses a virtual network adapter to connect to the Hyper\-V Extensible Switch, which connects it to the physical network.  
  
-   Each tenant virtual machine is also connected to the Hyper\-V Extensible Switch using a virtual network adapter.  
  
-   Network adapters named ConvergedNet1 and ConvergedNet2 participate in a teamed physical network adapter configuration using the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Failover and Load Balancing feature.  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Hyper\-V virtual switch QoS is used to assure that each traffic type \(such as live migration, cluster, management and tenant\) has a predictable amount of bandwidth available.  
  
-   Traffic isolation is enabled by 802.1q VLAN tagging so that host traffic is not visible to the tenants.  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Hyper\-V virtual switch port ACLs can also be used for more granular access control at the network level.  
  
It is important to note that Remote Direct Memory Access \(RDMA\) cannot be used on the converged network because it does not work together with the Hyper\-V virtual switch and NIC Teaming. This will be an issue if you prefer to use high performance SMB 3 connectivity to file server based storage for virtual machine disk and configuration files.  
  
> [!NOTE]  
> Virtual local area networks \(VLANs\) are not assigned to each tenant because VLAN\-based network isolation is not a scalable solution and is not compatible with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] network virtualization. VLANs are used to isolate infrastructure traffic from tenant traffic in this scenario.  
  
![](../Image/PScen_Hosted_Cloud_config3_2.gif)  
  
**Figure 6 Overview of cluster member traffic flows**  
  
This configuration highlights the following technologies and features of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]:  
  
-   **Load Balancing and Failover \(LBFO\)**: Load Balancing and Failover logically combines multiple network adapters to provide bandwidth aggregation and traffic failover to prevent connectivity loss in the event of a network component failure. Load Balancing with Failover is also known as NIC Teaming in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   **Hyper\-V Virtual Switch Quality of Service \(QoS\)**: In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], QoS includes new bandwidth management features that let you provide predictable network performance to virtual machines on a server running Hyper\-V.  
  
-   **Hyper\-V Virtual Switch Quality of Service \(QoS\)**: In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] the Hyper\-V virtual switch includes new capabilities that enhance the security of the cloud infrastructure. You can now use Port Access Control Lists \(Port ACLs\) and VLAN support to get network isolation similar to what you find when using physical network isolation.  
  
-   **Storage Spaces**: Storage Spaces makes it possible for you to create cost\-effective disk pools that present themselves as a single mass storage location on which virtual disks or volumes can created and formatted.  
  
For detailed setup and configuration information that you can use to build the Non\-Converged Data Center Configuration in your own datacenter, please see [Building Your Cloud Infrastructure: Converged Data Center without Dedicated Storage Nodes Configuration](assetId:///f38e1f6b-c18f-4135-9641-517754281570).  
  
