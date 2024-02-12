---
title: SLB Gateway Performance Tuning in Software Defined Networks
description: SLB Gateway performance tuning guidelines on SDN networks
ms.topic: article
ms.author: grcusanz
author: phstee
ms.date: 04/01/2023
---

# SLB Gateway Performance Tuning in Software Defined Networks

Applies to: Windows Server (All supported versions)

Software load balancing is provided by a set of Load Balancer Multiplexor (Mux) VMs, with the load balancer manager in the Network Controller VMs and the Hyper-V Virtual Switch.

No other performance tuning is required to configure the Network Controller or the Hyper-V host for load balancing beyond what is described in the [Software Defined Networking](index.md) section. If you're using SR-IOV for the Muxes, make sure to review the [SLB Mux VM Configuration](#slb-mux-vm-configuration) section.

## SLB Mux VM Configuration

SLB Mux virtual machines are deployed in an active-active configuration, meaning that every Mux VM that's deployed and added to the Network Controller can process incoming requests. In an active-active configuration, the total aggregate throughput of all of the connections is limited only by the number of Mux VMs that you deployed.

An individual connection to a Virtual IP (VIP) will always be sent to the same Mux, assuming the number of muxes remains constant and its throughput is limited to the throughput of a single Mux VM.  Muxes only process the inbound traffic that's going to a VIP.  Response packets go directly from the VM that's sending the response to the physical switch that forwards it on to the client.

In some cases, when the source of the request originates from an SDN host that's added to the same Network Controller that manages the VIP, further optimization of the inbound path for the request is also performed. With the SDN host and the VIP managed by the same controller, most packets are able to travel directly from the client to the server, bypassing the Mux VM entirely. No other configuration is required for this optimization to happen.

Each SLB Mux VM must be sized according to the guidelines provided in the SDN infrastructure virtual machine role requirements section. Learn more in the [Plan a Software Defined Network Infrastructure](/azure-stack/hci/concepts/plan-software-defined-networking-infrastructure) article.

## Single Root IO virtualization (SR-IOV)

When you're using 40 Gigabit Ethernet, the ability for the virtual switch to process packets for the Mux VM becomes the limiting factor for Mux VM throughput. SR-IOV should be enabled on the SLB VM's VM Network Adapter to ensure that the virtual switch isn't the bottleneck.

To enable SR-IOV, you must enable it on the virtual switch when the virtual switch is created.  In this example, we're creating a virtual switch with switch embedded teaming (SET) and SR-IOV:

``` syntax
    new-vmswitch -Name SDNSwitch -EnableEmbeddedTeaming $true -NetAdapterName @("NIC1", "NIC2") -EnableIOV $true
```

It must also be enabled on the virtual network adapter(s) of the SLB Mux VM that process the data traffic.  In this example, SR-IOV is being enabled on all adapters:

``` syntax
    get-vmnetworkadapter -VMName SLBMUX1 | set-vmnetworkadapter -IovWeight 50
```
