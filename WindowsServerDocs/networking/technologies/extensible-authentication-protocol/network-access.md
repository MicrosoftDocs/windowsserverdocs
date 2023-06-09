---
title: Extensible Authentication Protocol (EAP) for network access in Windows
description: This article presents information about the Extensible Authentication Protocol (EAP) settings and configuration in Windows-based computers.
author: xelu86
ms.author: wscontent
ms.topic: conceptual
ms.date: 06/09/2023
ms.contributor: samyun
---

# Extensible Authentication Protocol (EAP) for network access

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 11, Windows 10, Windows 8.1

The Extensible Authentication Protocol (EAP) is an authentication framework that allows for the use of different authentication methods for secure network access technologies. Examples of these technologies include wireless access using IEEE 802.1X, wired access using IEEE 802.1X, and Point-to-Point Protocol (PPP) connections like Virtual Private Networking (VPN). EAP isn't a specific authentication method like MS-CHAP v2, but rather a framework that enables networking vendors to develop and install new authentication methods, known as EAP methods, on the access client and authentication server.

## Authentication methods

EAP authentication methods that are used within tunneled EAP methods are commonly known as **inner methods** or **EAP types**. This article contains configuration information specific to the following authentication methods in EAP.

**Protected EAP (PEAP)**: This section contains configuration information for the two default inner EAP methods that are provided with PEAP.

- **EAP-Transport Layer Security (TLS)**: Appears as **Smart Card or other Certificate (EAP-TLS)** in the Windows, EAP-TLS can be deployed as an inner method for PEAP or as a standalone EAP method. If EAP-TLS is set up as an inner authentication method, it has the same configuration settings as EAP-TLS when it's used as an outer method. The only difference is that the method will be configured to work within PEAP.

- **EAP-Microsoft Challenge Handshake Authentication Protocol version 2 (MS-CHAP v2)**: Appears as **Secure password (EAP-MSCHAP v2)** in Windows, EAP-MSCHAP v2 is an EAP type that can be used with PEAP for password-based network authentication. EAP-MSCHAP v2 can also be used as a standalone method for VPN, but only as a PEAP inner method for wireless. EAP-MSCHAP v2 is the EAP method that encapsulates the MS-CHAPv2 authentication protocol.

**EAP-Tunneled Transport Layer Security (TTLS)**: Encapsulates a TLS session that authenticates the server to client and authenticates the client to the server using another inner authentication mechanism such as EAP or a non-EAP protocol, such as Password Authentication Protocol (PAP). In Windows Server 2012, the inclusion of EAP-TTLS only provides support on the client-side. This is done to enable interoperation with the most commonly deployed RADIUS servers that support EAP-TTLS.

**EAP-Subscriber Identity Module (SIM), EAP-Authentication and Key Agreement (AKA), and EAP-AKA Prime (AKA')**: Enables authentication by using SIM cards, and is implemented when a customer purchases a wireless broadband service plan from a mobile network operator. As part of the plan, the customer commonly receives a wireless profile that is preconfigured for SIM authentication.

**Tunnel EAP (TEAP)**: Standards-based tunneled EAP method that establishes a secure TLS tunnel and executes other EAP methods inside that tunnel. Supports EAP chain-authenticating the machine and user within one authentication session. Support for the Windows 10 client was added in version 2004 (build 19041).

## EAP-TLS, PEAP, and EAP-TTLS

You can access the EAP properties for 802.1X authenticated wired and wireless access in the following ways:

- Configuring the Wired Network (IEEE 802.3) Policies and Wireless Network (IEEE 802.11) Policies extensions in Group Policy.
- Manually configuring wired or wireless connections on client computers.

You can access the EAP properties for virtual private network (VPN) connections in the following ways:

- Using Connection Manager Administration Kit (CMAK) to configure VPN connections.
- Manually configuring VPN connections on client computers.

By default, you can configure EAP settings for the following network authentication methods for 802.1X authenticated wired access, 802.1X authenticated wireless access, and VPN:

- Microsoft: Smart card or other certificate (EAP-TLS)
- Microsoft: Protected EAP (PEAP)
- Microsoft: EAP-TTLS

The MS-CHAP-V2 network authentication method is available for VPN by default.

## Windows Server prerequisite

On the Windows client, wireless capabilities for EAP are enabled by default on supported adapters. Wireless capabilities on Windows Server are disabled by default and can be enabled through Server Manager or PowerShell.

## [Server Manager](#tab/server-manager)

To learn how to install Windows Server roles and features, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).

