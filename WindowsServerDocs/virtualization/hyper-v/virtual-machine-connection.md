---
title: Hyper-V Virtual Machine Connection
description: Describes Virtual Machine Connection, and includes details on how to do common tasks, such as send Ctrl-Alt-Delete to the virtual machine.
ms.topic: concept-article
ms.author: daknappe
author: dknappettmsft
ms.date: 06/26/2025
---

# Hyper-V Virtual Machine Connection

Virtual Machine Connection (VMConnect) is a tool you can use to connect to a virtual machine to install or interact with the guest operating system in a virtual machine. Some of the tasks you can perform by using VMConnect include the following:

- Start and shut down a virtual machine

- Connect to a DVD image (.iso file) or a USB flash drive

- Create a checkpoint

- Modify the settings of a virtual machine

## Tips for using VMConnect

You might find the following information helpful for using VMConnect:

|To do this…|Do this…|
|---------------|------------|
|Send mouse clicks or keyboard input to the virtual machine|Click anywhere in the virtual machine window. The mouse pointer might appear as a small dot when you connect to a running virtual machine.|
|Return mouse clicks or keyboard input to the physical computer|Press CTRL\+ALT\+LEFT ARROW and then move the mouse pointer outside of the virtual machine window. This mouse release key combination can be changed in the Hyper\-V settings in Hyper\-V Manager.|
|Send the CTRL\+ALT\+DELETE key combination to a virtual machine|Select **Action** > **Ctrl\+Alt\+Delete** or use the key combination CTRL\+ALT\+END.|
|Switch from window mode to full\-screen mode|Select **View** > **Full Screen Mode**. To switch back to window mode, press CTRL\+ALT\+BREAK.|
|Create a checkpoint to capture the current state of the machine for troubleshooting|Select **Action** > **Checkpoint** or use the key combination CTRL\+N.|
|Change the settings of the virtual machine|Select **File** > **Settings**.|
|Connect to a DVD image \(.iso file\) or a virtual floppy disk \(.vfd file\)|Select **Media**.<p>Virtual floppy disks aren't supported for generation 2 virtual machines. For more information, see [Should I create a generation 1 or 2 virtual machine in Hyper-V?](plan/Should-I-create-a-generation-1-or-2-virtual-machine-in-Hyper-V.md).|
|Use a host's local resources on Hyper\-V virtual machine like a USB flash drive|Turn on enhanced session mode on the Hyper-V host, use VMConnect to connect to the virtual machine, and before you connect, choose the local resource that you want to use. For the specific steps, see [Use local resources on Hyper\-V virtual machine with VMConnect](use-local-resources-virtual-machine-connection.md).|
|Change saved VMConnect settings for a virtual machine|Run the following command in Windows PowerShell or the command prompt:<p>`VMConnect.exe <ServerName> <VMName> /edit`|
|Prevent a VMConnect user from taking over another user's VMConnect session|Not having enhanced session mode turned on might pose a security and privacy risk. If a user is connected and logged on to a virtual machine through VMConnect and another authorized user connects to the same virtual machine, the session is taken over by the second user and the first user loses the session. The second user will be able to view the first user's desktop, documents, and applications.|
|Manage integration services or components that allow the VM to communicate with the Hyper-V host| On Hyper-V hosts that run Windows 10 or Windows Server 2016, you can't manage integration services with VMConnect. See these articles: <br />- [Turn on/turn off integration services from the Hyper-V host](manage/manage-hyper-v-integration-services.md#turn-an-integration-service-on-or-off-using-hyper-v-manager) <br />- [Turn on/turn off integration services from a Windows virtual machine](manage/manage-hyper-v-integration-services.md#start-and-stop-an-integration-service-from-a-windows-guest)<br />- [Turn on/turn off integration services from a Linux virtual machine](manage/manage-hyper-v-integration-services.md#start-and-stop-an-integration-service-from-a-linux-guest) <br />- [Keep integration services updated for the virtual machine](manage/manage-hyper-v-integration-services.md#keep-integration-services-up-to-date).|
|Resize the VMConnect window|You can change the size of the VMConnect window for generation 2 virtual machines that run a Windows operating system. To do this, you might need to turn on enhanced session mode on the Hyper-V host. For virtual machines that run Ubuntu, see [Changing Ubuntu Screen Resolution in a Hyper-V VM](/archive/blogs/virtual_pc_guy/changing-ubuntu-screen-resolution-in-a-hyper-v-vm).|

## Keyboard shortcuts

By default, keyboard input and mouse clicks are sent to the virtual machine. So you might need to press CTRL + ALT + LEFT ARROW before you use the following shortcut keys.

|Key combination|Description|
|-------------------|---------------|
|CTRL\+ALT\+LEFT ARROW|Mouse release|
|CTRL\+ALT\+END|Equivalent of CTRL\+ALT\+DELETE in the virtual machine|
|CTRL\+ALT\+BREAK|Switch from full\-screen mode back to windowed mode|
|CTRL\+O|Opens the settings for the virtual machine|
|CTRL\+S|Starts the virtual machine|
|CTRL\+N|Creates a checkpoint|
|CTRL\+E|Reverts to a checkpoint|
|CTRL\+C|Does a screen capture|

## Related content

- [Hyper-V overview](/windows-server/virtualization/hyper-v/hyper-v-overview?pivots=windows-server)
- [Use local resources on Hyper-V virtual machine with VMConnect](use-local-resources-virtual-machine-connection.md)
