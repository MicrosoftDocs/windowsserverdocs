---
title: Reducing the Workload on the PDC Emulator Master
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 588335f8-1794-48e8-8b36-faf374e66fd6
author: Femila
---
# Reducing the Workload on the PDC Emulator Master
  In addition to processing normal domain controller load from clients, the primary domain controller \(PDC\) emulator operations master must also process password changes. Of all the operations master \(also known as flexible single master operations or FSMO\) roles, the PDC emulator master role has the highest impact on the domain controller that hosts that role. To mitigate some of the load that is caused by normal domain controller traffic, you can protect the PDC emulator by configuring Domain Name System \(DNS\) to distribute some of the normal request load to other domain controllers that are capable of processing the requests.  
  
 To receive information from the domain, a client uses DNS to locate a domain controller. The client then sends the request to that domain controller. By default, DNS performs rudimentary load balancing. It also randomizes the distribution of client requests so that the requests are not always sent to the same domain controller. If too many client requests are sent to a domain controller while it attempts to perform other duties, such as the duties of the PDC emulator, it can become overloaded, which has a negative impact on its performance.  
  
 You can configure DNS so that a domain controller is queried less frequently than others. Reducing the number of client requests helps reduce the workload on a domain controller, which gives it more time to function as an operations master. This is especially important for the PDC emulator.  
  
 To reduce the number of client requests that are processed by the PDC emulator, you can change its weight or its priority in the DNS environment.  
  
## Changing the weight for DNS service \(SRV\) resource records in the registry  
 Changing the weight of a domain controller to a value less than that of other domain controllers reduces the number of clients that Domain Name System \(DNS\) refers to that domain controller. This value is stored in the **LdapSrvWeight** registry entry. The default value is 100, but it can range from 0 through 65535. When you lower this value on a domain controller, DNS refers clients to that domain controller less frequently based on the proportion of this value to the value on other domain controllers. For example, to configure the system so that the domain controller that hosts the PDC emulator role receives requests only half as many times as other domain controllers, configure the weight of the domain controller that host the PDC emulator role to be 50. Assuming that other domain controllers use the default weight value of 100, DNS determines the weight ratio for that domain controller to be 50\/100 \(50 for that domain controller and 100 for the other domain controllers\). After you reduce this ratio to 1\/2, DNS refers clients to the other domain controllers twice as often as it refers to the domain controller with the reduced weight setting. By reducing client referrals, the domain controller receives fewer client requests and has more resources for other tasks, such as performing the role of PDC emulator.  
  
## Changing the priority for DNS service \(SRV\) resource records in the registry  
 Changing the priority of a domain controller also reduces the number of client referrals to it. However, rather than reducing access to the domain controller proportionally with regard to the other domain controllers, changing the priority causes Domain Name System \(DNS\) to stop referring all clients to this domain controller unless all domain controllers with a lower priority setting are unavailable.  
  
 To prevent clients from sending all requests to a single domain controller, the domain controllers are assigned a priority value. This value is stored in the **LdapSrvPriority** registry entry. The default value is 0, but it can range from 0 through 65535. The client uses the priority value to help determine to which domain controller it sends requests. When a client uses DNS to discover a domain controller, the priority for a given domain controller is returned to the client with the rest of the DNS information. Clients always send requests to the domain controller that has the lowest priority value. If more than one domain controller has the same value, the clients randomly choose from the group of domain controllers with the same value. If no domain controllers with the lowest priority value are available, the clients send requests to the domain controller with the next highest priority. Therefore, raising the value of the **LdapSrvPriority** registry entry on the PDC emulator can reduce its chances of receiving client requests.  
  
 **Task requirements**  
  
 The following tool is required to perform the procedures for this task:  
  
-   Regedit.exe  
  
 To complete this task, perform the following procedures:  
  
1.  [Change the Weight for DNS Service &#40;SRV&#41; Resource Records in the Registry](../Topic/Change-the-Weight-for-DNS-Service--SRV--Resource-Records-in-the-Registry.md)  
  
2.  [Change the Priority for DNS Service &#40;SRV&#41; Resource Records in the Registry](../Topic/Change-the-Priority-for-DNS-Service--SRV--Resource-Records-in-the-Registry.md)  
  
  