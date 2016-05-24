---
title: Enable Aging and Scavenging for DNS
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 7972082c-22a1-44fc-8e39-841f7327b605
author: Femila
---
# Enable Aging and Scavenging for DNS
Stale resource records can accumulate in zone data over time. To allow automatic cleanup and removal of stale resource records, you enable aging and scavenging on [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain controllers running the Domain Name System \(DNS\) Server service.  
  
Stale resource records can result from performing dynamic updates because that process automatically adds resource records to zones when computers start on the network. In some cases, those resource records are not automatically removed when computers leave the network. For example, if a computer registers its own host \(A\) resource record at startup, and then is improperly disconnected from the network, its host \(A\) resource record might not be deleted. If your network has mobile users and computers, this situation can occur frequently.  
  
If they are left unmanaged, the presence of stale resource records in zone data can cause the following problems:  
  
-   If a large number of stale resource records remain in server zones, they can eventually take up server disk space and cause unnecessarily long zone transfers.  
  
-   DNS servers that load zones with stale resource records might use outdated information to answer client queries, which can cause the clients to experience name resolution problems on the network.  
  
-   The accumulation of stale resource records on a DNS server can degrade its performance and responsiveness.  
  
    > [!NOTE]  
    > By default, the aging and scavenging mechanism for the DNS Server service is disabled. Enable aging and scavenging only after you understand all parameters. Otherwise, you might unintentionally configure the server to delete resource records that it should not delete. If a required resource record is deleted, not only will users fail to resolve queries for that resource record, but also any user can create the resource record and take ownership of it, even on zones that are configured for secure dynamic updates.  
  
To enable the aging and scavenging features, you perform the following steps to configure the applicable server and any of its zones that are integrated with Active Directory Domain Services \(AD DS\):  
  
-   Enable aging and scavenging for the DNS server.  
  
    These settings determine the effect of zone\-level properties for any zones that are integrated with AD DS and loaded at the server.  
  
-   Enable aging and scavenging for specified zones on the DNS server.  
  
    When you set zone\-level properties for a specified zone, these settings apply only to that zone and its resource records. Unless you otherwise configure these zone\-level properties, they inherit their default settings from comparable settings that AD DS maintains in the aging and scavenging properties for the DNS server.  
  
-   For more information about aging and scavenging, see Using DNS Aging and Scavenging \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93661](http://go.microsoft.com/fwlink/?LinkId=93661)\).  
  
## Enable aging and scavenging for the DNS server  
Membership in the local Administrators group is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To enable aging and scavenging for the DNS server  
  
1.  To open DNS Manager, click **Start**, click **Administrative Tools**, and then click **DNS**.  
  
    > [!NOTE]  
    > You can also access DNS Manager by expanding the **Roles** node in Server Manager.  
  
2.  In the DNS console tree, right\-click the applicable DNS server, and then click **Properties**.  
  
3.  Click the **Advanced** tab.  
  
4.  Select the **Enable automatic scavenging of stale records** check box.  
  
5.  To adjust the **Scavenging period**, in the drop\-down list, select an interval in either hours or days, and then type a number in the text box  
  
6.  Click **OK**.  
  
## Enable aging and scavenging for the selected zones on the DNS server  
Membership in the local Administrators group is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To set aging and scavenging properties for a zone  
  
1.  To open DNS Manager, click **Start**, click **Administrative Tools**, and then click **DNS**.  
  
    > [!NOTE]  
    > You can also access DNS Manager by expanding the **Roles** node in Server Manager.  
  
2.  In the DNS console tree, right\-click the applicable zone, and then click **Properties**.  
  
3.  On the **General** tab, click **Aging**, and then select the **Scavenge stale resource records** check box.  
  
4.  Modify other aging and scavenging properties as needed.  
  
