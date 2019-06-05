---
title: Generation 1 virtual machine security settings for Hyper-V
description: "Describes the security settings available in Hyper-V Manager for generation 1 virtual machines"
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f8f8c569-8b74-4c19-876e-1c7d00cce308
author: larsiwer
ms.author: kathydav
ms.date: 10/04/2016
---
# Generation 1 virtual machine security settings

>Applies To: Windows Server 2016, Microsoft Hyper-V Server 2016, Windows Server 2019, Microsoft Hyper-V Server 2019

Use the generation 1 virtual machine security settings in Hyper-V Manager to help protect the data and state of a virtual machine.

## Encryption support settings in Hyper-V Manager

You can help protect the data and state of the virtual machine by selecting the following encryption support option.

- **Encrypt state and virtual machine migration traffic** - Encrypts the virtual machine saved state when it's written to disk and the live migration traffic.

To enable this option, you must add a key storage drive for the virtual machine.

## Key storage drive in Hyper-V Manager

A key storage drive provides a small drive to the virtual machine for a BitLocker key to be stored. This allows the virtual machine to encrypt its operating system disk without requiring a virtualized Trusted Platform Module (TPM) chip. The contents of the key storage drive are encrypted by using a Key Protector. The Key Protector authories the Hyper-V host to run the virtual machine. Both the contents of the key storage drive and the Key Protector are stored as part of the virtual machine's runtime state.

To decrypt the contents of the key storage drive and start the virtual machine, the Hyper-V host needs to be either:

- Part of an authorized guarded fabric for this virtual machine, or
- Have the private key from one of the virtual machine's guardians.

To learn more about guarded fabrics, please see the Introducing Shielded VMs section in [Security and Assurance](../../../security/Security-and-Assurance.md).

You can add a key storage drive to an empty slot on one of the virtual machine's IDE controllers. To do this, click **Add Key Storage Drive** to add a key storage drive to the first free IDE controller slot of this virtual machine.

## See also

- [Generation 2 virtual machine security settings in Hyper-V manager](Generation-2-virtual-machine-security-settings-for-hyper-v.md)
- [Security and Assurance](../../../security/Security-and-Assurance.md)