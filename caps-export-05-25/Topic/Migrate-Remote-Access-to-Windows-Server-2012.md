---
title: Migrate Remote Access to Windows Server 2012
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1c304a60-248e-4cf7-bd88-533e966c3b53
author: vhorne
---
# Migrate Remote Access to Windows Server 2012
Routing and Remote Access Service \(RRAS\) was a role service in Windows Server operating systems prior to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] that enabled you to use a computer as an IPv4 or IPv6 router, as an IPv4 network address translation \(NAT\) router, or as a remote access server that hosted dial\-up or virtual private network \(VPN\) connections from remote clients. Now, that feature has been combined with DirectAccess to make up the Remote Access server role in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] This guide describes how to migrate a server that is hosting the Routing and Remote Access service \(in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and other down\-level versions\) to a computer that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
> [!NOTE]  
> Your detailed feedback is very important, and helps us to make Windows Server Migration Guides as reliable, complete, and easy to use as possible. Please take a moment to rate this topic, and then add comments that support your rating. Describe what you liked, did not like, or want to see in future versions of the topic. To submit additional suggestions about how to improve Migration guides or utilities, post on the [Windows Server Migration forum](http://go.microsoft.com/fwlink/?LinkId=247606).  
  
## About this guide  
Migration documentation and tools ease the migration of server role settings and data from an existing server to a destination server that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. By using the tools that are described in this guide, you can simplify the migration process, reduce migration time, increase the accuracy of the migration process, and help to eliminate possible conflicts that might otherwise occur during the migration process. For more information about installing and using the migration tools on the source and destination servers, see the [Windows Server Migration Tools Installation, Access, and Removal Guide](http://go.microsoft.com/fwlink/?LinkId=247607) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=247607\).  
  
### Target audience  
This document is intended for information technology \(IT\) administrators, IT professionals, and other knowledge workers who are responsible for the operation and deployment of the Remote Access servers in a managed environment. Some scripting knowledge may be required to perform some of the migration steps that are contained in this guide.  
  
## What this guide does not provide  
This guide does not describe the architecture or detailed functionality of the Remote Access role. The following scenarios are not supported in this migration guide:  
  
-   Any process for an in\-place upgrade, in which the new operating system is installed on the existing server hardware by using the **Upgrade** option during setup  
  
-   Clustering and multisite scenarios  
  
-   Migrating more than one server role  
  
    If your server is running multiple roles, it is recommended that you design a custom migration procedure that is specific to your server environment and based on the information that is provided in this and other role migration guides.  
  
## Supported migration scenarios  
This guide provides instructions for migrating an existing server to a server that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
> [!CAUTION]  
> This guide does not contain instructions for migration when the source server is running multiple roles. If your source server is running multiple roles, some migration steps in this guide, such as those for migrating user accounts and network interface names, can cause other roles that are running on the source server to fail.  
  
### Supported operating systems  
This guide provides instructions for migrating data and settings from an existing server that is being replaced by a new physical or virtual 64\-bit server with a clean\-installed operating system, as described in the following table.  
  
|Source server processor|Source server operating system|Destination server operating system|Destination server processor|  
|---------------------------|----------------------------------|---------------------------------------|--------------------------------|  
|x86\- or x64\-based|Windows Server 2003 with Service Pack 2|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|x64\-based|  
|x86\- or x64\-based|Windows Server 2003 R2|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|x64\-based|  
|x86\- or x64\-based|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], full installation option only|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|x64\-based|  
|x64\-based|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], full installation option only|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|x64\-based|  
|x64\-based|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|x64\-based|  
  
-   The versions of operating systems shown in the preceding table are the earliest combinations of operating systems and service packs that are supported. Newer service packs are supported.  
  
-   Migration with the destination server already having DirectAccess configured is not supported.  
  
-   The Foundation, Standard, Enterprise, and Datacenter editions of the Windows Server operating system are supported as either source or destination servers. This includes migrating across editions. For example, you can migrate from a server running Windows Server 2003 Standard to a server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   Migrations between physical operating systems and virtual operating systems are supported.  
  
-   Migration from a source server to a destination server that is running an operating system in a different system UI language \(that is, the installed language\) than the source server is not supported. For example, you cannot use [!INCLUDE[wsmt](../Token/wsmt_md.md)] to migrate roles, operating system settings, data, or shared resources from a computer that is running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] in the French system UI language to a computer that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] in the German system UI language.  
  
    > [!NOTE]  
    > The system UI language is the language of the localized installation package that was used to set up the Windows operating system.  
  
