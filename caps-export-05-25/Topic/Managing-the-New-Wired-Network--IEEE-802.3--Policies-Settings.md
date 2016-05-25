---
title: Managing the New Wired Network (IEEE 802.3) Policies Settings
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dd157aa8-f392-43b9-95fb-036358a03011
author: markgalioto
---
# Managing the New Wired Network (IEEE 802.3) Policies Settings
This topic provides details about configuring 802.1X authenticated wired Ethernet access using the Wired Network \(IEEE 802.3\) Policies extension of Group Policy. Information is presented in two main sections:  
  
-   [Configuring Wired Network \(IEEE 802.3\)  Policies](#BKMK_CfgWired) provides step\-by\-step details for configuring 802.1X authenticated Wired Access based on one of the authentication methods you have selected:  
  
    -   Configure a wired connection profile for PEAP\-MS\-CHAP v2  
  
    -   Configure a wired connection profile for PEAP\-TLS  
  
    -   Configure a wired connection profile for EAP\-TLS  
  
-   [Per\-setting details](#BKMK_PerSetting) provides information about the individual settings in the Wired Network \(IEEE 802.3\) Policies extension of Group Policy:  
  
    -   General – settings  
  
    -   Security \- settings  
  
    -   Advanced security settings for Wired and Wireless Network Policies  
  
## <a name="BKMK_CfgWired"></a>Configuring Wired Network \(IEEE 802.3\) Policies  
This section provides step\-by\-step details to configure Wired Network \(IEEE 802.3\) Policies extension of Group Policy for 802.1X authenticated wired network access.  
  
-   [Configure a wired connection profile for PEAP\-MS\-CHAP v2](#BKMK_PMSCHAP)  
  
-   [Configure a wired connection profile for PEAP\-TLS](#BKMK_PTLS)  
  
-   [Configure a wired connection profile for EAP\-TLS](#BKMK_ETLS)  
  
### <a name="BKMK_PMSCHAP"></a>Configure a wired connection profile for PEAP\-MS\-CHAP v2  
This procedure provides the steps that are required to configure a wired access connection profile for Protected Extensible Authentication Protocol–Microsoft Challenge Handshake Authentication Protocol version 2 \(PEAP\-MS\-CHAP v2\) for authentication by using secure passwords.  
  
Membership in Domain Admins, or equivalent, is the minimum requirement to complete this procedure.  
  
> [!TIP]  
> For more information about individual controls on any active dialog box in Wired Network \(IEEE 802.3\) Policies, press **F1** while viewing that dialog box.  
  
##### To configure a wired connection profile for PEAP\-MS\-CHAP v2  
  
1.  If you have not already done so, open the New Wired Network \(IEEE 802.3\) Policies Properties dialog.  
  
2.  In **New Wired Network \(IEEE 802.3\) Policies Properties**, on the **General** tab, in **Policy Name**, type a name for your network policy, or leave the default name **New Wired Network Policy**.  
  
3.  In **Description**, type a description for your network policy.  
  
4.  Select **Use Windows Wired Auto Config service for clients** to specify that Wired AutoConfig is used to configure wired network adapter settings.  
  
5.  To prevent the use of shared user credentials for authentication for computers running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], select **don’t allow shared user credentials for network authentication**.  
  
6.  To specify the duration for which automatic authentication attempts will be blocked from occurring after a failed authentication attempt, select **Enable block period \(minutes\)**.  
  
7.  Click the **Security** tab, click **Advanced**, and then configure the following:  
  
    1.  To configure advanced 802.1X settings, in **IEEE 802.1X**, select **Enforce advanced 802.1X settings**.  
  
        When the advanced 802.1X settings are enforced, the default values for **Max Eapol\-Start Msgs**, **Held Period**, **Start Period**, **Auth Period**, and **Eapol\-Start Message** are sufficient for common wired access deployments.  
  
    2.  To enable Single Sign On, select **Enable Single Sign On for this network**.  
  
    3.  To specify whether Single Sign On is performed before or after user logon, select either **Perform immediately before User Logon** or **Perform immediately after User Logon**.  
  
    4.  To specify a maximum connectivity delay, select **Max delay for connectivity \(seconds\)**, and then specify a value, or leave the default value of 10.  
  
8.  To specify whether additional dialogs may be displayed during Single Sign On, select **Allow additional dialogs to be displayed during Single Sign On**.  
  
9. If your network is configured to use different VLANs for authentication that uses computer credentials and authentication that uses user credentials, select **This network uses different VLAN for authentication with machine and user credentials**.  
  
10. Click **OK** to return to the **Security** tab.  In **Select a network authentication method**, select **Protected EAP \(PEAP\)**, and then click **Properties**. The **Protected EAP Properties** page opens.  
  
11. In **Protected EAP Properties**, verify that **Validate server certificate** is selected.  
  
12. In **Trusted Root Certification Authorities**, select the trusted root certification authority \(CA\) that issued the server certificate to your computer running Network Policy Server \(NPS\).  
  
    > [!NOTE]  
    > This setting limits which root CAs that clients trust to the selected CAs. If no trusted root CAs are selected, clients will trust all root CAs listed in their trusted root certification authority store.  
  
13. Select **Do not prompt user to authorize new servers or trusted certification authorities**. Selecting this setting provides an enhanced user experience and better security.  
  
14. In the **Select Authentication Method** list, select **Secured password \(EAP\-MS\-CHAP v2\)**.  
  
15. To enable PEAP fast reconnect, select **Enable Fast Reconnect**.  
  
16. If Network Access Protection \(NAP\) is configured on your network, select **Enable Quarantine checks**. Otherwise, clear this check box.  
  
17. Click **Configure**. In the **EAP MSCHAPv2 Properties** dialog box, verify **Automatically use my Windows logon name and password \(and domain if any\)** is selected, click **OK**, and then click **OK** to close **Protected EAP Properties**.  
  
18. Click **OK** to close the **Security** tab, and then click **OK** again to close the Windows Vista Wired \(IEEE 802.3\) Network Policy.  
  
[Back to top](#BKMK_TOP)  
  
### <a name="BKMK_PTLS"></a>Configure a wired connection profile for PEAP\-TLS  
This procedure provides the steps that are required to configure a wired access connection profile for Protected Extensible Authentication Protocol – Transport Layer Security \(PEAP\-TLS\) for authentication by using smart cards or user and computer digital certificates.  
  
Membership in Domain Admins, or equivalent, is the minimum requirement to complete this procedure.  
  
> [!TIP]  
> For more information about individual controls on any active dialog box in Wired Network \(IEEE 802.3\) Policies, press **F1** while viewing that dialog box.  
  
##### To configure a wired connection profile for PEAP\-TLS  
  
1.  If you have not already done so, open the New Wired Network \(IEEE 802.3\) Policies Properties dialog.  
  
2.  In **New Wired Network \(IEEE 802.3\) Policies Properties**, on the **General** tab, in **Policy Name**, type a name for your network policy, or leave the default name **New Wired Network Policy**.  
  
3.  In **Description**, type a description for your network policy.  
  
4.  Select **Use Windows Wired Auto Config service for clients** to specify that Wired AutoConfig is used to configure wired network adapter settings.  
  
5.  To prevent the use of shared user credentials for authentication for computers running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], select **don’t allow shared user credentials for network authentication**.  
  
6.  To specify the duration for which automatic authentication attempts will be blocked from occurring after a failed authentication attempt, select **Enable block period \(minutes\)**.  
  
7.  Click the **Security** tab, click **Advanced**, and then configure the following:  
  
    1.  To configure advanced 802.1X settings, in **IEEE 802.1X**, select **Enforce advanced 802.1X settings**.  
  
        When the advanced 802.1X settings are enforced, the default values for **Max Eapol\-Start Msgs**, **Held Period**, **Start Period**, **Auth Period**, and **Eapol\-Start Message** are sufficient for common wired access deployments.  
  
    2.  To enable Single Sign On, select **Enable Single Sign On for this network**.  
  
    3.  To specify whether Single Sign On is performed before or after user logon, select either **Perform immediately before User Logon** or **Perform immediately after User Logon**.  
  
    4.  To specify a maximum connectivity delay, select **Max delay for connectivity \(seconds\)**, and then specify a value, or leave the default value of 10.  
  
8.  To specify whether additional dialogs may be displayed during Single Sign On, select **Allow additional dialogs to be displayed during Single Sign On**.  
  
9. If your network is configured to use different VLANs for authentication that uses computer credentials and authentication that uses user credentials, select **This network uses different VLAN for authentication with machine and user credentials**.  
  
10. Click **OK** to return to the **Security** tab. In **Select a network authentication method**, select **Protected EAP \(PEAP\)**, and then click **Properties**. The **Protected EAP Properties** page opens.  
  
11. In **Protected EAP Properties**, verify that **Validate server certificate** is selected.  
  
12. In **Trusted Root Certification Authorities**, select the trusted root certification authority \(CA\) that issued the server certificate to your computer running Network Policy Server \(NPS\).  
  
    > [!NOTE]  
    > This setting limits which root CAs that clients trust to the selected CAs. If no trusted root CAs are selected, clients will trust all root CAs listed in their trusted root certification authority store.  
  
13. Select **Do not prompt user to authorize new servers or trusted certification authorities**. Selecting this setting provides an enhanced user experience and better security.  
  
14. In the **Select Authentication Method** list, select **Smart Card or other certificate**, and then click **Configure**. The **Smart Card or other Certificate Properties** dialog box opens.  
  
15. In the **Smart Card or other Certificate Properties** dialog box, in **When connecting**, for smart card deployments, select **Use my smart card**. Otherwise, for computer and user digital certificate deployments, select **Use a certificate on this computer**.  
  
16. Verify that **Validate server certificate** is selected.  
  
17. In **Trusted Root Certification Authorities**, select the trusted root certification authority \(CA\) that issued the server certificate to your computer running Network Policy Server \(NPS\).  
  
18. Select **Do not prompt user to authorize new servers or trusted certification authorities**.  
  
19. Click **OK**. The **Smart Card or other Certificate Properties** dialog box closes, returning you to **Protected EAP Properties**.  
  
20. On the **Protected EAP Properties** dialog box, to enable PEAP fast reconnect, select **Enable Fast Reconnect**.  
  
21. If Network Access Protection \(NAP\) is configured on your network, select **Enable Quarantine checks**. Otherwise, clear this check box.  
  
22. Click **OK**, to close the **Protected EAP Properties** dialog box, click **OK** to close the **Security** tab, and then click **OK** again to close the [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] Wired \(IEEE 802.3\) Network Policy.  
  
[Back to top](#BKMK_TOP)  
  
### <a name="BKMK_ETLS"></a>Configure a wired connection profile for EAP\-TLS  
This procedure provides the steps that are required to configure a wired access connection profile for Extensible Authentication Protocol – Transport Layer Security \(PEAP\-TLS\) for authentication by using smart cards or user and computer digital certificates.  
  
Membership in Domain Admins, or equivalent, is the minimum requirement to complete this procedure.  
  
> [!TIP]  
> For more information about individual controls on any active dialog box in Wired Network \(IEEE 802.3\) Policies, press **F1** while viewing that dialog box.  
  
##### To configure a wired connection profile for EAP\-TLS  
  
1.  If you have not already done so, open the New Wired Network \(IEEE 802.3\) Policies Properties dialog.  
  
2.  In **New Wired Network \(IEEE 802.3\) Policies Properties**, on the **General** tab, in **Policy Name**, type a name for your network policy, or leave the default name **New Wired Network Policy**.  
  
3.  In **Description**, type a description for your network policy.  
  
4.  Select **Use Windows Wired Auto Config service for clients** to specify that Wired AutoConfig is used to configure wired network adapter settings.  
  
5.  To prevent the use of shared user credentials for authentication for computers running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], select **don’t allow shared user credentials for network authentication**.  
  
6.  To specify the duration for which automatic authentication attempts will be blocked from occurring after a failed authentication attempt, select **Enable block period \(minutes\)**.  
  
7.  Click the **Security** tab, click **Advanced**, and then configure the following:  
  
    1.  To configure advanced 802.1X settings, in **IEEE 802.1X**, select **Enforce advanced 802.1X settings**.  
  
        When the advanced 802.1X settings are enforced, the default values for **Max Eapol\-Start Msgs**, **Held Period**, **Start Period**, **Auth Period**, and **Eapol\-Start Message** are sufficient for common wired access deployments.  
  
    2.  To enable Single Sign On, select **Enable Single Sign On for this network**.  
  
    3.  To specify whether Single Sign On is performed before or after user logon, select either **Perform immediately before User Logon** or **Perform immediately after User Logon**.  
  
    4.  To specify a maximum connectivity delay, select **Max delay for connectivity \(seconds\)**, and then specify a value, or leave the default value of 10.  
  
8.  To specify whether additional dialogs may be displayed during Single Sign On, select **Allow additional dialogs to be displayed during Single Sign On**.  
  
9. If your network is configured to use different VLANs for authentication that uses computer credentials and authentication that uses user credentials, select **This network uses different VLAN for authentication with machine and user credentials**.  
  
10. Click **OK** to return to the **Security** tab. In the **Select Authentication Method** list, select **Smart Card or other certificate**, and then click **Properties**. The **Smart Card or other Certificate Properties** dialog box opens.  
  
11. In the **Smart Card or other Certificate Properties** dialog box, in **When connecting**, for smart card deployments, select **Use my smart card**. Otherwise, for computer and user digital certificate deployments, select **Use a certificate on this computer**.  
  
12. Verify that **Validate server certificate** is selected.  
  
13. In **Trusted Root Certification Authorities**, select the trusted root certification authority \(CA\) that issued the server certificate to your computer running Network Policy Server \(NPS\).  
  
14. Select **Do not prompt user to authorize new servers or trusted certification authorities**.  
  
15. Click **OK**. The **Smart Card or other Certificate Properties** dialog box closes, returning you to the **Security** tab.  
  
16. Click **OK** to close the **Security** tab, and then click **OK** again to close the [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] Wired \(IEEE 802.3\) Network Policy.  
  
[Back to top](#BKMK_TOP)  
  
## <a name="BKMK_PerSetting"></a>Per\-setting details  
This section provides details about settings in the Wired Network \(IEEE 802.3\) Policies extension of Group Policy:  
  
1.  [General \- settings](#BKMK_General)  
  
2.  [Security \- settings](#BKMK_Security)  
  
> [!NOTE]  
> Information about the Advanced security settings is provided in the topic, [Advanced Security Settings for Wired and Wireless Network Policies](../Topic/Advanced-Security-Settings-for-Wired-and-Wireless-Network-Policies.md). Clicking this link will open a new Web page. A link is provided in the Additional Resources section of that topic to return you to this page.  
  
### <a name="BKMK_General"></a>General \- settings  
Use the Wired Network \(IEEE 802.3\) Policies General tab to specify whether the Wired AutoConfig Service is used to configure local area network \(LAN\) adapters to connect to the wired network. You can also specify the policy name and description.  
  
|**Item**|**Details**|  
|------------|---------------|  
|**Policy Name**|Provides a location for you to type a name for the Network Policy that is applied to your wired clients running [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)]. **Note:** When you name the Wired Network \(IEEE 802.3\) Policy, the name is displayed as the title of its property pages, and under **Name** in the details pane in the Group Policy Management Console \(GPMC\) for that policy.|  
|**Description**|Provides a location for you to type a description for your Wired Network \(IEEE 802.3\) Policy. **Note:** The description you type is displayed under **Description** in the details pane of the Group Policy Management Console \(GPMC\) for that policy.|  
|**Use Windows wired network service for clients**|Specifies that Wired AutoConfig Service is used to configure and connect clients running [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] to the 802.3 wired Ethernet network.<br /><br />Default \= enabled|  
|**Don’t allow shared user credentials for network authentication**|Specifies that users with computers running Windows 7 are not allowed to store their user credentials \(such as user name and password\), which the computer can then use to log on to the network \(even though the user is not actively logged on to the computer\).<br /><br />Default \= not selected. Users are allowed to enter and store their user credentials in profiles that they configure.<br /><br />The following statements summarize the behavior of this setting:<br /><br />-   This setting is provided in both the Wired Network \(IEEE 802.3\) Policies and the version of the Wireless Network \(IEEE 802.11\) Policies that you can configure for client computers running [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] and subsequent releases of Windows.<br />-   This setting is per\-Group Policy object \(GPO\), and within each GPO it is specific to the Wired Network \(IEEE 802.3\) Policies and Wireless Network \(IEEE 802.11\) Policies.<br />-   For as long as the default setting remains unchanged, the local administrator can use the netsh LAN set allowexplicitcreds command on client computers running [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] to allow or disallow users to store their user credentials.<br />-   After the first time that the default is changed the administrator can use this setting to enable or disable the capability for users to configure non\-Group Policy based user profiles to store their user credentials. User credentials cannot be stored with Group Policy profiles.|  
|**Enable block period \(minutes\)**|Specifies whether to prohibit computers running [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] from making auto connection attempts to the network for a specified amount of time, following a failed authentication attempt. The blocked state is reset upon a manual connection attempt, a session change, or a media connect.<br /><br />Default \= not enabled. If enabled, the default is 20 minutes. The valid range of minutes is 1\-60.|  
  
[Back to top](#BKMK_TOP)  
  
### <a name="BKMK_Security"></a>Security \- settings  
Security configuration items include all of the settings on the **Security** tab. These settings specify whether to perform 802.1X authentication for connecting clients and which network authentication method to use.  
  
|**Item**|**Details**|  
|------------|---------------|  
|**Enable use of IEEE 802.1X authentication for network access**|Specifies that 802.1X authentication is performed for access requests to the wired network.<br /><br />Default \= enabled|  
|**Select a network authentication**|-   Specifies the network authentication method that connecting clients use:<br />-   **Smart Card or other certificate** \(EAP\-TLS\)<br />-   **Protected EAP \(PEAP\)**<br /><br />Default \= Protected EAP \(PEAP\)|  
|**Properties**|Opens the properties page of the selected network authentication method.<br /><br />For setting information specific to network authentication methods, see: [Extensible Authentication Protocol &#40;EAP&#41; Settings for Network Access](../Topic/Extensible-Authentication-Protocol--EAP--Settings-for-Network-Access.md)|  
|**Authentication Mode**|Specifies how network authentication is performed:<br /><br />-   **User re\-authentication**. An 802.1X\-compliant device always uses security credentials based on the computer's current state. Authentication is performed by using the computer credentials when no users are logged on to the computer. When a user logs on to the computer, authentication is always performed using the user credentials.<br />    This is the recommended setting.<br />-   **Computer only**. Authentication is always performed using only the computer credentials.<br />-   **User authentication**. Specifies that when users are not logged on to the computer, authentication is performed by using the computer credentials. After a user logs on to the computer, authentication is still based on the computer credentials. Authentication is performed by using the user credentials if the user travels to a new wireless access point.<br />-   **Guest authentication**. Allows connections to the network that are regulated by the restrictions and permissions set for the Guest user account.<br /><br />Default \= User re\-authentication|  
|**Max Authentication Failures**|Specifies the maximum number of failed authentication attempts that can occur with a specific set of credentials before notification is displayed to indicate that authentication has failed.<br /><br />Default \= 3|  
|**Advanced**|Opens the Advances security dialog.<br /><br />For information about advanced security settings, see [Advanced Security Settings for Wired and Wireless Network Policies](../Topic/Advanced-Security-Settings-for-Wired-and-Wireless-Network-Policies.md)|  
  
[Back to top](#BKMK_TOP)  
  
## See Also  
[802.1X Authenticated Wired Access Overview](../Topic/802.1X-Authenticated-Wired-Access-Overview.md)  
  
