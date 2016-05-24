---
title: Design for Optimized Performance
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c28b3f09-1dbf-4b78-8cfd-e9e4c3f1ed8e
author: britw
---
# Design for Optimized Performance
You can customize the [!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] 3.0 SP2 deployment for performance optimization. This topic describes the options.  
  
In this topic:  
  
-   [Network setup recommendations](../Topic/Design-for-Optimized-Performance.md#net)  
  
-   [Deferred downloads](../Topic/Design-for-Optimized-Performance.md#defer)  
  
-   [Update filters](../Topic/Design-for-Optimized-Performance.md#filter)  
  
-   [Express installation files](../Topic/Design-for-Optimized-Performance.md#express)  
  
-   [Large update deployment recommendations](../Topic/Design-for-Optimized-Performance.md#large)  
  
-   [Background Intelligent Transfer Service](../Topic/Design-for-Optimized-Performance.md#bits)  
  
-   [Internet Information Services](../Topic/Design-for-Optimized-Performance.md#iis)  
  
-   [Exclude WSUS and WUAgent resources from antivirus scans](../Topic/Design-for-Optimized-Performance.md#av)  
  
## <a name="net"></a>Network setup recommendations  
To optimize performance in WSUS networks, consider the following suggestions:  
  
-   Set up WSUS networks in a hub\-and\-spoke topology rather than in a hierarchical topology.  
  
-   Use DNS netmask ordering for roaming client computers, and configure roaming client computers to obtain updates from the local WSUS server. For more information about this configuration, see [Configure WSUS for Roaming Client Computers](../Topic/Configure-WSUS-for-Roaming-Client-Computers.md).  
  
## <a name="defer"></a>Deferred downloads  
You can approve updates, and download the update metadata before you download the update files. This method is called *deferred downloads*.  
  
When you defer downloads, an update is downloaded only after it is approved. We recommend that you defer downloads because it optimizes network bandwidth and disk space.  
  
![](../Image/0d256355-4cb8-4f22-9386-da71754ce94e.gif)  
  
In a hierarchy of WSUS servers, WSUS automatically sets all downstream servers to use the deferred download setting of the root WSUS server. You can change this default setting. For example, you can configure an upstream server to perform full, immediate synchronizations, and then configure a downstream server to defer the downloads\).  
  
If you deploy a hierarchy of connected WSUS servers, we recommend that you do not deeply nest the servers. If you enable deferred downloads and a downstream server requests an update that is not approved on the upstream server, the downstream server’s request forces a download on the upstream server. The downstream server then downloads the update on a subsequent synchronization. In a deep hierarchy of WSUS servers, delays can occur as updates are requested, downloaded, and then passed through the server hierarchy.  
  
By default, deferred downloads are enabled when you store updates locally. You can change this option manually.  
  
## <a name="filter"></a>Update filters  
WSUS lets you filter update synchronizations by language, product, and classification.  
  
In a hierarchy of WSUS servers, WSUS automatically sets all downstream servers to use the update filtering options that are selected on the root WSUS server. You can reconfigure download servers to receive only a subset of the languages.  
  
By default, the products to be updated are Windows and Office, and the default classifications are Critical updates, Security updates, and Definition updates. To conserve bandwidth and disk space, we recommend that you limit languages to the ones that you actually use.  
  
For more information about update languages, see [Plan for WSUS update languages](assetId:///358e5660-ce8a-483a-aa60-e74fcee7b19c).  
  
## <a name="express"></a>Express installation files  
Updates typically consist of new versions of files that already exist on the computer that is being updated. On a binary level, these existing files might not differ very much from updated versions. The express installation files feature identifies the exact bytes between versions, creates and distributes updates of only those differences, and then merges the existing file together with the updated bytes.  
  
Sometimes this feature is called *delta delivery* because it downloads only the delta \(difference\) between two versions of a file. Express installation files are larger than the updates that are distributed to client computers because the express installation file contains all possible versions of each file that is to be updated.  
  
You can use express installation files to limit the bandwidth that is consumed on the local network. However, this is at the costs of additional bandwidth on the Internet connection and additional local disk space. By default, WSUS does not use express installation files.  
  
The following image show an update that is first distributed by using express installation files, and then distributed without using express installation files. In this example, the use of express installation files incurs an initial download size that is three times the size of the actual update. However, this cost is lessened by the reduced amount of bandwidth that is required to update client computers on the corporate network. When the express installation files feature is disabled, the initial download is smaller, but the full size of the download must then be distributed to each client computer on the corporate network.  
  
![](../Image/77edc56e-9ae3-4827-a99d-625a11339dc9.gif)  
  
> [!NOTE]  
> The file sizes in this image are provided for illustration only. Each update and express installation file size varies. The size of each update that is distributed to client computers depends on the state of the computer that is being updated.  
  
Not all updates are good candidates for distribution by using express installation files. If you select this option, you obtain express installation files for all updates. If you do not store updates locally, you cannot use express installation files.  
  
## <a name="large"></a>Large update deployment recommendations  
When you deploy large updates \(such as service packs\), you can avoid saturating the network by using the following practices:  
  
-   Use Background Intelligent Transfer Service \(BITS\) throttling. BITS bandwidth limitations can be controlled by time of day, but they apply to all applications that are using BITS. For more information about BITS throttling, see [Background Intelligent Transfer Service](../Topic/Design-for-Optimized-Performance.md#bits) and [Improve WSUS Download Performance with BITS](../Topic/Improve-WSUS-Download-Performance-with-BITS.md).  
  
-   Use [!INCLUDE[iis_nover](../Token/iis_nover_md.md)] throttling to limit throttling to one or more web services. For more information about IIS throttling, see [IIS Settings for WSUS 3.0 SP2 Web Services](../Topic/IIS-Settings-for-WSUS-3.0-SP2-Web-Services.md).  
  
-   Use computer groups to control the rollout. A client computer identifies itself as a member of a particular computer group when it sends information to the WSUS server. The WSUS server uses this information to determine which updates should be deployed to this computer. You can set up multiple computer groups and sequentially approve large service pack downloads for a subset of these groups.  
  
### <a name="bits"></a>Background Intelligent Transfer Service  
WSUS uses the Background Intelligent Transfer Service \(BITS\) protocol for all its file transfer tasks. This includes downloads to client computers and server synchronizations. BITS enables programs to download files by using spare bandwidth. BITS maintains file transfers through network disconnections and computer restarts. For more information about BITS, see:  
  
-   [Improve WSUS Download Performance with BITS](../Topic/Improve-WSUS-Download-Performance-with-BITS.md)  
  
-   [Background Intelligent Transfer Service](http://go.microsoft.com/fwlink/?LinkId=79389)  
  
### <a name="iis"></a>Internet Information Services  
You can optimize Internet Information Services \(IIS\) performance in a variety of ways. For example, you can configure performance settings for a website based on bandwidth usage and connection limits.  
  
For more information about how to optimize IIS, see:  
  
-   [Optimize IIS Performance \(IIS 7\)](http://go.microsoft.com/fwlink/?LinkID=202624)  
  
-   [Bit Rate Throttling \(IIS 7\)](http://go.microsoft.com/fwlink/?LinkID=202627)  
  
-   [Edit Web Site Limits Dialog Box \(IIS 7\)](http://go.microsoft.com/fwlink/?LinkID=202626)  
  
## <a name="av"></a>Antivirus scans  
We recommend that you exclude the following WSUS folders from antivirus scans to improve overall system performance:  
  
-   \\WSUS\\WSUSContent  
  
-   \\WSUS\\UpdateServicesDBFiles  
  
-   \\SoftwareDistribution\\Datastore  
  
-   \\SoftwareDistribution\\Download  
  
