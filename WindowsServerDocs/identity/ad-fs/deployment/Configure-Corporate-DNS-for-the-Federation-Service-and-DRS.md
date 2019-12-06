---
ms.assetid: aca4a4fa-b12c-4eed-a499-f9aedb7d2fd6
title: Configure Corporate DNS for the Federation Service and DRS
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Configure Corporate DNS for the Federation Service and DRS
  
## Step 6: Add a Host \(A\) and Alias \(CNAME\) Resource Record to Corporate DNS for the Federation Service and DRS  
You must add the following resource records to corporate Domain Name System \(DNS\) for your federation service and Device Registration Service that you configured in previous steps.  
  
|Entry|Type|Address|  
|---------|--------|-----------|  
|federation\_service\_name|Host \(A\)|IP address of the AD FS server or the IP address of the load balancer that is configured in front of your AD FS server farm|  
|enterpriseregistration|Alias \(CNAME\)|federation\_server\_name.contoso.com|  
  
You can use the following procedure to add a host \(A\) and alias \(CNAME\) resource records to corporate DNS for the federation server and the Device Registration Service.  
  
Membership in **Administrators**, or equivalent, is the minimum requirement to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).   
  
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

[AD FS Deployment](../../ad-fs/AD-FS-Deployment.md)  

[Windows Server 2012 R2 AD FS Deployment Guide](../../ad-fs/deployment/Windows-Server-2012-R2-AD-FS-Deployment-Guide.md)  
 
[Deploying a Federation Server Farm](../../ad-fs/deployment/Deploying-a-Federation-Server-Farm.md)  
  

