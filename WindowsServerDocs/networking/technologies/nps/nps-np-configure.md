---
title: Configure Network Policies
description: This topic provides an overview of network policy configuration for Network Policy Server in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: fe77655a-e2be-4949-92e1-aaaa215d86ea
ms.author: lizross 
author: eross-msft
---

# Configure Network Policies

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

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

### To add a network policy 

1. Open the NPS console, and then double-click **Policies**.

2. In the console tree, right-click **Network Policies**, and click **New**. The New Network Policy wizard opens.

3. Use the New Network Policy wizard to create a policy.

## Create Network Policies for Dial-Up or VPN with a Wizard

You can use this procedure to create the connection request policies and network policies required to deploy either dial-up servers or virtual private network \(VPN\) servers as Remote Authentication Dial-In User Service \(RADIUS\) clients to the NPS RADIUS server.

>[!NOTE]
>Client computers, such as laptop computers and other computers running client operating systems, are not RADIUS clients. RADIUS clients are network access servers — such as wireless access points, 802.1X authenticating switches, virtual private network \(VPN\) servers, and dial-up servers — because these devices use the RADIUS protocol to communicate with RADIUS servers such as NPSs.

This procedure explains how to open the New Dial-up or Virtual Private Network Connections wizard in NPS.

After you run the wizard, the following policies are created:

- One connection request policy
- One network policy

You can run the New Dial-up or Virtual Private Network Connections wizard every time you need to create new policies for dial-up servers and VPN servers.

Running the New Dial-up or Virtual Private Network Connections wizard is not the only step required to deploy dial-up or VPN servers as RADIUS clients to the NPS. Both network access methods require that you deploy additional hardware and software components.

Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure.

### To create policies for dial-up or VPN with a wizard

1. Open the NPS console. If it is not already selected, click **NPS \(Local\)**. If you want to create policies on a remote NPS, select the server.

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

Running the New IEEE 802.1X Secure Wired and Wireless Connections wizard is not the only step required to deploy 802.1X authenticating switches and wireless access points as RADIUS clients to the NPS. Both network access methods require that you deploy additional hardware and software components.

Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure.

### To create policies for 802.1X wired or wireless with a wizard

1. On the NPS, in Server Manager, click **Tools**, and then click **Network Policy Server**. The NPS console opens. 

2. If it is not already selected, click **NPS \(Local\)**. If you want to create policies on a remote NPS, select the server.

3. In **Getting Started** and **Standard Configuration**, select **RADIUS server for 802.1X Wireless or Wired Connections**. The text and links under the text change to reflect your selection.

4. Click **Configure 802.1X using a wizard**. The New IEEE 802.1X Secure Wired and Wireless Connections wizard opens.

5. Follow the instructions in the wizard to complete creation of your new policies.

## Configure NPS to Ignore User Account Dial-in Properties

Use this procedure to configure an NPS network policy to ignore the dial-in properties of user accounts in Active Directory during the authorization process. User accounts in Active Directory Users and Computers have dial-in properties that NPS evaluates during the authorization process unless the **Network Access Permission** property of the user account is set to **Control access through NPS Network Policy**. 

There are two circumstances where you might want to configure NPS to ignore the dial-in properties of user accounts in Active Directory:

- When you want to simplify NPS authorization by using network policy, but not all of your user accounts have the **Network Access Permission** property set to **Control access through NPS Network Policy**. For example, some user accounts might have the **Network Access Permission** property of the user account set to **Deny access** or **Allow access**.

- When other dial-in properties of user accounts are not applicable to the connection type that is configured in the network policy. For example, properties other than the **Network Access Permission** setting are applicable only to dial-in or VPN connections, but the network policy you are creating is for wireless or authenticating switch connections.

You can use this procedure to configure NPS to ignore user account dial-in properties. If a connection request matches the network policy where this check box is selected, NPS does not use the dial-in properties of the user account to determine whether the user or computer is authorized to access the network; only the settings in the network policy are used to determine authorization.

Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure.

1. On the NPS, in Server Manager, click **Tools**, and then click **Network Policy Server**. The NPS console opens.

2. Double-click **Policies**, click **Network Policies**, and then in the details pane double-click the policy that you want to configure.

3. In the policy **Properties** dialog box, on the **Overview** tab, in **Access Permission**, select the **Ignore user account dial-in properties** check box, and then click **OK**.

### To configure NPS to ignore user account dial-in properties



## Configure NPS for VLANs

By using VLAN-aware network access servers and NPS in Windows Server 2016, you can provide groups of users with access only to the network resources that are appropriate for their security permissions. For example, you can provide visitors with wireless access to the Internet without allowing them access to your organization network. 

In addition, VLANs allow you to logically group network resources that exist in different physical locations or on different physical subnets. For example, members of your sales department and their network resources, such as client computers, servers, and printers, might be located in several different buildings at your organization, but you can place all of these resources on one VLAN that uses the same IP address range. The VLAN then functions, from the end-user perspective, as a single subnet.

