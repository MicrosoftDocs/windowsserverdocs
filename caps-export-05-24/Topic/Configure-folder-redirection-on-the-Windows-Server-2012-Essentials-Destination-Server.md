---
title: Configure folder redirection on the Windows Server 2012 Essentials Destination Server
ms.custom: na
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fe77ba67-128c-4fc3-9361-30fa6af42516
---
# Configure folder redirection on the Windows Server 2012 Essentials Destination Server
Perform this task if folder redirection is enabled on the Source Server.  
  
First, delete the old Folder Redirection Group Policy setting. Then use the [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] Dashboard to enable folder redirection on the Destination Server.  
  
### To delete the old Folder Redirection Group Policy setting  
  
1.  On the Destination Server, open the **Group Policy Management** administrative tool.  
  
2.  In **Group Policy Management**, expand **Forest:***YourNetworkDomainName*, expand **Domains**, expand *YourNetworkDomainName*, and then expand **Group Policy Objects**.  
  
3.  Right\-click **SBS Group Policy Folder Redirection**, and then click **Delete**.  
  
4.  Right\-click **SBS Group Policy Security Templates**, and then click **Delete**.  
  
5.  Read the warning, and then click **Yes**.  
  
6.  Close **Group Policy Management**.  
  
### To enable folder redirection on the Destination Server  
  
1.  On the Destination Server, open the [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] Dashboard.  
  
2.  In the navigation bar, click **Devices**.  
  
3.  In the **Devices Tasks** pane, click **Implement Group Policy**.  
  
4.  On the **Enable Folder Redirection Group Policy** page, select the folders to be redirected, and then click **Next**.  
  
5.  On the **Enable Security Policy Settings** page, click **Finish**.  
  
To apply the change to folder redirection, network users must log off their computer, and then log back on. This ensures the transfer of all redirected folders to the Destination Server.  
  
