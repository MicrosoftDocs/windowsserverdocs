---
title: Scenario: Manage the network configuration of virtual machines
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5295a4ac-87da-4862-9e08-4844c7f0b3d5
---
# Scenario: Manage the network configuration of virtual machines
See the following sections in this topic:  
  
-   [Problem description](../Topic/Scenario--Manage-the-network-configuration-of-virtual-machines.md#problem)  
  
-   [MAC addressing in Hyper\-V](../Topic/Scenario--Manage-the-network-configuration-of-virtual-machines.md#mac)  
  
-   [Configure a MAC address based DHCP policy](../Topic/Scenario--Manage-the-network-configuration-of-virtual-machines.md#procedure)  
  
-   [Conclusion](../Topic/Scenario--Manage-the-network-configuration-of-virtual-machines.md#conclusion)  
  
## <a name="problem"></a>Problem description  
More and more organizations are leveraging the advantages of virtualization in today’s business environment. However, virtual networks also require physical resources, including:  
  
-   **Compute resources**: Physical servers that host virtual machines, such as a Hyper\-V cluster are required.  
  
-   **Storage resources**: Clustered file servers such as the Scale\-Out File Server in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] are a critical component of any virtualization solution.  
  
-   **Network resources**: Physical devices such as routers and switches that connect virtual networks to other networks are necessary.  
  
-   **Management resources**: Physical servers and devices that provide automation, access control, monitoring, and scalability for virtual networks, such as System Center Virtual Machine Manager are a critical component.  
  
As a consequence, organizations often need to manage a hybrid environment consisting of both physical and virtual resources. See the following diagram.  
  
![](../Image/DHCP_pba-scen1.png)  
  
Placing virtual and physical devices on separate subnets enables customization of network settings but adds complexity. Larger, flat networks are typically more efficient and less complex to manage than a design that includes multiple smaller, partitioned networks. DHCP policies can help to simplify management of hybrid environments by enabling greater flexibility and control of the network configuration of DHCP clients.  
  
### Virtual machines  
An advantage of virtual machines is that they can be added and removed dynamically from the network depending upon load requirements. However, this capability can bring with it some unique requirements. Due to their dynamic nature, virtual machines might require:  
  
-   A different, often shorter, lease duration  
  
-   A different default gateway for use in traffic management  
  
-   A different domain name or DNS server  
  
-   A different IP address range  
  
These configuration parameters can be managed by creating a DHCP policy based on MAC address prefix. DHCP clients that match the policy are assigned IP addresses from a specific IP address range, a short lease duration, and different DHCP options such as default gateway and DNS server.  
  
## <a name="mac"></a>MAC addressing in Hyper\-V  
With Hyper\-V, you can configure a virtual machine to use a dynamic or a static MAC address. The default option is to use a dynamic MAC address, which means that Hyper\-V will generate a MAC address for the network adapter. To view MAC address settings in Hyper\-V, right\-click a virtual machine, click **Settings**, and then under **Network Adapter**, click **Advanced Features**. See the following example.  
  
![](../Image/DHCP_pba-mac.gif)  
  
In this example, the Hyper\-V server is using a dynamic MAC address range of 00\-15\-5D\-9F\-DF\-00 to 00\-15\-5D\-9F\-DF\-FF. To use a static MAC address, select **Static** and then specify a MAC address.  
  
For dynamic MAC addressing in Hyper\-V, a range of 256 possible MAC addresses is used by default. The starting and ending addresses are derived from the lowest two octets in an IPv4 address on the Hyper\-V server, and will begin with Microsoft’s Organizationally Unique Identifier \(OUI\) of 00\-15\-5D. The range can be modified, if desired, by editing the **MaximumMacAddress** and **MinimumMacAddress** registry keys located under **HKLM\\Software\\Microsoft\\Windows\\NT\\CurrentVersion\\Virtualization**. This kind of support is provided by all the virtualization platforms.  
  
To group virtual machines in a DHCP policy, create a policy with conditions based on MAC address or MAC address prefix.  
  
For example, if MAC addresses are assigned from the range 00\-15\-5D\-9F\-DF\-00 to 00\-15\-5D\-9F\-DF\-FF, you can create a policy based on the MAC address prefix 00\-15\-5D\-9F\-DF. If you would like the policy to cater to all virtual machines regardless of the host or host group, use the MAC address prefix 00\-15\-5D with a wildcard \(00155D\*\). The following procedure demonstrates how to configure this policy.  
  
## <a name="procedure"></a>Configure a MAC address based DHCP policy  
Use the following procedure to configure a policy for virtual machines based on MAC addresses. In this procedure, the example MAC address range used is 00\-15\-5D\-9F\-DF\-00 to 00\-15\-5D\-9F\-DF\-FF. You must replace the values used in this example with the MAC address range used in your environment. By default, the Hyper\-V server will use a MAC address range that includes values of 00 to FF for the sixth octet, with the same first five octets. For more information, see [MAC addressing in Hyper\-V](../Topic/Scenario--Manage-the-network-configuration-of-virtual-machines.md#mac).  
  
#### To configure a MAC address based DHCP policy  
  
1.  In the DHCP console, choose a scope that will be used to issue leases to both physical and virtual DHCP clients.  
  
2.  Under the DHCP scope, right click **Policies** and then click **New Policy**.  
  
3.  In the DHCP Policy Configuration Wizard, type **MAC Prefix Policy** next to **Policy Name**, and then click **Next**. You can type a different policy name and enter a description if desired.  
  
4.  On the Configure Conditions for the policy page, click **Add**.  
  
5.  Next to **Criteria**, choose **MAC Address** from the drop\-down list and choose **Equals** next to **Operator**.  
  
6.  Next to **Value**, type **00155D9FDF**, select the **Append wildcard** checkbox, click **Add**, and then click **OK**.  
  
7.  Click **Next**, and provide an IPv4 address range to be used for clients that match the policy. To provide a range, enter a start and end IP address next to **Start IP address** and **End IP address**, respectively. The percentage of IP address used by this IP address range compared to all available IP addresses in the scope is displayed next to **Percentage of IP address range**. If you do not want to specify a range of IP addresses for the policy, select **No** next to **Do you want to configure an IP address range for the policy**.  
  
    > [!NOTE]  
    > The IP address range specified must be within the IP address range for the scope. An IP address range setting cannot be specified in server level policies.  
  
8.  Click **Next**, and specify DHCP options to be used by clients that match the policy, such as the default route or list of DNS servers.  
  
9. Click **Next**, and on the Summary page review the conditions and settings for this policy. Click **Finish** to create the policy.  
  
10. To configure a custom lease duration for virtual machines, right\-click the policy you just created and then click **Properties**. On the **General** tab, select the **Set lease duration for the policy** checkbox and then specify a lease duration.  
  
11. Review the conditions and settings for the policy by clicking each available tab. DNS registration settings can be modified on the **DNS** tab. Click **OK** to apply changes or click **Cancel** to discard changes.  
  
After you have configured this policy, you can also right\-click the policy and click **Move Up** or **Move Down** to change its processing order.  
  
## <a name="conclusion"></a>Conclusion  
Using this policy, new DHCP requests for IPv4 addresses in this scope that are sent from DHCP clients with a MAC address prefix of 00\-15\-5D\-9F\-DF will get the IP address and options that are defined in the policy. In this example, only virtual machines that are hosted by the specified Hyper\-V server will have this MAC address prefix, and will receive these settings.  
  
You can specify additional MAC address prefix values in the policy by adding them to policy conditions. To enable more than one MAC address prefix to receive the same policy settings, add additional MAC address prefixes on the **Conditions** tab in policy properties and select the **OR** radio button.  
  
## See also  
[Introduction to DHCP Policies](../Topic/Introduction-to-DHCP-Policies.md)  
  
