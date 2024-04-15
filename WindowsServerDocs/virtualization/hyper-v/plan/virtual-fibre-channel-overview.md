---
title: Hyper-V Virtual Fibre Channel
description: 
ms.topic: conceptual
ms.author: helohr
author: Heidilohr
ms.date: 004/12/2024
---

# Hyper-V Virtual Fibre Channel

> Applies to: Windows Server 2019, Windows Server 2016

Hyper-V provides Fibre Channel ports within guest operating systems (OSes) that let you connect to Fibre Channel directly from your virtual machines (VMs). This feature lets you virtualize workloads that use direct access to Fibre Channel storage, cluster guests over Fibre Channel, and gives you more storage options for servers hosted in your virtualization infrastructure. This article describes what Fibre Channel on Hyper-V is and how it works.

## Prerequisites

In order to use Virtual Fibre Channel on Hyper-V, your deployment must have the following:

- One or more installations of Windows Server 2012 or later with the Hyper-V role installed.

- A device with one or more Fibre Channel host bus adapters (HBAs) and an updated HBA driver that supports Virtual Fibre Channel.

- The HBA ports must also have Fibre Channel topography that can support N_Port ID Virtualization (NPIV), a maximum transfer size of at least 0.5 MB, and data transfers of at least 128 physical pages.

- An NPIV-enabled Storage Area Network (SAN).

- VMs that use Windows Server 2012 or later as their guest OS and can support virtual Fibre Channel adapters.

- Storage accessible through Virtual Fibre Channel support devices that present logical units. The storage must not use Virtual Fibre Channel logical units as boot media.

## How Virtual Fibre Channel works

Virtual Fibre Channel for Hyper-V provides the guest OS with unmediated access to a SAN by using a standard World Wide Name (WWN) associated with a virtual machine. Hyper-V users can use Fibre Channel SANs to virtualize workloads that require direct access to SAN logical unit numbers (LUNs). Fibre Channel SANs also let you operate in new scenarios, such as running failover clustering inside the guest OS of a VM connected to shared Fibre Channel storage.

Physical deployments use the advanced storage functionality of mid-range and high-end storage arrays to offload certain management tasks from hosts to the Windows software virtual hard disk stack. In virtualized deployments, Virtual Fibre Channel plays a similar role, letting you use your SANs directly from Hyper-V VMs to offload functionality. For example, when you use Hyper-V to take a snapshot of a LUN, you can offload storage functionality on the SAN hardware by using a hardware Volume Shadow Copy Service (VSS) provider in a Hyper-V VM.

There are several components to this feature that allow it to offload management and storage tasks that we cover in the following sections.

### NPIV support

Virtual Fibre Channel for Hyper-V guests uses the existing N_Port ID Virtualization (NPIV) T11 standard to map multiple virtual N_Port IDs to a single physical Fibre Channel N_port. A new NPIV port is created on the host each time you start a virtual machine that is configured with a virtual HBA. When the virtual machine stops running on the host, the NPIV port is removed. Due to the use of NPIV, the HBA ports used for virtual Fibre Channel should be set up in a Fibre Channel topology that supports NPIV, and the SAN should support NPIV ports.

### Virtual SAN support

### Tape library support

### Live migration

### MPIO functionality