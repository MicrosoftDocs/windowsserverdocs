---
title: Replicate DHCP Failover Using the Command Line
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7d195c99-4229-48c4-9024-833f1192608c
---
# Replicate DHCP Failover Using the Command Line
Use the following procedures to replicate DHCP settings using Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist: [Checklist: Deploy DHCP Failover](../Topic/Checklist--Deploy-DHCP-Failover.md).  
  
Replication is the process of copying settings from one or more failover\-enabled DHCP scopes to on a DHCP server to the server’s failover partner.  
  
> [!IMPORTANT]  
> Replication can be initiated from either DHCP server in a failover relationship. Settings on the failover partner server will be overwritten with the settings that are configured on the server where replication is initiated. Therefore, it is important to always ensure replication is initiated on the server that is configured with the settings you wish to use.  
  
This topic provides steps to replicate scope settings using the command line. For steps to replicate scope settings using the DHCP console, see [Replicate DHCP Failover Using the DHCP Console](../Topic/Replicate-DHCP-Failover-Using-the-DHCP-Console.md).  
  
Three types of replication are available:  
  
-   **Server replication**: This type of replication copies the configuration of all failover\-enabled scopes on the local server to its failover partner servers.  
  
-   **Relationship replication**: This type of replication copies the configuration of all DHCP scopes that are part of a selected failover relationship to the failover partner server.  
  
-   **Scope replication**: This type of replication copies the configuration of a selected DHCP scope to the failover partner server.  
  
Choose one of the following procedures based on the type of replication you wish to perform:  
  
-   [Replicate failover settings at the server level using the command line](../Topic/Replicate-DHCP-Failover-Using-the-Command-Line.md#rep1)  
  
-   [Replicate failover settings at the relationship level using the command line](../Topic/Replicate-DHCP-Failover-Using-the-Command-Line.md#rep2)  
  
-   [Replicate failover settings at the scope level using the command line](../Topic/Replicate-DHCP-Failover-Using-the-Command-Line.md#rep3)  
  
## <a name="rep1"></a>Replicate failover settings at the server level using the command line  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### <a name="rep1p"></a>To replicate failover settings at the server level using the command line  
  
1.  On a computer with the Windows PowerShell DHCP Server module installed, right\-click **Windows PowerShell** and then click **Run as Administrator**.  
  
2.  Type the following at the command line, and then press ENTER. Replace the example values with values used in your environment.  
  
    ```  
    Invoke-DhcpServerv4FailoverReplication –ComputerName dhcp1.contoso.com -Force  
    ```  
  
3.  Verify that the scope IDs are listed in the command output for all failover enabled scopes on the DHCP server.  
  
In this example, the primary DHCP server is named **dhcp1.contoso.com**. If the **ComputerName** parameter is not specified, the command is run on the local server.  
  
> [!TIP]  
> Windows PowerShell DHCP Server module can be installed using the Add Roles and Features Wizard under Features\\Remote Server Administration Tools\\Role Administration Tools\\DHCP Server Tools. The DHCP Server module is also installed by default when you install the DHCP Server role service.  
  
## <a name="rep2"></a>Replicate failover settings at the relationship level using the command line  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### <a name="rep2p"></a>To replicate failover settings at the relationship level using the command line  
  
1.  On a computer with the Windows PowerShell DHCP Server module installed, right\-click **Windows PowerShell** and then click **Run as Administrator**.  
  
2.  Type the following at the command line, and then press ENTER. Replace the example values with values used in your environment.  
  
    ```  
    Invoke-DhcpServerv4FailoverReplication –ComputerName dhcp1.contoso.com –Name dhcp1-dhcp2 -Force  
    ```  
  
3.  Verify that the scope IDs are listed in the command output for all failover enabled scopes that are configured to use the specified failover relationship.  
  
In this example, the primary DHCP server is named **dhcp1.contoso.com** and the failover relationship name is **dhcp1\-dhcp2**. If the **ComputerName** parameter is not specified, the command is run on the local server.  
  
> [!TIP]  
> Windows PowerShell DHCP Server module can be installed using the Add Roles and Features Wizard under Features\\Remote Server Administration Tools\\Role Administration Tools\\DHCP Server Tools. The DHCP Server module is also installed by default when you install the DHCP Server role service.  
  
## <a name="rep3"></a>Replicate failover settings at the scope level using the command line  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### <a name="rep3p"></a>To replicate failover settings at the scope level using the command line  
  
1.  On a computer with the Windows PowerShell DHCP Server module installed, right\-click **Windows PowerShell** and then click **Run as Administrator**.  
  
2.  Type the following at the command line, and then press ENTER. Replace the example values with values used in your environment.  
  
    ```  
    Invoke-DhcpServerv4FailoverReplication –ComputerName dhcp1.contoso.com –ScopeID 10.0.10.0,10.0.20.0 -Force  
    ```  
  
3.  Verify that the scope IDs are listed in the command output for all scopes that were specified on the command line.  
  
In this example, the primary DHCP server is named **dhcp1.contoso.com**, and the DHCP scope IDs specified are **10.0.10.0** and **10.0.20.0**. If the **ComputerName** parameter is not specified, the command is run on the local server.  
  
> [!TIP]  
> Windows PowerShell DHCP Server module can be installed using the Add Roles and Features Wizard under Features\\Remote Server Administration Tools\\Role Administration Tools\\DHCP Server Tools. The DHCP Server module is also installed by default when you install the DHCP Server role service.  
  
## See also  
[What is DHCP Failover?](../Topic/What-is-DHCP-Failover-.md)  
  
[Deploy DHCP Failover](../Topic/Deploy-DHCP-Failover.md)  
  
[Step-by-Step: Configure DHCP for Failover](../Topic/Step-by-Step--Configure-DHCP-for-Failover.md)  
  
