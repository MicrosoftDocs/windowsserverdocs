---
title: iSCSI Target Block Storage, How To
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1a92bcd5-d122-482d-b6aa-dd2cedf19a4e
---
# iSCSI Target Block Storage, How To
With iSCSI Target Server, any computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] can become a storage device.  
  
-   [Prerequisites](assetId:///4a96cdaf-0081-4824-aab8-f0d51be501ac#BKMK_Prereqs)  
  
-   [Step 1: Install iSCSI Target Server and failover clustering](../Topic/iSCSI-Target-Block-Storage,-How-To.md#BKMK_Step1)  
  
-   [Step 2: Configure the iSCSI initiator](../Topic/iSCSI-Target-Block-Storage,-How-To.md#BKMK_Step2)  
  
-   [Step 3: Create the high availability iSCSI Target Server role service](../Topic/iSCSI-Target-Block-Storage,-How-To.md#BKMK_Step3)  
  
-   [Step 4: Configure iSCSI storage provider identity credentials](../Topic/iSCSI-Target-Block-Storage,-How-To.md#BKMK_Step4)  
  
> [!NOTE]  
> [!INCLUDE[wps_howtorun](../Token/wps_howtorun_md.md)]  
  
## Prerequisites  
Before you configure block storage, you need to set up two or more servers that are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
## <a name="BKMK_Step1"></a>Step 1: Install iSCSI Target Server and failover clustering  
Install the required role service and features by using Windows PowerShell commands:  
  
1.  Start Windows PowerShell if it is not already open. From the Start menu, click **Administrative Tools**, and then click **Windows PowerShell Modules**. The Windows PowerShell Modules command\-line console appears. The first time you open the tool and click ENTER, Windows PowerShell imports all the cmdlets.  
  
2.  Add the iSCSI Target Server role service by running the following command:  
  
    ```  
    PS C:\> Add-WindowsFeature fs-iscsitarget-server  
    ```  
  
3.  Verify that the iSCSI Target Server role service is installed by running the following command:  
  
    ```  
    PS C:\> Get-WindowsFeature fs-iscsitarget-server  
    ```  
  
    > [!NOTE]  
    > "\[X\]" indicates that the role service is installed.  
  
4.  Install failover clustering by running the following command on the cluster node:  
  
    ```  
    PS C:\> Add-WindowsFeature failover-clustering  
    ```  
  
5.  Verify that the feature is installed on both nodes by running the following command:  
  
    ```  
    PS C:\> Get-WindowsFeatures failover-clustering  
    ```  
  
    > [!NOTE]  
    > "\[X\]" indicates that the feature is installed.  
  
## <a name="BKMK_Step2"></a>Step 2: Configure the iSCSI initiator  
  
1.  On the computer that you set up as the iSCSI initiator, start the iSCSI Initiator Properties. From Server Manager, click the **Tools** menu, and then choose **iSCSI Initiator**.  
  
2.  Click the **Targets** tab, and then type the iSCSI target IP address.  
  
3.  Click **Quick Connect**, and then select the **Connect** button.  
  
After a connection has been established, you can use Windows PowerShell cmdlets to bring the disks online.  
  
#### To use PowerShell cmdlets to bring the disks online  
  
1.  From Windows PowerShell, type:  
  
    ```  
    New-IscsiTargetPortal –TargetPortalAddress <IP_address>  
    $t = Get-IscsiDiscoveredTarget  
    Connect-IscsiDiscoveredTarget –NodeAddress $t.NodeAddress  
    Get-IscsiPersistentTarget  
    ```  
  
    > [!NOTE]  
    > If there is no record returned, you can register the iSCSI target by typing:  
  
    ```  
    Register-IscsiPersistentTarget –TargetName $t.NodeAddress  
    ```  
  
2.  Bring the disk online and create a volume on it:  
  
    ```  
    Get-disk  
    ```  
  
    > [!NOTE]  
    > To manage iSCSI Target Server on a cluster, you will need to use Server Manager or Windows PowerShell cmdlets.  
  
## <a name="BKMK_Step3"></a>Step 3: Create the high availability iSCSI Target Server role service  
To ensure transparent failover, create the iSCSI Target Server role service on a cluster.  
  
#### To create the iSCSI Target Server role service on a cluster  
  
1.  Open Failover Cluster Manager.  
  
2.  Right\-click **Roles**, and then click **Configure Role**. The High Availability Wizard, Select Service or Application page appears.  
  
3.  Select **iSCSI Target Server**. The **Client Access Point** page appears.  
  
4.  Type the service or application name and the IP address for the iSCSI Target Server high\-availability instance.  
  
5.  Select the **Networks Address** check box, and then click **Next**. The **Select Storage** page appears.  
  
    > [!NOTE]  
    > Each time that you assign storage to the cluster nodes, by default, the disks are offline. You need to manually bring them online. To bring the disks online, leave the High Availability Wizard open \(you will return to it shortly\) and open the Disk Management tool.  
  
6.  In the Disk Management tool, right\-click the disks to bring them online.  
  
7.  After bringing the disks online, you need to put them in the storage. Open the Failover Cluster Manager. From the Actions pane, click **Storage**, and then click **Add Disk**.  
  
8.  Return to the High Availability Wizard, select the check box for this storage volume, and then click **Next**. The **Confirmation** page appears.  
  
9. Return to the Failover Cluster Manager and verify that the storage volume was created successfully.  
  
> [!NOTE]  
> To manage iSCSI Target Server on a cluster, you need to use Server Manager or Windows PowerShell cmdlets.  
  
## <a name="BKMK_Step4"></a>Step 4: Configure iSCSI storage provider identity credentials  
The iSCSI VDS and VSS storage providers must be configured to run under the administrative credentials of the iSCSI Target Server. You can configure these credentials by using Windows PowerShell or by using Component Services \(DcomCnfg\). For servers that are not part of a domain, create a local user account with the same user name and password for each server.  
  
#### To use Windows PowerShell to configure credentials  
  
1.  Open Windows PowerShell.  
  
2.  Run the following command:  
  
    ```  
    $PsCred = Get-Credential  
    $PrvdIdentityPath = New-Object System.Management.ManagementPath("root\wmi:WT_iSCSIStorageProviderIdentity")  
    $PrvdIdentityClass = New-Object System.Management.ManagementClass($PrvdIdentityPath)  
    $PrvdIdentityClass.SetProviderIdentity("{88155B26-CE61-42FB-AF31-E024897ADEBF}",$PsCred.UserName,$PsCred.GetNetworkCredential().Password)  
    $PrvdIdentityClass.SetProviderIdentity("{9D884A48-0FB0-4833-AB70-A19405D58616}",$PsCred.UserName,$PsCred.GetNetworkCredential().Password)  
    ```  
  
#### To use Component Services to configure credentials  
  
1.  Open**Component Services**.  
  
2.  In the left pane, click **Computers**, click **My Computer**, and then click **DCOM Config**..  
  
3.  Right\-click **WTVdsProv**, click **Properties**, click the **Identity** tab, click **This user**, enter the user name and password for the iSCSI Target Server account, and then click **OK**.  
  
4.  Right\-click **WTSnapsthoProvider**, click **Properties**, click the **Identity** tab, click **This user**, enter the user name and password of the iSCSI Target Server account, and then click **OK**.  
  
5.  Click **Run**, and then type **regedit**. In the left pane, click**HKey\_Local\_Machine**, click **Software**, click **Microsoft**, click **Windows NT**, click **CurrentVersion**, click **WTVDSProv**, and then click **WtServers**. . Right\-click **WtServers**, point to **New**, click **String Value**, and then type the name of the iSCSI Target Server. \(The **Data** value can remain blank.\)  
  
## <a name="BKMK_Links"></a>See also  
  
-   [iSCSI Target Server Overview](../Topic/iSCSI-Target-Server-Overview.md)  
  
