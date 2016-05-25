---
title: SNMP
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d1f753d4-86a0-4083-b4cd-079476a07ac0
author: coreyp
---
# SNMP
SNMP has been deprecated. Instead, use the Common Information Model \(CIM\), which is supported by the WS\-Management web services protocol and implemented as Windows Remote Management.  
  
The Microsoft Windows Management Instrumentation \(WMI\) technology is the Microsoft implementation of the Distributed Management Task Force \(DMTF\) Web\-Based Enterprise Management \(WBEM\) initiative that extends the Common Information Model \(CIM\) to represent management objects in Windows\-based management environments. The Common Information Model, also a DMTF standard, is an extensible data model for logically organizing management objects in a consistent, unified manner in a managed environment.  
  
Based on the Common Information Model, WBEM is a DMTF initiative and technology that establishes management infrastructure standards and provides a standardized way to access information from various hardware and software management systems in an enterprise environment. Using WBEM standards, developers can create tools and technologies that reduce the complexity and costs of enterprise management. By providing such standards, WBEM contributes to industry\-wide efforts to lower total cost of ownership \(TCO\). TCO refers to the administrative costs associated with computer hardware and software purchases, deployment and configuration, hardware and software updates, training, maintenance, and technical support.  
  
WBEM provides a point of integration through which data from management sources can be accessed, and it complements and extends existing management protocols and instrumentation such as Simple Network Management Protocol \(SNMP\), Desktop Management Interface \(DMI\), and Common Management Information Protocol \(CMIP\).  
  
## Windows Management Instrumentation technology  
The Windows Management Instrumentation \(WMI\) technology is a management infrastructure that supports the syntax of CIM, the Managed Object Format \(MOF\), and a common programming interface. The MOF syntax defines the structure and contents of the CIM schema in human and machine\-readable form. Windows Management Instrumentation offers a powerful set of services, including query\-based information retrieval and event notification. These services and the management data are accessed through a Component Object Model \(COM\) programming interface. The WMI scripting interface also provides scripting support.  
  
The WMI technology provides:  
  
-   Access to monitor, command, and control any managed object through a common, unifying set of interfaces, regardless of the underlying instrumentation mechanism. WMI is an access mechanism.  
  
-   A consistent model of Windows operating system operation, configuration, and status.  
  
-   A COM Application Programming Interface \(API\) that supplies a single point of access for all management information.  
  
-   Interoperability with other Windows management services. This approach can simplify the process of creating integrated, well\-architected management solutions.  
  
-   A flexible, extensible architecture. Developers can extend the information model to cover new devices, applications, and so on, by writing code modules called WMI providers.  
  
-   Extensions to the Windows Driver Model \(WDM\) to capture instrumentation data and events from device drivers and kernel\-side features.  
  
-   A powerful event architecture. This allows management information changes to be identified, aggregated, compared, and associated with other management information. These changes can also be forwarded to local or remote management applications.  
  
-   A rich query language that enables detailed queries of the information model.  
  
-   A scriptable API which developers can use to create management applications. The scripting API supports several languages, including Microsoft Visual Basic; Visual Basic for Applications \(VBA\); Visual Basic, Scripting Edition \(VBScript\); and Microsoft JScript development software. Besides VBScript and JScript, developers can use any scripting language implementation that supports Microsoft ActiveX scripting technologies with this API \(for example, a Perl scripting engine\). Additionally, you can use the Windows Script Host or Microsoft Internet Explorer to write scripts using this interface. Windows Script Host, like Internet Explorer, serves as a controller engine of ActiveX scripting engines. Windows Script Host supports scripts written in VBScript and JScript.  
  
## WMI architecture overview  
The WMI technology architecture consists of the following:  
  
-   A management infrastructure \- This includes the CIM Object Manager, which provides applications with uniform access to management data and a central storage area for management data called the CIM Object Manager repository.  
  
-   WMI Providers \- These function as intermediaries between the CIM Object Manager and managed objects. Using the WMI APIs, providers supply the CIM Object Manager with data from managed objects, handle requests on behalf of management applications, and generate event notifications.  
  
The management infrastructure consists of the CIM Object Manager and the CIM Object Manager repository. Applications depend on the Object Manager to handle the interface between management applications and data providers. WMI facilitates these communications by providing a common programming interface to Windows management services using COM. This COM API supplies event notification and query processing services, and can be used in several programming language environments such as C and C\+\+. The CIM Object Manager repository holds the CIM and extension schemas, and data information or data source details. The CIM Object Manager uses the schema data in this repository when servicing requests from management applications for managed objects.  
  
