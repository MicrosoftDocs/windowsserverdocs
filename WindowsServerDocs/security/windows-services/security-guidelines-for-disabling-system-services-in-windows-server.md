---
title: Security guidelines for system services in Windows Server 2016
description: Provides security guidelines and recommendations for disabling services in Windows Server 2016 with Desktop Experience.
ms.topic: article
ms.date: 11/26/2018
ms.assetid: b886b2fd-3567-4f0a-8aa3-4ba7923d2d21
author: nirb
ms.author: wscontent
---

# Guidance on disabling system services on Windows Server 2016 with Desktop Experience

>Applies to: Windows Server 2016 only, when used in Desktop Experience installation option

The Windows operating system includes many system services that provide important functionality. Different services have different default startup policies: some are started by default (automatic), some when needed (manual), and some are disabled by default and must be explicitly enabled before they can run. These defaults were chosen carefully for each service to balance performance, functionality, and security for typical customers.

However, some enterprise customers may prefer a more security-focused balance for their Windows PCs and servers, one that reduces their attack surface to the absolute minimum, and may therefore wish to fully disable all services that are not needed in their specific environments. For those customers, Microsoft&reg; is providing the accompanying guidance regarding which services can safely be disabled for this purpose.

The guidance is only for Windows Server 2016 with Desktop Experience (unless used as a desktop replacement for end users). Beginning with Windows Server 2019, these guidelines are configured by default. Each service on the system is categorized as follows:

- **Should Disable:** A security-focused enterprise will most likely prefer to disable this service and forego its functionality (see additional details below).
- **OK to Disable:** This service provides functionality that is useful to some but not all enterprises, and security-focused enterprises that don't use it can safely disable it.
- **Do Not Disable:** Disabling this service will impact essential functionality or prevent specific roles or features from functioning correctly. Therefore it should not be disabled.
- **(No guidance):** The impact of disabling these services has not been fully evaluated. Therefore, the default configuration of these services should not be changed.

Customers can configure their Windows PCs and servers to disable selected services using the Security Templates in their Group Policies or using PowerShell automation. In some cases, the guidance includes specific Group Policy settings that disable the service's functionality directly, as an alternative to disabling the service itself.

Microsoft recommends that customers disable the following services and their respective scheduled tasks on Windows Server 2016 with Desktop Experience:

Services:
1. Xbox Live Auth Manager
2. Xbox Live Game Save

Scheduled tasks:
1. \Microsoft\XblGameSave\XblGameSaveTask
2. \Microsoft\XblGameSave\XblGameSaveTaskLogon


### Disabling services not installed by default

Microsoft recommends against applying policies to disable services that are not installed by default.
- The service is usually needed if the feature is installed. Installing the service or the feature requires administrative rights. Disallow the feature installation, not the service startup.
- Blocking the Microsoft Windows service doesn't stop an admin (or non-admin in some cases) from installing a similar third-party equivalent, perhaps one with a higher security risk.
- A baseline or benchmark that disables a non-default Windows service (for example, W3SVC) will give some auditors the mistaken impression that the technology (for example, IIS) is inherently insecure and should never be used.
- If the feature (and service) is never installed, this just adds unnecessary bulk to the baseline and to verification work.

For all system services listed in this document, the two tables that follow offer an explanation of columns and Microsoft recommendations for enabling and disabling system services in Windows Server 2016 with Desktop Experience:

### Explanation of columns

| Name | Description |
|--|--|
| **Service name** | Key (internal) name of the service |
| **Description** | The service's description, from sc.exe qdescription. |
| **Installation** | *Always installed*: Service is installed on Windows Server 2016 Core and Windows Server 2016 with Desktop Experience. *Only with Desktop Experience*: Service is on Windows Server 2016 with Desktop Experience, but is ***not*** installed on Server Core. |
| **Startup type** | Service Startup type on Windows Server 2016 |
| **Recommendation** | Microsoft recommendation/advice about disabling this service on Windows Server 2016 in a typical, well-managed enterprise deployment and where the server is not being used as an end-user desktop replacement. |
| **Comments** | Additional explanation |

### Explanation of Microsoft recommendations

| Name | Description |
|--|--|
| **Do not disable** | This service should not be disabled |
| **OK to disable** | This service can be disabled if the feature it supports is not being used. |
| **Already disabled** | This service is disabled by default; no need to enforce with policy |
| **Should be disabled** | This service should never be enabled on a well-managed enterprise system. |

The following tables offer Microsoft guidance on disabling system services on Windows Server 2016 with Desktop Experience:


## ActiveX Installer (AxInstSV)

| Name | Description |
|--|--|
| **Service name** | AxInstSV |
| **Description** | Provides User Account Control validation for the installation of ActiveX controls from the Internet and enables management of ActiveX control installation based on Group Policy settings. This service is started on demand and if disabled the installation of ActiveX controls will behave according to default browser settings. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | OK to disable if feature not needed |

## AllJoyn Router Service

| Name | Description |
|--|--|
| **Service name** | AJRouter |
| **Description** | Routes AllJoyn messages for the local AllJoyn clients. If this service is stopped the AllJoyn clients that do not have their own bundled routers will be unable to run. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## App Readiness

| Name | Description |
|--|--|
| **Service name** | AppReadiness |
| **Description** | Gets apps ready for use the first time a user signs in to this PC and when adding new apps. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | None |

## Application Identity

| Name | Description |
|--|--|
| **Service name** | AppIDSvc |
| **Description** | Determines and verifies the identity of an application. Disabling this service will prevent AppLocker from being enforced. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## Application Information

| Name | Description |
|--|--|
| **Service name** | Appinfo |
| **Description** | Facilitates the running of interactive applications with additional administrative privileges. If this service is stopped, users will be unable to launch applications with the additional administrative privileges they may require to perform desired user tasks. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | Supports UAC same-desktop elevation |

## Application Layer Gateway Service

| Name | Description |
|--|--|
| **Service name** | ALG |
| **Description** | Provides support for third-party protocol plug-ins for Internet Connection Sharing |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## Application Management

| Name | Description |
|--|--|
| **Service name** | AppMgmt |
| **Description** | Processes installation, removal, and enumeration requests for software deployed through Group Policy. If the service is disabled, users will be unable to install, remove, or enumerate software deployed through Group Policy. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## AppX Deployment Service (AppXSVC)

| Name | Description |
|--|--|
| **Service name** | AppXSvc |
| **Description** | Provides infrastructure support for deploying Store applications. This service is started on demand and if disabled Store applications will not be deployed to the system, and may not function properly. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## Auto Time Zone Updater

| Name | Description |
|--|--|
| **Service name** | tzautoupdate |
| **Description** | Automatically sets the system time zone. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Disabled |
| **Recommendation** | Already disabled |
| **Comments** | None |

## Background Intelligent Transfer Service

| Name | Description |
|--|--|
| **Service name** | BITS |
| **Description** | Transfers files in the background using idle network bandwidth. If the service is disabled, then any applications that depend on BITS, such as Windows Update or MSN Explorer, will be unable to automatically download programs and other information. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## Background Tasks Infrastructure Service

| Name | Description |
|--|--|
| **Service name** | BrokerInfrastructure |
| **Description** | Windows infrastructure service that controls which background tasks can run on the system. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |

## Base Filtering Engine

