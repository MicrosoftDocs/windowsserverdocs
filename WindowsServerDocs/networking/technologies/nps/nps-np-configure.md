---
title: Configure Network Policies
description: This topic provides an overview of network policy configuration for Network Policy Server in Windows Server 2016.
manager: dongill
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: fe77655a-e2be-4949-92e1-aaaa215d86ea
ms.author: jamesmci 
author: jamesmci
---

# Configure Network Policies

>Applies To: Windows Server 2016

You can use this topic to configure network policies in NPS.

## Add a Network Policy

Network Policy Server \(NPS\) uses network policies and the dial-in properties of user accounts to determine whether a connection request is authorized to connect to the network.

You can use this procedure to configure a new network policy in either the NPS console or the Remote Access console.

### Performing authorization

When NPS performs the authorization of a connection request, it compares the request with each network policy in the ordered list of policies, starting with the first policy, and then moving down the list of configured policies. If NPS finds a policy whose conditions match the connection request, NPS uses the matching policy and the dial-in properties of the user account to perform authorization. If the dial-in properties of the user account are configured to grant access or control access through network policy and the connection request is authorized, NPS applies the settings that are configured in the network policy to the connection.

If NPS does not find a network policy that matches the connection request, the connection request is rejected unless the dial-in properties on the user account are set to grant access.

If the dial-in properties of the user account are set to deny access, the connection request is rejected by NPS.

### Key settings


When you use the New Network Policy wizard to create a network policy, the value that you specify in **Network connection method** is used to automatically configure the **Policy Type** condition: 

- If you keep the default value of Unspecified , the network policy that you create is evaluated by NPS for all network connection types that are using any kind of network access server (NAS).
- If you specify a network connection method, NPS evaluates the network policy only if the connection request originates from the type of network access server that you specify.

On the **Access Permission** page, you must select **Access granted** if you want the policy to allow users to connect to your network. If you want the policy to prevent users from connecting to your network, select **Access denied**. 

If you want access permission to be determined by user account dial-in properties in Active Directory&reg; Domain Services \(AD DS\), you can select the **Access is determined by User Dial-in properties** check box.

Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure.

#### To add a network policy 

1. Open the NPS console, and then double-click **Policies**.

2. In the console tree, right-click **Network Policies**, and click **New**. The New Network Policy wizard opens.

3. Use the New Network Policy wizard to create a policy.

## Create Network Policies for Dial-Up or VPN with a Wizard

You can use this procedure to create the connection request policies and network policies required to deploy either dial-up servers or virtual private network \(VPN\) servers as Remote Authentication Dial-In User Service \(RADIUS\) clients to the NPS RADIUS server.

>[!NOTE]
>Client computers, such as laptop computers and other computers running client operating systems, are not RADIUS clients. RADIUS clients are network access servers — such as wireless access points, 802.1X authenticating switches, virtual private network \(VPN\) servers, and dial-up servers — because these devices use the RADIUS protocol to communicate with RADIUS servers such as NPS servers.

This procedure explains how to open the New Dial-up or Virtual Private Network Connections wizard in NPS.

After you run the wizard, the following policies are created:

- One connection request policy
- One network policy

You can run the New Dial-up or Virtual Private Network Connections wizard every time you need to create new policies for dial-up servers and VPN servers.

Running the New Dial-up or Virtual Private Network Connections wizard is not the only step required to deploy dial-up or VPN servers as RADIUS clients to the NPS server. Both network access methods require that you deploy additional hardware and software components.

Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure.

### To create policies for dial-up or VPN with a wizard

1. Open the NPS console. If it is not already selected, click **NPS \(Local\)**. If you want to create policies on a remote NPS server, select the server.

2. In **Getting Started** and **Standard Configuration**, select **RADIUS server for Dial-Up or VPN Connections**. The text and links under the text change to reflect your selection.

3. Click **Configure VPN or Dial-Up with a wizard**. The New Dial-up or Virtual Private Network Connections wizard opens.

4. Follow the instructions in the wizard to complete creation of your new policies.


## Create Network Policies for 802.1X Wired or Wireless with a Wizard

You can use this procedure to create the connection request policy and network policy that are required to deploy either 802.1X authenticating switches or 802.1X wireless access points as Remote Authentication Dial-In User Service (RADIUS) clients to the NPS RADIUS server.

This procedure explains how to start the New IEEE 802.1X Secure Wired and Wireless Connections wizard in NPS.

After you run the wizard, the following policies are created:

- One connection request policy
- One network policy

You can run the New IEEE 802.1X Secure Wired and Wireless Connections wizard every time you need to create new policies for 802.1X access.

Running the New IEEE 802.1X Secure Wired and Wireless Connections wizard is not the only step required to deploy 802.1X authenticating switches and wireless access points as RADIUS clients to the NPS server. Both network access methods require that you deploy additional hardware and software components.

Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure.

### To create policies for 802.1X wired or wireless with a wizard

1. Open the NPS console. If it is not already selected, click **NPS \(Local\)**. If you want to create policies on a remote NPS server, select the server.

2. In **Getting Started** and **Standard Configuration**, select **RADIUS server for 802.1X Wireless or Wired Connections**. The text and links under the text change to reflect your selection.

3. Click **Configure 802.1X using a wizard**. The New IEEE 802.1X Secure Wired and Wireless Connections wizard opens.

4. Follow the instructions in the wizard to complete creation of your new policies.

For more information about network policies, see [Network Policies](nps-np-overview.md).

For examples of pattern-matching syntax to specify network policy attributes, see [Use Regular Expressions in NPS](nps-crp-reg-expressions.md).

For more information about NPS, see [Network Policy Server (NPS)](nps-top.md).
