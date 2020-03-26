---
title: Manage QoS Policy
description: This topic provides instructions on how to create and manage Quality of Service (QoS) Policy in Windows Server 2016.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 04fdfa54-6600-43d4-8945-35f75e15275a
manager: brianlic
ms.author: lizross
author: eross-msft
---

# Manage QoS Policy

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn about using the QoS Policy wizard to create, edit, or delete a QoS Policy.

>[!NOTE]
>  In addition to this topic, the following QoS Policy management documentation is available.
> 
>  - [QoS Policy Events and Errors](qos-policy-errors.md)

In Windows operating systems, QoS Policy combines the functionality of standards-based QoS with the manageability of Group Policy. Configuration of this combination makes for easy application of QoS policies to Group Policy Objects. Windows includes a QoS Policy Wizard to help you do the following tasks.

-  [Create a QoS policy](#bkmk_createpolicy)

-  [View, edit, or delete a QoS policy](#bkmk_editpolicy)

##  <a name="bkmk_createpolicy"></a>Create a QoS policy

Before you create a QoS policy, it is important that you understand the two key QoS controls that are used to manage network traffic:

- DSCP value

-   Throttle rate

### Prioritizing traffic with DSCP

As noted in the previous line-of-business application example, you can define the priority of outbound network traffic by using **Specify DSCP Value** to configure a QoS policy with a specific DSCP value. 

As described in RFC 2474, DSCP allows values from 0 to 63 to be specified within the TOS field of an IPv4 packet and within the Traffic Class field in IPv6. Network routers use the DSCP value to classify network packets and to queue them appropriately.
  
> [!NOTE]
>  By default, Windows traffic has a DSCP value of 0.
  
The number of queues and their prioritization behavior needs to be designed as part of your organization's QoS strategy. For example, your organization may choose to have five queues: latency-sensitive traffic, control traffic, business-critical traffic, best-effort traffic, and bulk-data-transfer traffic.  
  
### Throttling traffic

Along with DSCP values, throttling is another key control for managing network bandwidth. As mentioned earlier, you can use the **Specify Throttle Rate** setting to configure a QoS policy with a specific throttle rate for outbound traffic. By using throttling, a QoS policy limits the outgoing network traffic to a specified throttle rate. Both DSCP marking and throttling can be used together to manage traffic effectively.

>[!NOTE]
>By default, the **Specify Throttle Rate** check box is not selected.

To create a QoS policy, edit the settings of a Group Policy Object (GPO) from within the Group Policy Management Console (GPMC) tool. GPMC then opens the Group Policy Object Editor.

QoS policy names must be unique. How policies are applied to servers and end users depends on where the QoS policy is stored in the Group Policy Object Editor:

- A QoS policy in Computer Configuration\Windows Settings\QoS Policy applies to computers, regardless of the user that is currently logged on. You typically use computer-based QoS policies for server computers.

- A QoS policy in User Configuration\Windows Settings\QoS Policy applies to users after they have logged on, regardless of which computer they have logged on to.

#### To create a new QoS policy with the QoS Policy wizard

-   In Group Policy Object Editor, right-click either of the **QoS Policy** nodes, and then click **Create a new policy**.

### Wizard page 1 - Policy Profile

On the first page of the QoS Policy wizard, you can specify a policy name and configure how QoS controls outgoing network traffic.

#### To configure the Policy Profile page of the QoS-based Policy wizard

1. In **Policy name**, type a name for the QoS policy. The name must uniquely identify the policy.

2. Optionally, use **Specify DSCP Value** to enable DSCP marking, and then configure a DSCP value between 0 and 63.

3. Optionally, use **Specify Throttle Rate** to enable traffic throttling and configure the throttle rate. The throttle rate value must be greater than 1 and you can specify units of kilobytes per second \(KBps\) or megabytes per second \(MBps\).

4. Click **Next**.

### Wizard page 2 - Application Name

In the second page of the QoS Policy wizard you can apply the policy to all applications, to a specific application as identified by its executable name, to a path and application name, or to the HTTP server applications that handle requests for a specific URL.

- **All applications** specifies that the traffic management settings on the first page of the QoS Policy wizard apply to all applications.

- **Only applications with this executable name** specifies that the traffic management settings on the first page of the QoS Policy wizard are for a specific application. The executable file name must end with the .exe file name extension.

- **Only HTTP server applications responding to requests for this URL** specifies that the traffic management settings on the first page of the QoS Policy wizard apply to certain HTTP server applications only.

Optionally, you can enter the application path. To specify an application path, include the path with the application name. The path can include environment variables. For example, %ProgramFiles%\My Application Path\MyApp.exe, or c:\program files\my application path\myapp.exe.

>[!NOTE]
>The application path cannot include a path that resolves to a symbolic link.

The URL must conform to  [RFC 1738](https://tools.ietf.org/html/rfc1738), in the form of `http[s]://<hostname\>:<port\>/<url-path>`. You can use a wildcard, `‘*'`, for `<hostname>` and/or `<port>`, e.g. `https://training.\*/, https://\*.\*`, but the wildcard cannot denote a substring of `<hostname>` or `<port>`.

In other words, neither `https://my\*site/` nor `https://\*training\*/` is valid. 

Optionally, you can check **Include subdirectories and files** to perform matching on all subdirectories and files following a URL. For example, if this option is checked and the URL is `https://training`, QoS Policy will consider requests for` https://training/video` a good match.

#### To configure the Application Name page of the QoS Policy wizard

1. In **This QoS policy applies to**, select either **All applications** or **Only applications with this executable name**.

2. If you select **Only applications with this executable name**, specify an executable name ending with the .exe file name extension.

3. Click **Next**.

### Wizard page 3 - IP Addresses

In the third page of the QoS Policy wizard you can specify IP address conditions for the QoS policy, including the following:

- All source IPv4 or IPv6 addresses or specific source IPv4 or IPv6 addresses

- All destination IPv4 or IPv6 addresses or specific destination IPv4 or IPv6 addresses

If you select **Only for the following source IP address** or **Only for the following destination IP address**, you must type one of the following:

- An IPv4 address, such as `192.168.1.1`

- An IPv4 address prefix using network prefix length notation, such as `192.168.1.0/24`

- An IPv6 address, such as `3ffe:ffff::1`

- An IPv6 address prefix, such as `3ffe:ffff::/48`

If you select both **Only for the following source IP address** and **Only for the following destination IP address**, both addresses or address prefixes must be either IPv4- or IPv6-based.

If you specified the URL for HTTP server applications in the previous wizard page, you'll notice that the source IP address for the QoS policy on this wizard page is grayed out. 

This is true because the source IP address is the HTTP server address and it is not configurable here. On the other hand, you can still customize the policy by specifying the destination IP address. This makes it possible for you to create different policies for different clients by using the same HTTP server applications.

#### To configure the IP Addresses page of the QoS Policy wizard

1. In **This QoS policy applies to** (source), select **Any source IP address** or **Only for the following IP source address**.

2. If you selected **Only the following IP source address**, specify an IPv4 or IPv6 address or prefix.

3. In **This QoS policy applies to** (destination), select **Any destination address** or **Only for the following IP destination address.**

4. If you selected **Only for the following IP destination address**, specify an IPv4 or IPv6 address or prefix that corresponds to the type of address or prefix specified for the source address.

5.  Click **Next**.  

### Wizard page 4 - Protocols and Ports

On the fourth page of the QoS Policy wizard, you can specify the types of traffic and the ports that are controlled by the settings on the first page of the wizard. You can specify:  
-   TCP traffic, UDP traffic, or both  

-   All source ports, a range of source ports, or a specific source port

-   All destination ports, a range of destination ports, or a specific destination port  

#### To configure the Protocols and Ports page of the QoS Policy wizard

1. In **Select the protocol this QoS policy applies to**, select **TCP**, **UDP**, or **TCP and UDP**.

2. In **Specify the source port number**, select **From any source port** or **From this source port number**.

3. If you selected **From this source port number**, type a port number between 1 and 65535.

     Optionally, you can specify a port range, in the format of "*Low*:*High*," where *Low* and *High* represent the lower bounds and upper bounds of the port range, inclusively. *Low* and *High* each must be a number between 1 and 65535. No space is allowed between the colon (:) character and the numbers.

4. In **Specify the destination port number**, select **To any destination port** or **To this destination port number**.

5. If you selected **To this destination port number** in the previous step, type a port number between 1 and 65535.

To complete the creation of the new QoS policy, click **Finish** on the **Protocols and Ports** page of the QoS Policy wizard. When completed, the new QoS policy is listed in the details pane of the Group Policy Object Editor.  
  
To apply the QoS policy settings to users or computers, link the GPO in which the QoS policies are located to an Active Directory Domain Services container, such as a domain, a site, or an organizational unit (OU).  
  
##  <a name="bkmk_editpolicy"></a>View, Edit, or Delete a QoS Policy

The pages of the QoS Policy wizard described previously correspond to the properties pages that are displayed when you view or edit the properties of a policy.  
  
### To view the properties of a QoS policy  
  
-   Right-click the policy name in the details pane of the Group Policy Object Editor, and then click **Properties**.  
  
     The Group Policy Object Editor displays the properties page with the following tabs:  
  
    -   Policy Profile  
  
    -   Application Name  
  
    -   IP Addresses  
  
    -   Protocols and Ports  
  
### To edit a QoS policy  
  
-   Right-click the policy name in the details pane of the Group Policy Object Editor, and then click **Edit existing policy**.  
  
     The Group Policy Object Editor displays the **Edit an existing QoS policy** dialog box.  
  
### To delete a QoS policy  
  
-   Right-click the policy name in the details pane of the Group Policy Object Editor, and then click **Delete policy**.  
  
### QoS Policy GPMC Reporting 

After you have applied a number of QoS policies across your organization, it may be useful or necessary to periodically review how the policies are applied. A summary of the QoS policies for a specific user or computer can be viewed by using GPMC reporting.  
  
#### To run the Group Policy Results Wizard for a report of QoS policies  
  
-   In GPMC, right-click the **Group Policy Results** node, and then select the menu option for **Group Policy Results Wizard.**  
  
After Group Policy results are generated, click the **Settings** tab. On the **Settings** tab, the QoS policies can be found under the "Computer Configuration\Windows Settings\QoS Policy" and "User Configuration\Windows Settings\QoS Policy" nodes.  
  
On the **Settings** tab, the QoS policies are listed by their QoS policy names with their DSCP value, throttle rate, policy conditions, and winning GPO listed in the same row..  
  
The Group Policy results view uniquely identifies the winning GPO. When multiple GPOs have QoS policies with the same QoS policy name, the GPO with the highest GPO precedence is applied. This is the winning GPO. Conflicting QoS policies (identified by policy name) that are attached to a lower priority GPO are not applied. Note the GPO priorities define which QoS policies are deployed in the site, domain, or OU, as appropriate. After deployment, at a user or computer level, the [QoS Policy Precedence Rules](#BKMK_precedencerules) determine which traffic is allowed and blocked.  
  
The QoS policy's DSCP value, throttle rate, and policy conditions are also visible in Group Policy Object Editor (GPOE)  
  
### Advanced settings for roaming and remote users  
With QoS Policy, the goal is to manage traffic on an enterprise's network. In mobile scenarios, users might be sending traffic on or off the enterprise network. Because QoS policies are not relevant while away from the enterprise's network, QoS policies are enabled only on network interfaces that are connected to the enterprise for Windows 8, Windows 7, or Windows Vista.  
  
For example, a user might connect her portable computer to her enterprise's network via virtual private network (VPN) from a coffee shop. For VPN, the physical network interface (such as wireless) will not have QoS policies applied. However, the VPN interface will have QoS policies applied because it connects to the enterprise. If the user later enters another enterprise's network that does not have an AD DS trust relationship, QoS policies will not be enabled.  
  
Note that these mobile scenarios do not apply to server workloads. For example, a server with multiple network adapters might sit on the edge of an enterprise's network. The IT department might choose to have QoS policies throttle traffic that egresses the enterprise; however, this network adapter that sends this egress traffic does not necessarily connect back to the enterprise network. For this reason, QoS policies are always enabled on all network interfaces of a computer running Windows Server 2012.  
  
> [!NOTE]
>  Selective enablement only applies to QoS policies and not to the Advanced QoS settings discussed next in this document.  
  
### Advanced QoS settings

Advanced QoS settings provide additional controls for IT administrators to manage computer network consumption and DSCP markings. Advanced QoS settings apply only at the computer level, whereas QoS policies can be applied at both the computer and user levels.

#### To configure advanced QoS settings

1.  Click **Computer Configuration**, and then click **Windows Settings in Group Policy**.
  
2.  Right-click **QoS Policy**, and then click **Advanced QoS Settings**.

     The following figure shows the two advanced QoS settings tabs: **Inbound TCP Traffic** and **DSCP Marking Override**.
  
> [!NOTE]
>  Advanced QoS Settings are computer-level Group Policy settings.
  
#### Advanced QoS settings: inbound TCP traffic

**Inbound TCP Traffic** controls the TCP bandwidth consumption on the receiver's side, whereas QoS policies affect the outbound TCP and UDP traffic. 

By setting a lower throughput level on the **Inbound TCP Traffic** tab, TCP will limit the size of its advertised TCP receive window. The effect of this setting will be increased throughput rates and link utilization for TCP connections with higher bandwidths or latencies (bandwidth delay product). By default, computers running Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows Server 2008, and Windows Vista are set to the maximum throughput level.
  
The TCP receive window has changed in Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows Server 2008, and Windows Vista from previous versions of Windows. Previous versions of Windows limited the TCP receive-side window to a maximum of 64 kilobytes (KB), whereas Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows Server 2008, and Windows Vista dynamically size the receive-side window up to 16 megabytes (MB). In the Inbound TCP Traffic control, you can control the inbound throughput level by setting the maximum value to which the TCP receive-window can grow. The levels correspond to the following maximum values. 
  
|Inbound throughput level|Maximum|  
|------------------------|-------|  
|0|64 KB|
|1|256 KB|
|2|1 MB|
|3|16 MB|

The actual window size may be a value equal to or smaller than the maximum, depending on network conditions.

###### To set the TCP receive-side window

1. In Group Policy Object Editor, click **Local Computer Policy**, click **Windows Settings**, right click **QoS Policy**, and then click **Advanced QoS Settings**.
  
2. In **TCP Receiving Throughput**, select **Configure TCP Receiving Throughput**, and then select the level of throughput that you want.

3.  Link the GPO to the OU.

#### Advanced QoS settings: DSCP Marking Override

DSCP Marking Override restricts the ability of applications to specify—or "mark"—DSCP values other than those specified in QoS policies. By specifying that applications are allowed to set DSCP values, applications can set non-zero DSCP values. 

By specifying **Ignore**, applications that use QoS APIs will have their DSCP values set to zero, and only QoS policies can set DSCP values. 

By default, computers running Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows Server 2008, and Windows Vista allow applications to specify DSCP values; applications and devices that do not use the QoS APIs are not overridden.

##### Wireless Multimedia and DSCP values

The [Wi-Fi Alliance](https://go.microsoft.com/fwlink/?LinkId=160769) has established a certification for Wireless Multimedia \(WMM\) that defines four access categories \(WMM_AC\) for prioritizing network traffic transmitted on a Wi\-Fi wireless network. The access categories include \(in order of highest-to-lowest priority\): voice, video, best effort, and background; respectively abbreviated as VO, VI, BE, and BK. The WMM specification defines which DSCP values correspond with each of the four access categories:
  
|DSCP Value|WMM Access Category|
|----------|-------------------|
|48-63|Voice (VO)|
|32-47|Video (VI)|
|24-31, 0-7|Best effort (BE)|
|8-23|Background (BK)|

You can create QoS policies that use these DSCP values to ensure that portable computers with Wi\-Fi Certified™ for WMM wireless adapters receive prioritized handling when associated with Wi\-Fi Certified for WMM access points.
  
### <a name="BKMK_precedencerules"></a>QoS Policy Precedence Rules

Similar to GPO's priorities, QoS policies have precedence rules to resolve conflicts when multiple QoS policies apply to a specific set of traffic. For outbound TCP or UDP traffic, only one QoS policy can be applied at a time, which means that QoS policies do not have a cumulative effect, such as where throttle rates would be summed.

In general, the QoS policy with the most matching conditions wins. When multiple QoS policies apply, the rules fall into three categories: user-level versus computer-level; application versus the network quintuple; and among the network quintuple.

By *network quintuple*, we mean the source IP address, destination IP address, source port, destination port, and protocol \(TCP/UDP\).  

 **User-level QoS policy takes precedence over computer-level QoS policy**

This rule greatly facilitates network administrators' management of QoS GPOs, particularly for user group–based policies. For example, if the network admin wants to define a QoS policy for a user group, they can just create and distribute a GPO to that group. They don't have to worry about which computers those users are logged on to and whether those computers will have conflicting QoS policies defined, because, if a conflict exists, the user-level policy always takes precedence.

> [!NOTE]
>  A user-level QoS policy is only applicable to traffic that is generated by that user. Other users of a specific computer, and the computer itself, will not be subject to any QoS policies that are defined for that user.

 **Application specificity and taking precedence over network quintuple**

When multiple QoS policies match the specific traffic, the more specific policy is applied. Among policies that identify applications, a policy that includes the sending application's file path is considered more specific than another policy that only identifies the application name (no path). If multiple policies with applications still apply, the precedence rules use the network quintuple to find the best match.

Alternatively, multiple QoS policies might apply to the same traffic by specifying non-overlapping conditions. Between the conditions of applications and the network quintuple, the policy that specifies the application is considered more specific and is applied. 

For example, policy_A only specifies an application name (app.exe), and policy_B specifies the destination IP address 192.168.1.0/24. When these QoS policies conflict \(app.exe sends traffic to an IP address within the range of 192.168.4.0/24\), policy_A gets applied.

 **More specificity takes precedence within the network quintuple**

For policy conflicts within the network quintuple, the policy with the most matching conditions takes precedence. For example, assume policy_C specifies source IP address "any", destination IP address 10.0.0.1, source port "any", destination port "any", and protocol "TCP". 

Next, assume policy_D specifies source IP address "any", destination IP address 10.0.0.1, source port "any", destination port 80, and protocol "TCP". Then policy_C and policy_D both match connections to destination 10.0.0.1:80. Because QoS Policy applies the policy with the most specific matching conditions, policy_D takes precedence in this example.  
  
However, QoS policies might have an equal number of conditions. For example, several policies may each specify only one (but not the same) piece of the network quintuple. Among the network quintuple, the following order is from higher to lower precedence:

- Source IP address

- Destination IP address

- Source port

- Destination port

- Protocol (TCP or UDP)

Within a specific condition, such as IP address, a more specific IP address is treated with higher precedence; for example, an IP address 192.168.4.1 is more specific than 192.168.4.0/24.

Design your QoS policies as specifically as possible to simplify your organization's ability to understand which policies are in effect.

For the next topic in this guide, see [QoS Policy Events and Errors](qos-policy-errors.md).

For the first topic in this guide, see [Quality of Service (QoS) Policy](qos-policy-top.md).
