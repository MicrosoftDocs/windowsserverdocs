---
title: Compatible hardware with Windows Server Virtualization-based protection of Code Integrity
ms.custom: na
ms.prod: windows-server
ms.topic: article
ms.assetid: 15ded82c-f70f-4efb-9e26-2731127931af
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Compatible hardware with Windows Server Virtualization-based protection of Code Integrity

>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

Windows Server 2016 introduced a new Virtualization-based code protection to help protect physical and virtual machines from attacks that modify system code. 
To achieve this high protection level, Microsoft works in tandem with the computer hardware manufactures (Original Equipment Manufacturers, or OEMs) to prevent malicious writes into system execution code. 
This protection can be applied to any system and is being used as one of the building blocks for implementing the Hyper-V host health for shielded virtual machines (VMs). 

As with any hardware based protection, some systems might not be compliant due to issues such as incorrect marking of memory pages as executables or by actually trying to modify code at run time, which may result in unexpected failures including data loss or a blue screen error (also called a stop error). 

To be compatible and fully support the new security feature, OEMs need to implement the Memory Address Table defined in UEFI 2.6, which was published in Jan. 2016. 
The adoption of the new UEFI standard takes time; meanwhile, to prevent customers encountering issues, we want to provide information about systems and configurations that we have tested this feature set with as well as systems that we know to be not compatible. 

## Non-compatible systems

The following configurations are known to be non-compatible with Virtualization-based protection of code integrity and cannot be used as a host for Shielded VMs:

- Dell PowerEdge Servers running PERC H330 RAID Controllers
    For more information, see the following article from Dell Support [H330 – Enabling “Host Guardian Hyper-V Support” or “Device Guard” on Win 2016 OS causes OS boot failure](http://www.dell.com/Support/Article/us/en/19/QNA44045).  


## Compatible systems

These are the systems we and our partners have been testing in our environment. 
Please make sure that you verify the system works as expected in your environment: 

- Virtual Machines – You can enable Virtualization-based protection of code integrity on virtual machines that run on a Hyper-V host beginning with Windows Server 2016.



