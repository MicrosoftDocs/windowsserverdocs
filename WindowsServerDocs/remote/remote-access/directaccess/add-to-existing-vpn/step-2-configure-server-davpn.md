---
title: Step 2 Configure the DirectAccess-VPN Server
description: This topic is part of the guide Add DirectAccess to an Existing Remote Access (VPN) Deployment for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fe221fc9-c7d9-4508-b8a1-000d2515283c
ms.author: pashort
author: shortpatti
---
#  Step 2 Configure the DirectAccess-VPN Server

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes how to configure the client and server settings required for a basic Remote Access deployment using the Enable DirectAccess Wizard.

The following table provides an overview of the steps you can complete by using this topic.

|Task       |Description|
|-----------|-----------|
|Configure DirectAccess clients|Configure the Remote Access server with the security groups containing DirectAccess clients.|
|Configure the Network Topology|Configure Remote Access server settings.|
|Configure the DNS Suffix Search List|Modify the Suffix search list if desired.|
|GPO Configuration|Modify the GPOs if desired.|

## To Start the Enable DirectAcces Wizard

1. In Server Manager, click **Tools**, and then click **Remote Access**.The Enable DirectAccess Wizard starts automatically unless you have selected **Do not show this screen again**. 

2. If the wizard does not start automatically, right-click the server node in the Routing and Remote Access tree, and then click **Enable DirectAccess**.

3. Click **Next**.

## Configure DirectAccess clients

For a client computer to be provisioned to use DirectAccess it must belong to the selected security group. After DirectAccess is configured, client computers in the security group are provisioned to receive the DirectAccess group policy.

1. On the **Select Groups** page, click **Add**.

2. On the **Select Groups** dialog box, select the security groups containing DirectAccess client computers.

3. Select the **Enable DirectAccess for mobile computers only** check box to allow only mobile computers to access the internal network.

4. Select the **Use force tunneling** check box to route all client traffic (to the internal network and to the Internet) through the Remote Access server.

5. Click **Next**.

## Configure the Network Topology

To deploy Remote Access, you need to configure the Remote Access server with the correct network adapters, a public URL for the Remote Access server to which client computers can connect (the connect to address), and an IP-HTTPS certificate whose subject matches the connect to address.

1. On the **Network Topology** page, click the deployment topology that will be used in your organization. In **Type the public name or IPv4 address used by clients to connect to the Remote Access server**, enter the public name for the deployment (this name matches the subject name of the IP-HTTPS certificate, for example, edge1.contoso.com), and then click **Next**.

## Configure the DNS Suffix Search List

For DNS clients, you can configure a DNS domain suffix search list that extends or revises their DNS search capabilities. By adding additional suffixes to the list, you can search for short, unqualified computer names in more than one specified DNS domain. Then, if a DNS query fails, the DNS Client service can use this list to append other name suffix endings to your original name and repeat DNS queries to the DNS server for these alternate FQDNs.

1. Select **Configure DirectAccess Clients with DNS client suffix search list** to specify additional suffixes for client name searches.

2. Type a new suffix name in **New Suffix** and then click **Add**. Additionally, you can change the search order and remove suffixes from **Domain Suffixes to use**.

>[NOTE]
>In a disjoint name space scenario \(where one or more domain computers has an DNS suffix that does not match the Active Directory domain to which the computers belong\), you should ensure that the search list is customized to include all the required suffixes. The Remote Access wizard will by default configure the Active Directory DNS name as the primary DNS suffix on the client. Admin should ensure that he adds the DNS suffix used by clients for name resolution.

For computers and servers, the following default DNS search behavior is predetermined and used when completing and resolving short, unqualified names.When the suffix search list is empty or unspecified, the primary DNS suffix of the computer is appended to short unqualified names, and a DNS query is used to resolve the resultant FQDN. 

If this query fails, the computer can try additional queries for alternate FQDNs by appending any connection-specific DNS suffix configured for network connections.If no connection-specific suffixes are configured or queries for these resultant connection-specific FQDNs fail, then the client can then begin to retry queries based on systematic reduction of the primary suffix (also known as devolution).

For example, if the primary suffix is "example.microsoft.com," the devolution process can retry queries for the short name by searching for it in the "microsoft.com" and "com" domains.

When the suffix search list is not empty and has at least one DNS suffix specified, attempts to qualify and resolve short DNS names is limited to searching only those FQDNs made possible by the specified suffix list. 

If queries for all FQDNs formed as a result of appending and trying each suffix in the list are not resolved, the query process fails, producing a "name not found" result. 

> [!WARNING]
> If the domain suffix list is used, clients continue to send additional alternate queries based on different DNS domain names when a query is not answered or resolved. Once a name is resolved using an entry in the suffix list, unused list entries are not tried. For this reason, it is most efficient to order the list with the most used domain suffixes first.
> 
> Domain name suffix searches are used only when a DNS name entry is not fully qualified. To fully qualify a DNS name, a trailing period (.) is entered at the end of the name.

## GPO Configuration

When you configure Remote Access, DirectAccess settings are collected into Group Policy Objects (GPO). 

In **GPO Settings**, the DirectAccess server GPO name and Client GPO name are listed. Additionally, you can modify the GPO selection settings.

Two GPOs are populated automatically with DirectAccess settings, and distributed in this way:

1. **DirectAccess client GPO**. This GPO contains client settings, including IPv6 transition technology settings, NRPT entries, and Windows Firewall with Advanced Security connection security rules. The GPO is applied to the security groups specified for the client computers.

2. **DirectAccess server GPO**. This GPO contains the DirectAccess configuration settings that are applied to any server configured as a Remote Access server in your deployment. It also contains Windows Firewall with Advanced Security connection security rules.

## Summary

Once the Remote Access configuration is complete the **Summary** is displayed. You can change the configured settings or click **Finish** to apply the configuration.