-   Both x86\- and x64\-based migrations are supported for Windows Server 2003 and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. All editions of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]are x64\-based.  
  
### <a name="bkmk_src"></a>Supported role configurations  
The following is a broad list of the migration scenarios that are supported for Remote Access. All settings under these scenarios are migrated.  
  
-   **DirectAccess \(supported in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] migration only\)**  
  
-   **VPN server**  
  
-   **Dial\-up server**  
  
-   **Network address translation \(NAT\)**  
  
-   **Routing**, with the following optional components:  
  
    -   DHCP Relay Agent  
  
    -   Routing Information Protocol \(RIP\)  
  
    -   Internet Group Management Protocol \(IGMP\)  
  
In addition to the above scenarios, migration also automatically adjusts configuration of the destination server to account for features that are no longer supported and to support features that are new in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and not supported on earlier versions of Windows.  
  
### Migration dependencies  
If a local or remote NPS server that is used for authentication, accounting, or policy management must also be migrated, then migrate the NPS service before migrating Remote Access. For more information, see [Migrating Network Policy Server to Windows Server 2012](assetId:///a03f6f7f-7be3-4e96-8120-0fe8339fc15e).  
  
If you are upgrading from Windows 2008 R2 DirectAccess to Windows Server 2012, ensure that all the DirectAccess configuration settings have been applied on the Windows 2008 R2 server. It is possible to save settings through the console but not apply them. Before upgrading, ensure that the saved settings have also been applied.  
  
## <a name="bkmk_msns"></a>Migration components that are not supported in all operating system versions  
The following Remote Access components are not supported by all operating systems:  
  
||||  
|-|-|-|  
|Component|UI Dialog\/Settings|Action|  
|**New Components, not available on Windows Server 2003, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]**, and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|  
|**Specifying adapter to obtain DNS\/WINS addresses**|RAS Properties – IPv4 Tab: Adapter|This component is not supported on Windows Server 2003. The default value should be used for this setting on the target computer.|  
|**SSTP**|SSTP ports|SSTP is not supported on Windows Server 2003. SSTP ports should be enabled on the target computer. The number depends on the default value for the SKU on the target computer|  
|**IPv6**|1.  RAS Properties – General Tab: IPv6 router check\-box and corresponding radio\-buttons, IPv6 Remote access server<br /><br />1.  RAS Properties – IPv6 Tab: All settings<br /><br />1.  Demand\-Dial \(VPN\/PPPoE\) properties – Networking tab – TCP\/IPv6<br /><br />1.  Demand\-dial \(VPN\/PPPoE\) – IPv6 filters for connection initiation<br /><br />1.  IPv6 \- Router|-   IPv6 is not supported on Windows Server 2003. It should be disabled on the target computer if DirectAccess is not deployed \(legacy VPN\). Under the General tab of RRAS properties, IPv6 Router and IPv6 Remote access server should not be selected.<br /><br />-   The adapter setting under the IPv6 tab of RAS properties was introduced in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] for IKEv2.  It was not present in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. During migration this setting should be set to the default value on the target computer for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and be “as is” for [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|  
|**IP Filters under RA Logging and Policies**|Remote Access Logging & Policies – IP Filters|Windows Server 2003 and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] do not have an option to create IP filters under Remote Access Logging and Policies. Hence there would be no filters to migrate.|  
|**Automatically obtaining IPv6 address**|Demand\-Dial \(VPN\/PPPoE\) properties \- Networking tab \- IPv6 Properties – ‘Obtain IP address automatically’ radio\-button|This setting is not present in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. The value of this setting should be set to default on the target computer.|  
|**IKEv2**|1.  IKEv2 ports<br /><br />1.  RAS Properties – Security Tab: computer certificate authentication for IKEv2<br /><br />1.  RAS Properties – IKEv2 Tab: All settings|-   IKEv2 is not supported on Windows Server 2003 and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. IKEv2 ports should be enabled on the target computer. The number would depend on the default value for the SKU on the target computer.<br /><br />-   Default values should be used for all IKEv2 settings on the target computer.|  
|**SSTP Cert. Selection**|RAS Properties – Security Tab: ‘Use HTTP’ check\-box, drop\-down to select certificate, crypto binding settings|This component is not supported on Windows Server 2003 and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. Default values should be used for all these settings on the target computer.|  
|**VPN Accounting**|Remote Access Logging & Policies – Accounting: Logging failure action settings under ‘SQL Server Logging Properties’ and ‘Log File Properties’|These are not present in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. The default value should be used on the target computer.|  
|**Deprecated Features: Not available on [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]**, [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)],   or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|  
|**SPAP, MS\-CHAP, EAP\-MD5 protocols and related settings**|VPN\/PPPoE Demand\-dial interface properties \- Security tab|SPAP, EAP\-MD5 and MS\-CHAP settings are not supported on [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and will not be migrated.|  
|**Local Area Connection  interface configuration under Routing**|Routing – General – Local Area Connection properties – Configuration tab|This tab provides settings to configure how an IP address should be obtained for this interface. It is only present on Windows Server 2003 and will not be migrated.|  
|**RAS Firewall \(integrated with NAT\)**|1.  NAT – Interface – NAT\/Basic Firewall Tab<br /><br />1.  NAT – Interface – ICMP Tab|Windows Server 2003 supported RAS firewall functionality which was removed in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. These settings will not be migrated.|  
|**Weak Encryption settings**||Weak encryption is supported on Windows Server 2003 but on [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], it can only be enabled through the registry. During migration from Windows Server 2003 the registry settings will not be created automatically. For [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and higher versions, if these registry settings happen to be present already, they will be migrated.|  
  
## Migration components that are not automatically migrated  
The following Remote Access elements and settings are not migrated by the Windows PowerShell cmdlets that are supplied with the Windows Server Migration Tools. Instead, you must manually configure the element or setting on the new RRAS server as described in [Completing the required manual migration steps](assetId:///17a32df7-7e4e-4f2a-a17d-f406390f681d#bkmk_4) in this guide.  
  
> [!IMPORTANT]  
> Perform the manual configuration of these elements only when directed later in this guide.  
  
-   **SSL certificate bindings**. SSL Certificate binding and crypto\-binding settings for SSTP are migrated as follows:  
  
    1.  The migration Wizard looks for a source certificate on the destination computer.  If one is found, SSTP uses that certificate.  
  
    2.  If a source certificate is not found, the migration wizard will look for a valid certificate with the same trusted root as the source certificate.  
  
    3.  If still no certificate is found, then the SSTP configuration on the destination computer is ‘Default’.  
  
    4.  If self\-signed certificates are being used \(valid for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]\), they will be automatically created on the destination computer.  
  
-   **User accounts on the local RRAS server**. If you use domain\-based user and group accounts, and both the old and new RRAS servers are part of the same domain, no migration of the accounts is required. Local user accounts can be used if **Windows Authentication** is configured on the RRAS source server.  
  
-   **Only routing\/VPN\/DirectAccess  when all are installed**. If your Remote Access server configuration includes all of the available services, then all services must be migrated together. Migrating only one of the services to the destination server is not supported.  
  
-   **A local or remote server that is running Network Policy Server \(NPS\)** that provides authentication, accounting, and policy management. This guide does not include the steps that are required to migrate a server that is running NPS. To migrate a server that is running NPS, use [Migrating Network Policy Server to Windows Server 2012](assetId:///a03f6f7f-7be3-4e96-8120-0fe8339fc15e). NPS migration should be performed when directed later in this guide.  
  
    > [!NOTE]  
    > If you are not using a server that is running NPS, the default Remote Access policies and accounting settings that are automatically created while configuring RRAS are not migrated.  
  
-   **Dial\-up based demand\-dial connections**. The destination server might have different modems, and there are many demand\-dial settings that are specific to the modem or ISDN device that is selected.  
  
-   **Certificates** used for authenticating IKEv2, SSTP, and L2TP\/IPsec connections.  
  
-   **SSL Certificate Binding** for SSTP when the **Use HTTP** check box is not selected.  
  
-   **IKEv2 VPN connections that use IPv6 network adapters**. IKEv2 is supported on RRAS servers that are running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] only. In the RRAS Microsoft Management Console \(MMC\) on [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you can specify the network interface used to acquire IPV6 DHCP and DNS addresses that are used for IKEv2 VPN clients. If you migrate RRAS from [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to another server running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], the setting is migrated. However, if you migrate from a previous version of Windows, there is no setting to migrate, and the default value of **Allow RAS to select the adapter** is used.  
  
-   **Weak encryption**. In Windows Server 2003, weak encryption is enabled, but on later versions of Windows it is disabled by default. You can enable weak encryption only by modifying the registry. During migration from Windows Server 2003 the required registry settings are not created on the new server by the migration process, and they must manually be configured. For later versions of Windows, if these registry settings are present, they are migrated.  
  
-   **Admin DLLs and Security DLLs** and their corresponding registry keys. These DLLs are available in both 32\-bit and 64\-bit versions, and they do not work in a 32\-bit to 64\-bit migration.  
  
-   **Custom DLLs used for dialing a demand\-dial connection**. These DLLs are available in both 32\-bit and 64\-bit versions, and they do not work in a 32\-bit to 64\-bit migration. Any corresponding registry settings also are not migrated.  
  
-   **Connection Manager profiles**. The Connection Manager Administration Kit is used to create VPN and dial\-up remote access profiles. Profiles created are stored under specific folders on the RRAS server. Profiles that are created on a 32\-bit version of Windows do not work on computers that are running a 64\-bit version of Windows, and vice versa. For more information about connection profiles, see [Connection Manager Administration Kit](http://go.microsoft.com/fwlink/?linkid=55986) \(http:\/\/go.microsoft.com\/fwlink\/?linkid\=55986\).  
  
-   **The Group Forwarded Fragments setting on NAT**. This setting is enabled if the RRAS server is deployed behind a NAT router running on the Windows operating system. This is required for L2TP\/IPsec connections that are using computer certificate authentication to succeed. We recommend that you enable this value to work around a known issue in RRAS.  
  
-   The **Log additional Routing and Remote Access information \(used for debugging\)** setting in the **Routing and Remote Access Properties** dialog box on the **Logging** tab.  
  
## Overview of the Routing and Remote Access service migration process  
The pre\-migration process involves the manual collection of data, followed by running procedures on the destination and source servers. The migration process includes source and destination server procedures that use the **Export** and **Import** cmdlets to automatically collect, store, and migrate server role settings. Post\-migration procedures include verifying that the destination server successfully replaced the source server and then retiring or repurposing the source server. If the verification procedure indicates that the migration failed, troubleshooting begins. If troubleshooting fails, rollback instructions are provided to return the network to the use of the original source server.  
  
## Impact of migration  
During migration, the Remote Access server is not available to accept incoming connections or to route traffic.  
  
-   New remote clients cannot connect to the server by using dial\-up, VPN or DirectAccess connections. Existing connections on the server are disconnected. If you have multiple remote access servers, then the loss of availability of this server results in a reduction in capacity until the new server is operational again. For demand\-dial connections, you must provide alternate connectivity between offices or reconfigure the connections to point to an alternate server.  
  
-   Routing and NAT functionalities are not available. If the functionality is required during the migration, an alternate router can be deployed until the new destination server is available.  
  
Post\-migration impacts include the following:  
  
-   If you plan to reuse the name of the source server as the name of the destination server, the name can be configured on the destination server after the source server is disconnected from the network. Otherwise, there is a name conflict that can affect availability. If you plan to run both servers, then the destination server must be given a unique name.  
  
-   A VPN server can be directly connected to the Internet, or it can be placed on a perimeter network that is behind a firewall or NAT router. If the IP address or DNS name of the destination server changes as part of the migration, or after the migration is completed, then the mappings in the firewall or NAT device must be reconfigured to point to the correct address or name. You must also update any intranet or Internet DNS servers with the new name and IP address. Also, remember to provide information about any server name or IP address changes to your users so that they can connect to the correct server. If you use connection profiles that are created by using the Connection Manager Administration Kit, then deploy a new profile with the updated server address information.  
  
> [!NOTE]  
> For DirectAccess, the source computer and the destination computer must have the same IP addresses and interface names.  
  
We recommend that you advertise the expected date and time of the migration so that users can plan accordingly, and make other arrangements as needed.  
  
## Permissions required to complete migration  
The following permissions are required on the source server and the destination Remote Access servers:  
  
-   Domain user rights are required join the new server to the domain.  
  
-   Local administrative rights are required to install and manage the Remote Access role.  
  
-   Equivalent administrator permissions for DirectAccess GPOs as were configured on the source computer.  
  
-   Write permissions are required to the migration store location. For more information, see [Remote Access: Prepare to Migrate](../Topic/Remote-Access--Prepare-to-Migrate.md) in this guide.  
  
## Estimated duration  
The migration can take two to three hours, including testing.  
  
## See Also  
[Remote Access: Prepare to Migrate](../Topic/Remote-Access--Prepare-to-Migrate.md)  
[Remote Access: Migrate Remote Access](../Topic/Remote-Access--Migrate-Remote-Access.md)  
[Remote Access: Verify the Migration](../Topic/Remote-Access--Verify-the-Migration.md)  
[Remote Access: Post-migration Tasks](../Topic/Remote-Access--Post-migration-Tasks.md)  
  