| Name | Description |
|--|--|
| **Service name** | BFE |
| **Description** | The Base Filtering Engine (BFE) is a service that manages firewall and Internet Protocol security (IPsec) policies and implements user mode filtering. Stopping or disabling the BFE service will significantly reduce the security of the system. It will also result in unpredictable behavior in IPsec management and firewall applications. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |

## Bluetooth Support Service

| Name | Description |
|--|--|
| **Service name** | bthserv |
| **Description** | The Bluetooth service supports discovery and association of remote Bluetooth devices. Stopping or disabling this service may cause already installed Bluetooth devices to fail to operate properly and prevent new devices from being discovered or associated. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | OK to disable if not used. Another disabling mechanism: [Disabling Bluetooth and Infrared Beaming](/previous-versions/tn-archive/dd252791(v=technet.10)) |

## CDPUserSvc

| Name | Description |
|--|--|
| **Service name** | CDPUserSvc |
| **Description** | This user service is used for Connected Devices Platform scenarios |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Automatic |
| **Recommendation** | OK to disable |
| **Comments** | User service template |

## Certificate Propagation

| Name | Description |
|--|--|
| **Service name** | CertPropSvc |
| **Description** | Copies user certificates and root certificates from smart cards into the current user's certificate store, detects when a smart card is inserted into a smart card reader, and if needed, installs the smart card Plug and Play minidriver. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## Client License Service (ClipSVC)

| Name | Description |
|--|--|
| **Service name** | ClipSVC |
| **Description** | Provides infrastructure support for the Microsoft Store. This service is started on demand and if disabled applications bought using Microsoft Store will not behave correctly. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## CNG Key Isolation

| Name | Description |
|--|--|
| **Service name** | KeyIso
| **Description** | The CNG key isolation service is hosted in the LSA process. The service provides key process isolation to private keys and associated cryptographic operations as required by the Common Criteria. The service stores and uses long-lived keys in a secure process complying with Common Criteria requirements.
| **Installation** | Always installed
| **Startup type** | Manual
| **Recommendation** | No guidance
| **Comments** | None |

## COM+ Event System

| Name | Description |
|--|--|
| **Service name** | EventSystem |
| **Description** | Supports System Event Notification Service (SENS), which provides automatic distribution of events to subscribing Component Object Model (COM) components. If the service is stopped, SENS will close and will not be able to provide logon and logoff notifications. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |

## COM+ System Application

| Name | Description |
|--|--|
| **Service name** | COMSysApp |
| **Description** | Manages the configuration and tracking of Component Object Model (COM)+-based components. If the service is stopped, most COM+-based components will not function properly. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## Computer Browser

| Name | Description |
|--|--|
| **Service name** | Browser |
| **Description** | Maintains an updated list of computers on the network and supplies this list to computers designated as browsers. If this service is stopped, this list will not be updated or maintained. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Disabled |
| **Recommendation** | Already disabled |
| **Comments** | None |

## Connected Devices Platform Service

| Name | Description |
|--|--|
| **Service name** | CDPSvc |
| **Description** | This service is used for Connected Devices and Universal Glass scenarios |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |

## Connected User Experiences and Telemetry

| Name | Description |
|--|--|
| **Service name** | DiagTrack |
| **Description** | The Connected User Experiences and Telemetry service enables features that support in-application and connected user experiences. Additionally, this service manages the event-driven collection and transmission of diagnostic and usage information (used to improve the experience and quality of the Windows Platform) when the diagnostics and usage privacy option settings are enabled under Feedback and Diagnostics. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |

## Contact Data

| Name | Description |
|--|--|
| **Service name** | PimIndexMaintenanceSvc |
| **Description** | Indexes contact data for fast contact searching. If you stop or disable this service, contacts might be missing from your search results. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | User service template |

## CoreMessaging

| Name | Description |
|--|--|
| **Service name** | CoreMessagingRegistrar |
| **Description** | Manages communication between system components. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |

## Credential Manager

| Name | Description |
|--|--|
| **Service name** | VaultSvc |
| **Description** | Provides secure storage and retrieval of credentials to users, applications and security service packages. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## Cryptographic Services

| Name | Description |
|--|--|
| **Service name** | CryptSvc |
| **Description** | Provides three management services: Catalog Database Service, which confirms the signatures of Windows files and allows new programs to be installed; Protected Root Service, which adds and removes Trusted Root Certification Authority certificates from this computer; and Automatic Root Certificate Update Service, which retrieves root certificates from Windows Update and enable scenarios such as SSL. If this service is stopped, these management services will not function properly. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |

## Data Sharing Service

| Name | Description |
|--|--|
| **Service name** | DsSvc |
| **Description** | Provides data brokering between applications. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## DataCollectionPublishingService

| Name | Description |
|--|--|
| **Service name** | DcpSvc |
| **Description** | The DCP (Data Collection and Publishing) service supports first-party apps to upload data to cloud. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## DCOM Server Process Launcher

| Name | Description |
|--|--|
| **Service name** | DcomLaunch |
| **Description** | The DCOMLAUNCH service launches COM and DCOM servers in response to object activation requests. If this service is stopped or disabled, programs using COM or DCOM will not function properly. It is strongly recommended that you have the DCOMLAUNCH service running. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |

## Device Association Service

| Name | Description |
|--|--|
| **Service name** | DeviceAssociationService |
| **Description** | Enables pairing between the system and wired or wireless devices. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## Device Install Service

| Name | Description |
|--|--|
| **Service name** | DeviceInstall |
| **Description** | Enables a computer to recognize and adapt to hardware changes with little or no user input. Stopping or disabling this service will result in system instability. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## Device Management Enrollment Service

| Name | Description |
|--|--|
| **Service name** | DmEnrollmentSvc |
| **Description** | Performs Device Enrollment Activities for Device Management |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## Device Setup Manager

| Name | Description |
|--|--|
| **Service name** | DsmSvc |
| **Description** | Enables the detection, download and installation of device-related software. If this service is disabled, devices may be configured with outdated software, and may not work correctly. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## DevQuery Background Discovery Broker

| Name | Description |
|--|--|
| **Service name** | DevQueryBroker |
| **Description** | Enables apps to discover devices with a backgroud task |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## DHCP Client

| Name | Description |
|--|--|
| **Service name** | Dhcp |
| **Description** | Registers and updates IP addresses and DNS records for this computer. If this service is stopped, this computer will not receive dynamic IP addresses and DNS updates. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |

## Diagnostic Policy Service

| Name | Description |
|--|--|
| **Service name** | DPS |
| **Description** | The Diagnostic Policy Service enables problem detection, troubleshooting and resolution for Windows components. If this service is stopped, diagnostics will no longer function. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |

## Diagnostic Service Host

| Name | Description |
|--|--|
| **Service name** | WdiServiceHost |
| **Description** | The Diagnostic Service Host is used by the Diagnostic Policy Service to host diagnostics that need to run in a Local Service context. If this service is stopped, any diagnostics that depend on it will no longer function. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## Diagnostic System Host

| Name | Description |
|--|--|
| **Service name** | WdiSystemHost |
| **Description** | The Diagnostic System Host is used by the Diagnostic Policy Service to host diagnostics that need to run in a Local System context. If this service is stopped, any diagnostics that depend on it will no longer function. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## Distributed Link Tracking Client

