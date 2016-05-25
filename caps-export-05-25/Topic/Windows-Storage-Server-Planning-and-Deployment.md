---
title: Windows Storage Server Planning and Deployment
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f1c0db45-a2fb-4b55-b6ce-24c7f522772e
author: JasonGerend
---
# Windows Storage Server Planning and Deployment
This topic pertains to planning for, and deploying, Windows Storage Server 2012.  
  
## Install Windows Storage Server 2012 on the reference computer  
Use the method that best supports your factory processes.  
  
In addition to the files in the Windows Server 2012 installation media, there are additional packages, features, and settings that you must include on your reference installation  
  
> [!NOTE]  
> Language pack files, drivers, applications, updates, and storage server features can be installed automatically by providing entries in an answer file that supplements Windows Setup when it runs.  
  
### \(Optional\) Install desired language packs  
If you want to offer support for one or more of these languages you can include the desired language packs in your installation. Adding language packs is optional; however, if you do add one or more language packs, you must add them before installing Windows Storage Server 2012 system updates, packages, or applications.  
  
Windows Storage Server 2012 supports the following 19 languages:  
  
1.  Chinese\-Hong Kong S.A.R.:  zh\-HK  
  
2.  Chinese\-Simplified:  zh\-CN  
  
3.  Chinese\-Traditional:  zh\-TW  
  
4.  Czech:  cs\-CZ  
  
5.  Dutch:  nl\-NL  
  
6.  English: en\-US  
  
7.  French:  fr\-FR  
  
8.  German:  de\-DE  
  
9. Hungarian:  hu\-HU  
  
10. Italian:  it\-IT  
  
11. Japanese: ja\-JP  
  
12. Korean: ko\-KR  
  
13. Polish:  pl\-PL  
  
14. Portuguese \(Brazil\):  pt\-BR  
  
15. Portuguese \(Portugal\):  pt\-PT  
  
16. Russian:  ru\-RU  
  
17. Spanish: es\-ES  
  
18. Swedish:  sv\-SE  
  
19. Turkish: tr\-TR  
  
