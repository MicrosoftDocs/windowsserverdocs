---
title: Managing the New Wireless Network (IEEE 802.11) Policies Settings
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c984c36d-2bf2-4b16-97bb-ba526e26d714
author: carmonmills
---
# Managing the New Wireless Network (IEEE 802.11) Policies Settings
Wireless network settings in the Wireless Network \(IEEE 802.11\) Policies Group Policy extension include global wireless settings, the list of preferred networks, Wired Equivalent Privacy \(WEP\) and Wi\-Fi Protected Access \(WPA\) settings, and Institute of Electrical and Electronics Engineers \(IEEE\) 802.1X settings.. You can use the New Wireless Network Policy to configure wireless settings on computers running [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)], [!INCLUDE[firstref_client_7](../Token/firstref_client_7_md.md)], and [!INCLUDE[firstref_vista](../Token/firstref_vista_md.md)].  
  
There are two main sections in this topic:  
  
1.  [Configuring Wireless Network \(IEEE 802.11\) Policies](#BKMK_Perscriptive), provides prescriptive guidance for configuring 802.1X authenticated wireless access based on one of the authentication methods you have selected when configuring this policy.  
  
2.  [Wireless Network \(IEEE 802.11\) Policies settings](#BKMK_Settings), provides configuration details about the individual settings in this policy.  
  
## <a name="BKMK_Perscriptive"></a>Configuring Wireless Network \(IEEE 802.11\) Policies  
This section provides step\-by\-step details to configure Wireless Network \(IEEE 802.11\) Policies extension of Group Policy for 802.1X authenticated wireless network access.  
  
In this section:  
  
1.  [Configure a wireless connection profile for PEAP\-MS\-CHAP v2](#BKMK_PEAP-MS)  
  
2.  [Configure a wireless connection profile for PEAP\-TLS](#BKMK_PEAP-TLS)  
  
3.  [Configure a wireless connection profile for EAP\-TLS](#BKMK_EAP-TLS)  
  
### <a name="BKMK_PEAP-MS"></a>Configure a wireless connection profile for PEAP\-MS\-CHAP v2  
This procedure provides the steps that are required to configure a wireless connection profile for Protected Extensible Authentication Protocol–Microsoft\-Challenge Handshake Authentication Protocol \(PEAP\-MS\-CHAP v2\) for authentication by using secure passwords.  
  
Membership in Domain Admins, or equivalent, is the minimum requirement to complete this procedure.  
  
##### To configure a Windows Vista wireless connection profile for PEAP\-MS\-CHAP v2  
  
1.  If you have not already done so, open the [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] Wireless Network \(IEEE 802.11\) Policies properties page.  
  
2.  In **Windows Vista Wireless Network \(IEEE 802.11\) Policies Properties**, on the **General** tab, select **Use Windows to configure wireless network settings for clients** to specify that WLAN AutoConfig is used to configure wireless network adapter settings.  
  
3.  In **Windows Vista Wireless Network \(IEEE 802.11\) Policies Properties**, on the **General** tab, do one of the following:  
  
    -   To add and configure a new profile, click **Add**, and then select **Infrastructure**.  
  
    -   To edit an existing profile, select the profile that you want to modify, and then click **Edit**.  
  
4.  On the **Connection** tab, in **Profile Name**, if you are adding a new profile, type a name for the profile. If you are editing a profile that is already added, use the existing profile name, or modify the name as needed.  
  
5.  In **Network Name\(s\) \(SSID\)**, type the service set identifier \(SSID\) that corresponds to the SSID configured on your wireless APs, and then click **Add**.  
  
    If your deployment uses multiple SSIDs and each wireless AP uses the same wireless security settings, repeat this step to add the SSID for each wireless AP to which you want this profile to apply.  
  
    If your deployment uses multiple SSIDs and the security settings for each SSID do not match, configure a separate profile for each group of SSIDs that use the same security settings. For example, if you have one group of wireless APs configured to use WPA2\-Enterprise and AES, and another group of wireless APs to use WPA\-Enterprise and TKIP, configure a profile for each group of wireless APs.  
  
6.  If **NEWSSID** is present, select it, and then click **Remove**.  
  
7.  If you deployed wireless access points that are configured to suppress the broadcast beacon, select **Connect even if the network is not broadcasting**.  
  
    > [!NOTE]  
    > Enabling this option can create a security risk because wireless clients will probe for and try to connect to any wireless network. By default, this setting is not enabled.  
  
8.  Click the **Security** tab, click **Advanced**, and then configure the following:  
  
    1.  To configure advanced 802.1X settings, in **IEEE 802.1X**, select **Enforce advanced 802.1X settings**.  
  
        When the advanced 802.1X settings are enforced, the default values for **Max Eapol\-Start Msgs**, **Held Period**, **Start Period**, and **Auth Period** are sufficient for most wireless deployments.  
  
    2.  To enable Single Sign On, select **Enable Single Sign On for this network**.  
  
    3.  The remaining default values in **Single Sign On** are sufficient for typical wireless deployments.  
  
    4.  In **Fast Roaming**, if your wireless AP is configured for pre\-authentication, select **This network uses pre\-authentication**.  
  
9. Click **OK** to return to the **Security** tab.  In **Select the security methods for this network**, in **Authentication**, if it is supported by your wireless AP and wireless client network adapters, select **WPA2\-Enterprise**. Otherwise, select **WPA\-Enterprise**.  
  
10. In **Encryption**, select **AES**, if it is supported by your wireless AP and wireless client network adapters. Otherwise, select **TKIP**.  
  
    > [!NOTE]  
    > The settings for both **Authentication** and **Encryption** must match the settings configured on your wireless AP. On the **Security** tab, the default settings for **Authentication Mode**, **Max Authentication Failures**, and **Cache user information for subsequent connections to this network** are sufficient for typical wireless deployments.  
  
11. In **Select a network authentication method**, select **Protected EAP \(PEAP\)**, and then click **Properties**. The **Protected EAP Properties** page opens.  
  
12. In **Protected EAP Properties**, verify that **Validate server certificate** is selected.  
  
13. In **Trusted Root Certification Authorities**, select the trusted root certification authority \(CA\) that issued the server certificate to your computer running Network Policy Server \(NPS\).  
  
    > [!NOTE]  
    > This setting limits the root CAs that clients trust to the selected CAs. If no trusted root CAs are selected, clients will trust all root CAs listed in their trusted root certification authority store.  
  
14. Select **Do not prompt user to authorize new servers or trusted certification authorities**. Selecting this setting provides an enhanced user experience and better security.  
  
15. In the **Select Authentication Method** list, select **Secured password \(EAP\-MS\-CHAP v2\)**.  
  
16. To enable PEAP Fast Reconnect, select **Enable Fast Reconnect**.  
  
17. If Network Access Protection \(NAP\) is configured on your network, select **Enable Quarantine checks**. Otherwise, clear this check box.  
  
18. Click **Configure**. In the **EAP MSCHAPv2 Properties** dialog box, verify **Automatically use my Windows logon name and password \(and domain if any\)** is selected, click **OK**, and then click **OK** to close **Protected EAP Properties**.  
  
19. Click **OK** to close the **Security** tab, and then click **OK** again to close the Windows Vista Wireless Network Policy.  
  
### <a name="BKMK_PEAP-TLS"></a>Configure a wireless connection profile for PEAP\-TLS  
This procedure provides the steps that are required to configure a Protected Extensible Authentication Protocol–Transport Level Security \(PEAP\-TLS\) wireless connection profile for authentication using smart cards or other certificates.  
  
Membership in Domain Admins, or equivalent, is the minimum requirement to complete this procedure.  
  
##### To configure a Windows Vista PEAP\-TLS wireless connection profile  
  
1.  If you have not already done so, open the [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] Wireless Network \(IEEE 802.11\) Policies properties page.  
  
2.  In **Windows Vista Wireless Network \(IEEE 802.11\) Policies Properties**, on the **General** tab, select **Use Windows to configure wireless network settings for clients** to specify that WLAN AutoConfig is used to configure wireless network adapter settings.  
  
3.  In **Windows Vista Wireless Network \(IEEE 802.11\) Policies Properties**, on the **General** tab, do one of the following:  
  
    -   To add and configure a new profile, click **Add**, and then select **Infrastructure**.  
  
    -   To edit an existing profile, select the profile that you want to modify, and then click **Edit**.  
  
4.  On the **Connection** tab, in **Profile Name**, if you are adding a new profile, type a name for the profile. If you are editing a profile that is already added, use the existing profile name, or modify the name as needed.  
  
5.  In **Network Name\(s\) \(SSID\)**, type the service set identifier \(SSID\) that corresponds to the SSID configured on your wireless APs, and then click **Add**.  
  
    If your deployment uses multiple SSIDs and each wireless AP uses the same wireless security settings, repeat this step to add the SSID for each wireless AP to which you want this profile to apply.  
  
    If your deployment uses multiple SSIDs and the security settings for each SSID do not match, configure a separate profile for each group of SSIDs that use the same security settings. For example, if you have one group of wireless APs configured to use WPA2\-Enterprise and AES, and another group of wireless APs to use WPA\-Enterprise and TKIP, configure a profile for each group of wireless APs.  
  
6.  If **NEWSSID** is present, select it, and then click **Remove**.  
  
7.  If you deployed wireless access points that are configured to suppress the broadcast beacon, select **Connect even if the network is not broadcasting**.  
  
    > [!NOTE]  
    > Enabling this option can create a security risk because wireless clients will probe for and try to connect to any wireless network. By default, this setting is not enabled.  
  
8.  Click the **Security** tab, click **Advanced**, and then configure the following:  
  
    1.  To configure advanced 802.1X settings, in **IEEE 802.1X**, select **Enforce advanced 802.1X settings**.  
  
        When the advanced 802.1X settings are enforced, the default values for **Max Eapol\-Start Msgs**, **Held Period**, **Start Period**, and **Auth Period** are sufficient for most wireless deployments.  
  
    2.  To enable Single Sign On, select **Enable Single Sign On for this network**.  
  
    3.  The remaining default values in **Single Sign On** are sufficient for typical wireless deployments.  
  
    4.  In **Fast Roaming**, if your wireless AP is configured for pre\-authentication, select **This network uses pre\-authentication**.  
  
9. Click **OK** to return to the **Security** tab.  In **Select the security methods for this network**, in **Authentication**, select **WPA2\-Enterprise** if it is supported by your wireless AP and wireless client network adapters. Otherwise, select **WPA\-Enterprise**.  
  
10. In **Encryption**, if it is supported by your wireless AP and wireless client network adapters, select **AES**. Otherwise, select **TKIP**.  
  
    > [!NOTE]  
    > The settings for both **Authentication** and **Encryption** must match the settings configured on your wireless AP. On the **Security** tab, the default settings for **Authentication Mode**, **Max Authentication Failures**, and **Cache user information for subsequent connections to this network** are sufficient for typical wireless deployments.  
  
11. In **Select a network authentication method**, select **Protected EAP \(PEAP\)**, and then click **Properties**. The **Protected EAP Properties** page opens.  
  
12. In **Protected EAP Properties**, verify that **Validate server certificate** is selected.  
  
13. In **Trusted Root Certification Authorities**, select the trusted root certification authority \(CA\) that issued server certificates to your computers running Network Policy Server \(NPS\).  
  
    > [!NOTE]  
    > This setting limits the root CAs that clients trust to the selected CAs. If no trusted root CAs are selected, clients will trust all root CAs listed in their trusted root certification authority store.  
  
14. Select **Do not prompt user to authorize new servers or trusted certification authorities**. Selecting this setting provides an enhanced user experience and better security.  
  
15. In the **Select Authentication Method** list, select **Smart Card or other certificate**.  
  
16. To enable PEAP Fast Reconnect, select **Enable Fast Reconnect**.  
  
17. If Network Access Protection \(NAP\) is configured on your network, select **Enable Quarantine checks**. Otherwise, clear this check box.  
  
18. Click **Configure**. In the **Smart Card or other Certificate Properties** dialog box, in **When connecting**, specify one of the following.  
  
    -   For deployments that use smart cards, select **Use my smart card**.  
  
    -   For other certificate deployments, select **Use a certificate on this computer**.  
  
19. Select **Validate server certificate**.  
  
20. To specify which NPS servers your client computers can use for authentication and authorization, select **connect to these servers**, and then for each NPS server, type the name of each server, exactly as it appears in the **Subject** filed of each NPS server’s certificate, separated by a semicolon.  
  
21. In **Trusted Root Certification Authorities**, select the CA that issued certificates to your NPS servers.  
  
22. Click **OK**  two times, to close the Protected EAP properties, returning you to the **Security** tab.  
  
23. Click **OK** to close the **Security** tab, and then click **OK** again to close the Windows Vista Wireless Network Policy.  
  
### <a name="BKMK_EAP-TLS"></a>Configure a wireless connection profile for EAP\-TLS  
This procedure provides the steps that are required to configure an Extensible Authentication Protocol–Transport Level Security \(EAP\-TLS\) wireless profile for authentication by using secure passwords.  
  
Membership in Domain Admins, or equivalent, is the minimum requirement to complete this procedure.  
  
##### To configure an EAP\-TLS wireless profile  
  
1.  In **Windows Vista Wireless Network \(IEEE 802.11\) Policies Properties**, on the **General** tab, click **Add**, and then select **Infrastructure**.  
  
    > [!NOTE]  
    > For more information about the settings on any tab, press F1 while you are viewing that tab.  
  
2.  On the **Connection** tab, do the following:  
  
    1.  In **Profile Name**, type a name for the EAP\-based profile.  
  
    2.  In **Network Name\(s\) \(SSID\)**, type the service set identifier \(SSID\) that corresponds to the SSID configured on your wireless APs, and then click **Add.**  
  
    3.  If present, select **NEWSSID**, and then click **Remove**.  
  
    4.  If your wireless access point is configured to suppress its broadcast beacon, select **Connect even if the network is not broadcasting**.  
  
        > [!NOTE]  
        > Enabling this option can create a security risk because wireless clients will probe for and try to connect to any wireless network. By default, this setting is not enabled.  
  
3.  Select the **Security** tab, click **Advanced**, and then configure the following:  
  
    1.  To configure advanced 802.1X settings, in **IEEE 802.1X**, select **Enforce advanced 802.1X settings**.  
  
        > [!NOTE]  
        > When the advanced 802.1X settings are enforced, the default values for **Max Eapol\-Start Msgs**, **Held period**, **Start Period**, and **Auth Period** are sufficient for most wireless deployments.  
  
    2.  In **Single Sign On**, select **Enable Single Sign On for this network**.  
  
        > [!NOTE]  
        > The remaining default values in **Single Sign On** are sufficient for most wireless deployments.  
  
    3.  In **Fast Roaming**, if your wireless AP is configured for pre\-authentication, select **This network uses pre\-authentication**.  
  
4.  Click **OK** to return to the **Security** tab, and then configure the following:  
  
    1.  In **Select the security methods for this network**, for **Authentication**, if it is supported by your wireless AP and wireless client network adapters, select **WPA2\-Enterprise**. Otherwise, select **WPA\-Enterprise**.  
  
    2.  In **Encryption**, if it is supported by your wireless AP and wireless client network adapters, select **AES** \(preferred\). Otherwise, select **TKIP**.  
  
        > [!NOTE]  
        > The settings for both **Authentication** and **Encryption** must match the settings configured on your wireless AP. On the **Security** tab, the default settings for **Authentication Mode**, **Max Authentication Failures**, and **Cache user information for subsequent connections to this network** are sufficient for most wireless deployments.  
  
5.  In **Select a network authentication method**, select **Smart Card or other certificate \(EAP\-TLS\)**. On the **Security** tab, click **Properties**, and then configure the following:  
  
    1.  In **When connecting**, verify that **Use a certificate on this computer** and **Use simple certificate selection** are selected.  
  
    2.  Verify that **Validate server certificate** is selected.  
  
        In **Trusted Root Certification Authorities**, select the trusted root certification authority \(CA\) that issued the server certificate to your computers running Network Policy Server \(NPS\).  
  
        > [!NOTE]  
        > This setting limits the trusted root CAs that clients trust to the selected values. If no trusted root CAs are selected, clients will trust all trusted root CAs listed in their trusted root certification authority store.  
  
6.  Click **OK** to close **Smart Card or other Certificate Properties**, and then click **OK** again to close the **EAP Profile**.  
  
## <a name="BKMK_Settings"></a>Wireless Network \(IEEE 802.11\) Policies settings  
This section provides configuration setting details about the New Wireless Network Policy. You can use the New Wireless Network Policy to configure wireless settings on computers running [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)], [!INCLUDE[firstref_client_7](../Token/firstref_client_7_md.md)], and [!INCLUDE[firstref_vista](../Token/firstref_vista_md.md)].  
  
### Wireless Policies for computers running Windows Vista and subsequent releases of Windows  
In this section:  
  
1.  [General \- settings](#BKMK_general)  
  
2.  [Import and Export Wireless Network Profiles](#BKMK_Import)  
  
3.  [Connection \- settings](#BKMK_Connection)  
  
4.  [Network Permissions \- settings](#BKMK_NewPermissions)  
  
5.  [Security \- configuration items](#BKMK_Security)  
  
    1.  [Select the security methods for this network \- settings](#BKMK_NetSecMeth)  
  
    2.  [Select a network authentication method \- settings](#BKMK_NetAuthMeth)  
  
        > [!NOTE]  
        > Information about the network authentication methods is provided in the topic, [Advanced Security Settings for Wired and Wireless Network Policies](../Topic/Advanced-Security-Settings-for-Wired-and-Wireless-Network-Policies.md). Clicking this link will open a new Web page. A link is provided in the Additional Resources section of that topic to return you to this page.  
  
        > [!NOTE]  
        > Information about the Advanced Security settings is provided in the topic, [Advanced Security Settings for Wired and Wireless Network Policies](../Topic/Advanced-Security-Settings-for-Wired-and-Wireless-Network-Policies.md). Clicking this link will open a new Web page. A link is provided in the Additional Resources section of that topic to return you to this page.  
  
6.  [Additional Resources](#BKMK_AdditionalResources)  
  
#### <a name="BKMK_general"></a>General \- settings  
You can use the **General** tab to create and manage wireless network profiles and to define a list of preferred wireless networks, which prioritizes the order in which your domain\-member clients attempt to connect. You can also specify whether the WLAN AutoConfig Service is used to configure 802.11 wireless adapters to connect to wireless networks.  
  
|**Item**|**Details**|  
|------------|---------------|  
|**Vista Policy Name**|Provides a location for you to type a friendly name for the Wireless Network Policy. **Note:** When you name the Wireless Network \(IEEE 802.11\) Policy, the name you specify is displayed as the title of its properties page, and under **Name** in the details pane in the Group Policy Management Console \(GPMC\) for that policy.|  
|**Description**|Provides a location for you to type a description for the Wireless Policy. **Note:** The description you type is displayed under **Description** in the details pane of the Group Policy Management Console \(GPMC\) for that policy.|  
|**Use Windows WLAN Auto Config service for clients**|Specifies that the WLAN AutoConfig Service is used to configure and connect clients running [!INCLUDE[firstref_vista](../Token/firstref_vista_md.md)] to the wireless network.<br /><br />Default \= enabled|  
|**Connect to available networks in the order of profiles listed below**|Click the desired profile, and then use the **Move Up** and **Move down** buttons to specify the preferred order for clients to attempt connections. **Note:** Profiles for ad\-hoc networks cannot be prioritized higher than infrastructure profiles.|  
|**Add**|Allows you to add a wireless network profile and specify the profile properties.<br /><br />When you click **Add**, you will be presented with two options:<br /><br />**Ad\-hoc**. Specifies a computer\-to\-computer network. Access points are not used.<br /><br />**Infrastructure**. Specifies a network that uses one or more wireless access points.|  
|**Edit**|Select a network under **Profile name** and then click **Edit** to modify the properties of the wireless network profile.|  
|**Remove**|Select a network under **Profile name** and then click **Remove** to delete the wireless network profile.|  
|**Import**|Allows you to incorporate an existing wireless network profile, from a location you specify, into the list of available networks.|  
|**Export**|Allows you to save a configured profile as an Extensible Markup Langage \(XML\) file.|  
  
#### <a name="BKMK_Import"></a>Import and Export Wireless Network Profiles  
Profile import and export are managed by using the following two interfaces. You can use **Import a Profile** to add a wireless network profile, from a location you specify, into the list of available wireless networks. You can use **Save Export Profile** to export any profile listed under **Connect to available networks in the order of profiles listed below** on the **General** tab, and save it to a location you specify.  
  
##### Open for import a profile \(Import Profiles\)  
  
|**Item**|**Details**|  
|------------|---------------|  
|**Save in**|Specifies the location to save a profile.|  
|**Name**|Lists saved wireless profiles.|  
|**File name**|Provides a location for you to type a name for the profile.|  
|**Save as type**|Specifies the file type used to save the profile.|  
  
##### Save export profile as \(Export Profiles\)  
  
|**Item**|**Details**|  
|------------|---------------|  
|**Look in**|Specifies the location of a saved profile.|  
|**Name**|Lists saved profiles.<br /><br />Select the profile you want to export, and then click **Open**.|  
|**File name**|Provides a location for you to type a new name or modify the existing profile name.|  
|**Files of type**|Specifies the file type for files that are displayed under **Name**.|  
  
#### <a name="BKMK_Connection"></a>Connection \- settings  
The **Connection** tab for the Wireless Network \(IEEE 802.11\) Policy allows you to create wireless network profiles and specify the name of each wireless network to which domain\-member wireless clients can connect. Each network is saved as a profile. A *profile* is the collection of configuration settings for a wireless networks, saved as an Extensible Markup Language \(XML\) file.  
  
|**Item**|**Details**|  
|------------|---------------|  
|**Profile name**|Specifies the friendly name for the wireless network profile.|  
|**Network Name \(SSID\)**|Specifies the name of the wireless network. This must match the Service Set Identifier \(SSID\) configured on the wireless access points for this network.|  
|**Connect automatically when this network is in range**|Specifies that Windows will automatically attempt to connect to the wireless network when the computer is within broadcast range of any wireless access points that are broadcasting the SSID. **Note:** Windows attempts connections to wireless networks in the order they are listed in preferred networks.|  
|**Connect to a more preferred network if available**|Specifies that clients will attempt to connect to wireless networks in the order specified under **Connect to available networks in the order of profiles listed below** on the **General** tab.|  
|**Connect even if the network is not broadcasting**|Specifies that wireless clients will actively probe for wireless access points with the specified SSID, in case wireless access points are configured to suppress beacon broadcasts.|  
  
#### <a name="BKMK_NetPermissions"></a>Network Permissions \- settings  
You can use Network Permissions to list and configure wireless networks that are not defined on the **General** tab in the **Connect to available networks in the order of profiles listed below** preferred list. You can use these settings to define additional wireless networks and specify whether you want to allow or deny connections by your domain\-member wireless clients. Alternatively, you can block the additional wireless networks from being displayed to your domain\-member wireless clients. These settings are specific to the wireless networks listed on the **Network Permissions** tab under **Network Name \(SSID\)**.  
  
Connections to the wireless networks that are listed under **Network Name \(SSID\)** on the **Network Permissions** tab are only possible if the permission is set to **Allow**. If the permission is set to **Allow**, your domain\-member wireless clients first attempt to connect to a preferred network, before attempting to connect to non\-preferred networks. However, domain members can actively launch a connection attempt to listed networks that have permissions set to **Allow**.  
  
|**Item**|**Details**|  
|------------|---------------|  
|**Network Name \(SSID\)**|Lists wireless networks, for which you want to allow or deny permissions, but that are not defined on the **General** tab in **Connect to available networks in the order of profiles listed below**.<br /><br />Default \= disabled|  
|**Add**|Opens the **New Permission Entry** dialog box, for adding a new wireless network to the permission list.<br /><br />When you click **Add**, you will be presented with two options:<br /><br />-   **Ad\-hoc**. Specifies a computer\-to\-computer network. Access points are not used.<br />-   **Infrastructure**. Specifies a network that uses one or more wireless access points.|  
|**Remove**|Deletes the selected wireless network from the permission list.|  
|**Prevent connections to ad\-hoc networks**|Specifies that domain\-member wireless clients cannot form a new ad\-hoc network or connect to any ad\-hoc networks in the permission list.<br /><br />Default \= not enabled|  
|**Prevent connections to infrastructure networks**|Specifies that domain\-member wireless clients cannot connect to any infrastructure networks in the permission list.<br /><br />Default \= not enabled|  
|**Allow user to view denied networks**|Specifies whether domain\-member wireless clients can view wireless networks in the permission list that have permissions set to **Deny**.<br /><br />Default \= not enabled|  
|**Allow everyone to create all user profiles**|Specifies that any user to which Wireless Network \(IEEE 802.11\) Policy applies can create all user wireless profiles on the computer. When this setting is not selected, only users in the Network Administrators group or Network Operators group can create all user wireless profiles on the computer.<br /><br />*All user profiles* are wireless profiles that are used to connect to a specific wireless network and that can be started by any user with an account on the computer. Every user with an account on the computer is contained within the computer\-wide access control list \(ACL\) named **Everyone**. Based on the Everyone ACL group, network administrators can use this setting to limit access to the controls that enable users to create all user profiles.<br /><br />Default \= enabled|  
  
#### <a name="BKMK_NewPermissions"></a>New Permissions Entry \- settings  
You can use the Wireless Network \(IEEE 802.11\) Policy New Permission page to add new wireless networks to the permission list on the **Networks Permissions** tab. You can use New Permissions to specify, by Service Set Identifier \(SSID\), which wireless networks your wireless domain members are allowed to connect to, and which are denied.  
  
|**Items**|**Details**|  
|-------------|---------------|  
|**Network Name \(SSID\)**|Provides a location for you to type the name for the wireless network for which you want to set permissions.|  
|**Network Type**|Specifies whether the network is infrastructure \(uses a wireless access point\) or ad\-hoc \(computer\-to\-computer\).|  
|**Permission**|Specifies whether to permit or deny connections to the selected network.|  
  
#### <a name="BKMK_Security"></a>Security – configuration items  
Security configuration items include all of the settings on the **Security** tab. These settings specify whether to perform 802.1X authentication for connecting clients, which network security authentication method to use, and which network authentication method to use.  
  
[Select the security methods for this network](#BKMK_VistWirls_NetSecMeth) settings pertain to the authentication and security that the client uses to exchange data with the wireless access point.  
  
[Select a network authentication method](#BKMK_VistWirls_NetAuthMeth) settings pertain to the EAP method that is used for 802.1X authenticated network access.  
  
#### <a name="BKMK_NetSecMeth"></a>Select the security methods for this network \- settings  
  
|**Item**|**Details**|  
|------------|---------------|  
|**Authentication**|Specifies the security authentication method to use when the wireless client associates with the wireless access point.<br /><br />-   **Open**<br />-   **Shared**<br />-   **WPA\-Enterprise**<br />-   **WPA\-Personal**<br />-   **WPA2\-Enterprise**<br />-   **WPA2\-Personal**<br />-   **Open with 802.1X** **Note:** Network Authentication Methods and advanced settings are only exposed by selecting **WPA\-Enterprise**, **WPA2\-Enterprise**, and **Open with 802.1X** for the network security authentication method.<br /><br />Default \= Defaults to the most secure setting supported by the wireless hardware and drivers.|  
|**Encryption**|Specifies the security encryption to use for the selected network security authentication method.<br /><br />If the **Authentication** is set to **WPA\-Enterprise**, **WPA\-Personal**, **WPA2\-Enterprise**, or **WPA2\-Personal**, the encryption options are **AES** or **TKIP**.<br /><br />If **Authentication** is set to **Open**, **Shared**, or **Open with 802.1X**, then encryption options are either **WEP** or **Disabled**.|  
  
#### <a name="BKMK_NetAuthMeth"></a>Select a network authentication method \- settings  
  
|**Item**|**Details**|  
|------------|---------------|  
|**Select a network authentication method**|Specifies the network authentication method that connecting wireless clients use.<br /><br />-   **Smart Card or other certificate**<br />-   **Protected EAP \(PEAP\)**<br /><br />Default \= Protected EAP \(PEAP\)|  
|**Properties**|Opens the properties page of the selected network authentication method.<br /><br />For setting information for network authentication methods, see: [Extensible Authentication Protocol &#40;EAP&#41; Settings for Network Access](../Topic/Extensible-Authentication-Protocol--EAP--Settings-for-Network-Access.md). Clicking this link will open a new Web page. A link is provided in the Additional Resources section of that topic to return you to this page.|  
|**Authentication Mode**|Specifies how credentials are used for network authentication. The following options are available.<br /><br />-   **User re\-authentication**. An 802.1X\-compliant device always uses security credentials based on the computer's current state. Authentication is performed by using the computer credentials when no users are logged on to the computer. When a user logs on to the computer, authentication is always performed by using the user credentials.<br />    This is the recommended setting.<br />-   **Computer only**. Authentication is always performed using only the computer credentials.<br />-   **User authentication**. Specifies that when users are not logged on to the computer, authentication is performed by using the computer credentials. After a user logs on to the computer, authentication is still based on the computer credentials. Authentication is performed by using the user credentials if the user travels to a new wireless access point.<br />-   **Guest authentication**.Allows connections to the network which are regulated by the restrictions and permissions set for the Guest user account.<br /><br />Default \= User re\-authentication|  
|**Max Authentication Failures**|Specifies the maximum number of failed authentication attempts that can occur with a specific set of credentials before notification is displayed to indicate that authentication has failed.<br /><br />Default \= 3|  
|**Clear credentials after logoff**|Specifies that when the user logs off, the user credential data is removed from the registry. The result is that at the next user log on, they will be prompted for their credentials \(such as user name and password\).<br /><br />Default \= Not enabled|  
|**Authenticate as guest when user or computer information is unavailable**|Specifies that client connection requests that cannot meet computer or user authentication requirements can connect to the network by using permissions configured for the Guest account.<br /><br />Default \= Not enabled|  
|**Advanced**|Provides access to advanced security settings. **Note:** Information about the Advanced Security settings is provided in the topic, [Advanced Security Settings for Wired and Wireless Network Policies](../Topic/Advanced-Security-Settings-for-Wired-and-Wireless-Network-Policies.md). Clicking this link will open a new Web page. A link is provided in the Additional Resources section of that topic to return you to this page.|  
  
## <a name="BKMK_AdditionalResources"></a>Additional resources  
For additional information about the Advanced Security settings, see [Advanced Security Settings for Wired and Wireless Network Policies](../Topic/Advanced-Security-Settings-for-Wired-and-Wireless-Network-Policies.md), in the Microsoft technical library on TechNet.  
  
For additional information about network authentication methods, see [Extensible Authentication Protocol &#40;EAP&#41; Settings for Network Access](../Topic/Extensible-Authentication-Protocol--EAP--Settings-for-Network-Access.md), in the Microsoft technical library on TechNet.  
  
