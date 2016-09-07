---
title: "Enable folder redirection on the Windows Server 2012 Essentials Destination Server2"
ms.custom: na
ms.date: 10/03/2012
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
H1: Enable folder redirection on the Windows Server 2012 Essentials Destination Server
applies_to: 
  - Windows Server 2012 Essentials
  - Windows Server 2012 R2 Essentials
ms.assetid: 7e6e3b26-bad1-4dcb-b024-e7c506a5d975
caps.latest.revision: 4
author: DonGill
manager: stevenka
translation.priority.ht: 
  - de-at
  - de-de
  - es-es
  - fr-be
  - fr-fr
  - it-ch
  - it-it
  - ja-jp
  - ko-kr
  - pt-br
  - ru-ru
  - zh-cn
  - zh-tw
---
# Enable folder redirection on the Windows Server 2012 Essentials Destination Server2
You can perform this task if folder redirection is enabled on the Source Server.  
  
 First, use the [!INCLUDE[sbs_sbs8web_2](../install/includes/sbs_sbs8web_2_md.md)] Dashboard to enable folder redirection on the Destination Server. Then, delete the old Folder Redirection Group Policy setting.  
  
### To enable folder redirection on the Destination Server  
  
1.  On the Destination Server, open the [!INCLUDE[sbs_sbs8web_2](../install/includes/sbs_sbs8web_2_md.md)] Dashboard.  
  
2.  In the navigation bar, click **DEVICES**.  
  
3.  In the **Devices Tasks** pane, click **Implement Group Policy**.  
  
4.  On the **Enable Folder Redirection Group Policy** page, select the folders to be redirected, and then click **Next**.  
  
5.  On the **Enable Security Policy Settings** page, click **Finish**.  
  
### To delete the old Folder Redirection Group Policy setting  
  
1.  On the Destination Server, open the **Group Policy Management** administrative tool.  
  
2.  In **Group Policy Management**, expand **Forest:***YourNetworkDomainName*, expand **Domains**, expand *YourNetworkDomainName*, and then expand **Group Policy Objects**.  
  
3.  Right-click **Small Business Server Folder Redirection**, and then click **Delete**.  
  
4.  Read the warning, and then click **Yes**.  
  
5.  Close **Group Policy Management**.  
  
 To apply the change to folder redirection, network users must log off their computer, and then log back on. This ensures the transfer of all redirected folders to the Destination Server.