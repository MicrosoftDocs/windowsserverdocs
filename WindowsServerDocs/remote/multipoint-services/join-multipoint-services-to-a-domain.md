---
title: Join MultiPoint Services to a domain (optional)
Description: Provides the steps to join MultiPoint Services to your domain
ms.date: 07/22/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.topic: article
ms.assetid: 623b7c21-dcbb-402e-8b5a-8e434cd225bd
author: evaseydl
manager: scottman
ms.author: evas
---
# Join the MultiPoint Services computer to a domain (optional)
If you will access your MultiPoint Services computer over an Active Directory domain, your next step is to add the computer to the domain.  
  
> [!IMPORTANT]  
> You must verify your time zone before you join the computer to a domain. For instructions, see [Set the date, time, and time zone](Set-the-date--time--and-time-zone.md).  
   
1.  From the **Start** screen, open **Control Panel**. Click **System and Security**, and then click **System**.  
  
2.  Under **Computer name, domain, and workgroup settings**, click **Change settings**.  
  
3.  On the **Computer name** tab, click **Change**.  
  
4.  In the **Computer Name/Domain Changes** dialog box, select **Domain**, enter the name of the domain, and click **OK**, and then follow the steps in the wizard to complete the process.  
  
5.  After the computer restarts, log on as Administrator and wait for MultiPoint Manager to open.  
  
> [!IMPORTANT]  
> To ensure that your MultiPoint Services domain deployment works correctly, you will need to configure a couple of group policies and update the Registry. For information, see [Configure group policies for a domain deployment](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn265982(v=ws.11)).  
