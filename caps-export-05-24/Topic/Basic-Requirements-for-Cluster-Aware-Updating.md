---
title: Basic Requirements for Cluster-Aware Updating
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1e7e20b4-26e1-46b4-8427-650e62fe428e
---
# Basic Requirements for Cluster-Aware Updating
Your cluster environment and existing software update infrastructure must meet certain requirements before you can use Cluster\-Aware Updating \(CAU\). For detailed information, see [Requirements and Best Practices for Cluster\-Aware Updating \[WS8\]](../Topic/Requirements-and-Best-Practices-for-Cluster-Aware-Updating.md).  
  
At any time, to verify that your cluster environment is ready for CAU, select the **Analyze cluster updating readiness** action in the CAU console. This action performs several tests to verify that your environment meets the prerequisites and some of the recommended configurations for using CAU. For example, the cluster must have quorum, and all cluster nodes must be running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. The tests also detect common issues that can interfere with using CAU. After the tests complete, you can review the results and perform any necessary corrective actions.  
  
## Recommendations for using CAU to apply updates  
We recommend that when you begin to use CAU on a cluster, you stop using other methods for installing software updates on the cluster nodes.  
  
> [!CAUTION]  
> Combining CAU with methods that update individual nodes automatically \(on a fixed time schedule\) can cause unpredictable results, including interruptions in service and unplanned downtime.  
  
We recommend that you follow these guidelines:  
  
-   Do not configure the nodes themselves for automatic updating, for example, through the updating options in Control Panel.  
  
-   Do not configure an update system such as Windows Server Update Services \(WSUS\) to apply updates automatically \(on a fixed time schedule\) to cluster nodes.  
  
-   If you use a configuration management system to apply software updates to computers on the network, exclude cluster nodes from all required or automatic updates. Examples of configuration management systems include Microsoft System Center Configuration Manager and Microsoft System Center Virtual Machine Manager.  
  
-   If internal software distribution servers \(for example, WSUS servers\) are used to contain and deploy the updates, ensure that those servers correctly identify the approved updates for the cluster nodes.  
  
-   Review any preferred owner settings for clustered roles. Configure these settings so that when the software update process completes, the clustered roles will be distributed across the cluster nodes.  
  
    > [!NOTE]  
    > After an Updating Run, Cluster\-Aware Updating attempts to return clustered roles to the nodes that they were running on before the Updating Run began.  
  
## See also  
  
-   [Cluster\-Aware Updating Overview \[WS8overview\]](assetId:///a8e6dfbb-9d98-4130-86ac-9f6f00241e02)  
  
-   [Requirements and Best Practices for Cluster\-Aware Updating \[WS8\]](../Topic/Requirements-and-Best-Practices-for-Cluster-Aware-Updating.md)  
  
