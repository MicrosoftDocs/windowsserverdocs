---
title: SLB Gateway Performance Tuning in Software Defined Networks  
description: SLB Gateway performance tuning guidelines on SDN networks 
ms.prod: windows-server
ms.technology: performance-tuning-guide
ms.topic: article
ms.author: grcusanz; AnPaul
author: phstee
ms.date: 10/16/2017
---

# SLB Gateway Performance Tuning in Software Defined Networks

Software load balancing is provided by a combination of a load balancer manager in the Network Controller VMs, the Hyper-V Virtual Switch and a set of Load Balancer Multixplexor (Mux) VMs.

No additional performance tuning is required to configure the Network Controller or the Hyper-V host for load balancing beyond what is described in the [Software Defined Networking](index.md) section, unless you will be using SR-IOV for the Muxes as described below.

## SLB Mux VM Configuration

SLB Mux virtual machines are deployed in an Active-Active configuration.  This means that every Mux VM that is deployed and added to the Network Controller can process incoming requests.  Thus, the total aggregate throughput of all of the connections is only limited by the number of Mux VMs that you have deployed.  

An individual connection to a Virtual IP (VIP) will always be sent to the same Mux, assuming the number of muxes remains constant, and as a result its throughput will be limited to the throughput of a single Mux VM.  Muxes only process the inbound traffic that is destined to a VIP.  Response packets go directly from the VM that is sending the response to the physical switch which forwards it on to the client.

In some cases when the source of the request originates from an SDN host that is added to the same Network Controller that manages the VIP, further optimization of the inbound path for the request is also performed which enables most packets to travel directly from the client to the server, bypassing the Mux VM entirely.  No additional configuration is required for this optimization to take place.

Each SLB Mux VM must be sized according to the guidelines provided in the SDN infrastructure virtual machine role requirements section of the  [Plan a Software Defined Network Infrastructure](../../../../networking/sdn/plan/Plan-a-Software-Defined-Network-Infrastructure.md) topic.

## Single Root IO virtualization (SR-IOV)

When using 40Gbit Ethernet, the ability for the virtual switch to process packets for the Mux VM becomes the limiting factor for Mux VM throughput.  Because of this it is recommended that SR-IOV be enabled on the SLB VM's VM Network Adapter to ensure that the virtual switch is not the bottleneck.

To enable SR-IOV, you must enable it on the virtual switch when the virtual switch is created.  In this example, we are creating a virtual switch with switch embedded teaming (SET) and SR-IOV:
``` syntax
    new-vmswitch -Name SDNSwitch -EnableEmbeddedTeaming $true -NetAdapterName @("NIC1", "NIC2") -EnableIOV $true
```
Then, it must be enabled on the virtual network adapter(s) of the SLB Mux VM which process the data traffic.  In this example, SR-IOV is being enabled on all adapters:
``` syntax
    get-vmnetworkadapter -VMName SLBMUX1 | set-vmnetworkadapter -IovWeight 50
```
