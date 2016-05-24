---
title: Advanced Security Settings for Wired and Wireless Network Policies
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1bc6a3a6-307c-4739-a287-f8d9734a158e
author: carmonmills
---
# Advanced Security Settings for Wired and Wireless Network Policies
The Wireless Network \(IEEE 802.11\) Policies Advanced settings and Wired Network \(IEEE 802.11\) Policies specify settings associated with 802.1X authentication requests. For the Wireless Network \(IEEE 802.11\) Policies, the Advanced settings are only exposed by enabling Wi\-Fi Protected Access 2 \(WPA2\)\-Enterprise, WPA\-Enterprise, or Open with 802.1X as the network authentication setting on the **Security** tab in the Wireless Network \(IEEE 802.11\) Policy.  
  
## Advanced security settings for the Wireless Network Policies and Wired Network Policies  
  
### IEEE 802.1X \- settings  
IEEE 802.1X settings specify the behavior of wireless client 802.1X authentication requests.  
  
|**Item**|**Details**|  
|------------|---------------|  
|**Enforce advanced 802.1x settings**|Specifies that the settings listed are enforced as configured:<br /><br />-   **Max Eapol\-Start Msgs**<br />-   **Held Period \(seconds\)**<br />-   **Start Period \(seconds\)**<br />-   **Auth Period \(seconds\)**|  
|**Max Eapol\-Start Msgs**|EAPOL is the Extensible Authentication Protocol \(EAP\) over local area network \(LAN\) protocol.<br /><br />If no response is received to the original EAPOL\-Start message, this setting specifies the maximum number of subsequent EAPOL\-Start messages sent.<br /><br />Default \= 3|  
|**Held Period \(seconds\)**|After a client has received notification of authentication failure, this setting specifies the number of seconds an authenticating client waits before it performs another 802.1X authentication request.<br /><br />Default \= 60|  
|**Start Period**|If no response is received to the original EAPOL\-Start message, this setting specifies the number of seconds between the retransmission of subsequent EAPOL\-Start messages.<br /><br />Default \= 5|  
|**Auth Period**|After end\-to\-end 802.1X authentication is initiated, this setting specifies the number of seconds authenticating clients must wait before retransmitting any 802.1X requests.<br /><br />Default \= 30|  
  
### Single Sign On \- settings  
In [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)] and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], Single Sign On performs 802.1X authentication based on the network security configuration during the user logon process. This feature enables scenarios — such Group Policy updates, implementation login scripts, and joining of wireless clients to domains — that require network connectivity prior to user logon.  
  
You can use Group Policy settings to configure Single Sign On profiles for your wireless client computers. When a Single Sign On profile is configured, 802.1X authentication is conducted prior to computer logon to the domain; users are only prompted for credential information if needed.  
  
|**Item**|**Details**|  
|------------|---------------|  
|**Enable Single Sign On for this network**|Specifies that Single Sign On is activated for the wireless network profile for this network.<br /><br />Default \= Not enabled|  
|**Perform immediately before User Logon**|Specifies that Single Sign On performs 802.1X authentication before user logon completes.<br /><br />Default \= Not enabled|  
|**Perform immediately after User Logon**|Specifies that Single Sign On performs 802.1x authentication immediately upon successful user logon.<br /><br />Default \= Not enabled|  
|**Max delay for connectivity \(Seconds\)**|Specifies the maximum time, in seconds, in which 802.1X authentication must complete and authorize network access. This setting allows the network administrator to define the maximum length of time a user waits at the logon screen.<br /><br />Default \= 10|  
|**This network uses different VLAN for authentication with machine and user credentials**|Specifies that wireless computers are placed on one virtual local area network \(VLAN\) at startup, and then — based on user permissions — transitions to a different VLAN network after the user logs on to the computer.<br /><br />This setting is used in scenarios where it is desirable to separate traffic by using VLANs. For example, one VLAN, "VLAN\-a," allows access only to authenticated computers, typically with a restricted set of assets. A second VLAN, "VLAN\-b," provides authenticated and authorized users with access to a broader set of assets, such as e\-mail, build servers, or the intranet.<br /><br />Default \= Not enabled|  
  
### Fast Roaming settings  
Fast Roaming is a feature of WPA2 that uses pre\-authentication and Pairwise Master Key \(PMK\) Caching to enable wireless clients to roam more quickly among wireless access points \(APs\).  
  
Fast Roaming settings are only exposed by enabling **WPA2\-Enterpries** on the Security tab in the [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] Wireless Network \(IEEE 802.11\) Policy.  
  
|**Item**|**Details**|  
|------------|---------------|  
|**Enable Pairwise Master Key \(PMK\) Caching**|Specifies that Pairwise Master Key \(PMK\) Caching is used for WPA2 Fast Roaming.<br /><br />Default \= Enabled|  
|**PMK time to Live \(Minutes\)**|Specifies the duration, in minutes, the PMK is held in cache.<br /><br />Default \= 720|  
|**Number of Entries in PMK Cache**|Specifies the maximum number of PMK entries that are stored in cache.<br /><br />Default \= 128|  
|**This network uses pre\-authentication**|Specifies that pre\-authentication is used for WPA2 Fast Roaming.<br /><br />Pre\-authentication enables WPA2 wireless clients that are connected to one wireless AP to perform 802.1X authentication with other wireless APs within its range. Pre\-authentication stores the PMK and its associated information in the PMK cache. When the wireless client connects to a wireless AP with which it has pre\-authenticated, it uses the cached PMK information to reduce the time required to authenticate and connect. **Note:** WPA2 client pre\-authentication is only possible with wireless access points that broadcast pre\-authentication capability in Beacon and Probe Response messages.<br /><br />Default \= Enabled|  
|**Maximum pre\-authentication attempts**|Specifies the maximum allowed pre\-authentication attempts.<br /><br />This setting is available only when **This network uses pre\-authentication** is selected.<br /><br />Default \= 3|  
  
|||  
|-|-|  
|Item|Details|  
|Perform cryptography in FIPS 140\-2\-certified mode|Specifies that wireless transmissions adhere to the Federal Information Processing Standard \(FIPS\) 140\-2 mode for cryptography. FIPS 140\-2 is a U.S. government computer security standard that is used to certify cryptographic modules.<br /><br />Default \= not enabled|  
  
## Additional resources  
For additional information about wireless settings in Group Policy, see [Managing the New Wireless Network &#40;IEEE 802.11&#41; Policies Settings](../Topic/Managing-the-New-Wireless-Network--IEEE-802.11--Policies-Settings.md)  
  
For additional information about wireless settings in Group Policy, see [Managing the New Wired Network &#40;IEEE 802.3&#41; Policies Settings](../Topic/Managing-the-New-Wired-Network--IEEE-802.3--Policies-Settings.md)  
  
