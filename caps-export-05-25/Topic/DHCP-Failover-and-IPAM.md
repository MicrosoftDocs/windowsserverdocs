---
title: DHCP Failover and IPAM
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 62722502-7fe3-4283-bf88-de26e88afc48
---
# DHCP Failover and IPAM
See the following topics for information about IPAM integration with DHCP Failover in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and later.  
  
-   [What is DHCP failover?](../Topic/DHCP-Failover-and-IPAM.md#whatis_failover)  
  
-   [Managing DHCP failover with IPAM](../Topic/DHCP-Failover-and-IPAM.md#ipam_failover)  
  
-   [Failover replication example](../Topic/DHCP-Failover-and-IPAM.md#replication_example)  
  
## <a name="whatis_failover"></a>What is DHCP failover?  
DHCP failover is a new feature available with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] that enables redundancy and load balancing between two Microsoft DHCP servers. When you enable DHCP failover on a DHCP scope, the scope with its associated settings, leases, and reservations is replicated to a partner DHCP server. DHCP clients must be able to contact both DHCP servers in order for DHCP failover to work properly.  
  
For detailed information about DHCP failover and steps to deploy it, see [Understand and Deploy DHCP Failover](../Topic/Understand-and-Deploy-DHCP-Failover.md).  
  
## <a name="ipam_failover"></a>Managing DHCP failover with IPAM  
DHCP failover is fully integrated with IPAM in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Failover\-enabled DHCP scopes are also compatible with IPAM in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], but these scopes appear as duplicates and no failover relationship data is available in the IPAM console. You cannot display or modify DHCP failover related settings using IPAM in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
On an IPAM server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], the following enhancements are available for managed DHCP servers that are configured with DHCP failover\-enabled scopes:  
  