**Managed objects** are either physical or logical enterprise features that are modeled using CIM. For example, a managed object can be hardware such as a cable, or software such as a database application. Management applications can access managed objects through the CIM Object Manager.  
  
**Management applications** are applications or Windows services that use or process information originating from managed objects. Management applications can access managed object information by making a request to the CIM Object Manager through one of the methods in the WMI API.  
  
**WMI providers** are standard COM and Distributed Component Object Model \(DCOM\) servers that function as mediators between managed objects and the CIM Object Manager. If the CIM Object Manager receives a request from a management application for data that is not available from the CIM Object Manager repository or for event notifications that are not supported by the CIM Object Manager, it forwards the request to a WMI provider. Providers supply data and event notifications for managed objects that are specific to their particular domain.  
  
To implement a provider, you should use one of the following supported server types:  
  
-   Microsoft Windows Server services, local or remote  
  
-   Standard executables \(.exe files\), local or remote  
  
-   In\-process dynamic\-link libraries \(DLLs\)  
  
Note that local or remote Windows Server services and standard executables are recommended server types.  
  
WMI ships with built\-in providers \(or standard providers\) that supply data from sources such as the system registry. The built\-in providers include:  
  
-   **Active Directory Provider** \- Acts as a gateway to all the information stored in the Active Directory service. Allows information from both WMI and Active Directory to be accessed by using a single API.  
  
-   **Windows Installer Provider** \- Allows complete control of Windows Installer and installation of software through WMI. Also supplies information about any application installed with Windows Installer.  
  
-   **Performance Counter Provider** \- Exposes the raw performance counter information used to compute the performance values shown in the System Monitor tool. Any performance counters installed on a system will automatically be visible through this provider.  
  
-   **Registry Provider** \- Allows Registry keys to be created, read, and written. WMI events can be generated when specified Registry keys are modified.  
  
-   **SNMP Provider** \- Acts as a gateway to systems and devices that use the Simple Network Management Protocol \(SNMP\) for management. SNMP MIB object variables can be read and written. SNMP traps can be automatically mapped to WMI events.  
  
-   **Event Log Provider** \- Provides access to data and event notifications from the Windows Server Event Log.  
  
-   **Win32 Provider** \- Provides information about the operating system, computer system, peripheral devices, file systems, and security information.  
  
-   **WDM Provider** \- Supplies low\-level Windows Driver Model driver information for user input devices, storage devices, network interfaces, and communications ports.  
  
-   **View Provider** \- Allows new aggregated classes to be built up from existing classes. Source classes can be filtered for only the information of interest, information from multiple classes can be combined into a single class, and data from multiple computers can be aggregated into a single view.  
  
The WMI technology also provides support for third\-party custom providers. Custom providers can be used to service requests related to managed objects that are environment\-specific. Providers typically use the MOF language to define and create classes. Providers use the WMI API to access the CIM Object Manager repository, and to respond to CIM Object Manager requests made initially by applications.  
  
### Simple Network Management Protocol overview  
Simple Network Management Protocol \(SNMP\) is a network management standard that defines a strategy for managing TCP\/IP networks.  
  
SNMP uses a distributed architecture that includes:  
  
-   Multiple managed nodes, each with an SNMP entity called an agent which provides remote access to management instrumentation.  
  
-   At least one SNMP entity referred to as a manager which runs management applications to monitor and control managed elements. Managed elements are devices such as hosts, routers, and so on; they are monitored and controlled by accessing their management information.  
  
-   A management protocol, SNMP, is used to convey management information between the management stations and agents. Management information refers to a collection of managed objects that reside in a virtual information store called a Management Information Base \(MIB\).  
  
### SNMP messages  
To communicate host information, management systems and agents use SNMP messages. These messages are sent using the User Datagram Protocol \(UDP\) and are routed between the management system and host by using the Internet Protocol \(IP\).  
  
A Management Information Base contains the information requested by the management system. The MIB for a networked computer may include information about the configuration and performance of the network interface card, the available hard drive space, the version of drivers and applications, and so on. Additional MIBs may be written and loaded, to expose the data that is specified for collection, as long as the system itself supports the collection of the requested information.  
  
#### Processing information requests  
When a management system requests information, the following sequence occurs:  
  
1.  A management system sends a request to an agent using the agent's IP address.  
  
2.  The agent forms an SNMP datagram that contains an SNMP message and the community name to which the management system belongs.  
  
3.  The SNMP agent receives the datagram and confirms the community name. If the community name is valid, the SNMP agent retrieves the appropriate data. Otherwise, if the community name is invalid, the request is rejected. If the agent has been configured to send an authentication trap, a trap message is sent.  
  
