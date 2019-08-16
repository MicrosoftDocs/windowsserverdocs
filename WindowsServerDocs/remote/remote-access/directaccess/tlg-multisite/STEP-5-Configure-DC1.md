---
title: STEP 5 Configure DC1
description: This topic is part of the Test Lab Guide - Demonstrate a DirectAccess Multisite Deployment for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 70357156-fcb0-4346-a61e-4ea963e3ffb0
ms.author: pashort
author: shortpatti
---
# STEP 5 Configure DC1

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

DC1 acts as a domain controller, DNS server, and DHCP server for the corp.contoso.com domain.  
  
To configure Remote Access to use a multisite topology, it is necessary to add an additional Active Directory Domain Services (AD DS) site for the second domain controller 2-DC1, and to configure routing between the subnets.  
  
1. To configure the default gateway on the domain controller. Configure the default gateway on DC1.  
  
2. Create security groups for Windows 7 DirectAccess clients on DC1. When DirectAccess is configured, it automatically creates Group Policy Objects (GPOs) and GPO settings that are applied to DirectAccess clients and servers. The DirectAccess client GPO is applied to specific Active Directory security groups.  
  
3. To add a new AD DS site. Create a second AD DS site.  
  
## To configure the default gateway on the domain controller  
  
1.  In the Server Manager console, click **Local Server**, and then in the **Properties** area, next to **Wired Ethernet Connection**, click the link.  
  
2.  In the Network Connections window, right-click **Wired Ethernet Connection**, and then click **Properties**.  
  
3.  Click **Internet Protocol Version 4 (TCP/IPv4)**, and then click **Properties**.  
  
4.  In **Default gateway**, type **10.0.0.254**, and in **Alternate DNS server**, type **10.2.0.1**, and then click **OK**.  
  
5.  Click **Internet Protocol Version 6 (TCP/IPv6)**, and then click **Properties**.  
  
6.  In **Default gateway**, type **2001:db8:1::fe**, and in **Alternate DNS server**, type **2001:db8:2::1**, and then click **OK**.  
  
7.  On the **Wired Ethernet Connection Properties** dialog box, click **Close**.  
  
8.  Close the **Network Connections** window.  
  
## Create security groups for Windows 7 DirectAccess clients on DC1  
Create the DirectAccess security groups for  Windows 7  with the following procedure.  
  
 Windows 7  client computers must be members of separate security groups because they are able to connect to internal resources through a single entry point only. When enabling Multisite support or adding entry points, if  Windows 7  support is requested, then a separate GPO will be automatically created by DirectAccess for  Windows 7  clients for each entry point.  
  
### Create security groups  
  
1.  On the **Start** screen, type**dsa.msc**, and then press ENTER.  
  
2.  In the left pane, expand **corp.contoso.com**, click **Users**, then right-click **Users**, point to **New**, and then click **Group**.  
  
3.  On the **New Object - Group** dialog box, under **Group name**, enter **Win7_Clients_Site1**.  
  
4.  Under **Group scope**, click **Global**, under **Group type**, click **Security**, and then click **OK**.  
  
5.  Double-click the **Win7_Clients_Site1** security group, and on the **Win7_Clients_Site1 Properties** dialog box, click the **Members** tab.  
  
6.  On the **Members** tab, click **Add**.  
  
7.  On the **Select Users, Contacts, Computers, or Service Accounts** dialog box, click **Object Types**. On the **Object Types** dialog box, select **Computers**, and then click **OK**.  
  
8.  In **Enter the object names to select**, type **client2**, and then click **OK**, and then on the **Win7_Clients_Site1 Properties** dialog box click **OK**.  
  
9. In the **Active Directory Users and Computers** console, in the left pane, right-click **Users**, point to **New**, and then click **Group**.  
  
10. On the **New Object - Group** dialog box, under **Group name**, enter **Win7_Clients_Site2**.  
  
11. Under **Group scope**, click **Global**, under **Group type**, click **Security**, and then click **OK**.  
  
12. Close the **Active Directory Users and Computers** console.  
  
## To add a new AD DS site  
  
1.  On the **Start** screen, type**dssite.msc**, and then press ENTER.  
  
2.  In the Active Directory Sites and Services console, in the console tree, right-click **Sites**, and then click **New Site**.  
  
3.  On the **New Object - Site** dialog box, in the **Name** box, type **Second-Site**.  
  
4.  In the list box, click **DEFAULTIPSITELINK**, and then click **OK** twice.  
  
5.  In the console tree, expand **Sites**, right-click **Subnets**, and then click **New Subnet**.  
  
6.  On the **New Object - Subnet** dialog box, under **Prefix**, type **10.0.0.0/24**, in the **Select a site object for this prefix** list, click **Default-First-Site-Name**, and then click **OK**.  
  
7.  In the console tree, right-click **Subnets**, and then click **New Subnet**.  
  
8.  On the **New Object - Subnet** dialog box, under **Prefix**, type **2001:db8:1::/64**, in the **Select a site object for this prefix** list, click **Default-First-Site-Name**, and then click **OK**.  
  
9. In the console tree, right-click **Subnets**, and then click **New Subnet**.  
  
10. On the **New Object - Subnet** dialog box, under **Prefix**, type **10.2.0.0/24**, in the **Select a site object for this prefix** list, click **Second-Site**, and then click **OK**.  
  
11. In the console tree, right-click **Subnets**, and then click **New Subnet**.  
  
12. On the **New Object - Subnet** dialog box, under **Prefix**, type **2001:db8:2::/64**, in the **Select a site object for this prefix** list, click **Second-Site**, and then click **OK**.  
  
13. Close Active Directory Sites and Services.  
  


