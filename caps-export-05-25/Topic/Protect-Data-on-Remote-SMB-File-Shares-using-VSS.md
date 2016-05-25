---
title: Protect Data on Remote SMB File Shares using VSS
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4352bfaf-2a72-4177-bff4-1c6d9a9d5572
author: JasonGerend
---
# Protect Data on Remote SMB File Shares using VSS
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], a new feature is introduced called VSS for SMB File Shares, which allows VSS\-aware backup applications to create a volume shadow copy of VSS\-aware server applications that store data on remote SMB 3.0 file shares. This guide provides information on how to perform backups of server applications using this feature, and therefore, protect your data.  
  
**In this document**  
  
-   [VSS for SMB File Shares: overview](../Topic/Protect-Data-on-Remote-SMB-File-Shares-using-VSS.md#BKMK_overview)  
  
-   [Requirements and supported configurations](../Topic/Protect-Data-on-Remote-SMB-File-Shares-using-VSS.md#BKMK_reqs)  
  
-   [Deployment scenarios](../Topic/Protect-Data-on-Remote-SMB-File-Shares-using-VSS.md#BKMK_deploy)  
  
-   [Step 1: Install File Server VSS Agent Service](../Topic/Protect-Data-on-Remote-SMB-File-Shares-using-VSS.md#BKMK_Step1)  
  
-   [Step 2: Add a user to the Backup Operators local group on the file server](../Topic/Protect-Data-on-Remote-SMB-File-Shares-using-VSS.md#BKMK_Step2)  
  
-   [Step 3: Perform a shadow copy](../Topic/Protect-Data-on-Remote-SMB-File-Shares-using-VSS.md#BKMK_shadowcopy)  
  
> [!NOTE]  
> [!INCLUDE[wps_howtorun](../Token/wps_howtorun_md.md)]  
  
## <a name="BKMK_overview"></a>VSS for SMB File Shares: overview  
VSS for SMB File Shares is an extension to the existing VSS infrastructure and consists of four parts:  
  
-   **File Share Shadow Copy Provider \(fssprov.dll\)**. This is a new VSS provider on the server running the VSS\-aware application. It manages shadow copies on remote Universal Naming Convention \(UNC\) paths where the application stores its data files, and then relays the shadow copy request to the File Share Shadow Copy Agents. Enhancements to the VSS infrastructure to support the File Share Shadow Copy Provider include updates to the API.  
  
-   **File Share Shadow Copy Agent \(fssagent.dll\)**. This is a new VSS requester on the file server hosting the SMB 3.0 file shares \(using an UNC path\) that store the application’s data files. It manages mappings between file shares and volumes, and also interacts with the file server’s VSS infrastructure to perform shadow copies of the volumes that backup the SMB 3.0 file shares \(where the VSS\-aware applications stores their data\).  
  
-   **File Server Remote VSS Protocol \(MSFSRVP\)**. The File Share Shadow Copy Provider and the File Share Shadow Copy Agent use this new RPC\-based protocol to coordinate shadow copy requests of data stored on SMB file shares.  
  
## <a name="BKMK_reqs"></a>Requirements and supported configurations  
The requirements for using VSS for SMB File Shares are listed below.  
  
-   The application server and file server must be running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   The application server and file server must be joined to the same Active Directory domain.  
  
-   The File Server VSS Agent Service role service must be installed on the file server.  
  
-   The File Share Shadow Copy agent must run in a security environment that has backup operators or administrator privileges on both the application server and file server.  
  
-   The File Share Shadow Copy agent and the application must run in a security environment that has no less than read\-only permission on the file share data that will be backed up.  
  
> [!NOTE]  
> VSS for SMB File Shares also works with third\-party Network Attached Storage \(NAS\) appliances or other similar solutions. These appliances or solutions must support SMB 3.0 and File Server Remote VSS Protocols.  
  
VSS for SMB File Shares supports the following configurations:  
  
-   An application server configured as a single server or in a failover cluster.  
  
-   A file server configured as a single server or in a failover cluster with continuously available or scale\-out file shares.  
  
-   File shares with a single DFS Namespaces link target.  
  
VSS for SMB File Shares has the following limitations:  
  
-   Unsupported VSS capabilities, such as: hardware transferrable shadow copies, writable shadow copies, VSS fast recovery where a volume can quickly revert to a shadow copy, and client\-accessible shadow copies \(Shadow Copy of Shared Folders\).  
  
-   Loopback configurations where an application server accesses its data on SMB file shares that are hosted on the same application server.  
  
-   Shadow copies of Hyper\-V virtual machines, where the application for which the virtual machine stores its data on SMB file shares is not supported.  
  
-   Data on mounted drives that are below the root of the file share are not included in the shadow copy.  
  
-   Shadow copies of file shares that do not support failover clustering.  
  
## <a name="BKMK_deploy"></a>Deployment scenarios  
VSS for SMB File Shares is most commonly deployed with Hyper\-V, where a server running Hyper\-V stores the virtual machine files on remote SMB file share. Some example deployments are described below.  
  
**Single server running Hyper\-V and single file server**  
  
In this scenario, there is a single, non\-clustered server running Hyper\-V and a single, non\-clustered file server. As shown in the diagram below, the file server has two volumes attached to it, with a file share on each volume. The virtual machine files for `VM A` are stored on `\\fileserv\share1`, which is backed by `Volume 1`. For `VM B`, some of the virtual machine files are stored on `\\fileserv\share1`, and some are stored on `\\fileserv\share2`, which is backed by `Volume 2`. The virtual machine files for `VM C` are stored on `\\fileserv\share2`.  
  
![](../Image/SingleHyper-Vserverandsinglefileserver.gif)  
  
When a backup operator performs a shadow copy of `VM A`, the Hyper\-V VSS writer adds `\\fileserv\share1` to the shadow copy set. When ready, the File Share Shadow Copy Provider sends the shadow copy request to `\\fileserv`. On the file server, the File Share Shadow Copy Agent invokes the local VSS service to perform a shadow copy of `Volume 1`. `Volume 2` is not part of the shadow copy set since only `\\fileserv\share1` was reported by the VSS writer. When the shadow copy sequence is complete, a shadow copy share `\\fileserv\share1@{GUID}` is available for the backup application to move the backup data. When the backup is complete, the backup application releases the shadow copy set, and the associated shadow copies and shadow copy shares are removed.  
  
If the backup operator performs a shadow copy of `VM B`, the Hyper\-V VSS writer reports both `\\fileserv\share1` and `\\fileserv\share2` in the shadow copy set. On the file server, this results in a shadow copy of both `Volume 1` and `Volume 2`, and two shadow copy shares `\\fileserv\share1@{GUID}` and `\\fileserv\share2@{GUID}` are created.  
  
If the backup operator performs a shadow copy of `VM A` and `VM B`, the Hyper\-V VSS writer reports both `\\fileserv\share1` and `\\fileserv\share2` in the shadow copy set. On the file server, a shadow copy of both volumes is generated and two shadow copy shares are created.  
  
**Two servers running Hyper\-V and a file server cluster**  
  
In this scenario, there are two servers running Hyper\-V and a file server cluster. As shown in the diagram below, the file server cluster has two cluster nodes, `node1` and `node2`. The file server cluster, `\\fs1`, is currently online on `node1`, with a single share, `\\fs1\share`, on `Volume 1`. To use both cluster nodes, a second file server cluster, `\\fs2`, is configured and is currently online on `node2`, with a single share, `\\fs2\share`, on `Volume 2`.  
  
![](../Image/TwoHyper-Vserversandafileservercluster.gif)  
  
When the backup operator performs a shadow copy of `VM A`, the Hyper\-V VSS writer reports `\\fs1\share` in the shadow copy set. When ready, the File Share Shadow Copy Provider sends a shadow copy request to `\\fs1`. As part of the exchange between the File Share Shadow Copy Provider and the File Share Shadow Copy Agent, the agent notifies the provider of the physical computer name, `node1`, which is actually performing the shadow copy.  
  
On `node1`, the File Share Shadow Copy Agent calls the local VSS service to perform a shadow copy of the volume that backs the file share. When the shadow copy sequence is complete, a shadow copy share `\\node1\share@{GUID}` is available for the backup application to stream the backup data. Note the shadow copy share, `\\node1\share@{GUID}`, is targeted to the cluster node, `node1`, and not the virtual computer name, `\\fs1`.  
  
Once the backup is complete, the backup application releases the shadow copy set and the associated shadow copies and shadow copy shares are removed. If the file server cluster moves to, or fails over to, `node2` before the backup sequence is complete, the shadow copy share and the shadow copy become invalid. If the file server cluster moves back to `node1`, the shadow copy and the corresponding shadow copy share will become valid again.  
  
## <a name="BKMK_Step1"></a>Step 1: Install File Server VSS Agent Service  
Use one of the following procedures to install File Server VSS Agent Service.  
  
#### To install File Server VSS Agent Service using Server Manager  
  
1.  From the Add Roles and Features Wizard, under Server Roles, select **File and Storage Services** if it has not already been installed.  
  
2.  Under **File and iSCSI Services**, select **File Server** and **File Server VSS Agent Service**.  
  
3.  On the **Select Features** page, click **Next**.  
  
4.  On the **Confirmation** page, verify that **File Server** and **File Server VSS Agent Service** are listed, and then click **Install**.  
  
*The next part of Step 1 is where you include the Windows PowerShell equivalent to the GUI procedure. Delete this part if there is no PowerShell equivalent.*  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
*Provide the Windows PowerShell code for the procedure. For example:*  
  
```  
PS C:\> Import-Module ServerManager  
PS C:\> Add-WindowsFeature -name File-Services,FS-VSS-Agent  
  
```  
  
## <a name="BKMK_Step2"></a>Step 2: Add a user to the Backup Operators local group on the file server  
The user who is performing the shadow copy must have the backup administrative privileges on the remote file servers that are included in the shadow copy set. Usually, this is accomplished by adding the user to the Backup Operators group on the file servers. Use one of the following procedures to do this.  
  
#### To add a user to the Backup Operators local group on the file server using Server Manager  
  
1.  From the dashboard in Server Manager, click **Tools**, and then click **Computer Management**.  
  
2.  In Computer Management, expand **Local Users and Groups**, and then expand **Groups**.  
  
3.  Double\-click **Backup Operators**.  
  
4.  On the **Backup Operators Properties** page, click **Add**.  
  
5.  Type of the name of the user you want to add to the Backup Operators group, and click **OK**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
In the example below, modify the user account and the name of the file server to apply to your environment.  
  
```  
$objUser = [ADSI](-WinNT-//domain/user-)  
$objGroup = [ADSI](-WinNT-//fileserv/Backup-Operators-)  
$objGroup.PSBase.Invoke("Add",$objUser.PSBase.Path)  
```  
  
## <a name="BKMK_shadowcopy"></a>Step 3: Perform a shadow copy  
You must have a VSS\-aware backup application that supports VSS for SMB File Shares to perform a shadow copy of an application’s data that is stored on a remote file share.  
  
> [!NOTE]  
> Windows Server Backup in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] does not support VSS for SMB File Shares.  
  
This section contains examples of performing a shadow copy of a virtual machine that has its data files stored on an SMB file share using DiskShadow.exe \(a tool that exposes the functionality offered by VSS\), and Microsoft System Center Data Protection Manager 2012 Service Pack 1. For information on how to backup and protect data using Microsoft System Center Data Protection Manager 2012 SP1, see [Managing Hyper\-V computers](http://technet.microsoft.com/library/hh757970).  
  
**To perform a shadow copy of virtual machine on the Hyper\-V host \(HV1\) using DiskShadow**  
  
1.  Start Windows PowerShell. Right\-click the PowerShell icon on the taskbar, and select **Run as Administrator**.  
  
    Run the following Windows PowerShell command:  
  
    ```  
    PS C:\Users\administrator> DISKSHADOW  
    ```  
  
2.  Type the following:  
  
    ```  
  
    DISKSHADOW> Writer Verify {66841cd4-6ded-4f4b-8f17-fd23f8ddc3de}  
    DISKSHADOW> Set Context Persistent  
    DISKSHADOW> Set MetaData vm1backup.cab  
    DISKSHADOW> Begin Backup  
    DISKSHADOW> Add Volume \\smbsofs\vm\vm1  
    DISKSHADOW> Create  
  
    ```  
  
    The following output appears:  
  
    ```  
    Alias VSS_SHADOW_1 for shadow ID {7b53b887-76e5-4db8-821d-6828e4cbe044} set as environment variable.  
    Alias VSS_SHADOW_SET for shadow set ID {2bef895d-5d3f-4799-8368-f4bfc684e95b} set as environment variable.  
    Querying all shadow copies with the shadow copy set ID {2bef895d-5d3f-4799-8368-f4bfc684e95b}  
    * Shadow copy ID = {7b53b887-76e5-4db8-821d-6828e4cbe044} %VSS_SHADOW_1%  
    - Shadow copy set: {2bef895d-5d3f-4799-8368-f4bfc684e95b} %VSS_SHADOW_SET%  
    - Original count of shadow copies = 1  
    - Original volume name: \\SMBSOFS\VM\ [volume not on this machine]  
    - Creation time: 5/30/2012 5:35:52 PM  
    - Shadow copy device name: \\FSF-260403-09\VM@{F1C5E17A-4168-4611-9CD4-8366F9F935C3}  
    - Originating machine: FSF-260403-09  
    - Service machine: CONTOSO.SMBTEST.stbtest.microsoft.com  
    - Not exposed  
    - Provider ID: {89300202-3cec-4981-9171-19f59559e0f2}  
    - Attributes: No_Auto_Release Persistent FileShare  
    Number of shadow copies listed: 1  
    ```  
  
    Type the following to end the backup operation:  
  
    ```  
    DISKSHADOW> End Backup  
  
    ```  
  
In this example, the following command parameters are used:  
  
**Writer Verify**. This parameter specifies that the backup or restore operation must fail if the writer or the component is not included. For more information, see [Invoking diskshadow to back up a Virtual Machine from a Hyper\-V Host](http://blogs.technet.com/b/m2/archive/2008/04/17/invoking-diskshadow-to-back-up-a-virtual-machine-from-a-hyper-v-host.aspx).  
  
**Set Context Persistent**. This parameter sets the shadow copy to be persistent, which means that the user or the application controls when to delete the shadow copy.  
  
**Set MetaData**. This parameter stores the metadata information for the shadow copy \(which is needed for restore\) in the specified file.  
  
**Add Volume**. This parameter adds the UNC path to the shadow copy set. You can specify multiple paths by repeating the Add Volume parameter.  
  
**Create**. This parameter initiates the shadow copy. When the shadow copy is created, DiskShadow generates the properties of the shadow copy. The shadow Copy device name is the path for the shadow copy data, which can be copied to the backup store using XCOPY or other tools.  
  
> [!NOTE]  
> During the backup session, you can see the virtual machine status reporting **Backing up..** in Hyper\-V Manager. The backup session starts with the Create parameter, and then ends with the End Backup command in the DiskShadow sequence above.  
  
**To copy the backup data to an alternate location**  
  
After the shadow copy is complete, you can view the shadow copy share \(which is the shadow copy device name from above\), and then copy the data you want to back up to an alternate location.  
  
1.  Start Windows PowerShell. Right\-click the PowerShell icon on the taskbar, and select **Run as Administrator**.  
  
    Run the following Windows PowerShell command:  
  
    ```  
    PS C:\Users\administrator> Get-ChildItem -Recurse -Path "\\FSF-260403-09\VM@{F1C5E17A-4168-4611-9CD4-8366F9F935C3}"  
    Directory: \\FSF-260403-09\VM@{F1C5E17A-4168-4611-9CD4-8366F9F935C3}  
    Mode LastWriteTime Length Name  
    ---- ------------- ------ ----  
    d---- vm1  
    Directory: \\FSF-260403-09\VM@{F1C5E17A-4168-4611-9CD4-8366F9F935C3}\vm1  
    Mode LastWriteTime Length Name  
    ---- ------------- ------ ----  
    d---- vm1  
    -a--- vm1.vhd  
    Directory: \\FSF-260403-09\VM@{F1C5E17A-4168-4611-9CD4-8366F9F935C3}\vm1\vm1  
    Mode LastWriteTime Length Name  
    ---- ------------- ------ ----  
    d---- Virtual Machines  
    Directory: \\FSF-260403-09\VM@{F1C5E17A-4168-4611-9CD4-8366F9F935C3}\vm1\vm1\Virtual Machines  
    Mode LastWriteTime Length Name  
    ---- ------------- ------ ----  
    d---- 87B27972-46C2-406B-87A4-C3FFA1FB6822  
    -a--- 28800 87B27972-46C2-406B-87A4-C3FFA1FB6822.xml  
    Directory: \\FSF-260403-09\VM@{F1C5E17A-4168-4611-9CD4-8366F9F935C3}\vm1\vm1\Virtual  
    Machines\87B27972-46C2-406B-87A4-C3FFA1FB6822  
    Mode LastWriteTime Length Name  
    ---- ------------- ------ ----  
    -a--- 2147602688 87B27972-46C2-406B-87A4-C3FFA1FB6822.bin  
    -a--- 20971520 87B27972-46C2-406B-87A4-C3FFA1FB6822.vsv  
  
    ```  
  
**To delete the shadow copy**  
  
When the backup data is copied, you can delete the shadow copy.  
  
1.  Start Windows PowerShell. Right\-click the PowerShell icon on the taskbar, and select **Run as Administrator**.  
  
    Run the following Windows PowerShell command:  
  
    ```  
    PS C:\Users\administrator> DISKSHADOW  
    ```  
  
2.  Type the following:  
  
    ```  
    DISKSHADOW> Delete Shadows Volume \\smbsofs\vm  
    Deleting shadow copy {7b53b887-76e5-4db8-821d-6828e4cbe044} on volume \\SMBSOFS\VM\ from provider {89300202-3cec-4981-91  
    71-19f59559e0f2} [Attributes: 0x04400009]...  
    Number of shadow copies deleted: 1  
  
    ```  
  
**To restore data from a shadow copy**  
  
-   Start Windows PowerShell. Right\-click the PowerShell icon on the taskbar, and select **Run as Administrator**.  
  
    Run the following Windows PowerShell command:  
  
    ```  
    PS C:\Users\administrator> DISKSHADOW  
    DISKSHADOW> Set Context Persistent  
    DISKSHADOW> Load MetaData vm1backup.cab  
    DISKSHADOW> Begin Restore  
    DISKSHADOW> //xcopy files from backup store to the original location  
    DISKSHADOW> End Restore  
    ```  
  
The Load MetaData parameter loads the metadata information for the shadow copy to restore data from the specified file. After running the Begin Restore parameter, you can copy the virtual machine files from the backup store to the original location \(\\\\smbsofs\\vm\\vm1\). For more information, see this [Microsoft TechNet](http://blogs.technet.com/b/enterprise_admin/archive/2009/11/20/diskshadow-xcopy-restore-of-hyper-v.aspx) blog.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [File and Storage Services Overview](../Topic/File-and-Storage-Services-Overview.md)  
  
-   [Server Message Block Overview](../Topic/Server-Message-Block-Overview.md)  
  
