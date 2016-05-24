---
title: Verify Global Catalog Readiness
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 0463c574-dccf-4dc9-bd41-53f442b57cbf
author: Femila
---
# Verify Global Catalog Readiness
  When a global catalog server has satisfied replication requirements, the **isGlobalCatalogReady rootDSE** attribute is set to **TRUE**, and the global catalog is ready to serve clients. You can use this procedure to verify global catalog readiness.  
  
 Membership in **Domain Users** and the right to log on locally to a domain controller is the minimum required to complete this procedure. By default, members of **Account Operators**, **Administrators**, **Enterprise Admins**, **Domain Admins**, **Backup Operators**, **Print Operators**, and **Server Operators** have the right to log on locally to a domain controller. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Verifying global catalog readiness  
  
-   [Using the Windows interface](#bkmk_gui)  
  
-   [Using a command prompt](#bkmk_cmd)  
  
###  <a name="bkmk_gui"></a>   
##### To verify global catalog readiness using the Windows interface  
  
1.  Click **Start**, click **Run**, type **Ldp**, and then click **OK**.  
  
2.  On the **Connection** menu, click **Connect**.  
  
3.  In **Connect**, type the name of the server whose global catalog readiness you want to verify.  
  
4.  In **Port**, if 389 is not showing, type **389**.  
  
5.  If the **Connectionless** check box is selected, clear it, and then click **OK**.  
  
6.  In the details pane, verify that the **isGlobalCatalogReady** attribute has a value of **TRUE**.  
  
7.  On the **Connection** menu, click **Disconnect**, and then close Ldp.  
  
###  <a name="bkmk_cmd"></a>   
##### To verify global catalog readiness using a command prompt  
  
1.  Open a Command Prompt.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `nltest /server:<servername> /dsgetdc:<domainname>`  
  
    |Parameter|Description|  
    |---------------|-----------------|  
    |\<servername\>|Specifies the name of the domain controller that you have designated as a global catalog server.|  
    |\<domainname\>|Specifies the name of the domain to which the server belongs.|  
  
3.  In the `Flags:` line of the output, if `GC` appears, the global catalog server has satisfied its replication requirements.  
  
  