| Name | Description |
|--|--|
| **Service name** | TrkWks |
| **Description** | Maintains links between NTFS files within a computer or across computers in a network. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |

## Distributed Transaction Coordinator

| Name | Description |
|--|--|
| **Service name** | MSDTC |
| **Description** | Coordinates transactions that span multiple resource managers, such as databases, message queues, and file systems. If this service is stopped, these transactions will fail. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |

## dmwappushsvc

| Name | Description |
|--|--|
| **Service name** | dmwappushservice |
| **Description** | WAP Push Message Routing Service |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | Service required on client devices for Intune, MDM and similar management technologies, and for Unified Write Filter. Not needed for Server. |

## DNS Client

| Name | Description |
|--|--|
| **Service name** | Dnscache |
| **Description** | The DNS Client service (dnscache) caches Domain Name System (DNS) names and registers the full computer name for this computer. If the service is stopped, DNS names will continue to be resolved. However, the results of DNS name queries will not be cached and the computer's name will not be registered. If the service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |

## Downloaded Maps Manager

| Name | Description |
|--|--|
| **Service name** | MapsBroker |
| **Description** | Windows service for application access to downloaded maps. This service is started on-demand by application accessing downloaded maps. Disabling this service will prevent apps from accessing maps. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Automatic |
| **Recommendation** | OK to disable |
| **Comments** | Disabling breaks apps that rely on the service; OK to disable if apps not relying on it |

## Embedded Mode

| Name | Description |
|--|--|
| **Service name** | embeddedmode |
| **Description** | The Embedded Mode service enables scenarios related to Background Applications. Disabling this service will prevent Background Applications from being activated. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## Encrypting File System (EFS)

| Name | Description |
|--|--|
| **Service name** | EFS |
| **Description** | Provides the core file encryption technology used to store encrypted files on NTFS file system volumes. If this service is stopped or disabled, applications will be unable to access encrypted files. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |

## Enterprise App Management Service

| Name | Description |
|--|--|
| **Service name** | EntAppSvc |
| **Description** | Enables enterprise application management. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Extensible Authentication Protocol

| Name | Description |
|--|--|
| **Service name** | EapHost |
| **Description** | The Extensible Authentication Protocol (EAP) service provides network authentication in such scenarios as 802.1x wired and wireless, VPN, and Network Access Protection (NAP). EAP also provides application programming interfaces (APIs) that are used by network access clients, including wireless and VPN clients, during the authentication process. If you disable this service, this computer is prevented from accessing networks that require EAP authentication. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Function Discovery Provider Host

| Name | Description |
|--|--|
| **Service name** | fdPHost |
| **Description** | The FDPHOST service hosts the Function Discovery (FD) network discovery providers. These FD providers supply network discovery services for the Simple Services Discovery Protocol (SSDP) and Web Services - Discovery (WS-D) protocol. Stopping or disabling the FDPHOST service will disable network discovery for these protocols when using FD. When this service is unavailable, network services using FD and relying on these discovery protocols will be unable to find network devices or resources. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Function Discovery Resource Publication

| Name | Description |
|--|--|
| **Service name** | FDResPub |
| **Description** | Publishes this computer and resources attached to this computer so they can be discovered over the network. If this service is stopped, network resources will no longer be published and they will not be discovered by other computers on the network. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Geolocation Service

| Name | Description |
|--|--|
| **Service name** | lfsvc |
| **Description** | This service monitors the current location of the system and manages geofences (a geographical location with associated events). If you turn off this service, applications will be unable to use or receive notifications for geolocation or geofences. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | Disabling breaks apps that rely on the service; OK to disable if apps not relying on it |



## Group Policy Client

| Name | Description |
|--|--|
| **Service name** | gpsvc |
| **Description** | The service is responsible for applying settings configured by administrators for the computer and users through the Group Policy component. If the service is disabled, the settings will not be applied and applications and components will not be manageable through Group Policy. Any components or applications that depend on the Group Policy component might not be functional if the service is disabled. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## Human Interface Device Service

| Name | Description |
|--|--|
| **Service name** | hidserv |
| **Description** | Activates and maintains the use of hot buttons on keyboards, remote controls, and other multimedia devices. It is recommended that you keep this service running. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## HV Host Service

| Name | Description |
|--|--|
| **Service name** | HvHost |
| **Description** | Provides an interface for the Hyper-V hypervisor to provide per-partition performance counters to the host operating system. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | Performance enhancers for guest VMs. Not used today except for explicitly populated VMs, but will be used in Application Guard |



## Hyper-V Data Exchange Service

| Name | Description |
|--|--|
| **Service name** | vmickvpexchange |
| **Description** | Provides a mechanism to exchange data between the virtual machine and the operating system running on the physical computer. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | See HvHost |



## Hyper-V Guest Service Interface

| Name | Description |
|--|--|
| **Service name** | vmicguestinterface |
| **Description** | Provides an interface for the Hyper-V host to interact with specific services running inside the virtual machine. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | See HvHost |



## Hyper-V Guest Shutdown Service

| Name | Description |
|--|--|
| **Service name** | vmicshutdown |
| **Description** | Provides a mechanism to shut down the operating system of this virtual machine from the management interfaces on the physical computer. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | See HvHost |



## Hyper-V Heartbeat Service

| Name | Description |
|--|--|
| **Service name** | vmicheartbeat |
| **Description** | Monitors the state of this virtual machine by reporting a heartbeat at regular intervals. This service helps you identify running virtual machines that have stopped responding. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | See HvHost |



## Hyper-V PowerShell Direct Service

| Name | Description |
|--|--|
| **Service name** | vmicvmsession |
| **Description** | Provides a mechanism to manage virtual machine with PowerShell via VM session without a virtual network. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | See HvHost |



## Hyper-V Remote Desktop Virtualization Service

| Name | Description |
|--|--|
| **Service name** | vmicrdv |
| **Description** | Provides a platform for communication between the virtual machine and the operating system running on the physical computer. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | See HvHost |



## Hyper-V Time Synchronization Service

| Name | Description |
|--|--|
| **Service name** | vmictimesync |
| **Description** | Synchronizes the system time of this virtual machine with the system time of the physical computer. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | See HvHost |



## Hyper-V Volume Shadow Copy Requestor

| Name | Description |
|--|--|
| **Service name** | vmicvss |
| **Description** | Coordinates the communications that are required to use Volume Shadow Copy Service to back up applications and data on this virtual machine from the operating system on the physical computer. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | See HvHost |



## IKE and AuthIP IPsec Keying Modules

| Name | Description |
|--|--|
| **Service name** | IKEEXT |
| **Description** | The IKEEXT service hosts the Internet Key Exchange (IKE) and Authenticated Internet Protocol (AuthIP) keying modules. These keying modules are used for authentication and key exchange in Internet Protocol security (IPsec). Stopping or disabling the IKEEXT service will disable IKE and AuthIP key exchange with peer computers. IPsec is typically configured to use IKE or AuthIP; therefore, stopping or disabling the IKEEXT service might result in an IPsec failure and might compromise the security of the system. It is strongly recommended that you have the IKEEXT service running. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Interactive Services Detection