1. In the **Add Roles and Features Wizard**, under **Server Roles**, select **Next**.
1. In the **Features** windows, select **Wireless LAN Service**, select **Next**, then select **Install**.
1. Once installation is complete, click **Close** and reboot your device.

## [PowerShell](#tab/powerhshell)

You can use PowerShell to install the **Wireless LAN Service** feature and management tools by running the following command:

```powershell
Install-WindowsFeature -Name Wireless-Networking -IncludeManagementTools -Restart
```

A reboot is required once installation is complete.

---

## Authentication method configuration settings

To access the configuration settings for the authentication method of choice, perform the following:

1. Click **Start** > type **ncpa.cpl** > hit <kbd>Enter</kbd>.
1. Right-click on the Wi-Fi network you want to edit and select **Properties**.
1. Click the **Security** tab > under **Security type**, select **WPA2-Enterprise**.
1. Under **Choose a network authentication method**, choose the authentication method you want to configure, then select **Settings**.

> [!CAUTION]
> Deploying the same type of authentication method for PEAP and EAP creates a security vulnerability. When you deploy both PEAP and EAP (which isn't protected), don't use the same authentication type. For example, if you deploy PEAP-TLS, do not also deploy EAP-TLS.

The following table explains the configurable settings for each authentication method.

## [EAP-TLS](#tab/eap-tls)

|Setting|Default|Description|
|--|--|--|
|**Use my smart card**|Wired/Wireless: Disabled<p>VPN: Enabled|Specifies that clients making authentication requests must present a smart card certificate for network authentication.|
|**Use a certificate on this computer**|Wired/Wireless: Enabled<p>VPN: Disabled|Specifies that authenticating clients must use a certificate located in the Current User or Local Computer certificate stores.|
|**Use simple certificate selection (Recommended)**|Wired/Wireless: Enabled<p>VPN: Disabled|Specifies whether Windows filters out certificates that are unlikely to meet authentication requirements. This serves to limit the list of available certificates when prompting the user to select a certificate.|
|**Advanced**||Opens the [Configure Certificate Selection](#configure-certificate-selection) dialog box.|
|**Verify the server’s identity by validating the certificate**|Enabled|Specifies that the client verifies that the server certificates presented to the client computer have the correct signatures, haven't expired, and were issued by a trusted root certification authority (CA). Disabling this check box causes client computers to be unable to verify the identity of your servers during the authentication process. If server authentication doesn't occur, users are exposed to severe security risks, including the possibility that users might unknowingly connect to a rogue network.|
|**Connect to these servers**|Wired/Wireless: Disabled<p>VPN: Enabled|Allows you to specify the name for Remote Authentication Dial-In User Service (RADIUS) servers that provide network authentication and authorization.<p>You must type the name **exactly** as it appears in the **subject** field of each RADIUS server certificate or use regular expressions to specify the server name.<p> The complete syntax of the regular expression can be used to specify the server name, but to differentiate a regular expression with the literal string, you must use at least one `*` in the string specified. For example, you can specify `nps*.example.com` to specify the RADIUS server `nps1.example.com` or `nps2.example.com` but not `nps12.example.com`.<p> **If no RADIUS servers are specified, the client verifies that the RADIUS server certificate was issued by a trusted root CA.**|
|**Trusted Root Certification Authorities**|No trusted root CAs are selected|Lists the trusted root certification authorities. The list is built from the trusted root CAs that are installed in the computer and in the user certificate stores. You can specify which trusted root CA certificates supplicants use to determine whether they trust your servers, such as your server running Network Policy Server (NPS) or your provisioning server. If no trusted root CAs are selected, the 802.1X client verifies that the computer certificate of the RADIUS server was issued by an installed trusted root CA. If one or multiple trusted root CAs are selected, the 802.1X client verifies that the computer certificate of the RADIUS server was issued by a selected trusted root CA. <p> **If no trusted root CAs are selected, the client verifies that the RADIUS server certificate was issued by a trusted root CA.** <p> If you have a public key infrastructure (PKI) on your network, and you use your CA to issue certificates to your RADIUS servers, your CA certificate is automatically added to the list of trusted root CAs. You can also purchase a CA certificate from a non-Microsoft vendor. Some non-Microsoft trusted root CAs provide software with your purchased certificate that automatically installs the purchased certificate into the **Trusted Root Certification Authorities** certificate store. In this case, the trusted root CA automatically appears in the list of trusted root CAs.<p> Don't specify a trusted root CA certificate that isn't already listed in client computers’ **Trusted Root Certification Authorities** certificate stores for **Current User** and **Local Computer**. If you designate a certificate that isn't installed on client computers, authentication will fail.|
|**View certificate**||Enables you to view the properties of the selected certificate.|
|**Do not prompt user to authorize new servers or trusted certification authorities**|Disabled|Prevents the user from being prompted to trust a server certificate if that certificate is incorrectly configured, isn't already trusted, or both (if enabled). To simplify the user experience and prevent users from mistakenly trusting a server deployed by an attacker, it's recommended that you select this checkbox.|
|**Use a different user name for the connection**|Disabled|Specifies whether to use a user name for authentication that is different from the user name in the certificate.|

The following lists the configuration settings for **Configure Certificate Selection**.

|Setting|Default|Description|
|--|--|--|
|<a id="configure-certificate-selection" />**Configure Certificate Selection**||Configure the criteria that client computer uses to automatically select the appropriate certificate for authentication purposes. This configuration can be provided to network client computers through the Wired Network (IEEE 802.3) Policies, the Wireless Network (IEEE 802.11) Policies, or through Connection Manager Administration Kit (CMAK) for VPN. This means that clients will be automatically provisioned with the specified authentication criteria.|
|**Certificate Issuer**|Disabled|Specifies whether Certificate Issuer filtering is enabled. <p>If both **Certificate Issuer** and **Extended Key Usage (EKU)** are enabled, only those certificates that satisfy both conditions are considered valid for authenticating the client to the server.|
|**Root Certification Authorities**|None selected|Lists the names of all of the issuers for which corresponding certification authority (CA) certificates are present in the **Trusted Root Certification Authorities** or **Intermediate Certification Authorities** certificate store of local computer account. This includes: <ul><li> All the root certification authorities and intermediate certification authorities. <li>Contains only those issuers for which there are corresponding valid certificates that are present on the computer (for example, certificates that aren't expired or not revoked). <li>The final list of certificates that are allowed for authentication contains only those certificates that were issued by any of the issuers selected in this list.</ul></li>|
|**Extended Key Usage (EKU)**|Disabled| Allows you to select **All Purpose**, **Client Authentication**, **AnyPurpose**, or any combination of these. Specifies that when a combination is selected, all the certificates satisfying at least one of the three conditions are considered valid certificates for authenticating the client to the server. If EKU filtering is enabled, one of the choices must be selected, otherwise the **OK** command control is disabled.|
|**All Purpose**|Automatically enabled if EKU is selected|When selected, this item specifies that certificates having the **All Purpose** EKU are considered valid certificates for authenticating the client to the server. The Object Identifier (OID) for **All Purpose** is `0` or empty.|
|**Client Authentication**|Automatically enabled if EKU is selected|Specifies that certificates having the **Client Authentication** EKU, and the specified list of EKUs are considered valid certificates for authenticating the client to the server. The Object Identifier (OID) for **Client Authentication** is `1.3.6.1.5.5.7.3.2`.|
|**AnyPurpose**|Automatically enabled if EKU is selected|Specifies that all certificates having **AnyPurpose** EKU and the specified list of EKUs are considered valid certificates for authenticating the client to the server. The Object Identifier (OID) for **AnyPurpose** is `1.3.6.1.4.1.311.10.12.1`.|
|**Add**|No EKUs are selected|Opens the **Select EKUs** dialog box, which enables you to add standard, custom, or vendor-specific EKUs to the **Client Authentication** or **AnyPurpose** list.<p> Selecting **Add** or **Edit** within the **Select EKUs** dialog box will open the **Add/Edit EKU** dialog box, which provides two options:<ul><li> **Enter the name of the EKU** - Provides a place to type the name of the custom EKU.<li>  **Enter the EKU OID** - Provides a place to type the OID for the EKU. Only numeric digits, separators, and "**.**" are allowed. Wild cards are permitted, in which case all of the child OIDs in the hierarchy are allowed. For example, entering `1.3.6.1.4.1.311.*` allows for `1.3.6.1.4.1.311.42` and `1.3.6.1.4.1.311.42.2.1`.|
|**Edit**|N/A|Enables you to edit custom EKUs that you have added. The default, predefined EKUs can't be edited.|
|**Remove**|N/A|Removes the selected EKU from the **Client Authentication** or **AnyPurpose** list.|

## [PEAP](#tab/peap)

|Setting|Default|Description|
|--|--|--|
|**Verify the server's identity by validating the certificate**|Enabled|This item specifies that the client verifies that server certificates presented to the client computer have the correct signatures, haven't expired, and were issued by a trusted root certification authority (CA).<p> **Disabling this check box causes client computers to be unable to verify the identity of your servers during the authentication process. If server authentication does not occur, users are exposed to severe security risks, including the possibility that users might unknowingly connect to a rogue network.**|
|**Connect to these servers** | Wired/Wireless: Disabled<p>VPN: Enabled|Allows you to specify the name for Remote Authentication Dial-In User Service (RADIUS) servers that provide network authentication and authorization.<p>You must type the name **exactly** as it appears in the **subject** field of each RADIUS server certificate or use regular expressions to specify the server name.<p> The complete syntax of the regular expression can be used to specify the server name, but to differentiate a regular expression with the literal string, you must use at least one `*` in the string specified. For example, you can specify `nps*.example.com` to specify the RADIUS server `nps1.example.com` or `nps2.example.com` but not `nps12.example.com`.<p> **If no RADIUS servers are specified, the client verifies that the RADIUS server certificate was issued by a trusted root CA.**|
|**Trusted Root Certification Authorities**|No trusted root CAs are selected |Lists the trusted root certification authorities. The list is built from the trusted root CAs that are installed in the computer and in the user certificate stores. You can specify which trusted root CA certificates supplicants use to determine whether they trust your servers, such as your server running Network Policy Server (NPS) or your provisioning server. If no trusted root CAs are selected, the 802.1X client verifies that the computer certificate of the RADIUS server was issued by an installed trusted root CA. If one or multiple trusted root CAs are selected, the 802.1X client verifies that the computer certificate of the RADIUS server was issued by a selected trusted root CA. <p> **If no trusted root CAs are selected, the client verifies that the RADIUS server certificate was issued by a trusted root CA.** <p> If you have a public key infrastructure (PKI) on your network, and you use your CA to issue certificates to your RADIUS servers, your CA certificate is automatically added to the list of trusted root CAs. You can also purchase a CA certificate from a non-Microsoft vendor. Some non-Microsoft trusted root CAs provide software with your purchased certificate that automatically installs the purchased certificate into the **Trusted Root Certification Authorities** certificate store. In this case, the trusted root CA automatically appears in the list of trusted root CAs.<p> Don't specify a trusted root CA certificate that isn't already listed in client computers’ **Trusted Root Certification Authorities** certificate stores for **Current User** and **Local Computer**. If you designate a certificate that isn't installed on client computers, authentication will fail.|
|**Notifications before connecting**|Tell user if the server’s identity can't be verified|Specifies whether the user is notified if the server name or root certificate isn't specified, or whether the server’s identity can't be verified. Here are the available options to choose from and what each specifies:<p> 1. **Do not ask user to authorize new servers or trusted CAs** - If the server name isn't in the **Connect to these servers** list, or the root certificate is found but isn't selected in the list of **Trusted Root Certification Authorities** in **PEAP Properties**, or the root certificate isn't found on the computer, then the user isn't notified and connection attempts fail.<p> 2. **Tell user if the server name or root certificate isn't specified** - If the server name isn't in the **Connect to these servers** list, or the root certificate is found but isn't selected in the list of **Trusted Root Certification Authorities** in **PEAP Properties**, then the user is prompted whether to accept the root certificate. If the user accepts the certificate, authentication proceeds. If the user rejects the certificate, the connection attempt fails. With this option, if the root certificate isn't present on the computer, the user isn't notified and connection attempts fail.<p> 3. **Tell user if the server’s identity cannot be verified** - If the server name isn't in the **Connect to these servers** list, or the root certificate is found but isn't selected in the list of **Trusted Root Certification Authorities** in **PEAP Properties**, or the root certificate isn't found on the computer, then the user is prompted whether to accept the root certificate. If the user accepts the certificate, authentication proceeds. If the user rejects the certificate, connection attempts fail. |
|**Select authentication method**|Secure password (EAP-MSCHAP v2)| Allows you to select the EAP type to use with PEAP for network authentication. There are two EAP types available, **Secure password (EAP-MSCHAP v2)** and **Smart card or other certificate (EAP-TLS)**. EAP is a flexible protocol that allows for the addition of other EAP methods and isn't limited to only these two types. |
|**Configure**|Wired/Wireless: Enabled<p>VPN: Disabled|This item provides access to property settings for the specified EAP type.<p> If **Secure password (EAP-MSCHAP v2)** is selected, the **Automatically use my Windows logon name and password (and domain if any)** checkbox is available, which specifies that the current user-based Windows sign-in name and password are used as network authentication credentials. <p> If **Smart card or other certificate (EAP-TLS)** is selected, it opens the **Smart Card or other Certificate Properties** dialog box for further configuration of this EAP type. |
|**Enable fast reconnect**|Enabled|Enables the ability to create a new or refreshed security association more efficiently and with a smaller number of round-trips if a security association was previously established. For VPN connections, **fast reconnect** uses IKEv2 technology to provide seamless and consistent VPN connectivity when users temporarily lose their Internet connections. This feature is especially useful for users who connect via wireless mobile broadband as when an Internet connection drops, **fast reconnect** will automatically re-establish active VPN connections seamlessly and transparently to users. |
|**Disconnect if server does not present cryptobinding TLV**|Disabled|Specifies that connecting clients must end the network authentication process if the RADIUS server doesn't present cryptobinding Type-Length-Value (TLV). Cryptobinding TLV is a security feature that enhances the security of the TLS tunnel in PEAP. It does this by combining the inner and outer method authentications, making it difficult for attackers to perform man-in-the-middle attacks by redirecting an MS-CHAP v2 authentication through the PEAP channel.|
|**Enable identity privacy**|Disabled| **This setting applies only to computers running Windows 8 and earlier.**<p> Specifies that clients are configured so that they can't send their identity before the client has authenticated the RADIUS server, and optionally, provides a place to type an anonymous identity value. If you select **Enable Identity Privacy** and then type `guest` as the anonymous identity value, the identity response for a user with identity `alice@example` is `guest@example`. If you select **Enable Identity Privacy** but don't provide an anonymous identity value, the identity response for the user `alice@example` is `@example`.|

## [EAP-TTLS](#tab/eap-ttls)

|Setting|Default|Description|
|--|--|--|
|**Enable identity privacy**|Enabled|Allows for different levels of privacy of the client's identity from the server during the authentication process using a generated temporary encryption key. You must type the name **exactly** as it appears in the **subject** field. The available options are:<ul><li>**anonymous** - Provides full anonymity where the client's identity is hidden from the server during the authentication process.<li>**pseudonymous** - Provides partial anonymity where the client's identity is partially hidden from the server, but some information, such as the client's domain or organization, may be visible.<li>**identified** - Provides no anonymity where the client's full identity is visible to the server during the authentication process.</ul></li>|
|**Connect to these servers**|Wired/Wireless: Disabled<p>VPN:<br>Enabled|Allows you to specify the name for Remote Authentication Dial-In User Service (RADIUS) servers that provide network authentication and authorization.<p>You must type the name **exactly** as it appears in the **subject** field of each RADIUS server certificate or use regular expressions to specify the server name.<p> The complete syntax of the regular expression can be used to specify the server name, but to differentiate a regular expression with the literal string, you must use at least one `*` in the string specified. For example, you can specify `nps*.example.com` to specify the RADIUS server `nps1.example.com` or `nps2.example.com` but not `nps12.example.com`.<p> **If no RADIUS servers are specified, the client verifies that the RADIUS server certificate was issued by a trusted root CA.**|
|**Trusted Root Certification Authorities**|No trusted root CAs are selected|Lists the trusted root certification authorities. The list is built from the trusted root CAs that are installed in the computer and in the user certificate stores. You can specify which trusted root CA certificates supplicants use to determine whether they trust your servers, such as your server running Network Policy Server (NPS) or your provisioning server. If no trusted root CAs are selected, the 802.1X client verifies that the computer certificate of the RADIUS server was issued by an installed trusted root CA. If one or multiple trusted root CAs are selected, the 802.1X client verifies that the computer certificate of the RADIUS server was issued by a selected trusted root CA. <p> **If no trusted root CAs are selected, the client verifies that the RADIUS server certificate was issued by a trusted root CA.** <p> If you have a public key infrastructure (PKI) on your network, and you use your CA to issue certificates to your RADIUS servers, your CA certificate is automatically added to the list of trusted root CAs. You can also purchase a CA certificate from a non-Microsoft vendor. Some non-Microsoft trusted root CAs provide software with your purchased certificate that automatically installs the purchased certificate into the **Trusted Root Certification Authorities** certificate store. In this case, the trusted root CA automatically appears in the list of trusted root CAs.<p> Don't specify a trusted root CA certificate that isn't already listed in client computers’ **Trusted Root Certification Authorities** certificate stores for **Current User** and **Local Computer**. If you designate a certificate that isn't installed on client computers, authentication will fail.|
|**Don't prompt user if unable to authorize server**|Disabled|Specifies, when not selected, that if server certificate validation fails due to any of the following reasons, the user is prompted to accept or reject the server:<ul><li><p> A root certificate for the server certificate isn't found or not selected in the **Trusted Root Certification Authorities** list.<li> One or more of the intermediate root certificates in the certificate chain isn't found.<li> The subject name in the server certificate doesn't match any of the servers that are specified in the **Connect to these servers** list. |
|**Select a non-EAP method for authentication**|Unencrypted password (PAP)|Specifies whether a non-EAP or an EAP type is used for authentication. If **Select a non-EAP method for authentication** is selected, then **Select an EAP method for authentication** is disabled. The following are the available authentication options:<ul><li> Unencrypted password (PAP) <li> Challenge Handshake Authentication Protocol (CHAP) <li> Microsoft CHAP (MS-CHAP) <li> Microsoft CHAP Version 2 (MS-CHAP v2)  |
|[**Automatically use my Windows logon name and password**](#automatically-use-logon)|Disabled|If enabled, this item uses Windows sign-in credentials and is only available if **MS-CHAP v2** is selected in the **Select a non-EAP method for authentication** drop-down list. **Automatically use my Windows logon name and password** is disabled for **PAP**, **CHAP**, and **MS-CHAP** authentication types.|
|**Select an EAP method for authentication**|Disabled|specifies whether an EAP type or a non-EAP type is used for authentication. If **Select an EAP method for authentication** is selected, then **Select a non-EAP method for authentication** is disabled. The following are the available authentication options:<ul><li><p> Microsoft: Smart Card or other certificate (EAP-TLS) <li> Microsoft: Secured password (EAP-MSCHAP v2)</ul></li><p> The drop-down list enumerates all the EAP methods that are installed on the server, except for **PEAP** and **FAST** tunnel methods. The EAP types are listed in the order that they're discovered by the computer.|
|**Configure**|Disabled|See <a id="automatically-use-logon" />Automatically use my Windows logon name and password.|

## [TEAP](#tab/teap)

|Setting|Default|Description|
|--|--|--|
|**Identity privacy**|Enabled|Allows for different levels of privacy of the client's identity from the server during the authentication process using a generated temporary encryption key. You must type the name **exactly** as it appears in the **subject** field. The available options are:<ul><li>**anonymous** - Provides full anonymity where the client's identity is hidden from the server during the authentication process.<li>**pseudonymous** - Provides partial anonymity where the client's identity is partially hidden from the server, but some information, such as the client's domain or organization, may be visible.<li>**identified** - Provides no anonymity where the client's full identity is visible to the server during the authentication process.</ul></li>|
|**Connect to these servers**|Wired/Wireless: Disabled<p>VPN:<br>Enabled|Allows you to specify the name for Remote Authentication Dial-In User Service (RADIUS) servers that provide network authentication and authorization.<p>You must type the name **exactly** as it appears in the **subject** field of each RADIUS server certificate or use regular expressions to specify the server name.<p> The complete syntax of the regular expression can be used to specify the server name, but to differentiate a regular expression with the literal string, you must use at least one `*` in the string specified. For example, you can specify `nps*.example.com` to specify the RADIUS server `nps1.example.com` or `nps2.example.com` but not `nps12.example.com`.<p> **If no RADIUS servers are specified, the client verifies that the RADIUS server certificate was issued by a trusted root CA.**|
|**Trusted Root Certification Authorities**|No trusted root CAs are selected|Lists the trusted root certification authorities. The list is built from the trusted root CAs that are installed in the computer and in the user certificate stores. You can specify which trusted root CA certificates supplicants use to determine whether they trust your servers, such as your server running Network Policy Server (NPS) or your provisioning server. If no trusted root CAs are selected, the 802.1X client verifies that the computer certificate of the RADIUS server was issued by an installed trusted root CA. If one or multiple trusted root CAs are selected, the 802.1X client verifies that the computer certificate of the RADIUS server was issued by a selected trusted root CA. <p> **If no trusted root CAs are selected, the client verifies that the RADIUS server certificate was issued by a trusted root CA.** <p> If you have a public key infrastructure (PKI) on your network, and you use your CA to issue certificates to your RADIUS servers, your CA certificate is automatically added to the list of trusted root CAs. You can also purchase a CA certificate from a non-Microsoft vendor. Some non-Microsoft trusted root CAs provide software with your purchased certificate that automatically installs the purchased certificate into the **Trusted Root Certification Authorities** certificate store. In this case, the trusted root CA automatically appears in the list of trusted root CAs.<p> Don't specify a trusted root CA certificate that isn't already listed in client computers’ **Trusted Root Certification Authorities** certificate stores for **Current User** and **Local Computer**. If you designate a certificate that isn't installed on client computers, authentication will fail.|
|**Don't prompt user if unable to authorize server**|Disabled|Specifies, when not selected, that if server certificate validation fails due to any of the following reasons, the user is prompted to accept or reject the server:<ul><li><p> A root certificate for the server certificate isn't found or not selected in the **Trusted Root Certification Authorities** list.<li> One or more of the intermediate root certificates in the certificate chain isn't found.<li> The subject name in the server certificate doesn't match any of the servers that are specified in the **Connect to these servers** list. |
|**Select a primary EAP method for authentication**|None|Allows the user to choose a primary authentication method between **Microsoft: Smart card or other certificate (EAP-TLS)** and **Microsoft: Secured password (EAP-MSCHAP v2)**.<p> If **EAP-TLS** is selected as the primary and **EAP-MSCHAP v2** as the secondary, Windows attempts to authenticate using EAP-TLS first.<p> If EAP-TLS fails or isn't supported by the server, Windows will then attempt to authenticate using EAP-MSCHAP v2.|
|**Configure**|Disabled|If **Microsoft: Smart card or other certificate (EAP-TLS)** is selected, it opens the **Smart Card or other Certificate Properties** dialog box.<p> If **Microsoft: Secured password (EAP-MSCHAP v2)** is selected, the **Automatically use my Windows logon name and password (and domain if any)** checkbox becomes available, which specifies that the current user-based Windows sign-in name and password are used as network authentication credentials.|
|**Select a primary EAP method for authentication**|None|Allows the user to choose a secondary authentication method between **Microsoft: Smart card or other certificate (EAP-TLS)** and **Microsoft: Secured password (EAP-MSCHAP v2**).<p> If **EAP-MSCHAP v2** is selected as the primary and **EAP-TLS** as the secondary, Windows attempts to authenticate using EAP-MSCHAP v2 first.<p> If EAP-MSCHAP v2 fails or isn't supported by the server, Windows will then attempt to authenticate using EAP-TLS.|

---

## Cellular authentication configuration settings

The following lists the configuration settings for EAP-SIM, EPA-AKA, and EPA-AKA' respectively.

## [EAP-SIM](#tab/eap-sim)

EAP-SIM is defined in [RFC 4186](https://www.rfc-editor.org/rfc/rfc4186). EAP Subscriber Identity Module (SIM) is used for authentication and session key distribution for the Global System for Mobile Communications (GSM).

| Item | Description |
|--|--|
| **Use strong Cipher keys** | Specifies that if selected, the profile uses strong encryption. |
| **Do not reveal real identity to server when pseudonym identity is available** | When enabled, forces the client to fail the authentication if server requests for permanent identity though the client have a pseudonym identity with it. Pseudonym identities are used for identity privacy so that the actual or permanent identity of a user isn't revealed during authentication. |
| **Enable usage of realms** | Provides a place to type the realm name. If this field is left blank with **Enable usage of realms** selected, the realm is derived from the International Mobile Subscriber Identity (IMSI) using the realm 3gpp.org, as described in the 3rd Generation Partnership Project (3GPP) standard 23.003 V6.8.0. |
| **Specify a realm** | Provides a place to type the realm name |

## [EAP-AKA](#tab/eap-aka1)

EAP-AKA' is defined in [RFC 4187](https://www.rfc-editor.org/rfc/rfc4187). EAP Authentication and Key Agreement (AKA) for Universal Mobile Telecommunications System (UMTS) is used for authentication and session key distribution by using the UMTS Universal Subscriber Identity Module (USIM).

| Item | Description |
|--|--|
| **Do not reveal real identity to server when pseudonym identity is available** | When enabled, forces the client to fail the authentication if server requests for permanent identity though the client have a pseudonym identity with it. Pseudonym identities are used for identity privacy so that the actual or permanent identity of a user isn't revealed during authentication. |
| **Enable usage of realms** | Provides a place to type the realm name. If this field is left blank with **Enable usage of realms** selected, the realm is derived from the International Mobile Subscriber Identity (IMSI) using the realm 3gpp.org, as described in the 3rd Generation Partnership Project (3GPP) standard 23.003 V6.8.0. |
| **Specify a realm** | Provides a place to type the realm name. |

## [EAP-AKA'](#tab/eap-aka2)

EAP-AKA' is defined in [RFC 5448](https://www.rfc-editor.org/rfc/rfc5448). EAP-AKA Prime (AKA') is a modified version of EAP-AKA that is used to enable access to the 3rd-Generation Partnership Project (3GPP)-based networks by using non-3GPP standards, such as:

- WiFi - sometimes referred to as wireless fidelity
- Evolution-Data Optimized (EVDO)
- Worldwide Interoperability for Microwave Access (WiMax)

| Item | Description |
|--|--|
| **Do not reveal real identity to server when pseudonym identity is available** | When enabled, forces the client to fail the authentication if server requests for permanent identity though the client have a pseudonym identity with it. Pseudonym identities are used for identity privacy so that the actual or permanent identity of a user isn't revealed during authentication. |
| **Enable usage of realms** | Provides a place to type the realm name. If this field is left blank with **Enable usage of realms** selected, the realm is derived from the International Mobile Subscriber Identity (IMSI) using the realm 3gpp.org, as described in the 3rd Generation Partnership Project (3GPP) standard 23.003 V6.8.0. |
| **Specify a realm** | Provides a place to type the realm name. |
| **Ignore network name mismatch** | The client compares the name of network known to it, with the name sent by the RADIUS server during authentication. If there's a mismatch, it's ignored if this option is selected. If not selected, authentication fails. |
| **Enable Fast Reauthentication** | Specifies that fast reauthentication is enabled. Fast Reauthentication is useful when SIM authentication happens frequently. The encryption keys that are derived from full authentication are reused. As a result, the SIM algorithm isn't required to run for every authentication attempt, and the number of network operations that result from frequent authentication attempts is reduced. |

---

## Additional resources

- [Managing the New Wireless Network (IEEE 802.11) Policies Settings](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh994701(v=ws.11))
- [Managing the New Wired Network (IEEE 802.3) Policies Settings](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831813(v=ws.11))
- [Advanced Security Settings for Wired and Wireless Network Policies](/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh994696(v=ws.11)).
