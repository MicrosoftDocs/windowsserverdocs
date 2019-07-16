---
title: BGP Windows PowerShell Command Reference
description: You can use this topic as a reference, when writing Windows PowerShell scripts in Windows Server 2016, to add, configure, and remove BGP capabilities from RAS Gateway and Remote Access Local Area Network (LAN) routers.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4b0240a3-b927-4a1e-b241-5f8f29a9552f
ms.author: pashort
author: shortpatti
---
# BGP Windows PowerShell Command Reference

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic as a reference, when writing Windows PowerShell scripts, to add, configure, and remove BGP capabilities from RAS Gateway and Remote Access Local Area Network (LAN) routers.  
  
These BGP commands are part of the Remote Access Windows PowerShell command set for  Windows Server 2016. This topic helps you quickly locate the BGP commands that you want to use in scripts.  
  
For more information on all Remote Access commands, see [Remote Access Cmdlets](https://technet.microsoft.com/library/hh918399.aspx).  
  
## BGP Command Reference  
The following sections provide command name, purpose, and syntax for each BGP command, as well as a link to the command in the Remote Access reference, which contains more detailed information about each command.  
  
This reference contains the following sections.  
  
-   [Add commands](#bkmk_add)  
  
-   [Clear commands](#bkmk_clear)  
  
-   [Disable and Enable commands](#bkmk_disable)  
  
-   [Get commands](#bkmk_get)  
  
-   [Install commands](#bkmk_install)  
  
-   [Remove commands](#bkmk_remove)  
  
-   [Set commands](#bkmk_set)  
  
-   [Start and Stop commands](#bkmk_start)  
  
-   [Uninstall commands](#bkmk_uninstall)  
  
### <a name="bkmk_add"></a>Add commands  
Following are the BGP Add commands.  
  
[Add-BgpCustomRoute](https://technet.microsoft.com/library/dn262684.aspx)  
  
Adds custom routes to the BGP routing table.  
  
```  
Add-BgpCustomRoute [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-Interface <String[]> ] [-Network <String[]> ] [-PassThru] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Add-BgpPeer](https://technet.microsoft.com/library/dn262687.aspx)  
  
Adds a new BGP peer.  
  
```  
Add-BgpPeer [-Name] <String> -LocalIPAddress <IPAddress> -PeerASN <UInt32> -PeerIPAddress <IPAddress> [-CimSession <CimSession[]> ] [-HoldTimeSec <UInt16> ] [-IdleHoldTimeSec <UInt16> ] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-LocalASN <UInt32> ] [-MaxAllowedPrefix <UInt32> ] [-OperationMode <OperationMode> {Mixed | Server} ] [-PassThru] [-PeeringMode <PeeringMode> {Automatic | Manual} ] [-RouteReflectorClient <Boolean> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Weight <UInt16> ] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Add-BgpRouteAggregate](https://technet.microsoft.com/library/mt463113.aspx)  
  
Adds a new aggregate route for specific BGP routes.  
  
```  
Add-BgpRouteAggregate -Prefix <String> [-AttributePolicy <String[]> ] [-CimSession <CimSession[]> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-PassThru] [-PreserveASPath <PreserveASPath> ] [-RoutingDomain <String> ] [-SummaryOnly <SummaryOnly> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Add-BgpRouter](https://technet.microsoft.com/library/dn262665.aspx)  
  
Adds a BGP router for the specified Tenant ID.  
  
```  
Add-BgpRouter -BgpIdentifier <IPAddress> -LocalASN <UInt32> [-CimSession <CimSession[]> ] [-ClientToClientReflection <ClientToClientReflection> ] [-ClusterId <UInt32> ] [-CompareMEDAcrossASN <Boolean> ] [-DefaultGatewayRouting <Boolean> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-IPv6Routing <IPv6RoutingState> {Disabled | Enabled} ] [-LocalIPv6Address <IPAddress> ] [-PassThru] [-RouteReflector <RouteReflector> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-TransitRouting <TransitRouting> ] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Add-BgpRoutingPolicy](https://technet.microsoft.com/library/dn262662.aspx)  
  
Adds a BGP routing policy to the policy store.  
  
```  
Add-BgpRoutingPolicy [-Name] <String> [-PolicyType] <PolicyType> {Deny | Allow | ModifyAttribute} [-AddCommunity <String[]> ] [-CimSession <CimSession[]> ] [-ClearMED] [-Force] [-IgnorePrefix <String[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-MatchASNRange <UInt32[]> ] [-MatchCommunity <String[]> ] [-MatchNextHop <IPAddress[]> ] [-MatchPrefix <String[]> ] [-NewLocalPref <UInt32]> ] [-NewMED <UInt32]> ] [-NewNextHop <IPAddress> ] [-PassThru] [-RemoveAllCommunities] [-RemoveCommunity <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Add-BgpRoutingPolicyForPeer](https://technet.microsoft.com/library/dn262680.aspx)  
  
Adds BGP routing policies to BGP peers.  
  
```  
Add-BgpRoutingPolicyForPeer -Direction <PolicyDirection> {Ingress | Egress} -PolicyName <String[]> [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-PeerName <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
### <a name="bkmk_clear"></a>Clear commands  
Following are the Clear commands for BGP  
  
[Clear-BgpRouteFlapDampening](https://technet.microsoft.com/library/mt463114.aspx)  
  
Clears the route flap dampening information for the specified set of BGP routes.  
  
```  
Clear-BgpRouteFlapDampening [-CimSession <CimSession[]> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-Prefix <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
### <a name="bkmk_disable"></a>Disable and Enable commands  
Following are the Disable and Enable commands for BGP  
  
[Disable-BgpRouteFlapDampening](https://technet.microsoft.com/library/mt463100.aspx)  
  
Disables route dampening for the flapping BGP routes.  
  
```  
Disable-BgpRouteFlapDampening [-CimSession <CimSession[]> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Enable-BgpRouteFlapDampening](https://technet.microsoft.com/library/mt463102.aspx)  
  
Enables route dampening for the flapping BGP routes.  
  
```  
Enable-BgpRouteFlapDampening [-CimSession <CimSession[]> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-PassThru] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
### <a name="bkmk_get"></a>Get commands  
Following are the Get commands for BGP.  
  
[Get-BgpCustomRoute](https://technet.microsoft.com/library/dn262664.aspx)  
  
Gets custom route information from the BGP router.  
  
```  
Get-BgpCustomRoute [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Get-BgpPeer](https://technet.microsoft.com/library/dn262659.aspx)  
  
Gets configuration information for BGP peers.  
  
```  
Get-BgpPeer [[-Name] <String[]> ] [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Get-BgpRouteAggregate](https://technet.microsoft.com/library/mt463103.aspx)  
  
Gets all the aggregate BGP routes configured by the administrator.  
  
```  
Get-BgpRouteAggregate [-CimSession <CimSession[]> ] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-Prefix <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Get-BgpRouteFlapDampening](https://technet.microsoft.com/library/mt463108.aspx)  
  
Retrieves the configuration of a BGP route dampening engine.  
  
```  
Get-BgpRouteFlapDampening [-CimSession <CimSession[]> ] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Get-BgpRouteInformation](https://technet.microsoft.com/library/dn262667.aspx)  
  
Retrieves BGP route information for one or more network prefixes from the BGP routing table.  
  
```  
Get-BgpRouteInformation [-CimSession <CimSession[]> ] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-Network <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Type <RouteType> ] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Get-BgpRouter](https://technet.microsoft.com/library/dn262660.aspx)  
  
Gets configuration information for BGP routers.  
  
```  
Get-BgpRouter [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String[]> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Get-BgpRoutingPolicy](https://technet.microsoft.com/library/dn262672.aspx)  
  
Gets configuration information of BGP routing policies.  
  
```  
Get-BgpRoutingPolicy [[-Name] <String[]> ] [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-PolicyType <PolicyType> {Deny | Allow | ModifyAttribute} ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Get-BgpStatistics](https://technet.microsoft.com/library/dn262685.aspx)  
  
Retrieves BGP peering-related message and route advertisement statistics.  
  
```  
Get-BgpStatistics [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-PeerName <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
### <a name="bkmk_install"></a>Install commands  
Following are the Install commands for RAS Gateway and BGP.  
  
[Install-RemoteAccess](https://technet.microsoft.com/library/hh918408.aspx)  
  
Performs prerequisite checks for DirectAccess (DA) to ensure that it can be installed, installs DA for remote access (RA) (includes management of remote clients) or for management of remote clients only, installs VPN (both Remote Access VPN and site-to-site VPN), and installs BGP Routing.  
  
```  
Parameter Set: MultiTenant  
Install-RemoteAccess [-MultiTenancy] [-CapacityKbps <UInt64> ] [-CimSession <CimSession[]> ] [-ComputerName <String> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-MsgAuthenticator <String> {Enabled | Disabled} ] [-PassThru] [-RadiusPort <UInt16> ] [-RadiusScore <Byte> ] [-RadiusServer <String> ] [-RadiusTimeout <UInt32> ] [-SharedSecret <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
  
Parameter Set: Vpn  
Install-RemoteAccess [-VpnType] <String> {Vpn | VpnS2S | SstpProxy | RoutingOnly} [-CimSession <CimSession[]> ] [-ComputerName <String> ] [-EntrypointName <String> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-IPAddressRange <String[]> ] [-IPv6Prefix <String> ] [-Legacy] [-MsgAuthenticator <String> {Enabled | Disabled} ] [-PassThru] [-RadiusPort <UInt16> ] [-RadiusScore <Byte> ] [-RadiusServer <String> ] [-RadiusTimeout <UInt32> ] [-SharedSecret <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
> [!IMPORTANT]  
> When you install RAS Gateway in Multitenant mode, you must specify whether BGP is enabled for each tenant by using the **Enable-RemoteAccessRoutingDomain** Windows PowerShell command with the **-Type** parameter value of **All**. The following example code illustrates how to install RAS in Multitenancy mode with all RAS features (point-to-site VPN, site-to-site VPN, and BGP routing) enabled for two tenants, Contoso and Fabrikam.  
  
```  
$Contoso_RoutingDomain = "ContosoTenant"  
$Fabrikam_RoutingDomain = "FabrikamTenant"  
  
Install-RemoteAccess -MultiTenancy  
  
Enable-RemoteAccessRoutingDomain -Name $Contoso_RoutingDomain -Type All -PassThru  
Enable-RemoteAccessRoutingDomain -Name $Fabrikam_RoutingDomain -Type All -PassThru  
```  
  
If you are using Remote Access as a LAN router instead of as a gateway, you can still use BGP, which provides the advantage of having dynamic routing on your intranet. To install Remote Access as a BGP LAN router, type the following command in a Windows PowerShell prompt, and then press ENTER.  
  
```  
Install-RemoteAccess -VpnType RoutingOnly  
```  
  
### <a name="bkmk_remove"></a>Remove commands  
Following are the Remove commands for BGP.  
  
[Remove-BgpCustomRoute](https://technet.microsoft.com/library/dn262669.aspx)  
  
Removes custom routes from the BGP router.  
  
```  
Remove-BgpCustomRoute [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-Interface <String[]> ] [-Network <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Remove-BgpPeer](https://technet.microsoft.com/library/dn262675.aspx)  
  
Removes BGP peers from a router.  
  
```  
Remove-BgpPeer [-Name] <String[]> [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Remove-BgpRouteAggregate](https://technet.microsoft.com/library/mt463110.aspx)  
  
Removes the set of specified aggregate BGP routes.  
  
```  
Remove-BgpRouteAggregate [-CimSession <CimSession[]> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-Prefix <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Remove-BgpRouter](https://technet.microsoft.com/library/dn262678.aspx)  
  
Removes a BGP router.  
  
```  
Remove-BgpRouter [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String[]> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Remove-BgpRoutingPolicy](https://technet.microsoft.com/library/dn262656.aspx)  
  
Removes routing policies from the policy store.  
  
```  
Remove-BgpRoutingPolicy [-Name] <String[]> [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Remove-BgpRoutingPolicyForPeer](https://technet.microsoft.com/library/dn262681.aspx)  
  
Removes routing policies from BGP peers.  
  
```  
Parameter Set: Remove1  
Remove-BgpRoutingPolicyForPeer [-CimSession <CimSession[]> ] [-Direction <PolicyDirection> {Ingress | Egress} ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-PeerName <String[]> ] [-PolicyName <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
### <a name="bkmk_set"></a>Set commands  
Following are the Set commands for BGP.  
  
[Set-BgpPeer](https://technet.microsoft.com/library/dn262673.aspx)  
  
Updates the configuration of the specified BGP peer.  
  
```  
Set-BgpPeer [-Name] <String> [-CimSession <CimSession[]> ] [-ClearPrefixLimit] [-Force] [-HoldTimeSec <UInt16> ] [-IdleHoldTimeSec <UInt16> ] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-LocalASN <UInt32> ] [-LocalIPAddress <IPAddress> ] [-MaxAllowedPrefix <UInt32> ] [-OperationMode <OperationMode> {Mixed | Server} ] [-PassThru] [-PeerASN <UInt32> ] [-PeeringMode <PeeringMode> {Automatic | Manual} ] [-PeerIPAddress <IPAddress> ] [-RouteReflectorClient <Boolean> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Weight <UInt16> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Set-BgpRouteAggregate](https://technet.microsoft.com/library/mt463115.aspx)  
  
Updates the properties of specified aggregate BGP route.  
  
```  
Set-BgpRouteAggregate -Prefix <String> [-AttributePolicy <String[]> ] [-CimSession <CimSession[]> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-PassThru] [-PreserveASPath <PreserveASPath> ] [-RoutingDomain <String> ] [-SummaryOnly <SummaryOnly> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Set-BgpRouteFlapDampening](https://technet.microsoft.com/library/mt463116.aspx)  
  
Configures the BGP route dampening engine.  
  
```  
Set-BgpRouteFlapDampening [-CimSession <CimSession[]> ] [-Force] [-HalfLife <UInt32> ] [-HalfLifeUnreachable <UInt32> ] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-MaxSuppressTime <UInt32> ] [-PassThru] [-ReuseThreshold <UInt32> ] [-RoutingDomain <String> ] [-SuppressThreshold <UInt32> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Set-BgpRouter](https://technet.microsoft.com/library/dn262652.aspx)  
  
Updates the configuration of the local BGP router for the specified tenant ID.  
  
```  
Set-BgpRouter [-BgpIdentifier <IPAddress> ] [-CimSession <CimSession[]> ] [-ClientToClientReflection <ClientToClientReflection> ] [-ClusterId <UInt32> ] [-CompareMEDAcrossASN <Boolean> ] [-DefaultGatewayRouting <Boolean> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-IPv6Routing <IPv6RoutingState> {Disabled | Enabled} ] [-LocalASN <UInt32> ] [-LocalIPv6Address <IPAddress> ] [-PassThru] [-RouteReflector <RouteReflector> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-TransitRouting <TransitRouting> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Set-BgpRoutingPolicy](https://technet.microsoft.com/library/dn262670.aspx)  
  
Modifies a routing policy configuration.  
  
```  
Set-BgpRoutingPolicy [-Name] <String> [-AddCommunity <String[]> ] [-CimSession <CimSession[]> ] [-ClearMED] [-Force] [-IgnorePrefix <String[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-MatchASNRange <UInt32[]> ] [-MatchCommunity <String[]> ] [-MatchNextHop <IPAddress[]> ] [-MatchPrefix <String[]> ] [-NewLocalPref <UInt32]> ] [-NewMED <UInt32]> ] [-NewNextHop <IPAddress> ] [-PassThru] [-PolicyType <PolicyType> {Deny | Allow | ModifyAttribute} ] [-RemoveAllCommunities] [-RemoveCommunity <String[]> ] [-RemovePolicyClause <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Set-BgpRoutingPolicyForPeer](https://technet.microsoft.com/library/dn262674.aspx)  
  
Modifies BGP routing policies for BGP peers.  
  
```  
Set-BgpRoutingPolicyForPeer -Direction <PolicyDirection> {Ingress | Egress} -PolicyName <String[]> [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-PeerName <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
### <a name="bkmk_start"></a>Start and Stop commands  
Following are the Start and Stop  commands for BGP.  
  
[Start-BgpPeer](https://technet.microsoft.com/library/dn262683.aspx)  
  
Starts routing sessions for BGP peers.  
  
```  
Start-BgpPeer [-Name] <String[]> [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
[Stop-BgpPeer](https://technet.microsoft.com/library/dn262661.aspx)  
  
Stops routing sessions for BGP peers.  
  
```  
Stop-BgpPeer [-Name] <String[]> [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  
### <a name="bkmk_uninstall"></a>Uninstall commands  
Following are the Uninstall  commands for RAS Gateway and BGP.  
  
[Uninstall-RemoteAccess](https://technet.microsoft.com/library/hh918390.aspx)  
  
Uninstalls Remote Access from the computer, including all Remote Access features and functionality (RAS Gateway, BGP, etc).  
  
```  
Uninstall-RemoteAccess [-CimSession <CimSession[]> ] [-ComputerName <String> ] [-EntrypointName <String> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-ThrottleLimit <Int32> ] [-VpnType <String> {Vpn | VpnS2S} ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]  
```  
  


