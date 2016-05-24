---
title: Configure Hyper-V Server for Remote Management
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5f78764a-3b3a-4ae8-91d1-aabe46e3e3a0
author: cwatsonmsft
---
# Configure Hyper-V Server for Remote Management
This topic describes the steps that are necessary to configure Microsoft Hyper\-V Server 2012 R2 or Hyper\-V Server 2012 so that you can manage it remotely.  
  
> [!NOTE]  
> [!INCLUDE[wps_howtorun](../Token/wps_howtorun_md.md)]  
  
## <a name="BKMK_1.1"></a>To configure computers running Hyper\-V Server in the same domain  
  
1.  On the computer running Hyper\-V Server, add names to the local administrator account for users who you want to be able to manage the server remotely.  
  
2.  From the remote computer, connect to the computer running Hyper\-V Server by using Server Manager or Hyper\-V Manager. Use an account that has local administrative rights. No further configuration is required.  
  
## <a name="BKMK_1.2"></a>To configure computers running Hyper\-V Server in different domains  
  
1.  On the computer running Hyper\-V Server, add names to the local administrator account for users who want to be able to manage the server remotely.  
  
2.  On the remote computer, add the computer running Hyper\-V Server as a trusted host by using the following Windows PowerShell cmdlet: `Set-Item WSMan:\localhost\Client\TrustedHosts -Value <RemoteServerName> -Concatenate`, where *RemoteServerName* is the name of the computer running Hyper\-V Server that you want to manage.  
  
3.  From the remote computer, connect to the computer running Hyper\-V Server by using Server Manager or Hyper\-V Manager. Use an account that has local administrative rights. No further configuration is required.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Microsoft Hyper\-V Server 2012 R2 and Hyper\-V Server 2012 \[MTPS TOC\]](../DocSets/Harvest_TH_Microsoft-Hyper-V-Server-2012-and-Microsoft-Hyper-V-Server-2012-R2/NotInToc/Microsoft-Hyper-V-Server-2012-R2-and-Hyper-V-Server-2012_deleted.md)  
  
-   [Hyper\-V Overview](assetId:///5aad349f-ef06-464a-b36f-366fbb040143)  
  
-   [Manage Hardware and Drivers](../Topic/Manage-Hardware-and-Drivers.md)  
  
-   [Manage Hyper-V Server Remotely](../Topic/Manage-Hyper-V-Server-Remotely.md)  
  
-   [Configuring and Managing Server Core Installations](http://technet.microsoft.com/library/jj574091)  
  
-   [Microsoft Hyper\-V Server 2008 R2](http://technet.microsoft.com/library/ee815281(v=ws.10).aspx)  
  
