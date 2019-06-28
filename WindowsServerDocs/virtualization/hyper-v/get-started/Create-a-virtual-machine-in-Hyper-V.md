---
title: Create a virtual machine in Hyper-V
description: "Gives instructions for creating a virtual machine using Hyper-V Manager or Windows PowerShell"
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 59297022-a898-456c-b299-d79cd5860238
author: KBDAzure
ms.author: kathydav
ms.date: 10/04/2016
---
# Create a virtual machine in Hyper-V

>Applies To: Windows 10, Windows Server 2016, Microsoft Hyper-V Server 2016, Windows Server 2019, Microsoft Hyper-V Server 2019

Learn how to create a virtual machine by using Hyper-V Manager and Windows PowerShell and what options you have when you create a virtual machine in Hyper-V Manager.  

## Create a virtual machine by using Hyper-V Manager  

1.  Open **Hyper-V Manager**.  

2.  From the **Action** pane, click **New**, and then click **Virtual Machine**.  

3.  From the **New Virtual Machine Wizard**, click **Next**.  

4.  Make the appropriate choices for your virtual machine on each of the pages. For more information, see [New virtual machine options and defaults in Hyper-V Manager](#options-in-hyper-v-manager-new-virtual-machine-wizard) later in this topic.  

5.  After verifying your choices in the **Summary** page, click **Finish**.  

6.  In Hyper-V Manager, right-click the virtual machine and select **connect**.  

7.  In the Virtual Machine Connection window, select **Action** > **Start**.  

## Create a virtual machine by using Windows PowerShell  

1. On the Windows desktop, click the Start button and type any part of the name **Windows PowerShell**.  

2. Right-click **Windows PowerShell** and select **Run as administrator**.  

3. Get the name of the virtual switch that you want the virtual machine to use by using [Get-VMSwitch](https://technet.microsoft.com/library/hh848499.aspx).  For example,  

   ```  
   Get-VMSwitch  * | Format-Table Name  
   ```  

4. Use the [New-VM](https://technet.microsoft.com/library/hh848537.aspx) cmdlet to create the  virtual machine.  See the following examples.  

   > [!NOTE]  
   > If you may move this virtual machine to a Hyper-V host that runs Windows Server 2012 R2, use the -Version parameter with  [New-VM](https://technet.microsoft.com/library/hh848537.aspx) to set the virtual machine configuration  version to 5. The default virtual machine configuration version for Windows Server 2016 isn't supported by  Windows Server 2012 R2  or earlier versions. You can't change the virtual machine configuration version after the virtual machine is created. For more information, see [Supported virtual machine configuration versions](../deploy/Upgrade-virtual-machine-version-in-Hyper-V-on-Windows-or-Windows-Server.md#supported-virtual-machine-configuration-versions).  

   - **Existing virtual hard disk** - To create a virtual machine with an existing virtual hard disk, you can use the following command where,  
     - **-Name** is the name that you provide for the virtual machine that you're creating.  
     - **-MemoryStartupBytes** is the amount of memory   that is available to the virtual machine at start up.  
     - **-BootDevice** is the device that the virtual machine boots to  when it starts like the network adapter (NetworkAdapter) or virtual hard disk (VHD).  
     - **-VHDPath** is the path to the virtual machine disk that you want to use.  
     - **-Path** is the path to store the virtual machine configuration files.  
     - **-Generation** is the virtual machine generation. Use generation 1 for VHD and generation 2 for VHDX. See [Should I create a generation 1 or 2 virtual machine in Hyper-V?.](../plan/Should-I-create-a-generation-1-or-2-virtual-machine-in-Hyper-V.md)  
     - **-Switch** is the name of the virtual switch that you want the virtual machine to use to connect to other virtual machines or the network. See [Create a virtual switch for Hyper-V virtual machines](Create-a-virtual-switch-for-Hyper-V-virtual-machines.md).  

       ```  
       New-VM -Name <Name> -MemoryStartupBytes <Memory> -BootDevice <BootDevice> -VHDPath <VHDPath> -Path <Path> -Generation <Generation> -Switch <SwitchName>  
       ```  

       For example:  

       ```  
       New-VM -Name Win10VM -MemoryStartupBytes 4GB -BootDevice VHD -VHDPath .\VMs\Win10.vhdx -Path .\VMData -Generation 2 -Switch ExternalSwitch  
       ```  

       This creates a generation 2 virtual machine named Win10VM with 4GB of memory. It boots from the folder VMs\Win10.vhdx in the current directory and uses the virtual switch named ExternalSwitch. The virtual machine configuration files are stored in the folder VMData.  

   - **New virtual hard disk** - To create a virtual machine with a new virtual hard disk, replace the **-VHDPath** parameter from the example above  with  **-NewVHDPath** and add the **-NewVHDSizeBytes** parameter. For example,  

     ```  
     New-VM -Name Win10VM -MemoryStartupBytes 4GB -BootDevice VHD -NewVHDPath .\VMs\Win10.vhdx -Path .\VMData -NewVHDSizeBytes 20GB -Generation 2 -Switch ExternalSwitch  
     ```  

   - **New virtual hard disk that boots to operating system image** - To create a virtual machine with a new virtual disk that boots to an operating system image, see the PowerShell example in [Create virtual machine walkthrough for Hyper-V on Windows 10](https://msdn.microsoft.com/virtualization/hyperv_on_windows/quick_start/walkthrough_create_vm).  

5. Start the virtual machine by using the [Start-VM](https://technet.microsoft.com/library/hh848589.aspx) cmdlet. Run the following cmdlet where Name is the name of the  virtual machine you created.  

   ```  
   Start-VM -Name <Name>  
   ```  

   For example:  

   ```  
   Start-VM -Name Win10VM  
   ```  

6. Connect to the virtual machine by using Virtual Machine Connection (VMConnect).  

   ```  
   VMConnect.exe  
   ```  

## Options in Hyper-V Manager New Virtual Machine Wizard  
The following table lists the options you can pick when you create a virtual machine in Hyper-V Manager and the defaults for each.  

|Page|Default for Windows Server 2016 and Windows 10|Other options|  
|--------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------|  
|**Specify Name and Location**|Name:  New Virtual Machine.<br /><br />Location:  **C:\ProgramData\Microsoft\Windows\Hyper-V\\**.|You can also enter your own name and choose another location for the virtual machine.<br /><br />This is where the virtual machine configuration files will be stored.|  
|**Specify Generation**|Generation 1|You can also choose to create a Generation 2 virtual machine. For more information, see [Should I create a generation 1 or 2 virtual machine in Hyper-V?.](../plan/Should-I-create-a-generation-1-or-2-virtual-machine-in-Hyper-V.md)|  
|**Assign Memory**|Startup memory: 1024 MB<br /><br />Dynamic memory: **not selected**|You can set the startup memory from 32MB to 5902MB.<br /><br />You can also choose to use Dynamic Memory. For more information, see [Hyper-V Dynamic Memory Overview](https://technet.microsoft.com/library/hh831766.aspx).|  
|**Configure Networking**|Not connected|You can select a network connection for the virtual machine to use from a list of existing virtual switches. See [Create a virtual switch for Hyper-V virtual machines](Create-a-virtual-switch-for-Hyper-V-virtual-machines.md).|  
|**Connect Virtual Hard Disk**|Create a virtual hard disk<br /><br />Name: <*vmname*>.vhdx<br /><br />**Location**: **C:\Users\Public\Documents\Hyper-V\Virtual Hard Disks\\**<br /><br />**Size**: 127GB|You can also choose to use an existing virtual hard disk or wait and attach a virtual hard disk later.|  
|**Installation Options**|Install an operating system later|These options change the boot order of the virtual machine so that you can install from an .iso file, bootable floppy disk or a network installation service, like Windows Deployment Services (WDS).|  
|**Summary**|Displays the options that you have chosen, so that you can verify they are correct.<br /><br />-   Name<br />-   Generation<br />-   Memory<br />-   Network<br />-   Hard Disk<br />-   Operating System|**Tip:** You can copy the summary from the page and paste it into e-mail or somewhere else to help you keep track of your virtual machines.|  

## See also  

- [New-VM](https://technet.microsoft.com/library/hh848537.aspx)  

- [Supported virtual machine configuration versions](../deploy/Upgrade-virtual-machine-version-in-Hyper-V-on-Windows-or-Windows-Server.md#supported-virtual-machine-configuration-versions)  

-   [Should I create a generation 1 or 2 virtual machine in Hyper-V?](../plan/Should-I-create-a-generation-1-or-2-virtual-machine-in-Hyper-V.md)  

-   [Create a virtual switch for Hyper-V virtual machines](Create-a-virtual-switch-for-Hyper-V-virtual-machines.md)  
