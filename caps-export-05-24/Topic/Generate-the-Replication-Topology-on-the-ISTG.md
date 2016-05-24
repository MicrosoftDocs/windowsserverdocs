---
title: Generate the Replication Topology on the ISTG
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: af59ba34-bd3b-49c8-b84d-a43694e5d818
author: Femila
---
# Generate the Replication Topology on the ISTG
  You can use this procedure to generate the intersite replication topology on the intersite topology generator \(ISTG\). The Knowledge Consistency Checker \(KCC\) generates the Active Directory replication topology on every domain controller. The KCC runs by default every 15 minutes.  
  
 You can force the KCC to run on any domain controller. The topology that is generated depends on the domain controller on which you run the command. You can force the KCC to run as follows:  
  
-   To generate the intersite replication topology, run the KCC on the domain controller in the site that holds the ISTG role.  
  
-   To generate the intrasite replication topology, run the KCC on any domain controller in the site that does not hold the ISTG role.  
  
> [!NOTE]  
>  To generate the replication topology on the ISTG, you must first complete the procedure: [Determine the ISTG Role Owner for a Site](../Topic/Determine-the-ISTG-Role-Owner-for-a-Site.md).  
  
 Membership in **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To generate the replication topology on the ISTG  
  
1.  Determine the server that holds the ISTG role for the site.  
  
2.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
3.  In the console tree, expand **Sites**, and then expand the site that contains the ISTG on which you want to run the KCC.  
  
4.  Expand **Servers**, and then click the **Server** object for the ISTG.  
  
5.  In the details pane, right\-click **NTDS Settings**, click **All Tasks**, and then click **Check Replication Topology**.  
  
6.  In the **Check Replication Topology** message box, click **OK**.  
  
  