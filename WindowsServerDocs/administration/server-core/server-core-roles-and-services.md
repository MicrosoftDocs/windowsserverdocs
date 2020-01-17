---
title: Roles, Role Services, and Features included in Windows Server - Server Core
description: What roles and features are included in the Server Core installation option of Windows Server?
ms.prod: windows-server
ms.mktglfcycl: manage
ms.sitesec: library
author: lizap
ms.localizationpriority: medium
ms.date: 02/23/2018
---
# Roles, Role Services, and Features included in Windows Server - Server Core

> Applies to: Windows Server 2019, Windows Server 2016, and Windows Server (Semi-Annual Channel)

We generally talk about [what's *not* in Server Core](server-core-removed-roles.md) - now we're going to try a different approach and tell you what's *included* and whether something is *installed by default*. The following roles, role services, and features are *in* the Server Core installation option of Windows Server. Use this information to help figure out if the Server Core option works for your environment. Because this is a large list, consider searching for the specific role or feature you're interested in - if that search doesn't return what you're looking for, it's not included in Server Core.

For example, if you search for "Remote Desktop Session Host" - you won't find it on this page. That's because the RD Session Host is NOT included in the Server Core image.

Remember that you can [always look](server-core-removed-roles.md) at what's *not* included. This is just a different way to look at things.

## Roles included in Server Core
The Server Core installation option includes the following server roles.

| Role                                            | Name                           | Installed by default? |
|-------------------------------------------------|--------------------------------|-----------------------|
| Active Directory Certificate Services           | AD-Certificate                 | N                     |
| Active Directory Domain Services                | AD-Domain-Services             | N                     |
| Active Directory Federation Services            | ADFS-Federation                | N                     |
| Active Directory Lightweight Directory Services | ADLDS                          | N                     |
| Active Directory Rights Management Services     | ADRMS                          | N                     |
| Device Health Attestation                       | DeviceHealthAttestationService | N                     |
| DHCP Server                                     | DHCP                           | N                     |
| DNS Server                                      | DNS                            | N                     |
| File and Storage Services                       | FileAndStorage-Services        | Y                     |
| Host Guardian Service                           | HostGuardianServiceRole        | N                     |
| Hyper-V                                         | Hyper-V                        | N                     |
| Print and Document Services                     | Print-Services                 | N                     |
| Remote Access                                   | RemoteAccess                   | N                     |
| Remote Desktop Services                         | Remote-Desktop-Services        | N                     |
| Volume Activation Services                      | VolumeActivation               | N                     |
| Web Server IIS                                  | Web-Server                     | N                     |
| Windows Server Essentials Experience            | ServerEssentialsRole           | N                     |
| Windows Server Update Services                  | UpdateServices                 | N                     |

## Role services included in Server Core
The Server Core installation option includes the following role services.

| Role                                  | Role service                                                   | Name                    | Installed by default? |
|---------------------------------------|----------------------------------------------------------------|-------------------------|-----------------------|
| Active Directory Certificate Services | Certification Authority                                        | ADCS-Cert-Authority     | N                     |
|                                       | Certificate Enrollment Policy Web Service                      | ADCS-Enroll-Web-Pol     | N                     |
|                                       | Certificate Enrollment Web Service                             | ADCS-Enroll-Web-Svc     | N                     |
|                                       | Certification Authority Web Enrollment                         | ADCS-Web-Enrollment     | N                     |
|                                       | Network Device Enrollment Service                              | ADCS-Device-Enrollment  | N                     |
|                                       | Online Responder                                               | ADCS-Online-Cert        | N                     |
| Active Directory Rights Management    | Active Directory Rights Management Server                      | ADRMS-Server            | N                     |
|                                       | Identity Federation Support                                    | ADRMS-Identity          | N                     |
| File and Storage Services             | File and iSCSI Services                                        | File-Services           | N                     |
|                                       | File Server                                                    | FS-FileServer           | N                     |
|                                       | BranchCache for Network Files                                  | FS-BranchCache          | N                     |
|                                       | Data Deduplication                                             | FS-Data-Deduplication   | N                     |
|                                       | DFS Namespaces                                                 | FS-DFS-Namespace        | N                     |
|                                       | DFS Replication                                                | FS-DFS-Replication      | N                     |
|                                       | File Server Resource Manager                                   | FS-Resource-Manager     | N                     |
|                                       | File Server VSS Agent Service                                  | FS-VSS-Agent            | N                     |
|                                       | iSCSI Target Server                                            | iSCSITarget-Server      | N                     |
|                                       | iSCSI Target Storage Provider (VDS and VSS hardware providers) | iSCSITarget-VSS-VDS     | N                     |
|                                       | Server for NFS                                                 | FS-NFS-Service          | N                     |
|                                       | Work Folders                                                   | FS-SyncShareService     | N                     |
|                                       | Storage Services                                               | Storage-Services        | Y                     |
| Print and Document Services           | Print Server                                                   | Print-Server            | N                     |
|                                       | LPD Service                                                    | Print-LPD-Service       | N                     |
| Remote Access                         | DirectAccess and VPN (RAS)                                     | DirectAccess-VPN        | N                     |
|                                       | Routing                                                        | Routing                 | N                     |
|                                       | Web Application Proxy                                          | Web-Application-Proxy   | N                     |
| Remote Desktop Services               | Remote Desktop Connection Broker                               | RDS-Connection-Broker   | N                     |
|                                       | Remote Desktop Licensing                                       | RDS-Licensing           | N                     |
|                                       | Remote Desktop Virtualization Host                             | RDS-Virtualization      | N                     |
| Web Server (IIS)                      | Web Server                                                     | Web-WebServer           | N                     |
|                                       | Common HTTP Features                                           | Web-Common-Http         | N                     |
|                                       | Default Document                                               | Web-Default-Doc         | N                     |
|                                       | Directory Browsing                                             | Web-Dir-Browsing        | N                     |
|                                       | HTTP Errors                                                    | Web-Http-Errors         | N                     |
|                                       | Static Content                                                 | Web-Static-Content      | N                     |
|                                       | HTTP Redirection                                               | Web-Http-Redirect       | N                     |
|                                       | WebDAV Publishing                                              | Web-DAV-Publishing      | N                     |
|                                       | Health and Diagnostics                                         | Web-Health              | N                     |
|                                       | HTTP Logging                                                   | Web-Http-Logging        | N                     |
|                                       | Custom Logging                                                 | Web-Custom-Logging      | N                     |
|                                       | Logging Tools                                                  | Web-Log-Libraries       | N                     |
|                                       | ODBC Logging                                                   | Web-ODBC-Logging        | N                     |
|                                       | Request   Monitor                                              | Web-Request-Monitor     | N                     |
|                                       | Tracing                                                        | Web-Http-Tracing        | N                     |
|                                       | Performance                                                    | Web-Performance         | N                     |
|                                       | Static Content Compression                                     | Web-Stat-Compression    | N                     |
|                                       | Dynamic Content Compression                                    | Web-Dyn-Compression     | N                     |
|                                       | Security                                                       | Web-Security            | N                     |
|                                       | Request Filtering                                              | Web-Filtering           | N                     |
|                                       | Basic Authentication                                           | Web-Basic-Auth          | N                     |
|                                       | Centralized SSL Certificate Support                            | Web-CertProvider        | N                     |
|                                       | Client Certificate Mapping Authentication                      | Web-Client-Auth         | N                     |
|                                       | Digest Authentication                                          | Web-Digest-Auth         | N                     |
|                                       | IIS Client Certificate Mapping Authentication                  | Web-Cert-Auth           | N                     |
|                                       | IP and Domain Restrictions                                     | Web-IP-Security         | N                     |
|                                       | URL Authorization                                              | Web-Url-Auth            | N                     |
|                                       | Windows Authentication                                         | Web-Windows-Auth        | N                     |
|                                       | Application Development                                        | Web-App-Dev             | N                     |
|                                       | .NET Extensibility 3.5                                         | Web-Net-Ext             | N                     |
|                                       | .NET Extensibility 4.6                                         | Web-Net-Ext45           | N                     |
|                                       | Application Initialization                                     | Web-AppInit             | N                     |
|                                       | ASP                                                            | Web-ASP                 | N                     |
|                                       | ASP.NET 3.5                                                    | Web-Asp-Net             | N                     |
|                                       | ASP.NET 4.6                                                    | Web-Asp-Net45           | N                     |
|                                       | CGI                                                            | Web-CGI                 | N                     |
|                                       | ISAPI Extensions                                               | Web-ISAPI-Ext           | N                     |
|                                       | ISAPI Filters                                                  | Web-ISAPI-Filter        | N                     |
|                                       | Server Side Includes                                           | Web-Includes            | N                     |
|                                       | WebSocket Protocol                                             | Web-WebSockets          | N                     |
|                                       | FTP Server                                                     | Web-Ftp-Server          | N                     |
|                                       | FTP Service                                                    | Web-Ftp-Service         | N                     |
|                                       | FTP Extensibility                                              | Web-Ftp-Ext             | N                     |
|                                       | Management Tools                                               | Web-Mgmt-Tools          | N                     |
|                                       | IIS 6 Management Compatibility                                 | Web-Mgmt-Compat         | N                     |
|                                       | IIS 6 Metabase Compatibility                                   | Web-Metabase            | N                     |
|                                       | IIS 6 Scripting Tools                                          | Web-Lgcy-Scripting      | N                     |
|                                       | IIS 6 WMI Compatibility                                        | Web-WMI                 | N                     |
|                                       | IIS Management Scripts and Tools                               | Web-Scripting-Tools     | N                     |
|                                       | Management Service                                             | Web-Mgmt-Service        | N                     |
| Windows Server Update Services        | WID Connectivity                                               | UpdateServices-WidDB    | N                     |
|                                       | WSUS Services                                                  | UpdateServices-Services | N                     |
|                                       | SQL Server Connectivity                                        | UpdateServices-DB       | N                     |

## Features included in Server Core
The Server Core installation option includes the following features.

| Feature                                                | Name                               | Installed by default? |
|--------------------------------------------------------|------------------------------------|-----------------------|
| .NET Framework 3.5 Features                            | NET-Framework-Features             | N                     |
| .NET Framework 3.5 (includes .NET 2.0 and   3.0)       | NET-Framework-Core                 | (removed)             |
| HTTP Activation                                        | NET-HTTP-Activation                | N                     |
| Non-HTTP Activation                                    | NET-Non-HTTP-Activ                 | N                     |
| .NET Framework 4.6 Features                            | NET-Framework-45-Features          | Y                     |
| .NET Framework 4.6                                     | NET-Framework-45-Core              | Y                     |
| ASP.NET 4.6                                            | NET-Framework-45-ASPNET            | N                     |
| WCF Services                                           | NET-WCF-Services45                 | Y                     |
| HTTP Activation                                        | NET-WCF-HTTP-Activation45          | N                     |
| Message Queuing (MSMQ) Activation                      | NET-WCF-MSMQ-Activation45          | N                     |
| Named Pipe Activation                                  | NET-WCF-Pipe-Activation45          | N                     |
| TCP Activation                                         | NET-WCF-TCP-Activation45           | N                     |
| TCP Port Sharing                                       | NET-WCF-TCP-PortSharing45          | Y                     |
| Background Intelligent Transfer Service (BITS)         | BITS                               | N                     |
| Compact Server                                         | BITS-Compact-Server                | N                     |
| BitLocker Drive Encryption                             | BitLocker                          | N                     |
| BranchCache                                            | BranchCache                        | N                     |
| Client for NFS                                         | NFS-Client                         | N                     |
| Containers                                             | Containers                         | N                     |
| Data Center Bridging                                   | Data-Center-Bridging               | N                     |
| Enhanced Storage                                       | EnhancedStorage                    | N                     |
| Failover Clustering                                    | Failover-Clustering                | N                     |
| Group Policy Management                                | GPMC                               | N                     |
| I/O Quality of Service                                 | DiskIo-QoS                         | N                     |
| IIS Hostable Web Core                                  | Web-WHC                            | N                     |
| IP Address Management (IPAM) Server                    | IPAM                               | N                     |
| iSNS Server service                                    | ISNS                               | N                     |
| Management OData IIS Extension                         | ManagementOdata                    | N                     |
| Media Foundation                                       | Server-Media-Foundation            | N                     |
| Message Queuing                                        | MSMQ                               | N                     |
| Message Queuing Services                               | MSMQ-Services                      | N                     |
| Message Queuing Server                                 | MSMQ-Server                        | N                     |
| Directory Service Integration                          | MSMQ-Directory                     | N                     |
| HTTP Support                                           | MSMQ-HTTP-Support                  | N                     |
| Message Queuing Triggers                               | MSMQ-Triggers                      | N                     |
| Routing Service                                        | MSMQ-Routing                       | N                     |
| Message Queuing DCOM Proxy                             | MSMQ-DCOM                          | N                     |
| Multipath I/O                                          | Multipath-IO                       | N                     |
| MultiPoint Connector                                   | MultiPoint-Connector               | N                     |
| MultiPoint Connector Services                          | MultiPoint-Connector-Services      | N                     |
| MultiPoint Manager and MultiPoint Dashboard            | MultiPoint-Tools                   | N                     |
| Network Load Balancing                                 | NLB                                | N                     |
| Peer Name Resolution Protocol                          | PNRP                               | N                     |
| Quality Windows Audio Video Experience                 | qWave                              | N                     |
| Remote Differential Compression                        | RDC                                | N                     |
| Remote Server Administration Tools                     | RSAT                               | N                     |
| Feature Administration Tools                           | RSAT-Feature-Tools                 | N                     |
| BitLocker Drive Encryption Administration   Utilities  | RSAT-Feature-Tools-BitLocker       | N                     |
| DataCenterBridging LLDP Tools                          | RSAT-DataCenterBridging-LLDP-Tools | N                     |
| Failover Clustering Tools                              | RSAT-Clustering                    | N                     |
| Failover Cluster Module for Windows PowerShell         | RSAT-Clustering-PowerShell         | N                     |
| Failover Cluster Automation Server                     | RSAT-Clustering-AutomationServer   | N                     |
| Failover Cluster Command Interface                     | RSAT-Clustering-CmdInterface       | N                     |
| IP Address Management (IPAM) Client                    | IPAM-Client-Feature                | N                     |
| Shielded VM Tools                                      | RSAT-Shielded-VM-Tools             | N                     |
| Storage Replica Module for Windows PowerShell          | RSAT-Storage-Replica               | N                     |
| Role Administration Tools                              | RSAT-Role-Tools                    | N                     |
| AD DS and AD LDS Tools                                 | RSAT-AD-Tools                      | N                     |
| Active Directory module for Windows PowerShell         | RSAT-AD-PowerShell                 | N                     |
| AD DS Tools                                            | RSAT-ADDS                          | N                     |
| Active Directory Administrative Center                 | RSAT-AD-AdminCenter                | N                     |
| AD DS Snap-Ins and Command-Line Tools                  | RSAT-ADDS-Tools                    | N                     |
| AD LDS Snap-Ins and Command-Line Tools                 | RSAT-ADLDS                         | N                     |
| Hyper-V Management Tools                               | RSAT-Hyper-V-Tools                 | N                     |
| Hyper-V Module for Windows PowerShell                  | Hyper-V-PowerShell                 | N                     |
| Windows Server Update Services Tools                   | UpdateServices-RSAT                | N                     |
| API and PowerShell cmdlets                             | UpdateServices-API                 | N                     |
| DHCP Server Tools                                      | RSAT-DHCP                          | N                     |
| DNS Server Tools                                       | RSAT-DNS-Server                    | N                     |
| Remote Access Management Tools                         | RSAT-RemoteAccess                  | N                     |
| Remote Access module for Windows PowerShell            | RSAT-RemoteAccess-PowerShell       | N                     |
| RPC over HTTP Proxy                                    | RPC-over-HTTP-Proxy                | N                     |
| Setup and Boot Event Collection                        | Setup-and-Boot-Event-Collection    | N                     |
| Simple TCP/IP Services                                 | Simple-TCPIP                       | N                     |
| SMB 1.0/CIFS File Sharing Support                      | FS-SMB1                            | Y                     |
| SMB Bandwidth Limit                                    | FS-SMBBW                           | N                     |
| SNMP Service                                           | SNMP-Service                       | N                     |
| SNMP WMI Provider                                      | SNMP-WMI-Provider                  | N                     |
| Telnet Client                                          | Telnet-Client                      | N                     |
| VM Shielding Tools for Fabric Management               | FabricShieldedTools                | N                     |
| Windows Defender Features                              | Windows-Defender-Features          | Y                     |
| Windows Defender                                       | Windows-Defender                   | Y                     |
| Windows Internal Database                              | Windows-Internal-Database          | N                     |
| Windows PowerShell                                     | PowerShellRoot                     | Y                     |
| Windows PowerShell 5.1                                 | PowerShell                         | Y                     |
| Windows PowerShell 2.0 Engine                          | PowerShell-V2                      | (removed)             |
| Windows PowerShell Desired State Configuration Service | DSC-Service                        | N                     |
| Windows PowerShell Web Access                          | WindowsPowerShellWebAccess         | N                     |
| Windows Process Activation Service                     | WAS                                | N                     |
| Process Model                                          | WAS-Process-Model                  | N                     |
| .NET Environment 3.5                                   | WAS-NET-Environment                | N                     |
| Configuration APIs                                     | WAS-Config-APIs                    | N                     |
| Windows Server Backup                                  | Windows-Server-Backup              | N                     |
| Windows Server Migration Tools                         | Migration                          | N                     |
| Windows Standards-Based Storage Management             | WindowsStorageManagementService    | N                     |
| WinRM IIS Extension                                    | WinRM-IIS-Ext                      | N                     |
| WINS Server                                            | WINS                               | N                     |
| WoW64 Support                                          | WoW64-Support                      | Y                     |
|                                                        |                                    |                       |
