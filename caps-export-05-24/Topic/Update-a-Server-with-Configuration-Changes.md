---
title: Update a Server with Configuration Changes
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: e7af4810-e194-46e4-b7f5-974338943310
author: Femila
---
# Update a Server with Configuration Changes
  On a domain controller that is running Windows Server 2008, you can use this procedure to force replication of configuration changes to a domain controller that is not receiving replication as a result of configuration errors. This procedure is particularly useful for updating a read\-only domain controller \(RODC\) in a branch site with configuration changes from a hub site, for example, when a site link object has been inadvertently deleted.  
  
 You can complete this procedure by using either the Windows interface or the Repadmin command\-line tool.  
  
 Membership in **Enterprise Admins** in the forest or **Domain Admins** in the forest root domain, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To use the Windows interface to update a server with configuration changes  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In the console tree, expand **Sites**, and then expand the site of the domain controller that you want to receive configuration updates.  
  
3.  Expand the **Servers** container to display the list of servers that are currently configured for that site.  
  
4.  Double\-click the server object that requires the configuration updates that you want to replicate.  
  
5.  Right\-click **NTDS Settings** below the server object, and then click **Replicate configuration to the selected DC**.  
  
6.  In the **Replicate Now** message box, click **OK**.  
  
### To use Repadmin to update a server with configuration changes  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Enterprise Admins credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `repadmin /showrepl <ServerName>`  
  
     Where \<ServerName\> is the name of the domain controller that has the configuration changes that you want to replicate. The `/showrepl` switch provides the globally unique identifier \(GUID\) information that you need for step 6.  
  
3.  Click the **Command Prompt** menu in the title bar, click **Edit**, and then click **Mark**.  
  
4.  Use the cursor to select the value in `DSA object GUID`.  
  
5.  Click the **Command Prompt** menu in the title bar, and then click **Copy**. Use the **Paste** command on the **Command Prompt** menu to paste this value for the `<SourceDomainControllerGUID>` parameter in the next step.  
  
6.  At the command prompt, type the following command, and then press ENTER:  
  
     `repadmin /sync <ConfigurationDistinguishedName> <DestinationServerName> <SourceDomainControllerGUID>`  
  
    |Value|Description|  
    |-----------|-----------------|  
    |\/sync|Synchronizes replication of the specified directory partition between the specified domain controllers|  
    |\<ConfigurationDistinguishedName\>|The configuration directory partition distinguished name: CN\=Configuration,DC\=*ForestRootDomainName*|  
    |\<DestinationServerName\>|The name of the domain controller that is to receive the configuration updates, for example, DC3B.|  
    |\<SourceDomainControllerGUID\>|The Directory System Agent \(DSA\) GUID of the domain controller that is forcing replication.|  
  
  