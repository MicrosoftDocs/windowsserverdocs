---
title: Security guidelines for system services in Windows Server 2016
description: Security guidelines for disabling services in Windows Server 2016 with Desktop Experience
ms.custom: na
ms.prod: windows-server-threshold
ms.technology: techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.date: 11/26/2018
ms.assetid: b886b2fd-3567-4f0a-8aa3-4ba7923d2d21
author: nirb
ms.author: nirb
---

## Guidance on disabling system services on Windows Server 2016 with Desktop Experience

Applies to: Windows Server 2016

The Windows operating system includes many system services that provide important functionality. Different services have different default startup policies: some are started by default (automatic), some when needed (manual), and some are disabled by default and must be explicitly enabled before they can run. These defaults were chosen carefully for each service to balance performance, functionality, and security for typical customers.

However, some enterprise customers may prefer a more security-focused balance for their Windows PCs and servers, one that reduces their attack surface to the absolute minimum, and may therefore wish to fully disable all services that are not needed in their specific environments. For those customers, Microsoft® is providing the accompanying guidance regarding which services can safely be disabled for this purpose.

The guidance is only for Windows Server 2016 with Desktop Experience (unless used as a desktop replacement for end users). Beginning with Windows Server 2019, these guidelines are configured by default. Each service on the system is categorized as follows:

-   **Should Disable:** A security-focused enterprise will most likely prefer to disable this service and forego its functionality (see additional details below).
- **OK to Disable:** This service provides functionality that is useful to some but not all enterprises, and security-focused enterprises that don’t use it can safely disable it.
- **Do Not Disable:** Disabling this service will impact essential functionality or prevent specific roles or features from functioning correctly. Therefore it should not be disabled.
-  **(No guidance):** The impact of disabling these services has not been fully evaluated. Therefore, the default configuration of these services should not be changed.


Customers can configure their Windows PCs and servers to disable selected services using the Security Templates in their Group Policies or using PowerShell automation. In some cases, the guidance includes specific Group Policy settings that disable the service’s functionality directly, as an alternative to disabling the service itself.

Microsoft recommends that customers disable the following services and their respective scheduled tasks on Windows Server 2016 with Desktop Experience:

Services: 
1. Xbox Live Auth Manager
2. Xbox Live Game Save

Scheduled tasks: 
1. \Microsoft\XblGameSave\XblGameSaveTask
2. \Microsoft\XblGameSave\XblGameSaveTaskLogon

