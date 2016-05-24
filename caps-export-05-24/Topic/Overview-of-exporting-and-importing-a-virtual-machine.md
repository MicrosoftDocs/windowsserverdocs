---
title: Overview of exporting and importing a virtual machine
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6240a7bc-446f-4417-bf18-a82756690c87
author: cwatsonmsft
---
# Overview of exporting and importing a virtual machine
Hyper\-V helps you to move virtual machines to a different host by providing Export and Import options.  
  
## <a name="MKMK_Export"></a>Export  
Starting in Windows Server 2012, you no longer need to export a virtual machine in order to be able to import it. But, the export functionality still exists and it can be an easy way to prepare virtual machines to be imported.  
  
For information about using Windows PowerShell to export virtual machines, see [Export\-VM](http://technet.microsoft.com/library/hh848491.aspx)  
  
During the export process, files that are used to run the virtual machine are moved into the location you specify. The files are organized in the following sub\-folders:  
  
|Sub\-folder name|Contents|  
|--------------------|------------|  
|Snapshots|If there are checkpoints, it will contain an .xml configuration file for each checkpoint using the checkpoint GUID as the file name.|  
|Virtual Hard Disks|This contains a copy of the .vhdx file and any .avhdx files for existing checkpoints.|  
|Virtual Machines|If the virtual machine is not running, this folder will only contain the .xml virtual machine configuration file. If the VM is in a saved state, there will be a sub\-folder that uses the VM GUID as its name, containing a .bin and a .vsv virtual machine saved state file.|  
  
## <a name="BKMK_Import"></a>Import  
Starting in Windows Server 2012, you no longer need to export a virtual machine to be able to import it. You can simply copy a virtual machine and its associated files to the new host, and then use the **Import Virtual Machine** wizard to specify the location of the files. This registers the virtual machine with Hyper\-V and makes it available for use.  
  
In addition to the wizard, the Hyper\-V module for Windows PowerShell includes cmdlets for importing virtual machines. For more information, see [Import\-VM](http://technet.microsoft.com/en-us/library/hh848495.aspx)  
  
During the import process, you can choose how to import the virtual machine:  
  
|Import type|Description|  
|---------------|---------------|  
|**Register**|Uses the existing unique ID of the virtual machine and registers it in\-place.  Choose this option if the virtual machines files are already in the correct location.|  
|**Restore**|Uses the original virtual machine’s unique ID and also copies the virtual machine files to the default location specified for the host.|  
|**Copy**|Creates a new unique ID for the virtual machine and also copies the virtual machine files to the default location specified for the host.|  
  
The **Import Virtual Machine** wizard also walks you through the steps of addressing incompatibilities when you import the virtual machine to the new host—so this wizard can help with configuration that is associated with physical hardware, such as memory, virtual switches, and virtual processors. To import a virtual machine, the wizard does the following:  
  
1.  **Creates a copy of the virtual machine configuration file.** This is done as a precaution in case an unexpected restart occurs on the host, such as from a power outage.  
  
2.  **Validates hardware.** Information in the virtual machine configuration file is compared to hardware on the new host.  
  
3.  **Compiles a list of errors.** This list identifies what needs to be reconfigured and determines which pages appear next in the wizard.  
  
4.  **Displays the relevant pages, one category at a time.** The wizard explains each incompatibility to help you reconfigure the virtual machine so it is compatible with the new host.  
  
5.  **Removes the copy of the configuration file.** After the wizard does this, the virtual machine is ready to be started.  
  
## See Also  
  
-   [Hyper-V Module for Windows PowerShell](../Topic/Hyper-V-Module-for-Windows-PowerShell.md)  
  
