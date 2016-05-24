---
title: Configure WSUS for Roaming Client Computers
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7944571d-5149-4f69-814e-d0daeaef2f7f
author: britw
---
# Configure WSUS for Roaming Client Computers
If your organization supports roaming users, you can configure [!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] 3.0 SP2 to optimize downloads for those users’ computers.  
  
A roaming user logs on to the network by using the same computer from various geographical locations. With the proper configuration, these computers can always download approved updates from the WSUS server that is nearest to their current connection point.  
  
The instructions in this topic assume that the network has several different DNS subnets, and that you will install WSUS servers in the subnets.  
  
> [!IMPORTANT]  
> The user account that is used to configure DNS must have the appropriate domain\-level credentials. For more information about domain\-level security, see [Local and Domain Default Groups](http://go.microsoft.com/fwlink/?LinkID=203239). We recommend that you confer with your DNS and network administrators before you perform these procedures.  
  
To configure WSUS for roaming client computers, you must perform the following steps:  
  
1.  **Identify the WSUS server in each subnet**  
  
    Identify one server in each subnet to use as a WSUS server. Record each server’s static IP address.  
  
2.  **Set up DNS host \(A\) resource records**  
  
    On the DNS server, set up a *DNS host \(A\) resource record* for each planned WSUS server. Use the same host name for each planned WSUS server. For more information about how to add DNS host \(A\) resource records, see [Adding Resource Records](http://go.microsoft.com/fwlink/?LinkID=203005) and [Add a host \(A or AAAA\) resource record to a zone](http://go.microsoft.com/fwlink/?LinkID=203006).  
  
3.  **Set up the DNS server for netmask ordering and round robin**  
  
    *Netmask ordering* restricts DNS name resolution to computers in the same subnet. If there are multiple name resolutions, *round robin* will rotate through the list of available hosts to return a result. By enabling these two DNS features, you ensure that when a client computer requests a WSUS server, any WSUS server on the same subnet is returned first. If any subnet does not have a WSUS server, host name resolution for client computers in that subnet will rotate through the list of WSUS servers in other subnets.  
  
    For a more comprehensive understanding of netmask ordering and round robin in DNS, see [Description of the netmask ordering feature and the round robin feature in Windows Server DNS](http://go.microsoft.com/fwlink/?LinkID=203242).  
  
    To set up netmask ordering and round robin, perform the following procedure on the DNS server:  
  
    ### Set up netmask ordering and round robin  
  
    1.  Logon to the DNS server by using an account that has the appropriate domain\-level privileges.  
  
    2.  Click **Start**, click **All Programs**, click **Administrative Tools**, and then click **DNS**.  
  
    3.  In the DNS console, right\-click the DNS server node, and then click **Properties**.  
  
    4.  Click the **Advanced** tab.  
  
    5.  In the **Server options** box, select the **Enable round robin** and **Enable netmask ordering** check boxes.  
  
    6.  Click **OK**.  
  
4.  **Install the WSUS servers**  
  
    Install and configure the WSUS servers on the subnets. For information about how to install a WSUS server, see [Install the WSUS 3.0 SP2 Server](assetId:///2cd2d2ac-47e8-461f-99bd-db6bd3af1dfc).  
  
5.  **Configure the roaming client computers to use the same host name**  
  
    You must configure each roaming client computer to use the same host name that you used to set up the DNS host \(A\) resource records. You can configure this setting in either of the following ways:  
  
    -   By using Group Policy, as described in the “Specify intranet Microsoft Update service location” section of [Configure Automatic Updates using Group Policy](../Topic/Configure-Automatic-Updates-using-Group-Policy.md).  
  
    -   By using Registry Editor to set the **WUServer** and **WUStatusServer** keys, as described in [Configure Automatic Updates using Registry Editor](../Topic/Configure-Automatic-Updates-using-Registry-Editor.md).  
  
## See Also  
[DNS structure](http://go.microsoft.com/fwlink/?LinkID=203237)  
[Managing Resource Records](http://go.microsoft.com/fwlink/?LinkID=203238)  
  