| Name | Description |
|--|--|
| **Service name** | UI0Detect |
| **Description** | Enables user notification of user input for interactive services, which enables access to dialogs created by interactive services when they appear. If this service is stopped, notifications of new interactive service dialogs will no longer function and there might not be access to interactive service dialogs. If this service is disabled, both notifications of and access to new interactive service dialogs will no longer function. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Internet Connection Sharing (ICS)

| Name | Description |
|--|--|
| **Service name** | SharedAccess |
| **Description** | Provides network address translation, addressing, name resolution and/or intrusion prevention services for a home or small office network. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | Required for clients used as WiFi hotspots, and also on both ends of Miracast projection. ICS can be blocked with GPO setting, "Prohibit use of Internet Connection Sharing on your DNS domain network" |



## IP Helper

| Name | Description |
|--|--|
| **Service name** | iphlpsvc |
| **Description** | Provides tunnel connectivity using IPv6 transition technologies (6to4, ISATAP, Port Proxy, and Teredo), and IP-HTTPS. If this service is stopped, the computer will not have the enhanced connectivity benefits that these technologies offer. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## IPsec Policy Agent

| Name | Description |
|--|--|
| **Service name** | PolicyAgent |
| **Description** | Internet Protocol security (IPsec) supports network-level peer authentication, data origin authentication, data integrity, data confidentiality (encryption), and replay protection. This service enforces IPsec policies created through the IP Security Policies snap-in or the command-line tool "netsh ipsec". If you stop this service, you may experience network connectivity issues if your policy requires that connections use IPsec. Also, remote management of Windows Firewall is not available when this service is stopped. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## KDC Proxy Server service (KPS)

| Name | Description |
|--|--|
| **Service name** | KPSSVC |
| **Description** | KDC Proxy Server service runs on edge servers to proxy Kerberos protocol messages to domain controllers on the corporate network. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## KtmRm for Distributed Transaction Coordinator

| Name | Description |
|--|--|
| **Service name** | KtmRm |
| **Description** | Coordinates transactions between the Distributed Transaction Coordinator (MSDTC) and the Kernel Transaction Manager (KTM). If it is not needed, it is recommended that this service remain stopped. If it is needed, both MSDTC and KTM will start this service automatically. If this service is disabled, any MSDTC transaction interacting with a Kernel Resource Manager will fail and any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Link-Layer Topology Discovery Mapper

| Name | Description |
|--|--|
| **Service name** | lltdsvc |
| **Description** | Creates a Network Map, consisting of PC and device topology (connectivity) information, and metadata describing each PC and device. If this service is disabled, the Network Map will not function properly. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | OK to disable if no dependencies on Network Map |



## Local Session Manager

| Name | Description |
|--|--|
| **Service name** | LSM |
| **Description** | Core Windows Service that manages local user sessions. Stopping or disabling this service will result in system instability. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## Microsoft (R) Diagnostics Hub Standard Collector

| Name | Description |
|--|--|
| **Service name** | diagnosticshub.standardcollector.service |
| **Description** | Diagnostics Hub Standard Collector Service. When running, this service collects real time ETW events and processes them. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Microsoft Account Sign-in Assistant

| Name | Description |
|--|--|
| **Service name** | wlidsvc |
| **Description** | Enables user sign-in through Microsoft account identity services. If this service is stopped, users will not be able to log on to the computer with their Microsoft account. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | Microsoft Accounts are N/A on Windows Server |



## Microsoft App-V Client

| Name | Description |
|--|--|
| **Service name** | AppVClient |
| **Description** | Manages App-V users and virtual applications |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Disabled |
| **Recommendation** | Already disabled |
| **Comments** | None |



## Microsoft iSCSI Initiator Service

| Name | Description |
|--|--|
| **Service name** | MSiSCSI |
| **Description** | Manages Internet SCSI (iSCSI) sessions from this computer to remote iSCSI target devices. If this service is stopped, this computer will not be able to login or access iSCSI targets. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | Our diagnostic data indicates this is used on client as well as server. No benefit to disabling this. |



## Microsoft Passport

| Name | Description |
|--|--|
| **Service name** | NgcSvc |
| **Description** | Provides process isolation for cryptographic keys used to authenticate to a user's associated identity providers. If this service is disabled, all uses and management of these keys will not be available, which includes machine logon and single-sign on for apps and websites. This service starts and stops automatically. It is recommended that you do not reconfigure this service. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | Needed for PIN/Hello logons, which aren't supported on Server |



## Microsoft Passport Container

| Name | Description |
|--|--|
| **Service name** | NgcCtnrSvc |
| **Description** | Manages local user identity keys used to authenticate user to identity providers as well as TPM virtual smart cards. If this service is disabled, local user identity keys and TPM virtual smart cards will not be accessible. It is recommended that you do not reconfigure this service. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | None |



## Microsoft Software Shadow Copy Provider

| Name | Description |
|--|--|
| **Service name** | swprv |
| **Description** | Manages software-based volume shadow copies taken by the Volume Shadow Copy service. If this service is stopped, software-based volume shadow copies cannot be managed. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Microsoft Storage Spaces SMP

| Name | Description |
|--|--|
| **Service name** | smphost |
| **Description** | Host service for the Microsoft Storage Spaces management provider. If this service is stopped or disabled, Storage Spaces cannot be managed. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | Storage management APIs fail without this service. Example: "Get-WmiObject -class MSFT_Disk -Namespace Root\Microsoft\Windows\Storage". |



## Net.Tcp Port Sharing Service

| Name | Description |
|--|--|
| **Service name** | NetTcpPortSharing |
| **Description** | Provides ability to share TCP ports over the net.tcp protocol. |
| **Installation** | Always installed |
| **Startup type** | Disabled |
| **Recommendation** | Already disabled |
| **Comments** | None |



## Netlogon

| Name | Description |
|--|--|
| **Service name** | Netlogon |
| **Description** | Maintains a secure channel between this computer and the domain controller for authenticating users and services. If this service is stopped, the computer may not authenticate users and services and the domain controller cannot register DNS records. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Network Connection Broker

| Name | Description |
|--|--|
| **Service name** | NcbService |
| **Description** | Brokers connections that allow Microsoft Store Apps to receive notifications from the internet. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | None |



## Network Connections

| Name | Description |
|--|--|
| **Service name** | Netman |
| **Description** | Manages objects in the Network and Dial-Up Connections folder, in which you can view both local area network and remote connections. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Network Connectivity Assistant

| Name | Description |
|--|--|
| **Service name** | NcaSvc |
| **Description** | Provides DirectAccess status notification for UI components |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Network List Service

| Name | Description |
|--|--|
| **Service name** | netprofm |
| **Description** | Identifies the networks to which the computer has connected, collects and stores properties for these networks, and notifies applications when these properties change. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Network Location Awareness

| Name | Description |
|--|--|
| **Service name** | NlaSvc |
| **Description** | Collects and stores configuration information for the network and notifies programs when this information is modified. If this service is stopped, configuration information might be unavailable. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## Network Setup Service

| Name | Description |
|--|--|
| **Service name** | NetSetupSvc |
| **Description** | The Network Setup Service manages the installation of network drivers and permits the configuration of low-level network settings. If this service is stopped, any driver installations that are in-progress may be cancelled. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Network Store Interface Service

