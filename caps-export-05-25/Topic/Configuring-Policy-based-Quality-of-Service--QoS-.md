---
title: Configuring Policy-based Quality of Service (QoS)
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b691ee7f-a2a2-40aa-9118-df2eb5d6e7d8
author: vhorne
---
# Configuring Policy-based Quality of Service (QoS)
Quality of Service \(QoS\) for networks is an industry\-wide set of standards and mechanisms for ensuring high\-quality performance for critical applications. By using QoS mechanisms, network administrators can use existing resources efficiently and ensure the required level of service without reactively expanding or over\-provisioning their networks.  
  
In Windows, policy\-based QoS combines the functionality of standards\-based QoS with the manageability of Group Policy. This combination allows for easy application of QoS policies to Group Policy Objects. Windows includes a Policy\-based QoS Wizard to help you configure QoS in Group Policy.  
  
This topic contains the following sections:  
  
-   [QoS policies overview](#BKMK_TOP)  
  
-   [Create a QoS policy](#BKMK_ConfigQoS)  
  
    -   [Policy Profile \- Wizard page 1](#BKMK_Cfg_QoS_Wiz1)  
  
    -   [Application Name \- Wizard page 2](#BKMK_Cfg_QoS_Wiz2)  
  
    -   [IP Addresses \- Wizard page 3](#BKMK_Cfg_QoS_Wiz3)  
  
    -   [Protocols and Ports \- Wizard page 4](#BKMK_Cfg_QoS_Wiz4)  
  
-   [View, edit, or delete a QoS policy](#BKMK_ViewEditDelete)  
  
-   [Additional resources](#BKMK_AddlRes)  
  
## <a name="BKMK_TOP"></a>QoS policies overview  
To create a QoS policy, edit the settings of a Group Policy Object \(GPO\) from within the Group Policy Management Console \(GPMC\). QoS policy names must be unique. Behavior depends on where the QoS policy is stored in the GPMC:  
  
-   A QoS policy in Computer Configuration\\Windows Settings\\Policy\-based QoS applies to computers, regardless of the user that is currently logged on. You typically use computer\-based QoS policies for server computers.  
  
-   A QoS policy in User Configuration\\Windows Settings\\Policy\-based QoS applies to users after they have logged on, regardless of which computer they have logged on to.  
  
### Prioritizing traffic by using DSCP  
To define the priority of outbound network traffic, use **Specify DSCP Value** to configure a QoS policy with a specific Differentiated Services Code Point \(DSCP\) value. As described in RFC 2474, DSCP allows values from 0 to 63 to be specified within the Type of Service \(TOS\) field of an IPv4 packet. Network routers use the DSCP value to classify network packets and determine the appropriate queue. A higher value indicates a higher priority for the packet. By default, the **Specify DSCP Value** check box is selected and its value is 0.  
  
The number of queues and their prioritization behavior needs to be designed as part of your organization's QoS strategy. For example, you can create four QoS policies so that packets with specific DSCP values are kept in five queues: latency\-sensitive traffic, control traffic, business critical traffic, best effort traffic, and bulk data transfer traffic.  
  
### Throttling traffic  
To manage the use of network bandwidth, you can use **Specify Throttle Rate** to configure a QoS policy with a throttle rate for outbound traffic. By default, the **Specify Throttle Rate** check box is not selected. With throttling, a QoS policy will limit the outgoing network traffic to a specified rate. Both DSCP marking and throttling can be used together to manage traffic effectively.  
  
## <a name="BKMK_ConfigQoS"></a>Create a QoS policy  
  
#### To create a new QoS policy with the Policy\-based QoS wizard  
  
-   In the Group Policy Management Console, right\-click either of the **Policy\-based QoS** nodes, and then click **Create a new policy**.  
  
### <a name="BKMK_Cfg_QoS_Wiz1"></a>Policy Profile \- Wizard page 1  
On the first page of the Policy\-based QoS wizard, you can specify a policy name and configure how QoS will control outgoing network traffic.  
  
##### To configure the Policy Profile page of the QoS\-based Policy wizard  
  
1.  In **Policy name**, type a name for the QoS policy. The name must uniquely identify the policy within the GPO node of its creation.  
  
2.  Optionally, use **Specify DSCP Value** to enable DSCP marking and configure a DSCP value between 0 and 63.  
  
3.  Optionally, use **Specify Throttle Rate** to enable traffic throttling and configure the throttle rate. The throttle rate value must be greater than 1 and you can specify units of kilobytes per second \(KBps\) or megabytes per second \(MBps\).  
  
4.  Click **Next**.  
  
[\(Back to the top of the page\)](#BKMK_TOP)  
  
### <a name="BKMK_Cfg_QoS_Wiz2"></a>Application Name \- Wizard page 2  
The second page of the Policy\-based QoS wizard allows you to apply the policy to all applications, to a specific application as identified by its executable name, or to a path and application name. **All applications** specifies that the traffic management settings on the first page of the Policy\-based QoS wizard apply to all applications. **Only applications with this executable name** specifies that the traffic management settings on the first page of the Policy\-based QoS wizard are for a specific application. The executable file name and must end with the .exe file name extension.  
  
Optionally, you can enter the application path. To specify an application path, include the path with the application name. The path may include environment variables. For example, %ProgramFiles%\\My Application Path\\MyApp.exe, or c:\\program files\\my application path\\myapp.exe. Note the application path cannot include a symbolic link.  
  
##### To configure the Application Name page of the Policy\-based QoS wizard  
  
1.  Under **This QoS policy applies to** select either **All applications** or **Only applications with this executable name**.  
  
2.  If you select **Only applications with this executable name**, specify an executable name ending with the .exe file name extension.  
  
3.  Click **Next**.  
  
[\(Back to the top of the page\)](#BKMK_TOP)  
  
### <a name="BKMK_Cfg_QoS_Wiz3"></a>IP Addresses \- Wizard page 3  
The third page of the Policy\-based QoS wizard allows you to specify that the traffic management settings specified on the first page of the Policy\-based QoS wizard apply to the following:  
  
-   All source IPv4 or IPv6 addresses or specific source IPv4 or IPv6 addresses  
  
-   All destination IPv4 or IPv6 addresses or specific destination IPv4 or IPv6 addresses.  
  
If you select **Only for the following source IP address** or **Only for the following destination IP address**, you must type one of the following:  
  
-   An IPv4 address, such as 192.168.1.1  
  
-   An IPv4 address prefix using network prefix length notation, such as 192.168.1.0\/24  
  
-   An IPv6 address, such as 3ffe:ffff::1  
  
-   An IPv6 address prefix, such as 3ffe:ffff::\/48  
  
If you select both **Only for the following source IP address** and **Only for the following destination IP address**, both addresses or address prefixes must be either IPv4 or IPv6\-based.  
  
##### To configure the IP Addresses page of the Policy\-based QoS wizard  
  
1.  In **This QoS policy applies to** \(source\), select **Any source IP address** or **Only for the following IP source address**.  
  
2.  If you selected **Only the following IP source address:**, specify an IPv4 or IPv6 address or prefix.  
  
3.  In **This QoS policy applies to** \(destination\), select **Any destination address**, or **Only for the following IP destination address.**  
  
4.  If you selected **Only for the following IP destination address:**, specify an IPv4 or IPv6 address or prefix that corresponds to the type of address or prefix specified for the source address.  
  
5.  Click **Next**.  
  
[\(Back to the top of the page\)](#BKMK_TOP)  
  
### <a name="BKMK_Cfg_QoS_Wiz4"></a>Protocols and Ports \- Wizard page 4  
On the fourth page of the Policy\-based QoS wizard you can specify the types of traffic and the ports that are controlled by the settings on the first page of the wizard. You can specify:  
  
-   TCP traffic, UDP traffic, or both  
  
-   All source ports, a range of source ports, or a specific source port  
  
-   All destination ports or a specific destination port  
  
##### To configure the Protocols and Ports page of the Policy\-based QoS wizard  
  
1.  In **Select the protocol this QoS policy applies to**, select **TCP**, **UDP**, or **TCP and UDP**.  
  
2.  In **Specify the source port number**, select **From any source port** or **From this source port number**.  
  
3.  If you selected **From this source port number** in the previous step, type a port number between 1 and 65535. Optionally, you can specify a port range, in the format of "Low:High," where Low and High represent the lower bounds and upper bounds of the port range, inclusively. Low and High each must be a number between 1 and 65535. No space is allowed between the colon \(:\) character and the numbers.  
  
4.  In **Specify the destination port number**, select **To any destination port** or **To this destination port number**.  
  
5.  If you selected **To this destination port number** in the previous step, type a port number between 1 and 65535.  
  
To complete the creation of the new QoS policy, click **Finish** on the Protocols and Ports page of the Policy\-based QoS wizard. When completed, the new QoS policy is listed in the details pane of the GPMC.  
  
To apply the QoS policy settings to users or computer, link the GPO in which the QoS policies are located to an Active Directory container, such as a domain, a site, or an organizational unit \(OU\).  
  
[\(Back to the top of the page\)](#BKMK_TOP)  
  
## <a name="BKMK_ViewEditDelete"></a>View, edit, or delete a QoS policy  
The pages of the Policy\-based QoS wizard described above correspond to the properties pages that are displayed when you view the properties of a policy or edit the policy.  
  
#### To view the properties of a QoS policy  
  
-   Right\-click the policy name in the details pane of the Group Policy Management Console, and then click **Properties**.  
  
    The GPMC displays the properties page with the following tabs:  
  
    -   Policy Profile  
  
    -   Application Name  
  
    -   IP Addresses  
  
    -   Protocols and Ports  
  
#### To edit a QoS policy  
  
-   Right\-click the policy name in the details pane of the Group Policy Management Console, and then click **Edit existing policy**.  
  
    The GPMC displays the **Edit an existing QoS policy** dialog box.  
  
#### To delete a QoS policy  
  
-   Right\-click the policy name in the details pane of the Group Policy Management Console, and then click **Delete policy**.  
  
[\(Back to the top of the page\)](#BKMK_TOP)  
  
## <a name="BKMK_AddlRes"></a>Additional resources  
  
-   For more information about QoS, see the [Windows Server TechCenter](http://go.microsoft.com/fwlink/?LinkId=65245) Web site at http:\/\/go.microsoft.com\/fwlink\/?LinkId\=65245.  
  
-   For more about Policy\-based QoS, see the [Cable Guy article](http://go.microsoft.com/fwlink/?LinkId=65246) on the Microsoft Web site at http:\/\/go.microsoft.com\/fwlink\/?LinkId\=65246.  
  
