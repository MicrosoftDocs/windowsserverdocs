---
title: Troubleshooting Nano Server
description: "Recovery Console, Emergency Management Services, kernel debugging"
ms.prod: windows-server-threshold
ms.service: na
manager: DonGill
ms.technology: server-nano
ms.date: 09/06/2017
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e427c66f-9571-4b8c-b65d-e7370d91544d
author: jaimeo
ms.author: jaimeo
ms.localizationpriority: medium
---
# Troubleshooting Nano Server

>Applies To: Windows Server 2016

> [!IMPORTANT]
> Starting in Windows Server, version 1709, Nano Server will be available only as a [container base OS image](/virtualization/windowscontainers/quick-start/using-insider-container-images#install-base-container-image). Check out [Changes to Nano Server](nano-in-semi-annual-channel.md) to learn what this means. 

This topic includes information about tools you can use to connect to, diagnose, and repair Nano Server installations.  
  
## Using the Nano Server Recovery Console 
 
Nano Server includes a Recovery Console that ensures you can access your Nano Server even if a network mis-configuration interferes with connecting to the Nano Server. You can use the Recovery Console to fix the network and then use your usual remote management tools.  
  
When you boot Nano Server in either a virtual machine or on a physical computer that has a monitor and keyboard attached, you'll see a full-screen, text-mode logon prompt. Log into this prompt with an administrator account to see the computer name and IP address of the Nano Server. You can use these commands to navigate in this console:  
  
-   Use arrow keys to scroll  
  
-   Use TAB to move to any text that starts with **>**; then press ENTER to select.  
  
-   To go back one screen or page, press ESC. If you're on the home page, pressing ESC will log you off.  
  
-   Some screens have additional capabilities displayed on the last line of the screen. For example, if you explore a network adapter, F4 will disable the network adapter.  
  
The Recovery Console allows you to view and configure network adapters and TCP/IP settings, as well as firewall rules.
> [!NOTE]
> The Recovery Console only supports basic keyboard functions. Keyboard lights, 10-key sections, and keyboard layout switching such as caps lock and number lock are not supported. Only English keyboards and character set are supported.

## Accessing Nano Server over a serial port with Emergency Management Services  
Emergency Management Services (EMS) lets you perform basic troubleshooting, get network status, and open console sessions (including CMD/PowerShell) by using a terminal emulator over a serial port. This replaces the need for a keyboard and monitor to troubleshoot a server. For more information about EMS, see [Emergency Management Services Technical Reference](https://technet.microsoft.com/library/cc784411(v=ws.10).aspx).

To enable EMS on a Nano Server image so that it's ready should you need it later, run this cmdlet:  
  
`New-NanoServerImage   -MediaPath \\Path\To\Media\en_us   -BasePath .\Base   -TargetPath .\EnablingEMS.vhdx   -EnableEMS   -EMSPort 3   -EMSBaudRate 9600`  
  
This example cmdlet enables EMS on serial port 3 with a baud rate of 9600 bps. If you don't include those parameters, the defaults are port 1 and 115200 bps. To use this cmdlet for VHDX media, be sure to include the Hyper-V feature and the corresponding Windows PowerShell modules.

## Kernel debugging  
You can configure the Nano Server image to support kernel debugging by a variety of methods. To use kernel debugging with a VHDX image, be sure to include the Hyper-V feature and the corresponding Windows PowerShell modules. For more information about remote kernel debugging generally see [Setting Up Kernel-Mode Debugging over a Network Cable Manually](https://msdn.microsoft.com/library/windows/hardware/hh439346%28v=vs.85%29.aspx) and  [Remote Debugging Using WinDbg](https://msdn.microsoft.com/library/windows/hardware/hh451173%28v=vs.85%29.aspx).  
  
### Debugging using a serial port  
Use this example cmdlet to enable the image to be debugged using a serial port:  
  
`New-NanoServerImage   -MediaPath \\Path\To\Media\en_us   -BasePath .\Base   -TargetPath .\KernelDebuggingSerial   -DebugMethod Serial   -DebugCOMPort 1   -DebugBaudRate 9600`  
  
This example enables serial debugging over port 2 with a baud rate of 9600 bps. If you don't specify these parameters, the defaults are prot 2 and 115200 bps. If you intend to use both EMS and kernel debugging, you'll have to configure them to use two separate serial ports.  
  
### Debugging over a TCP/IP network  
Use this example cmdlet to enable the image to be debugged over a TCP/IP network:  
  
`New-NanoServerImage   -MediaPath \\Path\To\Media\en_us   -BasePath .\Base   -TargetPath .\KernelDebuggingNetwork   -DebugMethod Net   -DebugRemoteIP 192.168.1.100   -DebugPort 64000`  
  
This cmdlet enables kernel debugging such that only the computer with the IP address of 192.168.1.100 is allowed to connect, with all communications over port 64000. The -DebugRemoteIP and -DebugPort parameters are mandatory, with a port number greater than 49152. This cmdlet generates an encryption key in a file alongside the resulting VHD which is required for communication over the port. Alternately, you can specify your own key with the -DebugKey parameter, as in this example:  
  
`New-NanoServerImage   -MediaPath \\Path\To\Media\en_us   -BasePath .\Base   -TargetPath .\KernelDebuggingNetwork   -DebugMethod Net   -DebugRemoteIP 192.168.1.100   -DebugPort 64000   -DebugKey 1.2.3.4`  
  
### Debugging using the IEEE1394 protocol (Firewire)  
To enable debugging over IEEE1394 use this example cmdlet:  
  
`New-NanoServerImage   -MediaPath \\Path\To\Media\en_us   -BasePath .\Base   -TargetPath .\KernelDebuggingFireWire   -DebugMethod 1394   -DebugChannel 3`  
  
The -DebugChannel parameter is mandatory.  
  
### Debugging using USB  
You can enable debugging over USB with this cmdlet:  
  
`New-NanoServerImage   -MediaPath \\Path\To\Media\en_us   -BasePath .\Base   -TargetPath .\KernelDebuggingUSB   -DebugMethod USB   -DebugTargetName KernelDebuggingUSBNano`  
  
When you connect the remote debugger to the resulting Nano Server, specify the target name as set by the -DebugTargetName parameter.    