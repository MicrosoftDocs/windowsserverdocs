---
title: Managing the Windows XP-based Wireless Network Policies
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5eb94ff6-efe9-4154-8722-cf2851a08b13
author: carmonmills
---
# Managing the Windows XP-based Wireless Network Policies
Wireless network settings in the Wireless Network \(IEEE 802.11\) Policies Group Policy extension include global wireless settings, the list of preferred networks, Wired Equivalent Privacy \(WEP\) and Wi\-Fi Protected Access \(WPA\) settings, and Institute of Electrical and Electronics Engineers \(IEEE\) 802.1X settings. These settings encompass all of the items on the Association and Authentication tabs in the Wireless Network \(IEEE 802.11\) Policies to configure wireless network access for client running Windows®°XP with Service°Pack°\(SP\)°2, Windows°XP with SP1, or Windows°Server®°2003.  
  
This topic contains the following sections:  
  
1.  [General \- settings](#BKMK_General)  
  
2.  [802.1X \- settings](#BKMK_1X)  
  
3.  [Network Properties \- settings](#BKMK_NetProps)  
  
4.  [Preferred Networks \- settings](#BKMK_Preferrd)  
  
## <a name="BKMK_General"></a>General \- settings  
  
|**Item**|**Details**|  
|------------|---------------|  
|**XP Policy Name**|Provides a location for you to type a friendly name for the wireless network policy. **Note:** When you name the Wireless Network \(IEEE 802.11\) Policy, the name you specify is displayed as the name of the associated properties page, and under **XP Policy Name** in the details pane in the Group Policy Management Console \(GPMC\) for that policy.|  
|**Description**|Provides a location for you to type a description for the wireless policy. **Note:** The description you type for is displayed under **Description** in the details pane of the Group Policy Management Console \(GPMC\) for that policy.|  
|**Networks to access**|Specifies the types of wireless networks with which the wireless client is allowed to create connections:<br /><br />-   **Any available network \(access point preferred\)**<br />-   **Access point \(infrastructure\) networks only**<br />-   **Computer\-to\-computer \(ad hoc\) networks only**|  
|**Use Windows WLAN Auto Config service for clients**|Enables the Wireless Zero Configuration service. When enabled, the Wireless Zero Configuration service is used to configure and connect clients running Windows°XP to wireless networks. **Note:** Clients running Windows°XP use Wireless Zero Configuration while Clients running Windows Vista use WLAN AutoConfig Service.|  
|**Automatically connect to non\-preferred networks**|Specifies that wireless clients can attempt to automatically connect to wireless networks that are not configured as preferred networks.<br /><br />If selected, your domain\-member wireless clients can connect to a non\-preferred network after first attempting to connect to preferred networks.|  
  
## <a name="BKMK_1X"></a>802.1X \- settings  
IEEE 802.1X settings specify the behavior of wireless clients when connecting to an infrastructure wireless network that is configured for 802.1X authentication. Settings include authentication methods, \(such as Extensible Authentication Protocol \(EAP\), authentication mode, and 802.1X\-specific parameters.  
  
|**Item**|**Details**|  
|------------|---------------|  
|**Enable network access control using IEEE 802.1X**|Specifies whether you want to use Institute of Electrical and Electronics Engineers \(IEEE\) 802.1X to perform authentication for your wireless network. If you clear this check box, all of the other settings on this tab become unavailable.|  
|**EAP Type**|Specifies the network authentication method that connecting wireless clients use.<br /><br />-   **Smart Card or other certificate** \(EAP\-TLS\)<br />-   **Protected EAP \(PEAP\)**<br /><br />Default \= Protected EAP \(PEAP\)|  
|**Settings**|Opens the properties page of the selected network authentication method.<br /><br />For setting information for network authentication methods, see:<br /><br />[Network Authentication Methods Properties \[w8\]](assetId:///28cc5255-97ef-43bc-b3ad-bf7a1ffd38e6)|  
|**Eapol\-Start message**|EAPOL is the Extensible Authentication Protocol \(EAP\) over local area network \(LAN\) protocol.<br /><br />This setting specifies the transmission behavior of the EAPOL\-Start message when authenticating. You can select from the following:<br /><br />-   **Do not transmit**. Specifies that EAPOL\-Start messages are not sent.<br />-   **Transmit Determines**. when to send EAPOL\-Start messages and, if needed, sends an EAPOL\-Start message.<br />-   **Transmit per IEEE 802.1x**. Sends an EAPOL\-Start message upon association to initiate the 802.1X authentication process.|  
|**Authentication Mode**|Specifies how credentials are used for network authentication. The following options are available.<br /><br />-   **User re\-authentication**. An 802.1X\-compliant device always uses security credentials based on the computer's current state. Authentication is performed using the computer credentials when no users are logged on to the computer. When a user logs on to the computer, authentication is always performed using the user credentials.<br />    This is the recommended setting.<br />-   **Computer only**. Authentication is always performed using only the computer credentials.<br />-   **User authentication**. Specifies that when users are not logged on to the computer, authentication is performed by using the computer credentials. After a user logs on to the computer, authentication is still based on the computer credentials. Authentication is preformed by using the user credentials if the user travels to a new wireless access point.<br />-   **Guest authentication**.Allows connections to the network which are regulated by the restrictions and permissions set for the Guest user account.<br /><br />Default \= User re\-authentication|  
|**Authenticate as computer when computer information is available**|Specifies whether the computer will attempt to authenticate using computer credentials when the user is not logged on.<br /><br />Computer credentials are typically a computer certificate.<br /><br />Default \= Enabled|  
|**Authenticate as guest when user or computer information is unavailable**|Specifies that client connection requests that cannot meet computer or user authentication requirements can connect to the network by using permissions configured for the Guest account.<br /><br />Default \= Not enabled|  
|**Max Eapol\-Start Msgs**|If no response is received to the original EAPOL\-Start message, this setting specifies the maximum number of subsequent EAPOL\-Start messages sent.<br /><br />Default \= 3|  
|**Held Period**|After a client has received notification of authentication failure, this setting specifies the number of seconds an authenticating client waits before it performs another 802.1X authentication request.<br /><br />Default \= 60|  
|**Start Period**|If no response is received to the original EAPOL\-Start message, this setting specifies the number of seconds between the retransmission of subsequent EAPOL\-Start messages.<br /><br />Default \= 5|  
|**Auth Period**|After end\-to\-end 802.1X authentication is initiated, this setting specifies the number of seconds authenticating clients must wait before retransmitting any 802.1X requests.<br /><br />Default \= 30|  
  
## <a name="BKMK_NetProps"></a>Network Properties \- settings  
You can use the Wireless Network \(IEEE 802.11\) Policy for Windows°XP clients to specify the name of the wireless network, network security authentication, such as Wi\-Fi Protected Access 2 \(**WPA2**\), and Fast Roaming features.  
  
|**Item**|**Details**|  
|------------|---------------|  
|**Network Name \(SSID\)**|Provides a location for you to type the wireless LAN network name, also known as the Service Set Identifier \(SSID\).|  
|**Description**|Provides a location for you to type a description of the wireless LAN network.|  
|**Connect even if network is not broadcasting**|Specifies that wireless clients will actively probe for wireless access points with the specified SSID, if wireless access points are configured to suppress beacon broadcasts.|  
|**Authentication**|Specifies the security authentication method that is used between the wireless access point and the wireless client.<br /><br />-   **Open**<br />-   **Shared**<br />-   **WPA\-Enterprise**<br />-   **WPA\-Personal**<br />-   **WPA2\-Enterprise**<br />-   **WPA2\-Personal**<br />-   **Open with 802.1X** **Note:** Network Authentication Methods and advanced settings are only exposed by selecting **WPA\-Enterprise**, **WPA2\-Enterprise**, and **Open with 802.1X** for the network security authentication method.<br /><br />Default \= Defaults to the most secure setting supported by the wireless hardware and drivers.|  
|**Encryption**|Specifies the security encryption to use for the selected network security authentication method.<br /><br />If Authentication is set to **WPA\-Enterprise**, **WPA\-Personal**, **WPA2\-Enterprise**, or **WPA2\-Personal**, the encryption options are **AES** or **TKIP**.<br /><br />If Authentication is set to **Open**, **Shared**, or **Open with 802.1X**, then encryption options are **WEP** or **Disabled**.|  
|**Enable Pairwise Master Key \(PMK\) Caching**|Specifies that Pairwise Master Key \(PMK\) Caching is used for WPA2 Fast Roaming. **Note:** Fast Roaming is a feature of Wi\-Fi Protected Access 2 \(WPA2\) that uses pre\-authentication and PMK Caching to enable wireless clients to roam more quickly among wireless access points \(APs\). Fast Roaming settings are only exposed if WPA2 is selected as the network security method.|  
|**PMK Time to Live \(Minutes\)**|Specifies the duration, in minutes, the PMK is held in cache.<br /><br />Default \= 720|  
|**Number of Entries in PMK Cache**|Specifies the maximum number of PMK entries that are stored in cache.<br /><br />Default \= 128|  
|**This network uses pre\-authentication**|Specifies that pre\-authentication is used for WPA2 Fast Roaming.<br /><br />Pre\-authentication enables WPA2 wireless clients that are connected to one wireless AP to perform 802.1X authentication with other wireless APs within its range. Pre\-authentication stores the PMK and its associated information in the PMK cache. When the wireless client connects to a wireless AP with which it has pre\-authenticated, it uses the cached PMK information to reduce the time required to authenticate and connect. **Note:** WPA2 client pre\-authentication is only possible with wireless access points that broadcast pre\-authentication capability in Beacon and Probe Response messages.<br /><br />Default \= Enabled|  
|**Maximum Pre\-authentication attempts**|Specifies the maximum allowed pre\-authentication attempts.<br /><br />This setting is available only when **This network uses pre\-authentication** is selected.<br /><br />Default \= 3|  
  
## <a name="BKMK_Preferrd"></a>Preferred Networks \- settings  
You can use the settings on the Preferred Networks tab to add wireless networks, by name, to a prioritized list. That list specifies the order in which your domain\-member wireless clients will attempt to connect to wireless networks.  
  
If a client cannot connect to a preferred wireless network, and the wireless network is configured to prevent automatic connection to wireless networks that are not in the preferred list \(the default\), then the Wireless Zero Configuration service places the wireless network adapter in infrastructure mode using a random wireless network name. At this point, the wireless adapter is not connected to any wireless networks and continues to scan for preferred wireless networks.  
  
|**Item**|**Details**|  
|------------|---------------|  
|**Profile name**|Displays the prioritized list of preferred wireless networks. General profile information, such as Service Set Identifier \(SSID\), IEEE 802.1X status **Enabled** or **Disabled**, and encryption type, is displayed.|  
|**Add**|Allows you to add a wireless network profile, and specify the profile properties.<br /><br />When you click **Add**, you will be presented with two options:<br /><br />-   **Ad\-hoc**. Specifies a computer\-to\-computer network. Access points are not used.<br />-   **Infrastructure**. Specifies a network that uses one or more wireless access points.|  
|**Edit**|Allows you to change the configuration settings for the selected preferred wireless network profile.|  
|**Remove**|Deletes the selected network from the list of preferred networks.|  
|**Up arrow**|Moves a selected network to a higher connection priority in the list of preferred networks. **Note:** Profiles for ad\-hoc networks cannot be prioritized higher than infrastructure profiles.|  
|**Down arrow**|Moves a selected network to a lower connection priority in the list of preferred networks.|  
  
