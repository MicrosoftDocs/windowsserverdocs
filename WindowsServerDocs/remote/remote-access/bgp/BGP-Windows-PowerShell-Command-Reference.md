---
title: BGP Windows PowerShell Command Reference
description: You can use this topic as a reference, when writing Windows PowerShell scripts in Windows Server 2016, to add, configure, and remove BGP capabilities from RAS Gateway and Remote Access Local Area Network (LAN) routers.
ms.topic: article
ms.assetid: 4b0240a3-b927-4a1e-b241-5f8f29a9552f
ms.author: jgerend
author: JasonGerend
ms.date: 02/08/2023
---

# BGP Windows PowerShell command reference

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

You can use this topic as a reference, when writing Windows PowerShell scripts, to add, configure, and remove BGP capabilities from RAS Gateway and Remote Access Local Area Network (LAN) routers.

These BGP commands are part of the Remote Access Windows PowerShell command set for  Windows Server 2016. This topic helps you quickly locate the BGP commands that you want to use in scripts.

For more information on all Remote Access commands, see [Remote Access Cmdlets](/powershell/module/remoteaccess/?view=windowsserver2022-ps).

## BGP command reference

The following sections provide command name, purpose, and syntax for each BGP command, as well as a link to the command in the Remote Access reference, which contains more detailed information about each command.

This reference contains the following sections.

