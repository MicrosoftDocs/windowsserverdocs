---
title: Policy-based Quality of Service (QoS)
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fbc54838-8aeb-4ddf-912b-bb44aadaf4c4
---
# Policy-based Quality of Service (QoS)
  
> [!NOTE]  
> In addition to this topic, the following Policy\-based QoS documentation is also available.  
>   
> -   [Configuring Policy-based Quality of Service &#40;QoS&#41;](../Topic/Configuring-Policy-based-Quality-of-Service--QoS-.md)  
  
As traffic increases on a network, it becomes increasingly important for IT departments to balance network performance with the cost of service. However, network traffic is not easily prioritized and managed. Mission\-critical and latency\-sensitive applications must compete for bandwidth against lower priority traffic. At the same time, some users and computers with specific network performance requirements might require differentiated service levels.  
  
Such challenges of providing cost\-effective, predictable network performance levels often first appear over wide area network \(WAN\) connections or with latency\-sensitive applications, like voice over IP \(VoIP\) and video. However, the end\-goal of providing predictable network service levels applies to any network environment \(for example, an enterprises’ local area network\), and to more than VoIP applications, such as your company's custom line\-of\-business applications.  
  
For computers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], you can use Policy\-based Quality of Service \(QoS\) to manage traffic to offer better user experiences, control bandwidth costs, or more finely negotiate service levels with bandwidth providers or business departments. Policy\-based QoS provides network control based on applications, users, and computers. Applications do not need to be written for specific application programming interfaces \(APIs\), providing you with the ability to use QoS with existing applications. Additionally, Policy\-based QoS takes advantage of your existing management infrastructure, because Policy\-based QoS is built into Group Policy.  
  
You can specify QoS policies that define priority through a Differentiated Services Code Point \(DSCP\) value. The DSCP applies a value \(0–63\) within the Type of Service \(TOS\) field in an IPv4 packet's header and within the Traffic Class field in IPv6. This DSCP value provides classification at the Internet Protocol \(IP\) level, which routers can use to decide queuing behavior. You can also limit an application's outbound network traffic by specifying a throttle rate.  
  
For example, you can configure routers to place packets with specific DSCP values into one of three queues: high\-priority, best\-effort, or lower\-than\-best effort. Therefore, mission\-critical network traffic, which is in the high\-priority queue, gets preference before other traffic. The QoS policy that defines throttling limits the rate of outbound network traffic. For example, an IT department might implement a service level agreement that specifies that a file server can never provide downloads beyond a specific rate to manage WAN costs.  
  
You can also use Policy\-based QoS to apply DSCP values and throttle rates for outbound network traffic to the following:  
  
-   Sending application and directory path  
  
-   Source and destination IP addresses, including support for address prefixes  
  
-   Source and destination ports and port ranges  
  
-   Protocol \(Transmission Control Protocol \[TCP\] and User Datagram Protocol \[UDP\]\)  
  
-   Specific groups of users or computers \(through deployment in Group Policy\)  
  
By using these controls, you can specify a QoS policy with a DSCP value of 46 for a VoIP application, enabling routers to place those packets in a low\-latency queue, or you can use a QoS policy to throttle a set of servers' outbound traffic to 512 kilobytes per second \(KBps\) when sending from TCP port 443. Or, as in the expanded example in the next section, QoS policy can be applied to a particular application that has special bandwidth requirements.  
  
## Advantages of Policy\-based QoS  
With Policy\-based QoS, IT administrators can configure and enforce QoS policies that cannot be configured on routers and switches.  
  
1.  **Level of detail:** It is difficult to create user\-level QoS policies on routers or switches, especially if the user’s computer is either configured by using dynamic IP address assignment or if the computer is not connected to fixed switch or router ports, as is frequently the case with portable computers. In contrast, Policy\-based QoS  makes it easier to configure a user\-level QoS policy on a domain controller and propagate it to the user’s computer, regardless of where or how the computer connects to the network. For example, you can configure a user\-level QoS policy that will apply to a computer, no matter where the user logs on: for example, in either a main office or in a branch office. Similarly, the same user level QoS policy will apply no matter how the user connects to the network: for example, by either the wired Ethernet network or by Wi\-Fi.  
  
2.  **Security:** If your IT department encrypts users’ traffic from end to end by using Internet Protocol security \(IPsec\), you cannot classify the traffic on routers based on any information above the IP layer in the packet \(for example, a TCP port\). However, by using Policy\-based QoS, you can classify packets at the end device to indicate the priority of the packets in the IP header before the IP payloads are encrypted and the packets sent out.  
  
3.  **Performance:** Some QoS functions, such as throttling, are better performed when they are closer to the source. Policy\-based QoS moves such QoS functions to where they can be closest to the source.  
  
4.  **Manageability:** Policy\-based QoS enhances the network manageability in two ways:  
  
    -   First, because it is based on Group Policy, you can use Policy\-based QoS to configure and manage a set of user\/computer QoS policies whenever necessary, and on one central domain\-controller computer.  
  
    -   Second, Policy\-based QoS facilitates user\/computer configuration by providing a mechanism to specify policies by URL, as opposed to specifying policies based on the IP addresses of each of the servers where QoS policies need to be applied.  
  
    For example, assume your network has a cluster of servers that share a common URL. By using Policy\-based QoS, you need only to create one policy based on that common URL, as opposed to creating one policy for each server in the cluster, with each policy based on the IP address of each server.  
  
## Scenario 1: Prioritizing a line\-of\-business application  
In this scenario, an IT department adds QoS to provide better network performance for a key set of users and the mission\-critical applications users depend on, but also needs to minimize the WAN link costs. The IT department decides to prioritize specific applications by using DSCP values to classify network traffic, and to configure its routers to provide preferential treatment for higher priority traffic. Later, they might consider using this classification to negotiate service levels for the leased WAN links.  
  
In addition to DSCP values, the QoS policies can specify a throttle rate. Throttling limits all outbound traffic that matched the QoS policy to a specific send rate.  
  
The first mission\-critical application to use Policy\-based QoS is a company\-wide enterprise resource planning \(ERP\) application. The ERP application is hosted on several computers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] in the data center, which are part of an organization unit \(OU\) for computers. While many groups within the company access the ERP application, the finance group requires differentiated performance, because the finance group depends on this application when dealing with customers. The client\-side component for the ERP application is installed on computers running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)].  
  