4.  The SNMP datagram is returned to the management system with the requested information.  
  
#### Messages  
The following SNMP message types are used:  
  
-   **GetThis** is a request message. SNMP management systems use Get messages to request information about a MIB entry on an SNMP agent.  
  
-   **Getnext** is a type of request message that can be used to browse an entire tree of managed objects.  
  
-   **Getbulk** is a type of request that specifies that the agent transfer as much data as possible, within the limits of message size.  
  
-   **SetThis** is used to send and assign an updated MIB value to an agent.  
  
-   **Notify \(or Trap\)** is an unsolicited message that an agent sends to an SNMP management system when it detects a certain type of event has occurred locally on the managed host.  
  
SNMP events \(or traps\) are sent unsolicited to a management station that filters the events; therefore, network traffic is involved. With WMI, the events are filtered locally and only those passing the filter criteria are sent over the network, thus reducing the required bandwidth for events of interest.  
  
### WMI SDK support for SNMP  
The SNMP Provider includes the following features:  
  
-   Class, instance, and event Providers that integrate the SNMP information modeling and processing into WMI. These SNMP providers map collections of object values to property values of CIM class instances.  
  
-   An SNMP information module compiler that compiles native SNMP schema information into the format that CIM uses.  
  
#### SNMP Providers  
The SNMP Providers return dynamic information. You can specify the set of classes that the instance Provider will operate against in one of two ways:  
  
-   Statically \- By creating classes in the CIM object repository namespace associated with the proxy device.  
  
-   Dynamically \- By using the SNMP class Provider, which returns the set of classes located within the SNMP Module Information Repository \(SMIR\) namespace.  
  
Additionally, you can also specify whether to use correlation for the set of classes returned from the SMIR namespace. Correlated classes define the set of classes that a given SNMP agent is known to support at the time the enumeration occurs. Noncorrelated enumeration returns all classes present within the SMIR namespace, regardless of whether the agent device supports them or not.  
  
The SNMP Providers include:  
  
-   SNMP class and instance providers, which applications use to access and modify data pertaining to SNMP devices.  
  
-   SNMP event providers, which generate events from SNMP traps and notifications. These report the same types of events, but in different formats: Encapsulated and Referent.  
  
    -   **Encapsulated** means that the event class has simple properties describing the information mapped directly from the TRAP\-TYPE and NOTIFICATION\-TYPE macros, described in the next section.  
  
    -   **Referent**  classes abstract the information present within the macros so that properties which share the same class and instance are presented as embedded objects. This allows extraction of the \_\_RELPATH so that the unique instance to which the trap is associated can be retrieved after the receipt of the event. To choose a format, consumers register for a particular class of events.  
  
#### Mapping device data to CIM classes  
The SNMP Providers map device data to CIM classes through the following methods:  
  
-   **Enumerating SNMP Class Definitions.** To enumerate a set of class definitions, applications can call IWbemServices::CreateClassEnum or IWbemServices::CreateClassEnumAsync.  
  
    MIB objects are mapped to SNMP CIM classes by using the OBJECT\-TYPE macro; events are mapped to classes by using the TRAP\-TYPE and NOTIFICATION\-TYPE macros.  
  
    The OBJECT\-TYPE macro is used to describe the basic characteristics of a MIB object. The SNMPv1 TRAP\-TYPE and SNMPv2C NOTIFICATION\-TYPE macros describe the characteristics of an SNMP event.  
  
-   **Instantiating SNMP Class Definitions.** To instantiate a class definition, applications can call IWbemServices::GetObject or IWbemServices::GetObjectAsync.  
  
-   **Enumerating SNMP Class Instances.** The SNMP instance Provider services requests to enumerate instances associated with classes that represent device MIBs.  
  
-   **Instantiating SNMP Class Instances.** The SNMP instance Provider processes requests to instantiate instances of classes that represent MIB objects.  
  
-   **Retrieving SNMP Class Instances.** To retrieve a particular instance of a SNMP CIM class, applications can call IWbemServices::GetObject or IWbemServices::GetObjectAsync.  
  
#### SNMP and the CIM schema  
The schema that SNMP uses to define objects differs from that used in the WMI Common Information Model. The SNMPv1 and SNMPv2 schema is called the Structure of Management Information \(SMI\); it is packaged as MIB files. To define objects, the MIB files use Abstract Syntax Notation 1 \(ASN.1\), a standard language, and macro definitions that are used as templates for describing the objects. These macros supply information about the object, including its name, identifier, syntax, description, access rights, and so on.  
  
The WMI SNMP Providers convert these MIB macros:  
  
