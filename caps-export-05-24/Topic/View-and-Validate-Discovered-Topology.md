---
title: View and Validate Discovered Topology
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c2374b40-f5a9-4825-a926-fe558304a936
---
# View and Validate Discovered Topology
You can use this topic to view and validate the discovered topology.  
  
This topic contains the following sections.  
  
-   [View the Discovered Topology](#bkmk_view)  
  
-   [Validate the Discovered Topology](#bkmk_validate)  
  
## <a name="bkmk_view"></a>View the Discovered Topology  
After network discovery is completed, you can view the discovered topology by using the following Windows PowerShell command.  
  
```  
Get-NetworkControllerDiscoveredTopology -ConnectionUri https://networkcontroller  
```  
  
The following example output provides the discoveredTopology resource.  
  
```  
ResourceRef      : /topologies/discoveredTopology/  
InstanceId       : 4ccfe813-6c7d-4580-8dc9-149c2d422353  
Etag             :   
ResourceMetadata :  
ResourceId       :  
Properties       : Microsoft.Windows.NetworkController.DiscoveredTopologyProperties  
```  
  
When you display the properties of discoveredTopology, you can view discovered topology nodes and links. Only the resource IDs are shown. You can also display the discovered properties of topology nodes and links, as shown in the following examples.  
  
```  
$topology=Get-NetworkControllerDiscoveredTopology -ConnectionUri https://networkcontroller  
$topology.Properties  
  
Provisioning State   Topology Nodes                                                                   TopologyLinks  
------------------   --------------                                                                   -------------   
Succeeded            {fc284b32-38ba-47d2-a67a-6443d3938bb1, f5bbde7a-649c-4aa2-ac97-28dadc02b017,...} {8de645ab-1380-45ac-82a8-ee7f8f4e9584,ff5c5fea-0527-4011-83a8-de0bf4b121d9,...}  
  
$topology=Get-NetworkControllerDiscoveredTopology -ConnectionUri https://networkcontroller  
$topology.Properties.TopologyNodes[0].Properties  
Name               : DC   
OS                 :   
Model              :  
Vendor             :  
Serial             :  
IsHidden           : False  
Type               : Switch  
IsManuallyAdded    : False  
ProvisioningState  : Succeeded  
TerminationPoints  : {04dce30a-d031-43ab-b516-7844550ee574, b26471f4-df07-49bb-a494-cf5547cc0c4c, 5c53cc33-53e5-4d64-b12e-3dce407bcbe5}  
  
$topology=Get-NetworkControllerDiscoveredTopology -ConnectionUri https://networkcontroller  
$topology.Properties.TopologyLinks[0].Properties  
  
Type              : Regular  
Label             :  
AggregateId       :  
IsManuallyAdded   : False  
IsHidden          : False  
ProvisioningState : Succeded  
Terminationpoint1 : Microsoft.Windows.NetworkController.DiscoveredTerminationPoint  
Terminationpoint2 : Microsoft.Windows.NetworkController.DiscoveredTerminationPoint  
```  
  
You can use the following Windows PowerShell commands to get the topology nodes, links, and termination points based on the resource IDs.  
  
```  
Get-NetworkControllerDiscoveredTopologyLink  
Get-NetworkControllerDiscoveredTopologyNode  
Get-NetworkControllerDiscoveredTerminationpoint  
```  
  
> [!NOTE]  
> Network Discovery marks devices as  failed devices when basic system information for the device is not obtained during discovery. Devices are marked as inaccessible  when basic system information is obtained successfully by discovery, but the IP address and Interface information are not obtained.  
  
## <a name="bkmk_validate"></a>Validate the Discovered Topology  
After performing Network Discovery, you can validate the discovered topology against the actual topology of your network. If you discover differences between the actual and discovered topologies, you can make changes to your network until network discovery results match the actual topology.  
  
For example, if a link between two topology nodes does not appear in the discovery topology, but the link exists in the actual topology of the network, this might indicate a cabling error. If this is the case, you can fix the cabling error, then run Network Discovery again to ensure that the actual topology and discovery topology match.  
  
In another example, if the discovered topology shows a particular VLAN on a switch port, while the actual topology shows a different VLAN, you can go ahead and correct the VLAN on the switch port. Then you can run Network Discovery again to ensure the topologies match.  
  
In most cases you will want to keep a record of your actual topology. You can manage the record of your actual topology manually, or you can input the topology to Network Controller.   
  
For more information on using Network Controller to manage your actual topology, see the topic [Build the Actual Topology in Network Controller](../Topic/Build-the-Actual-Topology-in-Network-Controller.md).  
  
If you do not want to create and input the actual topology in Network Controller, you can manually check whether the discovered topology is correct, and then convert the discovered topology into the actual topology. You can do this after your initial deployment is complete, and you can use the converted topology as the reference for any further wiring validation in the datacenter.  
  
For more information on converting the discovered topology into the actual topology, see the topic [Convert the Discovered Topology into the Actual Topology](Convert-the-Discovered-Topology-into-the-Actual-Topology.md).  
  
  
  
## See Also  
[Network Discovery and Topology](../Topic/Network-Discovery-and-Topology.md)  
  