| Name | Description |
|--|--|
| **Service name** | nsi |
| **Description** | This service delivers network notifications (e.g. interface addition/deleting etc) to user mode clients. Stopping this service will cause loss of network connectivity. If this service is disabled, any other services that explicitly depend on this service will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## Offline Files

| Name | Description |
|--|--|
| **Service name** | CscService |
| **Description** | The Offline Files service performs maintenance activities on the Offline Files cache, responds to user logon and logoff events, implements the internals of the public API, and dispatches interesting events to those interested in Offline Files activities and changes in cache state. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Disabled |
| **Recommendation** | Already disabled |
| **Comments** | None |



## Optimize drives

| Name | Description |
|--|--|
| **Service name** | defragsvc |
| **Description** | Helps the computer run more efficiently by optimizing files on storage drives. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Performance Counter DLL Host

| Name | Description |
|--|--|
| **Service name** | PerfHost |
| **Description** | Enables remote users and 64-bit processes to query performance counters provided by 32-bit DLLs. If this service is stopped, only local users and 32-bit processes will be able to query performance counters provided by 32-bit DLLs. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Performance Logs & Alerts

| Name | Description |
|--|--|
| **Service name** | pla |
| **Description** | Performance Logs and Alerts Collects performance data from local or remote computers based on preconfigured schedule parameters, then writes the data to a log or triggers an alert. If this service is stopped, performance information will not be collected. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Phone Service

| Name | Description |
|--|--|
| **Service name** | PhoneSvc |
| **Description** | Manages the telephony state on the device |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | Used by modern VoIP apps |



## Plug and Play

| Name | Description |
|--|--|
| **Service name** | PlugPlay |
| **Description** | Enables a computer to recognize and adapt to hardware changes with little or no user input. Stopping or disabling this service will result in system instability. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Portable Device Enumerator Service

| Name | Description |
|--|--|
| **Service name** | WPDBusEnum |
| **Description** | Enforces group policy for removable mass-storage devices. Enables applications such as Windows Media Player and Image Import Wizard to transfer and synchronize content using removable mass-storage devices. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Power

| Name | Description |
|--|--|
| **Service name** | Power |
| **Description** | Manages power policy and power policy notification delivery. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## Print Spooler

