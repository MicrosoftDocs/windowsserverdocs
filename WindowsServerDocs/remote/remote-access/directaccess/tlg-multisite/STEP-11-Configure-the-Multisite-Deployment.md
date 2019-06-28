---
title: STEP 11 Configure the Multisite Deployment
description: This topic is part of the Test Lab Guide - Demonstrate a DirectAccess Multisite Deployment for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8cbdeb1d-5f7c-4360-bcc1-ab40d3cd8040
ms.author: pashort
author: shortpatti
---
# STEP 11 Configure the Multisite Deployment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

To configure a multisite deployment, make changes to the current Remote Access configuration wizard on EDGE1, enable the multisite feature, and then add 2-EDGE1 as a second entry point.  
  
- Configure Remote Access on EDGE1  
  
- Enable multisite configuration on EDGE1  
  
- Add 2-EDGE1 as a second entry-point  
  
## <a name="configDA"></a>Configure Remote Access on EDGE1  
  
1.  On the **Start** screen, type**RAMgmtUI.exe**, and then press ENTER. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  In the Remote Access Management Console, click **Configuration**.  
  
3.  In the middle pane of the console, in the **Step 2 Remote Access Server** area, click **Edit**.  
  
4.  Click **Prefix Configuration**. On the **Prefix Configuration** page, in **Internal network IPv6 prefixes**, enter **2001:db8:1::/64; 2001:db8:2::/64**. In **IPv6 prefix assigned to DirectAccess client computers**, enter **2001:db8:1:1000::/64**, click **Next**, and then click **Finish**.  
  
5.  In the middle pane of the console, in the **Step 3 Infrastructure Servers** area, click **Edit**.  
  
6.  Click **DNS Suffix Search List**. On the **DNS Suffix Search List** page, make sure that the **Configure DirectAccess clients with DNS client suffix search list** check box is selected and that the **corp.contoso.com** and **corp2.corp.contoso.com** domain suffixes appear in the **Domain suffixes to use** list, click **Next**, and then click Finish.  
  
7.  In the middle pane of the console, click **Finish**.  
  
8.  On the **Remote Access Review** dialog box, review the configuration settings, and then click **Apply**. On the **Applying Remote Access Setup Wizard Settings** dialog box, click **Close**.  
  
9. In the **Tasks** pane, click **Refresh Management Servers**, and click **Close** when finished.  
  
## <a name="EnabledMultisite"></a>Enable multisite configuration on EDGE1  
  
1.  In the Remote Access Management Console, in the **Tasks** pane, click **Enable Multisite**.  
  
2.  In the Enable Multisite Deployment wizard, on the **Before You Begin** page, click **Next**.  
  
3.  On the **Deployment Name** page, in **Multisite deployment name**, type **Contoso**, in **First entry point name**, type **Edge1-Site**, and then click **Next**.  
  
4.  On the **Entry Point Selection** page, click **Assign entry points automatically, and allow clients to select manually**, and then click **Next**.  
  
5.  On the **Global Load Balancing** page, click **No, do not use global load balancing**, and then click **Next**.  
  
6.  On the **Client Support** page, click **Allow client computers running Windows 7 to access this entry point**, and click **Add**.  
  
7.  On the **Select Groups** dialog box, in **Enter the object names to select**, type **Win7_Clients_Site1**, click **OK**, and then click **Next**.  
  
8.  On the **Client GPO Settings** page, click **Next**.  
  
9. On the **Summary** page, click **Commit**.  
  
10. On the **Enabling Multisite Deployment** dialog box, click **Close** and then on the Enable Multisite Deployment wizard, click **Close**.  
  
## <a name="AddEP"></a>Add 2-EDGE1 as a second entry-point  
  
1.  In the Remote Access Management Console, in the **Tasks** pane, click **Add an Entry Point**.  
  
2.  In the Add an Entry Point Wizard, on the **Entry Point Details** page, in **Remote Access server**, type **2-edge1.corp2.corp.contoso.com**, in **Entry point name**, type **2-Edge1-Site**, and then click **Next**.  
  
3.  On the **Network Topology** page, click **Edge**, and then click **Next**.  
  
4.  On the **Network Name or IP Address** page, in **Type in the public name or IP address used by clients to connect to the Remote Access server**, type **2-edge1.contoso.com**, and then click **Next**.  
  
5.  On the **Network Adapters** page, make sure that the **External adapter** is **Internet**, the **Internal adapter** is **2-Corpnet**, the certificate is **CN=2-edge1.contoso.com**, and then click **Next**.  
  
6.  On the **Prefix Configuration** page, in **IPv6 prefix assigned to DirectAccess client computers**, type **2001:db8:2:2000::/64**, and then click **Next**.  
  
7.  On the **Client Support** page, click **Allow client computers running Windows 7 to access this entry point**, and click **Add**.  
  
8.  On the **Select Groups** dialog box, in **Enter the object names to select**, type **Win7_Clients_Site2**, click **OK**, and then click **Next**.  
  
9. On the **Client GPO Settings** page, click **Next**.  
  
10. On the **Server GPO Settings** page, click **Next**.  
  
11. On the **Summary** page click **Commit**.  
  
12. On the **Adding Entry Point** dialog box, click **Close** and then on the Add an Entry Point wizard, click **Close**.  
  


