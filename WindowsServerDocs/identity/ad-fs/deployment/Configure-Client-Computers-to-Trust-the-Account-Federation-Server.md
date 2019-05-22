---
ms.assetid: 4ae26970-e42e-4e69-887a-b16d2f8d0695
title: Configure Client Computers to Trust the Account Federation Server
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
ms.author: billmath
---

# Configure Client Computers to Trust the Account Federation Server

So that client computers can successfully access federated applications using Active Directory Federation Services \(AD FS\), you must first configure the Internet Explorer settings on each client computer so that the browser trusts the account federation server. You can do this manually or through Group Policy, depending on your administrative preference, by completing one of the following procedures.  
  
## Configuring Internet Explorer settings manually  
You can use the following procedure to manually configure each user's Internet Explorer settings to support federation through AD FS. If multiple users use a single computer, complete this procedure multiple times—once for each user profile.  
  
To perform this procedure, log on as the user who will be accessing federated applications. This is a profile\-specific setting. Therefore, it requires that you manually add this setting for each profile that exists on a specific computer.  
  
#### To manually configure client computers to trust the account federation server  
  
1.  On the client computer, start Internet Explorer.  
  
2.  On the **Tools** menu, click **Internet Options**.  
  
3.  On the **Security** tab, click the **Local intranet** icon, and then click **Sites**.  
  
4.  Click **Advanced**, and in **Add this Web site to the zone**, type the full Domain Name System \(DNS\) name of the account federation server \(for example, https:\/\/fs1.fabrikam.com\), and then click **Add**.  
  
5.  Click **OK** three times.  
  
## Configuring Internet Explorer settings by using Group Policy  
For most deployments, we recommend that you use Group Policy to push the appropriate Internet Explorer settings to each client computer.  
  
Membership in **Domain Admins** or **Enterprise Admins**, or equivalent, in Active Directory Domain Services \(AD DS\) is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=83477\).   
  
#### To configure client computers to trust the account federation server by using Group Policy  
  
1.  On a domain controller in the forest of the account partner organization, start the **Group Policy Management** snap\-in.  
  
2.  Find the appropriate Group Policy Object \(GPO\), right\-click it, and then click **Edit**.  
  
3.  In the console tree, open **User Configuration\\Preferences\\Windows Settings\\Internet Explorer Maintenance**, and then click **Security**.  
  
4.  In the details pane, double\-click **Security Zones and Content Ratings**.  
  
5.  Under **Security Zones and Privacy**, click **Import the current security zones and privacy settings**, and then click **Modify Settings**.  
  
6.  Click **Local intranet**, and then click **Sites**.  
  
7.  In **Add this Web site to the zone**, type the full DNS name of the account federation server \(for example, https:\/\/fs1.fabrikam.com\), click **Add**, and then click **Close**.  
  
8.  Click **OK** two times to apply these changes to Group Policy.  
  
