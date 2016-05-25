---
title: Datacenter Abstraction Layer (DAL) Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4cbcd83d-1760-479e-bc6e-094b8d3b313f
author: britw
---
# Datacenter Abstraction Layer (DAL) Overview
This topic provides overview information about the Datacenter Abstraction Layer \(DAL\). Within this topic you will find introductory information about the DAL: what the DAL is, and what it consists of. This topic also includes introductory information about how the DAL can be used to monitor and manage systems on your network, such as baseboard management controllers \(BMCs\), top\-of\-rack \(TOR\) switches, power distribution units \(PDUs\), and storage devices.  
  
**Did you mean…**  
  
-   [Hardware Abstraction Layer \(HAL\)](http://support.microsoft.com/kb/99588)  
  
-   [Windows Remote Management \(WinRM\)](http://msdn.microsoft.com/library/windows/desktop/aa384426(v=vs.85).aspx)  
  
-   [Microsoft.WSMan.Management Module](http://technet.microsoft.com/library/hh847832.aspx)  
  
-   [Configure Remote Management in Server Manager](http://technet.microsoft.com/library/hh921475.aspx)  
  
## <a name="BKMK_OVER"></a>DAL description  
Datacenter Abstraction Layer \(DAL\) is an extensible framework that provides a set of management infrastructure components and schemas that can emulate device\-specific details. DAL provides other management tools with direct access to the device management resources. The tools are standard and they can be automated, and Admins can use them without dealing with the complexity and specificity of the devices being managed.  
  
The following image shows the relationship between the applications and services that use the DAL \(shown in red\), the DAL \(shown in Blue\), and managed devices \(shown in green\):  
  
![](../Image/DAL_Overview_00.jpg)  
  
The DAL concept consists of a management infrastructure layer which implements the Common Information Model \(CIM\) as the modeling language, and Web Services for Management \(WS\-MAN\) as the preferred protocol.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], includes a lightweight, open\-source, cross\-platform, and scalable CIM object manager \(CIMOM\) architecture called Open Management Infrastructure \(OMI\). OMI implements CIM and WS\-Man as the base technologies for managing devices. The goal of OMI is to help device vendors expedite the adoption of CIM and WS\-Man as the basic technologies for data center device management.  
  
**Common Information Model**  
  
The Common Information Model \(CIM\) as defined by the Distributed Management Task Force \(DMTF\) provides the means to actively control and manage hardware and software resources. By using a common model of information, management software can work with many implementations of the common model, without complex and costly conversion operations or loss of information.  
  
CIM is a common definition of management information for a huge range of systems, networks, applications, and services. CIM defines the following:  
  
-   **Managed Object Format** \(MOF\): A language that is based on the interface description language \(IDL\), which is used to describe management objects  
  
-   **CIM Schema**: A standardized model of management objects that is written in MOF syntax \(for example, Processes, Computers, and Printers\)  
  
-   **CIM Profiles**: Collections of CIM models and associated behaviors for a particular management domain \(for example, Power, Virtualization, and Storage\)  
  
**WS\-MAN**  
  
WS\-MAN is designed to work with CIM objects to help perform all management operations securely and remotely. WS\-MAN is a Simple Object Access Protocol \(SOAP\) that is standardized by the DMTF based on:  
  
-   WS\-Addressing  
  
-   WS\-Transfer  
  
-   WS\-Enumerating  
  
-   WS\-Eventing  
  
-   WS\-MANagement CIM Binding Specification  
  
-   WS\-CIM Mapping Specification  
  
Windows Remote Management \(WinRM\) is the Microsoft implementation of WS\-MAN WinRM provides the following for clients and services:  
  
-   Windows PowerShell provider for configuration  
  
-   Windows PowerShell cmdlets to enable access to any remote management endpoint that implements WS\-MAN plus CIM  
  
-   Windows PowerShell remoting  
  
## <a name="BKMK_APP"></a>Practical applications  
As IT organizations consolidate, evolve, and operate as service providers for their customers, they must deploy service\-oriented infrastructures and management processes. Combined with the expansion of server and storage virtualization, the trend is increasingly placing pressure on organizations to provide greater levels of service while simultaneously reducing costs.  
  
Data centers today are made up of different classes of devices from a variety of device manufacturers. The rapid expansion of data centers and cloud computing increases the importance of consistently managing these devices. Prior to DAL, most of the devices in data centers were managed by using protocols and schemas, and for some, by proprietary solutions. The lack of a consistent management platform makes the task of management complicated, inefficient, and time consuming.  
  
For example, to meet its growing system and maintenance needs, Windows Azure acquires a variety of devices from a variety of manufacturers. The Windows Azure Fabric Controller is responsible for managing a variety of data center hardware such as blades, load balancers, PDUs, switches, and routers. Many of those devices are managed by using different protocols, schemas, and proprietary solutions in some instances. To simplify device management, Windows Azure includes a plug\-in system to abstract those complexities.  
  
Meeting the challenges that face complex, growing data center environments requires a management approach that is easy to use and facilitates end\-to\-end management operations. To address these issues, DAL provides a consistent developer abstraction layer to interact with the wide array of DAL\-compliant devices from a variety of vendors. This is similar to the hardware abstraction layer \(HAL\) that Windows provides for hardware application developers.  
  
**For system administrators**:  
  
DAL provides a consistent data center infrastructure management platform by using Windows PowerShell.  
  
For an example, let’s look at the job of an IT pro who is working for a cloud services vendor \(CSV\). This job involves collecting inventory information for the hardware in the data center and occasionally remotely troubleshooting or maintaining the hosts.  
  
These tasks present two challenges:  
  
1.  Some of the hardware supports Systems Management Architecture for Server Hardware \(SMASH\), some supports Intelligent Platform Management Interface \(IPMI\), and some hardware can use only the vendor proprietary protocols.  
  
2.  SMASH and WS\-MAN can be difficult to understand. The IT pro needs a simple task\-oriented way of doing things. The hardware management module in the data center cannot be used due to restrictions on scripts that are downloaded from Internet.  
  
Solution: [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] provides one set of Windows PowerShell cmdlets that can be used to manage all of the IPMI and SMASH\-based devices.  
  
**For developers**:  
  
DAL enables developers to invoke a CIM provider that provides a high\-level, task\-oriented abstraction by using the Windows Management Infrastructure with managed and native client APIs.  
  
For example, a developer on the Cloud Infrastructure Solution team is working on a cloud infrastructure solution deployment tool, which will be used to manage hardware. As per the reference architecture, the hardware can be managed by using IPMI or SMASH for. A list of the typical tasks for managing hardware includes:  
  
-   Setting the power state \(On or Off\)  
  
-   Changing the boot order \(persistent and one\-time\)  
  
-   Updating firmware  
  
-   Fetching event log entries from BMCs  
  
-   Providing a hardware inventory  
  
-   Creating firmware versions  
  
The developer can use the set of DAL APIs to provide a consistent experience across protocols. These APIs provide a layer of abstraction that completely hides the complexity and details of IPMI\- or SMASH\-based implementation.  
  
Summary of benefits provided by the DAL:  
  
-   Enables device management by using a common abstraction layer that provides standard protocol and schemas  
  
-   Helps data centers transition into a defined standards\-based management environment  
  
-   Provides a ready\-to\-use solution for device management in Windows, reducing the need for fabric controllers like the Microsoft System Center Virtual Machine Manager \(VMM\) and CIS to create custom solutions  
  
> [!NOTE]  
> For information about how properties that are exposed by the DAL are mapped to the values found on hardware devices and how to determine what properties are expected to have empty values when a warning is presented about absent profiles in Windows PowerShell, see [Physical Computer System View &#40;PCSV&#41; Property Mappings](../Topic/Physical-Computer-System-View--PCSV--Property-Mappings.md).  
  
## <a name="BKMK_NEW"></a>Important functionality  
This section provides brief summary information about DAL functionality.  
  
**Base management controllers:**  
  
The physical computer system profile \(PCSP\) uses the CIM to implement the basic functionality of the data center management interface. The PCSV is designed to provide a task\-based abstraction layer for compute node management.  
  
From the DAL perspective, the PCSP is capable of abstracting different BMC implementations.  
  
**Top\-of\-Rack**  
  
To managethe top\-of\-rack \(TOR\) switch, there is a new set of client APIs and Windows PowerShell cmdlets. It is possible for device vendors to implement the TOR CIM schema in their switches, based on CIM plus WS\-Man.  
  
Microsoft has collaborated with CISCO and Arista to implement a newly designed switch profile CIM schema into their switches by using the open\-source version of OMI.  
  
## <a name="BKMK_LINKS"></a>See also  
This section provides links to information that is relevant to the DAL.  
  
|Content type|References|  
|----------------|--------------|  
|**Product evaluation**|[Datacenter Abstraction Layer Center](http://technet.microsoft.com/cloud/dal.aspx)|  
|**Operations**|[PowerShell Out\-of\-Band Hardware Management Module](http://gallery.technet.microsoft.com/scriptcenter/PowerShell-Out-of-Band-84009c12)<br /><br />[In\-Band Management using IPMI and PowerShell](http://gallery.technet.microsoft.com/scriptcenter/In-Band-Management-using-88e221b8)<br /><br />For details about using the PCSV cmdlets in Windows PowerShell, see [Physical Computer System View \(PCSV\) Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/dn283380(v=wps.630).aspx)|  
|**Technical Reference**|[Physical Computer System View &#40;PCSV&#41; Property Mappings](../Topic/Physical-Computer-System-View--PCSV--Property-Mappings.md) provides details about how properties that are exposed by the DAL are mapped to the values found on the hardware devices. This document serves as a reference for hardware manufacturers and developers of management firmware to ensure that their implementation is consistent with the DAL management model. IT pros can use the tables to determine what properties are expected to have empty values when they see a warning about absent profiles in Windows PowerShell.|  
|**Tools and settings**|Content not available|  
|**Community resources**|Content not available|  
|**Related technologies**|[Open Management Infrastructure](http://blogs.technet.com/b/windowsserver/archive/2012/06/28/open-management-infrastructure.aspx)<br /><br />[Physical Computer System View Profile](http://dmtf.org/sites/default/files/standards/documents/DSP1108_1%200%200i.pdf) \(PCSVP\)<br /><br />[Systems Management Architecture for Server Hardware](http://dmtf.org/standards/smash)<br /><br />[Web Services for Management \(WS\-MANagement Specification](http://www.iso.org/iso/home/store/catalogue_tc/catalogue_detail.htm?csnumber=61138)<br /><br />[Software Defined Networking, Enabled in Windows Server 2012 and System Center 2012 SP1, Virtual Machine Manager](http://blogs.technet.com/b/windowsserver/archive/2012/08/22/software-defined-networking-enabled-in-windows-server-2012-and-system-center-2012-sp1-virtual-machine-manager.aspx)<br /><br />[Windows Management Infrastructure Blog](http://blogs.msdn.com/b/wmi/)|  
  
