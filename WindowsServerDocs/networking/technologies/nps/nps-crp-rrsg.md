---
title: Remote RADIUS Server Groups
description: This topic provides an overview of Network Policy Server Remote RADIUS Server Groups in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: d81678a7-be21-48f2-9b3f-5a75d6aef013
ms.author: lizross 
author: eross-msft
---

# Remote RADIUS Server Groups

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

When you configure Network Policy Server (NPS) as a Remote Authentication Dial-In User Service (RADIUS) proxy, you use NPS to forward connection requests to RADIUS servers that are capable of processing the connection requests because they can perform authentication and authorization in the domain where the user or computer account is located. For example, if you want to forward connection requests to one or more RADIUS servers in untrusted domains, you can configure NPS as a RADIUS proxy to forward the requests to the remote RADIUS servers in the untrusted domain.

>[!NOTE]
>Remote RADIUS server groups are unrelated to and separate from Windows groups.

To configure NPS as a RADIUS proxy, you must create a connection request policy that contains all of the information required for NPS to evaluate which messages to forward and where to send the messages.

When you configure a remote RADIUS server group in NPS and you configure a connection request policy with the group, you are designating the location where NPS is to forward connection requests.

## Configuring RADIUS servers for a group

A remote RADIUS server group is a named group that contains one or more RADIUS servers. If you configure more than one server, you can specify load balancing settings to either determine the order in which the servers are used by the proxy or to distribute the flow of RADIUS messages across all servers in the group to prevent overloading one or more servers with too many connection requests.

Each server in the group has the following settings.

- **Name or address**. Each group member must have a unique name within the group. The name can be an IP address or a name that can be resolved to its IP address.

- **Authentication and accounting**. You can forward authentication requests, accounting requests, or both to each remote RADIUS server group member.

- **Load balancing**. A priority setting is used to indicate which member of the group is the primary server (the priority is set to 1). For group members that have the same priority, a weight setting is used to calculate how often RADIUS messages are sent to each server. You can use additional settings to configure the way in which the NPS detects when a group member first becomes unavailable and when it becomes available after it has been determined to be unavailable.

After you have configured a Remote RADIUS Server Group, you can specify the group in the authentication and accounting settings of a connection request policy. Because of this, you can configure a remote RADIUS server group first. Next, you can configure the connection request policy to use the newly configured remote RADIUS server group. Alternatively, you can use the New Connection Request Policy Wizard to create a new remote RADIUS server group while you are creating the connection request policy.

For more information about NPS, see [Network Policy Server (NPS)](nps-top.md).
