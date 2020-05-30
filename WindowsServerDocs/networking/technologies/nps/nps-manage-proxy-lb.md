---
title: NPS Proxy Server Load Balancing
description: You can use this topic to learn about Windows Server 2016 and Windows 10 VPN features and functionality.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 528280e6-b47e-489f-b310-b257d434aa0d
manager: brianlic
ms.author: lizross
author: eross-msft
---

# NPS Proxy Server Load Balancing

Applies To: Windows Server 2016

Remote Authentication Dial-In User Service (RADIUS) clients, which are network access servers such as virtual private network (VPN) servers and wireless access points, create connection requests and send them to RADIUS servers such as NPS. In some cases, an NPS might receive too many connection requests at one time, resulting in degraded performance or an overload. When an NPS is overloaded, it is a good idea to add more NPSs to your network and to configure load balancing. When you evenly distribute incoming connection requests among multiple NPSs to prevent the overloading of one or more NPSs, it is called load balancing.

Load balancing is particularly useful for:

- Organizations that use Extensible Authentication Protocol-Transport Layer Security \(EAP-TLS\) or Protected Extensible Authentication Protocol \(PEAP\)-TLS for authentication. Because these authentication methods use certificates for server authentication and for either user or client computer authentication, the load on RADIUS proxies and servers is heavier than when password-based authentication methods are used.
- Organizations that need to sustain continuous service availability.
- Internet service providers \(ISPs\) that outsource VPN access for other organizations. The outsourced VPN services can generate a large volume of authentication traffic.

There are two methods you can use to balance the load of connection requests sent to your NPSs:

- Configure your network access servers to send connection requests to multiple RADIUS servers. For example, if you have 20 wireless access points and two RADIUS servers, configure each access point to send connection requests to both RADIUS servers. You can load balance and provide failover at each network access server by configuring the access server to send connection requests to multiple RADIUS servers in a specified order of priority. This method of load balancing is usually best for small organizations that do not deploy a large number of RADIUS clients.
- Use NPS configured as a RADIUS proxy to load balance connection requests between multiple NPSs or other RADIUS servers. For example, if you have 100 wireless access points, one NPS proxy, and three RADIUS servers, you can configure the access points to send all traffic to the NPS proxy. On the NPS proxy, configure load balancing so that the proxy evenly distributes the connection requests between the three RADIUS servers. This method of load balancing is best for medium and large organizations that have many RADIUS clients and servers.

In many cases, the best approach to load balancing is to configure RADIUS clients to send connection requests to two NPS proxy servers, and then configure the NPS proxies to load balance among RADIUS servers. This approach provides both failover and load balancing for NPS proxies and RADIUS servers.

## RADIUS server priority and weight

During the NPS proxy configuration process, you can create remote RADIUS server groups and then add RADIUS servers to each group. To configure load balancing, you must have more than one RADIUS server per remote RADIUS server group. While adding group members, or after creating a RADIUS server as a group member, you can access the Add RADIUS server dialog box to configure the following items on the Load Balancing tab:

- **Priority**. Priority specifies the order of importance of the RADIUS server to the NPS proxy server. Priority level must be assigned a value that is an integer, such as 1, 2, or 3. The lower the number, the higher priority the NPS proxy gives to the RADIUS server. For example, if the RADIUS server is assigned the highest priority of 1, the NPS proxy sends connection requests to the RADIUS server first; if servers with priority 1 are not available, NPS then sends connection requests to RADIUS servers with priority 2, and so on. You can assign the same priority to multiple RADIUS servers, and then use the Weight setting to load balance between them.

- **Weight**. NPS uses this Weight setting to determine how many connection requests to send to each group member when the group members have the same priority level. Weight setting must be assigned a value between 1 and 100, and the value represents a percentage of 100 percent. For example, if the remote RADIUS server group contains two members that both have a priority level of 1 and a weight rating of 50, the NPS proxy forwards 50 percent of the connection requests to each RADIUS server.

- **Advanced settings**. These failover settings provide a way for NPS to determine whether the remote RADIUS server is unavailable. If NPS determines that a RADIUS server is unavailable, it can start sending connection requests to other group members. With these settings you can configure the number of seconds that the NPS proxy waits for a response from the RADIUS server before it considers the request dropped; the maximum number of dropped requests before the NPS proxy identifies the RADIUS server as unavailable; and the number of seconds that can elapse between requests before the NPS proxy identifies the RADIUS server as unavailable.

## Configure NPS proxy load balancing

Before configuring load balancing, create a deployment plan that includes how many remote RADIUS server groups you require, which servers are members of each particular group, and the Priority and Weight setting for each server.

>[!NOTE]
>The steps that follow assume that you have already deployed and configured RADIUS servers.

To configure NPS to act as a proxy server and forward connection requests from RADIUS clients to remote RADIUS servers, you must take the following actions:

1. Deploy your RADIUS clients \(VPN servers, dial-up servers, Terminal Services Gateway servers, 802.1X authenticating switches, and 802.1X wireless access points\) and configure them to send connection requests to your NPS proxy servers.

2. On the NPS proxy, configure the network access servers as RADIUS clients. For more information, see [Configure RADIUS Clients](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-radius-clients-configure).

3. On the NPS proxy, create one or more remote RADIUS server groups. During this process, add RADIUS servers to the remote RADIUS server groups. For more information, see [Configure Remote RADIUS Server Groups](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-crp-rrsg-configure).

4. On the NPS proxy, for each RADIUS server that you add to a remote RADIUS server group, click the RADIUS server **Load Balancing** tab, and then configure **Priority**, **Weight**, and **Advanced settings**.

5. On the NPS proxy, configure connection request policies to forward authentication and accounting requests to remote RADIUS server groups. You must create one connection request policy per remote RADIUS server group. For more information, see [Configure Connection Request Policies](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-crp-configure).