> [!NOTE]  
> See [Multilingual Deployment Overview](http://technet.microsoft.com/library/hh825699.aspx) \(http:\/\/technet.microsoft.com\/library\/hh825699.aspx\) for more information.  
  
### Install 64\-bit drivers  
The Windows Server 2012 product DVD includes drivers for a variety of hardware. These are installed during setup. However, you should use Device Manager to verify that there are no missing device drivers. If there are missing drivers, you can use Device Manager to install them manually in audit mode. To comply with the Certified for Windows program, your storage appliance should contain only signed drivers.  
  
> [!WARNING]  
> Windows Setup will fail if the product DVD does not include a driver for the computer’s storage device. In this case, you must open Install.wim on the product DVD, add the required storage driver to Install.wim, and then save the updated .wim file. For more information, see the [How to Add and Remove Drivers Offline](http://technet.microsoft.com/library/hh825070.aspx) \(http:\/\/technet.microsoft.com\/library\/hh825070.aspx\).  
  
> [!WARNING]  
> OEMs who want to install updates that are released at a later date \(or those that are not included with the Windows Server 2012 package\) cannot obtain them from the Windows Update site. You must follow the update procedure as described in your OEM software license terms. However, this licensing restriction does not apply to end users. Storage appliance end users can obtain updates from Windows Update.  
  
During installation of the iSCSI Target Server role service, registry settings are created on the storage appliance. These registry settings store information that is used to uniquely identify the appliance on which the iSCSI Target Server role service is installed. OEMs with a master image that includes the iSCSI Software Target Server role service should be aware of the following deployment\-related considerations:  
  
1.  The vendor\-specific registry entries for iSCSI Target Server \(VendorID, ProductID, and ProductRevision\) do not support Unicode values. If you assign a Unicode value to any of these registry values, an iSCSI initiator will display “????” for the values.  
  
2.  If you set both the VendorSpecificIDLow and the VendorSpecificIDHigh registry entries to 0 \(0x00000000\), iSCSI Target Server will generate random values to uniquely identify the target.  
  
> [!NOTE]  
> For a standalone storage appliance, you can install the iSCSI Target Server role service on your reference computer and then capture it in your master image. For a clustered storage appliance, the ISCSI Target Server role service should be installed after the Failover Clustering feature has been enabled on the appliance and the cluster has been created. As such, you should install the Failover Clustering feature as part of the master image. The iSCSI Target Server role service should then be installed by the end user after the ICT process completes in Server Manager. To ease this installation process, OEMs can customize the ICT window and add a task or task group that initiates the iSCSI Target Server role service setup on the failover cluster.  
  
### Add required or optional storage server roles or features  
Windows Storage Server 2012 may use specific server roles or features. How you enable these roles or features can vary based on the deployment methods that are used in your factory.  
  
For example, you can manually add these roles or features by using the Add Roles and Features Wizard in Server Manager during audit mode, by using the Windows PowerShell [Add\-WindowsFeature](http://technet.microsoft.com/library/ee662309.aspx) cmdlet \(http:\/\/technet.microsoft.com\/library\/ee662309.aspx\), or you can use the Deployment Image Servicing and Management \(DISM\) tool to enable roles or features within an installation image offline. For more information about DISM, see [Deployment Image Servicing and Management \(DISM\) Technical Reference](http://technet.microsoft.com/library/hh824821.aspx) \(http:\/\/technet.microsoft.com\/library\/hh824821.aspx\).  
  
For failover clusters, the Remote Server Administration Tools \(RSAT\) feature must also be installed on the primary node. RSAT can be installed in Server Manager using the Add Roles and Features wizard, during the Windows PowerShell Add\-WindowsFeature cmdlet for failover clustering as follows from a Windows command prompt:.  
  
```  
powershell.exe;powershell.exe -command {Import-Module ServerManager; Add-WindowsFeature Failover-Clustering -IncludeManagementTools}  
```  
  
or use the following Windows PowerShell command:  
  
```  
Add-WindowsFeature Failover-Clustering -IncludeManagementTools  
```  
  
Alternatively, RSAT can be installed by using DISM as follows:  
  
```  
dism.exe /online /enable-feature /featurename:"remoteServerAdministrationTools  
```  
  
### Enable Windows Remote Management  
For failover clusters, use Windows PowerShell to enable Windows Remote Management \(WinRM\) on both nodes.  
  
##### To enable WinRM  
  
1.  On the reference computer, click **Start**, click **Run**, and then type `cmd`.  
  
2.  At the command prompt, type `powershell`  
  
3.  At the Windows PowerShell command prompt, type `Set-WSManQuickConfig –Force`.  
  
4.  If prompted, type `y` to accept.  
  
### \(Optional\) Install non\-Microsoft applications  
If you want non\-Microsoft applications available on the storage appliance, you can add them to the reference computer installation as follows:  
  
**During preinstallation**: If the application supports unattended installation \(specifically, the application does not prompt the user during installation\) the application can be referenced in an answer file and added to the installation during setup. For more information, see [RunSynchronousCommand](http://technet.microsoft.com/library/ff715407(v=ws.10).aspx) \(http:\/\/technet.microsoft.com\/library\/ff715407\(v\=ws.10\).aspx\).  
  
**During audit mode**: If the application does not support unattended installation and does not require the end user to accept software license terms, you can manually install the application in audit mode. For more information, see [Audit Mode Overview](http://technet.microsoft.com/library/hh824891.aspx) \(http:\/\/technet.microsoft.com\/library\/hh824891.aspx\).  
  
**During the user’s first logon**: If the application makes changes to the installation that will be removed when Sysprep runs \(that is, before you capture the master image\), you can add a reference to the application’s setup executable in the answer file that Sysprep references prior to the user’s first logon. However, this option can only be used if the application supports unattended installation. For more information, see [Sysprep Technical Reference](http://technet.microsoft.com/library/hh825209.aspx) \(http:\/\/technet.microsoft.com\/library\/hh825209.aspx\).  
  
**As a link from the ICT window**: If the application requires the user’s interaction for installation or the acceptance of software license terms, you can create a task or task group that links to the installation setup file.  
  
### \(Optional\) Add your OEM software license terms  
OEMs that require that their end users accept their software license terms can customize this part of end user setup \(known as Windows Welcome\) by copying the content of the end\-user license agreement \(EULA\) to an .rtf file and then adding a reference to this file in the Oobe.xml file. If you offer localized versions of Windows Storage Server 2012, you must provide a localized version of the EULA for each supported language that you offer. For information about how to provide a localized version of a EULA, see [How Oobe.xml Works](http://technet.microsoft.com/library/cc722315%28v=ws.10%29.aspx) \(http:\/\/technet.microsoft.com\/library\/cc722315%28v\=ws.10%29.aspx\).  
  
> [!NOTE]  
> OEMs that opt to add software license terms to Windows Welcome do not have to provide a printed version with their storage appliance.  
  
##### To display OEM\-specific software license terms  
  
1.  On the reference computer, create the following directory: **%Windir%\\System32\\oobe\\info**. If you want to support localization, you must add subdirectories for each language that you want to support.  
  
2.  Copy the desired software license terms \(for example, Contoso\_EULA.rtf\) to the info directory.  
  
3.  Locate the Oobe.xml file, and open it in a text editor or an application that supports .xml files.  
  
4.  Add the following text to the Oobe.xml file:  
  
    ```  
    <?xml version="1.0" encoding="utf-8"?>  
          <FirstExperience>  
             <oobe>  
                <oem>  
                   <eulafilename>Contoso_EULA.rtf </eulafilename>  
                </oem>  
             </oobe>  
       </FirstExperience>  
    ```  
  
5.  Save the edited file.  
  
For more information about customizing the Oobe.xml file, see [Oobe.xml Settings](http://technet.microsoft.com/library/cc722154%28v=ws.10%29.aspx) \(http:\/\/technet.microsoft.com\/library\/cc722154%28v\=ws.10%29.aspx\).  
  
## Customize the end user installation experience for the usage scenario  
The OEM\-Appliance\-OOBE feature provides a Windows Presentation Foundation \(WPF\) application that uses an XML\-based framework to enable OEMs to customize the Initial Configuration Tasks \(ICT\) window using the OEMOOBE.xml file. The ICT application in Windows Server 2012 has options that are specifically designed for the setup and configuration of storage appliances, Hyper\-V appliances and SQL appliances.  
  
Unless you customized the ICT, the window that is displayed during setup and configuration of the storage appliance will display tasks that are appropriate for one of two scenarios: as a standalone storage appliance or as an appliance that is part of a two\-node cluster.  
  
The ICT window will display the two\-node configuration options only when the storage appliance is running Windows Storage Server 2012 Standard with the Failover Clustering feature enabled. For a two\-node cluster, the framework includes functionality that simplifies end user configuration or setup of both nodes of the cluster. In addition, you can customize your deployment so that appliances that are intended to be part of a cluster display two setup options to the end user during Windows Welcome: configuration of the appliance as a single node or configuration as part of a two\-node cluster.  
  
The following sections describe how to customize the ICT window for the default usage scenarios. In addition, you can create additional \(although, unsupported\) usage scenarios \(for example, tasks required to configure or set up a single node cluster\). A complete description of the customization options available to OEMs is provided on…  
  
> [!NOTE]  
> You can also customize UI elements contained on the Server Manager page and associated Roles pages by creating an XML file that conforms to the Server Manager schema. For more information, see [Server Manager Extension Schema](http://technet.microsoft.com/library/hh825683.aspx).  
  
### Customizing the ICT window for a standalone storage appliance  
The default ICT window for a standalone storage appliance displays the following task groups and their associated tasks:  
  
-   **Activate Windows**: This task group includes the **Activate Windows** task  
  
-   **Provide Computer Information**: This task group includes the **Set time zone, Configure networking**, and **Provide computer name and domain** tasks.  
  
-   **Update This Server**: This task group includes the **Enable automatic updating, Enable Windows Error Reporting, and Enable Customer Experience Improvement Program** wizards.  
  
-   **Provision Cluster Storage**: This task group includes links to the **Create Storage Pool task**, the **Create Virtual Disks and Volumes** task, and the **Create Volumes** task:  
  
    -   **Create Storage Pool**: This task should only be completed if the configuration is using Storage Spaces or an SMI\-S\- or SMP\-based storage subsystem.  
  
    -   **Create Virtual Disks and Volumes**: This task should be completed in conjunction with the Create Storage Pool task. This task enables the two wizards to be run in tandem so the user does not forget to create a volume on the virtual disk.  
  
    -   **Create Volumes**: This task should be completed only if the configuration is using an iSCSI or a non\-SMI\-S or non\-SMP based storage adapter or external RAID system. In this case, storage provisioning can either be performed at the factory or by the end user. The end user can provision LUNs by using a BIOS ROM\-based, a Windows\-based, or a web\-based configuration utility.  
  
In this task group you will find links to the **Create Storage Pool, Create disks and volumes and Create Volumes** wizard links will guide the customer through the process of provisioning storage. These wizards are also available in Server Manager under the File and Storage Services page. Storage pools enable you to group physical disks into one or more containers known as storage pools. You can then create virtual disks from available capacity in a storage pool without the need to manage each physical disk individually. This aggregation of disks enables you to make more efficient use of disk capacity, easily add storage without impacting users, and delegate administration of storage. You can use storage pools with the included Storage Spaces subsystem, or with third\-party storage subsystems including those that use the SMP or SMI\-S standards. If the disk subsystem requires using a proprietary configuration method, such as entering the storage controller BIOS before booting into Windows, or logging into a device’s HTML\-based management system, then those instructions must be provided to the end user or a link to the configuration tools should be included in the ICT along with prescriptive guidance.  
  
These are the tasks that end users complete to set up and configure their storage appliances. However, OEMs should customize the ICT window \(for example, add custom icons or text strings\), change the task groups \(or individual tasks\), remove unneeded tasks, and add hyperlinks to vendor\-specific resources that are presented to end users. For example, OEMs who activate Windows for their users may want to remove the **Activate Windows** task group \(or disable the **Activate Windows** task\).  
  
### Customizing the ICT window for a clustered storage appliance  
By default, the ICT window for a storage appliance that is part of a cluster displays the following task groups with their associated tasks:  
  
1.  **View Connection Status**: This task group includes the **Connect to the second node** task.  
  
2.  **Configure Networking**: This task group includes the **Configure networking for the first node** and **Configure networking for the second node** tasks.  
  
3.  **Configure Cluster Settings**: This task group includes the **Set time zone, Specify cluster name and domain**, and **Enable automatic updating and feedback** tasks.  
  
4.  **Provision Cluster Storage**: This task group includes links to the iSCSI Initiator task for local and remote node configuration, the **Create Storage Pool task**, the **Create Virtual Disks and Volumes task**, and the **Create Volumes** task.  
  
    -   **iSCSI Initiator**:  These tasks should be completed if the cluster is connecting to an iSCSI Target, otherwise they should be removed by deleting the relevant task group in the OEMOOBE.XML file.  
  
    -   **Create Storage Pool**: This task should only be completed if the configuration is using Storage Spaces or an SMI\-S\- or SMP\-based storage subsystem.  
  
    -   **Create Virtual Disks and Volumes**: This task should be completed in conjunction with the Create Storage Pool task. This task enables the two wizards to be run in tandem so the user does not forget to create a volume on the virtual disk.  
  
    -   **Create Volumes**: This task should be completed only if the configuration is using an iSCSI or a non\-SMI\-S or non\-SMP based storage adapter or external RAID system. In this case, storage provisioning can either be performed at the factory or by the end user. The end user can provision LUNs by using a BIOS ROM\-based, a Windows\-based, or a web\-based configuration utility.  
  
    -   **Deploy the cluster**: This task group includes the **Validate and create the cluster** task.  
  
    -   **Cluster\-Aware Updating**: This task group directs the user to the new updating mechanism for clusters that avoids downtime by coordinating and monitoring patches applied to cluster nodes.  
  
The ICT window for a two\-node cluster scenario provides the list of common tasks that an end user needs to complete, including the order in which they need to be completed. Similar to the standalone scenario, you can customize the appearance of the ICT window for a two\-node cluster \(for example, add custom icons or text\), or you can edit the task groups \(or tasks\) as required to configure or set up the nodes of a cluster. In addition, OEMs who use their own tools to provision volumes in the appliance can customize the tasks in the **Provision Storage** task group as appropriate. OEMs can also provide links to customized Help content.  
  
For storage provisioning, we recommend OEMs be very prescriptive in the tasks that the user should do. If storage can be provisioned without any end\-user input by using a Windows Powershell script that can be run during the initial start of the system for example, then OEMs should implement that and remove the Storage Provisioning section of the ICT window entirely.  
  
For a two\-node cluster, Windows Storage Server 2012 offers features that make end user configuration or setup easier. These features include automatic network discovery of the second node during the cluster setup and the ability to configure both nodes of the cluster from a single console window.  
  
> [!NOTE]  
> If your storage appliance is designed to be a node in a cluster, and you want to offer end users the choice between configuring their appliance automatically as a single node or as a node in a two node cluster \(which includes automatic network discovery\), you can customize the registry of your reference installation and create an appropriate Unattend.xml file as described in the following procedures.  
  
### Create registry keys to enable automatic network discovery  
For automatic discovery to work successfully when the storage appliance is turned on, the following registry keys must be set on the reference installation:  
  
1.  **Password**: This registry key stores the password string that enables the first node of a cluster to connect to the second node of the cluster. This registry key must exist, the string value contained in this key cannot be null, and the string must match the password value set in the answer file.  
  
2.  RunDiscovery: This registry key enables automatic network discovery. If this key is not present, or the value is not **1** or **2**, automatic discovery is disabled and the end user must configure cluster nodes manually. A value of **1** enables automatic network discovery. A value of **2** offers an end user the choice between configuring the storage appliance as a single node and configuring the storage appliance as a node in a two\-node cluster. The primary difference between these options is that as part of the two\-node cluster setup, automatic network discovery occurs.  
  
##### To add the registry keys that enable automatic network discovery  
  
1.  On the reference computer, click **Start**, click **Run**, and then type `cmd`.  
  
2.  At the command prompt, type:  
  
    ```  
    %Windir%\System32\reg add “HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\OEMOOBE” /v Password /t REG_SZ /d contoso_password /f  
  
    ```  
  
3.  Then at the command prompt, do one of the following:  
  
    To automatically enable setup or configuration processes for a two\-node cluster \(including automatic network discovery\) type:  
  
    ```  
    “HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\OEMOOBE” /v RunDiscovery /t REG_SZ /d 1 /f  
  
    ```  
  
4.  To enable the end user to select between setup and configuration options for a single node storage appliance or one that is part of a two\-node cluster, type:  
  
    ```  
    “HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\OEMOOBE” /v RunDiscovery /t REG_SZ /d 2 /f  
    ```  
  
> [!NOTE]  
> There are two additional, optional, registry keys that control aspects of the automatic discovery process: AllowSkipClustervalidation and PollUIAutomationTimeout. These keys provide additional options that you can use for testing or other purposes.  
  
### Create a Sysprep answer file  
For the ICT window to display tasks for the configuration or setup of a cluster node \(standalone or as part of a two\-node cluster\), the storage appliance must be running Windows Storage Server 2012 Standard and the Failover Clustering feature must be installed. This feature cannot be present in your master image, and it must be installed prior to the end user logging on to the storage appliance for the first time.  
  
You can enable this feature by adding the appropriate entry to an answer file \(if you use an answer file for the initial installation of Windows Server 2012\). Or you can create a specific answer file that is referenced when you run Sysprep to prepare the installation for imaging. In Sample files, there is an answer file that you can use as the basis for your Unattend.xml file. If you want the setup experience for your end users to vary based on whether the appliance is a standalone cluster node or a node in a two\-node cluster, you need to add conditional logic to your Unattend.xml file.  
  
In addition, as part of the automatic network discovery process, network adapter ports can be assigned specific names, which make it easier for the end user to identify the ports during cluster configuration and setup. To enable this feature, the answer file must contain an entry that calls a Windows PowerShell script \(renamenetworkconnection.ps1\).  
  
##### To create a Sysprep answer file  
  
1.  On your technician computer, use a text or an XML editor to open a blank document, and then copy the text of the sample Unattend.xml file. Save it locally as Unattend.xml.  
  
2.  \(Optional\) Add conditional logic to the portion of the Unattend.xml file that controls the installation of the Failover Clustering feature.  
  
3.  If you want to make additional customizations, add them to this file. You can use Windows System Image Manager \(SIM\) to add customization options to this file.  
  
4.  If you made customizations, validate this answer file by using Windows SIM. For more information about how to use Windows SIM to create or validate an answer file, see [Windows System Image Manager Technical Reference](http://technet.microsoft.com/library/hh824929.aspx) \(http:\/\/technet.microsoft.com\/library\/hh824929.aspx\).  
  
5.  Attach a removable storage device to the technician computer and copy Unattend.xml to this device.  
  
6.  Attach the removable storage device to the reference computer.  
  
7.  Copy Unattend.xml to the `%windir%\System32\sysprep` folder.  
  
You can use this answer file when you run Sysprep  
  
### Customize the Nic.config file  
Before end users turn on the nodes of their cluster, they need to attach network cables to the appropriate network adapter ports. A clustered storage appliance requires one network adapter to be attached to a private network \(for heartbeat communications between nodes\) and one or more additional network connections.  
  
> [!IMPORTANT]  
> When end user’s set up and configure their clustered storage appliance, all of the configuration or management operations use a private network connection. However, the network adapter for the private network must be configured to support the IPv4 protocol, or alternatively, both the IPv4 and IPv6 protocols. You can set these properties during audit mode. After the cluster has been configured, the end user can change the properties of this network adapter as appropriate.  
  
To simplify the identification of these ports to end users during setup or configuration tasks, the OEMOOBE framework includes a file \(Nic.config\) that controls how the network adapter ports are identified. You must customize this script as follows:  
  
1.  Add entries for the number of network adapter ports that are available in the appliance. Your master image must include a Nic.config file with entries that are identical to the storage appliances that you will deploy the master image on.  
  
2.  Set the naming scheme for the ports that are identified in the ICT window.  
  
3.  If you want to support additional languages, add duplicate entries for network adapter ports for each language that you want to support.  
  
##### To customize the Nic.config file  
  
1.  On the reference computer, open Notepad, and then open the default Nic.config file \(located at `%Windir%\System32\OEMOOBE`\).  
  
2.  Add entries for each network adapter port in the storage appliance. Network adapter ports are identified by their PCI bus location. In the default Nic.config file, there are entries for three network ports. Edit the number of network adapter ports in your reference computer appropriately. For example, in audit mode you could determine the PCI bus location for each port by reviewing the **Location** value in the Device Manager **Properties** window for your network adapters.  
  
3.  \(Optional\) Add duplicate entries for each language that you want to support. Each language is identified by a language code values. For example, the default Nic.config file includes entries for Chinese \(Simplified\), using the language locale code of **zh\-CN**. For the complete list of language locale codes, see [Language Pack Default Values](http://technet.microsoft.com/library/dd799301%28v=WS.10%29.aspx) \(http:\/\/technet.microsoft.com\/library\/dd799301%28v\=WS.10%29.aspx\).  
  
4.  Save the edited Nic.config file to the same location.  
  
> [!NOTE]  
> 1. Only the 4\-letter combinations that match the Windows language pack locale codes are supported.  
>   
> 2. If an Access denied error message appears when you attempt to save an edited file, you must take ownership of the file and set the appropriate access controls. To take ownership, at a command prompt type: `Takeown /f filename Icacls filename /grant administrators:f`  
  
## Reseal, capture, deploy, and test the master image  
After you have installed, configured, and customized Windows Storage Server 2012, you can use this deployment as a master image \(.wim\), which can be deployed on other, identical computers. Before you capture this master installation as an image, you must use the Sysprep tool to seal the installation.  
  
> [!IMPORTANT]  
> Some test\-specific settings on the reference computer should be removed before capturing the installation as a master image. For example, if you enabled the AllowSkipClustervalidation registry setting, you should remove this registry key or set the value to 0, so that end users cannot skip the cluster validation process. Also, if you enabled assertions or tracing data \(useful for testing the ICT window customization\), this feature should be disabled.  
  
### Reseal the installation on the reference computer  
You must use the Sysprep tool to ensure that Windows Welcome runs when the end user first uses the computer. Windows Welcome prompts end users to accept the software license terms, to set up their user accounts, and to perform other setup and configuration tasks.  
  
You can use the Sysprep command line tool with the \/generalize parameter to remove hardware\-specific information from the Windows operating system installation, and the \/oobe parameter to configure the computer to boot to Windows Welcome on the next restart.  
  
For more information about Sysprep, see the “Sysprep Technical Reference” topic in the Windows OPK User's Guide \(Opk.chm\).  
  
##### To reseal the computer by using Sysprep  
  
1.  To launch Sysprep in audit mode, on the reference computer, click **Start**, click **Run**, and then type `sysprep`.  
  
2.  From the **Sysprep** folder, double\-click **sysprep**.  
  
3.  From the **System Cleanup Action** list, select **Enter System Out Of Box Experience \(OOBE\)**.  
  
4.  Select Generalize.  
  
5.  In the **Shutdown Options** list, select **Shutdown**.  
  
6.  Click **OK**.  
  
> [!IMPORTANT]  
> If you need to reference an answer file, run Sysprep from a command line and provide the path to your custom answer file, for example:  
>   
> `%Windir%\system32\sysprep\sysprep.exe /oobe /generalize /shutdown /unattend:%filepath%/unattend.xml`  
  
Sysprep.exe prepares the image for capture by cleaning up various user\- and computer\-specific settings, and log files. At this point, the reference installation should be complete and ready to be imaged.  
  
> [!CAUTION]  
> When you use the sysprep \/generalize command, out\-of\-box device drivers are removed from the Windows image. If you add out\-of\-box device drivers during installation and you intend to capture the Windows image, use Windows System Image Manager \(Windows SIM\) to set the PersistAllDeviceInstalls setting of the Microsoft\-Windows\-PnpSysprep entry to True in the answer file. When you do this, Sysprep does not remove the detected device drivers.  
  
### Capture the master image  
Use DISM to capture and deploy an installation image. There are non\-Microsoft imaging tools, but DISM is the only Microsoft\-supported imaging tool. For an installation to be captured, you must run Sysprep \/generalize on the reference computer, and then turn the computer off. Boot the computer to Windows PE and then capture the complete reference installation.  
  
> [!WARNING]  
> For more information about capturing a completed installation see [How to Capture Images of Hard Disk Partitions by Using DISM](http://technet.microsoft.com/library/hh825072.aspx) \(http:\/\/technet.microsoft.com\/library\/hh825072.aspx\) and [Image Management Command\-Line Options](http://technet.microsoft.com/library/hh825258.aspx) \(http:\/\/technet.microsoft.com\/library\/hh825258.aspx\).  
  
### Deploy and test the master image  
After you have an image of your reference installation, you can deploy the image onto new hardware by using DISM. To deploy the image, you need to format the hard disk drive that will contain the operating system partition. You can use the DiskPart command line tool to format this disk. For more information, see [DiskPart](http://go.microsoft.com/fwlink/?LinkId=197182) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=197182\).  
  
> [!NOTE]  
> Your clustered storage appliances should be installed with the same Windows operating system drive configuration on each node. Configuring the computer this way can avoid possible issues during failover of iSCSI Software Target on computers configured in a failover cluster.  
  
After you create a master image from your reference computer, you should deploy that image onto an identical computer, and walk through the setup of that computer. This allows you to inspect any customizations that you made to the ICT window, to review the presence of customized storage server software license terms, or to verify that other setup processes complete as intended. This testing should be repeated for each master image that you created for deployment. Check the OEM license agreement to see if a system recovery process is required. If so, provide an appropriate recovery solution.  
  
> [!WARNING]  
> For more information about deploying master images to storage appliances, see [How to Apply Images by Using DISM](http://technet.microsoft.com/library/hh824910.aspx) \(http:\/\/technet.microsoft.com\/library\/hh824910.aspx\).  
  
## Complete post deployment tasks  
Your OEM license may require the completion of additional tasks as part of the delivery of your storage appliance. For example, you may need to provide end user documentation with each storage appliance delivered, or a DVD or CD for system restoration. Review your OEM license for more details.  
  
## Appendix A: Sample Files  
This appendix includes the following sample files that you can use for your deployment:.  
  
1.  Sample Unattend.xml file. This file controls the behavior of the storage appliance during the end user’s first logon. Two Unattend.xml files are provided, one that OEMs can use when the storage appliance is specifically designed to be a node in a two node cluster, and one that enables the end user to select whether the appliance is a standalone node or a node in a two\-node cluster.  
  
2.  Sample ConfigureClusterRole.ps1. This Windows PowerShell script file controls the cluster setup behavior based on the value of the **RunDiscovery** registry key.  
  
3.  Sample Nic.config file. This file controls the naming of network adapters within the ICT window.  
  
### Sample Unattend.xml file  
The following sample answer files \(Unattend.xml\) can be used with the Sysprep command line tool. The answer file is used when you reseal and generalize the reference computer.  
  
Two versions of the answer file \(Unattend.xml\) are provided. The first answer file can be used by OEMs when the storage appliance is specifically designed to be a node in a two node cluster. In this case, the answer file enables automatic network discovery of the second node of the cluster, which eases the cluster setup by the end user. The second answer file should be used by OEMs who want to enable the end user to select whether the appliance will be used as a standalone node or as a node in a two\-node cluster. This answer file installs the Failover Clustering feature depending on which setup option an end user selects. The presence of the Failover Clustering feature determines whether automatic network discovery of the second node occurs.  
  
> [!IMPORTANT]  
> OEMs can control if an additional dialog box is displayed to the end user during Windows Welcome. This dialog box enables the user to select between two setup options: configuring a single cluster node or configuring nodes in a two\-node cluster. Setting the **RunDiscovery** registry key to a value of 2 in your deployment enables the display of this dialog box.  
  
The `FirstLogonCommands` settings specify the commands to run the first time that a user who has administrative rights logs on to a new storage appliance. If someone with a non\-administrative account logs on to a new storage appliance, the commands that are listed in the `FirstLogonCommand` settings are not run. These commands run only once.  
  
To configure the settings that are required by Windows Storage Server 2012, you must include `SynchronousCommand`entries in the `FirstLogonCommands` section of both Unattend.xml files, as shown in the following sample. These entries will be read when you run Sysprep with the **sysprep \/oobe \/generalize** command.  
  
**Sample answer file 1:  Automates the end user’s storage appliance configuration process**  
  
The following sample answer file contains entries that provide the credentials necessary to connect to the second node if the end user intends to configure their appliance as a node in a two\-node cluster. You must edit this file so that the credentials that are contained in the file match the credentials that are used elsewhere in your deployment.  
  
The first synchronous command entry invokes a Windows PowerShell script \(renamenetworkconnection.ps1\) that automates network discovery for a two\-node cluster. The second entry adds the Failover Clustering feature to the storage appliance. Both of these entries will run during the `FirstLogonCommands` portion of the **oobeSystem** pass, which applies settings after a user with administrative rights logs on and before the desktop appears.  
  
When the first logon command runs, the Windows PowerShell script \(renamenetworkconnection.ps1\) reads the entries in the Nic.config file, which determines the naming scheme to be used when the network adapter ports are renamed. You must modify this sample Nic.config file so that it includes entries for all the network adapters in the storage appliance. You must also choose how those network adapters will be identified \(by PnP device ID number or by PCI bus location\).  
  
When the second logon command runs, the command adds the Failover Clustering feature to the storage appliance. This feature must be present on the appliance for the ICT window to display the appropriate two\-node cluster setup and configuration options.  
  
The following is a sample answer file that OEMs can use to automate the end user’s storage appliance configuration process.  
  
```  
<?xml version="1.0" encoding="utf-8"?>  
<unattend xmlns="urn:schemas-microsoft-com:unattend">  
  <settings pass="oobeSystem">  
    <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
      <UserAccounts>  
        <AdministratorPassword>  
          <Value>contoso_user</Value>  
          <PlainText>True</PlainText>  
        </AdministratorPassword>  
      </UserAccounts>  
      <AutoLogon>  
        <Password>  
          <Value>contoso_password</Value>  
          <PlainText>True</PlainText>  
        </Password>  
        <Enabled>true</Enabled>  
        <Username>Administrator</Username>  
        <LogonCount>1</LogonCount>  
      </AutoLogon>  
        <FirstLogonCommands>  
    <SynchronousCommand wcm:action="add">  
     <CommandLine>C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe c:\windows\system32\OEMOOBE\renamenetworkconnection.ps1;</CommandLine>  
     <Description>Rename NICs</Description>  
     <Order>1</Order>  
   </FirstLogonCommands>   
          </component>  
      </settings>  
</unattend>  
  
```  
  
**Sample answer file 2: Enables end users to select a clustered setup experience**  
  
The following sample answer file contains entries that provide the credentials that are necessary to connect to the second node if the end user intends to configure the storage appliance as a node in a two\-node cluster. You must edit this file so that the credentials that are contained in the file match the credentials that are used elsewhere in your deployment.  
  
If the appliance is not intended to be attached to a cluster immediately, the end user can choose the standalone node setup options and the **RunDiscovery** registry key value is set to 0. If the user chooses the two node cluster setup option, the **RunDiscovery** registry key value is set to **1**.  
  
The answer file includes a call to a Windows PowerShell script \(configureClusterRole.ps1\), which reads the value of the **RunDiscovery** registry key. If the value is set to 0, the Failover Clustering feature is not installed. If the **RunDiscovery** registry key value is set to **1**, the Failover clustering feature is installed. The presence of the Failover Clustering feature, together with a **RunDiscovery** registry key value of **1** triggers the automatic network discovery process \(which requires a customized Nic.config file\). In addition, the ICT window displays tasks that are suitable for the two\-node cluster setup.  
  
The following is a sample answer file that OEMs can use to enable end users to select their cluster node setup experience.  
  
```  
<?xml version="1.0" encoding="utf-8"?>  
<unattend xmlns="urn:schemas-microsoft-com:unattend">  
  <settings pass="oobeSystem">  
    <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
      <UserAccounts>  
        <AdministratorPassword>  
          <Value>contoso_user</Value>  
          <PlainText>True</PlainText>  
        </AdministratorPassword>  
      </UserAccounts>  
      <AutoLogon>  
        <Password>  
          <Value>contoso_password</Value>  
          <PlainText>True</PlainText>  
        </Password>  
        <Enabled>true</Enabled>  
        <Username>Administrator</Username>  
        <LogonCount>1</LogonCount>  
      </AutoLogon>  
  <FirstLogonCommands>  
    <SynchronousCommand>  
      <Order>1</Order>  
        </SynchronousCommand>  
      </FirstLogonCommands>  
    </component>  
  </settings>  
</unattend>  
  
```  
  
### Sample Nic.config file  
The following is an example of the Nic.config file, which is the file that controls the naming scheme that is applied to network adapter ports as part of the automatic discovery for a two\-node cluster. You must modify the Nic.config file if your storage appliance is a node in a two\-node cluster.  
  
> [!WARNING]  
> A copy of the Nic.config file can be found in the **%Windir%\\System32\\OEMOOBE** folder.  
  
```  
<?xml version="1.0" encoding="utf-8" ?>  
<configuration>  
  <!--  
     Empty or missing language id attribute indicates culture-neutral mapping, which is used only if a  
     culture-sensitive mapping cannot be located in the configuration.       
  
     Supply "-NicIdPropName LocationInfo" to NicConfig.ps1 to use device location information for NIC id.  
     Device location information string is culture sensitive. NicConfig.ps1 always tries to use the current  
     UI culture to match an entry in culture-sensitive mappings first.  
  
     The below content is just an example and needs to be updated to reflect the real configuration.  
  -->  
  <language id="">  
    <nic id="PCI bus 100, device 0, function 0" name="Cross-Over Red" isClusterPrivate="true" />  
    <nic id="PCI bus 101, device 0, function 0" name="Green" />  
  </language>  
  <language id="en-US">  
    <nic id="PCI bus 111, device 0, function 0" name="Cross-Over Red" isClusterPrivate="true" />  
    <nic id="PCI bus 114, device 0, function 0" name="Green" />  
    <nic id="PCI bus 114, device 0, function 1" name="Blue" />  
    <nic id="PCI bus 115, device 0, function 0" name="Black" />  
    <nic id="PCI bus 115, device 0, function 1" name="White" />  
    <nic id="PCI bus 117, device 0, function 0" name="Yellow" />  
  </language>  
  <language id="zh-CN">  
    <nic id="PCI 总线 1、设备 0、功能 0" name="红色" isClusterPrivate="true" />  
    <nic id="PCI 总线 2、设备 0、功能 0" name="绿色" />  
    <nic id="PCI 总线 3、设备 0、功能 0" name="蓝色" />  
  </language>  
</configuration>  
  
```  
  
> [!NOTE]  
> The Bus, Device and Function values for a NIC can be found in the Device Manager properties dialog box for a given NIC.  
  
## Appendix B: Registry keys  
Depending on if your storage appliance will be used as a standalone appliance or as a node in a two\-node cluster, you might need to configure certain registry keys on your reference installation.  
  
This appendix describes the Windows Storage Server 2012 extensibility registry keys. These registry keys enable automatic network discovery when the storage appliance is a node within a two\-node cluster.  
  
### Windows Storage Server 2012 registry keys  
The tables in this section of the appendix describe registry keys that it might be useful to customize a storage appliance running Windows Storage Server 2012.  
  
**HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Terminal Server**  
  
||||  
|-|-|-|  
|**Name**|**Type**|**Description**|  
|fDenyTSConnections|REG\_DWORD|The default value is 1. Specifies whether the Remote Desktop Connection \(RDC\) feature is enabled.|  
  
**HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Terminal Server\\WinStations\\RDP\-TCP**  
  
||||  
|-|-|-|  
|**Name**|**Type**|**Description**|  
|UserAuthentication|REG\_DWORD|The default value is 0. Disables Remote Desktop network level authentication to enable remote management from a variety of computers.|  
  
### Windows Storage Server 2012 extensibility registry keys  
OEMs should brand and customize the Initial Configuration Tasks \(ICT\), on the storage appliance as part of your deployment process. In addition, if your storage appliance is a node in a two\-node cluster, you must manually set the following several extensibility\-specific registry keys.  
  
**HKEY\_LOCAL\_MACHINE\\Software\\Microsoft\\OEMOOBE**  
  
The installation of the OEM\-Appliance\-OOBE feature will create an OEMOOBE registry subkey under HKLM\\Software\\Microsoft. This subkey contains registry keys that are used when configuring a two\-node cluster. Some of these keys must be created, and others are automatically generated during the two\-node cluster configuration process. For automatic network discovery to occur during the two\-node cluster configuration, OEMs must manually add the following registry keys.  
  
||||  
|-|-|-|  
|**Name**|**Type**|**Description**|  
|AllowSkipClusterValidation|REG\_SZ|This key enables OEMs to skip cluster validation as part of their testing. A key value of 1 skips the cluster validation process. If this registry key is not present or if it has any other value, the cluster validation process occurs.<br /><br />If OEMs add this registry key to their storage appliances during testing, it should be removed or disabled before creating a master image. If this key is present in the master image, it will enable end users to skip the validation process, which could result in cluster configuration issues.|  
|Password|REG\_SZ|This key enables authentication during discovery of the second node of a two\-node cluster. The password value must match the value that you add to the Unattend.xml file, and it cannot be null.|  
|SuppressHAFileServer|REG\_SZ|Removes the \(default –checked\) checkbox in the create cluster wizard and disables the automatic creation of a cluster file\-server resource group using all available storage.|  
|PollUIAutomationTimeout|REG\_SZ|This key controls the period of time that can elapse before a time out occurs during the configuration of a two node cluster. This key is optional, and it does not have to be created by the OEM. If this key does not exist, a default value of 45 seconds is used. However, OEMs that run their storage appliances under virtualization can create this key and set an appropriate value \(the key value represents seconds\).|  
|RunDiscovery|REG\_SZ|This key controls the setup experience that is displayed to end users. A value of 1 enables automatic network discovery and the display of cluster\-specific tasks or task groups within the ICT window. A value of 2 enables end users to choose if they want their storage appliance to be configured as a single node in a cluster or as part of a two node cluster. If this key does not exist, or if it has any value besides 1 or 2, automatic network discovery is disabled and manual setup and configuration is required.|  
  
The following registry keys are automatically created during the cluster configuration process.  
  
||||  
|-|-|-|  
|**Name**|**Type**|**Description**|  
|ClusterName|REG\_SZ|The ClusterName key is automatically created as part of the Cluster Name and Domain Join Wizard. The wizard uses this key value to automatically populate the **Cluster Management Name** field in the wizard.|  
|RemoteNodeIpAddress|REG\_SZ|This key stores the link\-local IP address of the alternate node, which is assigned after both nodes are connected with a cross over cable.|  
|RemoteNodeName|REG\_SZ|This key is created as part of the cluster configuration or setup process. It stores the remote node name. For example, on the first node of a two\-node cluster, this key stores the name of the computer that is the second node of the cluster.|  
  
## <a name="bkmk_appf_ICT_extensibility"></a>Appendix C: ICT extensibility and branding customization  
Windows Storage Server 2012 provides an XML\-based framework so that OEM partners can implement custom extensibility and branding to management screens. This framework is called OEMOOBE, which stands for the Original Equipment Manufacturer out\-of\-box experience. The framework uses standard XML code and Windows PowerShell scripts to create a customized Initial Configuration Tasks \(ICT\) window that is a WPF application. This appendix includes specific information and sample files that you can use for ICT window customization.  
  
> [!IMPORTANT]  
> If you edit any of the Windows PowerShell scripts that are provided in the OEMOOBE framework \(for example, OEMOOBE.ps1\), or if you add your own Windows PowerShell scripts, you may need to set the remote execution policy, by adding the following line to the OEMOOBE.psd1 file or for custom Windows PowerShell scripts run from the ICT window: **Set\-ExecutionPolicy RemoteSigned \-Scope Process \-Force**.  
  
The ICT window can be customized visually to include your own branding logos, icons, and text. In addition, you can add, delete, hide, rename, and reorder administrative task groups and individual tasks, and run Windows PowerShell scripts for a custom end\-user experience. Specifically, you can customize the following elements in the ICT window:  
  
-   **ICT window title bar**: You can modify the icon and text that are displayed in the ICT title bar.  
  
-   **ICT window header**: You can modify the icon and title text that are displayed in the ICT window header section.  
  
-   **Task group**: You can create new management task groups; delete existing task groups; modify the default task group display, order, and naming; add an icon for a task group; create Help topics; and display or hide the Help button.  
  
-   **Task**: Within a task group, you can create new tasks; delete existing tasks; and modify the default task display, UI order, naming values, and property values.  
  
-   **Profile selection**: Two configuration profiles are included, but they are not displayed by default. For more information, see the following [Initial Configuration Tasks window](#BKMK_ICTWindow) section.  
  
> [!NOTE]  
> ICT window fonts and colors cannot be changed.  
  
You can also customize the user interface elements that are contained on the Server Manager page and the associated Roles pages by creating an XML file that conforms to the Server Manager schema. For information, see [Server Manager Extension Schema](-http-//technet.microsoft.com/library/hh825683.aspx-).  
  
### <a name="BKMK_ICTWindow"></a>Initial Configuration Tasks window  
Two configuration profiles are available for the ICT window: the **Configure a standalone NAS** profile and the **Configure a 2\-node cluster** profile.  
  
By default, no profile selection box is displayed on the ICT window because the profile is automatically defined based on the edition of Windows Storage Server 2012 that is deployed. You can extend the OEMOOBE.xml file to include additional profiles, for example, to create a single node cluster or to add a node to an existing two node cluster. However, these additional profiles are not supported by Microsoft.  
  
**Standalone profile**  
  
The standalone network access server \(NAS\) profile is included for all editions of Windows Storage Server 2012. This profile enables task groups and tasks that are pertinent to single\-server environments.  
  
**Two\-node cluster profile**  
  
The two\-node cluster profile is included only for Windows Storage Server 2012 Standard, and it is displayed only if the Failover Clustering feature is installed. This profile enables task groups and tasks that are pertinent to two\-node cluster environments. The two\-node cluster profile supports a cluster configuration from a single console by using Windows RemoteApp and Windows PowerShell remoting capabilities.  
  
You can customize the default two\-node cluster profile to complete the setup of a packaged two\-node failover cluster. For example, the OEMOOBE.xml file can be modified to display a drop\-down list in the user interface to present additional profiles that can be used to display task groups and tasks or to add an additional node to an existing cluster.  
  
In the two\-node cluster profile, you must set a common local administrator password for both cluster nodes as part of the Sysprep process to enable the authentication that is required for remote cluster node configuration. This password cannot be null.  
  
**Customizing ICT user interface elements**  
  
You can modify and customize various user interface elements for the ICT window by modifying the OEMOOBE.xml file. The **Profile Selection** box is not displayed until the OEMOOBE.xml file is modified to display this element.  
  
If you want to modify the ICT window, you need to extend the **Provision Storage** and **Provision Cluster Storage** task groups for the appropriate configuration profile to enable provisioning for your specific storage appliance.  
  
The ICT has tools that can be used by OEMs for a specific storage appliance. OEMs should choose the specific tools needed for the customer’s desired configuration.  
  
1.  **Create a Storage Pool**  
  
    A Storage Pool is a new disk\-virtualization feature in Windows Server 8 that can be created using storage spaces or using a hardware\-based disk provider based on SMP or SMI\-S enabled storage devices.  
  
2.  **Create Disks and Volumes**  
  
    The Create Virtual Disks and Volumes wizard is used to create virtual disks \(LUNs\). This wizard option should only be displayed if using a storage pool. These two options will not work unless using SMI\-S, SMP, or storage spaces. In this case, the Create Volume wizard can be used instead. OEMs should decide which wizard options to display in the ICT window.  
  
3.  **Create Volumes**  
  
    The Create Volumes wizard is used to create, format and assign drive letters to volumes  
  
OEMs should add prescriptive messages for tasks with instructions for the end user to follow for such tasks. For more information, see the sections Adding task messages, Dynamically updating task message text and Dynamically updating task message severity.  
  
Creating a cluster requires provisioning a minimum of two LUNs for the cluster: one LUN \(with a minimum size of 700 megabytes\) for a witness disk and one \(or more\) LUNs to support high availability file server instances. The LUNs must be brought online, initialized, assigned a drive letter, and formatted by using the storage subsystems configuration utility or the available storage wizards in Windows or automatically launch Windows PowerShell scripts to complete the configuration.  
  
> [!NOTE]  
> The LUNs must be available before running the **Validate and create the cluster** task in the **Deploy the Cluster** task group.  
  
> [!NOTE]  
> If an **Access denied** error message appears when you attempt to save an edited file, you must take ownership of the file and set the appropriate access controls. To do this, at a command prompt type:  
>   
> **Takeown \/f filename**  
>   
> **Icacls filename \/grant administrators:f**  
  
**ICT window title bar icons**  
  
The following sample shows how to extend the OEMOOBE.xml file to change the title bar icon. The default icon is a 16x16 pixel icon \(.ico\) image, which is a resized version of the icon in the page header section \(unless you specified a different image for the title bar\). If you specified a different icon for the title bar, your image file \(for example, .gif, .png, .jpg, .ico, and so on\) should be the same size; a smaller image will include white space in the top right\-hand corner of the window, and a larger image will be truncated.  
  
The path to the image can be a relative or an absolute path value.  
  
The value for `titleResource` is set by using the OEMOOBE.resx file. This attribute is used for showing the localized Windows title bar. The OEMOOBE.resx file consists of data that is specified as `key-value` pairs.  
  
If the `titleResource` attribute is set, the Windows title in the ICT window is shown per the `titleResource` attribute. If it is not set \(or if the OEMOOBE.resx file is not available\), the Windows title in the ICT window is shown per the `title` attribute.  
  
```  
<oobe xmlns="http://www.contoso.com/OEMOOBE.xsd"  
   title="Initial Configuration Tasks"  
   titleResource="WindowTitle"  
   icon="Images\Your_Icon.ico"  
   headerText="Perform the following configuration tasks"  
   headerTextResource="HeaderText"  
   headerImage="Images\Your_Header_Icon.ico">  
  
```  
  
**ICT title bar text**  
  
The following sample shows how to extend the OEMOOBE.xml file to change the ICT title bar text.  
  
```  
<oobe xmlns="http://www.contoso.com/OEMOOBE.xsd"  
   title="Contoso SuperNAS Configuration Tasks"  
   titleResource="WindowTitle"  
   icon="Images\Your_Icon.ico"  
   headerText="Perform the following configuration tasks"  
   headerTextResource="HeaderText"  
   headerImage="Images\Your_Header_Icon.ico">  
  
```  
  
**ICT window header icon**  
  
The following sample shows how to extend the OEMOOBE.xml file to change the ICT window header icon. Your image file \(for example, .gif, .png, .jpg, .ico, and so on\) should be 24x24 pixels in size; a smaller image will include white space in the top right\-hand corner of the window, and a larger image will be truncated. The path to the image can be a relative or an absolute path value.  
  
```  
<oobe xmlns="http://www.contoso.com/OEMOOBE.xsd"  
   title="Contoso SuperNAS Configuration Tasks"  
   titleResource="WindowTitle"  
   icon="Images\YourIcon.ico"  
   headerText="Perform the following configuration"  
   headerTextResource="HeaderText"  
   headerImage="Images\Your_Header_Icon.ico">  
  
```  
  
**ICT window header text**  
  
The following sample shows how to extend the OEMOOBE.xml file to change the page ICT header text.  
  
```  
<oobe xmlns="http://www.contoso.com/OEMOOBE.xsd"  
   title="Your Configuration Tasks"  
   titleResource="WindowTitle"  
   icon="Images\YourIcon.ico"  
   headerText="Contoso SuperNAS Configuration Tasks"  
   headerTextResource="HeaderText"  
   headerImage="Images\YourHeaderIcon.ico">  
  
```  
  
**Profile selection**  
  
The OEMOOBE framework can be extended to support different configuration profiles, such as to create profiles for single\-node clusters or to add a node to existing failover clusters. The following sample shows how to extend the OEMOOBE.xml file to display the **Configure a 1\-node cluster** profile option.  
  
> [!NOTE]  
> Extending the profile selections to include additional profiles is not supported by Microsoft.  
  
```  
<profiles title="Show tasks for this deployment:"  
   titleResource="ProfilesTitle"  
   requireProfileSelection="true">  
  
<profile title="Configure a one-node cluster"  
<profile title="Configure a 1-node cluster"  
   titleResource="ProfileClusterSingleNode"  
   description="Configures a one-node cluster."  
   descriptionResource="ProfileCluster1NodeDescription"  
   visible="$global:g_isClusterInstalled"  
   selectCommand="$g_profile='Cluster1Node_Profile'"/>  
</profiles>  
  
```  
  
**Creating new task groups**  
  
A task group is used to group one or more tasks. New tasks can be added with the `task` element. The following sample shows how to extend the OEMOOBE.xml file to create a new task group called **Partner Information Links**.  
  
```  
<!-- BEGIN: task groups for 2-Node Cluster profile -->  
<taskGroup title="Task for Partner Information Links"  
titleResource="Partner Information Links"  
visible="$true"  
helpCommand="notepad $env:windir\system32\oemoobe\Help.txt"  
collapseByDefault="false">  
   </taskGroup>  
   <taskGroup title="View Connection Status"  
  
```  
  
**Deleting task groups**  
  
Task groups can be deleted simply by deleting the XML code that defines the applicable **taskGroup** element.  
  
**Hiding task groups**  
  
Task groups can be hidden in the UI by setting the `visible` attribute to `“$false”`. The following sample shows how to hide the task group Partner Information Links.  
  
```  
<!-- BEGIN: task groups for 2-Node Cluster profile -->  
   <taskGroup title="Partner Information links"  
     titleResource="Partner Information Links"  
     visible="$false"  
     helpCommand=""  
     collapseByDefault="false">    
   </taskGroup>  
  
```  
  
**Renaming task groups**  
  
Task groups can be renamed by changing the text in the `taskGroup` element title. The following sample shows how to rename the task group title to **Partner Information Links**.  
  
```  
<!-- BEGIN: task groups for 2-Node Cluster profile -->  
   <taskGroup title="Your_task_group_name"  
     titleResource="Partner Information Links"  
     visible="$true"  
     helpCommand=""  
     collapseByDefault="false">    
   </taskGroup>  
  
```  
  
**Displaying an icon for a task group**  
  
By default, task groups do not display an icon in the ICT window. However, an icon can be associated with a task group by adding an `image` entry to the task group element.  
  
The following sample shows how to extend the OEMOOBE.xml file so that an icon is displayed for a task group. Your image file \(for example, .gif, .png, .jpg, .ico, and so on\) should be 24x24 pixels in size; a smaller image will include white space in the top right\-hand corner of the window, and a larger image will be truncated. The path to the image file for your task group icon can be a relative or an absolute path value.  
  
```  
<!-- BEGIN: task groups for 2-Node Cluster profile -->  
   <taskGroup title="Your_task_group_name"  
     titleResource="Partner Information Links"  
     image="Images\Your_Task_Group_Icon.ico"  
     visible="$true"  
     helpCommand=""  
     collapseByDefault="false">    
   </taskGroup>  
  
```  
  
**Reordering task groups in the ICT window**  
  
The order that task groups are displayed can be changed. Simply cut\-and\-paste the applicable <taskGroup> code section as needed to create a corresponding order change in the user interface.  
  
**Changing task group expand\/collapse**  
  
All task group containers are expanded by default, but they can be modified to be collapsed when the user interface is opened. The collapse state is controlled by setting the `collapseByDefault` attribute to true or false. The default is false \(to not collapse the task group\).  
  
```  
<taskGroup title="Task for Partner Information links"  
        titleResource="Partner Information Links"  
        visible="$true"  
        helpCommand=""  
        collapseByDefault="true">   
    <task title="Verify Windows Authentication"  
     titleResource="Verify Windows Authentication"  
     image="Images\ActivateWindows.ico"  
     visible="$true"  
     enabled="$true"  
     command="slui.exe">  
  </task>  
  </taskGroup>  
  
```  
  
**Hiding the task group Help button**  
  
The Help button is not displayed if the `helpCommand` value is not specified \(this is an optional attribute for a task group\).  
  
```  
<!-- BEGIN: task groups for 2-Node Cluster profile -->  
    <taskGroup title="Task for Partner Information links"  
        titleResource="Partner Information Links"  
        visible="$true"  
        helpCommand=""  
        collapseByDefault="false">    
    </taskGroup>  
   <taskGroup title="View Connection Status"  
  
```  
  
**Adding a link to a Help resource**  
  
You can add or change the path that is used to connect to a Help resource for a task group, such as a local CHM Help file or to an external website. The following sample will link the user to the Microsoft website when the Help button for a task group is clicked.  
  
```  
<!-- BEGIN: task groups for 2-Node Cluster profile -->  
    <taskGroup title="Partner Information links"  
        titleResource="Partner Information Links"  
        visible="$true"  
        helpCommand="http://www.microsoft.com"  
        collapseByDefault="false">    
    </taskGroup>  
   <taskGroup title="View Connection Status"  
  
```  
  
**Tasks**  
  
A task group is comprised of one or more tasks. Each task can have one or more properties. A task can also be visible, hidden, enabled, or disabled, based on a Windows PowerShell expression. A disabled task will appear gray in the user interface, and it cannot be used to perform any action.  
  
**Creating new tasks**  
  
A new task can be added within an existing or new `<taskGroup>` section.  
  
```  
<taskGroup>  
<taskGroup title="Task for Partner Information links"  
        titleResource="Partner Information Links"  
        visible="$true"  
        helpCommand=""  
        collapseByDefault="false">  
    <task title="Verify Windows Authentication"titleResource="Verify Windows Authentication"image="Images\ActivateWindows.ico"visible="$true"enabled="$true"command="slui.exe"></task>  
</taskGroup>  
  
```  
  
**Deleting tasks**  
  
Tasks can be deleted simply by deleting the XML code that defines the applicable task section.  
  
**Disabling tasks**  
  
A task that has the `enabled` attribute set to `$false` will appear as a disabled task. A disabled task cannot be used to perform any action.  
  
> [!NOTE]  
> An empty `command` attribute also disables a task, even if the `enabled` attribute is set to `$true`. The following sample adds the false attribute to disable the link to **Task for Partner Information links**.  
  
```  
<taskGroup>  
<taskGroup title="Task for Partner Information links"  
        titleResource="Partner Information Links"  
        visible="$true"  
        helpCommand=""  
        collapseByDefault="false">  
    <task title="Verify Windows Authentication"  
     titleResource="Verify Windows Authentication"  
     image="Images\ActivateWindows.ico"  
     visible="$true"  
     enabled="$false"  
     command="slui.exe">  
    </task>  
</taskGroup>  
  
```  
  
**Hiding tasks**  
  
Tasks can be hidden in the user interface by setting the `visible` attribute value to `$false`. However, whether a task is displayed can depend on additional conditions. For example, the Cluster Name and Domain Join Wizard is displayed only if the Failover Clustering feature is installed. The following sample shows how to hide the **Verify Windows Authentication** task.  
  
```  
<taskGroup>  
<taskGroup title="Task for Partner Information links"  
        titleResource="Partner Information Links"  
        visible="$true"  
        helpCommand=""  
        collapseByDefault="false">  
    <task title="Verify Windows Authentication"  
     titleResource="Verify Windows Authentication"  
     image="Images\ActivateWindows.ico"  
     visible="$false"  
     enabled="$true"  
     command="slui.exe">  
    </task>  
</taskGroup>  
  
```  
  
**Changing a task icon**  
  
An icon can be displayed for any task. The following sample shows how to reference a different icon file to change the icon that is displayed in the user interface.  
  
```  
<taskGroup>  
<taskGroup title="Task for Partner Information links"  
        titleResource="Partner Information Links"  
        visible="$true"  
        helpCommand=""  
        collapseByDefault="false">  
    <task title="Verify Windows Authentication"  
     titleResource="Verify Windows Authentication"  
     image="Images\NewActivateWindows.ico"  
     visible="$false"  
     enabled="$true"  
     command="slui.exe">  
    </task>  
</taskGroup>  
  
```  
  
**Changing task action**  
  
A task performs the action that is specified by the `command` attribute. An empty `command` attribute disables a task, even if the enabled attribute is set to `true`. The following sample shows how to associate an application with a task. All applications must be located in the Windows system file path.  
  
```  
<taskGroup>  
<taskGroup title="Task for Partner Information links"  
        titleResource="Partner Information Links"  
        visible="$true"  
        helpCommand=""  
        collapseByDefault="false">  
    <task title="Verify Windows Authentication"  
     titleResource="Verify Windows Authentication"  
     image="Images\NewActivateWindows.ico"  
     visible="$false"  
     enabled="$true"  
     command="NewWindowsActive.exe">  
    </task>  
</taskGroup>  
  
```  
  
**Adding new task properties**  
  
A task property can be created for a task within the `<properties>` section. The following sample shows how to add a new Product ID property to the **Verify Windows Authentication** task.  
  
```  
<task title="Verify Windows Authentication"  
     titleResource="Verify Windows Authentication"  
     image="Images\NewActivateWindows.ico"  
     visible="$false"  
     enabled="$true"  
     command="slui.exe">  
     <properties>  
     <property title=”Product ID:”titleResource=”TaskPropertyTitleProductID:”visible=”$true”value=”$global:g_windowsPID”  
     </properties>  
   </task>  
  
```  
  
**Deleting task properties**  
  
Task properties can be deleted simply by deleting the XML code that defines the applicable property section.  
  
**Hiding task properties**  
  
A hidden task property is not shown in the user interface. The following sample shows how to hide the **Verify Windows Authentication** task.  
  
```  
<task title="Verify Windows Authentication"  
     titleResource="Verify Windows Authentication"  
     image="Images\NewActivateWindows.ico"  
     visible="$false"  
     enabled="$true"  
     command="slui.exe">  
     <properties>  
        <property title=”Product ID:”  
        titleResource=”TaskPropertyTitleProductID:”  
        visible=”$false”  
        value=”$global:g_windowsPID”  
     </properties>  
   </task>  
  
```  
  
**Adding task messages**  
  
A message can be associated with a task. Only one message can be displayed per task. The following sample shows how to add message text for the **Verify Windows Authentication** task.  
  
```  
<task title="Verify Windows Authentication"  
     titleResource="Verify Windows Authentication"  
     image="Images\NewActivateWindows.ico"  
     visible="$false"  
     enabled="$true"  
     command="slui.exe">  
     <properties>  
        <property title=”Product ID:”  
        titleResource=”TaskPropertyTitleProductID:”  
        visible=”$true”  
        value=”$global:g_windowsPID”  
     </properties>  
     <message text=”Authenticate task”textResource=””severity=”Info”visible=”$true”textExpression=”$global:windowsActivateMessage.Text”severityExpression=”$global:windowsActivateMessage.Severity”</message>”  
  </task>  
  
```  
  
**Deleting task messages**  
  
A deleted task message will not appear under a task in the user interface. To delete task messages that are associated with a task, delete the entries that define the message. For example, to delete the message text for the **Verify Windows Authentication** task, remove the code that was described in the **Adding task messages** section \(shown previously\).  
  
**Dynamically updating task message severity**  
  
The severity level that is associated with a task message can be dynamically updated in the user interface, with the associated icons displayed. The value of the **severityExpression** attribute shown is a Windows PowerShell expression that can have one of three different values:  
  
1.  **Info**. The information icon is displayed for the message.  
  
2.  **Warning**. The warning icon is displayed for the message.  
  
3.  **Error**. The error icon is displayed for the message.  
  
The following sample shows how to enable the display of a severity level icon for a task on the ICT window.  
  
```  
<task title="Verify Windows Authentication"  
   titleResource="Verify Windows Authentication"  
   image="Images\NewActivateWindows.ico"  
   visible="$false"  
   enabled="$true"  
   command="slui.exe">  
   <properties>  
      <property title=”Product ID:”  
      titleResource=”TaskPropertyTitleProductID:”  
      visible=”$true”  
      value=”$global:g_windowsPID”  
   </properties>  
   <message text=”Authenticate task”  
      textResource=””  
      severity=”Info”  
      visible=”$true”  
      textExpression=”$global:windowsActivateMessage.Text”  
      severityExpression=”$global:windowsActivateMessage.Severity”  
   </message>”  
</task>  
  
```  
  
**Dynamically updating task message text**  
  
The message that is displayed for a task can be dynamically updated in the user interface. The value of the **textExpression** attribute is a Windows PowerShell expression. The following sample shows how to enable the text for the **Verify Windows Authentication** task to update dynamically.  
  
```  
<task title="Verify Windows Authentication"  
     titleResource="Verify Windows Authentication"  
     image="Images\NewActivateWindows.ico"  
     visible="$false"  
     enabled="$true"  
     command="slui.exe">  
     <properties>  
        <property title=”Product ID:”  
        titleResource=”TaskPropertyTitleProductID:”  
        visible=”$true”  
        value=”$global:g_windowsPID”  
     </properties>  
     <message text=”Authenticate task”  
        textResource=””  
        severity=”Info”  
        visible=”$true”  
        textExpression=”$global:windowsActivateMessage.Text”  
        severityExpression=”$global:windowsActivateMessage.Severity”  
     </message>”  
  </task>  
  
```  
  
**Creating a wgaProperty**  
  
The Windows Genuine Advantage \(WGA\) property displays the Windows Genuine Advantage icon. The icon is only displayed if Windows is activated. The property has a `visible` attribute, and it can be hidden by changing the `visible` attribute to `$false`. The following sample shows how to enable the display of the Windows Genuine Advantage icon if the storage appliance has been activated.  
  
```  
<task title="Verify Windows Authentication"  
     titleResource="Verify Windows Authentication"  
     image="Images\ActivateWindows.ico"  
     visible="$true"  
     enabled="$true"  
     command="slui.exe">  
<properties>     
       <wgaProperty visible="$true">  
</properties>  
</task>  
</taskGroup>  
  
```  
  
**Adding a task property expression**  
  
A property expression can be added to a task. Property expressions are used when there are two or more value pairs for a property element, and they represent a name\-value pair. The property title and value elements are generated dynamically by using a Windows PowerShell array. There can be only one expression associated with a task. Each entry in the Windows PowerShell array represents one task property in the user interface.  
  
##### To add a property expression  
  
1.  Edit the Oemoobe.ps1 Windows PowerShell file.  
  
2.  Add a `Properties` element to the applicable `<task>` section in the OEMOOBE.xml file.  
  
3.  Edit the `<refresh>` section in the OEMOOBE.xml file.  
  
4.  Edit the `<init>` section in the Oemoobe.xml file.  
  
The following example displays all the installed Windows features in the **Available Features** task group.  
  
**1. Edit the OEMOOBE.ps1 Windows PowerShell file.**  
  
Add the following code to the end of the OEMOOBE.ps1 file. This function returns all the installed Windows features:  
  
```  
Function GetWindowsFeatures  
{  
  param([string] $installState)  
  $featureList=@()    
  $features = Invoke-Command -scriptBlock {Import-Module ServerManager;Get-WindowsFeature | Where-Object {$_.Installed -eq $installState} | Select-Object Name, Installed }  
  
  foreach($feature in $features)  
  {  
  $featureList+=@{$feature.Name=$feature.Installed}  
  }  
  return $featureList  
}  
  
```  
  
**2. Add a Properties element to the applicable Task section of the OEMOOBE.xml file.**  
  
Add a `<properties expression>` element within the `<task>` element, which is within the `<taskGroup>` element:  
  
```  
<taskGroup>  
   <taskGroup title="Available features"   
         titleResource=""  
         visible="($g_profile -eq 'Cluster2Node_Profile')"   
         helpCommand="notepad $env:windir\system32\OEMOOBE\Help.txt"   
         collapseByDefault="false">  
  
      <task title="Add a windows feature"   
         titleResource=""  
         image="Images\ConfigureNetworkingTask.ico"  
         visible="$true"   
         enabled="$true"   
         command="C:\windows\System32\ServerManager.msc">  
         <properties expression="$propExpression">  
       </task>  
</taskGroup>  
```  
  
**3. Edit the <refresh> section of the OEMOOBE.xml file.**  
  
Edit the `<refresh>` section, which is located within the `<scripts>` section in the OEMOOBE.xml file:  
  
```  
<refresh>  
     #  
     # This script is run when Oemoobe has focus or F5 is pressed.  
     # This script should complete quickly. Any long  
     # running task should use an asynchronous job.  
     #  
  
     if(!$global:g_isClusterInstalled)  
     {  
       # Standalone profile  
  
       # Async refresh Windows activation status  
       $global:g_refreshWindowsActivationQueued=$true  
       PollQueryWindowsActivationJob  
  
       # Refresh the local settings for Standalone profile  
       RefreshLocalSettingsForStandaloneProfile  
     }  
     else  
     {  
       # 2-Node Cluster profile  
  
       # Keep polling the state of the remote node periodically  
       $global:g_refreshRemoteRebootPendingState='NotStarted'  
       PollRemoteMachineStatus  
  
       # Queue a refresh to query local setting for 2-Node Cluster profile  
       $global:g_refreshLocalSettingsQueued=$true  
  
       # Keep polling the state of the remote node periodically  
       PollRemoteMachineStatus  
  
       # Try to set up RemoteApp  
       TrySetupRemoteApp  
  
       # Refresh the settings of the remote node  
       $global:g_refreshRemoteSettingsQueued=$true  
       RefreshRemoteMachineSettings  
     }  
  
     #added for property expression$installState=$true$propExpression=GetWindowsFeatures $installState | ToArray  
</refresh>  
  
```  
  
**4. Edit to the <init> section of the OEMOOBE.xml file.**  
  
Edit the `<init>` section, which is located within the `<scripts>` section in the OEMOOBE.xml file:  
  
```  
<init>  
     #  
     # Script in this block will be run first and will be run only once  
     #  
  
     [void][System.Reflection.Assembly]::Load("Microsoft.Windows.Server, Version=1.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35")  
     [void][System.Reflection.Assembly]::Load("Microsoft.Windows.Oem.Oobe.Common, Version=1.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35")  
  
Set-ExecutionPolicy RemoteSigned -Scope Process –Force  
  
     # include the function library  
     ."$env:windir\system32\OEMOOBE\OEMOOBE.ps1"  
  
     # Initialize global variables  
     InitializeGlobalVariables  
  
     # Check if local server has cluster service installed  
     # If cluster service is installed, we will only support Standalone profile,  
     # otherwise, we will only support 2-Node Cluster profile  
     $global:g_isClusterInstalled=IsClusterInstalled  
  
     if(!$global:g_isClusterInstalled)  
     {  
       # Standalone profile  
  
       # Query if local Windows has been activated  
       # The query is called synchronously  
       $global:g_isWindowsActivated=IsWindowsActivated  
  
       # Get Windows PID and generate a displayable string  
       $global:g_windowsPID=GetWindowsProductID $global:g_isWindowsActivated  
  
       # Refresh the local settings for Standalone profile  
       RefreshLocalSettingsForStandaloneProfile  
     }  
     else  
     {  
       # 2-Node Cluster profile  
  
       # Start discover the IP address of remote node  
       StartDiscoverRemoteNode  
  
       # Start polling the state of the remote node periodically  
       $global:g_refreshRemoteRebootPendingState='NotStarted'  
       PollRemoteMachineStatus  
  
       # Refresh local settings for 2-Node Cluster profile  
       $global:g_refreshLocalSettingsQueued=$true  
       RefreshLocalSettingsForClusterProfile  
  
       # Keep polling the state of the remote node periodically  
       PollRemoteMachineStatus  
  
       # Try to set up RemoteApp  
       TrySetupRemoteApp  
  
       # Refresh the settings of the remote node  
       $global:g_refreshRemoteSettingsQueued=$true  
       RefreshRemoteMachineSettings  
        }  
     #added for property expression$installState=$true$propExpression=GetWindowsFeatures $installState | ToArray  
    </init>  
  
```  
  
**Controlling message display**  
  
The `<close>` element performs different actions when the ICT window closes. You can control the message that is displayed when the ICT window is closed by editing the **<close>** section of OEMOOBE.xml. Messages display if various conditions are met. If any of the following conditions exist, the appropriate message will display:  
  
1.  A refresh is in progress.  
  
2.  Values mismatch \(for two\-node cluster profile\).  
  
3.  All tasks have not been completed—suppress the ICT window on the next logon.  
  
4.  A reboot is pending on the local computer \(or the remote computer on a two\-node cluster\).  
  
The following sample displays the message **Refresh in progress**. The message text is a Windows PowerShell variable with a string value. For more information, see [Appendix G: OEMOOBE XML schema](assetId:///9f6691dd-d676-4a34-b523-03f7ec19a468#bkmk_appG_NASOOBE_XML_schema).  
  
```  
<close warnRefreshing=”$true”>  
   warnRefreshingMessage=$global:g_stringTable.WarnMessageRefreshing”>  
</close>  
  
```  
  
#### Profile\-based configuration  
The two default profiles that are available for use are the **Configure a standalone NAS** profile and the **Configure a 2\-node cluster** profile. Additional configuration profiles can be created in the OEMOOBE.xml file. For example, you could create a **Configure single\-node cluster** profile. These additional profiles are not supported by Microsoft.  
  
As an example for a single\-node cluster, you could modify the **Configure Networking** task group to display a task to configure local networking only and remove the option to display the **Configure networking for the secondary node** task.  
  
As an example for a two\-node cluster, you could modify **Network Connections** for the first and second nodes, and then display the tasks accordingly. To use task profiles that support both one\-node and two\-node clusters, you could modify the tasks within the `Task Groups` section of the OEMOOBE.xml file based on profile selected.  
  
> [!NOTE]  
> For the two\-node cluster profile, you must specify the same, non\-null, administrator password for both cluster nodes.  
  
The following samples contain commands that can be used to define whether a task group is visible and whether tasks are enabled or disabled. Disabled tasks are gray in the user interface, and they do not function. You may decide to hide disabled tasks if a task is not applicable for a profile.  
  
```  
<profile title="Configure a 2-node cluster"  
        titleResource="ProfileCluster2Node"  
        description="Configures a 2-node cluster."  
        descriptionResource="ProfileCluster2NodeDescription"  
         visible="$global:g_isClusterInstalled"   
         selectCommand="$g_profile='Cluster2Node_Profile'"/>  
  
 <profile title="Configure a 1-node cluster"  
      titleResource="ProfileClusterSingleNode"  
      description="Configures a 1-node cluster."  
      descriptionResource="ProfileCluster1NodeDescription"  
      visible="$global:g_isClusterInstalled"  
     selectCommand="$g_profile='Cluster1Node_Profile'"/>  
  
```  
  
#### Defining tasks by using XML attributes  
The following sample shows how to define tasks that are based on profile selection by using the `visible` and `enabled` XML attributes.  
  
Setting the **Configure Networking** task group `visible` attribute to `"($g_profile -eq 'Cluster2Node_Profile') -or ($g_profile -eq 'Cluster1Node_Profile')”` ensures that the task group is displayed for both one\-node and two\-node profiles.  
  
Setting the **Configure networking for the primary node** task `visible` attribute to true and the `enabled` attribute to `“(!$global:g_disabledAllTasks)”` ensures that the task is displayed for both one\-node and two\-node profiles.  
  
Setting the **Configure networking for the secondary node** task `visible` attribute to `“($g_profile -eq 'Cluster2Node_Profile')”` ensures that the task is displayed for the two\-node profile only.  
  
```  
<taskGroup title="Configure Networking"   
         titleResource="GroupTitleConfigureNetwork"  
         visible="($g_profile -eq 'Cluster2Node_Profile') -or ($g_profile -eq 'Cluster1Node_Profile')"  
         helpCommand="notepad $env:windir\system32\OEMOOBE\Help.txt"   
         collapseByDefault="false">  
  
      <task title="Configure networking for the primary node"   
         titleResource="TaskTitleConfigureNetworkPrimary"  
         image="Images\ConfigureNetworkingTask.ico"  
         visible="$true"   
         enabled="(!$global:g_disabledAllTasks)"   
         command="control ncpa.cpl">  
         <properties expression="$global:g_localNetworkAdapterList" />  
      </task>  
  
      <task title="Configure networking for the secondary node"   
         titleResource="TaskTitleConfigureNetworkSecondary"  
         image="Images\ConfigureNetworkingTask.ico"  
         visible="($g_profile -eq 'Cluster2Node_Profile')"   
         enabled="($g_profile -eq 'Cluster2Node_Profile')"  
         command="mstsc.exe $env:windir\system32\OEMOOBE\ncpa.rdp">  
         <properties expression="$global:g_remoteNetworkAdapterList" />  
      </task>  
```  
  
#### Using RemoteApp and Desktop Connection to configure clusters  
The RemoteApp and Desktop Connection tool can be used to make configuration changes in two\-node failover clusters. For example, RemoteApp and Desktop Connection can be used to open Network Connections \(Ncpa.cpl\) and the Disk Management tool \(Diskmgmt.msc\) to manage a second node from the administrative console on the first node.  
  
> [!NOTE]  
> For more information about RemoteApp and Desktop Connection, see [RemoteApp and Desktop Connection](http://technet.microsoft.com/library/dd560650%28WS.10%29.aspx).  
  
To use RemoteApp and Desktop Connection, you must first create one or more tasks in a task group that is associated with a management feature that is applicable to the second node. In the following sample, first a task was created to open Disk Management on the first node and to use RemoteApp and Desktop Connection to open Disk Management on the second node within the **Provision Failover Cluster Storage** task group.  
  
Next, two new tasks are created. The first task is **Launch Disk Management** for the first node, and it opens Diskmgmt.msc. The second task is **Launch Disk Management for the secondary node**, and it runs the command **mstsc.exe $env:windir\\system32\\OEMOOBE\\diskmgmt.rdp**.  
  
```  
<taskGroup title="Provision Failover Cluster Storage"  
          titleResource="GroupTitleProvisionClusterStorage"  
          visible="($g_profile -eq 'Cluster2Node_Profile')"  
          helpCommand="notepad $env:windir\system32\OEMOOBE\Help.txt"  
          collapseByDefault="false">  
  
<task title="Run Disk Management for the first node"   
         titleResource="TaskTitleProvisionStorage"  
         image="Images\ProvisionStorage.ico"  
         visible="$true"   
         enabled="(!$global:g_disabledAllTasks)"   
         command="diskmgmt.msc" />  
  
 <task title="Run Disk Management for the second node"   
         titleResource="TaskTitleProvisionStorage"  
         image="Images\ProvisionStorage.ico"  
         visible="$true"   
         enabled="(!$global:g_disabledAllTasks)"   
         command="mstsc.exe $env:windir\system32\OEMOOBE\diskmgmt.rdp" />  
</taskGroup>  
  
```  
  
Notice the reference to Diskmgmt.rdp in the second command line of the sample. Diskmgmt.rdp is a text file that defines the parameters for Windows Remote Desktop \(Mstsc.exe\) to open the appropriate applications. The Diskmgmt.rdp file is located in the **%Windir%\\System32\\oemoobe\\** folder. The Diskmgmt.rdp file contains the following code:  
  
```  
session bpp:i:32  
prompt for credentials on client:i:1  
span monitors:i:1  
use multimon:i:1  
remoteapplicationmode:i:1  
server port:i:3389  
allow font smoothing:i:1  
promptcredentialonce:i:1  
authentication level:i:2  
gatewayusagemethod:i:2  
gatewayprofileusagemethod:i:0  
gatewaycredentialssource:i:0  
full address:s: 169.255.12.220 (code acquires IP address dynamically)  
remoteapplicationprogram:s:diskmgmt.msc  
gatewayhostname:s:  
authentication level:i:0  
  
```  
  
> [!IMPORTANT]  
> See the `CreateNetworkConfigRdpFile` function in the Oemoobe.ps1 file for more information about how to dynamically create an RDP session.  
  
## <a name="bkmk_appG_NASOOBE_XML_schema"></a>Appendix D: OEMOOBE XML schema  
The following tables summarize the various elements that are used in the OEMOOBE.xml file.  
  
The `oobe` element is the root element for the OEMOOBE.xml file. It contains one or more section elements, which are displayed in sequence in the UI. OEMOOBE.xml can also contain elements that define scripts to run during user interface initialization, synchronization, and refresh.  
  
The `oobe` element is used only once in the OEMOOBE.xml file.  
  
|||||  
|-|-|-|-|  
|**Attribute name**|**Type**|**Purpose**|**Required Use?**|  
|`Title`|`string`|Value is a static string. The value is for the ICT window title.|Required|  
|`titleResource`|String|Value is a .resx file. Used for the localized ICT window title. When the .resx file is available, the value for `titleResource` overrides value of the `title` attribute.|Required|  
|`Icon`|Image|Path for the ICT window icon. Can be a .gif, .ico, or .jpg file. If the path does not exist, an image placeholder is shown.|Required|  
|`headerText`|string|Value is a static string. The value is for the ICT window header.|Required|  
|`headerTextResource`|string|Value is a .resx file. Used for the localized ICT window header. When the .resx file is available, the value for `headerTextResource` overrides value of the `headerText` attribute.|Required|  
|`headerImage`|image|Path for the header image. Can be a .gif, .ico, or .jpg file. If the path does not exist, an image place holder is shown|Required|  
  
**Profiles element**  
  
There is only one `profiles` element in OEMOOBE.xml.  
  
|||||  
|-|-|-|-|  
|**Attribute name**|**Type**|**Purpose**|**Required Use?**|  
|`Title`|String|Value is a static string. The value is the label that is associated with the `intent` drop\-down list. The title is only shown if two or more intents are visible at same time.|Required|  
|`titleResource`|String|Represents the localized value for `title`. The value is set from a .resx file. If a value exists, it overrides the `title` attribute.|Required|  
|`requireProfileSelection`|Boolean|The default value is `false`. If the value is `true`, the user must select a profile from multiple available profiles prior to using the task groups. If the value is `false`, the system automatically selects the profile as the first visible profile.|Optional|  
  
**Profile element**  
  
There can be one or more `profile` elements in OEMOOBE.xml. Each profile is a child element of the `profiles` element.  
  
|||||  
|-|-|-|-|  
|**Attribute name**|**Type**|**Purpose**|**Required Use?**|  
|`Title`|String|Value is a static string. The value indicates the intent title. This is only shown if two or more intents are visible at same time|Required|  
|`titleResource`|String|Represents the localized value for `title`. The value is set from a .resx file. If a value exists, it overrides the `title` attribute value.|Required|  
|`description`|String|Value is a static string. The value indicates a brief description for the intent. This is only shown if two or more intents are visible at same time.|Optional|  
|`descriptionResource`|String|Represents the localized value for `description`. The value is set from a .resx file. If a value exists, it overrides the `description` attribute value.|Optional|  
|`visible`|Windows PowerShell Boolean \($true\/$false\)|Used to show or hide intent. It can be set directly as `$true` or `$false`. Also, a Windows PowerShell expression that returns `$true` or `$false` can be used as the value for this attribute.|Optional|  
|`selectCommand`|Windows PowerShell expression|Indicates the value that is set for a Windows PowerShell variable after the intent is selected. Then the Windows PowerShell variable can be used to show or hide other sections in the ICT window.|Required|  
  
**TaskGroup element**  
  
There can be one or more `TaskGroup` elements in OEMOOBE.xml.  
  
|||||  
|-|-|-|-|  
|**Attribute name**|**Type**|**Purpose**|**Required Use?**|  
|`title`|String|Value is a static string. It represents the `taskgroup` title.|Required|  
|`titleResource`|String|Represents the localized value for `title`. The value is set from a .resx file. If a value exists, it overrides the `title` attribute value.|Required|  
|`visible`|Windows PowerShell Boolean value|It can be set directly as `$true` or `$false`. Also, a Windows PowerShell expression that returns `$true` or `$false` can be used as the value for this attribute.|Optional|  
|`helpCommand`|String|The string is a command. The command runs when a user clicks the task. Usually, it is used to run an executable file or to perform an action.|Optional|  
|`collapseByDefault`|True\/False|A .NET Boolean flag. If set as `true`, the `taskgroup` is collapsed when the ICT window opens. If `false`, the task group is shown expanded.|Optional|  
  
**Task element**  
  
There can be one or more `task` elements in OEMOOBE.xml. Each task is a child element of a `TaskGroup` element.  
  
|||||  
|-|-|-|-|  
|**Attribute name**|**Type**|**Purpose**|**Required Use?**|  
|`title`|String|Value is a static string. Represents the task title.|Required|  
|`titleResource`|String|Represents the localized value for `title`. The value is set from a .resx file. If a value exists, it overrides the `title` attribute value.|Required|  
|`image`|Image|A .gif, .ico, or .jpg file path, which is shown as the image for the task. If a path does not exist, an image place holder is shown.|Required|  
|`visible`|Windows PowerShell Boolean value|It can be set directly as `$true` or `$false`. Also, a Windows PowerShell expression that returns `$true` or `$false` can be used as the value for this attribute. This controls the visibility of a task.|Optional|  
|`enabled`|Windows PowerShell Boolean value|It can be set directly as `$true` or `$false`. Also, a Windows PowerShell expression that returns `$true` or `$false` can be used as the value for this attribute. This value controls the enable or disable state of the task. If a task is disabled, users cannot click it.|Optional|  
|`command`|String|Clicking the task runs the command. This can be used to run an .exe or .msc file, or a Windows PowerShell script.|Required|  
  
**Properties element**  
  
There can be one or more `properties` elements in OEMOOBE.xml. Each `properties` element is a child element of a `task` element.  
  
**Property element**  
  
There can be one or more `property` elements in OEMOOBE.xml. Each `property` is a child element of the `properties` elements, and it represents data in `name-value` format. The property title is static and the property value is set by using a Windows PowerShell expression.  
  
|||||  
|-|-|-|-|  
|**Attribute name**|**Type**|**Purpose**|**Required Use?**|  
|`title`|String|Value is a static string. Represents the `taskproperty` title.|Required|  
|`titleResource`|String|Represents the localized value for `title`. The value is set from a .resx file. If a value exists, it overrides the `title` attribute value.|Required|  
|`visible`|Windows PowerShell Boolean value|It can be set directly as `$true` or `$false`. Also, a Windows PowerShell expression that returns `$true` or `$false` can be used as the value for this attribute.|Optional|  
|`value`|Windows PowerShell expression|The Windows PowerShell expression is a single value.|Optional|  
  
**Property expression**  
  
The property expression is used when there two or more value pairs for a `property` element, and the property expression represents a name\-value pair. The property title and value elements are generated dynamically by using a Windows PowerShell array, a hash table, or a list.  
  
|||||  
|-|-|-|-|  
|**Attribute name**|**Type**|**Purpose**|**Required Use?**|  
|`expression`|Windows PowerShell expression|The value is a Windows PowerShell expression that represents data in `name-value` format. There can be only one expression associated with a task. Each entry in a Windows PowerShell array represents one property in the ICT window. The entry consists of a `property title` and a `property value`.|Optional|  
  
**wgaProperty element**  
  
The `wgaProperty` element is used to display the Windows Genuine Advantage icon and is a child element of the `properties` element.  
  
|||||  
|-|-|-|-|  
|**Attribute name**|**Type**|**Purpose**|**Required Use?**|  
|`visible`|Windows PowerShell Boolean|Used to show or hide the genuine Windows copy icon. The value can be `$true` or `$false`. Or it can be a Windows PowerShell expression that returns `$true` or `$false`.|Optional|  
  
**Message element**  
  
The `message` element is a child element of the `task` element. There is one `message` element per `task` element.  
  
|||||  
|-|-|-|-|  
|**Attribute name**|**Type**|**Purpose**|**Required Use?**|  
|`text`|String|Static value for message text.|Optional|  
|`textResource`|String|Used for localized display of message text. The value is set from a .resx file. If the `titleResource` value set, it overrides the `title` attribute value.|Optional|  
|`severity`|Info<br />Warning<br />Error|Used to show the severity alert icon for a message.|Optional|  
|`visible`|Windows PowerShell Boolean expression|Can be set directly as `$true` or `$false`. Also, it can be a Windows PowerShell expression that returns `$true` or `$false`.|Optional|  
|`severityExpression`|Windows PowerShell expression that returns one of the following values: <br />Error<br />Warning<br />Info|Used to set the severity alert icon for the message. If set, it overrides the `severity` attribute value.|Optional|  
|`textExpression`|Windows PowerShell Boolean expression \(String\)|A string that is returned by using a Windows PowerShell expression. If `textExpression` is set, it overrides the `text` value. Because this is a Windows PowerShell expression, the text can be changed dynamically in the ICT window.|Optional|  
  
**Status Bar Element**  
  
The status bar element displays in the Windows status bar area.  
  
|||||  
|-|-|-|-|  
|**Attribute name**|**Type**|**Purpose**|**Required Use?**|  
|`refreshing`|Windows PowerShell Boolean value|Can be set directly as `$true` or `$false`. Also, it can be a Windows PowerShell expression that returns `$true` or `$false`. This is set to true when a refresh is in progress.|Optional|  
|`rebootPending`|Windows PowerShell Boolean value|Can be set directly as `$true` or `$false`. Also, it can be a Windows PowerShell expression that returns `$true` or `$false`. This is set to true when a reboot is pending.|Optional|  
  
**Close element**  
  
The close element implements actions when a user closes the ICT window.  
  
|||||  
|-|-|-|-|  
|**Attribute name**|**Type**|**Purpose**|**Required Use?**|  
|`warnRefreshing`|Windows PowerShell Boolean value|Can be set directly as `$true` or `$false`. Also, it can be a Windows PowerShell expression that returns `$true` or `$false`. When this is set to **true**, the `refresh in progress` message is shown.|Optional|  
|`warnRefreshingMessage`|Windows PowerShell expression \(String\)|A message shown for refresh in progress.|Optional|  
|`warnBadState`|Windows PowerShell Boolean value|Can be set directly as `$true` or `$false`. Also, it can be a Windows PowerShell expression that returns `$true` or `$false`. When this is set to **true**, the `mismatch value` message is shown.|Optional|  
|`warnBadStateMessage`|Windows PowerShell expression \(String\)|A message shown for values that do not match \(for the two\-node cluster scenario\).|Optional|  
|`warnTasksNotDone`|Windows PowerShell Boolean value|Can be set directly as `$true` or `$false`. Also, it can be a Windows PowerShell expression that returns `$true` or `$false`. When set to **true**, a message is shown to the end user at the next logon to confirm suppression of the ICT window.|Optional|  
|`warnTasksNotDoneMessage`|Windows PowerShell expression \(String\)|A message is shown to the end user at the next logon to confirm the suppression of the ICT window.|Optional|  
|`rebootPendingMessage`|Windows PowerShell expression \(String\)|A message is shown when a reboot is pending on the local computer \(or the second node of a two\-node cluster\).|Optional|  
  
## <a name="bkmk_apph_nasoobe_files"></a>Appendix E: OEMOOBE framework files  
As part of the installation of Windows Storage Server 2012, the following folders and files are installed to the *%Windir%***\\System32\\OEMOOBE** directory:  
  
-   CreatePool.exe: The Create Storage Pool wizard.  
  
-   CreateVirtualDisk.exe: The Create Virtual Disks and Volumes wizard.  
  
-   de\-DE: This folder contains localized .dll and .psd1 files for the German language.  
  
-   en\-US: This folder contains .dll and .psd1 files for the English language \(the default installation language\).  
  
-   es\-ES: This folder contains localized .dll and .psd1 files for the Spanish language.  
  
-   fr\-FR: This folder contains localized .dll and .psd1 files for the French language.  
  
-   hu\-HU: This folder contains localized .dll and .psd1 files for the Hungarian language.  
  
-   Images: This folder contains the images that are displayed in the ICT window. OEMs can replace these images with their own customized versions, or add additional images for tasks or task groups that are added to the ICT window.  
  
-   it\-IT: This folder contains localized .dll and .psd1 files for the Italian language.  
  
-   ja\-JP: This folder contains localized .dll and .psd1 files for the Japanese language.  
  
-   ko\-KR: This folder contains localized .dll and .psd1 files for the Korean language.  
  
-   Microsoft.Windows.Oem.Oobe.Common.dll: This file includes functionality that is used by the storage\-specific ICT window \(for example, getting the status of the second node of a cluster, reviewing computer name details, or node discovery\).  
  
-   Microsoft.Windows.Server.PS.Commands.dll: This file is used when the automatic discovery process runs.  
  
-   msoobe\_oem.exe: This file invokes Windows Welcome \(which runs immediately after an end user turns on the appliance\). It also initiates the automatic network discovery process \(used if the appliance is a node in a cluster\).  
  
-   msoobe\_oem.exe.config: This file enables the display of assertions or the collection of tracing data when the msoobe\_oem.exe runs. By default, tracing data is stored in the msoobe\_oem.txt file. However, if you edit the msoobe.exe.config file, you can enable the tracing data to be written to a different file. In that case, you can delete msoobe\_oem.txt file.  
  
-   msoobe\_oem.resources.dll: This file contains cultural\-specific information. In each language folder \(for example, the fr folder\), there is a localized version of this file.  
  
-   Nic.config: This file controls the process of uniformly naming the network adapters that are present in a storage appliance. OEMs can edit this file to customize how network adapter ports are named.  
  
-   NicConfig.ps1: This Windows PowerShell script controls the assignment of unique names to all of the network adapter ports in a storage appliance.  
  
-   nl\-NL: This folder contains localized .dll and .psd1 files for the Dutch language.  
  
-   OEMOOBE. de\-DE.resx: This file contains German language strings that are displayed in the ICT window.  
  
-   OEMOOBE.en\-US.resx: This file contains English language strings that are displayed in the ICT window.  
  
-   OEMOOBE.es\-ES.resx: This file contains Spanish language strings that are displayed in the ICT window.  
  
-   OEMOobe.exe: This file is the Windows Storage Server 2012 version of the ICT window.  
  
-   OEMOobe.exe.config: This file enables assertions or the collection of tracing data recorded by ICT processes. By default, tracing data is stored in the Oemoobe.txt file. However, if you edit the OemOobe.exe.config file, you can enable the tracing data to be written to a different file. In that case, you can delete the Oemoobe.txt file.  
  
-   OEMOOBE.fr\-FR.resx: This file contains French language strings that are displayed in the ICT window.  
  
-   OEMOOBE.it\-IT.resx: This file contains Italian language strings that are displayed in the ICT window.  
  
-   OEMOOBE.ja\-JP.resx: This file contains Japanese language strings that are displayed in the ICT window.  
  
-   OEMOOBE.ko\-KR.resx: This file contains Korean language strings that are displayed in the ICT window.  
  
-   OEMOOBE.ps1: This Windows PowerShell script launches the storage\-specific ICT window.  
  
-   OEMOOBE.psd1: This is a Windows PowerShell data file. This file stores strings used by the OEMOOBE.ps1 file. In each language folder \(for example, the fr\-FR folder\), there is a localized version of this file.  
  
-   OEMOOBE.pt\-BR.resx: This file contains Portuguese \(Brazil\) language strings that are displayed in the ICT window.  
  
-   OemOobe.resources.dll: This file contains cultural\-specific information. In each language folder \(for example, the fr\-FR folder\), there is a localized version of this file.  
  
-   OEMOOBE.resx: This resource file contains the text strings that are presented to the user within the ICT window. To support localization of the storage\-specific ICT window, there are language\-specific are versions of this file for each supported language.  
  
-   OEMOOBE.ru\-RU.resx: This file contains Russian language strings that are displayed in the ICT window.  
  
-   OEMOOBE.xml: This file controls the appearance \(the icons or text that is displayed within the ICT window\). It also controls which task groups or individual tasks are presented to the end user as part of the configuration of their storage appliance.  
  
-   OEMOOBE.zh\-CN.resx: This file contains Chinese \(Simplified\) language strings that are displayed in the ICT window.  
  
-   OEMOOBE.zh\-HK.resx: This file contains Chinese \(Hong S.A.R.\) language strings that are displayed in the ICT window.  
  
-   OEMOOBE.zh\-TW.resx: This file contains Chinese \(Traditional\) language strings that are displayed in the ICT window.  
  
-   oobediscoveryservice.exe: This file contains the functionality that is used to identify the second node of a cluster. It runs during the automatic network discovery process.  
  
-   oobediscoveryservice.exe.config: This file enables assertions or the collection of tracing data that is recorded by the Cluster Name and Domain Join Wizard. By default, this tracing data is stored in the oobediscoveryservice.txt file. However, if you edit the oobediscoveryservice.exe.config file, you can enable the tracing data to be written to a different file. In that case, you can delete the oobediscoveryservice file  
  
-   pl\-PL: his folder contains localized .dll and .psd1 files for the Polish language.  
  
-   PostDiscovery.ps1: This Windows PowerShell script enables all the network adapter ports in a storage appliance. Enabling all the ports is necessary so that the ports can be uniformly named and these names can be displayed to an end user in the storage\-specific ICT window.  
  
-   PreDiscovery.ps1: This Windows PowerShell script disables all the network adapter ports in a storage appliance. Disabling all the ports is necessary so that the ports can be uniformly named and these names can be displayed to an end user in the storage\-specific ICT window.  
  
-   PrepareCluster.exe: This file launches the Cluster Name and Domain Join Wizard, which enables the end user to input their domain information, set a domain user name and password, and set the cluster and node names.  
  
-   PrepareCluster.exe.config: This file enables assertions or the collection of tracing data that is recorded by the Cluster Name and Domain Join Wizard. By default, this tracing data is stored in the PrepareCluster.txt file. However, if you edit the PrepareCluster.exe.config file, you can enable the tracing data to be written to a different file. In that case, you can delete the PrepareCluster.txt file.  
  
-   PrepareCluster.resources.dll: This file contains cultural\-specific information that is used by the Cluster Name and Domain Join Wizard. In each language folder \(for example, the fr folder\), there is a localized version of this file.  
  
-   PrepareCluster.txt: This file contains Cluster Name and Domain Join Wizard tracing data.  
  
-   ProvisionVolume.exe: The Create Volumes wizard.  
  
-   RenameNetworkConnection.ps1: This Windows PowerShell script renames all the network adapter ports in a storage appliance. This script uses the contents of the Nic.config file to set the names of individual network adapter ports.  
  
-   pt\-BR: This folder contains localized .dll and .psd1 files for the Portuguese \(Brazil\) language.  
  
-   pt\-PT: This folder contains localized .dll and .psd1 files for the Portugese \(Portugal\) language.  
  
-   Ru\-Ru: This folder contains localized .dll and .psd1 files for the Russian language.  
  
-   SetupCluster.exe: This file invokes the Cluster Validation and Setup Wizard.  
  
-   SetupCluster.exe.config: This file enables the recording of tracing data collected when the Cluster Validation and Setup Wizard runs. By default, tracing data is stored in the SetupCluster.txt file. However, if you edit the SetupCluster.exe.config file, you can enable tracing data to be written to a different file. In that case, you can delete the SetupCluster.txt file.  
  
-   SetupCluster.resources.dll: This file contains cultural\-specific information. In each language folder \(for example, the fr\-FR folder\), there is a localized version of this file.  
  
-   SetupCluster.txt: This file contains Cluster Validation and Setup Wizard tracing data.  
  
-   ServerCeipOptinDlg.exe: The Windows Customer Experience Improvement Program application.  
  
-   ServerCeipOptinDlg.exe.config: This file contains configuration settings for the Windows Customer Experience Improvement Program.  
  
-   ServerWerOptinDlg.exe: The Windows Error Reporting application.  
  
-   ServerWerOptinDlg.exe.config: This file contains configuration settings for Windows Error Reporting.  
  
-   sv\-SE: This folder contains localized .dll and .psd1 files for the Swedish language.  
  
-   tr\-TR: This folder contains localized .dll and .psd1 files for the Turkish language.  
  
-   zh\-CN: This folder contains localized .dll and .psd1 files for the Chinese \(Simplified\) language.  
  
-   zh\-HK: This folder contains localized .dll and .psd1 files for the Chinese Hong Kong S.A.R. language.  
  
-   zh\-TW: This folder contains localized .dll and .psd1 files for the Chinese \(Traditional\) language.  
  
