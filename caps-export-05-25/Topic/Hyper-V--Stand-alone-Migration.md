---
title: Hyper-V: Stand-alone Migration
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4af53985-eab3-496c-9f37-ca66f478248b
author: cwatsonmsft
---
# Hyper-V: Stand-alone Migration
This scenario describes how to migrate a single server running the Hyper\-V role in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
## Migration options  
When you migrate a single server, you have the following migration options available:  
  
-   [In\-place upgrade](../Topic/Hyper-V--Stand-alone-Migration.md#bkmk_inplace)  
  
-   [Cross\-version live migration](../Topic/Hyper-V--Stand-alone-Migration.md#bkmk_crossversion)  
  
-   Export and Import \(not covered in this guide\)  
  
### <a name="bkmk_inplace"></a>In\-place upgrade  
This scenario describes how to use the existing hardware that runs the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] operating system and to perform an in\-place upgrade of the operating system to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. This scenario does not require any additional hardware; however, during the upgrade process, all of the virtual machines must be turned off or be in a saved state.  
  
> [!NOTE]  
> -   We recommend that you shut down or turn off all of the virtual machines before you upgrade. Virtual machines can be in a saved state during the upgrade, but we do not recommend it. You receive a warning during the upgrade process if any of the virtual machines are in a saved state.  
> -   Before you run an in\-place upgrade, we recommend that you back up the host operating system and the virtual machines.  
  
#### Perform an in\-place upgrade  
Use the following steps to perform an in\-place upgrade.  
  
> [!NOTE]  
> If Hyper\-V Replica has been enabled on any of the virtual machines, we recommend that you upgrade the Replica server first. During the upgrade of the Replica server, the primary server continues to send updates to the Replica server, and you might see warning messages about the health of the replication. After the Replica server has successfully upgraded, the replication should continue normally.  
  
-   Log on to the server by using a user account with local Administrator rights.  
  
-   Insert media for [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and run **Setup.exe** if the installation program did not start automatically.  
  
-   Review the upgrade report and fix any blocking warning messages.  
  
-   After the host has restarted, confirm that the server successfully upgraded.  
  
-   Install the latest updates.  
  
-   Start each of the virtual machines that were running before the upgrade.  
  
-   Confirm that each virtual machine operates as expected.  
  
-   Upgrade the integration services for each virtual machine. A restart might be required to complete the integration services update.  
  
### <a name="bkmk_crossversion"></a>Cross\-version live migration  
The upgrade to a new version of the Windows Server operating system no longer requires downtime of the virtual machines. In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], live migration has been updated to support the migration of Hyper\-V virtual machines in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to Hyper\-V in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. If the virtual hard disk \(VHD\) files are stored on an SMB 3.0 file share, you must only move the virtual machine, but not the storage.  
  
This scenario requires additional hardware for a destination server. Ensure that the destination server has the capacity to run the virtual machines that you are currently running and has room for future expansion.  
  
Use the following steps to move a virtual machine from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
##### Prepare the new server hardware  
  
1.  Install [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] on the new server hardware.  
  
2.  Install the Hyper\-V role on the server.  
  
3.  Configure the following Hyper\-V settings, for example:  
  
    -   The default location for virtual hard disks and virtual machine configuration files.  
  
    -   NUMA settings.  
  
    -   Live migration settings. Even if live migration was not previously configured, you must enable and configure live migration on both servers.  
  
    -   Replication settings if Hyper\-V Replica is used. If certificate\-based authentication is configured, an appropriate certificate must be installed on the new server.  
  
    -   Virtual switches.  
  
    -   **Hyper\-V Administrators** local group membership.  
  
4.  Install the latest updates.  
  
#### Move a virtual machine from Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]  
In this section, you move a virtual machine from Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to Hyper\-V in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
Perform this procedure on the source server running Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
###### To move the virtual machine to Hyper\-V in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]  
  
1.  On the **source server** running Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], open the Hyper\-V Manager console, and then select the virtual machine that you want to move.  
  
2.  From the **Actions** pane, click **Move**. This action opens the **Move Wizard**.  
  
    1.  On the **Choose Move Type** page, select **Move the virtual machine**.  
  
    2.  On the **Specify Destination Computer**, specify the name or server that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
    3.  On the **Choose Move Options** page, select **Move only the virtual machine**.  
  
    You can also use the [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet **Move\-VM**. The following example shows a virtual machine *test VM* that is moved to a remote computer *NewServer* where the virtual machine is stored on an SMB share.  
  
    ```  
    PS C:\> Move-VM –Name "Test VM" -DestinationHost NewServer  
    ```  
  
#### Modify the Hyper\-V Replica settings  
  
> [!NOTE]  
> Perform the following procedure on the primary server after moving a virtual machine on the Replica server.  
  
###### \[Optional\] To modify Hyper\-V Replica settings  
  
1.  On the primary server, open the Hyper\-V Manager console, and then select the virtual machine whose Replica virtual machine was just moved.  
  
2.  Right\-click the virtual machine to select **Settings**.  
  
3.  Select **Replication** and update the value for **Replica server** with the name of the destination Replica server.  
  
4.  Confirm that replication has successfully started.  
  
    You can also use the **Set\-VMReplication** cmdlet to update the name of the Replica server.  
  
#### Verify that the virtual machine runs correctly  
This procedure describes how to confirm that the virtual machine that was moved runs correctly on the destination server running Hyper\-V in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
> [!NOTE]  
> Skip this step when you move a virtual machine on a Replica server. Replica virtual machines are in an off state until the virtual machine is failed over by the administrator.  
  
###### To verify that virtual machine runs correctly  
  
1.  Open the Hyper\-V Manager console on the destination server.  
  
2.  Verify that the virtual machine is running. If the virtual machine is not running, attempt to start it. If the virtual machine does not start, check the event log to see why it failed to start.  
  
3.  \[Optional\] \- Run some basic operations that change the state of the virtual machine.  
  
4.  Run the necessary application\-specific tests to ensure that the application on the virtual machine can provide the same service levels as it provided before the virtual machine was migrated. Although the virtual machine was moved while it was running the services that the virtual machine provides, the services should not have been interrupted.  
  
5.  Verify that you can connect to the virtual machine by using **Remote Desktop** or **Virtual Machine Connection**.  
  
6.  Upgrade the integration services on the virtual machine. Because the virtual machine was never shut down during the migration, you can update the integration services silently without a restart. The update occurs the next time that the virtual machine is restarted during its scheduled maintenance period.  
  
    1.  Modify the settings of the virtual machine and specify the following media to be used for the CD\/DVD drive, *%Systemroot%\\System32\\Vmguest.iso*.  
  
    2.  Run the following command from an elevated command prompt in the virtual machine:  
  
        1.  For 64\-bit Windows Server operating systems, *drive:\\Support\\Amd64\\Setup.exe \/quiet \/norestart*  
  
        2.  For 32\-bit Windows Server operating systems, *drive:\\Support\\X86\\Setup.exe \/quiet \/norestart*  
  
## See also  
[Virtual Machine Live Migration Overview](../Topic/Virtual-Machine-Live-Migration-Overview.md)  
  
[Configure Live Migration and Migrating Virtual Machines without Failover Clustering](../Topic/Configure-Live-Migration-and-Migrating-Virtual-Machines-without-Failover-Clustering.md)  
  
[Install and Deploy Windows Server 2012](assetId:///8c6701a3-6c8e-42ed-8cc5-3a0505142932)  
  
[Hyper\-V Replica Overview](assetId:///3d81d4f3-2db8-431b-9796-79ab4fe477be)  
  
