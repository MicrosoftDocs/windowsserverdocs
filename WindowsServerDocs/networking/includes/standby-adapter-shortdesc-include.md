---
author: eross-msft
ms.author: lizross
ms.date:  10/02/2018
ms.prod: windows-server
ms:topic: include
---

The options for Standby Adapter are **None (all adapters Active)** or your selection of a specific network adapter in the NIC Team that acts as a Standby adapter. When you configure a NIC as a Standby adapter, all other unselected team members are Active, and no network traffic is sent to or processed by the adapter until an Active NIC fails. After an Active NIC fails, the Standby NIC becomes active and processes network traffic. When all team members get restored to service, the standby team member returns to standby status.  