---
title: Deploy Windows Offloaded Data Transfers
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 585d10cf-3448-4f1f-8e3d-747f53dbba63
author: JasonGerend
---
# Deploy Windows Offloaded Data Transfers
This topic discusses how to deploy Windows Offloaded Data Transfer \(ODX\) in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to directly transfer data within or between compatible storage devices, bypassing the host computer. This topic also discusses hardware requirements, software requirements, and how to verify the performance of ODX after you implement it.  
  
Although no action is required to use ODX with a compatible storage array and compatible applications, there are a number of tasks that you should perform to confirm that your environment is compatible with ODX and to verify that you are receiving the performance benefits of ODX, as discussed in this topic.  
  
-   **In this document**  
  
-   [Prerequisites](#DeployODX_Prerequisites)  
  
-   [Step 1: Gather storage array information](#DeployODX_Step1Gatherstoragearrayinformation)  
  
-   [Step 2: Validate file system filter drivers](#DeployODX_Step2Validatefilesystemfilterdrivers)  
  
-   [Step 3: Establish a performance baseline](#DeployODX_Step3Establishaperformancebaseline)  
  
-   [Step 4: Test ODX performance](#DeployODX_Step4TestODXPerformance)  
  
-   [Appendix: Deployment checklist](#DeployODX_AppendixDeploymentChecklist)  
  
## <a name="DeployODX_Prerequisites"></a>Prerequisites  
To use ODX, your environment must meet the following hardware and software requirements.  
  
### Hardware requirements  
To use ODX, your storage arrays must meet the following requirements:  
  
-   Be certified as compatible with Windows Offloaded Data Transfer \(ODX\) on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]  
  
-   Support cross\-storage array ODX. To support ODX between storage arrays, the copy manager for the storage arrays must support cross\-storage array ODX, and the storage arrays must be from the same vendor  
  
-   Be connected by using one of the following protocols:  
  
    -   iSCSI  
  
    -   Fibre Channel  
  
    -   Fibre Channel over Ethernet  
  
    -   Serial Attached SCSI \(SAS\)  
  
-   Use one of the following configurations:  
  
    -   One server with one storage array  
  
    -   One server with two storage arrays  
  
    -   Two servers with one storage array  
  
    -   Two servers with two storage arrays  
  
### Software requirements  
To use ODX, your environment must support the following:  
  
-   The computer initiating the data transfer must be running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], or [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
-   File system filter drivers such as antivirus and encryption programs need to opt\-in to ODX. ODX is not supported by the following file system filter drivers:  
  
    -   Data Deduplication  
  
    -   BitLocker Drive Encryption  
  
-   Files must be on an unencrypted basic partition. Storage Spaces and dynamic volumes are not supported.  
  
-   Files must be on a volume that is formatted by using NTFS. ReFS and FAT are not supported. Files can be directly transferred to or from this volume, or from one of the following containers:  
  
    -   A virtual hard disk \(VHD\) that uses the .vhd or .vhdx format  
  
    -   A file share that uses the SMB protocol  
  
-   The files must be 256 KB or larger. Smaller files are transferred by using a traditional \(non\-ODX\) file transfer operation.  
  
-   The application that performs the data transfer must be written to support ODX. The following currently support ODX:  
  
    -   Hyper\-V management operations that transfer large amounts of data at one time, such as creating a fixed size VHD, merging a snapshot, or converting VHDs.  
  
    -   [!INCLUDE[win8_explorer](../Token/win8_explorer_md.md)]  
  
    -   Copy commands in Windows PowerShell  
  
    -   Copy commands in the Windows command prompt \(including Robocopy\)  
  
-   Files should not be highly fragmented. Transfers of highly fragmented files will have reduced performance.  
  
### Hyper\-V Requirements  
To use ODX with virtual machines on a server running Hyper\-V, the virtual machines need to access storage from an ODX\-capable storage array. You can achieve this by using any of the following approaches.  
  
-   Store the VHD on an ODX\-capable iSCSI LUN.  
  
-   Assign ODX\-capable iSCSI LUNs to the virtual machine's iSCSI initiator.  
  
-   Assign ODX\-capable Fibre Channel LUNs to the virtual machine's virtual Fibre Channel adapter.  
  
-   Connect the host or virtual machine to an SMB file share on another computer that is hosted on an ODX\-capable storage array.  
  
## <a name="DeployODX_Step1Gatherstoragearrayinformation"></a>Step 1: Gather storage array information  
Before deploying ODX, gather the following information about the copy manager \(operating system\) of the storage array:  
  
-   What is the name and version of the copy manager?  
  
-   Does the copy manager support ODX?  
  
-   Does the copy manager support an ODX operation across multiple storage arrays from the same vendor?  
  
-   What is the default inactive timer value? This specifies how long the copy manager waits to invalidate the idle token after the timer expiration.  
  
-   What is the maximum token capacity of the copy manager?  
  
-   What is the optimal transfer size? This tells Windows how to send Read and Write commands that are optimally sized for the storage array.  
  
## <a name="DeployODX_Step2Validatefilesystemfilterdrivers"></a>Step 2: Validate file system filter drivers  
To use ODX, validate all the file system filter drivers on all servers that are hosting the storage support ODX.  
  
To validate the opt\-in status of file system filter drivers, use the following procedure:  
  
#### To validate file system filter driver opt\-in status  
  
1.  On each server on which you want to use ODX, list all of the file system filter drivers that are attached to the volume on which you want to enable ODX. To do so, open a Windows PowerShell session as an administrator, and then type the following command, where *<volume>* is the drive letter of the volume:  
  
    ```  
    Fltmc instances -v <volume>  
    ```  
  
2.  For each filter driver listed, query the registry to determine whether the filter driver has opted\-in to ODX support. To do so, type the following command for each filter previously listed, and replace *<FilterName>* with the name of the filter.  
  
    ```  
    Get-ItemProperty hklm:\system\currentcontrolset\services\<FilterName> -Name "SupportedFeatures"  
    ```  
  
3.  If the **SupportedFeatures** registry value equals **3**, the filter driver supports ODX. If the value is not **3**, contact the file system filter driver vendor for an ODX\-compatible version.  
  
## <a name="DeployODX_Step3Establishaperformancebaseline"></a>Step 3: Establish a performance baseline  
To establish a performance baseline, use the following procedures to disable ODX on the server and create a System Performance Report during a representative data transfer.  
  
### Disable ODX  
To establish a baseline of non\-offloaded data transfer performance, first disable ODX on the server by following these steps:  
  
##### To disable ODX on the server  
  
1.  Open a Windows PowerShell session as an administrator.  
  
2.  Check whether ODX is currently enabled \(it is by default\) by verifying that the **FilterSupportedFeaturesMode** value in the registry equals **0**. To do so, type the following command:  
  
    ```  
    Get-ItemProperty hklm:\system\currentcontrolset\control\filesystem -Name "FilterSupportedFeaturesMode"  
    ```  
  
3.  Disable ODX support. To do so, type the following command:  
  
    ```  
    Set-ItemProperty hklm:\system\currentcontrolset\control\filesystem -Name "FilterSupportedFeaturesMode" -Value 1  
    ```  
  
### <a name="BKMK_Create"></a>Create a System Performance Report during a data transfer  
To record the baseline performance of data transfers, use Performance Monitor to record system performance during a represenative data transfer. To do so, follow these steps:  
  
##### To create a System Performance Report  
  
1.  In Server Manager, on the **Tools** menu, click **Performance Monitor**.  
  
2.  Initiate a large data transfer that is representative of the workload you want to accelerate and that is within or between the storage arrays that support ODX.  
  
3.  Start the System Performance data collector set. To do so, expand **Data Collector Sets**, expand **System**, right\-click **System Performance**, and then click **Start**. Performance Monitor will collect data for 60 seconds.  
  
4.  Expand **Reports**, expand **System**, expand **System Performance**, and then click the most recent report.  
  
5.  Review the System Performance Report, and take note of the following counters:  
  
    -   CPU Utilization \(in the Resource Overview section\)  
  
    -   Network Utilization \(in the Resource Overview section\)  
  
    -   Disk Bytes\/sec \(in the Disk section, under Physical Disk\)  
  
## <a name="DeployODX_Step4TestODXPerformance"></a>Step 4: Test ODX performance  
After you establish a baseline of system performance during traditional data transfers, use the following procedures to enable ODX on the server and test offloaded data transfers:  
  
### Enable ODX  
To enable ODX on the server, follow these steps:  
  
##### To enable ODX  
  
1.  Open a Windows PowerShell session as an administrator.  
  
2.  Type the following command:  
  
    ```  
    Set-ItemProperty hklm:\system\currentcontrolset\control\filesystem -Name "FilterSupportedFeaturesMode" -Value 0  
    ```  
  
### Verify ODX performance  
After ODX is enabled, create a System Performance Report during a large offloaded data transfer \(see the [Create a System Performance Report during a data transfer](../Topic/Deploy-Windows-Offloaded-Data-Transfers.md#BKMK_Create) section earlier in this topic for the procedure\).  
  
When you evaluate the performance of offloaded data transfers, you should see the following differences from the baseline that you created when ODX was disabled:  
  
-   CPU utilization should be much lower \(only slightly higher than prior to the data transfer\). This shows that the server did not need to manage the data transfer.  
  
-   Network utilization should be much lower \(only slightly higher than prior to the data transfer\). This shows that the data transfer bypassed the server.  
  
-   Disk Bytes\/sec should be much higher. This reflects increased performance from direct transfers within an array or within the SAN.  
  
After you verify ODX performance, periodically create another System Performance Report during offloaded data transfers to confirm that ODX is still operating as expected. If any performance degradation is detected, contact Microsoft Customer Support and the storage array vendor.  
  
> [!TIP]  
> You can use the following command in a Windows PowerShell session to display a list of storage subsystems that support ODX and use a storage management provider. This command does not display storage subsystems that use the Storage Management Initiative Specification \(SMI\-S\) protocol.  
>   
> `Get-OffloadDataTransferSetting | Get-StorageSubSystem`  
  
## <a name="DeployODX_AppendixDeploymentChecklist"></a>Appendix: Deployment checklist  
Use the following checklist to confirm that you completed all the steps for the deployment.  
  
|||  
|-|-|  
||**Deploying Windows Offloaded Data Transfers Checklist**|  
||Check the Windows Offloaded Data Transfers prerequisites.|  
||Gather storage array information.|  
||Validate the file system filter drivers.|  
||Establish a performance baseline.|  
||Test the ODX performance.|  
  
## See Also  
[Is Offloaded Data Transfers \(ODX\) working? \(TechNet Blog\)](http://blogs.technet.com/b/askcore/archive/2014/06/26/is-offloaded-data-transfers-odx-working.aspx)  
[T10 SCSI Primary Command Spec \(SPC4r36\)](http://www.t10.org/cgi-bin/ac.pl?t=f&f=spc4r36.pdf)  
[Windows 8 Devices Requirements](http://msdn.microsoft.com/library/windows/hardware/hh748188)  
  
