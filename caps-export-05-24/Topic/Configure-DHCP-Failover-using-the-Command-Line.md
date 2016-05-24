---
title: Configure DHCP Failover using the Command Line
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3223c617-1306-4738-bce3-a7710547c1ba
---
# Configure DHCP Failover using the Command Line
Use the following procedures to configure DHCP failover using the command line. When you have completed the procedures in this topic, return to the parent checklist: [Checklist: Deploy DHCP Failover](../Topic/Checklist--Deploy-DHCP-Failover.md).  
  
Configuring DHCP failover with the command line uses Windows PowerShell. To configure DHCP failover using the Windows interface instead, see [Configure DHCP Failover using the DHCP Console](../Topic/Configure-DHCP-Failover-using-the-DHCP-Console.md).  
  
**Additional considerations:**  
  
-   When you configure DHCP failover, you can accept default values for several parameters, or you can specify custom values. For more information about DHCP failover settings, see [DHCP Failover Settings](../Topic/DHCP-Failover-Settings.md).  
  
-   DHCP failover can be configured on a single DHCP scope, or you can configure multiple scopes simultaneously if they will all use the same failover relationship. The procedures below describe how to specify a new failover relationship for use with a single DHCP scope. Multiple scopes can be configured using the command line by providing a comma\-delimited list of scope IDs after the **ScopeID** parameter.  
  
-   In the following procedures, the **Add\-DhcpServerv4Failover** cmdlet is used to create a new DHCP failover relationship. You can also add scopes to an existing DHCP failover relationship using the **Add\-DhcpServerv4FailoverScope** cmdlet. For more information about Windows PowerShell cmdlets for configuring and managing DHCP failover relationships, scopes, and server settings, see [DHCP Server Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/jj590751.aspx).  
  
To configure DHCP failover, you must choose load balance or hot standby mode:  
  
-   [Configure DHCP failover in load balance mode using the command line](../Topic/Configure-DHCP-Failover-using-the-Command-Line.md#cmd_line)  
  
-   [Configure DHCP failover in hot standby mode using the command line](../Topic/Configure-DHCP-Failover-using-the-Command-Line.md#hot_standby)  
  
## <a name="cmd_line"></a>Configure DHCP failover in load balance mode using the command line  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### <a name="load_balance_cmd"></a>To configure DHCP failover in load balance mode using the command line  
  
1.  On a computer with the Windows PowerShell DHCP Server module installed, right\-click **Windows PowerShell** and then click **Run as Administrator**.  
  
2.  Type the following at the command line, and then press ENTER. Replace the example values with values used in your environment.  
  
    ```  
    Add-DhcpServerv4Failover –ComputerName dhcp1.contoso.com –PartnerServer dhcp2.contoso.com –Name dhcp1-dhcp2 –ScopeID 10.10.10.0 –LoadBalancePercent 70 –SharedSecret sEcReT -Force  
    ```  
  
In this example, the primary DHCP server is named **dhcp1.contoso.com** and the secondary DHCP server is named **dhcp2.contoso.com**. DHCP failover is enabled in load balancing mode with 70% of leases allocated to the primary DHCP server. The failover relationship name is **dhcp1\-dhcp2**, the DHCP scope ID is **10.10.10.0**, and the shared secret is **sEcReT**. A shared secret is optional. If specified, message digest authentication is turned on for the newly created failover relationship.  
  
> [!TIP]  
> Windows PowerShell DHCP Server module can be installed using the Add Roles and Features Wizard under Features\\Remote Server Administration Tools\\Role Administration Tools\\DHCP Server Tools. The DHCP Server module is also installed by default when you install the DHCP Server role service.  
  
The following table provides a description of parameters used in this example.  
  
|Parameter|Description|  
|-------------|---------------|  
|ComputerName|The name of the primary DHCP server.|  
|PartnerServer|The name of the secondary DHCP server.|  
|Name|The name of the new DHCP failover relationship.|  
|ScopeID|The ID of the DHCP scope on the primary DHCP server to be configured for failover.|  
|LoadBalancePercent|The load balancing percentage assigned to the primary DHCP server.|  
|SharedSecret|The shared secret for the failover relationship.|  
  
## <a name="hot_standby"></a>Configure DHCP failover in hot standby mode using the command line  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### <a name="hot_standby1"></a>To configure DHCP failover in hot standby mode using the command line  
  
1.  On a computer with the Windows PowerShell DHCP Server module installed, right\-click **Windows PowerShell** and then click **Run as Administrator**.  
  
2.  Type the following at the command line, and then press ENTER. Replace the example values with values used in your environment.  
  
    ```  
    Add-DhcpServerv4Failover –ComputerName dhcp1.contoso.com –PartnerServer dhcp2.contoso.com –Name dhcp1-dhcp2 –ScopeID 10.10.10.0 –ServerRole Active -SharedSecret sEcReT -Force  
    ```  
  
In this example, the primary DHCP server is named **dhcp1.contoso.com** and the secondary DHCP server is named **dhcp2.contoso.com**. DHCP failover is enabled in hot standby mode with the primary DHCP server assigned as the active server. The failover relationship name is **dhcp1\-dhcp2**, the DHCP scope ID is **10.10.10.0**, and the shared secret is **sEcReT**. A shared secret is optional. If specified, message digest authentication is turned on for the newly created failover relationship.  
  
> [!TIP]  
> Windows PowerShell DHCP Server module can be installed using the Add Roles and Features Wizard under Features\\Remote Server Administration Tools\\Role Administration Tools\\DHCP Server Tools. The DHCP Server module is also installed by default when you install the DHCP Server role service.  
  
The following table provides a description of parameters used in this example.  
  
|Parameter|Description|  
|-------------|---------------|  
|ComputerName|The name of the primary DHCP server.|  
|PartnerServer|The name of the secondary DHCP server.|  
|Name|The name of the new DHCP failover relationship.|  
|ScopeID|The ID of the DHCP scope on the primary DHCP server to be configured for failover.|  
|ServerRole|Specifies the role of the target DHCP server in hot standby mode. Acceptable values are Active or Standby. The target computer is specified by the ComputerName parameter.|  
|SharedSecret|The shared secret for the failover relationship.|  
  
## See also  
[What is DHCP Failover?](../Topic/What-is-DHCP-Failover-.md)  
  
[Deploy DHCP Failover](../Topic/Deploy-DHCP-Failover.md)  
  
[Step-by-Step: Configure DHCP for Failover](../Topic/Step-by-Step--Configure-DHCP-for-Failover.md)  
  