The following example illustrates the clients and servers in a prioritization scenario. The subsequent section titled "[Configuring Policy\-based QoS](#BKMK_configuring)" walks through the wizard steps for creating QoS policies. In this example, the IT administrator selects the Group Policy Object \(GPO\) on which the QoS policy will be deployed. Through the QoS policy wizard, the IT administrator creates a QoS policy for the group of servers called "Server LOB policy" that specifies a high\-priority DSCP value of 44 for all applications, any IP address, TCP and UDP, and port number. The QoS policy is applied only to the line\-of\-business \(LOB\) servers by linking the GPO to the OU that contains only these servers, via the Group Policy Management Console \(GPMC\) tool. This initial server LOB policy applies the high\-priority DSCP value whenever the computer sends network traffic. This QoS policy can later be edited \(in the Group Policy Object Editor tool\) to include the ERP application's port numbers, which limits the policy to apply only when the specified port number is used.  
  
To ensure that the finance group can support their customers, a QoS policy needs to classify these users' traffic as higher priority. However, the policy should not apply when members of the finance group use applications other than the ERP application. Thus, the IT department defines a second QoS policy called "Client LOB policy" in the Group Policy Object Editor tool that applies a DSCP value of 60 when the finance user group runs the ERP application.  
  
A separate backup application is running on all computers. To ensure the backup application's traffic does not use all available network resources, a backup data policy is created. This backup policy specifies a DSCP value of 1 based on the executable name for this backup application, backup.exe. A third GPO is created and deployed for all client computers in the domain. Whenever the backup application sends data, the low\-priority DSCP value is applied, even if it originates from computers in the finance department.  
  
Note that traffic without a QoS policy sends with a DSCP value of 0.  
  
The following table summarizes the QoS policies for this scenario.  
  
|Policy name|DSCP value|Throttle rate|Applied to organization units|Description|  
|---------------|--------------|-----------------|---------------------------------|---------------|  
|\[No policy\]|0|None|\[No deployment\]|Best effort \(default\) treatment for unclassified traffic.|  
|Backup data|1|None|All clients|Applies a low\-priority DSCP value for this bulk data.|  
|Server LOB|44|None|Computer OU for ERP servers|Applies high\-priority DSCP for ERP server traffic|  
|Client LOB|60|None|Finance user group|Applies high\-priority DSCP for ERP client traffic|  
  
> [!NOTE]  
> DSCP values are represented in decimal form.  
  
With QoS policies defined and applied by using Group Policy, outbound network traffic receives the policy\-specified DSCP value. Routers then provide differential treatment based on these DSCP values by using queuing. For this IT department, the routers are configured with four queues: high\-priority, middle\-priority, best\-effort, and low\-priority.  
  
When traffic arrives at the router with DSCP values from "Server LOB policy" and "Client LOB policy," the data is placed into high\-priority queues. Traffic with a DSCP value of 0 receives a best\-effort level of service. Packets with a DSCP value of 1 \(from the backup application\) receive low\-priority treatment.  
  
#### Prerequisites for prioritizing a line\-of\-business application  
To complete this task, ensure that you meet the following requirements:  
  
-   The computers involved are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)].  
  
-   The computers involved are members of an Active Directory Domain Services \(AD DS\) domain so that they can be controlled by using Group Policy.  
  
-   TCP\/IP networks are set up with routers configured for DSCP \(RFC 2474\). For more information, see [http:\/\/www.ietf.org\/rfc\/rfc2474.txt](http://www.ietf.org/rfc/rfc2474.txt).  
  
-   Administrative credentials requirements are met.  
  
##### Administrative credentials  
To complete this task, you must be able to create and deploy Group Policy Objects.  
  
#### Setting up the test environment for prioritizing a line\-of\-business application  
To set up the test environment, complete the following tasks:  
  
-   Create an AD DS domain controller with clients and users grouped into organization units.  
  
-   Configure the routers to differentially queue based on DSCP values. For example, DSCP value 44 enters a "Platinum" queue and all others are weighted\-fair\-queued.  
  
    > [!NOTE]  
    > DSCP values can be viewed by using network captures, such as tools like NetMon, and by observing the TOS field.  
  
#### Steps for prioritizing a line\-of\-business application  
To prioritize a line\-of\-business application, complete the following tasks:  
  
1.  Create and link a Group Policy Object \(GPO\) with a QoS policy.  
  
2.  Configure the routers to differentially treat a line\-of\-business application \(by using queuing\) based on the selected DSCP values. The procedures of this task will vary depending upon the type of routers you have.  
  
## Scenario 2: Prioritizing an HTTP server application  
Many enterprise applications are developed for and hosted on Internet Information Services \(IIS\) web servers. Typically, the application is accessed from browsers on client computers. For these deployments, IT departments can benefit from prioritizing the network traffic that is associated with web\-based applications. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], Policy\-based QoS provides a new feature, known as URL\-based Policies, that enables administrators to place HTTP responses—to applications that are built on top of HTTP—subject to QoS control.  
  
In this scenario, assume that you manage a set of IIS servers that host training videos for all your organization’s employees. Your objective is to ensure that the traffic from these video servers won’t overwhelm your network, and ensure that video traffic is differentiated from voice and data traffic on the network. The task is similar to the task in Scenario 1. You will design and configure the traffic management settings, such as the DSCP value for the video traffic, and the throttling rate the same as you would for the line\-of\-business applications. Only when specifying the traffic, instead of providing the application name, you need only to enter the URL to which your HTTP server application will respond: for example, https:\/\/hrweb\/training.  
  
