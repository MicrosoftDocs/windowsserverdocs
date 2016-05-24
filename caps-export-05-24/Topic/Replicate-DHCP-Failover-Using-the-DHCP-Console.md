---
title: Replicate DHCP Failover Using the DHCP Console
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fa2f5e96-d27d-4f40-b0ab-2ed312e12182
---
# Replicate DHCP Failover Using the DHCP Console
Use the following procedures to replicate DHCP settings using the DHCP console. When you have completed the procedures in this topic, return to the parent checklist: [Checklist: Deploy DHCP Failover](../Topic/Checklist--Deploy-DHCP-Failover.md).  
  
Replication is the process of copying settings from one or more failover\-enabled DHCP scopes to on a DHCP server to the server’s failover partner.  
  
> [!IMPORTANT]  
> Replication can be initiated from either DHCP server in a failover relationship. Settings on the failover partner server will be overwritten with the settings that are configured on the server where replication is initiated. Therefore, it is important to always ensure replication is initiated on the server that is configured with the settings you wish to use.  
  
This topic provides steps to replicate scope settings using the DHCP console. For steps to replicate scope settings using the command line, see [Replicate DHCP Failover Using the Command Line](../Topic/Replicate-DHCP-Failover-Using-the-Command-Line.md).  
  
Three types of replication are available:  
  
-   **Server replication**: This type of replication copies the configuration of all failover\-enabled scopes on the local server to its failover partner servers.  
  
-   **Relationship replication**: This type of replication copies the configuration of all DHCP scopes that are part of a selected failover relationship to the failover partner server.  
  
-   **Scope replication**: This type of replication copies the configuration of a selected DHCP scope to the failover partner server.  
  
Choose one of the following procedures based on the type of replication you wish to perform:  
  
-   [Replicate failover settings at the server level using the DHCP console](../Topic/Replicate-DHCP-Failover-Using-the-DHCP-Console.md#rep1)  
  
-   [Replicate failover settings at the relationship level using the DHCP console](../Topic/Replicate-DHCP-Failover-Using-the-DHCP-Console.md#rep2)  
  
-   [Replicate failover settings at the scope level using the DHCP console](../Topic/Replicate-DHCP-Failover-Using-the-DHCP-Console.md#rep3)  
  
## <a name="rep1"></a>Replicate failover settings at the server level using the DHCP console  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### <a name="rep1p"></a>To replicate failover settings at the server level using the DHCP console  
  
1.  On a DHCP server, open Server Manager, click **Tools** and then click **DHCP**.  
  
2.  In the DHCP console, right\-click **IPv4**, and then click **Replicate Failover Scopes**.  
  
3.  Click **OK** in the alert that appears.  
  
4.  In the **Failover Scope Configuration Replication** dialog box, verify that replication was successful, and then click **Close**.  
  
## <a name="rep2"></a>Replicate failover settings at the relationship level using the DHCP console  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### <a name="rep2p"></a>To replicate failover settings at the relationship level using the DHCP console  
  
1.  On a DHCP server, open Server Manager, click **Tools** and then click **DHCP**.  
  
2.  In the DHCP console, right\-click any failover\-enabled scope, and then click **Replicate Relationship**.  
  
3.  Click **OK** in the alert that appears.  
  
4.  In the **Failover Scope Configuration Replication** dialog box, verify that replication was successful, and then click **Close**.  
  
## <a name="rep3"></a>Replicate failover settings at the scope level using the DHCP console  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### <a name="rep3p"></a>To replicate failover settings at the scope level using the DHCP console  
  
1.  On a DHCP server, open Server Manager, click **Tools** and then click **DHCP**.  
  
2.  In the DHCP console, right\-click any failover\-enabled scope, and then click **Replicate Scope**.  
  
3.  In the **Failover Scope Configuration Replication** dialog box, verify that replication was successful, and then click **Close**.  
  
## See also  
[What is DHCP Failover?](../Topic/What-is-DHCP-Failover-.md)  
  
[Deploy DHCP Failover](../Topic/Deploy-DHCP-Failover.md)  
  
[Step-by-Step: Configure DHCP for Failover](../Topic/Step-by-Step--Configure-DHCP-for-Failover.md)  
  
