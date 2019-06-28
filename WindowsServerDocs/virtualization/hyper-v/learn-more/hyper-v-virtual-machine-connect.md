---
title: Hyper-V Virtual Machine Connection
description: "Describes Virtual Machine Connection, which provides remote access to a virtual machine. Includes details on how to do common tasks, such as send Ctrl-Alt-Delete to the virtual machine."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: deae35b9-7647-42b8-b6bf-45645a44c9c4
author: KBDAzure
ms.author: kathydav
ms.date: 10/04/2016
---
# Hyper-V Virtual Machine Connection

>Applies To: Windows Server 2016, Windows 10, Windows 8.1, Windows Server 2012 R2, Windows Server 2012, Windows 8

Virtual Machine Connection \(VMConnect\) is a tool that you use to connect to a virtual machine so that you can install or interact with the guest operating system in a virtual machine. Some of the tasks that you can perform by using VMConnect include the following:  
  
-   Start and shut down a virtual machine  
  
-   Connect to a DVD image \(.iso file\) or a USB flash drive  
  
-   Create a checkpoint  
  
-   Modify the settings of a virtual machine  
    
## Tips for using VMConnect  
You may find the following information helpful for using VMConnect:  
  
|To do this…|Do this…|  
|---------------|------------|  
|Send mouse clicks or keyboard input to the virtual machine|Click anywhere in the virtual machine window. The mouse pointer may appear as a small dot when you connect to a running virtual machine.|  
|Return mouse clicks or keyboard input to the physical computer|Press CTRL\+ALT\+LEFT arrow and then move the mouse pointer outside of the virtual machine window. This mouse release key combination can be changed in the Hyper\-V settings in Hyper\-V Manager.|  
|Send CTRL\+ALT\+DELETE key combination to a virtual machine|Select **Action** > **Ctrl\+Alt\+Delete** or use the key combination CTRL\+ALT\+END.|  
|Switch from a window mode to a full\-screen mode|Select **View** > **Full Screen Mode**. To switch back to window mode, press CTRL\+ALT\+BREAK.|  
|Create a checkpoint to capture the current state of the machine for troubleshooting|Select **Action** > **Checkpoint** or use the key combination CTRL\+N.|  
|Change the settings of the virtual machine|Select **File** > **Settings**.|  
|Connect to a DVD image \(.iso file\) or a virtual floppy disk \(.vfd file\)|Select **Media**.<br /><br />Virtual floppy disks are not supported for generation 2 virtual machines. For more information, see [Should I create a generation 1 or 2 virtual machine in Hyper-V?](../plan/Should-I-create-a-generation-1-or-2-virtual-machine-in-Hyper-V.md).|  
|Use a host’s local resources on Hyper\-V virtual machine like a USB flash drive|Turn on enhanced session mode on the Hyper-V host, use VMConnect to connect to the virtual machine, and before you connect, choose the local resource that you want to use. For the specific steps, see [Use local resources on Hyper\-V virtual machine with VMConnect](Use-local-resources-on-Hyper-V-virtual-machine-with-VMConnect.md).|  
|Change saved VMConnect settings for a virtual machine|Run the following command in Windows PowerShell or the command prompt:<br /><br />`VMConnect.exe <ServerName> <VMName> \/edit`|  
|Prevent a VMConnect user from taking over another user’s VMConnect session|[Turn on enhanced session mode on Hyper-V host](Use-local-resources-on-Hyper-V-virtual-machine-with-VMConnect.md#turn-on-enhanced-session-mode-on-a-hyper-v-host).<br /><br />Not having enhanced session mode turned on may pose a security and privacy risk. If a user is connected and logged on to a virtual machine through VMConnect and another authorized user connects to the same virtual machine, the session will be taken over by the second user and the first user will lose the session. The second user will be able to view the first user's desktop, documents, and applications.|
|Manage integration services or components that allow the VM to communicate with the Hyper-V host| On Hyper-V hosts that run Windows 10 or Windows Server 2016, you can't manage integration services with VMConnect. See these topics: <br />- [Turn on/turn off integration services from the Hyper-V host](https://msdn.microsoft.com/virtualization/hyperv_on_windows/user_guide/managing_ics) <br />- [Turn on/turn off integration services from a Windows virtual machine](https://msdn.microsoft.com/virtualization/hyperv_on_windows/user_guide/managing_ics#manage-integration-services-from-guest-os-windows)<br />- [Turn on/turn off integration services from a Linux virtual machine](https://msdn.microsoft.com/virtualization/hyperv_on_windows/user_guide/managing_ics#manage-integration-services-from-guest-os-linux) <br />- [Keep integration services updated for the virtual machine](https://msdn.microsoft.com/virtualization/hyperv_on_windows/user_guide/managing_ics#integration-service-maintenance)  <br />For hosts that run Windows Server 2012 or Windows Server 2012 R2, see [Integration Services](https://technet.microsoft.com/library/dn798297(v=ws.11).aspx).|
|Resize the VMConnect window|You can change the size of the VMConnect window for generation 2 virtual machines that run a Windows operating system. To do this, you may need to turn on enhanced session mode on the Hyper-V host. For more information, see [Turn on enhanced session mode on Hyper-V host](Use-local-resources-on-Hyper-V-virtual-machine-with-VMConnect.md#turn-on-enhanced-session-mode-on-a-hyper-v-host). For virtual machines that run Ubuntu, see [Changing Ubuntu Screen Resolution in a Hyper-V VM](https://blogs.msdn.microsoft.com/virtual_pc_guy/2014/09/19/changing-ubuntu-screen-resolution-in-a-hyper-v-vm/).|


## Keyboard shortcuts  
By default, the keyboard input and mouse clicks are sent to the virtual machine. So you may need to press CTRL + ALT + LEFT arrow before you use the following shortcut keys. 

|Key combination|Description|  
|-------------------|---------------|  
|CTRL\+ALT\+LEFT arrow|Mouse release|  
|CTRL\+ALT\+END|Equivalent of CTRL\+ALT\+DELETE in the virtual machine|  
|CTRL\+ALT\+BREAK|Switch from full\-screen mode back to windowed mode|  
|CTRL\+O|Opens the settings for the virtual machine|  
|CTRL\+S|Starts the virtual machine|  
|CTRL\+N|Create a checkpoint|  
|CTRL\+E|Revert to a checkpoint|  
|CTRL\+C|Do a screen capture|  

## See Also  
-   [Use local resources on Hyper-V virtual machine with VMConnect](Use-local-resources-on-Hyper-V-virtual-machine-with-VMConnect.md)  
-   [Hyper-V on Windows Server 2016](../Hyper-V-on-Windows-Server.md)  
-   [Hyper-V on Windows 10](https://msdn.microsoft.com/virtualization/hyperv_on_windows/windows_welcome)  
  
  
