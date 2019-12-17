---
title: "Step 5: Enable folder redirection on the Destination Server for Windows Server Essentials migration"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d3925f80-552d-431f-b2a6-2af202e50ca4
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Step 5: Enable folder redirection on the Destination Server for Windows Server Essentials migration

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

If folder redirection is enabled on the Source Server, you can enable folder redirection on the Destination Server, and then delete the old Folder Redirection Group Policy setting.  
  
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
  
3. Right-click the policy that you want to delete, and then click **Delete**.  
  
4. Read the warning, and then click **Yes**.  
  
5. Close **Group Policy Management**.  
  
   To apply the change for the folder redirection, network users must log off their computers, and then log back on. This ensures the transfer of all redirected folders to the Destination Server.  
  
## Next steps  
 You have enabled folder redirection on the Destination Server. Now go to [Step 6: Demote and remove the Source Server from the new Windows Server Essentials network](Step-6--Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-Essentials-network.md).  
  

To view all the steps, see [Migrate to Windows Server Essentials](Migrate-from-Previous-Versions-to-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md).

