---
title: Manage Hardware and Drivers
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5017dd43-c381-4472-b2b8-0b69337b4f36
author: cwatsonmsft
---
# Manage Hardware and Drivers
Follow these procedures to add hardware, obtain a list of drivers, or disable drivers on a server running Hyper\-V Server.  
  
#### To add hardware  
  
1.  Follow the instructions that are provided by the hardware vendor to install new hardware:  
  
    -   If the driver for the hardware is included in Hyper\-V Server, Plug and Play will start and install the driver.  
  
        > [!NOTE]  
        > Hyper\-V Server uses the Windows Server driver model. Any drivers that work with corresponding editions of Windows Server will also work with Hyper\-V Server.  
  
    -   If the driver for the hardware is not included, proceed with Steps 2 and 3.  
  
2.  Copy the driver files to a temporary folder on the server running a Server Core installation of Windows Server.  
  
3.  At a command prompt, open the folder where the driver files are located, and run the following command:  
  
    **pnputil –i –a** <*driverinf*>  
  
    Where:  
  
    *driverinf* is the file name of the .inf file for the driver.  
  
4.  If prompted, restart the computer.  
  
#### To obtain a list of drivers that are installed  
  
-   At a command prompt, run  
  
    **sc query type\= driver**  
  
> [!NOTE]  
> You must include the space after the equal sign for the command to complete successfully.  
  
#### To disable a device driver  
  
-   At a command prompt, run  
  
    **sc delete** <*service\_name*>  
  
    Where:  
  
    *service\_name* is the name of the service that you obtain by running **sc query type\= driver**  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Microsoft Hyper\-V Server 2012 R2 and Hyper\-V Server 2012 \[MTPS TOC\]](../DocSets/Harvest_TH_Microsoft-Hyper-V-Server-2012-and-Microsoft-Hyper-V-Server-2012-R2/NotInToc/Microsoft-Hyper-V-Server-2012-R2-and-Hyper-V-Server-2012_deleted.md)  
  
-   [Hyper\-V Overview](assetId:///5aad349f-ef06-464a-b36f-366fbb040143)  
  
-   [Configure Hyper-V Server for Remote Management](../Topic/Configure-Hyper-V-Server-for-Remote-Management.md)  
  
-   [Install Hyper\-V Server 2012](assetId:///388e3ac7-cc7c-487e-ba99-c12ac1722bc9)  
  
-   [Configuring and Managing Server Core Installations](http://technet.microsoft.com/library/jj574091)  
  
-   [Microsoft Hyper\-V Server 2008 R2](http://technet.microsoft.com/library/ee815281(v=ws.10).aspx)  
  
