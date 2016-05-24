---
title: Step 2: Evaluate Client Connectivity
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 679dc9e6-0420-443f-af3e-04542b9d522e
author: jaimeo
---
# Step 2: Evaluate Client Connectivity
After you understand some of the requirements that are associated with each volume activation option as described in [Step 1: Review and Select Activation Methods](../Topic/Step-1--Review-and-Select-Activation-Methods.md), the next step in planning for Volume Activation Services is to evaluate the types of clients you have and their location and ability to connect to the central network. After you have completed this step, you can proceed to [Step 3: Determine Activation Method and Product License Requirements](../Topic/Step-3--Determine-Activation-Method-and-Product-License-Requirements.md).  
  
## Activation scenarios  
Each Volume Activation Services method that is available in Windows Server is best suited to a particular type of client and network configuration.  
  
To select the best activation method or methods for your organization, you need to assess your network environment to identify the types of clients you have and how groups of clients connect to the network.  
  
Connectivity to the corporate network, Internet access, and the number of computers that regularly connect to your corporate network are some of the important characteristics to identify. Most medium to large organizations use a combination of activation methods because of varied client connectivity needs.  
  
This section illustrates a few common volume activation scenarios in heterogeneous corporate environments that require more than one activation method. Each scenario has a recommended activation solution, but some environments may have infrastructure or policy requirements that are best suited to a different solution.  
  
|Task|Description|  
|--------|---------------|  
|2.1. Identify scenario requirements for the central network|Evaluate and address activation planning issues associated with well\-connected computers.|  
|2.2. Identify scenario requirements for the branch office network|Evaluate and address activation planning issues associated with computers that are on branch office networks.|  
|2.3. Identify high\-security zone scenario requirements|Evaluate and address activation planning issues associated with computers located in high\-security zones.|  
|2.4. Identify disconnected computer scenario requirements|Evaluate and address activation planning issues associated with computers that are disconnected from any of the organization’s networks.|  
|2.5 Identify test and development lab requirements|Evaluate and address activation planning issues associated with computers in test or development labs.|  
  
### 2.1. Identify scenario requirements for the central network  
The central network is characterized by well\-connected computers on multiple network segments that also have a connection to the Internet. For these environments, a combination of Active Directory\-based Activation and a centralized KMS solution are the recommended activation methods for computers on the central network.  
  
In Figure 1, the central network has a domain controller and KMS host, which are activated directly over the Internet.  
  
![](../Image/VA_CoreNetwork.gif)  
  
If physical computers are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] or newer, use Active\-Directory\-based Activation. If you have more than 25 client computers running earlier versions of Windows, use KMS host activation.  
  
> [!NOTE]  
> Clients running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] or newer can activate from the domain controller or from the KMS host.  
  
If you have fewer than 25 client computers running earlier versions of Windows, use MAK activation \(by telephone, Internet, or MAK Proxy\).  
  
> [!NOTE]  
> You can install a KMS host on a virtual computer. You should select a virtual computer that is unlikely to be moved to a different physical computer. If the KMS host on the virtual computer is moved to a different physical computer, the operating system detects the change in the underlying hardware, and the KMS host must be reactivated with Microsoft.  
  
If you plan to use KMS activation and you have more than 50 clients, consider setting up at least two KMS hosts for failover if one host is unavailable.  
  
### 2.2. Identify scenario requirements for the branch office network  
Some networks are in a different physical location from the central network. You may need to use a combination of Active Directory\-based Activation, KMS hosts, and MAK activation to meet the requirements of the branch office network scenario.  
  
How your network’s firewalls are configured is a significant factor in determining your branch office strategy.  
  
If ports on firewalls can be opened between KMS clients and hosts, use KMS hosts that are located on the central network.  
  
Figure 2 shows an enterprise network that supports client computers in three branch offices.  
  
![](../Image/VA_BranchOfficeScenario.gif)  
  
If you have more than 25 client computers and a site that has a secure TCP\/IP connection to the central network, use a local KMS host for activation. Site A in the diagram is an example of this solution.  
  
If you have remote sites with infrequent contact to the central network, use MAK activation. Site B is an example of the MAK solution.  
  
If you have a site with a secure connection to the central network, you can use the Active Directory\-based Activation for clients running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] or newer operating systems, and use KMS hosts from the central network to activate all other clients. Site C is an example of this solution.  
  
> [!NOTE]  
> The firewall configuration on the host for RPC over TCP should allow inbound traffic on TCP port 1688.  
  
