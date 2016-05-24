---
title: Create AD DS Site Links
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: a5d0befc-9138-4502-846d-80b7f403ce21
author: Femila
---
# Create AD DS Site Links
Create the Active Directory Domain Services \(AD DS\) site links that are specified in the site topology design that is provided by your design team.  
  
Membership in the Enterprise Admins group in the forest or the Domain Admins group in the forest root domain, or equivalent, is the minimum requirement to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To create an AD DS site link  
  
1.  To open the Active Directory Sites and Services snap\-in, click **Start**, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In Active Directory Sites and Services, in the console tree, right\-click the intersite transport protocol that you want the site link to use.  
  
    **Where?**  
  
    -   Active Directory Sites and Services\/Sites\/Inter\-Site Transports\/IP  
  
    or  
  
    -   Active Directory Sites and Services\/Sites\/Inter\-Site Transports\/SMTP  
  
3.  Click **New Site Link**.  
  
4.  In **Name**, type the name for the site link.  
  
5.  In **Sites not in this site link**, click a site to add to the site link, and then click **Add**.  
  
    Repeat this step to add more sites to the site link. To remove a site from the site link, in **Sites in this link**, click the site, and then click **Remove**.  
  
6.  When you have added the sites that you want to be connected by this site link, click **OK**.  
  
> [!IMPORTANT]  
> Use the IP intersite transport unless your network has remote sites where network connectivity is intermittent or end\-to\-end IP connectivity is not available. Simple Mail Transfer Protocol \(SMTP\) replication is not enabled by default, and it has restrictions that do not apply to IP replication.  
  
