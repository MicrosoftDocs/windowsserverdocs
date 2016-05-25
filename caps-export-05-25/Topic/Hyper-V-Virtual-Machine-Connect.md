---
title: Hyper-V Virtual Machine Connect
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: deae35b9-7647-42b8-b6bf-45645a44c9c4
author: cwatsonmsft
---
# Hyper-V Virtual Machine Connect
Virtual Machine Connection \(VMConnect\) is a tool that you use to connect to a virtual machine so that you can install or interact with the guest operating system in a virtual machine. Some of the tasks that you can perform by using VMConnect include the following:  
  
-   Start and shut down a virtual machine  
  
-   Connect to a DVD image \(.iso file\) or a virtual floppy disk \(.vfd file\)  
  
-   Create a checkpoint  
  
-   Modify the settings of a virtual machine  
  
## Keyboard shortcuts  
  
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
|Connect to a DVD image \(.iso file\) or a virtual floppy disk \(.vfd file\)|Select **Media**.<br /><br />Virtual floppy disks are not supported for generation 2 virtual machines. For more information about generation 2 virtual machines, see [Generation 2 Virtual Machine Overview](../Topic/Generation-2-Virtual-Machine-Overview.md).|  
|Use a host’s local resources on Hyper\-V virtual machine like a USB drive|Turn on enhanced session mode on the Hyper\-V host, use VMConnect to connect to the virtual machine, and before you connect, choose the local resource that you want to use. For the specific steps, see [Use local resources on Hyper\-V virtual machine with VMConnect](../Topic/Use-local-resources-on-Hyper-V-virtual-machine-with-VMConnect.md).|  
|Change saved VMConnect settings for a virtual machine|Run the following command in Windows PowerShell or the command prompt:<br /><br />`VMConnect.exe <ServerName> <VMName> \/edit`|  
|Prevent a VMConnect user from taking over another user’s VMConnect session|[Turn on enhanced session mode on Hyper\-V host](https://technet.microsoft.com/library/dn282274.aspx#BKMK_OVER).<br /><br />Not having enhanced session mode turned on may pose a security and privacy risk. If a user is connected and logged on to a virtual machine through VMConnect and another authorized user connects to the same virtual machine, the session will be taken over by the second user and the first user will lose the session. The second user will be able to view the first user's desktop, documents, and applications.|  
  
## See Also  
-   [Use local resources on Hyper\-V virtual machine with VMConnect](https://technet.microsoft.com/library/dn282274.aspx)  
-   [Hyper-V on Windows Server 2016](Hyper-V-on-Windows-Server-2016-Technical-Preview.md)  
-   [Hyper-V on Windows 10](https://msdn.microsoft.com/virtualization/hyperv_on_windows/windows_welcome)  
  
  
