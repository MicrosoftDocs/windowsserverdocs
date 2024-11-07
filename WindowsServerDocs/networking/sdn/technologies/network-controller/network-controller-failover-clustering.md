---
title: Network Controller with Failover Clustering on Windows Server and Azure Stack HCI
description: Learn about Network Controller high availability using Failover Clustering for Software Defined Networking (SDN) in Windows Server and Azure Stack HCI.
author: robinharwood
ms.author: roharwoo
ms.topic: concept-article 
ms.date: 11/07/2024
zone_pivot_groups: windows-os
#Customer intent: As a network administrator, I want to understand how Network Controller works with Failover Clustering so that I can deploy and manage my tenant network configurations.

---

# Network Controller with Failover Clustering

Beginning with Windows Server 2025 and Azure Stack HCI, version 24H2, Software Defined Networking infrastructure uses a smaller footprint for the Network Controller (NC), one of the core infrastructural components. NC can now be deployed directly on the host as a Failover Clustering service. Service Fabric based infrastructure continues to be supported. This article provides an overview of Network Controller high availability using Failover Clustering, how it works with Software Load Balancer and Gateways, and how it differs from Network Controller on Service Fabric.

## Network Controller as a role

Network Controller is the brain of the SDN ecosystem. It allows you to deploy and manage your tenant network configurations, including virtual networking, logical networking, and network security. Network Controller a key infrastructural component, and it had to be hosted inside a VM in previous versions. VM-based resource deployment is a long and resource-intensive. VMs took up more CPU and Memory, resources that could be spent on your core application workloads. Beginning with Windows Server 2025 and Azure Stack HCI, version 24H2, the NC footprint is when used with Failover Clustering on the host, freeing up resources for your other workloads. The following illustration provides an overview of the key differences between NC on Service Fabric and NC on Failover Clustering.

Figure 1: Network Controller on Service Fabric vs Network Controller on Failover Clustering

## Architecture

With Network Controller on Failover Clustering, all the Network Controller microservices are now contained in a failover cluster resource group. SDN microservices use a single database and single partition, rather than three databases duplicated across 3 VMs when using Service Fabric. With each SDN microservice as a Failover Clustering resource group, there’s a significant reduction in CPU utilization and storage.

¬¬Figure 2: Network Controller on Failover Clustering

The diagram shows an overview of the Network Controller architecture and how it relates to the different logical layers such as data, control, and management planes. Network Controller and all its services are set as a Failover Cluster group set across the servers in your Software Defined Networking cluster. For example, your network topology includes four servers clustered together with a single Top-of-Rack (ToR) Switch, and the Network Controller component as a _Failover Clustering Generic Resource_. Instead of the three VMs in previous versions, each Network Controller microservice is highly available as a Failover Cluster Resource Group. The following diagram shows a 4-node deployment with Network Controller on Failover Clustering.

Figure 3: Network Controller on Failover Clustering on a 4-node deployment

The resource group has the same provisioning requirements as NC VMs. The API Microservice requires a floating IP address in your management network and DNS registration is still supported.

## High Availability

With Network Controller on Failover Clustering, resource ownership is associated with a specific node within the Failover Cluster. When a server goes down, resource groups are transferred to another node within the cluster. Replication of data is done through the underlying infrastructure of Failover Clustering which is Storage Replica. To learn more about Failover Clustering and Storage Replica, see the following resources:

:::zone pivot="windows-server"

- [Failover Clustering in Windows Server and Azure Stack HCI](../../../failover-clustering/failover-clustering-overview.md)
- [Storage Replica Overview](../../../storage/storage-replica/storage-replica-overview.md)

:::zone-end

:::zone pivot="azure-stack-hci"

- [Failover Clustering in Windows Server and Azure Stack HCI](../../../failover-clustering/failover-clustering-overview.md?context=/azure-stack/context/hci-context)
- [Storage Replica Overview](../../../storage/storage-replica/storage-replica-overview.md?context=/azure-stack/context/hci-context)

:::zone-end

## Software Load Balancing and Gateways

This transition from Service Fabric to Failover Clustering only affects our Network Controlling services. Other network function virtualization roles, such as the Software Load Balancer and Gateway are still hosted on Virtual Machines. Network Controller on Failover Clustering doesn't affect the behavior  or operation of other network function virtualization roles. For more details on Software Load Balancing and Gateways, visit the following links:

- [What is Software Load Balancer (SLB) for SDN?](/azure-stack/hci/concepts/software-load-balancer)

- [What is Remote Access Service (RAS) Gateway for Software Defined Networking?](/azure-stack/hci/concepts/gateway-overview)

## Next steps

For additional information regarding Software Defined Networking, check out some of our other resources available to you:

:::zone pivot="windows-server"

- YouTube Series

- LINK TECH BLOG

- [Plan a SDN Deployment](/azure-stack/hci/concepts/plan-software-defined-networking-infrastructure)

:::zone-end

:::zone pivot="azure-stack-hci"

- YouTube Series

- <LINK TECH BLOG>

- [Plan a SDN Deployment](/azure-stack/hci/concepts/plan-software-defined-networking-infrastructure?context=/azure-stack/context/hci-context)

:::zone-end
