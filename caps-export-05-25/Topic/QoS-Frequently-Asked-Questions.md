---
title: QoS Frequently Asked Questions
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d8d314b6-1bb2-425e-855b-2074b62ca4f2
author: vhorne
---
# QoS Frequently Asked Questions
  
## <a name="bkmk_qosfaq"></a>Frequently Asked Questions  
Following are frequently asked questions – and answers to those questions – for QoS configuration.  
  
1.  **Is QoS enabled by default?**  
  
    No, QoS is not enabled by default. You must configure Bandwidth Management, Classification and Tagging, or PFC explicitly. For more information, see [Related topics](#bkmk_related).  
  
2.  **Is there a recommended default QoS configuration?**  
  
    No. Due to variations in server configurations and workloads, there is no recommended default QoS configuration. However, the examples in this document can serve as a basis for QoS configurations for many deployments in datacenters.  
  
3.  **Can DCB be leveraged on a NIC that is bound to a Hyper\-V Virtual Switch?**  
  
    Yes. By default, when a DCB\-capable NIC is bound to a Hyper\-V Virtual Switch, DCB is disabled. To take advantage of the hardware bandwidth management functionality, administrators can enable this component by using the following Windows PowerShell command in the management operating system. In addition, you can refer to the example [2 NICs with NIC Teaming](../Topic/QoS-Common-Configurations.md#bkmk_2) for information on how to classify and tag traffic, and how to allow tagged traffic to go through the Hyper\-V Virtual Switch.  
  
    ```  
    # Enable the DCB component for the DCB NIC that is bound to a Hyper-V switch  
    Enable-NetAdapterBinding “DCB NIC bound to Hyper-V switch” –ComponentID ms_lldp  
    ```  
  
4.  **Can multiple virtual network adapters be created for one workload and still have QoS \(particularly Bandwidth Management\) applied to them?**  
  
    Yes. In fact, to leverage MPIO, you must create multiple virtual network adapters in the management operating system. In addition, you must configure Minimum Bandwidth and Maximum Bandwidth on a per\-virtual network adapter basis. Also, these virtual network adapters must be placed in different IP subnets.  
  
