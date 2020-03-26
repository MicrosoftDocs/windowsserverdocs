---
title: "Enable folder redirection on the Windows Server Essentials Destination Server1"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
H1: Enable folder redirection on the Windows Server Essentials Destination Server
ms.assetid: f67d195e-36f6-495a-8361-6d5faa889441
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Enable folder redirection on the Windows Server Essentials Destination Server1

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

You can perform this task if folder redirection is enabled on the Source Server.  
  
 First, use the  Windows Server Essentials Dashboard to enable folder redirection on the Destination Server. Then, delete the old Folder Redirection Group Policy setting.  
  
### To enable folder redirection on the Destination Server  
  
1.  On the Destination Server, open the  Windows Server Essentials Dashboard.  
  
2.  In the navigation bar, click **DEVICES**.  
  
3.  In the **Devices Tasks** pane, click **Implement Group Policy**.  
  
4.  On the **Enable Folder Redirection Group Policy** page, select the folders to be redirected, and then click **Next**.  
  
5.  On the **Enable Security Policy Settings** page, click **Finish**.  
  
### To delete the old Folder Redirection Group Policy setting  
  
1. On the Destination Server, open the **Group Policy Management** administrative tool.  
  
2. In **Group Policy Management**, expand **Forest:**<em>YourNetworkDomainName</em>, expand **Domains**, expand *YourNetworkDomainName*, and then expand **Group Policy Objects**.  
  
3. Right-click **W7PVP Folder Redirection**, and then click **Delete**.  
  
4. Read the warning, and then click **Yes**.  
  
5. Close **Group Policy Management**.  
  
   To apply the change to folder redirection, network users must log off their computer, and then log back on. This ensures the transfer of all redirected folders to the Destination Server.
