---
title: Configure Corporate DNS for the Federation Service and DRS
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 347e564a-45f6-418b-8520-cdba680b00a5
author: billmath
---
# Configure Corporate DNS for the Federation Service and DRS
  
## Step 6: Add a Host \(A\) and Alias \(CNAME\) Resource Record to Corporate DNS for the Federation Service and DRS  
You must add the following resource records to corporate Domain Name System \(DNS\) for your federation service and Device Registration Service that you configured in previous steps.  
  
|Entry|Type|Address|  
|---------|--------|-----------|  
|federation\_service\_name|Host \(A\)|IP address of the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server or the IP address of the load balancer that is configured in front of your [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server farm|  
|enterpriseregistration|Alias \(CNAME\)|federation\_server\_name.contoso.com|  
  
You can use the following procedure to add a host \(A\) and alias \(CNAME\) resource records to corporate DNS for the federation server and the Device Registration Service.  
  
Membership in **Administrators**, or equivalent, is the minimum requirement to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To add a host \(A\) and alias \(CNAME\) resource records to DNS for your federation server  
  
1.  On you domain controller, in Server Manager, on the **Tools** menu, click **DNS** to open the DNS snap\-in.  
  
2.  In the console tree, expand the **domain\_controller\_name** node, expand **Forward Lookup Zones**, right\-click **domain\_name**, and then click **New Host \(A or AAAA\)**.  
  
3.  In the **Name** box, type the name to use for your AD FS farm.  
  
4.  In the **IP address** box, type the IP address of your federation server. Click **Add Host**.  
  
5.  Right\-click the **domain\_name** node, and then click **New Alias \(CNAME\)**.  
  
6.  In the **New Resource Record** dialog box, type **enterpriseregistration** in the **Alias name** box.  
  
7.  In the fully qualified domain name \(FQDN\) of the target host box, type **federation\_service\_farm\_name.domain\_name.com**, and then click **OK**.  
  
    > [!IMPORTANT]  
    > In a real world deployment, if your company has multiple User Principal Name \(UPN\) suffixes, you must create multiple CNAME records for each of those UPN suffixes in DNS.  
  
## See Also  
[Deploying a Federation Server Farm](../Topic/Deploying-a-Federation-Server-Farm.md)  
  
