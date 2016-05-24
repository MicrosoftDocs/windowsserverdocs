---
title: Data Center Bridging
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 11f008df-4f90-413b-b388-a30973934944
---
# Data Center Bridging
  
## <a name="BKMK_DCB"></a>Data Center Bridging  
Data Center Bridging \(DCB\) is a suite of Institute of Electrical and Electronics Engineers \(IEEE\) standards that enable Converged Fabrics in the data center, where storage, data networking, cluster IPC and management traffic all share the same Ethernet network infrastructure. DCB provides hardware\-based bandwidth allocation to a specific type of traffic and enhances Ethernet transport reliability with the use of priority\-based flow control.  
  
Hardware\-based bandwidth allocation is essential if traffic bypasses the operating system and is offloaded to a converged network adapter, which might support Internet Small Computer System Interface \(iSCSI\), Remote Direct Memory Access \(RDMA\) over Converged Ethernet, or Fiber Channel over Ethernet \(FCoE\). Priority\-based flow control is essential if the upper layer protocol, such as Fiber Channel, assumes a lossless underlying transport.  
  
For more information, see [Data Center Bridging &#40;DCB&#41; Overview](../Topic/Data-Center-Bridging--DCB--Overview.md) and [Overview of Data Center Bridging \(Windows Drivers\)](http://msdn.microsoft.com/library/windows/hardware/hh440120(v=vs.85).aspx)  
  
