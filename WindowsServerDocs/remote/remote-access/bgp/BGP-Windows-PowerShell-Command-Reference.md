---
title: BGP Windows PowerShell Command Reference
description: You can use this topic as a reference, when writing Windows PowerShell scripts in Windows Server 2016, to add, configure, and remove BGP capabilities from RAS Gateway and Remote Access Local Area Network (LAN) routers.
manager: brianlic
ms.topic: article
ms.assetid: 4b0240a3-b927-4a1e-b241-5f8f29a9552f
ms.author: jgerend
author: JasonGerend
ms.date: 08/07/2020
---
# BGP Windows PowerShell Command Reference

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic as a reference, when writing Windows PowerShell scripts, to add, configure, and remove BGP capabilities from RAS Gateway and Remote Access Local Area Network (LAN) routers.

These BGP commands are part of the Remote Access Windows PowerShell command set for  Windows Server 2016. This topic helps you quickly locate the BGP commands that you want to use in scripts.

For more information on all Remote Access commands, see [Remote Access Cmdlets](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11)).

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

[Add-BgpCustomRoute](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Adds custom routes to the BGP routing table.

```
Add-BgpCustomRoute [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-Interface <String[]> ] [-Network <String[]> ] [-PassThru] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Add-BgpPeer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Adds a new BGP peer.

```
Add-BgpPeer [-Name] <String> -LocalIPAddress <IPAddress> -PeerASN <UInt32> -PeerIPAddress <IPAddress> [-CimSession <CimSession[]> ] [-HoldTimeSec <UInt16> ] [-IdleHoldTimeSec <UInt16> ] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-LocalASN <UInt32> ] [-MaxAllowedPrefix <UInt32> ] [-OperationMode <OperationMode> {Mixed | Server} ] [-PassThru] [-PeeringMode <PeeringMode> {Automatic | Manual} ] [-RouteReflectorClient <Boolean> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Weight <UInt16> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Add-BgpRouteAggregate](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Adds a new aggregate route for specific BGP routes.

```
Add-BgpRouteAggregate -Prefix <String> [-AttributePolicy <String[]> ] [-CimSession <CimSession[]> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-PassThru] [-PreserveASPath <PreserveASPath> ] [-RoutingDomain <String> ] [-SummaryOnly <SummaryOnly> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Add-BgpRouter](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Adds a BGP router for the specified Tenant ID.

```
Add-BgpRouter -BgpIdentifier <IPAddress> -LocalASN <UInt32> [-CimSession <CimSession[]> ] [-ClientToClientReflection <ClientToClientReflection> ] [-ClusterId <UInt32> ] [-CompareMEDAcrossASN <Boolean> ] [-DefaultGatewayRouting <Boolean> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-IPv6Routing <IPv6RoutingState> {Disabled | Enabled} ] [-LocalIPv6Address <IPAddress> ] [-PassThru] [-RouteReflector <RouteReflector> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-TransitRouting <TransitRouting> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Add-BgpRoutingPolicy](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Adds a BGP routing policy to the policy store.

```
Add-BgpRoutingPolicy [-Name] <String> [-PolicyType] <PolicyType> {Deny | Allow | ModifyAttribute} [-AddCommunity <String[]> ] [-CimSession <CimSession[]> ] [-ClearMED] [-Force] [-IgnorePrefix <String[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-MatchASNRange <UInt32[]> ] [-MatchCommunity <String[]> ] [-MatchNextHop <IPAddress[]> ] [-MatchPrefix <String[]> ] [-NewLocalPref <UInt32]> ] [-NewMED <UInt32]> ] [-NewNextHop <IPAddress> ] [-PassThru] [-RemoveAllCommunities] [-RemoveCommunity <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Add-BgpRoutingPolicyForPeer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Adds BGP routing policies to BGP peers.

```
Add-BgpRoutingPolicyForPeer -Direction <PolicyDirection> {Ingress | Egress} -PolicyName <String[]> [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-PeerName <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

### <a name="bkmk_clear"></a>Clear commands
Following are the Clear commands for BGP

[Clear-BgpRouteFlapDampening](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Clears the route flap dampening information for the specified set of BGP routes.

```
Clear-BgpRouteFlapDampening [-CimSession <CimSession[]> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-Prefix <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

### <a name="bkmk_disable"></a>Disable and Enable commands
Following are the Disable and Enable commands for BGP

[Disable-BgpRouteFlapDampening](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Disables route dampening for the flapping BGP routes.

```
Disable-BgpRouteFlapDampening [-CimSession <CimSession[]> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Enable-BgpRouteFlapDampening](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Enables route dampening for the flapping BGP routes.

```
Enable-BgpRouteFlapDampening [-CimSession <CimSession[]> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-PassThru] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

### <a name="bkmk_get"></a>Get commands
Following are the Get commands for BGP.

[Get-BgpCustomRoute](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Gets custom route information from the BGP router.

```
Get-BgpCustomRoute [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Get-BgpPeer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Gets configuration information for BGP peers.

```
Get-BgpPeer [[-Name] <String[]> ] [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Get-BgpRouteAggregate](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Gets all the aggregate BGP routes configured by the administrator.

```
Get-BgpRouteAggregate [-CimSession <CimSession[]> ] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-Prefix <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Get-BgpRouteFlapDampening](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Retrieves the configuration of a BGP route dampening engine.

```
Get-BgpRouteFlapDampening [-CimSession <CimSession[]> ] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Get-BgpRouteInformation](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Retrieves BGP route information for one or more network prefixes from the BGP routing table.

```
Get-BgpRouteInformation [-CimSession <CimSession[]> ] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-Network <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Type <RouteType> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Get-BgpRouter](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Gets configuration information for BGP routers.

```
Get-BgpRouter [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String[]> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Get-BgpRoutingPolicy](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Gets configuration information of BGP routing policies.

```
Get-BgpRoutingPolicy [[-Name] <String[]> ] [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-PolicyType <PolicyType> {Deny | Allow | ModifyAttribute} ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Get-BgpStatistics](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Retrieves BGP peering-related message and route advertisement statistics.

```
Get-BgpStatistics [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-PeerName <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

### <a name="bkmk_install"></a>Install commands
Following are the Install commands for RAS Gateway and BGP.

[Install-RemoteAccess](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

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

[Remove-BgpCustomRoute](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Removes custom routes from the BGP router.

```
Remove-BgpCustomRoute [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-Interface <String[]> ] [-Network <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Remove-BgpPeer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Removes BGP peers from a router.

```
Remove-BgpPeer [-Name] <String[]> [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Remove-BgpRouteAggregate](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Removes the set of specified aggregate BGP routes.

```
Remove-BgpRouteAggregate [-CimSession <CimSession[]> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-Prefix <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Remove-BgpRouter](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Removes a BGP router.

```
Remove-BgpRouter [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String[]> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Remove-BgpRoutingPolicy](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Removes routing policies from the policy store.

```
Remove-BgpRoutingPolicy [-Name] <String[]> [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Remove-BgpRoutingPolicyForPeer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Removes routing policies from BGP peers.

```
Parameter Set: Remove1
Remove-BgpRoutingPolicyForPeer [-CimSession <CimSession[]> ] [-Direction <PolicyDirection> {Ingress | Egress} ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-PeerName <String[]> ] [-PolicyName <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

### <a name="bkmk_set"></a>Set commands
Following are the Set commands for BGP.

[Set-BgpPeer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Updates the configuration of the specified BGP peer.

```
Set-BgpPeer [-Name] <String> [-CimSession <CimSession[]> ] [-ClearPrefixLimit] [-Force] [-HoldTimeSec <UInt16> ] [-IdleHoldTimeSec <UInt16> ] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-LocalASN <UInt32> ] [-LocalIPAddress <IPAddress> ] [-MaxAllowedPrefix <UInt32> ] [-OperationMode <OperationMode> {Mixed | Server} ] [-PassThru] [-PeerASN <UInt32> ] [-PeeringMode <PeeringMode> {Automatic | Manual} ] [-PeerIPAddress <IPAddress> ] [-RouteReflectorClient <Boolean> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Weight <UInt16> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Set-BgpRouteAggregate](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Updates the properties of specified aggregate BGP route.

```
Set-BgpRouteAggregate -Prefix <String> [-AttributePolicy <String[]> ] [-CimSession <CimSession[]> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-PassThru] [-PreserveASPath <PreserveASPath> ] [-RoutingDomain <String> ] [-SummaryOnly <SummaryOnly> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Set-BgpRouteFlapDampening](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Configures the BGP route dampening engine.

```
Set-BgpRouteFlapDampening [-CimSession <CimSession[]> ] [-Force] [-HalfLife <UInt32> ] [-HalfLifeUnreachable <UInt32> ] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-MaxSuppressTime <UInt32> ] [-PassThru] [-ReuseThreshold <UInt32> ] [-RoutingDomain <String> ] [-SuppressThreshold <UInt32> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Set-BgpRouter](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Updates the configuration of the local BGP router for the specified tenant ID.

```
Set-BgpRouter [-BgpIdentifier <IPAddress> ] [-CimSession <CimSession[]> ] [-ClientToClientReflection <ClientToClientReflection> ] [-ClusterId <UInt32> ] [-CompareMEDAcrossASN <Boolean> ] [-DefaultGatewayRouting <Boolean> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-IPv6Routing <IPv6RoutingState> {Disabled | Enabled} ] [-LocalASN <UInt32> ] [-LocalIPv6Address <IPAddress> ] [-PassThru] [-RouteReflector <RouteReflector> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-TransitRouting <TransitRouting> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Set-BgpRoutingPolicy](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Modifies a routing policy configuration.

```
Set-BgpRoutingPolicy [-Name] <String> [-AddCommunity <String[]> ] [-CimSession <CimSession[]> ] [-ClearMED] [-Force] [-IgnorePrefix <String[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-MatchASNRange <UInt32[]> ] [-MatchCommunity <String[]> ] [-MatchNextHop <IPAddress[]> ] [-MatchPrefix <String[]> ] [-NewLocalPref <UInt32]> ] [-NewMED <UInt32]> ] [-NewNextHop <IPAddress> ] [-PassThru] [-PolicyType <PolicyType> {Deny | Allow | ModifyAttribute} ] [-RemoveAllCommunities] [-RemoveCommunity <String[]> ] [-RemovePolicyClause <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Set-BgpRoutingPolicyForPeer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Modifies BGP routing policies for BGP peers.

```
Set-BgpRoutingPolicyForPeer -Direction <PolicyDirection> {Ingress | Egress} -PolicyName <String[]> [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-PeerName <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

### <a name="bkmk_start"></a>Start and Stop commands
Following are the Start and Stop  commands for BGP.

[Start-BgpPeer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Starts routing sessions for BGP peers.

```
Start-BgpPeer [-Name] <String[]> [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Stop-BgpPeer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Stops routing sessions for BGP peers.

```
Stop-BgpPeer [-Name] <String[]> [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

### <a name="bkmk_uninstall"></a>Uninstall commands
Following are the Uninstall  commands for RAS Gateway and BGP.

[Uninstall-RemoteAccess](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd851844(v=ws.11))

Uninstalls Remote Access from the computer, including all Remote Access features and functionality (RAS Gateway, BGP, etc).

```
Uninstall-RemoteAccess [-CimSession <CimSession[]> ] [-ComputerName <String> ] [-EntrypointName <String> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-ThrottleLimit <Int32> ] [-VpnType <String> {Vpn | VpnS2S} ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

