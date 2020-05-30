---
title: Configure RADIUS Clients
description: This topic provides information about configuring RADIUS Clients for Network Policy Server in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: cde37849-ce79-4c26-aa14-cd0ef31cae18
ms.author: lizross 
author: eross-msft
---

# Configure RADIUS Clients

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to configure network access servers as RADIUS Clients in NPS.

When you add a new network access server \(VPN server, wireless access point, authenticating switch, or dial-up server\) to your network, you must add the server as a RADIUS client in NPS, and then configure the RADIUS client to communicate with the NPS.

>[!IMPORTANT]
>Client computers and devices, such as laptop computers, tablets, phones, and other computers running client operating systems, are not RADIUS clients. RADIUS clients are network access servers - such as wireless access points, 802.1X-capable switches, virtual private network (VPN) servers, and dial-up servers - because they use the RADIUS protocol to communicate with RADIUS servers, such as Network Policy Server \(NPS\) servers.

This step is also necessary when your NPS is a member of a remote RADIUS server group that is configured on an NPS proxy. In this circumstance, in addition to performing the steps in this task on the NPS proxy, you must do the following:

- On the NPS proxy, configure a remote RADIUS server group that contains the NPS.
- On the remote NPS, configure the NPS proxy as a RADIUS client.

To perform the procedures in this topic, you must have at least one network access server \(VPN server, wireless access point, authenticating switch, or dial-up server\) or NPS proxy physically installed on your network.

## Configure the Network Access Server

Use this procedure to configure network access servers for use with NPS. When you deploy network access servers (NASs) as RADIUS clients, you must configure the clients to communicate with the NPSs where the NASs are configured as clients.

This procedure provides general guidelines about the settings you should use to configure your NASs; for specific instructions on how to configure the device you are deploying on your network, see your NAS product documentation.

### To configure the network access server

1. On the NAS, in **RADIUS settings**, select **RADIUS authentication** on User Datagram Protocol (UDP) port **1812** and **RADIUS accounting** on UDP port **1813**.
2. In **Authentication server** or **RADIUS server**, specify your NPS by IP address or fully qualified domain name (FQDN), depending on the requirements of the NAS. 
3. In **Secret** or **Shared secret**, type a strong password. When you configure the NAS as a RADIUS client in NPS, you will use the same password, so do not forget it.
4. If you are using PEAP or EAP as an authentication method, configure the NAS to use EAP authentication.
5. If you are configuring a wireless access point, in **SSID**, specify a Service Set Identifier \(SSID\), which is an alphanumeric string that serves as the network name. This name is broadcast by access points to wireless clients and is visible to users at your wireless fidelity \(Wi-Fi\) hotspots.
6. If you are configuring a wireless access point, in **802.1X and WPA**, enable **IEEE 802.1X authentication** if you want to deploy PEAP-MS-CHAP v2, PEAP-TLS, or EAP-TLS.

## Add the Network Access Server as a RADIUS Client in NPS

Use this procedure to add a network access server as a RADIUS client in NPS. You can use this procedure to configure a NAS as a RADIUS client by using the NPS console.

To complete this procedure, you must be a member of the **Administrators** group.

### To add a network access server as a RADIUS client in NPS

1. On the NPS, in Server Manager, click **Tools**, and then click **Network Policy Server**. The NPS console opens.
2. In the NPS console, double-click **RADIUS Clients and Servers**. Right-click **RADIUS Clients**, and then click **New RADIUS Client**. 
3. In **New RADIUS Client**, verify that the **Enable this RADIUS client** check box is selected.
4. In **New RADIUS Client**, in **Friendly name**, type a display name for the NAS. In **Address (IP or DNS)**, type the NAS IP address or fully qualified domain name (FQDN). If you enter the FQDN, click **Verify** if you want to verify that the name is correct and maps to a valid IP address. 
5. In **New RADIUS Client**, in **Vendor**, specify the NAS manufacturer name. If you are not sure of the NAS manufacturer name, select **RADIUS standard**.
6. In **New RADIUS Client**, in **Shared secret**, do one of the following:
	- Ensure that **Manual** is selected, and then in **Shared secret**, type the strong password that is also entered on the NAS. Retype the shared secret in **Confirm shared secret**.
	- Select **Generate**, and then click **Generate** to automatically generate a shared secret. Save the generated shared secret for configuration on the NAS so that it can communicate with the NPS.
7. In **New RADIUS Client**, in **Additional Options**, if you are using any authentication methods other than EAP and PEAP, and if your NAS supports use of the message authenticator attribute, select **Access Request messages must contain the Message Authenticator attribute**.
8. Click **OK**. Your NAS appears in the list of RADIUS clients configured on the NPS.

## Configure RADIUS Clients by IP Address Range in Windows Server 2016 Datacenter

If you are running Windows Server 2016 Datacenter, you can configure RADIUS clients in NPS by IP address range. This allows you to add a large number of RADIUS clients (such as wireless access points) to the NPS console at one time, rather than adding each RADIUS client individually.

You cannot configure RADIUS clients by IP address range if you are running NPS on Windows Server 2016 Standard.

Use this procedure to add a group of network access servers (NASs) as RADIUS clients that are all configured with IP addresses from the same IP address range.

All of the RADIUS clients in the range must use the same configuration and shared secret.

To complete this procedure, you must be a member of the **Administrators** group.

### To set up RADIUS clients by IP address range

1. On the NPS, in Server Manager, click **Tools**, and then click **Network Policy Server**. The NPS console opens.
2. In the NPS console, double-click **RADIUS Clients and Servers**. Right-click **RADIUS Clients**, and then click **New RADIUS Client**.
3. In **New RADIUS Client**, in **Friendly name**, type a display name for the collection of NASs.
4. In **Address \(IP or DNS\)**, type the  IP address range for the RADIUS clients by using Classless Inter-Domain Routing \(CIDR\) notation. For example, if the IP address range for the NASs is 10.10.0.0, type **10.10.0.0/16**.
5. In **New RADIUS Client**, in **Vendor**, specify the NAS manufacturer name. If you are not sure of the NAS manufacturer name, select **RADIUS standard**.
6. In **New RADIUS Client**, in **Shared secret**, do one of the following:
	- Ensure that **Manual** is selected, and then in **Shared secret**, type the strong password that is also entered on the NAS. Retype the shared secret in **Confirm shared secret**.
	- Select **Generate**, and then click **Generate** to automatically generate a shared secret. Save the generated shared secret for configuration on the NAS so that it can communicate with the NPS.
7. In **New RADIUS Client**, in **Additional Options**, if you are using any authentication methods other than EAP and PEAP, and if all of your NASs support use of the message authenticator attribute, select **Access Request messages must contain the Message Authenticator attribute**.
8. Click **OK**. Your NASs appear in the list of RADIUS clients configured on the NPS.

For more information, see [RADIUS Clients](nps-radius-clients.md).

For more information about NPS, see [Network Policy Server (NPS)](nps-top.md).