1.  Changes made to failover\-enabled scopes using the IPAM console are automatically replicated to the failover partner. This is a significant difference in the way that DHCP failover works compared to when you configure settings using the DHCP console or Windows PowerShell. For a step\-by\-step example of DHCP failover replication with and without using the IPAM console, see [Replication example](../Topic/DHCP-Failover-and-IPAM.md#replication_example).  
  
2.  A **Failover Relationships** view is available when the **Server Type** selected is **DHCP**.  
  
    -   DHCP failover relationships can be edited, deleted, and replicated using the **Failover Relationships** view.  
  
    -   The **Failover Relationships** view displays the DHCP failover **Relationship Name**, **Mode**, **Primary Server**, **Secondary Server**, **Primary Server Status**, and **Secondary Server Status**. The  
  
    -   The DHCP failover relationship can be set to **Partner Down** state using the **Failover Relationships** view.  
  
3.  The **Scope Properties** view enables several DHCP failover related actions.  
  
    -   DHCP scopes can be added to existing DHCP failover relationships or new DHCP failover relationships can be created using the **Scope Properties** view.  
  
    -   The **Failover Config Sync Status** and **Failover Relationship Name** are displayed in the **Scope Properties** view.  
  
        **Note**: The **Failover Config Sync Status** column will be blank if no problems occurred during an IPAM automatic failover replication process. Otherwise, an error is displayed.  
  
    -   If replication is run outside of IPAM to resolve a failover configuration synchronization error, you can manually clear the error in IPAM by right\-clicking the scope in **Scope Properties** view and clicking **Clear Config Sync Error**.  
  
4.  If changes are made to failover\-enabled scopes using the DHCP console or Windows PowerShell, you can still replicate these changes from one DHCP server to its failover partner using IPAM. Because these changes are not made using the IPAM console, they are not automatically detected and replicated.  
  
    -   Server\-level replication is available using the **Server Properties** view.  
  
    -   Relationship\-level replication is available using the **Failover Relationships** view.  
  
    -   Scope\-level replication is available using the **Scope Properties** view.  
  
5.  DHCP failover can be configured or removed from a scope by right\-clicking the scope in **DHCP Scopes** view. Removing the DHCP failover configuration from a scope does not delete the DHCP failover relationship. When configuring DHCP failover on a scope, you can add the scope to an existing failover relationship on that DHCP server, or you can choose to create a new DHCP failover relationship.  
  
## <a name="replication_example"></a>Failover replication example  
The following example demonstrates how replication works when changes are made to failover\-enabled DHCP scopes. A DHCP reservation is used as an example of a change that is made to a failover\-enabled DHCP scope. Other types of changes to failover\-enabled scopes have the same behavior. The change is made first using Windows PowerShell, which requires manual replication. The change is then removed and repeated using the IPAM console to demonstrate automatic replication.  
  
The example uses the following Windows PowerShell cmdlets to add a DHCP reservation and then replicate this reservation:  
  
-   **Get\-DhcpServerv4Failover**: Failover relationships are displayed on the server dhcp1.contoso.com.  
  
-   **Add\-DhcpServerv4Reseration**: A DHCP reservation is added to the local server, dhcp1.contoso.com.  
  
-   **Get\-DhcpServerv4Reseration**: DHCP reservations are displayed on dhcp1.contoso.com. One reservation is new and one reservation previously existed on both the local DHCP server and its failover partner server, dc1.contoso.com.  
  
-   **Get\-DhcpServerv4Reseration**: DHCP reservations are displayed on the partner server, dc1.contoso.com. Only the previously existing reservation exists on dc1.contoso.com. Replication is required to add the new reservation that was created on dhcp1.contoso.com.  
  
-   **Invoke\-DhcpServerv4FailoverReplication**: Scope level replication is run on dhcp1.contoso.com.  
  
-   **Get\-DhcpServerv4Reseration**: DHCP reservations are displayed again on dc1.contos.com, which is now configured with the new reservation.  
  
```  
PS C:\> Get-DhcpServerv4Failover  
  
Name                : dhcp1.contoso.com-dc1.contoso.com  
PartnerServer       : dc1.contoso.com  
Mode                : LoadBalance  
LoadBalancePercent  : 50  
ServerRole          :  
ReservePercent      :  
MaxClientLeadTime   : 01:00:00  
StateSwitchInterval :  
State               : Normal  
ScopeId             : 10.0.0.0  
AutoStateTransition : False  
EnableAuth          : False  
  
PS C:\> Add-DhcpServerv4Reservation -ScopeId 10.0.0.0 -IPAddress 10.0.0.100 -ClientId 00155DA76602  
PS C:\> Get-DhcpServerv4Reservation -ScopeId 10.0.0.0 -ComputerName dhcp1.contoso.com  
  
IPAddress            ScopeId              ClientId             Name                 Type                 Description  
---------            -------              --------             ----                 ----                 -----------  
10.0.0.99            10.0.0.0             aa-bb-cc-dd-ee-ff    test                 Both                 A1  
10.0.0.100           10.0.0.0             00-15-5d-a7-66-02                         Both  
  
PS C:\> Get-DhcpServerv4Reservation -ScopeId 10.0.0.0 -ComputerName dc1.contoso.com  
  
IPAddress            ScopeId              ClientId             Name                 Type                 Description  
---------            -------              --------             ----                 ----                 -----------  
10.0.0.99            10.0.0.0             aa-bb-cc-dd-ee-ff    test                 Both                 A1  
  
PS C:\> Invoke-DhcpServerv4FailoverReplication -ComputerName dhcp1.contoso.com -ScopeId 10.0.0.0 -Force  
10.0.0.0  
PS C:\> Get-DhcpServerv4Reservation -ScopeId 10.0.0.0 -ComputerName dc1.contoso.com  
  
IPAddress            ScopeId              ClientId             Name                 Type                 Description  
---------            -------              --------             ----                 ----                 -----------  
10.0.0.99            10.0.0.0             aa-bb-cc-dd-ee-ff    test                 Both                 A1  
10.0.0.100           10.0.0.0             00-15-5d-a7-66-02                         Both  
```  
  
See [Replicate DHCP Failover Using the DHCP Console](../Topic/Replicate-DHCP-Failover-Using-the-DHCP-Console.md) and [Replicate DHCP Failover Using the Command Line](../Topic/Replicate-DHCP-Failover-Using-the-Command-Line.md) for more information about replicating DHCP failover\-enabled scopes when you are not using IPAM.  
  
If you perform the same procedure to add a reservation using the IPAM console, replication is automatic. IPAM detects that a change was made to a failover\-enabled scope and DHCP settings are automatically synchronized with the DHCP failover partner.  
  
In the following example, the new reservation for 10.0.0.100 used in the previous example is deleted from both DHCP servers. The actual deletion of the reservation is not shown. The DHCP reservation will be added again in this example using the IPAM console. Deletion of the reservation is confirmed with Windows PowerShell, which shows that only the reservation for IP address 10.0.0.99 is currently configured on both DHCP servers:  
  
```  
PS C:\> Get-DhcpServerv4Reservation -ScopeId 10.0.0.0 -ComputerName dhcp1.contoso.com  
  
IPAddress            ScopeId              ClientId             Name                 Type                 Description  
---------            -------              --------             ----                 ----                 -----------  
10.0.0.99            10.0.0.0             aa-bb-cc-dd-ee-ff    test                 Both                 A1  
  
PS C:\> Get-DhcpServerv4Reservation -ScopeId 10.0.0.0 -ComputerName dc1.contoso.com  
  
IPAddress            ScopeId              ClientId             Name                 Type                 Description  
---------            -------              --------             ----                 ----                 -----------  
10.0.0.99            10.0.0.0             aa-bb-cc-dd-ee-ff    test                 Both                 A1  
```  
  
You can also view reservation using the **DHCP Scopes** node in IPAM and the **Reservations** view.  
  
Using the **DNS and DHCP Servers** node in IPAM with Server Type \= **DHCP** and View \= **Scope Properties**, the failover enabled scope is displayed on both dhcp1.contoso.com and dc1.contoso.com. To add a new DHCP reservation, right\-click either DHCP server \(in this case dhcp1.contoso.com is clicked\) and then click **Create DHCP Reservation**. See the following example.  
  
![](../Image/IPAM_res1.jpg)  
  
In the **Create DHCP Reservation** dialog box, the **IP address** and **Client ID** are entered:  
  
![](../Image/IPAM_res2.jpg)  
  
After clicking **OK**, the reservation is immediately replicated and appears on both DHCP servers:  
  
```  
PS C:\> Get-DhcpServerv4Reservation -ScopeId 10.0.0.0 -ComputerName dhcp1.contoso.com  
  
IPAddress            ScopeId              ClientId             Name                 Type                 Description  
---------            -------              --------             ----                 ----                 -----------  
10.0.0.99            10.0.0.0             aa-bb-cc-dd-ee-ff    test                 Both                 A1  
10.0.0.100           10.0.0.0             00-15-5d-a7-66-02                         Both  
  
PS C:\> Get-DhcpServerv4Reservation -ScopeId 10.0.0.0 -ComputerName dc1.contoso.com  
  
IPAddress            ScopeId              ClientId             Name                 Type                 Description  
---------            -------              --------             ----                 ----                 -----------  
10.0.0.99            10.0.0.0             aa-bb-cc-dd-ee-ff    test                 Both                 A1  
10.0.0.100           10.0.0.0             00-15-5d-a7-66-02                         Both  
```  
  
When scope settings are modified using the IPAM console, it is not necessary to replicate these settings using Windows PowerShell, the DHCP console, or the IPAM console. IPAM determines that the scope is enabled for DHCP failover and automatically replicates all changes to the scope on the DHCP failover partner server. This demonstrates an extremely useful feature of IPAM when used with DHCP failover\-enabled scopes.  
  
## See also  
[Multi-server Management](../Topic/Multi-server-Management.md)  
  
