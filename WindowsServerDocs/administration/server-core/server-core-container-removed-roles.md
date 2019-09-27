---
title: Roles, Role Services, and Features not in Server Core containers - Windows Server, version 1803
description: Learn about the roles and features we removed from the Server Core container image for Windows Server.
ms.prod: windows-server
ms.mktglfcycl: manage
ms.sitesec: library
author: lizap
ms.localizationpriority: medium
ms.date: 05/07/2018
---
# Roles, Role Services, and Features not in Server Core containers - Windows Server, version 1803

> Applies to: Windows Server, version 1803

In Windows Server, version 1803, we've [reduced the overall size of the Server Core container image to **1.58 GB**](https://blogs.technet.microsoft.com/virtualization/2018/01/22/a-smaller-windows-server-core-container-with-better-application-compatibility/). The way we've done this is by optimizing the architecture and removing things you don't need in a [Server Core container](https://docs.microsoft.com/virtualization/windowscontainers/about/). Some were things that didn't work in containers, some were roles and features no one's been using. 

> [!IMPORTANT]
> We removed these from the Server Core **container** image, not [Server Core itself](server-core-roles-and-services.md). 

Here's the complete list of features and roles removed from the Server Core container image:

<div style='font-size:9.0pt'>

<br>ADCertificateServicesRole
<br>AuthManager
<br>Bitlocker-Utilities
<br>BitLocker
<br>BITS
<br>BITSExtensions-Upload
<br>CCFFilter
<br>CertificateEnrollmentPolicyServer
<br>CertificateEnrollmentServer
<br>CertificateServices
<br>ClientForNFS-Infrastructure
<br>Containers
<br>CoreFileServer
<br>DataCenterBridging-LLDP-Tools
<br>DataCenterBridging
<br>Dedup-Core
<br>DeviceHealthAttestationService
<br>DFSN-Server
<br>DFSR-Infrastructure-ServerEdition
<br>DirectoryServices-ADAM
<br>DirectoryServices-DomainController
<br>DiskIo-QoS
<br>EnhancedStorage
<br>FailoverCluster-AdminPak
<br>FailoverCluster-AutomationServer
<br>FailoverCluster-CmdInterface
<br>FailoverCluster-FullServer
<br>FailoverCluster-PowerShell
<br>File-Services
<br>FileServerVSSAgent
<br>FRS-Infrastructure
<br>FSRM-Infrastructure-Services
<br>FSRM-Infrastructure
<br>HardenedFabricEncryptionTask
<br>HostGuardian
<br>HostGuardianService-Package
<br>IdentityServer-SecurityTokenService
<br>IPAMClientFeature
<br>IPAMServerFeature
<br>iSCSITargetServer-PowerShell
<br>iSCSITargetServer
<br>iSCSITargetStorageProviders
<br>iSNS_Service
<br>Licensing
<br>LightweightServer
<br>Microsoft-Hyper-V-Management-Clients
<br>Microsoft-Hyper-V-Offline
<br>Microsoft-Hyper-V-Online
<br>Microsoft-Hyper-V
<br>Microsoft-Windows-FCI-Client-Package
<br>Microsoft-Windows-GroupPolicy-ServerAdminTools-Update
<br>Microsoft-Windows-Subsystem-Linux
<br>MSRDC-Infrastructure
<br>MultipathIo
<br>NetworkController
<br>NetworkControllerTools
<br>NetworkDeviceEnrollmentServices
<br>NetworkLoadBalancingFullServer
<br>NetworkVirtualization
<br>OnlineRevocationServices
<br>P2P-PnrpOnly
<br>PeerDist
<br>Printing-Client-Gui
<br>Printing-LPDPrintService
<br>Printing-Server-Foundation-Features
<br>Printing-Server-Role
<br>QWAVE
<br>RasRoutingProtocols
<br>Remote-Desktop-Services
<br>RemoteAccess
<br>RemoteAccessMgmtTools
<br>RemoteAccessPowerShell
<br>RemoteAccessServer
<br>ResumeKeyFilter
<br>RightsManagementServices-Role
<br>RightsManagementServices
<br>RMS-Federation
<br>SBMgr-UI
<br>ServerCore-Drivers-General-WOW64
<br>ServerCore-Drivers-General
<br>ServerForNFS-Infrastructure
<br>ServerManager-Core-RSAT-Feature-Tools
<br>ServerMediaFoundation
<br>ServerMigration
<br>SessionDirectory
<br>SetupAndBootEventCollection
<br>ShieldedVMToolsAdminPack
<br>SMB1Protocol-Server
<br>SmbDirect
<br>SMBHashGeneration
<br>SmbWitness
<br>SNMP
<br>SoftwareLoadBalancer
<br>Storage-Replica-AdminPack
<br>Storage-Replica
<br>Tpm-PSH-Cmdlets
<br>UpdateServices-Database
<br>UpdateServices-Services
<br>UpdateServices-WidDatabase
<br>UpdateServices
<br>VmHostAgent
<br>VolumeActivation-Full-Role
<br>Web-Application-Proxy
<br>WebAccess
<br>WebEnrollmentServices
<br>Windows-Defender
<br>WindowsServerBackup
<br>WindowsStorageManagementService
<br>WINSRuntime
<br>WMISnmpProvider
<br>WorkFolders-Server
<br>WSS-Product-Package

</div>