-   **OBJECT\-TYPE** \- Describes the basic characteristics of an object, such as the object name, syntax, access rights, and so forth. Pertains to SNMPv1 and SNMPv2C.  
  
-   **TEXTUAL\-CONVENTION** \- Assigns a name and, in some cases, a range of values to an existing data type. Pertains to SNMPv2C only.  
  
-   **TRAP\-TYPE** \- Describes event messages \(traps\). Pertains to SNMPv1 only.  
  
-   **NOTIFICATION\-TYPE** \- Describes event messages \(notifications\). Pertains to SNMPv2C only.  
  
The SNMP class Provider enumerates and instantiates a set of class definitions against a CIM namespace. It does so by using a MIB correlator and the SNMP Module Information Repository, an SNMP schema database. The SNMP class Provider supports correlated and non\-correlated modes. You designate one of these modes by setting a context value \(IWbemContext\) correlate of type Boolean and passing this into the IWbemServices method. The SNMP class provider supports both enumeration of class definitions and retrieval of a class definition.  
  
The SNMP instance provider maps SNMP MIB objects to class instances.  
  
#### SNMP namespace  
To define a view of a network device, an SNMP namespace is used. You can create an SNMP namespace by using the WMI SDK's WMI Common Information \(CIM\) Studio application, by compiling a MOF file, or programmatically with the WMI API.  
  
The Namespace system class is used to represent an SNMP namespace. To generate a new namespace, you create an instance of this class. You must associate at least one descriptor \(or qualifier\) with the class instance. The qualifiers contain implementation\-specific context information, and transport properties that define how the SNMP Providers access an SNMP agent.  
  
### SNMP device representation  
SNMP devices are represented within WMI by using a proxy namespace that contains a set of instance qualifiers. These qualifiers describe the transport characteristics pertaining to the device. WMI uses a MOF file, snmpreg.mof, to create the \\\\.\\root\\snmp\\localhost namespace; this is a standard namespace that represents the local SNMP agent.  
  
#### SNMPv2C  
SNMPv2C is supported within the WMI context. The main purpose of SNMPv2C was to provide a stronger security context for SNMP. This version uses the simple and unsecure password\-based authentication feature, known as the community feature \(provided in SNMPv1\). The SNMPv2 SMI makes certain additions and enhancements to the community security, such as including bit strings, network addresses, and counters to the SNMPv1 SMI specific data types. Additionally, the SNMPv2 SMI specifies information modules, which specify a group of related definitions. SNMPv2 also defines two new protocol operations: GetBulk and Inform.  
  
#### Security  
WMI security validates a user's logon information both for the local computer and for remote access. WMI grants a validated user some form of controlled access to the entire CIM repository. In its current release, WMI does not provide security for system resources such as individual classes and instances. However, administrators can use WMI to control global permissions on schema operations, such as limiting the access of some users to read\-only operations. WMI also supports per namespace security. In addition, the SNMP Provider provides support for all SNMP\-based security, including the security enhancements in SNMPv2C.  
  
#### SNMP information module compiler  
The SNMP information module compiler is used to compile native SNMP management information that is defined in a MIB into an equivalent CIM schema definition that can be used with the SNMP Providers. The CIM schema can exist as output in a MOF file or it can be loaded into an SNMP schema database \(the SNMP Module Information Repository or SMIR\). The SNMP dynamic class Provider uses the SNMP Module Information Repository to create and retrieve instances of class definitions.  
  
The SNMP information module compiler runs in command\-line mode as an executable file, using one SNMP information module as input, and any additional files that might be needed to resolve external references. SNMP information modules are collections of management information that typically consist of a combination of MIB modules, and AGENT\-CAPABILITIES and MODULE\-COMPLIANCE statements. AGENT\-CAPABILITIES statements describe an agent's compliance to the set of MIB modules it supports. MODULE\-COMPLIANCE statements describe an agent's capabilities regarding object definitions.  
  
The SNMP information module compiler also provides the following functionality:  
  
-   Performs checking operations on the information module. For example, it checks local syntax and external references against information in the subsidiary modules.  
  
-   Removes all previously loaded data from the SMIR, or removes data loaded from one information module.  
  
-   Returns either the ASN.1 module name of a specified file, or the ASN.1 module names of all imported modules in a specified file.  
  
-   Returns the ASN.1 module names of all SNMP information modules currently loaded in the SMIR.  
  
-   Performs automatic resolution of imported modules instead of requiring users to manually specify the required modules.  
  
-   Performs a silent\-loading mode of operation that does not generate output, but can be used to load data into the SMIR during an installation operation.  
  
