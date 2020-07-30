---
title: vRSS Frequently Asked Questions
description: In this topic, you find some commonly asked questions and answers about using vRSS.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 61ae242e-82a8-430d-b07d-52b86c01e686
ms.localizationpriority: medium
manager: dougkim
ms.date: 09/05/2018
ms.author: lizross
author: eross-msft
---

# vRSS Frequently Asked Questions

In this topic, you find some commonly asked questions and answers about using vRSS.

## What are the requirements for the physical network adapters that I use with vRSS?

Network adapters must be compatible with Virtual Machine Queue \(VMQ\) and must have a link speed of 10 Gbps or more.

For more information, see [Plan the Use of vRSS](vrss-plan.md).

## Does vRSS work with hyper\-threaded processor cores?

No. Both vRSS and VMQ ignore hyper\-threaded processor cores.

## Does vRSS work for host virtual NICs \(vNICs\)?

Yes. Use the **-ManagementOS** parameter instead of the virtual machine \(VM\) name on the **Set-VMNetworkAdapter** Windows PowerShell command, and **Enable-NetAdapterRss** on the host vNIC.

For more information, see [Windows PowerShell Commands for RSS and vRSS](vrss-wps.md).

## How many logical processors does a VM need to use vRSS?

VMs need two or more logical processors \(LPs\) to be able to use vRSS.

For more information, see [Plan the Use of vRSS](vrss-plan.md).

## Is vRSS compatible with NIC Teaming?

Yes. If you are using NIC Teaming, it is important that you properly configure VMQ to work with the NIC Teaming settings. For detailed information about NIC Teaming deployment and management, see [NIC Teaming](https://docs.microsoft.com/windows-server/networking/technologies/nic-teaming/nic-teaming).

## vRSS is enabled, but how do I know if it is working? 

You'll be able to tell vRSS is working by opening the task manager in your VM and viewing the virtual processor utilization. If there are multiple connections established to the VM, you can see more than one core above 0% utilization.

Because a single TCP session cannot be load balanced across multiple logical processor cores, your VM must be receiving multiple TCP sessions before you can observe whether or not vRSS is working.

If the VM is receiving multiple TCP sessions, but you do not see more than one LP core above 0% utilization, ensure that you have completed all of the preparation steps in the topic [Plan the Use of vRSS](vrss-plan.md).

## I'm looking at the host and not all of the processors are being used. It looks like every other one is being skipped.
  
Check to see if hyper threading is enabled. Both VMQ and vRSS are designed to skip hyper\-threaded cores.

## Are there different Windows PowerShell commands for RSS and vRSS?

Yes and no. While you use the same commands for both RSS in native hosts and RSS in VMs, vRSS also requires VMQ to be enabled on the physical NIC - and for the VM and vRSS to be enabled on the switch port.

For more information, see [Windows PowerShell Commands for RSS and vRSS](vrss-wps.md).

---
