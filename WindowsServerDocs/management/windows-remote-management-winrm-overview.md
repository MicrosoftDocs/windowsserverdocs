---
title: Windows remote management (WinRM) Overview
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c5157a55-9e3d-44d3-92c3-d174c3d70b51
---
# Windows remote management (WinRM) Overview
Windows remote management \(WinRM\) is designed to improve hardware management in a network environment with various devices running a variety of operating systems. The purpose of WinRM is focused on monitoring and managing remote computers by implementing an interoperable standard protocol.

This topic provides an overview of WinRM and closely-related technologies, and provides links to additional information.

## What is WinRM?
WinRM is the Microsoft implementation of Web Services-management \(WS-management\). WS-management is an industry-standard Web services-based protocol. Like WS-management, WinRM provides a secure, efficient way for management applications and scripts to communicate with local and remote computers. The Windows service that WinRM installs and uses is WinRM.exe.

if a server has a baseboard management controller \(BMC\) that supports the WS-management standard, applications and scripts can use WinRM to communicate directly with that BMC, even if the host operating system is offline \(not started or in POST-failure\).

for servers that do not have a BMC, WinRM can still be used to connect to Windows management Instrumentation \(WMI\) remotely in situations where Distributed component Object model \(DCOM\) communication is impeded, for example, across a firewall. This is possible because the WS-management standard is firewall-friendly and uses a single port configurable by the system administrator.
## Practical applications
You can use WinRM scripting objects, the WinRM command-line tool, or the Windows remote Shell command line tool winrs.exe to get management data about local and remote computers that have BMCs. if the computer runs a Windows-based operating system version that includes WinRM, the management data is supplied by WMI.

You can also use WinRM to obtain hardware and system data from WS-management protocol implementations running on operating systems other than Windows in your enterprise. In such cases, WinRM establishes a session with a remote computer through the Simple Object Access Protocol \(SOAP\)-based WS-management protocol rather than a connection through DCOM. Data returned to WS-management protocol is formatted in XML rather than in objects.

BMC hardware has its own System Event Log \(SEL\) where it records significant events. Through an Event Log plug-in and Event Collector that is installed as part of Hardware management, Windows Servers can subscribe to events stored in the BMC SEL so that they appear in Windows Event Viewer. In case of an operating system shutdown or failure, Windows logs IPMI events into the BMC SEL. The administrator can then access the BMC SEL using out-of-band tools to determine why a machine is not running.

## Tools
**Windows powershell remoting features** - The Windows powershell remoting features are supported by the WS-management protocol and the Windows remote management (WinRM) service that implements WS-management in Windows.

**wecutil.exe** - Event Collector is managed with a command-line tool, Windows Event Collector Utility (wecutil.exe). You can use wecutil.exe to create and manage event subscriptions to BMC events. The tool provides extensive command-line usage with examples by entering the command */?*

**winrmcmd** - This command–line tool for system management is implemented in a Visual Basic Scripting edition file \(Winrm.vbs\) written using the WinRM scripting API. This tool enables an administrator to configure WinRM and to get data or manage resources. to learn more, see the provided winrmcmd help by entering the command *Winrm /?*

**WinRM Scripting API**  - This scripting API enables you to obtain data from remote computers using scripts that perform WS-management protocol operations.

**winrs.exe** - This command line tool enables administrators to remotely execute most cmd.exe commands using the WS-management protocol. for more information, see the online help provided by the entering the command *winrs /?*

## Related standards and technology descriptions: 
**BMC** is a subset of IPMI. A BMC is a specialized microcontroller that monitors the physical state of a device, such as a server computer. Typically imbedded in the motherboard of the device, the BMC collects data from system sensors. The sensors can measure a wide range of system conditions, such as: power status, voltage, fan speed, temperature, humidity, and operating system status. The BMC monitors the sensors and if any of the parameters are not within the preset limits, the BMC alerts the administrator. That person can then take corrective action by remote control. The administrator can also remotely communicate with the BMC to take some corrective action such as power cycling or rebooting the system.

**IPMI** is a set of specifications defining the self-governing computers subsystems that can provide management and monitoring capabilities. These subsystems function independently from the systems operating system, central processor unit \(CPU\), Basic Input\/Output System \(BIOS\), or Unified Extensible Firmware Interface \(UEFI\). IPMI provides an interface that you can use to manage a device through its network adapter, even if the device is unresponsive or shut down.

**IPMI driver and WMI provider** Hardware management through the IPMI provider and driver enables you to control and diagnose remote server hardware through BMCs when the operating system is not running or deployed.

**WMI service** The WMI service runs side-by-side with WinRM, and provides requested data or control through the WMI plug-in. You can obtain data from standard WMI classes, such as Win32_Process, as well as IPMI-supplied data.

**WS-management** is a firewall-friendly, standard SOAP-based protocol that allows hardware and operating systems from different vendors to interoperate. The WS-management protocol was developed by the Distributed management Task force \(DMTF\). WS-management is a public standard for remotely exchanging management data with devices on a network that implement the WS-Man protocol.

## additional technical resources:
[Distributed management Task force (DMTF)](http://www.dmtf.org/)

[Enable and Use remote Commands in Windows powershell](https://technet.microsoft.com/magazine/ff700227.aspx)

[Intelligent Platform management Interface Specification Second Generation v2.0 \(IPMI\)](http://www.intel.com/content/www/us/en/servers/ipmi/ipmi-second-gen-interface-spec-v2-rev1-1.html)

[Simple Object Access Protocol \(SOAP\)](http://www.w3.org/TR/2000/NOTE-SOAP-20000508/)

[Understanding powershell remote management](https://blogs.technet.microsoft.com/heyscriptingguy/2012/12/30/understanding-powershell-remote-management/)

[Understanding SOAP](https://msdn.microsoft.com/library/ms995800.aspx)

[Windows remote management](https://msdn.microsoft.com/library/windows/desktop/aa384426.aspx) 

[Windows remote management Command-Line Tool\(winrmcmd\)](https://technet.microsoft.com/library/cc781778.aspx)

[WinRM IIS Extension Overview](https://technet.microsoft.com/library/dd759166.aspx)

[WS-management Protocol](https://msdn.microsoft.com/library/windows/desktop/aa384470.aspx)



  