### 2.3. Identify high\-security zone scenario requirements  
Many organizations have networks that are separated into multiple security zones, including a high\-security zone that is isolated to protect sensitive information.  
  
Figure 3 shows a high\-security network environment that does not allow any traffic between computers in the high\-security zone and the central network.  
  
![](../Image/VA_HighSecurity.gif)  
  
High\-security zones are frequently separated by a firewall that limits communication to and from other networks.  
  
If the high\-security zone has only limited communication with the central network, but it has enough computers to meet the KMS activation threshold, the high\-security zone has a local KMS host. This KMS host is activated by telephone.  
  
If the high\-security zone has only limited communication with the central network, but it does not have enough computers to meet the KMS activation threshold, use MAK activation. Each computer can be activated independently with Microsoft by telephone.  
  
If the computers in a high\-security zone are allowed access to the central network, you can activate the high\-security zone computers by using Active Directory\-based Activation or KMS hosts that are located on the central network.  
  
> [!NOTE]  
> Firewalls between networks need to allow TCP 1688 RPC traffic to the KMS host from the client, and they must allow a stateful response from the KMS host to the client.  
  
MAK Proxy activation enabled with VAMT is also possible in the high\-security zone scenario. Because the computers in the high\-security zone do not have Internet access, VAMT can discover them by using Active Directory, the computer name, an IP address, or membership in a workgroup. VAMT uses WMI to install MAK product keys and CIDs and to retrieve status on MAK clients. Because this traffic is not allowed through the firewall, you must have a local VAMT host in the high\-security zone. For more information, see [Volume Activation Management Tool \(VAMT\) Overview](http://go.microsoft.com/fwlink/?LinkId=214550).  
  
### 2.4. Identify disconnected computer scenario requirements  
Some users in an organization may be in remote locations or may travel to many locations. This scenario is common for roaming clients, such as the computers of sales people or other users who work offsite, but not at branch locations. This scenario can also apply to remote branch office locations that have no connection or an intermittent connection to the central network.  
  
Figure 4 illustrates the activation options that are available for disconnected computers.  
  
![](../Image/VA_DisconnectedComputers.gif)  
  
Disconnected computers can use Active Directory\-based Activation, KMS activation, or MAK activation processes that connect to the central network \(directly or through a VPN or secure channel\) at least once every 180 days.  
  
Use MAK Independent activation, by telephone or the Internet, for computers that rarely or never connect to the central network.  
  
### 2.5 Identify test and development lab requirements  
In a lab environment, computers are reconfigured often, and there are usually a large number of virtual computers. You should first determine whether the computers in test and development labs need activation.  
  
If you do need activation, labs can use Active Directory\-based Activation, KMS activation, or MAK activation, depending on the planning considerations described previously.  
  
Use Active Directory\-based Activation or KMS activation if the computers have connectivity to a central network where these activation options are available.  
  
If the lab does not have connectivity to the central network and the number of physical computers in the lab meets the KMS activation threshold, you can also deploy a local KMS host in the lab. However, if your lab has a high turnover of computers and a small number of physical KMS clients, you need to monitor the KMS activation count to maintain a sufficient number of cached client machine identifications \(CMIDs\) on the KMS host. A KMS host caches activation requests from physical computers for 30 days.  
  
If computers in your lab environment need activation, but they are not connected to the central network and do not meet the conditions for KMS activation, you can use MAK Independent activation, by telephone or Internet, if available.  
  
MAK Proxy activation can also be used with VAMT in this scenario.  
  
> [!NOTE]  
> If you install a local VAMT inside a lab that has no outside connectivity, you must manually update VAMT. You need to install VAMT in the isolated lab network and also in a network that has access to the Internet. VAMT in the isolated lab performs discovery, obtains status, installs a MAK product key, and obtains the IID of each computer in the lab. You can then export this information from VAMT, save it to removable media, and import the file to a computer running VAMT that has access to the Internet. VAMT sends the IIDs to Microsoft and obtains the corresponding CIDs needed to complete activation. After you export this data to removable media, you can take it to the isolated lab to import the CIDs so VAMT can complete the activations.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 3: Determine Activation Method and Product License Requirements](../Topic/Step-3--Determine-Activation-Method-and-Product-License-Requirements.md)  
  
-   [Step 1: Review and Select Activation Methods](../Topic/Step-1--Review-and-Select-Activation-Methods.md)  
  
-   [Plan for Volume Activation](../Topic/Plan-for-Volume-Activation.md)  
  
-   [Volume Activation Overview](../Topic/Volume-Activation-Overview.md)  
  