You can also use VLANs when you want to segregate a network between different groups of users. After you have determined how you want to define your groups, you can create security groups in the Active Directory Users and Computers snap-in, and then add members to the groups.

### Configure a Network Policy for VLANs

You can use this procedure to configure a network policy that assigns users to a VLAN. When you use VLAN-aware network hardware, such as routers, switches, and access controllers, you can configure network policy to instruct the access servers to place members of specific Active Directory groups on specific VLANs. This ability to group network resources logically with VLANs provides flexibility when designing and implementing network solutions.

When you configure the settings of an NPS network policy for use with VLANs, you must configure the attributes **Tunnel-Medium-Type**, **Tunnel-Pvt-Group-ID**, **Tunnel-Type**, and **Tunnel-Tag**. 

This procedure is provided as a guideline; your network configuration might require different settings than those described below.

Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure.

### To configure a network policy for VLANs

1. On the NPS, in Server Manager, click **Tools**, and then click **Network Policy Server**. The NPS console opens.

2. Double-click **Policies**, click **Network Policies**, and then in the details pane double-click the policy that you want to configure.

3. In the policy **Properties** dialog box, click the **Settings** tab.

4. In policy **Properties**, in **Settings**, in **RADIUS Attributes**, ensure that **Standard** is selected.

5. In the details pane, in **Attributes**, the **Service-Type** attribute is configured with a default value of **Framed**. By default, for policies with access methods of VPN and dial-up, the **Framed-Protocol** attribute is configured with a value of **PPP**. To specify additional connection attributes required for VLANs, click **Add**. The **Add Standard RADIUS Attribute** dialog box opens.

6. In **Add Standard RADIUS Attribute**, in Attributes, scroll down to and add the following attributes:

	- **Tunnel-Medium-Type**. Select a value appropriate to the previous selections you have made for the policy. For example, if the network policy you are configuring is a wireless policy, select **Value: 802 (Includes all 802 media plus Ethernet canonical format)**.

	- **Tunnel-Pvt-Group-ID**. Enter the integer that represents the VLAN number to which group members will be assigned. 

	- **Tunnel-Type**. Select **Virtual LANs (VLAN)**.


7. In **Add Standard RADIUS Attribute**, click **Close**. 

8. If your network access server (NAS) requires use of the **Tunnel-Tag** attribute, use the following steps to add the **Tunnel-Tag** attribute to the network policy. If your NAS documentation does not mention this attribute, do not add it to the policy. If required, add the attributes as follows:

	- In policy **Properties**, in **Settings**, in **RADIUS Attributes**, click **Vendor Specific**. 

	- In the details pane, click **Add**. The **Add Vendor Specific Attribute** dialog box opens.

	- In **Attributes**, scroll down to and select **Tunnel-Tag**, and then click **Add**. The **Attribute Information** dialog box opens. 

	- In **Attribute value**, type the value that you obtained from your hardware documentation.

## Configure the EAP Payload Size

In some cases, routers or firewalls drop packets because they are configured to discard packets that require fragmentation.

When you deploy NPS with network policies that use the Extensible Authentication Protocol \(EAP\) with Transport Layer Security \(TLS\), or EAP-TLS, as an authentication method, the default maximum transmission unit \(MTU\) that NPS uses for EAP payloads is 1500 bytes. 

This maximum size for the EAP payload can create RADIUS messages that require fragmentation by a router or firewall between the NPS and a RADIUS client. If this is the case, a router or firewall positioned between the RADIUS client and the NPS might silently discard some fragments, resulting in authentication failure and the inability of the access client to connect to the network.

Use the following procedure to lower the maximum size that NPS uses for EAP payloads by adjusting the Framed-MTU attribute in a network policy to a value no greater than 1344.

Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure.

### To configure the Framed-MTU attribute

1. On the NPS, in Server Manager, click **Tools**, and then click **Network Policy Server**. The NPS console opens.
 
2. Double-click **Policies**, click **Network Policies**, and then in the details pane double-click the policy that you want to configure.

3. In the policy **Properties** dialog box, click the **Settings** tab.

4. In **Settings**, in **RADIUS Attributes**, click **Standard**. In the details pane, click **Add**. The **Add Standard RADIUS Attribute** dialog box opens.

5. In **Attributes**, scroll down to and click **Framed-MTU**, and then click **Add**. The **Attribute Information** dialog box opens.

6. In **Attribute Value**, type a value equal to or less than **1344**. Click **OK**, click **Close**, and then click **OK**.



For more information about network policies, see [Network Policies](nps-np-overview.md).

For examples of pattern-matching syntax to specify network policy attributes, see [Use Regular Expressions in NPS](nps-crp-reg-expressions.md).

For more information about NPS, see [Network Policy Server (NPS)](nps-top.md).
