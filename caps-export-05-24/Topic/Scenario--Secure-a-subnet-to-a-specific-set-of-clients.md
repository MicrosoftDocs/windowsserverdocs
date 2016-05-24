---
title: Scenario: Secure a subnet to a specific set of clients
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 99e11404-a1fb-4789-8d2b-0d83cc1553f0
---
# Scenario: Secure a subnet to a specific set of clients
See the following sections in this topic:  
  
-   [Problem description](../Topic/Scenario--Secure-a-subnet-to-a-specific-set-of-clients.md#problem)  
  
-   [Creating a scope\-based allow\-filter list using DHCP policies](../Topic/Scenario--Secure-a-subnet-to-a-specific-set-of-clients.md#allow)  
  
-   [Creating a scope\-based deny\-filter list using DHCP policies](../Topic/Scenario--Secure-a-subnet-to-a-specific-set-of-clients.md#deny)  
  
-   [Windows PowerShell](../Topic/Scenario--Secure-a-subnet-to-a-specific-set-of-clients.md#PS)  
  
## <a name="problem"></a>Problem description  
Link\-layer \(MAC address\-based\) filtering is a feature introduced in [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)] for the DHCP Server role that enabled restriction of network access to DHCP clients based on their MAC address. A limitation of this feature is that it is only possible at the server level. With DHCP policies in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)], link\-layer filtering is now possible at the scope level.  
  
Consider a situation where you want to allow only a specific set of computers or devices on a subnet. To control which clients can be allowed on the subnet, you can configure a policy on the DHCP server to provide IP addresses only to specific clients. You can do this by creating an allow list, or a deny list.  
  
## <a name="allow"></a>Creating a scope\-based allow\-filter list using DHCP policies  
To accomplish this, create a scope\-based policy for the subnet with a condition of MAC Address Equals a1, a2, a3 where a1, a2, and a3 are the MAC addresses of known clients. See the following example.  
  
![](../Image/DHCP_pba-mac-sec1.gif)  
  
The conditions of the policy will be MAC address \= a1, a2, a3 which has a logical meaning of MAC\-address \= a1 OR MAC\-address \= a2 OR MAC address \= a3. When you are finished entering MAC addresses, click **OK** and you will see a single MAC address condition. You can edit this condition later if desired to add or remove MAC addresses from the list.  
  
![](../Image/DHCP_pba-mac-sec2.gif)  
  
You can also add each MAC address as an individual condition, but you must make sure that the **OR** radio button is selected on the conditions page. Click **Next** to continue. You can also use wildcards if desired.  
  
The IP address range for the policy will be the entire scope IP address range. The **Percentage of IP address range** value should be **100.0**. This also means that you cannot have other policies in this scope that specify an IP address range because overlapping IP address range settings are not allowed.  
  
![](../Image/DHCP_pba-mac-sec3.gif)  
  
By choosing the entire scope range for this policy, no IP addresses will be available to clients that do not match the policy conditions. A client whose MAC address does not match any of the MAC addresses specified in the policy will be denied an IP address lease by the DHCP server.  
  
Click **Next**, specify any additional DHCP options if desired, then click **Next** and click **Finish**.  
  
## <a name="deny"></a>Creating a scope\-based deny\-filter list using DHCP policies  
If you wish to block specific MAC addresses from receiving an IP address from the given scope you can configure a deny list instead of an allow list. The only difference in creating a deny list vs. the allow list configured in the previous procedure is in the conditions of the policy. Instead of specifying a MAC address list with an operator of Equals, choose the Not Equals operator instead. See the following example.  
  
![](../Image/DHCP_pba-mac-sec4.gif)  
  
> [!IMPORTANT]  
> In this case, if you specify individual MAC addresses in separate conditions, you must use the **AND** operator on the conditions page instead of the **OR** operator.  
  
The “not equal to” MAC address conditions and the entire IP address range setting will ensure that incoming client DHCP requests that are sent from computers or devices that match one of the MAC addresses on the list will not receive a lease from the DHCP server.  
  
> [!CAUTION]  
> Longs lists of conditions and values used in a “Not Equals” policy can negatively impact performance.  
  
## <a name="PS"></a>Windows PowerShell  
If you have a large number of MAC addresses that need to be added to an allow or deny list in a policy, consider using a script to create your DHCP policy. See [Scope based Link Layer filtering using DHCP Policies](http://gallery.technet.microsoft.com/scriptcenter/Scope-based-Link-Layer-64c8ab30) in the Microsoft Script Center for more information. The script takes a file as input that contains the list of \(line separated\) MAC addresses, the scope ID, and whether an allow list or deny list should be created. This script will create the appropriate policy for you.  
  
## See also  
[Introduction to DHCP Policies](../Topic/Introduction-to-DHCP-Policies.md)  
  
