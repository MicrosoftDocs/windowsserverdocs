---
title: Configure WSUS for Network Load Balancing
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ad30cc5d-ceaa-41a0-9e22-7b1ca15e2852
author: britw
---
# Configure WSUS for Network Load Balancing
Network load balancing \(NLB\) is an optional feature of Windows Server that load balances network traffic for high availability. You can install [!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] 3.0 SP2 in a network that uses NLB, but this configuration requires that you perform additional steps during WSUS setup.  
  
After you install WSUS and configure a SQL Server database in a failover cluster, you can configure NLB. For more information about how to set up an NLB cluster, see [Network Load Balancing](http://go.microsoft.com/fwlink/?LinkID=201304).  
  
In this topic:  
  
-   [Install WSUS on the first front\-end server and configure a remote database](../Topic/Configure-WSUS-for-Network-Load-Balancing.md#firstfe)  
  
-   [Set up additional front\-end WSUS servers](../Topic/Configure-WSUS-for-Network-Load-Balancing.md#morefe)  
  
-   [Configure the front\-end WSUS servers](../Topic/Configure-WSUS-for-Network-Load-Balancing.md#configfe)  
  
-   [Create a shared file location](../Topic/Configure-WSUS-for-Network-Load-Balancing.md#fs)  
  
-   [Configure IIS on the front\-end WSUS servers](../Topic/Configure-WSUS-for-Network-Load-Balancing.md#iis)  
  
-   [Move the local content directory to the file share](../Topic/Configure-WSUS-for-Network-Load-Balancing.md#move)  
  
-   [Configure NLB](../Topic/Configure-WSUS-for-Network-Load-Balancing.md#nlb)  
  
-   [Test the WSUS NLB configuration](../Topic/Configure-WSUS-for-Network-Load-Balancing.md#test)  
  
-   [Configure WSUS clients to sync from the DFS share](../Topic/Configure-WSUS-for-Network-Load-Balancing.md#synchdfs)  
  
## <a name="firstfe"></a>Install WSUS on the first front\-end server and configure a remote database  
Install WSUS on the first front\-end server and configure it to use a remote database. This process is described in [Install the WSUS 3.0 SP2 server software through the User Interface](assetId:///3bc2933c-8d26-4594-b989-e64b406f3147).  
  
## <a name="morefe"></a>Set up additional front\-end WSUS servers  
This step installs WSUS on additional front\-end WSUS servers, but it does not create a WSUS database.  
  
> [!IMPORTANT]  
> You cannot assign more than four front\-end WSUS servers to a single database instance.  
  
#### To install WSUS on additional front\-end servers  
  
1.  Follow the instructions in [To run WSUS Setup from the command line](assetId:///2443408e-5bd2-4b1f-b0a5-7ee1452fe5bc#procCL) to install the WSUS server software on the additional WSUS servers by using the command line. Use the following flags for the command:  
  
    *WSUS30\-KB972455\-xxx.exe* **\/q FRONTEND\_SETUP\=1 SQLINSTANCE\_NAME\=server\\instance CREATE\_DATABASE\=0**  
  
    where *WSUS30\-KB972455\-xxx.exe* is the executable program that matches the server operating system.  
  
> [!NOTE]  
> If you use the default SQL Server instance, you must leave the instance name blank.  
  
## <a name="configfe"></a>Configure the front\-end WSUS servers  
Each front\-end WSUS server should use a proxy server, and should authenticate to the proxy server by using the same user name and password. You can configure these settings by using the WSUS administration console. For more information about how to configure WSUS to use a proxy server, see [Configure the proxy server](../Topic/Prepare-the-Network-and-Server-for-WSUS-3.0-SP2.md#proxy) and [Change the WSUS proxy server specification using the WSUS Administration Console](../Topic/Change-the-WSUS-proxy-server-specification-using-the-WSUS-Administration-Console.md).  
  
> [!NOTE]  
> All front\-end servers share this information and configuring the proxy server only needs to be done once from any node.  
  
## <a name="fs"></a>Create a shared file location  
You should create a single shared file location that is available to all of the front\-end WSUS servers. You can use a standard network file share and provide redundancy by storing updates on a RAID controller, or you can use a Distributed File System \(DFS\) share. The domain account of each front\-end WSUS server must have **Change** permissions on the root folder of the file share. That is, if there is a WSUS server installed locally on the computer that has the DFS share, the Network Service account should have change permissions on the root folder. In addition, the user account of the administrator who will run **movecontent** should have **Change** permissions.  
  
After you install a WSUS update, check the NTFS file system permissions for the WSUSContent folder. The NTFS file system permissions for the WSUSContent folder may be reset to the default values by the installer.  
  
> [!NOTE]  
> For more information about how to set permissions on DFS shares, see [article 308568](http://go.microsoft.com/fwlink/?LinkId=86550) in the Microsoft Knowledge Base.  
  
## <a name="iis"></a>Configure IIS on the front\-end WSUS servers  
To access the updates or metadata that reside on the file share, you must configure [!INCLUDE[iis_nover](../Token/iis_nover_md.md)] on the front\-end WSUS servers to allow for remote access. For more information, see [Configure Internet Information Services \(IIS\)](../Topic/Prepare-the-Network-and-Server-for-WSUS-3.0-SP2.md#iis) in this deployment guide.  
  
## <a name="move"></a>Move the local content directory to the file share  
You must move the content directories from the first front\-end WSUS server to the file share. You do not have to repeat this step for additional front\-end WSUS servers.  
  
> [!IMPORTANT]  
> You must manually update the registry on all machines other than the machine that **movecontent** is run on. The current storage location can be found or verified in the registry. It is stored in the **ContentDir** value in the **HKLM\\SOFTWARE\\Microsoft\\Update Services\\Server\\Setup** key.  
  
#### To move the content directories to the file share  
  
1.  [!INCLUDE[cmd](../Token/cmd_md.md)]  
  
2.  Open the following WSUS tools folder:  
  
    **cd \\Program Files\\Update Services\\Tools**  
  
3.  Type the following command:  
  
    **wsusutil movecontent***Filesharename logfilename*  
  
    where *Filesharename* is the name of the file share to which the content should be moved, and *logfilename* is the name of the log file.  
  
## <a name="nlb"></a>Configure NLB  
To configure NLB, follow the instructions that are provided in [Network Load Balancing Clusters](http://go.microsoft.com/fwlink/?LinkId=76491) in the Windows Server Technical Library.  
  
## <a name="test"></a>Test the WSUS NLB configuration  
You should make sure that at least one WSUS front\-end server can synchronize. If the synchronization is successful, proceed to the next step. Otherwise, review the WSUS setup and NLB cluster setup. Correct any problems with the configuration and then retest the synchronization.  
  
## <a name="synchdfs"></a>Configure WSUS clients to sync from the DFS share  
You can find instructions for configuring WSUS client computers in [Update and Configure the Automatic Updates Client](assetId:///d3d56210-9f71-49b7-b0d1-a04fb52d4e53). However, for WSUS on NLB clusters, you should specify the virtual address of the NLB cluster instead of the individual servers. For example, if you set up client computers by using a Group Policy Object or Local Group Policy Object, the setting for the **Specify intranet Microsoft update service location** setting should be the virtual web address.  
  
> [!IMPORTANT]  
> If you use a DFS share, be careful when you uninstall WSUS from one, but not all, of the front\-end servers. If you allow the WSUS content directory to be deleted, this will affect all the WSUS front\-end servers.  
  
## Upgrade NLB  
For information about upgrading a Network Load Balancing \(NLB\) cluster, see [Upgrading an existing Network Load Balancing Cluster](http://go.microsoft.com/fwlink/?LinkId=211766).  
  