| Name | Description |
|--|--|
| **Service name** | Spooler |
| **Description** | This service spools print jobs and handles interaction with the printer. If you turn off this service, you won't be able to print or see your printers. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | OK to disable if not a print server or a DC |
| **Comments** | On a domain controller, the installation of the DC role adds a thread to the spooler service that is responsible for performing print pruning – removing the stale print queue objects from the Active Directory. If the spooler service is not running on at least one DC in each site, then the AD has no means to remove old queues that no longer exist. ["Disabling Unnecessary Services? A Word to the Wise" - Microsoft Tech Community - Ask The Performance Team Blog](https://techcommunity.microsoft.com/t5/ask-the-performance-team/disabling-unnecessary-services-a-word-to-the-wise/ba-p/373444). |



## Printer Extensions and Notifications

| Name | Description |
|--|--|
| **Service name** | PrintNotify |
| **Description** | This service opens custom printer dialog boxes and handles notifications from a remote print server or a printer. If you turn off this service, you won't be able to see printer extensions or notifications. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | OK to disable if not a print server |
| **Comments** | None |



## Problem Reports and Solutions Control Panel Support

| Name | Description |
|--|--|
| **Service name** | wercplsupport |
| **Description** | This service provides support for viewing, sending and deletion of system-level problem reports for the Problem Reports and Solutions control panel. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Program Compatibility Assistant Service

| Name | Description |
|--|--|
| **Service name** | PcaSvc |
| **Description** | This service provides support for the Program Compatibility Assistant (PCA). PCA monitors programs installed and run by the user and detects known compatibility problems. If this service is stopped, PCA will not function properly. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Automatic |
| **Recommendation** | OK to disable |
| **Comments** | None |



## Quality Windows Audio Video Experience

| Name | Description |
|--|--|
| **Service name** | QWAVE |
| **Description** | Quality Windows Audio Video Experience (qWave) is a networking platform for Audio Video (AV) streaming applications on IP home networks. qWave enhances AV streaming performance and reliability by ensuring network quality-of-service (QoS) for AV applications. It provides mechanisms for admission control, run time monitoring and enforcement, application feedback, and traffic prioritization. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | Client-side QoS service |



## Radio Management Service

| Name | Description |
|--|--|
| **Service name** | RmSvc |
| **Description** | Radio Management and Airplane Mode Service |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | None |



## Remote Access Auto Connection Manager

| Name | Description |
|--|--|
| **Service name** | RasAuto |
| **Description** | Creates a connection to a remote network whenever a program references a remote DNS or NetBIOS name or address. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Remote Access Connection Manager

| Name | Description |
|--|--|
| **Service name** | RasMan |
| **Description** | Manages dial-up and virtual private network (VPN) connections from this computer to the Internet or other remote networks. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Remote Desktop Configuration

| Name | Description |
|--|--|
| **Service name** | SessionEnv |
| **Description** | Remote Desktop Configuration service (RDCS) is responsible for all Remote Desktop Services and Remote Desktop related configuration and session maintenance activities that require SYSTEM context. These include per-session temporary folders, RD themes, and RD certificates. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | None |



## Remote Desktop Services

| Name | Description |
|--|--|
| **Service name** | TermService |
| **Description** | Allows users to connect interactively to a remote computer. Remote Desktop and Remote Desktop Session Host Server depend on this service. To prevent remote use of this computer, clear the checkboxes on the Remote tab of the System properties control panel item. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | None |



## Remote Desktop Services UserMode Port Redirector

| Name | Description |
|--|--|
| **Service name** | UmRdpService |
| **Description** | Allows the redirection of Printers/Drives/Ports for RDP connections |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | Supports redirections on the server side of the connection. |



## Remote Procedure Call (RPC)

| Name | Description |
|--|--|
| **Service name** | RpcSs |
| **Description** | The RPCSS service is the Service Control Manager for COM and DCOM servers. It performs object activations requests, object exporter resolutions and distributed garbage collection for COM and DCOM servers. If this service is stopped or disabled, programs using COM or DCOM will not function properly. It is strongly recommended that you have the RPCSS service running. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## Remote Procedure Call (RPC) Locator

| Name | Description |
|--|--|
| **Service name** | RpcLocator |
| **Description** | In Windows 2003 and earlier versions of Windows, the Remote Procedure Call (RPC) Locator service manages the RPC name service database. In Windows Vista and later versions of Windows, this service does not provide any functionality and is present for application compatibility. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Remote Registry

| Name | Description |
|--|--|
| **Service name** | RemoteRegistry |
| **Description** | Enables remote users to modify registry settings on this computer. If this service is stopped, the registry can be modified only by users on this computer. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | Do not disable |
| **Comments** | None |



## Resultant Set of Policy Provider

| Name | Description |
|--|--|
| **Service name** | RSoPProv |
| **Description** | Provides a network service that processes requests to simulate application of Group Policy settings for a target user or computer in various situations and computes the Resultant Set of Policy settings. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Routing and Remote Access

| Name | Description |
|--|--|
| **Service name** | RemoteAccess |
| **Description** | Offers routing services to businesses in local area and wide area network environments. |
| **Installation** | Always installed |
| **Startup type** | Disabled |
| **Recommendation** | Already disabled |
| **Comments** | Already disabled |



## RPC Endpoint Mapper

| Name | Description |
|--|--|
| **Service name** | RpcEptMapper |
| **Description** | Resolves RPC interfaces identifiers to transport endpoints. If this service is stopped or disabled, programs using Remote Procedure Call (RPC) services will not function properly. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## Secondary Logon

| Name | Description |
|--|--|
| **Service name** | seclogon |
| **Description** | Enables starting processes under alternate credentials. If this service is stopped, this type of logon access will be unavailable. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Secure Socket Tunneling Protocol Service

| Name | Description |
|--|--|
| **Service name** | SstpSvc |
| **Description** | Provides support for the Secure Socket Tunneling Protocol (SSTP) to connect to remote computers using VPN. If this service is disabled, users will not be able to use SSTP to access remote servers. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | Disabling breaks RRAS |



## Security Accounts Manager

| Name | Description |
|--|--|
| **Service name** | SamSs |
| **Description** | The startup of this service signals other services that the Security Accounts Manager (SAM) is ready to accept requests. Disabling this service will prevent other services in the system from being notified when the SAM is ready, which may in turn cause those services to fail to start correctly. This service should not be disabled. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | Do not disable |
| **Comments** | None |



## Sensor Data Service

| Name | Description |
|--|--|
| **Service name** | SensorDataService |
| **Description** | Delivers data from a variety of sensors |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | None |



## Sensor Monitoring Service

| Name | Description |
|--|--|
| **Service name** | SensrSvc |
| **Description** | Monitors various sensors in order to expose data and adapt to system and user state. If this service is stopped or disabled, the display brightness will not adapt to lighting conditions. Stopping this service may affect other system functionality and features as well. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | None |


## Sensor Service

| Name | Description |
|--|--|
| **Service name** | SensorService |
| **Description** | A service for sensors that manages the functionality of different sensors. Manages Simple Device Orientation (SDO) and History for sensors. Loads the SDO sensor that reports device orientation changes. If this service is stopped or disabled, the SDO sensor will not be loaded and so auto-rotation will not occur. History collection from Sensors will also be stopped. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | None |


## Server

| Name | Description |
|--|--|
| **Service name** | LanmanServer |
| **Description** | Supports file, print, and named-pipe sharing over the network for this computer. If this service is stopped, these functions will be unavailable. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | Do not disable |
| **Comments** | Needed for remote management, IPC$, SMB file sharing |



## Shell Hardware Detection

| Name | Description |
|--|--|
| **Service name** | ShellHWDetection |
| **Description** | Provides notifications for AutoPlay hardware events. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Automatic |
| **Recommendation** | OK to disable |
| **Comments** | None |



## Smart Card

| Name | Description |
|--|--|
| **Service name** | SCardSvr |
| **Description** | Manages access to smart cards read by this computer. If this service is stopped, this computer will be unable to read smart cards. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Disabled |
| **Recommendation** | Already disabled |
| **Comments** | None |



## Smart Card Device Enumeration Service

| Name | Description |
|--|--|
| **Service name** | ScDeviceEnum |
| **Description** | Creates software device nodes for all smart card readers accessible to a given session. If this service is disabled, WinRT APIs will not be able to enumerate smart card readers. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | Needed almost exclusively for WinRT apps |



## Smart Card Removal Policy

| Name | Description |
|--|--|
| **Service name** | SCPolicySvc |
| **Description** | Allows the system to be configured to lock the user desktop upon smart card removal. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## SNMP Trap

| Name | Description |
|--|--|
| **Service name** | SNMPTRAP |
| **Description** | Receives trap messages generated by local or remote Simple Network Management Protocol (SNMP) agents and forwards the messages to SNMP management programs running on this computer. If this service is stopped, SNMP-based programs on this computer will not receive SNMP trap messages. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Software Protection

| Name | Description |
|--|--|
| **Service name** | sppsvc |
| **Description** | Enables the download, installation and enforcement of digital licenses for Windows and Windows applications. If the service is disabled, the operating system and licensed applications may run in a notification mode. It is strongly recommended that you not disable the Software Protection service. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## Special Administration Console Helper

| Name | Description |
|--|--|
| **Service name** | sacsvr |
| **Description** | Allows administrators to remotely access a command prompt using Emergency Management Services. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Spot Verifier

| Name | Description |
|--|--|
| **Service name** | svsvc |
| **Description** | Verifies potential file system corruptions. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## SSDP Discovery

| Name | Description |
|--|--|
| **Service name** | SSDPSRV |
| **Description** | Discovers networked devices and services that use the SSDP discovery protocol, such as UPnP devices. Also announces SSDP devices and services running on the local computer. If this service is stopped, SSDP-based devices will not be discovered. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | None |



## State Repository Service

| Name | Description |
|--|--|
| **Service name** | StateRepository |
| **Description** | Provides required infrastructure support for the application model. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Still Image Acquisition Events

| Name | Description |
|--|--|
| **Service name** | WiaRpc |
| **Description** | Launches applications associated with still image acquisition events. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | None |



## Storage Service

| Name | Description |
|--|--|
| **Service name** | StorSvc |
| **Description** | Provides enabling services for storage settings and external storage expansion |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Storage Tiers Management

| Name | Description |
|--|--|
| **Service name** | TieringEngineService |
| **Description** | Optimizes the placement of data in storage tiers on all tiered storage spaces in the system. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Superfetch

| Name | Description |
|--|--|
| **Service name** | SysMain |
| **Description** | Maintains and improves system performance over time. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Sync Host

| Name | Description |
|--|--|
| **Service name** | OneSyncSvc |
| **Description** | This service synchronizes mail, contacts, calendar and various other user data. Mail and other applications dependent on this functionality will not work properly when this service is not running. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Automatic |
| **Recommendation** | OK to disable |
| **Comments** | User service template |



## System Event Notification Service

| Name | Description |
|--|--|
| **Service name** | SENS |
| **Description** | Monitors system events and notifies subscribers to COM+ Event System of these events. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## System Events Broker

| Name | Description |
|--|--|
| **Service name** | SystemEventsBroker |
| **Description** | Coordinates execution of background work for WinRT application. If this service is stopped or disabled, then background work might not be triggered. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | Do not disable |
| **Comments** | In spite of the fact that its description implies it is only for WinRT apps, it's needed for task scheduler, broker infrastructure service, and other internal components. |



## Task Scheduler

| Name | Description |
|--|--|
| **Service name** | Schedule |
| **Description** | Enables a user to configure and schedule automated tasks on this computer. The service also hosts multiple Windows system-critical tasks. If this service is stopped or disabled, these tasks will not be run at their scheduled times. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## TCP/IP NetBIOS Helper

| Name | Description |
|--|--|
| **Service name** | lmhosts |
| **Description** | Provides support for the NetBIOS over TCP/IP (NetBT) service and NetBIOS name resolution for clients on the network, therefore enabling users to share files, print, and log on to the network. If this service is stopped, these functions might be unavailable. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Telephony

| Name | Description |
|--|--|
| **Service name** | TapiSrv |
| **Description** | Provides Telephony API (TAPI) support for programs that control telephony devices on the local computer and, through the LAN, on servers that are also running the service. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | Disabling breaks RRAS |



## Themes

| Name | Description |
|--|--|
| **Service name** | Themes |
| **Description** | Provides user experience theme management. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Automatic |
| **Recommendation** | Do not disable |
| **Comments** | Can't set accessibility themes when this service is disabled |



## Tile Data model server

| Name | Description |
|--|--|
| **Service name** | tiledatamodelsvc |
| **Description** | Tile Server for tile updates. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Automatic |
| **Recommendation** | Do not disable |
| **Comments** | Start menu breaks if this service is disabled |



## Time Broker

| Name | Description |
|--|--|
| **Service name** | TimeBrokerSvc |
| **Description** | Coordinates execution of background work for WinRT application. If this service is stopped or disabled, then background work might not be triggered. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | In spite of the fact that its description implies it is only for WinRT apps, it's needed for task scheduler, broker infrastructure service, and other internal components. |



## Touch Keyboard and Handwriting Panel Service

| Name | Description |
|--|--|
| **Service name** | TabletInputService |
| **Description** | Enables Touch Keyboard and Handwriting Panel pen and ink functionality |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | None |



## Update Orchestrator Service for Windows Update

| Name | Description |
|--|--|
| **Service name** | UsoSvc |
| **Description** | Manages Windows Updates. If stopped, your devices will not be able to download and install latest updates. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | Service description was missing in v1607; Windows Update (incl. WSUS) depends on this service. |



## UPnP Device Host

| Name | Description |
|--|--|
| **Service name** | upnphost |
| **Description** | Allows UPnP devices to be hosted on this computer. If this service is stopped, any hosted UPnP devices will stop functioning and no additional hosted devices can be added. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | None |



## User Access Logging Service

| Name | Description |
|--|--|
| **Service name** | UALSVC |
| **Description** | This service logs unique client access requests, in the form of IP addresses and user names, of installed products and roles on the local server. This information can be queried, via Powershell, by administrators needing to quantify client demand of server software for offline Client Access License (CAL) management. If the service is disabled, client requests will not be logged and will not be retrievable via Powershell queries. Stopping the service will not affect query of historical data (see supporting documentation for steps to delete historical data). The local system administrator must consult his, or her, Windows Server license terms to determine the number of CALs that are required for the server software to be appropriately licensed; use of the UAL service and data does not alter this obligation. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## User Data Access

| Name | Description |
|--|--|
| **Service name** | UserDataSvc |
| **Description** | Provides apps access to structured user data, including contact info, calendars, messages, and other content. If you stop or disable this service, apps that use this data might not work correctly. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | User service template |



## User Data Storage

| Name | Description |
|--|--|
| **Service name** | UnistoreSvc |
| **Description** | Handles storage of structured user data, including contact info, calendars, messages, and other content. If you stop or disable this service, apps that use this data might not work correctly. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | User service template |



## User Experience Virtualization Service

| Name | Description |
|--|--|
| **Service name** | UevAgentService |
| **Description** | Provides support for application and OS settings roaming |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Disabled |
| **Recommendation** | Already disabled |
| **Comments** | None |



## User Manager

| Name | Description |
|--|--|
| **Service name** | UserManager |
| **Description** | User Manager provides the runtime components required for multi-user interaction. If this service is stopped, some applications may not operate correctly. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## User Profile Service

| Name | Description |
|--|--|
| **Service name** | ProfSvc |
| **Description** | This service is responsible for loading and unloading user profiles. If this service is stopped or disabled, users will no longer be able to successfully sign in or sign out, apps might have problems getting to users' data, and components registered to receive profile event notifications won't receive them. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## Virtual Disk

| Name | Description |
|--|--|
| **Service name** | vds |
| **Description** | Provides management services for disks, volumes, file systems, and storage arrays. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Volume Shadow Copy

| Name | Description |
|--|--|
| **Service name** | VSS |
| **Description** | Manages and implements Volume Shadow Copies used for backup and other purposes. If this service is stopped, shadow copies will be unavailable for backup and the backup may fail. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## WalletService

| Name | Description |
|--|--|
| **Service name** | WalletService |
| **Description** | Hosts objects used by clients of the wallet |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | None |



## Windows Audio

| Name | Description |
|--|--|
| **Service name** | Audiosrv |
| **Description** | Manages audio for Windows-based programs. If this service is stopped, audio devices and effects will not function properly. If this service is disabled, any services that explicitly depend on it will fail to start |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | None |



## Windows Audio Endpoint Builder

| Name | Description |
|--|--|
| **Service name** | AudioEndpointBuilder |
| **Description** | Manages audio devices for the Windows Audio service. If this service is stopped, audio devices and effects will not function properly. If this service is disabled, any services that explicitly depend on it will fail to start |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | None |



## Windows Biometric Service

| Name | Description |
|--|--|
| **Service name** | WbioSrvc |
| **Description** | The Windows biometric service gives client applications the ability to capture, compare, manipulate, and store biometric data without gaining direct access to any biometric hardware or samples. The service is hosted in a privileged SVCHOST process. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Windows Camera Frame Server

| Name | Description |
|--|--|
| **Service name** | FrameServer |
| **Description** | Enables multiple clients to access video frames from camera devices. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | None |



## Windows Connection Manager

| Name | Description |
|--|--|
| **Service name** | Wcmsvc |
| **Description** | Makes automatic connect/disconnect decisions based on the network connectivity options currently available to the PC and enables management of network connectivity based on Group Policy settings. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## Windows Defender Network Inspection Service

| Name | Description |
|--|--|
| **Service name** | WdNisSvc |
| **Description** | Helps guard against intrusion attempts targeting known and newly discovered vulnerabilities in network protocols |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Windows Defender Service

| Name | Description |
|--|--|
| **Service name** | WinDefend |
| **Description** | Helps protect users from malware and other potentially unwanted software |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## Windows Driver Foundation - User-mode Driver Framework

| Name | Description |
|--|--|
| **Service name** | wudfsvc |
| **Description** | Creates and manages user-mode driver processes. This service cannot be stopped. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Windows Encryption Provider Host Service

| Name | Description |
|--|--|
| **Service name** | WEPHOSTSVC |
| **Description** | Windows Encryption Provider Host Service brokers encryption related functionalities from third-party Encryption Providers to processes that need to evaluate and apply EAS policies. Stopping this will compromise EAS compliancy checks that have been established by the connected Mail Accounts |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Windows Error Reporting Service

| Name | Description |
|--|--|
| **Service name** | WerSvc |
| **Description** | Allows errors to be reported when programs stop working or responding and allows existing solutions to be delivered. Also allows logs to be generated for diagnostic and repair services. If this service is stopped, error reporting might not work correctly and results of diagnostic services and repairs might not be displayed. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | Collects and sends crash/hang data used by both MS and third party ISVs/IHVs. The data is used to diagnose crash-inducing bugs, which may include security bugs. Also needed for Corporate Error Reporting |



## Windows Event Collector

| Name | Description |
|--|--|
| **Service name** | Wecsvc |
| **Description** | This service manages persistent subscriptions to events from remote sources that support WS-Management protocol. This includes Windows Vista event logs, hardware and IPMI-enabled event sources. The service stores forwarded events in a local Event Log. If this service is stopped or disabled event subscriptions cannot be created and forwarded events cannot be accepted. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | Collects ETW events (including security events) for manageability, diagnostics. Lots of features and third-party tools rely on it, including security audit tools |



## Windows Event Log

| Name | Description |
|--|--|
| **Service name** | EventLog |
| **Description** | This service manages events and event logs. It supports logging events, querying events, subscribing to events, archiving event logs, and managing event metadata. It can display events in both XML and plain text format. Stopping this service may compromise security and reliability of the system. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## Windows Firewall

| Name | Description |
|--|--|
| **Service name** | MpsSvc |
| **Description** | Windows Firewall helps protect your computer by preventing unauthorized users from gaining access to your computer through the Internet or a network. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## Windows Font Cache Service

| Name | Description |
|--|--|
| **Service name** | FontCache |
| **Description** | Optimizes performance of applications by caching commonly used font data. Applications will start this service if it is not already running. It can be disabled, though doing so will degrade application performance. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## Windows Image Acquisition (WIA)

| Name | Description |
|--|--|
| **Service name** | stisvc |
| **Description** | Provides image acquisition services for scanners and cameras |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | None |



## Windows Insider Service

| Name | Description |
|--|--|
| **Service name** | wisvc |
| **Description** | wisvc |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | Server doesn't support flighting, so it's a no-op on Server. Feature can be disabled via GP as well. |



## Windows Installer

| Name | Description |
|--|--|
| **Service name** | msiserver |
| **Description** | Adds, modifies, and removes applications provided as a Windows Installer (*.msi, *.msp) package. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Windows License Manager Service

| Name | Description |
|--|--|
| **Service name** | LicenseManager |
| **Description** | Provides infrastructure support for the Microsoft Store. This service is started on demand and if disabled then content acquired through the Microsoft Store will not function properly. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Windows Management Instrumentation

| Name | Description |
|--|--|
| **Service name** | Winmgmt |
| **Description** | Provides a common interface and object model to access management information about operating system, devices, applications and services. If this service is stopped, most Windows-based software will not function properly. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## Windows Mobile Hotspot Service

| Name | Description |
|--|--|
| **Service name** | icssvc |
| **Description** | Provides the ability to share a cellular data connection with another device. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | None |



## Windows Modules Installer

| Name | Description |
|--|--|
| **Service name** | TrustedInstaller |
| **Description** | Enables installation, modification, and removal of Windows updates and optional components. If this service is disabled, install or uninstall of Windows updates might fail for this computer. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Windows Push Notifications System Service

| Name | Description |
|--|--|
| **Service name** | WpnService |
| **Description** | This service runs in session 0 and hosts the notification platform and connection provider which handles the connection between the device and WNS server. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Automatic |
| **Recommendation** | OK to disable |
| **Comments** | Needed for live tiles and other features |



## Windows Push Notifications User Service

| Name | Description |
|--|--|
| **Service name** | WpnUserService |
| **Description** | This service hosts Windows notification platform which provides support for local and push notifications. Supported notifications are tile, toast and raw. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | OK to disable |
| **Comments** | User service template |



## Windows Remote Management (WS-Management)

| Name | Description |
|--|--|
| **Service name** | WinRM |
| **Description** | Windows Remote Management (WinRM) service implements the WS-Management protocol for remote management. WS-Management is a standard web services protocol used for remote software and hardware management. The WinRM service listens on the network for WS-Management requests and processes them. The WinRM Service needs to be configured with a listener using winrm.cmd command line tool or through Group Policy in order for it to listen over the network. The WinRM service provides access to WMI data and enables event collection. Event collection and subscription to events require that the service is running. WinRM messages use HTTP and HTTPS as transports. The WinRM service does not depend on IIS but is preconfigured to share a port with IIS on the same machine. The WinRM service reserves the /wsman URL prefix. To prevent conflicts with IIS, administrators should ensure that any websites hosted on IIS do not use the /wsman URL prefix. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | Do not disable |
| **Comments** | Needed for remote management |



## Windows Search

| Name | Description |
|--|--|
| **Service name** | WSearch |
| **Description** | Provides content indexing, property caching, and search results for files, e-mail, and other content. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Disabled |
| **Recommendation** | Already disabled |
| **Comments** | None |



## Windows Time

| Name | Description |
|--|--|
| **Service name** | W32Time |
| **Description** | Maintains date and time synchronization on all clients and servers in the network. If this service is stopped, date and time synchronization will be unavailable. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## Windows Update

| Name | Description |
|--|--|
| **Service name** | wuauserv |
| **Description** | Enables the detection, download, and installation of updates for Windows and other programs. If this service is disabled, users of this computer will not be able to use Windows Update or its automatic updating feature, and programs will not be able to use the Windows Update Agent (WUA) API. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## WinHTTP Web Proxy Auto-Discovery Service

| Name | Description |
|--|--|
| **Service name** | WinHttpAutoProxySvc |
| **Description** | WinHTTP implements the client HTTP stack and provides developers with a Win32 API and COM Automation component for sending HTTP requests and receiving responses. In addition, WinHTTP provides support for auto-discovering a proxy configuration via its implementation of the Web Proxy Auto-Discovery (WPAD) protocol. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | Do not disable |
| **Comments** | Anything that uses the network stack can have a functional dependency on this service. Many organizations rely on this to configure their internal networks' HTTP proxy routing. Without it, internally-originating HTTP connections to the Internet will all fail. |



## Wired AutoConfig

| Name | Description |
|--|--|
| **Service name** | dot3svc |
| **Description** | The Wired AutoConfig (DOT3SVC) service is responsible for performing IEEE 802.1X authentication on Ethernet interfaces. If your current wired network deployment enforces 802.1X authentication, the DOT3SVC service should be configured to run for establishing Layer 2 connectivity and/or providing access to network resources. Wired networks that do not enforce 802.1X authentication are unaffected by the DOT3SVC service. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## WMI Performance Adapter

| Name | Description |
|--|--|
| **Service name** | wmiApSrv |
| **Description** | Provides performance library information from Windows Management Instrumentation (WMI) providers to clients on the network. This service only runs when Performance Data Helper is activated. |
| **Installation** | Always installed |
| **Startup type** | Manual |
| **Recommendation** | No guidance |
| **Comments** | None |



## Workstation

| Name | Description |
|--|--|
| **Service name** | LanmanWorkstation |
| **Description** | Creates and maintains client network connections to remote servers using the SMB protocol. If this service is stopped, these connections will be unavailable. If this service is disabled, any services that explicitly depend on it will fail to start. |
| **Installation** | Always installed |
| **Startup type** | Automatic |
| **Recommendation** | No guidance |
| **Comments** | None |



## Xbox Live Auth Manager

| Name | Description |
|--|--|
| **Service name** | XblAuthManager |
| **Description** | Provides authentication and authorization services for interacting with Xbox Live. If this service is stopped, some applications may not operate correctly. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | Should be disabled |
| **Comments** | None |



## Xbox Live Game Save

| Name | Description |
|--|--|
| **Service name** | XblGameSave |
| **Description** | This service syncs save data for Xbox Live save enabled games. If this service is stopped, game save data will not upload to or download from Xbox Live. |
| **Installation** | Only with Desktop Experience |
| **Startup type** | Manual |
| **Recommendation** | Should be disabled |
| **Comments** | This service syncs save data for Xbox Live save enabled games. If this service is stopped, game save data will not upload to or download from Xbox Live. |