- [Add commands](#add-commands)

- [Clear commands](#clear-commands)

- [Disable and Enable commands](#disable-and-enable-commands)

- [Get commands](#get-commands)

- [Install commands](#install-commands)

- [Remove commands](#remove-commands)

- [Set commands](#set-commands)

- [Start and Stop commands](#start-and-stop-commands)

- [Uninstall commands](#uninstall-commands)

### Add commands

Following are the BGP Add commands.

[Add-BgpCustomRoute](/powershell/module/remoteaccess/add-bgpcustomroute?view=windowsserver2022-ps)

Adds custom routes to the BGP routing table.

```
Add-BgpCustomRoute [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-Interface <String[]> ] [-Network <String[]> ] [-PassThru] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Add-BgpPeer](/powershell/module/remoteaccess/add-bgppeer?view=windowsserver2022-ps)

Adds a new BGP peer.

```
Add-BgpPeer [-Name] <String> -LocalIPAddress <IPAddress> -PeerASN <UInt32> -PeerIPAddress <IPAddress> [-CimSession <CimSession[]> ] [-HoldTimeSec <UInt16> ] [-IdleHoldTimeSec <UInt16> ] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-LocalASN <UInt32> ] [-MaxAllowedPrefix <UInt32> ] [-OperationMode <OperationMode> {Mixed | Server} ] [-PassThru] [-PeeringMode <PeeringMode> {Automatic | Manual} ] [-RouteReflectorClient <Boolean> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Weight <UInt16> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Add-BgpRouteAggregate](/powershell/module/remoteaccess/add-bgprouteaggregate?view=windowsserver2022-ps)

Adds a new aggregate route for specific BGP routes.

```
Add-BgpRouteAggregate -Prefix <String> [-AttributePolicy <String[]> ] [-CimSession <CimSession[]> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-PassThru] [-PreserveASPath <PreserveASPath> ] [-RoutingDomain <String> ] [-SummaryOnly <SummaryOnly> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Add-BgpRouter](/powershell/module/remoteaccess/add-bgprouter?view=windowsserver2022-ps)

Adds a BGP router for the specified Tenant ID.

```
Add-BgpRouter -BgpIdentifier <IPAddress> -LocalASN <UInt32> [-CimSession <CimSession[]> ] [-ClientToClientReflection <ClientToClientReflection> ] [-ClusterId <UInt32> ] [-CompareMEDAcrossASN <Boolean> ] [-DefaultGatewayRouting <Boolean> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-IPv6Routing <IPv6RoutingState> {Disabled | Enabled} ] [-LocalIPv6Address <IPAddress> ] [-PassThru] [-RouteReflector <RouteReflector> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-TransitRouting <TransitRouting> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Add-BgpRoutingPolicy](/powershell/module/remoteaccess/add-bgproutingpolicy?view=windowsserver2022-ps)

Adds a BGP routing policy to the policy store.

```
Add-BgpRoutingPolicy [-Name] <String> [-PolicyType] <PolicyType> {Deny | Allow | ModifyAttribute} [-AddCommunity <String[]> ] [-CimSession <CimSession[]> ] [-ClearMED] [-Force] [-IgnorePrefix <String[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-MatchASNRange <UInt32[]> ] [-MatchCommunity <String[]> ] [-MatchNextHop <IPAddress[]> ] [-MatchPrefix <String[]> ] [-NewLocalPref <UInt32]> ] [-NewMED <UInt32]> ] [-NewNextHop <IPAddress> ] [-PassThru] [-RemoveAllCommunities] [-RemoveCommunity <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Add-BgpRoutingPolicyForPeer](/powershell/module/remoteaccess/add-bgproutingpolicyforpeer?view=windowsserver2022-ps)

Adds BGP routing policies to BGP peers.

```
Add-BgpRoutingPolicyForPeer -Direction <PolicyDirection> {Ingress | Egress} -PolicyName <String[]> [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-PeerName <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

### Clear commands

Following are the Clear commands for BGP

[Clear-BgpRouteFlapDampening](/powershell/module/remoteaccess/clear-bgprouteflapdampening?view=windowsserver2022-ps)

Clears the route flap dampening information for the specified set of BGP routes.

```
Clear-BgpRouteFlapDampening [-CimSession <CimSession[]> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-Prefix <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

### Disable and Enable commands

Following are the Disable and Enable commands for BGP

[Disable-BgpRouteFlapDampening](/powershell/module/remoteaccess/disable-bgprouteflapdampening?view=windowsserver2022-ps)

Disables route dampening for the flapping BGP routes.

```
Disable-BgpRouteFlapDampening [-CimSession <CimSession[]> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Enable-BgpRouteFlapDampening](/powershell/module/remoteaccess/enable-bgprouteflapdampening?view=windowsserver2022-ps)

Enables route dampening for the flapping BGP routes.

```
Enable-BgpRouteFlapDampening [-CimSession <CimSession[]> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-PassThru] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

### Get commands

Following are the Get commands for BGP.

[Get-BgpCustomRoute](/powershell/module/remoteaccess/get-bgpcustomroute?view=windowsserver2022-ps)

Gets custom route information from the BGP router.

```
Get-BgpCustomRoute [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Get-BgpPeer](/powershell/module/remoteaccess/get-bgprouter?view=windowsserver2022-ps)

Gets configuration information for BGP peers.

```
Get-BgpPeer [[-Name] <String[]> ] [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Get-BgpRouteAggregate](/powershell/module/remoteaccess/get-bgprouteaggregate?view=windowsserver2022-ps)

Gets all the aggregate BGP routes configured by the administrator.

```
Get-BgpRouteAggregate [-CimSession <CimSession[]> ] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-Prefix <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Get-BgpRouteFlapDampening](/powershell/module/remoteaccess/get-bgprouteflapdampening?view=windowsserver2022-ps)

Retrieves the configuration of a BGP route dampening engine.

```
Get-BgpRouteFlapDampening [-CimSession <CimSession[]> ] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Get-BgpRouteInformation](/powershell/module/remoteaccess/get-bgprouteinformation?view=windowsserver2022-ps)

Retrieves BGP route information for one or more network prefixes from the BGP routing table.

```
Get-BgpRouteInformation [-CimSession <CimSession[]> ] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-Network <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Type <RouteType> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Get-BgpRouter](/powershell/module/remoteaccess/get-bgprouter?view=windowsserver2022-ps)

Gets configuration information for BGP routers.

```
Get-BgpRouter [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String[]> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Get-BgpRoutingPolicy](/powershell/module/remoteaccess/get-bgproutingpolicy?view=windowsserver2022-ps)

Gets configuration information of BGP routing policies.

```
Get-BgpRoutingPolicy [[-Name] <String[]> ] [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-PolicyType <PolicyType> {Deny | Allow | ModifyAttribute} ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Get-BgpStatistics](/powershell/module/remoteaccess/get-bgpstatistics?view=windowsserver2022-ps)

Retrieves BGP peering-related message and route advertisement statistics.

```
Get-BgpStatistics [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-PeerName <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

### Install commands

Following are the Install commands for RAS Gateway and BGP.

[Install-RemoteAccess](/powershell/module/remoteaccess/install-remoteaccess?view=windowsserver2022-ps)

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

### Remove commands

Following are the Remove commands for BGP.

[Remove-BgpCustomRoute](/powershell/module/remoteaccess/remove-bgpcustomroute?view=windowsserver2022-ps)

Removes custom routes from the BGP router.

```
Remove-BgpCustomRoute [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-Interface <String[]> ] [-Network <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Remove-BgpPeer](/powershell/module/remoteaccess/remove-bgppeer?view=windowsserver2022-ps)

Removes BGP peers from a router.

```
Remove-BgpPeer [-Name] <String[]> [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Remove-BgpRouteAggregate](/powershell/module/remoteaccess/remove-bgprouteaggregate?view=windowsserver2022-ps)

Removes the set of specified aggregate BGP routes.

```
Remove-BgpRouteAggregate [-CimSession <CimSession[]> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-Prefix <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Remove-BgpRouter](/powershell/module/remoteaccess/remove-bgprouter?view=windowsserver2022-ps)

Removes a BGP router.

```
Remove-BgpRouter [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String[]> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Remove-BgpRoutingPolicy](/powershell/module/remoteaccess/remove-bgproutingpolicy?view=windowsserver2022-ps)

Removes routing policies from the policy store.

```
Remove-BgpRoutingPolicy [-Name] <String[]> [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Remove-BgpRoutingPolicyForPeer](/powershell/module/remoteaccess/remove-bgproutingpolicyforpeer?view=windowsserver2022-ps)

Removes routing policies from BGP peers.

```
Parameter Set: Remove1
Remove-BgpRoutingPolicyForPeer [-CimSession <CimSession[]> ] [-Direction <PolicyDirection> {Ingress | Egress} ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-PeerName <String[]> ] [-PolicyName <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

### Set commands

Following are the Set commands for BGP.

[Set-BgpPeer](/powershell/module/remoteaccess/set-bgppeer?view=windowsserver2022-ps)

Updates the configuration of the specified BGP peer.

```
Set-BgpPeer [-Name] <String> [-CimSession <CimSession[]> ] [-ClearPrefixLimit] [-Force] [-HoldTimeSec <UInt16> ] [-IdleHoldTimeSec <UInt16> ] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-LocalASN <UInt32> ] [-LocalIPAddress <IPAddress> ] [-MaxAllowedPrefix <UInt32> ] [-OperationMode <OperationMode> {Mixed | Server} ] [-PassThru] [-PeerASN <UInt32> ] [-PeeringMode <PeeringMode> {Automatic | Manual} ] [-PeerIPAddress <IPAddress> ] [-RouteReflectorClient <Boolean> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Weight <UInt16> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Set-BgpRouteAggregate](/powershell/module/remoteaccess/set-bgprouteaggregate?view=windowsserver2022-ps)

Updates the properties of specified aggregate BGP route.

```
Set-BgpRouteAggregate -Prefix <String> [-AttributePolicy <String[]> ] [-CimSession <CimSession[]> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-PassThru] [-PreserveASPath <PreserveASPath> ] [-RoutingDomain <String> ] [-SummaryOnly <SummaryOnly> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Set-BgpRouteFlapDampening](/powershell/module/remoteaccess/set-bgprouteflapdampening?view=windowsserver2022-ps)

Configures the BGP route dampening engine.

```
Set-BgpRouteFlapDampening [-CimSession <CimSession[]> ] [-Force] [-HalfLife <UInt32> ] [-HalfLifeUnreachable <UInt32> ] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-MaxSuppressTime <UInt32> ] [-PassThru] [-ReuseThreshold <UInt32> ] [-RoutingDomain <String> ] [-SuppressThreshold <UInt32> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Set-BgpRouter](/powershell/module/remoteaccess/set-bgprouter?view=windowsserver2022-ps)

Updates the configuration of the local BGP router for the specified tenant ID.

```
Set-BgpRouter [-BgpIdentifier <IPAddress> ] [-CimSession <CimSession[]> ] [-ClientToClientReflection <ClientToClientReflection> ] [-ClusterId <UInt32> ] [-CompareMEDAcrossASN <Boolean> ] [-DefaultGatewayRouting <Boolean> ] [-Force] [-InformationAction <ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <String> ] [-IPv6Routing <IPv6RoutingState> {Disabled | Enabled} ] [-LocalASN <UInt32> ] [-LocalIPv6Address <IPAddress> ] [-PassThru] [-RouteReflector <RouteReflector> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-TransitRouting <TransitRouting> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Set-BgpRoutingPolicy](/powershell/module/remoteaccess/set-bgproutingpolicy?view=windowsserver2022-ps)

Modifies a routing policy configuration.

```
Set-BgpRoutingPolicy [-Name] <String> [-AddCommunity <String[]> ] [-CimSession <CimSession[]> ] [-ClearMED] [-Force] [-IgnorePrefix <String[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-MatchASNRange <UInt32[]> ] [-MatchCommunity <String[]> ] [-MatchNextHop <IPAddress[]> ] [-MatchPrefix <String[]> ] [-NewLocalPref <UInt32]> ] [-NewMED <UInt32]> ] [-NewNextHop <IPAddress> ] [-PassThru] [-PolicyType <PolicyType> {Deny | Allow | ModifyAttribute} ] [-RemoveAllCommunities] [-RemoveCommunity <String[]> ] [-RemovePolicyClause <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Set-BgpRoutingPolicyForPeer](/powershell/module/remoteaccess/set-bgproutingpolicyforpeer?view=windowsserver2022-ps)

Modifies BGP routing policies for BGP peers.

```
Set-BgpRoutingPolicyForPeer -Direction <PolicyDirection> {Ingress | Egress} -PolicyName <String[]> [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-PeerName <String[]> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

### Start and Stop commands

Following are the Start and Stop  commands for BGP.

[Start-BgpPeer](/powershell/module/remoteaccess/start-bgppeer?view=windowsserver2022-ps)

Starts routing sessions for BGP peers.

```
Start-BgpPeer [-Name] <String[]> [-CimSession <CimSession[]> ] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [ <CommonParameters>] [ <WorkflowParameters>]
```

[Stop-BgpPeer](/powershell/module/remoteaccess/stop-bgppeer?view=windowsserver2022-ps)

Stops routing sessions for BGP peers.

```
Stop-BgpPeer [-Name] <String[]> [-CimSession <CimSession[]> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-RoutingDomain <String> ] [-ThrottleLimit <Int32> ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```

### Uninstall commands

Following are the Uninstall  commands for RAS Gateway and BGP.

[Uninstall-RemoteAccess](/powershell/module/remoteaccess/uninstall-remoteaccess?view=windowsserver2022-ps)

Uninstalls Remote Access from the computer, including all Remote Access features and functionality (RAS Gateway, BGP, etc).

```
Uninstall-RemoteAccess [-CimSession <CimSession[]> ] [-ComputerName <String> ] [-EntrypointName <String> ] [-Force] [-InformationAction <System.Management.Automation.ActionPreference> {SilentlyContinue | Stop | Continue | Inquire | Ignore | Suspend} ] [-InformationVariable <System.String> ] [-ThrottleLimit <Int32> ] [-VpnType <String> {Vpn | VpnS2S} ] [-Confirm] [-WhatIf] [ <CommonParameters>] [ <WorkflowParameters>]
```
