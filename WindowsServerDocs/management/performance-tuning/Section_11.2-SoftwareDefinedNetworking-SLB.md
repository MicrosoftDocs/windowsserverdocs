---
title: Software Defined Networking SLB Gateway Performance  
description: Software Defined Networking SLB Gateway Performance
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: performance-tuning-guide
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1ccf2079-797e-41c5-b621-de1379d273c1
author: phstee
ms.author: grcusanz
ms.date: 10/31/2016
---

# Software Defined Networking SLB Gateway Performance

Software load balancing is provided by a combination of a load balancer manager in the network controller, the Hyper-V Virtual Switch and as set of Load Balancer Multixplexor (Mux) VMs.

No additional performance tuning is required to configure the network controller or the Hyper-V host for load balancing beyond what is described in the [Software Defined Networking](./Section_11.0-SoftwareDefinedNetworking.md) section, unless you will be using SR-IOV as described below.
 
## SLB Mux VM Configuration

SLB Mux virtual machines are deployed in an Active-Active configuration.  This means that every Mux VM that is deployed and added to the network controller is able to process incoming requests.  This means the total aggregate throughput of all of the connections is only limited by the number of Mux VMs that you have deployed.  Each individual connection will be limited to the throughput of a single Mux VM.  Muxes only process the inbound traffic that is destined to a virtual IP (VIP).  Response packets go directly from the VM that is sending the response to the physical switch which forwards it on to the client.

Each SLB Mux VM must be sized according to the guidelines provided in the SDN infrastructure virtual machine role requirements section of the [Plan Software Defined Networking](../../networking/sdn/plan/Plan-Software-Defined-Networking.md) topic.

## SR-IOV

When using 40Gbit ethernet, the processing of packets in the virtual switch becomes the limiting factor for SLB Mux VM throughput.  Because of that it is recommended that you enable SR-IOV on the SLB VM's VM Network Adapter to ensure that the virtual switch is not the bottleneck.

To enable SR-IOV, you must enable it on the virtual switch when the virtual switch is created:

    TODO: Enable SRIOV command

Then, it must be enabled on the virtual network adapter of the SLB Mux VM:

