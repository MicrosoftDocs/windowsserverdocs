---
title: Compare the Discovered Topology with the Actual Topology
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 225480b5-faa1-413e-aa1d-e1c91f496e17
author: vhorne
---
# Compare the Discovered Topology with the Actual Topology
If you have populated the actual topology into the Network Controller, you can use Network Controller cmdlets to compare the actual topology with the discovered topology and see the differences. The differences will allow you to identify and correct cabling and connectivity issues in your datacenter.  
  
To compare the discovered topology with the actual topology, you can use the following script. Before you run this script, ensure that the actual topology is present and that topology discovery is completed.  
  
```  
$diffInput = ‘{  
  "resourceRef": "/networkDiscovery/TopologyValidationReport",  
  "resourceId": "validationReport",  
  "properties": {  
    "compareVlans": "true",  
    "compareHosts": "true",  
    "compareAggregateLinks": "true",  
    "compareIpConfiguration": "true",  
    "compareBasicPropertiesOnly": “false”,  
   "ignoreNullValues": “true”  
  }  
}’  
  
$diffOutput = Invoke-WebRequest -UseBasicParsing -Uri https://restserver/networking/v1/networkDiscovery/TopologyValidationReport -Body $diffInput -ContentType "application/json" -Method Put  
```  
After you run this script, `$diffOutput.Content' contains the differences between discovered and desired state topology.  
  
When computing the differences between actual topology and the discovered topology, you can choose to ignore certain properties. You can use the following customizations for this computation.  
  
1.	Compare virtual Local Area Networks \(VLANs\) – You can choose to enable or disable the comparison of VLANs on switch ports between the actual topology and the discovered topology. By default, comparisons of VLANs is enabled.  
2.	Compare Hosts - You can choose to enable or disable the comparison of hosts and their interfaces between the actual topology and the discovered topology. This is usually done when your hosts are not yet started and you want to validate the connectivity between the network switches. By default, host comparison is enabled.  
3.	Compare aggregate links - You can choose to enable or disable comparison of aggregate links on switches between the actual topology and the discovered topology. This is usually done when validating connectivity between switches before the switches have been configured. By default, comparing aggregate links is enabled.  
4.	Compare IP configuration - You can choose to enable or disable comparison of IP configuration on hosts and switches between the actual topology and the discovered topology. This is useful if the IP addresses are not static and you don’t want the overhead of updating the IP address in the actual topology. By default, comparison of the IP configuration is enabled.  
5.	Ignore null values – You can choose to ignore null values when you compare the actual topology with the discovered topology. You might not be populating some attributes in the actual topology, and you don’t want those differences to be highlighted in the comparison. By default, null values are ignored.  
6.	Compare only basic properties – The comparison logic in Network Discovery compares basic properties like FQDNs, management address for devices, and other advanced properties - such as  model, serial number, vendor, operating system name, and more. For interfaces, the basic properties are interface type, MAC address and interface index; and advanced properties are IP configuration and VLANs. You can choose to compare only the basic properties, or compare all the properties.   
