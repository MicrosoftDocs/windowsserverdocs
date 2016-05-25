---
title: Configure the Site Link Interval to Identify How Often Replication Polling Can Occur During the Schedule Window
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 94d5a629-7176-4fe5-9db3-08e33fb6aa5b
author: Femila
---
# Configure the Site Link Interval to Identify How Often Replication Polling Can Occur During the Schedule Window
  Bridgehead servers initiate intersite replication by polling their replication partners. You configure the polling schedule on the site link object in Active Directory Domain Services \(AD DS\). You can use this procedure and the properties on the site link object to determine how often during the available replication schedule you want bridgehead servers to poll their intersite replication partners for changes. Obtain the interval value from your design team.  
  
> [!NOTE]  
>  Intersite connection objects also have a schedule; they inherit their schedule and interval from the site link object.  
  
 Membership in **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To configure the site link interval  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In the console tree, expand **Sites** and **Inter\-Site Transports**, and then click **IP**.  
  
3.  In the details pane, right\-click the site link object that you want to configure, and then click **Properties**.  
  
4.  In **Replicate every \_\_\_\_\_ minutes**, specify the number of minutes for the intervals at which replication polling occurs during an open schedule, and then click **OK**.  
  
  