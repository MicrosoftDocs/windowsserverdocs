---
title: Windows management Instrumentation (WMI) Overview
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fc74bc7b-b753-47dc-9b18-3808a9757042
---
# Windows management Instrumentation (WMI) Overview
Windows management Instrumentation \(WMI\) is an infrastructure for management data and operations on Windows-based operating systems. You can use WMI to access management information in an enterprise environment.

This topic gives an overview about WMI, and has links to additional information.

## What is WMI?
WMI defines a set of enterprise-level management standards that work with other existing management standards, such as Simple Network management Protocol \(SNMP\) and Desktop management Interface \(DMI\). WMI complements these other management standards by providing a uniform management model. This uniform model provides a common way to access management data from any WMI-enabled source in a managed environment.

Many Windows features have associated WMI providers. Examples of WMI providers include: Boot Configuration Data \(Bcd\) Provider, Domain Name System \(DNS\) Provider, ping Provider and Win32 Provider. WMI Providers implement the functionality described by WMI classes, methods, and properties to manage associated Windows features.

WMI provides an interface through which instrumented Windows components, such as: Event Tracing for Windows \(ETW\), NetTCPIP, and Group Policy API, can manage computer systems and render system-management information and notifications.

But it is the ability to manage, and to retrieve management data from remote computers that makes WMI especially useful. You can make remote WMI connections through Distributed component Object model \(DCOM\). Alternately, you can use Windows remote management \(WinRM\), which gets remote WMI management data using the WS-management - Simple Object Access Protocol \(SOAP\)-based protocol.

WMI offers a simple interface to management data that includes:
- A rich and consistent model of the Windows operating system's behavior, configuration, and status.
- A COM API that supplies a single point of access to all management information.
- A flexible architecture that enables vendors to extend the information model to cover new devices, applications, and services.
- A rich query language that enables SQL-based queries of the information model.
- A scriptable API that allows seamless local and remote system administration.

The WMI behavior can be modified in:
- *Server manager/Tools/computer management/Services*
- *Applications/WMI Control*
- *Server manager/Tools/Group Policy management/forest: \(forestName\)/domains/DomainName/WMI Filters*

## Practical applications:
By viewing and making changes to a Common Information model \(CIM\) class, you can control different aspects of the enterprise. for example, you could query a CIM class instance representing a specific desktop workstation. You could then run a script to modify the CIM workstation instance. WMI then translates any change to the workstation CIM class instance into an actual change to that workstation.

## Related standards:
**WMI** is the Microsoft implementation of the Web-Based Enterprise management \(WBEM\)  and Common Information model \(CIM\) standards defined by the Distributed management Task force \(DMTF\).

**WBEM** is an industry initiative to develop a standardized, nonproprietary means for accessing and sharing management information in an enterprise network. WBEM is intended to alleviate the problems usually associated with collecting management and diagnostic data from different types of hardware, protocols, operating systems, and distributed applications.

**CIM** is an extensible, object-oriented data model that contains information about different parts of an enterprise. Through WMI, developers can use CIM to create classes that represent hard disk drives, applications, network routers, or even user-defined technologies such as a networked air conditioner.

CIM is developed and maintained by the Distributed management Task force (DMTF). WMI uses the CIM industry standard to represent systems, applications, networks, devices, and other managed components.

## additional technical resources:
[Common Information model \(CIM\)](http://www.dmtf.org/standards/cim)

[Distributed management Task force \(DMTF\)](http://www.dmtf.org/)

[Getting started with Windows powershell](https://technet.microsoft.com/library/hh857337.aspx)

[managed Reference for WMI Windows powershell Command Classes](https://msdn.microsoft.com/library/windows/desktop/ee309379.aspx)

[Probing the Depths of WMI, a Hey, Scripting Guy article](https://technet.microsoft.com/magazine/2008.11.heyscriptingguy.aspx)

[Scripting access to WMI](https://msdn.microsoft.com/library/windows/desktop/aa393256.aspx) 

[WBEM](http://www.dmtf.org/standards/wbem)

[Windows management Instrumentation](https://msdn.microsoft.com/library/windows/desktop/aa394582.aspx)  

[Windows remote management \(WinRM\)](https://msdn.microsoft.com/library/windows/desktop/aa384426.aspx)

[WMI Classes](https://msdn.microsoft.com/library/windows/desktop/aa394554.aspx)

[WMI Glossary](https://msdn.microsoft.com/library/windows/desktop/aa394561.aspx)

[WMI/MI/OMI Providers](https://msdn.microsoft.com/library/windows/desktop/bg126473.aspx)

[WMI Providers](https://msdn.microsoft.com/library/windows/desktop/aa394570.aspx)

[WMI Scripting Primer: Part 1](https://msdn.microsoft.com/library/ms974579.aspx)

[WMI Scripting Primer: Part 2](https://msdn.microsoft.com/library/ms974592.aspx)

[WMI Scripting Primer: Part 3](https://msdn.microsoft.com/library/ms974547.aspx)

[WMI Troubleshooting and Tips](https://technet.microsoft.com/library/ee692772.aspx)




  