> [!NOTE]  
> URL–based QoS policies apply only to computers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. You cannot use URL\-based QoS policies to prioritize network traffic for computers running Windows operating systems that were released prior to [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
### Precedence rules for URL\-based policies  
All the following URLs are valid and can be specified in Policy\-based QoS and applied simultaneously to a computer or a user:  
  
-   http:\/\/video  
  
-   https:\/\/training.hr.mycompany.com  
  
-   http:\/\/10.1.10.249:8080\/tech  
  
-   https:\/\/\*\/ebooks  
  
But which one will receive precedence? The rules are simple. URL\-based policies are prioritized in a left\-to\-right reading order. So, from the highest priority to the lowest priority, the URL fields are:  
  
1.  [URL scheme](#bkmk_QoS_UrlScheme)  
  
2.  [URL host](#bkmk_QoS_UrlHost)  
  
3.  [URL port](#bkmk_QoS_UrlPort)  
  
4.  [URL path](#bkmk_QoS_UrlPath)  
  
Details are as follows:  
  
#### <a name="bkmk_QoS_UrlScheme"></a>1. URL scheme  
https:\/\/ has a higher priority than http:\/\/.  
  
#### <a name="bkmk_QoS_UrlHost"></a>2. URL host  
From the highest priority to the lowest, they are:  
  
1.  Hostname  
  
2.  IPv6 address  
  
3.  IPv4 address  
  
4.  Wildcard  
  
In the case of hostname, a hostname with more dotted elements \(more depth\) has a higher priority than a hostname with fewer dotted elements. For example, among the following hostnames:  
  
-   video.internal.training.hr.mycompany.com \(depth \= 6\)  
  
-   selfguide.training.mycompany.com \(depth \= 4\)  
  
-   training \(depth \= 1\)  
  
-   library \(depth \= 1\)  
  
**video.internal.training.hr.mycompany.com** has the highest priority, and **selfguide.training.mycompany.com** has the next highest priority. **Training** and **library** share the same lowest priority.  
  
#### <a name="bkmk_QoS_UrlPort"></a>3. URL port  
A specific or an implicit port number has a higher priority than a wildcard port.  
  
#### <a name="bkmk_QoS_UrlPath"></a>4. URL path  
Like a hostname, a URL path may consist of multiple elements. The one with more elements always has a higher priority than the one with less. For example, the following paths are listed by priority:  
  
1.  \/ebooks\/tech\/windows\/networking\/qos  
  
2.  \/ebooks\/tech\/windows\/  
  
3.  \/ebooks  
  
4.  \/  
  
If a user chooses to include all subdirectories and files following a URL path, this URL path will have a lower priority than it would have if the choice were not made.  
  
A user may also choose to specify a destination IP address in a URL\-based policy. The destination IP address has a lower priority than any of the four URL fields described previously.  
  
### URL\-based policy vs. Quintuple policy  
A Quintuple policy is specified by protocol ID, source IP address, source port, destination IP address, and destination port. A Quintuple policy always has a higher precedence than any URL\-based policy. If a Quintuple policy is already applied for a user, a new URL\-based policy will not cause conflicts on any of that user’s client computers.  
  
## <a name="BKMK_configuring"></a>Configuring Policy\-based QoS  
Based on the previous line\-of\-business application example, you can see that QoS for networks is an industry\-wide set of standards and mechanisms for ensuring high\-quality performance for mission\-critical applications. By using QoS mechanisms, network administrators can use existing resources efficiently and ensure the required level of service without reactively expanding or over\-provisioning their networks.  
  
In Windows operating systems, Policy\-based QoS combines the functionality of standards\-based QoS with the manageability of Group Policy. Configuration of this combination makes for easy application of QoS policies to Group Policy Objects. Windows includes a Policy\-based QoS Wizard to help you:  
  
-   [Create a QoS policy](../Topic/Policy-based-Quality-of-Service--QoS-.md#BKMK_create_QoS_policy).  
  
-   [View, edit, or delete a QoS policy](../Topic/Policy-based-Quality-of-Service--QoS-.md#BKMK_view_edit_delete_QoS_policy).  
  
### <a name="BKMK_create_QoS_policy"></a>Create a QoS policy  
Before you create a QoS policy, it is important that you understand the two key QoS controls that are used to manage network traffic:  
  
-   DSCP value  
  
-   Throttle rate  
  
#### Prioritizing traffic with DSCP  
As noted in the previous line\-of\-business application example, you can define the priority of outbound network traffic by using **Specify DSCP Value** to configure a QoS policy with a specific DSCP value. As described in RFC 2474, DSCP allows values from 0 to 63 to be specified within the TOS field of an IPv4 packet and within the Traffic Class field in IPv6. Network routers use the DSCP value to classify network packets and to queue them appropriately.  
  
> [!NOTE]  
> By default, Windows traffic has a DSCP value of 0.  
  
The number of queues and their prioritization behavior needs to be designed as part of your organization's QoS strategy. For example, your organization may choose to have five queues: latency\-sensitive traffic, control traffic, business\-critical traffic, best\-effort traffic, and bulk\-data\-transfer traffic.  
  
#### Throttling traffic  
Along with DSCP values, throttling is another key control for managing network bandwidth. As mentioned earlier, you can use the **Specify Throttle Rate** setting to configure a QoS policy with a specific throttle rate for outbound traffic. By using throttling, a QoS policy limits the outgoing network traffic to a specified throttle rate. Both DSCP marking and throttling can be used together to manage traffic effectively.  
  
> [!NOTE]  
> By default, the **Specify Throttle Rate** check box is not selected.  
  
To create a QoS policy, edit the settings of a Group Policy Object \(GPO\) from within the Group Policy Management Console \(GPMC\) tool. GPMC then opens the Group Policy Object Editor.  
  
QoS policy names must be unique. How policies are applied to servers and end users depends on where the QoS policy is stored in the Group Policy Object Editor:  
  
-   A QoS policy in Computer Configuration\\Windows Settings\\Policy\-based QoS applies to computers, regardless of the user that is currently logged on. You typically use computer\-based QoS policies for server computers.  
  
-   A QoS policy in User Configuration\\Windows Settings\\Policy\-based QoS applies to users after they have logged on, regardless of which computer they have logged on to.  
  
###### To create a new QoS policy with the Policy\-based QoS wizard  
  
-   In Group Policy Object Editor, right\-click either of the **Policy\-based QoS** nodes, and then click **Create a new policy**.  
  
#### Wizard page 1—Policy Profile  
On the first page of the Policy\-based QoS wizard, you can specify a policy name and configure how QoS controls outgoing network traffic.  
  
###### To configure the Policy Profile page of the QoS\-based Policy wizard  
  
1.  In **Policy name**, type a name for the QoS policy. The name must uniquely identify the policy.  
  
2.  Optionally, use **Specify DSCP Value** to enable DSCP marking, and then configure a DSCP value between 0 and 63.  
  
3.  Optionally, use **Specify Throttle Rate** to enable traffic throttling and configure the throttle rate. The throttle rate value must be greater than 1 and you can specify units of kilobytes per second \(KBps\) or megabytes per second \(MBps\).  
  
4.  Click **Next**.  
  
#### Wizard page 2—Application Name  
In the second page of the Policy\-based QoS wizard you can apply the policy to all applications, to a specific application as identified by its executable name, to a path and application name, or to the HTTP server applications that handle requests for a specific URL.  
  
-   **All applications** specifies that the traffic management settings on the first page of the Policy\-based QoS wizard apply to all applications.  
  
-   **Only applications with this executable name** specifies that the traffic management settings on the first page of the Policy\-based QoS wizard are for a specific application. The executable file name and must end with the .exe file name extension.  
  
-   **Only HTTP server applications responding to requests for this URL** specifies that the traffic management settings on the first page of the Policy\-based QoS wizard apply to certain HTTP server applications only.  
  
Optionally, you can enter the application path. To specify an application path, include the path with the application name. The path can include environment variables. For example, %ProgramFiles%\\My Application Path\\MyApp.exe, or c:\\program files\\my application path\\myapp.exe.  
  
> [!NOTE]  
> The application path cannot include a path that resolves to a symbolic link.  
  
The URL must conform to RFC 1738 \([http:\/\/tools.ietf.org\/html\/rfc1738](http://tools.ietf.org/html/rfc1738)\), that is, in the form of “http\[s\]:\/\/<hostname>:<port>\/<url\-path>”. You can use a wildcard, ‘\*’, for <hostname> and\/or <port>, e.g. http:\/\/training.\*\/, https:\/\/\*.\*, but the wildcard cannot denote a substring of <hostname> or <port>.  
  
In other words, neither http:\/\/my\*site\/ nor https:\/\/\*training\*\/ is valid. Optionally, you can check **Include subdirectories and files** to perform matching on all subdirectories and files following a URL. For example, if this option is checked and the URL is “http:\/\/training”, Policy\-based QoS will consider requests for “http:\/\/training\/video” a good match.  
  
###### To configure the Application Name page of the Policy\-based QoS wizard  
  
1.  In **This QoS policy applies to**, select either **All applications** or **Only applications with this executable name**.  
  
2.  If you select **Only applications with this executable name**, specify an executable name ending with the .exe file name extension.  
  
3.  Click **Next**.  
  
#### Wizard page 3—IP Addresses  
In the third page of the Policy\-based QoS wizard you can specify IP address conditions for the QoS policy, including the following:  
  
-   All source IPv4 or IPv6 addresses or specific source IPv4 or IPv6 addresses  
  
-   All destination IPv4 or IPv6 addresses or specific destination IPv4 or IPv6 addresses  
  
If you select **Only for the following source IP address** or **Only for the following destination IP address**, you must type one of the following:  
  
-   An IPv4 address, such as 192.168.1.1  
  
-   An IPv4 address prefix using network prefix length notation, such as 192.168.1.0\/24  
  
-   An IPv6 address, such as 3ffe:ffff::1  
  
-   An IPv6 address prefix, such as 3ffe:ffff::\/48  
  
If you select both **Only for the following source IP address** and **Only for the following destination IP address**, both addresses or address prefixes must be either IPv4\- or IPv6\-based.  
  
If you specified the URL for HTTP server applications in the previous wizard page, you’ll notice that the source IP address for the QoS policy on this wizard page is grayed out. That’s because the source IP address is the HTTP server address and it is not configurable here. On the other hand, you can still customize the policy by specifying the destination IP address. This makes it possible for you to create different policies for different clients by using the same HTTP server applications.  
  
###### To configure the IP Addresses page of the Policy\-based QoS wizard  
  
1.  In **This QoS policy applies to** \(source\), select **Any source IP address** or **Only for the following IP source address**.  
  
2.  If you selected **Only the following IP source address**, specify an IPv4 or IPv6 address or prefix.  
  
3.  In **This QoS policy applies to** \(destination\), select **Any destination address** or **Only for the following IP destination address.**  
  
4.  If you selected **Only for the following IP destination address**, specify an IPv4 or IPv6 address or prefix that corresponds to the type of address or prefix specified for the source address.  
  
5.  Click **Next**.  
  
#### Wizard page 4—Protocols and Ports  
On the fourth page of the Policy\-based QoS wizard, you can specify the types of traffic and the ports that are controlled by the settings on the first page of the wizard. You can specify:  
  
-   TCP traffic, UDP traffic, or both  
  
-   All source ports, a range of source ports, or a specific source port  
  
-   All destination ports, a range of destination ports, or a specific destination port  
  
###### To configure the Protocols and Ports page of the Policy\-based QoS wizard  
  
1.  In **Select the protocol this QoS policy applies to**, select **TCP**, **UDP**, or **TCP and UDP**.  
  
2.  In **Specify the source port number**, select **From any source port** or **From this source port number**.  
  
3.  If you selected **From this source port number**, type a port number between 1 and 65535.  
  
    Optionally, you can specify a port range, in the format of "*Low*:*High*," where *Low* and *High* represent the lower bounds and upper bounds of the port range, inclusively. *Low* and *High* each must be a number between 1 and 65535. No space is allowed between the colon \(:\) character and the numbers.  
  
4.  In **Specify the destination port number**, select **To any destination port** or **To this destination port number**.  
  
5.  If you selected **To this destination port number** in the previous step, type a port number between 1 and 65535.  
  
To complete the creation of the new QoS policy, click **Finish** on the **Protocols and Ports** page of the Policy\-based QoS wizard. When completed, the new QoS policy is listed in the details pane of the Group Policy Object Editor.  
  
To apply the QoS policy settings to users or computers, link the GPO in which the QoS policies are located to an Active Directory Domain Services container, such as a domain, a site, or an organizational unit \(OU\).  
  
### <a name="BKMK_view_edit_delete_QoS_policy"></a>View, edit, or delete a QoS policy  
The pages of the Policy\-based QoS wizard described previously correspond to the properties pages that are displayed when you view or edit the properties of a policy.  
  
##### To view the properties of a QoS policy  
  
-   Right\-click the policy name in the details pane of the Group Policy Object Editor, and then click **Properties**.  
  
    The Group Policy Object Editor displays the properties page with the following tabs:  
  
    -   Policy Profile  
  
    -   Application Name  
  
    -   IP Addresses  
  
    -   Protocols and Ports  
  
##### To edit a QoS policy  
  
-   Right\-click the policy name in the details pane of the Group Policy Object Editor, and then click **Edit existing policy**.  
  
    The Group Policy Object Editor displays the **Edit an existing QoS policy** dialog box.  
  
##### To delete a QoS policy  
  
-   Right\-click the policy name in the details pane of the Group Policy Object Editor, and then click **Delete policy**.  
  
### QoS Policy GPMC Reporting  
After you have applied a number of QoS policies across your organization, it may be useful or necessary to periodically review how the policies are applied. A summary of the QoS policies for a specific user or computer can be viewed by using GPMC reporting.  
  
##### To run the Group Policy Results Wizard for a report of QoS policies  
  
-   In GPMC, right\-click the **Group Policy Results** node, and then select the menu option for **Group Policy Results Wizard.**  
  
After Group Policy results are generated, click the **Settings** tab. On the **Settings** tab, the QoS policies can be found under the "Computer Configuration\\Windows Settings\\Policy\-based QoS" and "User Configuration\\Windows Settings\\Policy\-based QoS" nodes.  
  
On the **Settings** tab, the QoS policies are listed by their QoS policy names with their DSCP value, throttle rate, policy conditions, and winning GPO listed in the same row..  
  
The Group Policy results view uniquely identifies the winning GPO. When multiple GPOs have QoS policies with the same QoS policy name, the GPO with the highest GPO precedence is applied. This is the winning GPO. Conflicting QoS policies \(identified by policy name\) that are attached to a lower priority GPO are not applied. Note the GPO priorities define which QoS policies are deployed in the site, domain, or OU, as appropriate. After deployment, at a user or computer level, the [QoS policy precedence rules](#BKMK_precedencerules) determine which traffic is allowed and blocked.  
  
The QoS policy's DSCP value, throttle rate, and policy conditions are also visible in Group Policy Object Editor \(GPOE\)  
  
### Advanced settings for roaming and remote users  
With Policy\-based QoS, the goal is to manage traffic on an enterprise's network. In mobile scenarios, users might be sending traffic on or off the enterprise network. Because QoS policies are not relevant while away from the enterprise's network, QoS policies are enabled only on network interfaces that are connected to the enterprise for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], or [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)].  
  
For example, a user might connect her portable computer to her enterprise's network via virtual private network \(VPN\) from a coffee shop. For VPN, the physical network interface \(such as wireless\) will not have QoS policies applied. However, the VPN interface will have QoS policies applied because it connects to the enterprise. If the user later enters another enterprise's network that does not have an AD DS trust relationship, QoS policies will not be enabled.  
  
Note that these mobile scenarios do not apply to server workloads. For example, a server with multiple network adapters might sit on the edge of an enterprise's network. The IT department might choose to have QoS policies throttle traffic that egresses the enterprise; however, this network adapter that sends this egress traffic does not necessarily connect back to the enterprise network. For this reason, QoS policies are always enabled on all network interfaces of a computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
> [!NOTE]  
> Selective enablement only applies to QoS policies and not to the Advanced QoS settings discussed next in this document.  
  
### Advanced QoS settings  
Advanced QoS settings provide additional controls for IT administrators to manage computer network consumption and DSCP markings. Advanced QoS settings apply only at the computer level, whereas QoS policies can be applied at both the computer and user levels.  
  
##### To configure advanced QoS settings  
  
1.  Click **Computer Configuration**, and then click **Windows Settings in Group Policy**.  
  
2.  Right\-click **Policy\-based QoS**, and then click **Advanced QoS Settings**.  
  
    The following figure shows the two advanced QoS settings tabs: **Inbound TCP Traffic** and **DSCP Marking Override**.  
  
> [!NOTE]  
> Advanced QoS Settings are computer\-level Group Policy settings.  
  
#### Advanced QoS settings: inbound TCP traffic  
**Inbound TCP Traffic** controls the TCP bandwidth consumption on the receiver's side, whereas QoS policies affect the outbound TCP and UDP traffic. By setting a lower throughput level on the **Inbound TCP Traffic** tab, TCP will limit the size of its advertised TCP receive window. The effect of this setting will be increased throughput rates and link utilization for TCP connections with higher bandwidths or latencies \(bandwidth delay product\). By default, computers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] are set to the maximum throughput level.  
  
The TCP receive window has changed in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] from previous versions of Windows. Previous versions of Windows limited the TCP receive\-side window to a maximum of 64 kilobytes \(KB\), whereas [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] dynamically size the receive\-side window up to 16 megabytes \(MB\). In the Inbound TCP Traffic control, you can control the inbound throughput level by setting the maximum value to which the TCP receive\-window can grow. The levels correspond to the following maximum values.  
  
|Inbound throughput level|Maximum|  
|----------------------------|-----------|  
|0|64 KB|  
|1|256 KB|  
|2|1 MB|  
|3|16 MB|  
  
The actual window size may be a value equal to or smaller than the maximum, depending on network conditions.  
  
###### To set the TCP receive\-side window  
  
1.  In Group Policy Object Editor, click **Local Computer Policy**, click **Windows Settings**, right click **Policy\-based QoS**, and then click **Advanced QoS Settings**.  
  
2.  In **TCP Receiving Throughput**, select **Configure TCP Receiving Throughput**, and then select the level of throughput that you want.  
  
3.  Link the GPO to the OU.  
  
#### Advanced QoS settings: DSCP Marking Override  
DSCP Marking Override restricts the ability of applications to specify—or "mark"—DSCP values other than those specified in QoS policies. By specifying that applications are allowed to set DSCP values, applications can set non\-zero DSCP values. By specifying **Ignore**, applications that use QoS APIs will have their DSCP values set to zero, and only QoS policies can set DSCP values. By default, computers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] and allow applications to specify DSCP values; applications and devices that do not use the QoS APIs are not overridden.  
  
##### Wireless Multimedia and DSCP values  
The [Wi\-Fi Alliance](http://go.microsoft.com/fwlink/?LinkId=160769) has established a certification for Wireless Multimedia \(WMM\) that defines four access categories \(WMM\_AC\) for prioritizing network traffic transmitted on a Wi\-Fi wireless network. The access categories include \(in order of highest\-to\-lowest priority\): voice, video, best effort, and background; respectively abbreviated as VO, VI, BE, and BK. The WMM specification defines which DSCP values correspond with each of the four access categories:  
  
|DSCP Value|WMM Access Category|  
|--------------|-----------------------|  
|48\-63|Voice \(VO\)|  
|32\-47|Video \(VI\)|  
|24\-31, 0\-7|Best effort \(BE\)|  
|8\-23|Background \(BK\)|  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] QoS policies can be created that use these DSCP values to ensure that portable computers with Wi\-Fi Certified™ for WMM wireless adapters receive prioritized handling when associated with Wi\-Fi Certified for WMM access points.  
  
### <a name="BKMK_precedencerules"></a>QoS Policy Precedence Rules  
Similar to GPO's priorities, QoS policies have precedence rules to resolve conflicts when multiple QoS policies apply to a specific set of traffic. For outbound TCP or UDP traffic, only one QoS policy can be applied at a time, which means that QoS policies do not have a cumulative effect, such as where throttle rates would be summed.  
  
In general, the QoS policy with the most matching conditions wins. When multiple QoS policies apply, the rules fall into three categories: user\-level versus computer\-level; application versus the network quintuple; and among the network quintuple.  
  
By *network quintuple*, we mean the source IP address, destination IP address, source port, destination port, and protocol \(TCP\/UDP\).  
  
**User\-level QoS policy takes precedence over computer\-level QoS policy**  
  
This rule greatly facilitates network administrators’ management of QoS GPOs, particularly for user group–based policies. For example, if the network admin wants to define a QoS policy for a user group, they can just create and distribute a GPO to that group. They don’t have to worry about which computers those users are logged on to and whether those computers will have conflicting QoS policies defined, because, if a conflict exists, the user\-level policy always takes precedence.  
  
> [!NOTE]  
> A user\-level QoS policy is only applicable to traffic that is generated by that user. Other users of a specific computer, and the computer itself, will not be subject to any QoS policies that are defined for that user.  
  
**Application specificity and taking precedence over network quintuple**  
  
When multiple QoS policies match the specific traffic, the more specific policy is applied. Among policies that identify applications, a policy that includes the sending application's file path is considered more specific than another policy that only identifies the application name \(no path\). If multiple policies with applications still apply, the precedence rules use the network quintuple to find the best match.  
  
Alternatively, multiple QoS policies might apply to the same traffic by specifying non\-overlapping conditions. Between the conditions of applications and the network quintuple, the policy that specifies the application is considered more specific and is applied. For example, policy\_A only specifies an application name \(app.exe\), and policy\_B specifies the destination IP address 192.168.1.0\/24. When these QoS policies conflict \(app.exe sends traffic to an IP address within the range of 192.168.4.0\/24\), policy\_A gets applied.  
  
**More specificity takes precedence within the network quintuple**  
  
For policy conflicts within the network quintuple, the policy with the most matching conditions takes precedence. For example, assume policy\_C specifies source IP address "any", destination IP address 10.0.0.1, source port "any", destination port "any", and protocol "TCP". Next, assume policy\_D specifies source IP address "any", destination IP address 10.0.0.1, source port "any", destination port 80, and protocol "TCP". Then policy\_C and policy\_D both match connections to destination 10.0.0.1:80. Because Policy\-based QoS applies the policy with the most specific matching conditions, policy\_D takes precedence in this example.  
  
However, QoS policies might have an equal number of conditions. For example, several policies may each specify only one \(but not the same\) piece of the network quintuple. Among the network quintuple, the following order is from higher to lower precedence:  
  
-   Source IP address  
  
-   Destination IP address  
  
-   Source port  
  
-   Destination port  
  
-   Protocol \(TCP or UDP\)  
  
Within a specific condition, such as IP address, a more specific IP address is treated with higher precedence; for example, an IP address 192.168.4.1 is more specific than 192.168.4.0\/24.  
  
> [!NOTE]  
> Generally your QoS policies should be designed as specifically as possible to simplify your organization's understanding of which policies are in effect.  
  
## Reference  
  
### Error and Event Messages  
Following are the error and event messages that are associated with Policy\-based QoS.  
  
#### Informational Messages  
  
|||  
|-|-|  
|**MessageId**|16500|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT\_EQOS\_INFO\_MACHINE\_POLICY\_REFRESH\_NO\_CHANGE|  
|**Language**|English|  
|**Message**|Computer QoS policies successfully refreshed. No changes detected.|  
  
|||  
|-|-|  
|**MessageId**|16501|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT\_EQOS\_INFO\_MACHINE\_POLICY\_REFRESH\_WITH\_CHANGE|  
|**Language**|English|  
|**Message**|Computer QoS policies successfully refreshed. Policy changes detected.|  
  
|||  
|-|-|  
|**MessageId**|16502|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT\_EQOS\_INFO\_USER\_POLICY\_REFRESH\_NO\_CHANGE|  
|**Language**|English|  
|**Message**|User QoS policies successfully refreshed. No changes detected.|  
  
|||  
|-|-|  
|**MessageId**|16503|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT\_EQOS\_INFO\_USER\_POLICY\_REFRESH\_WITH\_CHANGE|  
|**Language**|English|  
|**Message**|User QoS policies successfully refreshed. Policy changes detected.|  
  
|||  
|-|-|  
|**MessageId**|16504|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT\_EQOS\_INFO\_TCP\_AUTOTUNING\_NOT\_CONFIGURED|  
|**Language**|English|  
|**Message**|The Advanced QoS Setting for inbound TCP throughput level successfully refreshed. Setting value is not specified by any QoS policy. Local computer default will be applied.|  
  
|||  
|-|-|  
|**MessageId**|16505|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT\_EQOS\_INFO\_TCP\_AUTOTUNING\_OFF|  
|**Language**|English|  
|**Message**|The Advanced QoS Setting for inbound TCP throughput level successfully refreshed. Setting value is Level 0 \(minimum throughput\).|  
  
|||  
|-|-|  
|**MessageId**|16506|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT\_EQOS\_INFO\_TCP\_AUTOTUNING\_HIGHLY\_RESTRICTED|  
|**Language**|English|  
|**Message**|The Advanced QoS Setting for inbound TCP throughput level successfully refreshed. Setting value is Level 1.|  
  
|||  
|-|-|  
|**MessageId**|16507|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT\_EQOS\_INFO\_TCP\_AUTOTUNING\_RESTRICTED|  
|**Language**|English|  
|**Message**|The Advanced QoS Setting for inbound TCP throughput level successfully refreshed. Setting value is Level 2.|  
  
|||  
|-|-|  
|**MessageId**|16508|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT\_EQOS\_INFO\_TCP\_AUTOTUNING\_NORMAL|  
|**Language**|English|  
|**Message**|The Advanced QoS Setting for inbound TCP throughput level successfully refreshed. Setting value is Level 3 \(maximum throughput\).|  
  
|||  
|-|-|  
|**MessageId**|16509|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT\_EQOS\_INFO\_APP\_MARKING\_NOT\_CONFIGURED|  
|**Language**|English|  
|**Message**|The Advanced QoS Setting for DSCP marking overrides successfully refreshed. Setting value is not specified. Applications can set DSCP values independently of QoS policies.|  
  
|||  
|-|-|  
|**MessageId**|16510|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT\_EQOS\_INFO\_APP\_MARKING\_IGNORED|  
|**Language**|English|  
|**Message**|The Advanced QoS Setting for DSCP marking overrides successfully refreshed. Application DSCP marking requests will be ignored. Only QoS policies can set DSCP values.|  
  
|||  
|-|-|  
|**MessageId**|16511|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT\_EQOS\_INFO\_APP\_MARKING\_ALLOWED|  
|**Language**|English|  
|**Message**|The Advanced QoS Setting for DSCP marking overrides successfully refreshed. Applications can set DSCP values independently of QoS policies.|  
  
|||  
|-|-|  
|**MessageId**|16512|  
|**Severity**|Informational|  
|**SymbolicName**|EVENT\_EQOS\_INFO\_LOCAL\_SETTING\_DONT\_USE\_NLA|  
|**Language**|English|  
|**Message**|Selective application of QoS policies based on domain network category has been disabled. QoS policies will be applied to all network interfaces.|  
  
#### Warning Messages  
  
|||  
|-|-|  
|**MessageId**|16600|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT\_EQOS\_WARNING\_TEST\_1|  
|**Language**|English|  
|**Message**|EQOS: \*\*\*Testing\*\*\*\[, with one string\] "%2".|  
  
|||  
|-|-|  
|**MessageId**|16601|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT\_EQOS\_WARNING\_TEST\_2|  
|**Language**|English|  
|**Message**|EQOS: \*\*\*Testing\*\*\*\[, with two strings, string1 is\] "%2"\[, string2 is\] "%3".|  
  
|||  
|-|-|  
|**MessageId**|16602|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT\_EQOS\_WARNING\_MACHINE\_POLICY\_VERSION|  
|**Language**|English|  
|**Message**|The computer QoS policy "%2" has an invalid version number. This policy will not be applied.|  
  
|||  
|-|-|  
|**MessageId**|16603|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT\_EQOS\_WARNING\_USER\_POLICY\_VERSION|  
|**Language**|English|  
|**Message**|The user QoS policy "%2" has an invalid version number. This policy will not be applied.|  
  
|||  
|-|-|  
|**MessageId**|16604|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT\_EQOS\_WARNING\_MACHINE\_POLICY\_PROFILE\_NOT\_SPECIFIED|  
|**Language**|English|  
|**Message**|The computer QoS policy "%2" does not specify a DSCP value or throttle rate. This policy will not be applied.|  
  
|||  
|-|-|  
|**MessageId**|16605|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT\_EQOS\_WARNING\_USER\_POLICY\_PROFILE\_NOT\_SPECIFIED|  
|**Language**|English|  
|**Message**|The user QoS policy "%2" does not specify a DSCP value or throttle rate. This policy will not be applied.|  
  
|||  
|-|-|  
|**MessageId**|16606|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT\_EQOS\_WARNING\_MACHINE\_POLICY\_QUOTA\_EXCEEDED|  
|**Language**|English|  
|**Message**|Exceeded the maximum number of computer QoS policies. The QoS policy "%2" and subsequent computer QoS policies will not be applied.|  
  
|||  
|-|-|  
|**MessageId**|16607|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT\_EQOS\_WARNING\_USER\_POLICY\_QUOTA\_EXCEEDED|  
|**Language**|English|  
|**Message**|Exceeded the maximum number of user QoS policies. The QoS policy "%2" and subsequent user QoS policies will not be applied.|  
  
|||  
|-|-|  
|**MessageId**|16608|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT\_EQOS\_WARNING\_MACHINE\_POLICY\_CONFLICT|  
|**Language**|English|  
|**Message**|The computer QoS policy "%2" potentially conflicts with other QoS policies. See documentation for rules about which policy will be applied.|  
  
|||  
|-|-|  
|**MessageId**|16609|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT\_EQOS\_WARNING\_USER\_POLICY\_CONFLICT|  
|**Language**|English|  
|**Message**|The user QoS policy "%2" potentially conflicts with other QoS policies. See documentation for rules about which policy will be applied.|  
  
|||  
|-|-|  
|**MessageId**|16610|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT\_EQOS\_WARNING\_MACHINE\_POLICY\_NO\_FULLPATH\_APPNAME|  
|**Language**|English|  
|**Message**|The computer QoS policy "%2" was ignored because the application path cannot be processed. The application path may be invalid, contain an invalid drive letter, or contain a network mapped drive.|  
  
|||  
|-|-|  
|**MessageId**|16611|  
|**Severity**|Warning|  
|**SymbolicName**|EVENT\_EQOS\_WARNING\_USER\_POLICY\_NO\_FULLPATH\_APPNAME|  
|**Language**|English|  
|**Message**|The user QoS policy "%2" was ignored because the application path cannot be processed. The application path may be invalid, contain an invalid drive letter, or contain a network mapped drive.|  
  
#### Error Messages  
  
|||  
|-|-|  
|**MessageId**|16700|  
|**Severity**|Error|  
|**SymbolicName**|EVENT\_EQOS\_ERROR\_MACHINE\_POLICY\_REFERESH|  
|**Language**|English|  
|**Message**|Computer QoS policies failed to refresh. Error code: "%2".|  
  
|||  
|-|-|  
|**MessageId**|16701|  
|**Severity**|Error|  
|**SymbolicName**|EVENT\_EQOS\_ERROR\_USER\_POLICY\_REFERESH|  
|**Language**|English|  
|**Message**|User QoS policies failed to refresh. Error code: "%2".|  
  
|||  
|-|-|  
|**MessageId**|16702|  
|**Severity**|Error|  
|**SymbolicName**|EVENT\_EQOS\_ERROR\_OPENING\_MACHINE\_POLICY\_ROOT\_KEY|  
|**Language**|English|  
|**Message**|QoS failed to open the machine\-level root key for QoS policies. Error code: "%2".|  
  
|||  
|-|-|  
|**MessageId**|16703|  
|**Severity**|Error|  
|**SymbolicName**|EVENT\_EQOS\_ERROR\_OPENING\_USER\_POLICY\_ROOT\_KEY|  
|**Language**|English|  
|**Message**|QoS failed to open the user\-level root key for QoS policies. Error code: "%2".|  
  
|||  
|-|-|  
|**MessageId**|16704|  
|**Severity**|Error|  
|**SymbolicName**|EVENT\_EQOS\_ERROR\_MACHINE\_POLICY\_KEYNAME\_TOO\_LONG|  
|**Language**|English|  
|**Message**|A computer QoS policy exceeds the maximum allowed name length. The offending policy is listed under the machine\-level QoS policy root key, with index "%2".|  
  
|||  
|-|-|  
|**MessageId**|16705|  
|**Severity**|Error|  
|**SymbolicName**|EVENT\_EQOS\_ERROR\_USER\_POLICY\_KEYNAME\_TOO\_LONG|  
|**Language**|English|  
|**Message**|A user QoS policy exceeds the maximum allowed name length. The offending policy is listed under the user\-level QoS policy root key, with index "%2".|  
  
|||  
|-|-|  
|**MessageId**|16706|  
|**Severity**|Error|  
|**SymbolicName**|EVENT\_EQOS\_ERROR\_MACHINE\_POLICY\_KEYNAME\_SIZE\_ZERO|  
|**Language**|English|  
|**Message**|A computer QoS policy has a zero length name. The offending policy is listed under the machine\-level QoS policy root key, with index "%2".|  
  
|||  
|-|-|  
|**MessageId**|16707|  
|**Severity**|Error|  
|**SymbolicName**|EVENT\_EQOS\_ERROR\_USER\_POLICY\_KEYNAME\_SIZE\_ZERO|  
|**Language**|English|  
|**Message**|A user QoS policy has a zero length name. The offending policy is listed under the user\-level QoS policy root key, with index "%2".|  
  
|||  
|-|-|  
|**MessageId**|16708|  
|**Severity**|Error|  
|**SymbolicName**|EVENT\_EQOS\_ERROR\_OPENING\_MACHINE\_POLICY\_SUBKEY|  
|**Language**|English|  
|**Message**|QoS failed to open the registry subkey for a computer QoS policy. The policy is listed under the machine\-level QoS policy root key, with index "%2".|  
  
|||  
|-|-|  
|**MessageId**|16709|  
|**Severity**|Error|  
|**SymbolicName**|EVENT\_EQOS\_ERROR\_OPENING\_USER\_POLICY\_SUBKEY|  
|**Language**|English|  
|**Message**|QoS failed to open the registry subkey for a user QoS policy. The policy is listed under the user\-level QoS policy root key, with index "%2".|  
  
|||  
|-|-|  
|**MessageId**|16710|  
|**Severity**|Error|  
|**SymbolicName**|EVENT\_EQOS\_ERROR\_PROCESSING\_MACHINE\_POLICY\_FIELD|  
|**Language**|English|  
|**Message**|QoS failed to read or validate the "%2" field for the computer QoS policy "%3".|  
  
|||  
|-|-|  
|**MessageId**|16711|  
|**Severity**|Error|  
|**SymbolicName**|EVENT\_EQOS\_ERROR\_PROCESSING\_USER\_POLICY\_FIELD|  
|**Language**|English|  
|**Message**|QoS failed to read or validate the "%2" field for the user QoS policy "%3".|  
  
|||  
|-|-|  
|**MessageId**|16712|  
|**Severity**|Error|  
|**SymbolicName**|EVENT\_EQOS\_ERROR\_SETTING\_TCP\_AUTOTUNING|  
|**Language**|English|  
|**Message**|QoS failed to read or set inbound TCP throughput level, error code: "%2".|  
  
|||  
|-|-|  
|**MessageId**|16713|  
|**Severity**|Error|  
|**SymbolicName**|EVENT\_EQOS\_ERROR\_SETTING\_APP\_MARKING|  
|**Language**|English|  
|**Message**|QoS failed to read or set the DSCP marking override setting, error code: "%2".|  
  
## Additional resources  
  
-   For more an overview of QoS, see [Quality of Service &#40;QoS&#41; Overview](../Topic/Quality-of-Service--QoS--Overview.md).  
  
-   For more information about QoS, see the [Windows Server TechCenter](http://go.microsoft.com/fwlink/?LinkId=65245) web site at http:\/\/go.microsoft.com\/fwlink\/?LinkId\=65245.  
  
-   For more information on configuring Policy\-based QoS, see [Configuring Policy-based Quality of Service &#40;QoS&#41;](../Topic/Configuring-Policy-based-Quality-of-Service--QoS-.md).  
  
-   For more about Policy\-based QoS, see the [Cable Guy article](http://go.microsoft.com/fwlink/?LinkId=65246) on the Microsoft web site at http:\/\/go.microsoft.com\/fwlink\/?LinkId\=65246.  
  
-   For more information about Group Policy, see the [Windows Server TechCenter](http://go.microsoft.com/fwlink/?LinkID=17530) on the Microsoft web site at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=17530.  
  
-   For background on the Group Policy Management Console, see [Enterprise Management with the Group Policy Management Console](http://go.microsoft.com/fwlink/?LinkID=8630) on the Microsoft web site at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=8630.  
  
## FAQ  
  
### What operating system does my domain controller need to be running?  
Your domain controller can be running Windows 2000 Server, Windows Server 2003, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
> [!NOTE]  
> GPMC must be the version available in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)].  
  
### Do I need Windows Server 2008, Windows Server 2008 R2, or Windows Server 2012 to deploy QoS policies?  
No, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is not required. However, QoS policies only apply to users or computers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)].  
  
### Do QoS policies apply to the sender or receiver of traffic?  
QoS policies must be applied on the sending computer to affect its outbound traffic. In order to affect the bidirectional traffic of two computers, QoS policies need to be deployed to both computers.  
  
### What happens if conflicting policies are deployed to the same computer?  
If multiple policies apply, the more specific QoS policy takes precedence. For example, a policy that states a host address \(192.168.4.12\) gets applied instead of a network address \(192.168.0.0\/16\). If a computer\-level and user\-level policy have the same specificity, the user\-level QoS policy is applied instead of the computer\-level QoS policy.  
  
## <a name="BKMK_AddlRes"></a>Additional resources  
  
-   For more information about QoS, see the [Quality of Service &#40;QoS&#41; Overview](../Topic/Quality-of-Service--QoS--Overview.md).  
  
-   For more information about configuring Policy\-based QoS, see [Configuring Policy-based Quality of Service &#40;QoS&#41;](../Topic/Configuring-Policy-based-Quality-of-Service--QoS-.md).  
  
