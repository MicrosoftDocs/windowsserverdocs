---
title: Step 3: Configure Hyper-V to Use Scale-Out File Server
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 404a69d4-03ea-468b-9072-f18a10303ffc
---
# Step 3: Configure Hyper-V to Use Scale-Out File Server
Hyper\-V is one of two Microsoft applications that are supported when using Scale\-Out File Server for data storage. When the failover cluster is configured, virtual machines can be configured by using Hyper\-V Manager.  
  
|Task|Description|  
|--------|---------------|  
|[3.1. Verify permissions](../Topic/Step-3--Configure-Hyper-V-to-Use-Scale-Out-File-Server.md#BKMK_1.1)|Ensure that the permissions on the continuously available file share are configured correctly to host virtual machines.|  
|[3.2. Create a new virtual machine](../Topic/Step-3--Configure-Hyper-V-to-Use-Scale-Out-File-Server.md#BKMK_1.2)|Create a new virtual machine by using Hyper\-V Manager.|  
  
## <a name="BKMK_1.1"></a>3.1. Verify permissions  
You should ensure that the proper permissions are granted on the continuously available file share before you create the virtual machines.  
  
#### To verify permissions  
  
1.  Log on to the server as a member of the local Administrators group.  
  
2.  Open Windows Explorer and navigate to the shared folder.  
  
3.  Right\-click the folder, and then click **Properties**.  
  
4.  Click the **Sharing** tab, click **Advanced Sharing**, and then click **Permissions**.  
  
5.  Ensure that the Hyper\-V computer accounts, the SYSTEM account, and all Hyper\-V administrators have full control permissions.  
  
6.  Click **OK** twice.  
  
7.  Click the **Security** tab.  
  
8.  Ensure that the Hyper\-V computer accounts, the SYSTEM account, and all Hyper\-V administrators have full control permissions.  
  
## <a name="BKMK_1.2"></a>3.2. Create a new virtual machine  
You create a virtual machine by using Hyper\-V Manager. When you are prompted for the virtual machine location, enter the name of the client access point that is configured in the failover cluster for Scale\-Out File Server.  
  
#### To create a virtual machine  
  
1.  Log on to the server running Hyper\-V as a member of the local Administrators group.  
  
2.  Open Hyper\-V Manager. Click **Start**, and then click **Hyper\-V Manager**.  
  
3.  Right\-click the server running Hyper\-V name, point to **New**, and then click **Virtual Machine**.  
  
4.  On the **Before You Begin** page, click **Next**.  
  
5.  On the **Specify Name and Location** page, in the **Name** box, type a name for the virtual machine.  
  
6.  Select the **Store the virtual machine in a different location** check box. In the **Location** box, type the client access point that is configured in the failover cluster for Scale\-Out File Server, and then click **Next**.  
  
7.  On the **Assign Memory** page, type the desired amount of memory in the **Startup memory** box, and then click **Next**.  
  
8.  On the **Configure Networking** page, in the **Connection** box, choose the appropriate network, and then click **Next**.  
  
9. On the **Connect Virtual Hard Disk** page, create a virtual hard disk and set the location to the client access point that is configured in the failover cluster for Scale\-Out File Server, and then click **Next**.  
  
10. On the **Completing the New Virtual Machine Wizard** page, click **Finish**.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 1: Install Prerequisites for Scale\-out File Servers](assetId:///3847444c-b148-4d45-bb40-ce438ef36cd6)  
  
-   [Step 2: Configure the Scale\-out File Servers](assetId:///b5e3a0c1-d4e8-4761-975a-10c042c7455e)  
  
-   [Step 4: Configure Microsoft SQL Server to Use Scale-Out File Server](../Topic/Step-4--Configure-Microsoft-SQL-Server-to-Use-Scale-Out-File-Server.md)  
  
-   [Deploy Scale\-out File Servers](assetId:///11415db9-8fb8-4aea-a6c0-38f706a0586e)  
  
-   [Scale-Out File Server for Application Data Overview_1](../Topic/Scale-Out-File-Server-for-Application-Data-Overview_1.md)  
  
-   [Provide cost\-effective storage for Hyper\-V workloads by using Windows Server](http://technet.microsoft.com/library/dn554251.aspx)  
  
