---
author: eross-msft
ms.author: lizross
ms.date:  10/02/2018
ms.prod: windows-server
ms:topic: include
---

With Hyper-V Port, NIC Teams configured on Hyper-V hosts give VMs independent MAC addresses.  The VMs MAC address or the VM ported connected to the Hyper-V switch, can be used to divide network traffic between NIC Team members. You cannot configure NIC Teams that you create within VMs with the Hyper-V Port load balancing mode. Instead, use the Address Hash mode. 