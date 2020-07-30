---
author: eross-msft
ms.author: lizross
ms.date:  10/02/2018
ms.prod: windows-server
ms:topic: include
---

With Dynamic, outbound loads are distributed based on a hash of the TCP ports and IP addresses. Dynamic mode also rebalances loads in real time so that a given outbound flow may move back and forth between team members. Inbound loads, on the other hand, get distributed the same way as Hyper-V Port. In a nutshell, Dynamic mode utilizes the best aspects of both Address Hash and Hyper-V Port and is the highest performing load balancing mode. 