(You can also access the information on all services detailed in this article by viewing the attached Microsoft Excel spreadsheet: [Guidance on Disabling System Services on Windows Server 2016 with Desktop Experience](https://msdnshared.blob.core.windows.net/media/2017/05/Service-management-WS2016.xlsx))

<br />

### Disabling services not installed by default

Microsoft recommends against applying policies to disable services that are not installed by default.
-  The service is usually needed if the feature is installed. Installing the service or the feature requires administrative rights. Disallow the feature installation, not the service startup.
-  Blocking the Microsoft Windows service doesn't stop an admin (or non-admin in some cases) from installing a similar third-party equivalent, perhaps one with a higher security risk.
-  A baseline or benchmark that disables a non-default Windows service (for example, W3SVC) will give some auditors the mistaken impression that the technology (for example, IIS) is inherently insecure and should never be used.
-  If the feature (and service) is never installed, this just adds unnecessary bulk to the baseline and to verification work.

<br />
For all system services listed in this document, the two tables that follow offer an explanation of columns and Microsoft recommendations for enabling and disabling system services in Windows Server 2016 with Desktop Experience: 

<br />

### Explanation of columns

| | |
|---|---|
|**Service description**|   The service's description, from sc.exe qdescription.|
|**Name** |Key (internal) name of the service|
|**Installation** |Always installed: Service is on Server Core and Server with Desktop Experience  <br /> Only with Desktop Experience: Service is on Windows Server 2016 with Desktop Experience, but is ***not*** on Server Core |
|**StartType**  |Service start type on Windows Server 2016|
|**Recommendation** |Microsoft recommendation/advice about disabling this service on Windows Server 2016 in a typical, well-managed enterprise deployment and where the server is not being used as an end-user desktop replacement.|
|**Comments** |Additional explanation|

<br />

### Explanation of Microsoft recommendations

| | |
|---|---|
|**Do not disable** |This service should not be disabled|
|**OK to disable**| This service can be disabled if the feature it supports is not being used.|
|**Already disabled**|  This service is disabled by default; no need to enforce with policy|
|**Should be disabled** |This service should never be enabled on a well-managed enterprise system.|

<br />

The following tables offer Microsoft guidance on disabling system services on Windows Server 2016 with Desktop Experience:

<br />

##  ActiveX Installer (AxInstSV)

| | |
|---|---|
|   **Service description** |   Provides User Account Control validation for the installation of ActiveX controls from the Internet and enables management of ActiveX control installation based on Group Policy settings. This service is started on demand and if disabled the installation of ActiveX controls will behave according to default browser settings.    |
|   **Service name**    |   AxInstSV    |
|   **Installation**    |   Only with Desktop Experience    |
|   **StartType**   |   Manual  |
|   **Recommendation**  |   OK to disable   |
|   **Comments**    |   OK to disable if feature not needed |


<br />

## AllJoyn Router Service   

| | |
|---|---|
|   **Service description** |   Routes AllJoyn messages for the local AllJoyn clients. If this service is stopped the AllJoyn clients that do not have their own bundled routers will be unable to run. |
|   **Service name**    |   AJRouter    |
|   **Installation**    |   Only with Desktop Experience    |
|   **StartType**   |   Manual  |
|   **Recommendation**  | No guidance       |
|   **Comments**    |       |
| | |

<br />

## App Readiness

| | |
|---|---|
**Service description** |   Gets apps ready for use the first time a user signs in to this PC and when adding new apps.
**Service name**    |   AppReadiness
**Installation**    |   Only with Desktop Experience
**StartType**   |   Manual
**Recommendation**  |   Do not disable
**Comments**    |   
| | |

<br />

##  Application Identity

| | |       
|---|---|   
**Service description** |   Determines and verifies the identity of an application. Disabling this service will prevent AppLocker from being enforced.
**Service name**    |   AppIDSvc
**Installation**    |   Always installed
**StartType**   |   Manual
**Recommendation**  |No guidance    
**Comments**    |   
|||     

<br />

##  Application Information 

| | |       
|---|---|   
|   **Service description** |   Facilitates the running of interactive applications with additional administrative privileges.  If this service is stopped, users will be unable to launch applications with the additional administrative privileges they may require to perform desired user tasks.
|   **Service name**    |   Appinfo
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   Supports UAC same-desktop elevation
|||     

<br />

##  Application Layer Gateway Service       

| | |           
|---|---|           
|   **Service description** |   Provides support for third-party protocol plug-ins for Internet Connection Sharing
|   **Service name**    |   ALG
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |No guidance    
|   **Comments**    |   
|||     

<br />

##  Application Management      

| | |           
|---|---|       
|   **Service description** |   Processes installation, removal, and enumeration requests for software deployed through Group Policy. If the service is disabled, users will be unable to install, remove, or enumerate software deployed through Group Policy. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   AppMgmt
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  AppX Deployment Service (AppXSVC)       

| | |           
|---|---|
|   **Service description** |   Provides infrastructure support for deploying Store applications. This service is started on demand and if disabled Store applications will not be deployed to the system, and may not function properly.
|   **Service name**    |   AppXSvc
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Auto Time Zone Updater           

| | |           
|---|---|           
|   **Service description** |   Automatically sets the system time zone.
|   **Service name**    |   tzautoupdate
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Disabled
|   **Recommendation**  |   Already disabled
|   **Comments**    |   
|||         

<br />          

## Background Intelligent Transfer Service          

| | |           
|---|---|   
|   **Service description** |   Transfers files in the background using idle network bandwidth. If the service is disabled, then any applications that depend on BITS, such as Windows Update or MSN Explorer, will be unable to automatically download programs and other information.
|   **Service name**    |   BITS
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          


## Background Tasks Infrastructure Service      

| | |           
|---|---|   
|   **Service description** |   Windows infrastructure service that controls which background tasks can run on the system.
|   **Service name**    |   BrokerInfrastructure
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Base Filtering Engine            

| | |           
|---|---|       
|   **Service description** |   The Base Filtering Engine (BFE) is a service that manages firewall and Internet Protocol security (IPsec) policies and implements user mode filtering. Stopping or disabling the BFE service will significantly reduce the security of the system. It will also result in unpredictable behavior in IPsec management and firewall applications.
|   **Service name**    |   BFE
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Bluetooth Support Service            

| | |           
|---|---|   
|   **Service description** |   The Bluetooth service supports discovery and association of remote Bluetooth devices.  Stopping or disabling this service may cause already installed Bluetooth devices to fail to operate properly and prevent new devices from being discovered or associated.
|   **Service name**    |   bthserv
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   OK to disable if not used. Another disabling mechanism: https://technet.microsoft.com/library/dd252791.aspx
|||         

<br />          


## CDPUserSvc           

| | |           
|---|---|   
|   **Service description** |   This user service is used for Connected Devices Platform scenarios
|   **Service name**    |   CDPUserSvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Automatic
|   **Recommendation**  |   OK to disable
|   **Comments**    |   User service template
|||         

<br />          


##  Certificate Propagation     

| | |           
|---|---|
|   **Service description** |   Copies user certificates and root certificates from smart cards into the current user's certificate store, detects when a smart card is inserted into a smart card reader, and if needed, installs the smart card Plug and Play minidriver.
|   **Service name**    |   CertPropSvc
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Client License Service (ClipSVC)        

| | |           
|---|---|   
|   **Service description** |   Provides infrastructure support for the Microsoft Store. This service is started on demand and if disabled applications bought using Microsoft Store will not behave correctly.
|   **Service name**    |   ClipSVC
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## CNG Key Isolation

| | |           
|---|---|   
|   **Service description** |   The CNG key isolation service is hosted in the LSA process. The service provides key process isolation to private keys and associated cryptographic operations as required by the Common Criteria. The service stores and uses long-lived keys in a secure process complying with Common Criteria requirements.
|   **Service name**    |   KeyIso
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  COM+ Event System       

| | |           
|---|---|       
|   **Service description** |   Supports System Event Notification Service (SENS), which provides automatic distribution of events to subscribing Component Object Model (COM) components. If the service is stopped, SENS will close and will not be able to provide logon and logoff notifications. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   EventSystem
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  COM+ System Application     

| | |           
|---|---|       
|   **Service description** |   Manages the configuration and tracking of Component Object Model (COM)+-based components. If the service is stopped, most COM+-based components will not function properly. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   COMSysApp
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Computer Browser        

| | |           
|---|---|       
|   **Service description** |   Maintains an updated list of computers on the network and supplies this list to computers designated as browsers. If this service is stopped, this list will not be updated or maintained. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   Browser
|   **Installation**    |   Always installed
|   **StartType**   |   Disabled
|   **Recommendation**  |   Already disabled
|   **Comments**    |   
|||         

<br />          

## Connected Devices Platform Service       

| | |           
|---|---|       
|   **Service description** |   This service is used for Connected Devices and Universal Glass scenarios
|   **Service name**    |   CDPSvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Connected User Experiences and Telemetry     

| | |           
|---|---|       
|   **Service description** |   The Connected User Experiences and Telemetry service enables features that support in-application and connected user experiences. Additionally, this service manages the event-driven collection and transmission of diagnostic and usage information (used to improve the experience and quality of the Windows Platform) when the diagnostics and usage privacy option settings are enabled under Feedback and Diagnostics.
|   **Service name**    |   DiagTrack
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Contact Data        

| | |           
|---|---|       
|   **Service description** |   Indexes contact data for fast contact searching. If you stop or disable this service, contacts might be missing from your search results.
|   **Service name**    |   PimIndexMaintenanceSvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   User service template
|||         

<br />          

## CoreMessaging            

| | |           
|---|---|           
|   **Service description** |   Manages communication between system components.
|   **Service name**    |   CoreMessagingRegistrar
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Credential Manager           

| | |           
|---|---|       
|   **Service description** |   Provides secure storage and retrieval of credentials to users, applications and security service packages.
|   **Service name**    |   VaultSvc
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Cryptographic Services           

| | |           
|---|---|       
|   **Service description** |   Provides three management services: Catalog Database Service, which confirms the signatures of Windows files and allows new programs to be installed; Protected Root Service, which adds and removes Trusted Root Certification Authority certificates from this computer; and Automatic Root Certificate Update Service, which retrieves root certificates from Windows Update and enable scenarios such as SSL. If this service is stopped, these management services will not function properly. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   CryptSvc
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Data Sharing Service         

| | |           
|---|---|       
|   **Service description** |   Provides data brokering between applications.
|   **Service name**    |   DsSvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## DataCollectionPublishingService          

| | |           
|---|---|       
|   **Service description** |   The DCP (Data Collection and Publishing) service supports first-party apps to upload data to cloud.
|   **Service name**    |   DcpSvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## DCOM Server Process Launcher         

| | |           
|---|---|       
|   **Service description** |   The DCOMLAUNCH service launches COM and DCOM servers in response to object activation requests. If this service is stopped or disabled, programs using COM or DCOM will not function properly. It is strongly recommended that you have the DCOMLAUNCH service running.
|   **Service name**    |   DcomLaunch
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  |No guidance    
|   **Comments**    |   
|||         

<br />

##  Device Association Service      

| | |           
|---|---|       
|   **Service description** |   Enables pairing between the system and wired or wireless devices.
|   **Service name**    |   DeviceAssociationService
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />

##  Device Install Service

| | |
|---|---|
|   **Service description** |   Enables a computer to recognize and adapt to hardware changes with little or no user input. Stopping or disabling this service will result in system instability.
|   **Service name**    |   DeviceInstall
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance
|   **Comments**    |
|||

<br />          

##  Device Management Enrollment Service        

| | |           
|---|---|       
|   **Service description** |   Performs Device Enrollment Activities for Device Management
|   **Service name**    |   DmEnrollmentSvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Device Setup Manager         

| | |           
|---|---|       
|   **Service description** |   Enables the detection, download and installation of device-related software. If this service is disabled, devices may be configured with outdated software, and may not work correctly.
|   **Service name**    |   DsmSvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## DevQuery Background Discovery Broker         

| | |           
|---|---|           
|   **Service description** |   Enables apps to discover devices with a backgroud task
|   **Service name**    |   DevQueryBroker
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## DHCP Client          

| | |           
|---|---|       
|   **Service description** |   Registers and updates IP addresses and DNS records for this computer. If this service is stopped, this computer will not receive dynamic IP addresses and DNS updates. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   Dhcp
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Diagnostic Policy Service            

| | |           
|---|---|       
|   **Service description** |   The Diagnostic Policy Service enables problem detection, troubleshooting and resolution for Windows components.  If this service is stopped, diagnostics will no longer function.
|   **Service name**    |   DPS
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Diagnostic Service Host     

| | |           
|---|---|       
|   **Service description** |   The Diagnostic Service Host is used by the Diagnostic Policy Service to host diagnostics that need to run in a Local Service context.  If this service is stopped, any diagnostics that depend on it will no longer function.
|   **Service name**    |   WdiServiceHost
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Diagnostic System Host           

| | |           
|---|---|       
|   **Service description** |   The Diagnostic System Host is used by the Diagnostic Policy Service to host diagnostics that need to run in a Local System context.  If this service is stopped, any diagnostics that depend on it will no longer function.
|   **Service name**    |   WdiSystemHost
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Distributed Link Tracking Client            

| | |           
|---|---|   
|   **Service description** |   Maintains links between NTFS files within a computer or across computers in a network.
|   **Service name**    |   TrkWks
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Distributed Transaction Coordinator     

| | |           
|---|---|   
|   **Service description** |   Coordinates transactions that span multiple resource managers, such as databases, message queues, and file systems. If this service is stopped, these transactions will fail. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   MSDTC
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />  

##  dmwappushsvc        

| | |           
|---|---|       
|   **Service description** |   WAP Push Message Routing Service
|   **Service name**    |   dmwappushservice
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   Service required on client devices for Intune, MDM and similar management technologies, and for Unified Write Filter. Not needed for Server.
|||         

<br />      

##  DNS Client      

| | |           
|---|---|       
|   **Service description** |   The DNS Client service (dnscache) caches Domain Name System (DNS) names and registers the full computer name for this computer. If the service is stopped, DNS names will continue to be resolved. However, the results of DNS name queries will not be cached and the computer's name will not be registered. If the service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   Dnscache
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Downloaded Maps Manager     

| | |           
|---|---|   
|   **Service description** |   Windows service for application access to downloaded maps. This service is started on-demand by application accessing downloaded maps. Disabling this service will prevent apps from accessing maps.
|   **Service name**    |   MapsBroker
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Automatic
|   **Recommendation**  |   OK to disable
|   **Comments**    |   Disabling breaks apps that rely on the service; OK to disable if apps not relying on it
|||         

<br />          

## Embedded Mode            

| | |           
|---|---|       
|   **Service description** |   The Embedded Mode service enables scenarios related to Background Applications.  Disabling this service will prevent Background Applications from being activated.
|   **Service name**    |   embeddedmode
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Encrypting File System (EFS)

| | |                   
|---|---|           
|   **Service description** | Provides the core file encryption technology used to store encrypted files on NTFS file system volumes. If this service is stopped or disabled, applications will be unable to access encrypted files.            
|   **Service name**  |  EFS            
|   **Installation**  |  Always installed           
|   **StartType**   |  Manual           
|   **Recommendation**  | No guidance           
|   **Comments**   |
|||                 

<br />  

## Enterprise App Management Service            

| | |           
|---|---|       
|   **Service description** |   Enables enterprise application management.
|   **Service name**    |   EntAppSvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Extensible Authentication Protocol           

| | |           
|---|---|   
|   **Service description** |   The Extensible Authentication Protocol (EAP) service provides network authentication in such scenarios as 802.1x wired and wireless, VPN, and Network Access Protection (NAP).  EAP also provides application programming interfaces (APIs) that are used by network access clients, including wireless and VPN clients, during the authentication process.  If you disable this service, this computer is prevented from accessing networks that require EAP authentication.
|   **Service name**    |   EapHost
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Function Discovery Provider Host         

| | |           
|---|---|       
|   **Service description** |   The FDPHOST service hosts the Function Discovery (FD) network discovery providers. These FD providers supply network discovery services for the Simple Services Discovery Protocol (SSDP) and Web Services - Discovery (WS-D) protocol. Stopping or disabling the FDPHOST service will disable network discovery for these protocols when using FD. When this service is unavailable, network services using FD and relying on these discovery protocols will be unable to find network devices or resources.
|   **Service name**    |   fdPHost
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Function Discovery Resource Publication      

| | |           
|---|---|       
|   **Service description** |   Publishes this computer and resources attached to this computer so they can be discovered over the network.  If this service is stopped, network resources will no longer be published and they will not be discovered by other computers on the network.
|   **Service name**    |   FDResPub
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Geolocation Service          

| | |           
|---|---|       
|   **Service description** |   This service monitors the current location of the system and manages geofences (a geographical location with associated events).  If you turn off this service, applications will be unable to use or receive notifications for geolocation or geofences.
|   **Service name**    |   lfsvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   Disabling breaks apps that rely on the service; OK to disable if apps not relying on it
|||         

<br />          

##  Group Policy Client     

| | |           
|---|---|       
|   **Service description** |   The service is responsible for applying settings configured by administrators for the computer and users through the Group Policy component. If the service is disabled, the settings will not be applied and applications and components will not be manageable through Group Policy. Any components or applications that depend on the Group Policy component might not be functional if the service is disabled.
|   **Service name**    |   gpsvc
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          


## Human Interface Device Service           

| | |           
|---|---|       
|   **Service description** |   Activates and maintains the use of hot buttons on keyboards, remote controls, and other multimedia devices. It is recommended that you keep this service running.
|   **Service name**    |   hidserv
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  HV Host Service     

| | |           
|---|---|   
|   **Service description** |   Provides an interface for the Hyper-V hypervisor to provide per-partition performance counters to the host operating system.
|   **Service name**    |   HvHost
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   Performance enhancers for guest VMs. Not used today except for explicitly populated VMs, but will be used in Application Guard
|||         

<br />          

## Hyper-V Data Exchange Service        

| | |           
|---|---|   
|   **Service description** |   Provides a mechanism to exchange data between the virtual machine and the operating system running on the physical computer.
|   **Service name**    |   vmickvpexchange
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   See HvHost
|||         

<br />      

## Hyper-V Guest Service Interface          

| | |           
|---|---|   
|   **Service description** |   Provides an interface for the Hyper-V host to interact with specific services running inside the virtual machine.
|   **Service name**    |   vmicguestinterface
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   See HvHost
|||         

<br />  

## Hyper-V Guest Shutdown Service           

| | |           
|---|---|       
|   **Service description** |   Provides a mechanism to shut down the operating system of this virtual machine from the management interfaces on the physical computer.
|   **Service name**    |   vmicshutdown
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   See HvHost
|||         

<br />

## Hyper-V Heartbeat Service
| | |
|---|---|
|   **Service description** |   Monitors the state of this virtual machine by reporting a heartbeat at regular intervals. This service helps you identify running virtual machines that have stopped responding.
|   **Service name**    |   vmicheartbeat
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   See HvHost
|||

<br />          

## Hyper-V PowerShell Direct Service            

| | |           
|---|---|       
|   **Service description** |   Provides a mechanism to manage virtual machine with PowerShell via VM session without a virtual network.
|   **Service name**    |   vmicvmsession
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   See HvHost
|||         

<br />          

## Hyper-V Remote Desktop Virtualization Service            

| | |           
|---|---|       
|   **Service description** |   Provides a platform for communication between the virtual machine and the operating system running on the physical computer.
|   **Service name**    |   vmicrdv
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   See HvHost
|||         

<br />          

## Hyper-V Time Synchronization Service         

| | |           
|---|---|       
|   **Service description** |   Synchronizes the system time of this virtual machine with the system time of the physical computer.
|   **Service name**    |   vmictimesync
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   See HvHost
|||         

<br />          

## Hyper-V Volume Shadow Copy Requestor         

| | |           
|---|---|           
|   **Service description** |   Coordinates the communications that are required to use Volume Shadow Copy Service to back up applications and data on this virtual machine from the operating system on the physical computer.
|   **Service name**    |   vmicvss
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   See HvHost
|||         

<br />          

## IKE and AuthIP IPsec Keying Modules          

| | |           
|---|---|       
|   **Service description** |   The IKEEXT service hosts the Internet Key Exchange (IKE) and Authenticated Internet Protocol (AuthIP) keying modules. These keying modules are used for authentication and key exchange in Internet Protocol security (IPsec). Stopping or disabling the IKEEXT service will disable IKE and AuthIP key exchange with peer computers. IPsec is typically configured to use IKE or AuthIP; therefore, stopping or disabling the IKEEXT service might result in an IPsec failure and might compromise the security of the system. It is strongly recommended that you have the IKEEXT service running.
|   **Service name**    |   IKEEXT
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |    
|||         

<br />          

## Interactive Services Detection           

| | |           
|---|---|   
|   **Service description** |   Enables user notification of user input for interactive services, which enables access to dialogs created by interactive services when they appear. If this service is stopped, notifications of new interactive service dialogs will no longer function and there might not be access to interactive service dialogs. If this service is disabled, both notifications of and access to new interactive service dialogs will no longer function.
|   **Service name**    |   UI0Detect
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />  

## Internet Connection Sharing (ICS)            

| | |           
|---|---|           
|   **Service description** |   Provides network address translation, addressing, name resolution and/or intrusion prevention services for a home or small office network.
|   **Service name**    |   SharedAccess
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   Required for clients used as WiFi hotspots, and also on both ends of Miracast projection. ICS can be blocked with GPO setting, "Prohibit use of Internet Connection Sharing on your DNS domain network"
|||         

<br />          

## IP Helper            

| | |           
|---|---|       
|   **Service description** |   Provides tunnel connectivity using IPv6 transition technologies (6to4, ISATAP, Port Proxy, and Teredo), and IP-HTTPS. If this service is stopped, the computer will not have the enhanced connectivity benefits that these technologies offer.
|   **Service name**    |   iphlpsvc
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          


##  IPsec Policy Agent      

| | |           
|---|---|       
|   **Service description** |   Internet Protocol security (IPsec) supports network-level peer authentication, data origin authentication, data integrity, data confidentiality (encryption), and replay protection.  This service enforces IPsec policies created through the IP Security Policies snap-in or the command-line tool "netsh ipsec".  If you stop this service, you may experience network connectivity issues if your policy requires that connections use IPsec.  Also, remote management of Windows Firewall is not available when this service is stopped.
|   **Service name**    |   PolicyAgent
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />

##  KDC Proxy Server service (KPS)      

| | |           
|---|---|       
|   **Service description** |   KDC Proxy Server service runs on edge servers to proxy Kerberos protocol messages to domain controllers on the corporate network.
|   **Service name**    |   KPSSVC
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance    
|   **Comments**    |   
|||         

<br />          

## KtmRm for Distributed Transaction Coordinator            

| | |           
|---|---|       
|   **Service description** |   Coordinates transactions between the Distributed Transaction Coordinator (MSDTC) and the Kernel Transaction Manager (KTM). If it is not needed, it is recommended that this service remain stopped. If it is needed, both MSDTC and KTM will start this service automatically. If this service is disabled, any MSDTC transaction interacting with a Kernel Resource Manager will fail and any services that explicitly depend on it will fail to start.
|   **Service name**    |   KtmRm
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />

##  Link-Layer Topology Discovery Mapper        

| | |       
|---|---|       
|   **Service description** |   Creates a Network Map, consisting of PC and device topology (connectivity) information, and metadata describing each PC and device.  If this service is disabled, the Network Map will not function properly.
|   **Service name**    |   lltdsvc
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   OK to disable if no dependencies on Network Map
|||         

<br />

## Local Session Manager                    

| | |                   
|---|---|   
|   **Service description** |   Core Windows Service that manages local user sessions. Stopping or disabling this service will result in system instability.    
|   **Service name**    |   LSM |
|   **Installation**    |   Always installed    |
|   **StartType**   |   Automatic   |
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||                 

<br />                  

## Microsoft (R) Diagnostics Hub Standard Collector         

| | |           
|---|---|           
|   **Service description** |   Core Windows Service that manages local user sessions. Stopping or disabling this service will result in system instability.
|   **Service name**    |   LSM
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />

## Microsoft Account Sign-in Assistant
| | |
|---|---|
|   **Service description** |   Enables user sign-in through Microsoft account identity services. If this service is stopped, users will not be able to log on to the computer with their Microsoft account.
|   **Service name**    |   wlidsvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   Microsoft Accounts are N/A on Windows Server
|||

<br />          

##  Microsoft App-V Client      

| | |           
|---|---|       
|   **Service description** |   Manages App-V users and virtual applications
|   **Service name**    |   AppVClient
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Disabled
|   **Recommendation**  |   Already disabled
|   **Comments**    |   
|||         

<br />          

## Microsoft iSCSI Initiator Service            

| | |           
|---|---|       
|   **Service description** |   Manages Internet SCSI (iSCSI) sessions from this computer to remote iSCSI target devices. If this service is stopped, this computer will not be able to login or access iSCSI targets. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   MSiSCSI
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   Our diagnostic data indicates this is used on client as well as server. No benefit to disabling this.
|||         

<br />          

## Microsoft Passport           

| | |           
|---|---|   
|   **Service description** |   Provides process isolation for cryptographic keys used to authenticate to a user's associated identity providers. If this service is disabled, all uses and management of these keys will not be available, which includes machine logon and single-sign on for apps and websites. This service starts and stops automatically. It is recommended that you do not reconfigure this service.
|   **Service name**    |   NgcSvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   Needed for PIN/Hello logons, which aren't supported on Server
|||         

<br />          

## Microsoft Passport Container         

| | |           
|---|---|       
|   **Service description** |   Manages local user identity keys used to authenticate user to identity providers as well as TPM virtual smart cards. If this service is disabled, local user identity keys and TPM virtual smart cards will not be accessible. It is recommended that you do not reconfigure this service.
|   **Service name**    |   NgcCtnrSvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   
|||         

<br />          

## Microsoft Software Shadow Copy Provider          

| | |           
|---|---|       
|   **Service description** |   Manages software-based volume shadow copies taken by the Volume Shadow Copy service. If this service is stopped, software-based volume shadow copies cannot be managed. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   swprv
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Microsoft Storage Spaces SMP         

| | |           
|---|---|       
|   **Service description** |   Host service for the Microsoft Storage Spaces management provider. If this service is stopped or disabled, Storage Spaces cannot be managed.
|   **Service name**    |   smphost
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   Storage management APIs fail without this service. Example: "Get-WmiObject -class MSFT_Disk -Namespace Root\Microsoft\Windows\Storage".
|||         

<br />          

## Net.Tcp Port Sharing Service         

| | |           
|---|---|       
|   **Service description** |   Provides ability to share TCP ports over the net.tcp protocol.
|   **Service name**    |   NetTcpPortSharing
|   **Installation**    |   Always installed
|   **StartType**   |   Disabled
|   **Recommendation**  |   Already disabled
|   **Comments**    |   
|||         

<br />          

## Netlogon         

| | |           
|---|---|           
|   **Service description** |   Maintains a secure channel between this computer and the domain controller for authenticating users and services. If this service is stopped, the computer may not authenticate users and services and the domain controller cannot register DNS records. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   Netlogon
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Network Connection Broker            

| | |           
|---|---|       
|   **Service description** |   Brokers connections that allow Microsoft Store Apps to receive notifications from the internet.
|   **Service name**    |   NcbService
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   
|||         

<br />          

##  Network Connections         

| | |           
|---|---|   
|   **Service description** |   Manages objects in the Network and Dial-Up Connections folder, in which you can view both local area network and remote connections.
|   **Service name**    |   Netman
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Network Connectivity Assistant      

| | |           
|---|---|       
|   **Service description** |   Provides DirectAccess status notification for UI components
|   **Service name**    |   NcaSvc
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />  

##  Network List Service        

| | |           
|---|---|   
|   **Service description** |   Identifies the networks to which the computer has connected, collects and stores properties for these networks, and notifies applications when these properties change.
|   **Service name**    |   netprofm
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Network Location Awareness           

| | |           
|---|---|       
|   **Service description** |   Collects and stores configuration information for the network and notifies programs when this information is modified. If this service is stopped, configuration information might be unavailable. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   NlaSvc
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Network Setup Service       

| | |           
|---|---|       
|   **Service description** |   The Network Setup Service manages the installation of network drivers and permits the configuration of low-level network settings.  If this service is stopped, any driver installations that are in-progress may be cancelled.
|   **Service name**    |   NetSetupSvc
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Network Store Interface Service      

| | |           
|---|---|   
|   **Service description** |   This service delivers network notifications (e.g. interface addition/deleting etc) to user mode clients. Stopping this service will cause loss of network connectivity. If this service is disabled, any other services that explicitly depend on this service will fail to start.
|   **Service name**    |   nsi
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Offline Files            

| | |           
|---|---|       
|   **Service description** |   The Offline Files service performs maintenance activities on the Offline Files cache, responds to user logon and logoff events, implements the internals of the public API, and dispatches interesting events to those interested in Offline Files activities and changes in cache state.
|   **Service name**    |   CscService
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Disabled
|   **Recommendation**  |   Already disabled
|   **Comments**    |   
|||         

<br />          

## Optimize drives          

| | |           
|---|---|   
|   **Service description** |   Helps the computer run more efficiently by optimizing files on storage drives.
|   **Service name**    |   defragsvc
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />

## Performance Counter DLL Host         

| | |           
|---|---|       
|   **Service description** |   Enables remote users and 64-bit processes to query performance counters provided by 32-bit DLLs. If this service is stopped, only local users and 32-bit processes will be able to query performance counters provided by 32-bit DLLs.
|   **Service name**    |   PerfHost
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance    
|   **Comments**    |   
|||         

<br />          

## Performance Logs & Alerts            

| | |           
|---|---|   
|   **Service description** |   Performance Logs and Alerts Collects performance data from local or remote computers based on preconfigured schedule parameters, then writes the data to a log or triggers an alert. If this service is stopped, performance information will not be collected. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   pla
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Phone Service       

| | |           
|---|---|   
|   **Service description** |   Manages the telephony state on the device
|   **Service name**    |   PhoneSvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   Used by modern VoIP apps
|||         

<br />          

##      Plug and Play       

| | |           
|---|---|   
|   **Service description** |   Enables a computer to recognize and adapt to hardware changes with little or no user input. Stopping or disabling this service will result in system instability.
|   **Service name**    |   PlugPlay
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Portable Device Enumerator Service           

| | |           
|---|---|       
|   **Service description** |   Enforces group policy for removable mass-storage devices. Enables applications such as Windows Media Player and Image Import Wizard to transfer and synchronize content using removable mass-storage devices.
|   **Service name**    |   WPDBusEnum
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Power            

| | |           
|---|---|       
|   **Service description** |   Manages power policy and power policy notification delivery.
|   **Service name**    |   Power
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Print Spooler            

| | |           
|---|---|   
|   **Service description** |   This service spools print jobs and handles interaction with the printer.  If you turn off this service, you won't be able to print or see your printers.
|   **Service name**    |   Spooler
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  |   OK to disable if not a print server or a DC
|   **Comments**    |   On a domain controller, the installation of the DC role adds a thread to the spooler service that is responsible for performing print pruning – removing the stale print queue objects from the Active Directory.  If the spooler service is not running on at least one DC in each site, then the AD has no means to remove old queues that no longer exist. https://blogs.technet.microsoft.com/askperf/2008/11/18/disabling-unnecessary-services-a-word-to-the-wise/
|||         

<br />          

##  Printer Extensions and Notifications        

| | |           
|---|---|       
|   **Service description** |   This service opens custom printer dialog boxes and handles notifications from a remote print server or a printer. If you turn off this service, you won't be able to see printer extensions or notifications.
|   **Service name**    |   PrintNotify
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable if not a print server
|   **Comments**    |   
|||         

<br />          

##  Problem Reports and Solutions Control Panel Support     

| | |           
|---|---|   
|   **Service description** |   This service provides support for viewing, sending and deletion of system-level problem reports for the Problem Reports and Solutions control panel.
|   **Service name**    |   wercplsupport
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Program Compatibility Assistant Service     

| | |           
|---|---|       
|   **Service description** |   This service provides support for the Program Compatibility Assistant (PCA).  PCA monitors programs installed and run by the user and detects known compatibility problems. If this service is stopped, PCA will not function properly.
|   **Service name**    |   PcaSvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Automatic
|   **Recommendation**  |   OK to disable
|   **Comments**    |   
|||         

<br />          

##  Quality Windows Audio Video Experience      

| | |           
|---|---|   
|   **Service description** |   Quality Windows Audio Video Experience (qWave) is a networking platform for Audio Video (AV) streaming applications on IP home networks. qWave enhances AV streaming performance and reliability by ensuring network quality-of-service (QoS) for AV applications. It provides mechanisms for admission control, run time monitoring and enforcement, application feedback, and traffic prioritization.
|   **Service name**    |   QWAVE
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   Client-side QoS service
|||         

<br />          

##      Radio Management Service        

| | |           
|---|---|   
|   **Service description** |   Radio Management and Airplane Mode Service
|   **Service name**    |   RmSvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   
|||         

<br />          

## Remote Access Auto Connection Manager            

| | |           
|---|---|   
|   **Service description** |   Creates a connection to a remote network whenever a program references a remote DNS or NetBIOS name or address.
|   **Service name**    |   RasAuto
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Remote Access Connection Manager         

| | |           
|---|---|   
|   **Service description** |   Manages dial-up and virtual private network (VPN) connections from this computer to the Internet or other remote networks. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   RasMan
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Remote Desktop Configuration         

| | |           
|---|---|   
|   **Service description** |   Remote Desktop Configuration service (RDCS) is responsible for all Remote Desktop Services and Remote Desktop related configuration and session maintenance activities that require SYSTEM context. These include per-session temporary folders, RD themes, and RD certificates.
|   **Service name**    |   SessionEnv
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   
|||         

<br />          

## Remote Desktop Services          

| | |           
|---|---|   
|   **Service description** |   Allows users to connect interactively to a remote computer. Remote Desktop and Remote Desktop Session Host Server depend on this service.  To prevent remote use of this computer, clear the checkboxes on the Remote tab of the System properties control panel item.
|   **Service name**    |   TermService
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   
|||         

<br />          

##  Remote Desktop Services UserMode Port Redirector        

| | |           
|---|---|   
|   **Service description** |   Allows the redirection of Printers/Drives/Ports for RDP connections
|   **Service name**    |   UmRdpService
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   Supports redirections on the server side of the connection.
|||         

<br />          

## Remote Procedure Call (RPC)          

| | |           
|---|---|   
|   **Service description** |   The RPCSS service is the Service Control Manager for COM and DCOM servers. It performs object activations requests, object exporter resolutions and distributed garbage collection for COM and DCOM servers. If this service is stopped or disabled, programs using COM or DCOM will not function properly. It is strongly recommended that you have the RPCSS service running.
|   **Service name**    |   RpcSs
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Remote Procedure Call (RPC) Locator             

| | |               
|---|---|   
|   **Service description** |   In Windows 2003 and earlier versions of Windows, the Remote Procedure Call (RPC) Locator service manages the RPC name service database. In Windows Vista and later versions of Windows, this service does not provide any functionality and is present for application compatibility.   |
|   **Service name**    |   RpcLocator  |
|   **Installation**    |   Only with Desktop Experience    |
|   **StartType**   |   Manual  |
|   **Recommendation**  | No guidance   |
|   **Comments**    |       |
|||             

<br />              

## Remote Registry          

| | |           
|---|---|   
|   **Service description** |   Enables remote users to modify registry settings on this computer. If this service is stopped, the registry can be modified only by users on this computer. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   RemoteRegistry
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  |   Do not disable
|   **Comments**    |   
|||         

<br />          

##  Resultant Set of Policy Provider            

| | |           
|---|---|       
|   **Service description** |   Provides a network service that processes requests to simulate application of Group Policy settings for a target user or computer in various situations and computes the Resultant Set of Policy settings.
|   **Service name**    |   RSoPProv
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |No guidance    
|   **Comments**    |   
|||         

<br />          

## Routing and Remote Access            

| | |           
|---|---|   
|   **Service description** |   Offers routing services to businesses in local area and wide area network environments.
|   **Service name**    |   RemoteAccess
|   **Installation**    |   Always installed
|   **StartType**   |   Disabled
|   **Recommendation**  |   Already disabled
|   **Comments**    |   Already disabled
|||         

<br />          

## RPC Endpoint Mapper          

| | |           
|---|---|   
|   **Service description** |   Resolves RPC interfaces identifiers to transport endpoints. If this service is stopped or disabled, programs using Remote Procedure Call (RPC) services will not function properly.
|   **Service name**    |   RpcEptMapper
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Secondary Logon     

| | |           
|---|---|       
|   **Service description** |   Enables starting processes under alternate credentials. If this service is stopped, this type of logon access will be unavailable. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   seclogon
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Secure Socket Tunneling Protocol Service            

| | |               
|---|---|       
|   **Service description** |   Provides support for the Secure Socket Tunneling Protocol (SSTP) to connect to remote computers using VPN. If this service is disabled, users will not be able to use SSTP to access remote servers.    |
|   **Service name**    |   SstpSvc |
|   **Installation**    |   Always installed    |
|   **StartType**   |   Manual  |
|   **Recommendation**  |   Do not disable  |
|   **Comments**    |   Disabling breaks RRAS   |
|||             

<br />              

## Security Accounts Manager            

| | |           
|---|---|       
|   **Service description** |   The startup of this service signals other services that the Security Accounts Manager (SAM) is ready to accept requests.  Disabling this service will prevent other services in the system from being notified when the SAM is ready, which may in turn cause those services to fail to start correctly. This service should not be disabled.
|   **Service name**    |   SamSs
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | Do not disable
|   **Comments**    |   
|||         

<br />          

## Sensor Data Service  

| | |           
|---|---|   
|   **Service description** |   Delivers data from a variety of sensors
|   **Service name**    |   SensorDataService
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   
|||         

<br />  

## Sensor Monitoring Service            

| | |           
|---|---|       
|   **Service description** |   Monitors various sensors in order to expose data and adapt to system and user state.  If this service is stopped or disabled, the display brightness will not adapt to lighting conditions. Stopping this service may affect other system functionality and features as well.
|   **Service name**    |   SensrSvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   
|||         

<br /><br/>
## Sensor Service<br/>| | |<br/>|---|---|<br/>|   <strong>Service description</strong> |   A service for sensors that manages different sensors&#39; functionality. Manages Simple Device Orientation (SDO) and History for sensors. Loads the SDO sensor that reports device orientation changes.  If this service is stopped or disabled, the SDO sensor will not be loaded and so auto-rotation will not occur. History collection from Sensors will also be stopped.
|   <strong>Service name</strong>    |   SensorService
|   <strong>Installation</strong>    |   Only with Desktop Experience
|   <strong>StartType</strong>   |   Manual
|   <strong>Recommendation</strong>  |   OK to disable
|   <strong>Comments</strong>    |<br/>|||<br/>
<br />          

## Server           

| | |           
|---|---|   
|   **Service description** |   Supports file, print, and named-pipe sharing over the network for this computer. If this service is stopped, these functions will be unavailable. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   LanmanServer
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  |   Do not disable
|   **Comments**    |   Needed for remote management, IPC$, SMB file sharing
|||         

<br />          

## Shell Hardware Detection             

| | |           
|---|---|       
|   **Service description** |   Provides notifications for AutoPlay hardware events.
|   **Service name**    |   ShellHWDetection
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Automatic
|   **Recommendation**  |   OK to disable
|   **Comments**    |   
|||         

<br />          

## Smart Card           

| | |           
|---|---|   
|   **Service description** |   Manages access to smart cards read by this computer. If this service is stopped, this computer will be unable to read smart cards. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   SCardSvr
|   **Installation**    |   Always installed
|   **StartType**   |   Disabled
|   **Recommendation**  |   Already disabled
|   **Comments**    |   
|||         

<br />          

## Smart Card Device Enumeration Service                    

| | |               
|---|---|       
|   **Service description** |   Creates software device nodes for all smart card readers accessible to a given session. If this service is disabled, WinRT APIs will not be able to enumerate smart card readers.   |
|   **Service name**    |   ScDeviceEnum    |
|   **Installation**    |   Always installed    |
|   **StartType**   |   Manual  |
|   **Recommendation**  |   OK to disable   |
|   **Comments**    |   Needed almost exclusively for WinRT apps    |
|||             

<br />              

## Smart Card Removal Policy        

| | |           
|---|---|       
|   **Service description** |   Allows the system to be configured to lock the user desktop upon smart card removal.
|   **Service name**    |   SCPolicySvc
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## SNMP Trap            

| | |           
|---|---|       
|   **Service description** |   Receives trap messages generated by local or remote Simple Network Management Protocol (SNMP) agents and forwards the messages to SNMP management programs running on this computer. If this service is stopped, SNMP-based programs on this computer will not receive SNMP trap messages. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   SNMPTRAP
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Software Protection             

| | |           
|---|---|       
|   **Service description** |   Enables the download, installation and enforcement of digital licenses for Windows and Windows applications. If the service is disabled, the operating system and licensed applications may run in a notification mode. It is strongly recommended that you not disable the Software Protection service.
|   **Service name**    |   sppsvc
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Special Administration Console Helper        

| | |           
|---|---|   
|   **Service description** |   Allows administrators to remotely access a command prompt using Emergency Management Services.
|   **Service name**    |   sacsvr
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Spot Verifier            

| | |           
|---|---|   
|   **Service description** |   Verifies potential file system corruptions.
|   **Service name**    |   svsvc
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## SSDP Discovery           

| | |           
|---|---|   
|   **Service description** |   Discovers networked devices and services that use the SSDP discovery protocol, such as UPnP devices. Also announces SSDP devices and services running on the local computer. If this service is stopped, SSDP-based devices will not be discovered. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   SSDPSRV
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   
|||         

<br />          

## State Repository Service         

| | |           
|---|---|   
|   **Service description** |   Provides required infrastructure support for the application model.
|   **Service name**    |   StateRepository
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Still Image Acquisition Events

| | |           
|---|---|   
|   **Service description** |   Launches applications associated with still image acquisition events.
|   **Service name**    |   WiaRpc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   
|||         

<br />  

## Storage Service          

| | |           
|---|---|       
|   **Service description** |   Provides enabling services for storage settings and external storage expansion
|   **Service name**    |   StorSvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Storage Tiers Management        

| | |           
|---|---|   
|   **Service description** |   Optimizes the placement of data in storage tiers on all tiered storage spaces in the system.
|   **Service name**    |   TieringEngineService
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Superfetch          

| | |           
|---|---|       
|   **Service description** |   Maintains and improves system performance over time.
|   **Service name**    |   SysMain
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Sync Host            

| | |           
|---|---|       
|   **Service description** |   This service synchronizes mail, contacts, calendar and various other user data. Mail and other applications dependent on this functionality will not work properly when this service is not running.
|   **Service name**    |   OneSyncSvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Automatic
|   **Recommendation**  |   OK to disable
|   **Comments**    |   User service template
|||         

<br />          

## System Event Notification Service            

| | |           
|---|---|       
|   **Service description** |   Monitors system events and notifies subscribers to COM+ Event System of these events.
|   **Service name**    |   SENS
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## System Events Broker             

| | |           
|---|---|       
|   **Service description** |   Coordinates execution of background work for WinRT application. If this service is stopped or disabled, then background work might not be triggered.
|   **Service name**    |   SystemEventsBroker
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  |   Do not disable
|   **Comments**    |   In spite of the fact that its description implies it is only for WinRT apps, it's needed for task scheduler, broker infrastructure service, and other internal components.
|||         

<br />          

## Task Scheduler           

| | |           
|---|---|   
|   **Service description** |   Enables a user to configure and schedule automated tasks on this computer. The service also hosts multiple Windows system-critical tasks. If this service is stopped or disabled, these tasks will not be run at their scheduled times. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   Schedule
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## TCP/IP NetBIOS Helper            

| | |           
|---|---|   
|   **Service description** |   Provides support for the NetBIOS over TCP/IP (NetBT) service and NetBIOS name resolution for clients on the network, therefore enabling users to share files, print, and log on to the network. If this service is stopped, these functions might be unavailable. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   lmhosts
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Telephony           

| | |           
|---|---|       
|   **Service description** |   Provides Telephony API (TAPI) support for programs that control telephony devices on the local computer and, through the LAN, on servers that are also running the service.
|   **Service name**    |   TapiSrv
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   Disabling breaks RRAS
|||         

<br />          

## Themes           

| | |           
|---|---|
|   **Service description** |   Provides user experience theme management.
|   **Service name**    |   Themes
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Automatic
|   **Recommendation**  |   Do not disable
|   **Comments**    |   Can't set accessibility themes when this service is disabled
|||         

<br />  

## Tile Data model server           

| | |           
|---|---|   
|   **Service description** |   Tile Server for tile updates.
|   **Service name**    |   tiledatamodelsvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Automatic
|   **Recommendation**  |   Do not disable
|   **Comments**    |   Start menu breaks if this service is disabled
|||         

<br />          

##  Time Broker     

| | |           
|---|---|       
|   **Service description** |   Coordinates execution of background work for WinRT application. If this service is stopped or disabled, then background work might not be triggered.
|   **Service name**    |   TimeBrokerSvc
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   In spite of the fact that its description implies it is only for WinRT apps, it's needed for task scheduler, broker infrastructure service, and other internal components.
|||         

<br />          

## Touch Keyboard and Handwriting Panel Service         

| | |           
|---|---|   
|   **Service description** |   Enables Touch Keyboard and Handwriting Panel pen and ink functionality
|   **Service name**    |   TabletInputService
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   
|||         

<br />          

## Update Orchestrator Service for Windows Update           

| | |           
|---|---|       
|   **Service description** |   Manages Windows Updates. If stopped, your devices will not be able to download and install latest updates.
|   **Service name**    |   UsoSvc
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   Service description was missing in v1607; Windows Update (incl. WSUS) depends on this service.
|||         

<br />          

## UPnP Device Host         

| | |           
|---|---|   
|   **Service description** |   Allows UPnP devices to be hosted on this computer. If this service is stopped, any hosted UPnP devices will stop functioning and no additional hosted devices can be added. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   upnphost
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   
|||         

<br />          

## User Access Logging Service          

| | |           
|---|---|   
|   **Service description** |   This service logs unique client access requests, in the form of IP addresses and user names, of installed products and roles on the local server. This information can be queried, via Powershell, by administrators needing to quantify client demand of server software for offline Client Access License (CAL) management. If the service is disabled, client requests will not be logged and will not be retrievable via Powershell queries. Stopping the service will not affect query of historical data (see supporting documentation for steps to delete historical data). The local system administrator must consult his, or her, Windows Server license terms to determine the number of CALs that are required for the server software to be appropriately licensed; use of the UAL service and data does not alter this obligation.
|   **Service name**    |   UALSVC
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  User Data Access        

| | |           
|---|---|   
|   **Service description** |   Provides apps access to structured user data, including contact info, calendars, messages, and other content. If you stop or disable this service, apps that use this data might not work correctly.
|   **Service name**    |   UserDataSvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   User service template
|||         

<br />          

## User Data Storage            

| | |           
|---|---|       
|   **Service description** |   Handles storage of structured user data, including contact info, calendars, messages, and other content. If you stop or disable this service, apps that use this data might not work correctly.
|   **Service name**    |   UnistoreSvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   User service template
|||         

<br />          

## User Experience Virtualization Service           

| | |           
|---|---|       
|   **Service description** |   Provides support for application and OS settings roaming
|   **Service name**    |   UevAgentService
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Disabled
|   **Recommendation**  |   Already disabled
|   **Comments**    |   
|||         

<br />          

##  User Manager        

| | |           
|---|---|   
|   **Service description** |   User Manager provides the runtime components required for multi-user interaction.  If this service is stopped, some applications may not operate correctly.
|   **Service name**    |   UserManager
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## User Profile Service         

| | |           
|---|---|   
|   **Service description** |   This service is responsible for loading and unloading user profiles. If this service is stopped or disabled, users will no longer be able to successfully sign in or sign out, apps might have problems getting to users' data, and components registered to receive profile event notifications won't receive them.
|   **Service name**    |   ProfSvc
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Virtual Disk             

| | |           
|---|---|   
|   **Service description** |   Provides management services for disks, volumes, file systems, and storage arrays.
|   **Service name**    |   vds
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   No guidance
|   **Comments**    |   
|||         

<br />          

## Volume Shadow Copy           

| | |           
|---|---|   
|   **Service description** |   Manages and implements Volume Shadow Copies used for backup and other purposes. If this service is stopped, shadow copies will be unavailable for backup and the backup may fail. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   VSS
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   No guidance
|   **Comments**    |   
|||         

<br />          

##  WalletService           

| | |           
|---|---|   
|   **Service description** |   Hosts objects used by clients of the wallet
|   **Service name**    |   WalletService
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   
|||         

<br />          

## Windows Audio            

| | |           
|---|---|       
|   **Service description** |   Manages audio for Windows-based programs.  If this service is stopped, audio devices and effects will not function properly.  If this service is disabled, any services that explicitly depend on it will fail to start
|   **Service name**    |   Audiosrv
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   
|||         

<br />          

## Windows Audio Endpoint Builder           

| | |           
|---|---|
|   **Service description** |   Manages audio devices for the Windows Audio service.  If this service is stopped, audio devices and effects will not function properly.  If this service is disabled, any services that explicitly depend on it will fail to start
|   **Service name**    |   AudioEndpointBuilder
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   
|||         

<br />          

## Windows Biometric Service            

| | |           
|---|---|   
|   **Service description** |   The Windows biometric service gives client applications the ability to capture, compare, manipulate, and store biometric data without gaining direct access to any biometric hardware or samples. The service is hosted in a privileged SVCHOST process.
|   **Service name**    |   WbioSrvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Windows Camera Frame Server         

| | |           
|---|---|       
|   **Service description** |   Enables multiple clients to access video frames from camera devices.
|   **Service name**    |   FrameServer
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   
|||         

<br />          

## Windows Connection Manager           

| | |           
|---|---|   
|   **Service description** |   Makes automatic connect/disconnect decisions based on the network connectivity options currently available to the PC and enables management of network connectivity based on Group Policy settings.
|   **Service name**    |   Wcmsvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Windows Defender Network Inspection Service          

| | |           
|---|---|       
|   **Service description** |   Helps guard against intrusion attempts targeting known and newly discovered vulnerabilities in network protocols
|   **Service name**    |   WdNisSvc
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance    
|   **Comments**    |   
|||         

<br />          

## Windows Defender Service         

| | |           
|---|---|       
|   **Service description** |   Helps protect users from malware and other potentially unwanted software
|   **Service name**    |   WinDefend
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Windows Driver Foundation - User-mode Driver Framework           

| | |           
|---|---|   
|   **Service description** |   Creates and manages user-mode driver processes. This service cannot be stopped.
|   **Service name**    |   wudfsvc
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Windows Encryption Provider Host Service     

| | |           
|---|---|   
|   **Service description** |   Windows Encryption Provider Host Service brokers encryption related functionalities from third-party Encryption Providers to processes that need to evaluate and apply EAS policies. Stopping this will compromise EAS compliancy checks that have been established by the connected Mail Accounts
|   **Service name**    |   WEPHOSTSVC
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Windows Error Reporting Service          

| | |           
|---|---|       
|   **Service description** |   Allows errors to be reported when programs stop working or responding and allows existing solutions to be delivered. Also allows logs to be generated for diagnostic and repair services. If this service is stopped, error reporting might not work correctly and results of diagnostic services and repairs might not be displayed.
|   **Service name**    |   WerSvc
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   Collects and sends crash/hang data used by both MS and third party ISVs/IHVs. The data is used to diagnose crash-inducing bugs, which may include security bugs. Also needed for Corporate Error Reporting
|||         

<br />          

## Windows Event Collector          

| | |           
|---|---|   
|   **Service description** |   This service manages persistent subscriptions to events from remote sources that support WS-Management protocol. This includes Windows Vista event logs, hardware and IPMI-enabled event sources. The service stores forwarded events in a local Event Log. If this service is stopped or disabled event subscriptions cannot be created and forwarded events cannot be accepted.
|   **Service name**    |   Wecsvc
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   Collects ETW events (including security events) for manageability, diagnostics.  Lots of features and third-party tools rely on it, including security audit tools
|||         

<br />          

## Windows Event Log            

| | |           
|---|---|       
|   **Service description** |   This service manages events and event logs. It supports logging events, querying events, subscribing to events, archiving event logs, and managing event metadata. It can display events in both XML and plain text format. Stopping this service may compromise security and reliability of the system.
|   **Service name**    |   EventLog
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Windows Firewall         

| | |           
|---|---|   
|   **Service description** |   Windows Firewall helps protect your computer by preventing unauthorized users from gaining access to your computer through the Internet or a network.
|   **Service name**    |   MpsSvc
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Windows Font Cache Service      

| | |           
|---|---|   
|   **Service description** |   Optimizes performance of applications by caching commonly used font data. Applications will start this service if it is not already running. It can be disabled, though doing so will degrade application performance.
|   **Service name**    |   FontCache
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Windows Image Acquisition (WIA)          

| | |           
|---|---|   
|   **Service description** |   Provides image acquisition services for scanners and cameras
|   **Service name**    |   stisvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   
|||         

<br />          

##  Windows Insider Service     

| | |           
|---|---|   
|   **Service description** |   wisvc
|   **Service name**    |   wisvc
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   Server doesn't support flighting, so it's a no-op on Server. Feature can be disabled via GP as well.
|||         

<br />          

##  Windows Installer       

| | |           
|---|---|
|   **Service description** |   Adds, modifies, and removes applications provided as a Windows Installer (*.msi, *.msp) package. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   msiserver
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Windows License Manager Service          

| | |           
|---|---|   
|   **Service description** |   Provides infrastructure support for the Microsoft Store.  This service is started on demand and if disabled then content acquired through the Microsoft Store will not function properly.
|   **Service name**    |   LicenseManager
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Windows Management Instrumentation       

| | |           
|---|---|       
|   **Service description** |   Provides a common interface and object model to access management information about operating system, devices, applications and services. If this service is stopped, most Windows-based software will not function properly. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   Winmgmt
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

##  Windows Mobile Hotspot Service          

| | |           
|---|---|       
|   **Service description** |   Provides the ability to share a cellular data connection with another device.
|   **Service name**    |   icssvc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   
|||         

<br />          

## Windows Modules Installer        

| | |           
|---|---|   
|   **Service description** |   Enables installation, modification, and removal of Windows updates and optional components. If this service is disabled, install or uninstall of Windows updates might fail for this computer.
|   **Service name**    |   TrustedInstaller
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## Windows Push Notifications System Service            

| | |           
|---|---|
|   **Service description** |   This service runs in session 0 and hosts the notification platform and connection provider which handles the connection between the device and WNS server.
|   **Service name**    |   WpnService
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Automatic
|   **Recommendation**  |   OK to disable
|   **Comments**    |   Needed for live tiles and other features
|||         

<br />      

## Windows Push Notifications User Service          

| | |           
|---|---|   
|   **Service description** |   This service hosts Windows notification platform which provides support for local and push notifications. Supported notifications are tile, toast and raw.
|   **Service name**    |   WpnUserService
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   OK to disable
|   **Comments**    |   User service template
|||         

<br />

## Windows Remote Management (WS-Management)
| | |
|---|---|
|   **Service description** |   Windows Remote Management (WinRM) service implements the WS-Management protocol for remote management. WS-Management is a standard web services protocol used for remote software and hardware management. The WinRM service listens on the network for WS-Management requests and processes them. The WinRM Service needs to be configured with a listener using winrm.cmd command line tool or through Group Policy in order for it to listen over the network. The WinRM service provides access to WMI data and enables event collection. Event collection and subscription to events require that the service is running. WinRM messages use HTTP and HTTPS as transports. The WinRM service does not depend on IIS but is preconfigured to share a port with IIS on the same machine.  The WinRM service reserves the /wsman URL prefix. To prevent conflicts with IIS, administrators should ensure that any websites hosted on IIS do not use the /wsman URL prefix.
|   **Service name**    |   WinRM
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  |   Do not disable
|   **Comments**    |   Needed for remote management
|||

<br />          

##  Windows Search      

| | |           
|---|---|       
|   **Service description** |   Provides content indexing, property caching, and search results for files, e-mail, and other content.
|   **Service name**    |   WSearch
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Disabled
|   **Recommendation**  |   Already disabled
|   **Comments**    |   
|||         

<br />          

##  Windows Time        

| | |           
|---|---|   
|   **Service description** |   Maintains date and time synchronization on all clients and servers in the network. If this service is stopped, date and time synchronization will be unavailable. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   W32Time
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance
|   **Comments**    |   
|||         

<br />          

## Windows Update           

| | |           
|---|---|       
|   **Service description** |   Enables the detection, download, and installation of updates for Windows and other programs. If this service is disabled, users of this computer will not be able to use Windows Update or its automatic updating feature, and programs will not be able to use the Windows Update Agent (WUA) API.
|   **Service name**    |   wuauserv
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## WinHTTP Web Proxy Auto-Discovery Service         

| | |           
|---|---|   
|   **Service description** |   WinHTTP implements the client HTTP stack and provides developers with a Win32 API and COM Automation component for sending HTTP requests and receiving responses. In addition, WinHTTP provides support for auto-discovering a proxy configuration via its implementation of the Web Proxy Auto-Discovery (WPAD) protocol.
|   **Service name**    |   WinHttpAutoProxySvc
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  |   Do not disable
|   **Comments**    |   Anything that uses the network stack can have a functional dependency on this service. Many organizations rely on this to configure their internal networks' HTTP proxy routing.  Without it, internally-originating HTTP connections to the Internet will all fail.
|||         

<br />          

## Wired AutoConfig         

| | |           
|---|---|       
|   **Service description** |   The Wired AutoConfig (DOT3SVC) service is responsible for performing IEEE 802.1X authentication on Ethernet interfaces. If your current wired network deployment enforces 802.1X authentication, the DOT3SVC service should be configured to run for establishing Layer 2 connectivity and/or providing access to network resources. Wired networks that do not enforce 802.1X authentication are unaffected by the DOT3SVC service.
|   **Service name**    |   dot3svc
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance   
|   **Comments**    |   
|||         

<br />          

## WMI Performance Adapter          

| | |           
|---|---|   
|   **Service description** |   Provides performance library information from Windows Management Instrumentation (WMI) providers to clients on the network. This service only runs when Performance Data Helper is activated.
|   **Service name**    |   wmiApSrv
|   **Installation**    |   Always installed
|   **StartType**   |   Manual
|   **Recommendation**  | No guidance       
|   **Comments**    |   
|||         

<br />          

## Workstation          

| | |           
|---|---|   
|   **Service description** |   Creates and maintains client network connections to remote servers using the SMB protocol. If this service is stopped, these connections will be unavailable. If this service is disabled, any services that explicitly depend on it will fail to start.
|   **Service name**    |   LanmanWorkstation
|   **Installation**    |   Always installed
|   **StartType**   |   Automatic
|   **Recommendation**  | No guidance       
|   **Comments**    |   
|||         

<br />

## Xbox Live Auth Manager           

| | |           
|---|---|   
|   **Service description** |   Provides authentication and authorization services for interacting with Xbox Live. If this service is stopped, some applications may not operate correctly.
|   **Service name**    |   XblAuthManager
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   Should be disabled
|   **Comments**    |   
|||         

<br />          

## Xbox Live Game Save          

| | |           
|---|---|   
|   **Service description** |   This service syncs save data for Xbox Live save enabled games.  If this service is stopped, game save data will not upload to or download from Xbox Live.
|   **Service name**    |   XblGameSave
|   **Installation**    |   Only with Desktop Experience
|   **StartType**   |   Manual
|   **Recommendation**  |   Should be disabled
|   **Comments**    |   This service syncs save data for Xbox Live save enabled games.  If this service is stopped, game save data will not upload to or download from Xbox Live.
|||         

<br /> 
<br /> 

