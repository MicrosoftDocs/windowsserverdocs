---
title: DHCP Failover Relationships
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e4a3c03e-f18a-4e5c-9d99-508a2c739259
---
# DHCP Failover Relationships
See the following sections in this topic for more information about working with failover relationships.  
  
-   [Understand failover relationships](../Topic/DHCP-Failover-Relationships.md#servers_scopes)  
  
-   [Create failover relationships](../Topic/DHCP-Failover-Relationships.md#create)  
  
-   [View failover relationships](../Topic/DHCP-Failover-Relationships.md#view)  
  
-   [Edit failover relationships](../Topic/DHCP-Failover-Relationships.md#edit)  
  
-   [Delete failover relationships](../Topic/DHCP-Failover-Relationships.md#delete)  
  
## <a name="servers_scopes"></a>Understand failover relationships  
Failover relationships are settings used by two DHCP servers to share one or more failover\-enabled DHCP scopes.  
  
A single failover relationship can be associated to multiple DHCP scopes. You do not need to create a new failover relationship every time you enable failover on a DHCP scope, unless a new DHCP server will be used as the failover partner or a new set of failover settings are required. It is recommended to reuse existing failover relationships whenever possible to avoid unnecessary duplication of failover settings.  
  
Characteristics of failover relationships include the following.  
  
-   A single DHCP server can have no more than 31 failover relationships.  
  
-   A single failover relationship is always shared between exactly two DHCP servers.  
  
-   Multiple failover relationships can exist between the same two DHCP servers.  
  
-   Multiple DHCP scopes can use the same failover relationship.  
  
-   A single DHCP server can have failover relationships with multiple other DHCP servers.  
  
-   A single DHCP scope can only be associated to one failover relationship at a time. However, scopes can be removed from one failover relationship and added to a different failover relationship.  
  
-   A failover relationship can exist that is not associated to any DHCP scopes.  
  
-   Failover relationships can exist between two DHCP servers, a single DHCP server and clustered DHCP, or between two DHCP clusters.  
  
-   Deleting a failover relationship will remove failover from all scopes associated with that relationship.  
  
-   It is not necessary to pause, stop, or restart the DHCP Server service when adding, deleting, or modifying failover relationships.  
  
-   Failover relationships do not support IPv6 scopes.  
  
See the following example.  
  
![](../Image/DHCP_failover-relationships.gif)  
  
In this example, scopes A and C are configured on DHCP1 and DHCP2 to use a 50\-50 load balancing failover relationship named “DHCP1\-DHCP2.” Scope B is configured on DHCP2 and DHCP3 and is associated to the hot standby failover relationship “DHCP3\-DHCP2” wherein DHCP3 is the active server and DHCP2 is the standby server. Scope D on DHCP2 not currently configured for failover.  
  
Failover relationship 1 can be viewed and edited on DHCP1 or DHCP2. Likewise, failover relationship 2 can be viewed and edited on DHCP2 or DHCP3. The name of a failover relationship is established when it is created, and must be unique for both servers. You can type a custom name, or use the default name that is supplied.  
  
> [!IMPORTANT]  
> A single DHCP server can support up to 31 failover relationships. To avoid exceeding this limit, reuse existing failover relationships when possible and delete failover relationships that are not in use.  
>   
> Failover relationships can exist with no association to a DHCP scope. This occurs if you deconfigure failover on the last DHCP scope associated to a failover relationship, and do not also delete the failover relationship. You might do this if you plan to reuse the failover relationship later.  
  
## <a name="create"></a>Create failover relationships  
To create a failover relationship on a DHCP server, you can type **Add\-DhcpServerv4Failover** at an elevated Windows PowerShell prompt, or you can use the DHCP console. If you use the DHCP console, you can right\-click **IPv4**, or right\-click an IPv4 scope and then click **Configure Failover** to start the Configure Failover wizard.  
  
The following minimum information is required to create a new failover relationship:  
  
1.  A unique name for the failover relationship  
  
2.  A network\-connected partner DHCP server name or IP address  
  
3.  At least one scope ID for a DHCP scope that exists on the local server  
  
Additional parameters are optional. The default DHCP failover mode is load balance with 50% of leases being assigned by the local server and 50% being assigned by the partner server. Authentication is also enabled by default, but this setting is not required. If authentication is enabled, you must also supply a shared secret. The scope ID provided must correspond to a scope configured on the local server that is not already failover\-enabled, and does not already exist on the partner server. If DHCP failover is being configured remotely, the “local server” refers to the server specified on the command line or added to the management console.  
  
You cannot enable DHCP failover on a DHCP scope if the scope already exists on both DHCP servers in a failover relationship, as might occur in a split scope configuration. If a DHCP scope exists on the partner DHCP server it must be deleted prior to configuring DHCP failover. See the following examples:  
  
**Example 1**: Configure DHCP failover using Windows PowerShell.  
  
```  
PS C:\> Add-DhcpServerv4Failover –Name dc1-dhcp1 –ScopeID 192.168.10.0 –PartnerServer dhcp1.contoso.com  
```  
  
**Example 2**: Configure DHCP failover using the DHCP console.  
  
![](../Image/DHCP_failover-new1.gif)  
  
In the previous examples, a new failover relationship named **dc1\-dhcp1** is established between the local server and dhcp1.contoso.com to use a 50\-50 load balancing percentage for the DHCP scope with ID 192.168.10.0.  
  
For more information about additional settings used to configure failover relationships, see [Deploy DHCP Failover](../Topic/Deploy-DHCP-Failover.md).  
  
## <a name="view"></a>View failover relationships  
To view failover relationships on a DHCP server, you can type **Get\-DhcpServerv4Failover** at an elevated Windows PowerShell prompt, or you can open the DHCP console, right\-click **IPv4**, click **Properties**, and then click the **Failover** tab. See the following examples:  
  
**Example 1**: View DHCP failover using Windows PowerShell.  
  
```  
PS C:\> Get-DhcpServerv4Failover  
  
Name                : dc1.contoso.com-192.168.0.254  
PartnerServer       : 192.168.0.254  
Mode                : HotStandby  
LoadBalancePercent  :  
ServerRole          : Active  
ReservePercent      : 5  
MaxClientLeadTime   : 01:00:00  
StateSwitchInterval :  
State               : Normal  
ScopeId             : {192.168.50.0, 192.168.0.0}  
AutoStateTransition : False  
EnableAuth          : False  
  
Name                : dhcp1-dc1 load balance  
PartnerServer       : dhcp1.contoso.com  
Mode                : LoadBalance  
LoadBalancePercent  : 50  
ServerRole          :  
ReservePercent      :  
MaxClientLeadTime   : 01:00:00  
StateSwitchInterval :  
State               : Normal  
ScopeId             :  
AutoStateTransition : False  
EnableAuth          : False  
```  
  
**Example 2**: View DHCP failover using the DHCP console.  
  
![](../Image/DHCP_failover-tab.gif)  
  
An advantage to using Windows PowerShell to view failover relationships is that you can also view the DHCP scopes that are associated with each failover relationship. This information is provided next to the **ScopeId** parameter.  
  
## <a name="edit"></a>Edit failover relationships  
To edit failover relationships on a DHCP server, you can type **Set\-DhcpServerv4Failover** at an elevated Windows PowerShell prompt, or you can open the DHCP console, right\-click **IPv4**, click **Properties**, and then click the **Failover** tab. See the following examples:  
  
**Example 1**: Edit DHCP failover using Windows PowerShell.  
  
```  
PS C:\> Set-DhcpServerv4Failover –Name “dhcp1-dc1 load balance” –LoadBalancePercent 70  
```  
  
In the previous example, the load balancing percentage on the local server was changed to 70%.  
  
**Example 2**: To edit properties of the failover relationship using the DHCP console, choose a failover relationship and then click **Edit**.  
  
![](../Image/DHCP_failover-view-edit.gif)  
  
For more information about configuring DHCP failover relationships, see [Deploy DHCP Failover](../Topic/Deploy-DHCP-Failover.md).  
  
## <a name="delete"></a>Delete failover relationships  
To delete a failover relationship on a DHCP server, you can type **Remove\-DhcpServerv4Failover** at an elevated Windows PowerShell prompt, or you can use the DHCP console. You must supply the failover relationship name. See the following example:  
  
**Example 1**: Delete a DHCP failover relationship using Windows PowerShell.  
  
```  
PS C:\> Remove-DhcpServerv4Failover –Name dhcp1.contoso.com-dhcp2-dns1.contoso.com  
```  
  
To delete a failover relationship using the DHCP console, right\-click IPv4 and then click **Properties**. Highlight the relationship name on the **Failover** tab and then click **Delete**. You will be prompted to confirm the deletion, and if any scopes are currently associated with the failover relationship, these will be listed. See the following example:  
  
**Example 2**: Delete a DHCP failover relationship using the DHCP console.  
  
![](../Image/DHCP_failover-delete.gif)  
  
Click OK to confirm deletion of the failover relationship. Deleting a failover relationship that has DHCP scopes associated with it will remove those scopes from the partner DHCP server. The scopes will remain on the DHCP server where the failover relationship was deleted.  
  
> [!NOTE]  
> If you remove the last DHCP scope from a failover relationship \(by “deconfiguring” failover on the scope\) using the DHCP console, you will be notified that the failover relationship can be deleted. The failover relationship is not automatically removed. If you do not plan to reuse the relationship later, manually delete this relationship from either the primary DHCP server or the failover partner.  
  
## See also  
[DHCP Failover Modes](../Topic/DHCP-Failover-Modes.md)  
  
[DHCP Failover Communications](../Topic/DHCP-Failover-Communications.md)  
  
[DHCP Failover Settings](../Topic/DHCP-Failover-Settings.md)  
  
[Deploy DHCP Failover](../Topic/Deploy-DHCP-Failover.md)  
  
