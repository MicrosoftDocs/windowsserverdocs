---
title: Extensible Authentication Protocol (EAP) for network access in Windows
description: This article presents information about the Extensible Authentication Protocol (EAP) settings and configuration in Windows-based computers.
author: xelu86
ms.author: wscontent
ms.topic: conceptual
ms.date: 06/19/2023
ms.contributor: samyun
ms.reviewer: samyun
---

# Extensible Authentication Protocol (EAP) for network access

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 11, Windows 10, Windows 8.1

The Extensible Authentication Protocol (EAP) is an authentication framework that allows for the use of different authentication methods for secure network access technologies. Examples of these technologies include wireless access using IEEE 802.1X, wired access using IEEE 802.1X, and Point-to-Point Protocol (PPP) connections like Virtual Private Networking (VPN). EAP isn't a specific authentication method like MS-CHAP v2, but rather a framework that enables networking vendors to develop and install new authentication methods, known as EAP methods, on the access client and authentication server. The EAP framework is originally defined by [RFC 3748](https://www.ietf.org/rfc/rfc3748.txt) and extended by various other RFCs and standards.

## Authentication methods

EAP authentication methods that are used within tunneled EAP methods are commonly known as **inner methods** or **EAP types**. Methods that are set up as **inner methods** have the same configuration settings as they would when used as an outer method. This article contains configuration information specific to the following authentication methods in EAP.

**EAP-Transport Layer Security (EAP-TLS)**: [Standards-based](https://datatracker.ietf.org/doc/html/rfc5216) EAP method that uses TLS with certificates for mutual authentication. Appears as **Smart Card or other Certificate (EAP-TLS)** in Windows. EAP-TLS can be deployed as an **inner method** for another EAP method or as a standalone EAP method.

> [!TIP]
> EAP methods that use EAP-TLS, being certificate-based, generally offer the highest level of security. For example, EAP-TLS is the only allowed EAP method for [WPA3-Enterprise 192-bit mode](#wpa3-enterprise-192-bit-mode).

**EAP-Microsoft Challenge Handshake Authentication Protocol version 2 (EAP-MSCHAP v2)**: [Microsoft-defined](/openspecs/windows_protocols/ms-chap) EAP method that encapsulates the [MSCHAP v2 authentication protocol](https://www.ietf.org/rfc/rfc2759.txt), which uses username and password, for authentication. Appears as **Secure password (EAP-MSCHAP v2)** in Windows. EAP-MSCHAPv2 can be used as a standalone method for VPN, but only as an **inner method** for wired/wireless.

> [!WARNING]
> MSCHAPv2-based connections are subject to similar attacks as for NTLMv1. Windows 11 Enterprise, version 22H2 (build 22621) enables [Windows Defender Credential Guard](/windows/security/identity-protection/credential-guard/credential-guard-considerations#wi-fi-and-vpn-considerations) which may cause issues with MSCHAPv2-based connections.

**Protected EAP (PEAP)**: [Microsoft-defined](/openspecs/windows_protocols/ms-peap) EAP method that encapsulates EAP within a TLS tunnel. The TLS tunnel secures the inner EAP method, which could be unprotected otherwise. Windows supports EAP-TLS and EAP-MSCHAP v2 as inner methods.

**EAP-Tunneled Transport Layer Security (EAP-TTLS)**: Described by [RFC 5281](https://datatracker.ietf.org/doc/html/rfc5281), encapsulates a TLS session that performs mutual authentication using another inner authentication mechanism. This inner method can be either an EAP protocol, such as EAP-MSCHAP v2, or a non-EAP protocol, such as Password Authentication Protocol (PAP). In Windows Server 2012, the inclusion of EAP-TTLS only provides support on the client-side (in Windows 8). NPS doesn't support EAP-TTLS at this time. The client support enables interoperation with commonly deployed RADIUS servers that support EAP-TTLS.

**EAP-Subscriber Identity Module (EAP-SIM), EAP-Authentication and Key Agreement (EAP-AKA), and EAP-AKA Prime (EAP-AKA')**: Described by various RFCs, enables authentication by using SIM cards, and is implemented when a customer purchases a wireless broadband service plan from a mobile network operator. As part of the plan, the customer commonly receives a wireless profile that is preconfigured for SIM authentication.

**Tunnel EAP (TEAP)**: Described by [RFC 7170](https://www.rfc-editor.org/rfc/rfc7170), tunneled EAP method that establishes a secure TLS tunnel and executes other EAP methods inside that tunnel. Supports EAP chaining - authenticating the machine and user within one authentication session. In Windows Server 2022, the inclusion of TEAP only provides support for the client-side - Windows 10, version 2004 (build 19041). NPS doesn't support TEAP at this time. The client support enables interoperation with commonly deployed RADIUS servers that support TEAP. Windows supports EAP-TLS and EAP-MSCHAP v2 as inner methods.

The following table lists some common EAP methods and their [IANA assigned method Type numbers](https://www.iana.org/assignments/eap-numbers/eap-numbers.xhtml#eap-numbers-4).

| EAP method | IANA assigned **Type** number | Native Windows support |
| --- | --- | --- |
| MD5-Challenge (EAP-MD5) | 4 | ❌ |
| One-Time Password (EAP-OTP) | 5 | ❌ |
| Generic Token Card (EAP-GTC) | 6 | ❌ |
| EAP-TLS | 13 | ✅ |
| EAP-SIM | 18 | ✅ |
| EAP-TTLS | 21 | ✅ |
| EAP-AKA | 23 | ✅ |
| PEAP | 25 | ✅ |
| EAP-MSCHAP v2 | 26 | ✅ |
| Protected One-Time Password (EAP-POTP) | 32 | ❌ |
| EAP-FAST | 43 | ❌ |
| Pre-Shared Key (EAP-PSK) | 47 | ❌ |
| EAP-IKEv2 | 49 | ❌ |
| EAP-AKA' | 50 | ✅ |
| EAP-EKE | 53 | ❌ |
| TEAP | 55 | ✅ |
| EAP-NOOB | 56 | ❌ |

## Configuring EAP properties

You can access the EAP properties for 802.1X authenticated wired and wireless access in the following ways:

- Configuring the Wired Network (IEEE 802.3) Policies and Wireless Network (IEEE 802.11) Policies extensions in Group Policy.
  - **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings**
- Using Mobile Device Management (MDM) software, such as Intune ([Wi-Fi](/mem/intune/configuration/wi-fi-settings-windows)/[Wired](/mem/intune/configuration/wired-network-settings-windows))
  - [Wi-Fi CSP](/windows/client-management/mdm/wifi-csp)
  - [WiredNetwork CSP](/windows/client-management/mdm/wirednetwork-csp)
- Manually configuring wired or wireless connections on client computers.

You can access the EAP properties for virtual private network (VPN) connections in the following ways:

- Using Mobile Device Management (MDM) software, such as [Intune](/mem/intune/configuration/vpn-settings-windows-10)
  - [VPNv2 CSP](/windows/client-management/mdm/vpnv2-csp)
  - [VPN profile options](/windows/security/operating-system-security/network-security/vpn/vpn-profile-options)
- Manually configuring VPN connections on client computers.
- Using Connection Manager Administration Kit (CMAK) to configure VPN connections.

For more information on configuring EAP properties, see [Configure EAP profiles and settings in Windows](configure-eap-profiles.md).

## XML profiles for EAP

The profiles used for different connections types are XML files that contain the configuration options for that connection. Each different connection type follows a specific schema:

- [Wi-Fi (WLAN) profiles](/windows/win32/nativewifi/wlan-profileschema-elements)
- [Wired network (Ethernet) profiles](/windows/win32/nativewifi/lan-profileschema-schema)
- [VPN profiles](/windows/client-management/mdm/vpnv2-csp#profilexml-xsd-schema)

However, when configured to use EAP, each profile schema has a child element [EapHostConfig](/windows/win32/eaphost/eaphostconfigschema-schema) element.

- Wired/Wireless: `EapHostConfig` is a child element of the [EAPConfig](/windows/win32/nativewifi/onexschema-eapconfig-onex-element) element. **MSM > security** ([Wired](/windows/win32/nativewifi/lan-profileschema-security-msm-element)/[Wireless](/windows/win32/nativewifi/wlan-profileschema-security-msm-element)) **>** [OneX](/windows/win32/nativewifi/onexschema-elements) **> EAPConfig**
- VPN: `EapHostConfig` is a child element of **NativeProfile > Authentication > Eap > Configuration**

This configuration syntax is defined in the [Group Policy: Wireless/Wired Protocol Extension](/openspecs/windows_protocols/ms-gpwl) specification.

> [!NOTE]
> The various configuration GUIs don't always show every technically possible option. For example, Windows Server 2019 and earlier are unable to configure TEAP in UI. However, it is often possible to import an existing XML profile that has previously been configured.
>
> The remainder of the article is intended to provide a mapping between the EAP specific portions of the Group Policy/Control Panel UI and the XML configuration options, as well as providing a description of the setting.

More information about configuring XML profiles can be found in [XML Profiles](configure-eap-profiles.md#xml-profiles). An example of using an XML profile containing EAP settings can be found in [Provision a Wi-Fi profile via a website](/windows/win32/nativewifi/prov-wifi-profile-via-website).

## Security settings

The following table explains the configurable security settings for a profile that uses 802.1X. These settings map to [OneX](/windows/win32/nativewifi/onexschema-schema).

|Setting|XML element|Description|
|--|--|--|
|Select a network authentication method:|[EAPConfig](/windows/win32/nativewifi/onexschema-eapconfig-onex-element)|Allows you to select the EAP method to use for authentication. See [Authentication method configuration settings](#authentication-method-configuration-settings) and [Cellular authentication configuration settings](#cellular-authentication-configuration-settings)|
|Properties||Opens the properties dialog for the selected EAP method.|
|Authentication Mode|[authMode](/windows/win32/nativewifi/onexschema-authmode-onex-element)|Specifies the type of credentials used for authentication. The following values are supported: <br><br>1. User or computer authentication<br>2. Computer authentication<br>3. User authentication<br>4. Guest authentication<br><br>"Computer", in this context, means "Machine" in other references. `machineOrUser` is the default in Windows.|
|Max Authentication Failures|[maxAuthFailures](/windows/win32/nativewifi/onexschema-maxauthfailures-onex-element)|Specifies the maximum number of authentication failures allowed for a set of credentials, defaulting to `1`.|
|Cache user information for subsequent connections to this network|[cacheUserData](/windows/win32/nativewifi/onexschema-cacheuserdata-onex-element)|Specifies whether the user's credentials should be cached for subsequent connections to the same network, defaulting to `true`.|

### Advanced security settings > IEEE 802.1X

If **Enforce advanced 802.1X settings** is checked, all of the following settings will be configured. If it's unchecked, default settings apply. In XML, all elements are optional, with the default values used if they aren't present.

|Setting|XML element|Description|
|--|--|--|
|Max Eapol-Start Msgs|[maxStart](/windows/win32/nativewifi/onexschema-maxstart-onex-element)|Specifies the maximum number of EAPOL-Start messages that can be sent to the authenticator (RADIUS server) before the supplicant (Windows client) assumes there's no authenticator present, defaulting to `3`.|
|Start Period (seconds)|[startPeriod](/windows/win32/nativewifi/onexschema-startperiod-onex-element)|Specifies the time period (in seconds) to wait before an EAPOL-Start message is sent to start the 802.1X authentication process, defaulting to `5`.|
|Held Period (seconds)|[heldPeriod](/windows/win32/nativewifi/onexschema-heldperiod-onex-element)|Specifies the time period (in seconds) to wait after a failed authentication attempt to reattempt authentication, defaulting to `1`.|
|Auth Period (seconds)|[authPeriod](/windows/win32/nativewifi/onexschema-authperiod-onex-element)|Specifies the time period (in seconds) to wait for a response from the authenticator (RADIUS server) before assuming there's no authenticator present, defaulting to `18`.|
|Eapol-Start Message|[supplicantMode](/windows/win32/nativewifi/onexschema-supplicantmode-onex-element)|Specifies the method of transmission used for EAPOL-Start messages. The following values are supported: <br><br>1. Do not transmit (`inhibitTransmission`)<br>2. Transmit (`includeLearning`)<br>3. Transmit per IEEE 802.1X (`compliant`)<br><br>"Computer", in this context, means "Machine" in other references. `compliant` is the default in Windows, and is the only valid option for wireless profiles.|

### Advanced security settings > Single Sign On

The following table explains the settings for [Single Sign On (SSO), formerly known as Pre-Logon Access Provider (PLAP)](/windows/win32/eaphost/understanding-sso-and-plap).

|Setting|XML element|Description|
|--|--|--|
|Enable Single Sign On for this network|[singleSignOn](/windows/win32/nativewifi/onexschema-singlesignon-onex-element)|Specifies whether SSO is enabled for this network, defaulting to `false`. Don't use `singleSignOn` in a profile if the network doesn't require it.|
|Perform immediately before User<br><br>Perform immediately after User|[type](/windows/win32/nativewifi/onexschema-type-singlesignon-element)|Specifies when SSO should be performed - either before or after the user logs on.|
|Max delay for connectivity(seconds)|[maxDelay](/windows/win32/nativewifi/onexschema-maxdelay-singlesignon-element)|Specifies the maximum delay (in seconds) before the SSO attempt fails, defaulting to `10`.|
|Allow additional dialogs to be displayed during Single Sign On|**allowAdditionalDialogs**|Specified whether to allow EAP dialogs to be displayed during SSO, defaulting to `false`.|
|This network uses different VLAN for authentication with machine and user credentials|[userBasedVirtualLan](/windows/win32/nativewifi/onexschema-userbasedvirtuallan-singlesignon-element)|Specifies whether the virtual LAN (VLAN) used by the device changes based on the user's credentials, defaulting to `false`.|

## Authentication method configuration settings

> [!CAUTION]
> If a Network Access Server is configured to allow the same type of authentication method for a tunneled EAP method (e.g. PEAP) and a non-tunneled EAP method (e.g. EAP-MSCHAP v2), there is a potential security vulnerability. When you deploy both a tunneled EAP method and EAP (which isn't protected), don't use the same authentication type. For example, if you deploy PEAP-TLS, don't also deploy EAP-TLS. This is because if you require the protection of the tunnel, it serves no purpose to permit the method to be executed outside of the tunnel as well.

The following table explains the configurable settings for each authentication method.

## [EAP-TLS](#tab/eap-tls)

The EAP-TLS settings in the UI map to [EapTlsConnectionPropertiesV1](/windows/win32/eaphost/eaptlsconnectionpropertiesv1schema-schema), which is extended by [EapTlsConnectionPropertiesV2](/windows/win32/eaphost/eaptlsconnectionpropertiesv2schema-schema) and [EapTlsConnectionPropertiesV3](/openspecs/windows_protocols/ms-gpwl/65562521-4153-4e20-9c4a-612e190886ee).

|Setting|XML element|Description|
|--|--|--|
|**Use my smart card**|[CredentialsSource](/windows/win32/eaphost/eaptlsconnectionpropertiesv1schema-credentialssource-eaptype-element) **>** [SmartCard](/windows/win32/eaphost/eaptlsconnectionpropertiesv1schema-smartcard-credentialssourceparameters-element)|Specifies that clients making authentication requests must present a smart card certificate for network authentication.|
|**Use a certificate on this computer**|[CredentialsSource](/windows/win32/eaphost/eaptlsconnectionpropertiesv1schema-credentialssource-eaptype-element) **>** [CertificateStore](/windows/win32/eaphost/eaptlsconnectionpropertiesv1schema-certificatestore-credentialssourceparameters-element)|Specifies that authenticating clients must use a certificate located in the Current User or Local Computer certificate stores.|
|**Use simple certificate selection (Recommended)**|[SimpleCertSelection](/windows/win32/eaphost/eaptlsconnectionpropertiesv1schema-simplecertselection-certselection-element)|Specifies whether Windows will automatically select a certificate for authentication without user interaction (if possible) or if Windows will show a dropdown for the user to select a certificate.|
|**Advanced**||Opens the [Configure Certificate Selection](#cert-filteringinfo) dialog box.|
|[Server validation options](#server-validation)||
|**Use a different user name for the connection**|[DifferentUsername](/windows/win32/eaphost/eaptlsconnectionpropertiesv1schema-differentusername-eaptype-element)|Specifies whether to use a user name for authentication that is different from the user name in the certificate.|

The following lists the configuration settings for <a id="cert-filteringinfo">**Configure Certificate Selection**</a>. These settings define the criteria a client uses to select the appropriate certificate for authentication. This UI maps to [TLSExtensions](/windows/win32/eaphost/eaptlsconnectionpropertiesv1schema-acceptservername-peapextensionstype-element) **>** [FilteringInfo](/openspecs/windows_protocols/ms-gpwl/65f4406e-8d35-4542-a5ed-4d3e7f9862a7).

|Setting|XML element|Description|
|--|--|--|
|**Certificate Issuer**|**CAHashList** `Enabled="true"`|Specifies whether Certificate Issuer filtering is enabled. <p>If both **Certificate Issuer** and **Extended Key Usage (EKU)** are enabled, only those certificates that satisfy both conditions are considered valid for authenticating the client to the server.|
|**Root Certification Authorities**|**IssuerHash**|Lists the names of all of the issuers for which corresponding certification authority (CA) certificates are present in the **Trusted Root Certification Authorities** or **Intermediate Certification Authorities** certificate store of local computer account. This includes:<p><p> 1. All the root certification authorities and intermediate certification authorities.<br> 2. Contains only those issuers for which there are corresponding valid certificates that are present on the computer (for example, certificates that aren't expired or not revoked).<br> 3. The final list of certificates that are allowed for authentication contains only those certificates that were issued by any of the issuers selected in this list.<p> In XML, this is the SHA-1 thumbprint (hash) of the certificate.|
|**Extended Key Usage (EKU)**||Allows you to select **All Purpose**, **Client Authentication**, **AnyPurpose**, or any combination of these. Specifies that when a combination is selected, all the certificates satisfying at least one of the three conditions are considered valid certificates for authenticating the client to the server. If EKU filtering is enabled, one of the choices must be selected, otherwise the **Extended Key Usage (EKU)** checkbox will get unchecked.|
|**All Purpose**|**AllPurposeEnabled**|When selected, this item specifies that certificates having the **All Purpose** EKU are considered valid certificates for authenticating the client to the server. The Object Identifier (OID) for **All Purpose** is `0` or empty.|
|**Client Authentication**|**ClientAuthEKUList** `Enabled="true"` (**> EKUMapInList > EKUName**)|Specifies that certificates having the **Client Authentication** EKU, and the specified list of EKUs are considered valid certificates for authenticating the client to the server. The Object Identifier (OID) for **Client Authentication** is `1.3.6.1.5.5.7.3.2`.|
|**AnyPurpose**|**AnyPurposeEKUList** `Enabled="true"` (**> EKUMapInList > EKUName**)|Specifies that all certificates having **AnyPurpose** EKU and the specified list of EKUs are considered valid certificates for authenticating the client to the server. The Object Identifier (OID) for **AnyPurpose** is `1.3.6.1.4.1.311.10.12.1`.|
|**Add**|**EKUMapping > EKUMap > EKUName/EKUOID**|Opens the **Select EKUs** dialog box, which enables you to add standard, custom, or vendor-specific EKUs to the **Client Authentication** or **AnyPurpose** list.<p><p> Selecting **Add** or **Edit** within the **Select EKUs** dialog box will open the **Add/Edit EKU** dialog box, which provides two options:<br> 1. **Enter the name of the EKU** - Provides a place to type the name of the custom EKU.<br> 2. **Enter the EKU OID** - Provides a place to type the OID for the EKU. Only numeric digits, separators, and `.` are allowed. Wild cards are permitted, in which case all of the child OIDs in the hierarchy are allowed. <p> For example, entering `1.3.6.1.4.1.311.*` allows for `1.3.6.1.4.1.311.42` and `1.3.6.1.4.1.311.42.2.1`.|
|**Edit**||Enables you to edit custom EKUs that you have added. The default, predefined EKUs can't be edited.|
|**Remove**||Removes the selected EKU from the **Client Authentication** or **AnyPurpose** list.|

## [PEAP](#tab/peap)

The PEAP settings in the UI map to [MsPeapConnectionPropertiesV1](/windows/win32/eaphost/mspeapconnectionpropertiesv1schema-schema), which is extended by [MsPeapConnectionPropertiesV2](/windows/win32/eaphost/mspeapconnectionpropertiesv2schema-schema).

|Setting|XML element|Description|
|--|--|--|
|[Server validation options](#server-validation)||
|**Select authentication method**||Allows you to select the EAP type to use with PEAP for network authentication. There are two EAP types available, **Secure password (EAP-MSCHAP v2)** and **Smart card or other certificate (EAP-TLS)**.|
|**Configure**|EAP-MSCHAP v2: [UseWinLogonCredentials](/windows/win32/eaphost/mschapv2connectionpropertiesv1schema-usewinlogoncredentials-eaptype-element)<p> EAP-TLS: See EAP-TLS tab, [schema](/windows/win32/eaphost/eaptlsconnectionpropertiesv1schema-schema)|This item provides access to property settings for the specified EAP type.<p> If **Secure password (EAP-MSCHAP v2)** is selected, the **Automatically use my Windows logon name and password (and domain if any)** checkbox is available, which specifies that the current user-based Windows sign-in name and password are used as network authentication credentials. <p> If **Smart card or other certificate (EAP-TLS)** is selected, it opens the **Smart Card or other Certificate Properties** dialog box for further configuration of this EAP type. |
|**Enable fast reconnect**|[FastReconnect](/windows/win32/eaphost/mspeapconnectionpropertiesv1schema-fastreconnect-eaptype-element)|Enables the ability to create a new or refreshed security association more efficiently and with a smaller number of round-trips if a security association was previously established. For VPN connections, **fast reconnect** uses IKEv2 technology to provide seamless and consistent VPN connectivity when users temporarily lose their Internet connections. This feature is especially useful for users who connect via wireless mobile broadband as when an Internet connection drops, **fast reconnect** will automatically re-establish active VPN connections seamlessly and transparently to users. |
|**Disconnect if server does not present cryptobinding TLV**|[RequireCryptoBinding](/windows/win32/eaphost/mspeapconnectionpropertiesv1schema-requirecryptobinding-eaptype-element)|Specifies that connecting clients must end the network authentication process if the RADIUS server doesn't present cryptobinding Type-Length-Value (TLV). Cryptobinding TLV is a security feature that enhances the security of the TLS tunnel in PEAP. It does this by combining the inner and outer method authentications, making it difficult for attackers to perform man-in-the-middle attacks by redirecting an MS-CHAP v2 authentication through the PEAP channel.|
|**Enable identity privacy**|[IdentityPrivacy](/windows/win32/eaphost/mspeapconnectionpropertiesv2-identityprivacy-peapextensionstype-element) **>** [EnableIdentityPrivacy](/windows/win32/eaphost/mspeapconnectionpropertiesv2-enableidentityprivacy-identityprivacyparameters-element)/[AnonymousUserName](/windows/win32/eaphost/mspeapconnectionpropertiesv2-anonymoususername-identityprivacyparameters-element)|Specifies that clients are configured so that they can't send their identity before the client has authenticated the RADIUS server, and optionally, provides a place to type an anonymous identity value. If you select **Enable identity privacy** and then type `anonymous` as the anonymous identity value, the identity response for a user with identity `alice@example` is `anonymous@example`. If you select **Enable identity privacy** but don't provide an anonymous identity value, the identity response for the user `alice@example` is `@example`.|

## [EAP-TTLS](#tab/eap-ttls)

The EAP-TTLS settings in the UI map to [EapTtlsConnectionPropertiesV1](/openspecs/windows_protocols/ms-gpwl/723ffda5-9bef-40cc-81dc-3ede33fd90b2).

|Setting|XML element|Description|
|--|--|--|
|**Enable identity privacy**|**Phase1Identity** ><br> **IdentityPrivacy** ><br> **AnonymousIdentity**|Specifies that clients are configured so that they can't send their identity before the client has authenticated the RADIUS server, and optionally, provides a place to type an anonymous identity value. If you select **Enable identity privacy** and then type `anonymous` as the anonymous identity value, the identity response for a user with identity `alice@example` is `anonymous@example`. If you select **Enable identity privacy** but don't provide an anonymous identity value, the identity response for the user `alice@example` is `@example`.|
|[Server validation options](#server-validation)||
|**Select a non-EAP method for authentication**|**Phase2Authentication** > <br><br>_Any of the following_:<br> **PAPAuthentication**<br>**CHAPAuthentication**<br>**MSCHAPAuthentication**<br>**MSCHAPv2Authentication**|Specifies whether a non-EAP or an EAP type is used for authentication. If **Select a non-EAP method for authentication** is selected, then **Select an EAP method for authentication** is disabled. The following are the available authentication options:<p><p> 1. Unencrypted password (PAP) <br> 2. Challenge Handshake Authentication Protocol (CHAP) <br> 3. Microsoft CHAP (MS-CHAP) <br> 4. Microsoft CHAP Version 2 (MS-CHAP v2). |
|**Automatically use my Windows logon name and password**|**UseWinlogonCredentials**|If enabled, this item uses Windows sign-in credentials and is only available if **MS-CHAP v2** is selected in the **Select a non-EAP method for authentication** drop-down list. **Automatically use my Windows logon name and password** is disabled for **PAP**, **CHAP**, and **MS-CHAP** authentication types.|
|**Select an EAP method for authentication**|**Phase2Authentication** ><br> **EapHostConfig**|Specifies whether an EAP type or a non-EAP type is used for authentication. If **Select an EAP method for authentication** is selected, then **Select a non-EAP method for authentication** is disabled. The following are the available authentication options:<p><p> 1. Microsoft: Smart Card or other certificate (EAP-TLS) <br> 2. Microsoft: Secured password (EAP-MSCHAP v2)<p> The drop-down list enumerates all the EAP methods that are installed on the server, except for **PEAP** and **FAST** tunnel methods. The EAP types are listed in the order that they're discovered by the computer.|
|**Configure**||Opens the properties dialog box of the specified EAP method.|

## [TEAP](#tab/teap)

The TEAP settings in the UI map to [EapTeapConnectionPropertiesV1](/openspecs/windows_protocols/ms-gpwl/94cf6896-c28e-4865-b12a-d83ee38cd3ea). TEAP is available starting in Windows 10, version 2004 (build 19041) and Windows Server 2022.

|Setting|XML element|Description|
|--|--|--|
|**Identity privacy**|**Phase1Identity > IdentityPrivacy > AnonymousIdentity**|Specifies that clients are configured so that they can't send their identity before the client has authenticated the RADIUS server, and optionally, provides a place to type an anonymous identity value. If you select **Enable identity privacy** and then type `anonymous` as the anonymous identity value, the identity response for a user with identity `alice@example` is `anonymous@example`. If you select **Enable identity privacy** but don't provide an anonymous identity value, the identity response for the user `alice@example` is `@example`.|
|[Server validation options](#server-validation)||
|**Select a {primary/secondary} EAP method for authentication**|**Phase2Authentication (> InnerMethodConfig > EapHostConfig)**|Allows the user to choose a primary/secondary authentication method between **Microsoft: Smart card or other certificate (EAP-TLS)** and **Microsoft: Secured password (EAP-MSCHAP v2)**.<p> It's allowed to have any combination of inner methods. For example, the inner method could be EAP-TLS with machine credentials, followed by EAP-TLS with user credentials.|
|**Configure**||If **Microsoft: Smart card or other certificate (EAP-TLS)** is selected, it opens the **Smart Card or other Certificate Properties** dialog box.<p> If **Microsoft: Secured password (EAP-MSCHAP v2)** is selected, the **Automatically use my Windows logon name and password (and domain if any)** checkbox becomes available, which specifies that the current user-based Windows sign-in name and password are used as network authentication credentials.|

---

### Server validation

Many EAP methods include an option for the client to validate the server's certificate. If the server certificate isn't validated, the client can't be sure that it's communicating with the correct server. This exposes the client to security risks, including the possibility that the client might unknowingly connect to a rogue network.

> [!NOTE]
> Windows requires the server certificate have the **Server Authentication** EKU. The object identifier (OID) for this EKU is `1.3.6.1.5.5.7.3.1`.

The following table lists the server validation options applicable to each EAP method. Windows 11 updated the server validation logic to be more consistent (see [Updated server certificate validation behavior in Windows 11](windows-11-changes.md#updated-server-certificate-validation-behavior-in-windows-11)). Should they conflict, the descriptions in the following table describe the behavior for Windows 10 and earlier.

|Setting|XML element|Description|
|--|--|--|
|**Verify the server's identity by validating the certificate**|EAP-TLS:<br>[PerformServerValidation](/windows/win32/eaphost/eaptlsconnectionpropertiesv1schema-performservervalidation-peapextensionstype-element)<br><br>PEAP:<br>[PerformServerValidation](/windows/win32/eaphost/mspeapconnectionpropertiesv1schema-performservervalidation-peapextensionstype-element)|This item specifies that the client verifies that server certificates presented to the client computer have the correct signatures, haven't expired, and were issued by a trusted root certification authority (CA).<p> **Disabling this check box causes client computers to be unable to verify the identity of your servers during the authentication process. If server authentication does not occur, users are exposed to severe security risks, including the possibility that users might unknowingly connect to a rogue network.**|
|**Connect to these servers**|EAP-TLS:<br>[ServerValidation](/windows/win32/eaphost/eaptlsconnectionpropertiesv1schema-servervalidation-eaptype-element) **>** [ServerNames](/windows/win32/eaphost/eaptlsconnectionpropertiesv1schema-servernames-servervalidationparameters-element)<br><br>PEAP:<br>[ServerValidation](/windows/win32/eaphost/mspeapconnectionpropertiesv1schema-servervalidation-eaptype-element) **>** [ServerNames](/windows/win32/eaphost/mspeapconnectionpropertiesv1schema-servernames-servervalidationparameters-element)<br><br>EAP-TTLS:<br>**ServerValidation** ><br>**ServerNames**<br><br>TEAP:<br>**ServerValidation** ><br>**ServerNames**<br>|Allows you to specify the name for Remote Authentication Dial-In User Service (RADIUS) servers that provide network authentication and authorization.<p> You must type the name **exactly** as it appears in the **subject** field of each RADIUS server certificate or use regular expressions (regex) to specify the server name.<p> The complete syntax of the regular expression can be used to specify the server name, but to differentiate a regular expression with the literal string, you must use at least one `*` in the string specified. For example, you can specify `nps.*\.example\.com` to specify the RADIUS server `nps1.example.com` or `nps2.example.com`.<p> You can also include a `;` to separate multiple servers.<p> **If no RADIUS servers are specified, the client only verifies that the RADIUS server certificate was issued by a trusted root CA.**|
|**Trusted Root Certification Authorities**|EAP-TLS:<br>[ServerValidation](/windows/win32/eaphost/eaptlsconnectionpropertiesv1schema-servervalidation-eaptype-element) **>** [TrustedRootCA](/windows/win32/eaphost/eaptlsconnectionpropertiesv1schema-trustedrootca-servervalidationparameters-element)<br><br>PEAP:<br>[ServerValidation](/windows/win32/eaphost/mspeapconnectionpropertiesv1schema-servervalidation-eaptype-element) **>** [TrustedRootCA](/windows/win32/eaphost/mspeapconnectionpropertiesv1schema-trustedrootca-servervalidationparameters-element)<br><br>EAP-TTLS:<br>**ServerValidation** ><br> **TrustedRootCAHashes**<br><br>TEAP:<br>**ServerValidation** ><br> **TrustedRootCAHashes**|Lists the trusted root certification authorities. The list is built from the trusted root CAs that are installed in the computer and in the user certificate stores. You can specify which trusted root CA certificates supplicants use to determine whether they trust your servers, such as your server running Network Policy Server (NPS) or your provisioning server. If no trusted root CAs are selected, the 802.1X client verifies that the computer certificate of the RADIUS server was issued by an installed trusted root CA. If one or multiple trusted root CAs are selected, the 802.1X client verifies that the computer certificate of the RADIUS server was issued by a selected trusted root CA. <p> **If no trusted root CAs are selected, the client verifies that the RADIUS server certificate was issued by any trusted root CA.** <p> If you have a public key infrastructure (PKI) on your network, and you use your CA to issue certificates to your RADIUS servers, your CA certificate is automatically added to the list of trusted root CAs. You can also purchase a CA certificate from a non-Microsoft vendor. Some non-Microsoft trusted root CAs provide software with your purchased certificate that automatically installs the purchased certificate into the **Trusted Root Certification Authorities** certificate store. In this case, the trusted root CA automatically appears in the list of trusted root CAs.<p> Don't specify a trusted root CA certificate that isn't already listed in client computers' **Trusted Root Certification Authorities** certificate stores for **Current User** and **Local Computer**. If you designate a certificate that isn't installed on client computers, authentication will fail.<p> In XML, this is the SHA-1 thumbprint (hash) of the certificate (or SHA-256 for TEAP).|

### Server validation user prompt

The following table lists the server validation user prompt options applicable to each EAP method. These options would be used, in the case of an untrusted server certificate, to either:

- immediately fail the connection, or
- allow the user to manually accept or reject the connection.

### [EAP-TLS](#tab/serveruserprompt-eap-tls)

|Setting|XML element|
|--|--|
|**Don't prompt user to authorize new servers or trusted certification authorities**|[ServerValidation](/windows/win32/eaphost/eaptlsconnectionpropertiesv1schema-servervalidation-eaptype-element) **>** [DisableUserPromptForServerValidation](/windows/win32/eaphost/eaptlsconnectionpropertiesv1schema-disableuserpromptforservervalidation-servervalidationparameters-element)|

Prevents the user from being prompted to trust a server certificate if that certificate is incorrectly configured, isn't already trusted, or both (if enabled). To simplify the user experience and prevent users from mistakenly trusting a server deployed by an attacker, it's recommended that you select this checkbox.

### [PEAP](#tab/serveruserprompt-peap)

|Setting|XML element|
|--|--|
|**Notifications before connecting**|[ServerValidation](/windows/win32/eaphost/mspeapconnectionpropertiesv1schema-servervalidation-eaptype-element) **>**<p> 1. [DisableUserPromptForServerValidation](/windows/win32/eaphost/mspeapconnectionpropertiesv1schema-disableuserpromptforservervalidation-servervalidationparameters-element)=`true`<p> 2. **DisableUserPromptForServerValidation**=`false`<p> 3. **DisableUserPromptForServerValidation**=`false`, [PeapExtensionsV2](/windows/win32/eaphost/mspeapconnectionpropertiesv1-peapextensionsv2-peapextensionstype-element) **> AllowPromptingWhenServerCANotFound**|

Specifies whether the user is notified if the server name or root certificate isn't specified, or whether the server's identity can't be verified. Here are the available options to choose from and what each specifies:

1. **Don't ask user to authorize new servers or trusted CAs** - If the server name isn't in the **Connect to these servers** list, or the root certificate is found but isn't selected in the list of **Trusted Root Certification Authorities** in **PEAP Properties**, or the root certificate isn't found on the computer, then the user isn't notified and connection attempts fail.
1. **Tell user if the server name or root certificate isn't specified** - If the server name isn't in the **Connect to these servers** list, or the root certificate is found but isn't selected in the list of **Trusted Root Certification Authorities** in **PEAP Properties**, then the user is prompted whether to accept the root certificate. If the user accepts the certificate, authentication proceeds. If the user rejects the certificate, the connection attempt fails. With this option, if the root certificate isn't present on the computer, the user isn't notified and the connection attempt fails.
1. **Tell user if the server's identity cannot be verified** - If the server name isn't in the **Connect to these servers** list, or the root certificate is found but isn't selected in the list of **Trusted Root Certification Authorities** in **PEAP Properties**, or the root certificate isn't found on the computer, then the user is prompted whether to accept the root certificate. If the user accepts the certificate, authentication proceeds. If the user rejects the certificate, the connection attempt fails.

### [EAP-TTLS](#tab/serveruserprompt-ttls)

|Setting|XML element|
|--|--|
|**Don't prompt user if unable to authorize server**|**ServerValidation** ><br> **DisableUserPromptForServerValidation**|

Specifies, when not selected, that if server certificate validation fails due to any of the following reasons, the user is prompted to accept or reject the server:

- A root certificate for the server certificate isn't found or not selected in the **Trusted Root Certification Authorities** list.
- One or more of the intermediate root certificates in the certificate chain isn't found.
- The subject name in the server certificate doesn't match any of the servers that are specified in the **Connect to these servers** list.

### [TEAP](#tab/serveruserprompt-teap)

|Setting|XML element|
|--|--|
|**Don't prompt user if unable to authorize server**|**ServerValidation** > **DisablePrompt**|

Specifies, when not selected, that if server certificate validation fails due to any of the following reasons, the user is prompted to accept or reject the server:

- A root certificate for the server certificate isn't found or not selected in the **Trusted Root Certification Authorities** list.
- One or more of the intermediate root certificates in the certificate chain isn't found.
- The subject name in the server certificate doesn't match any of the servers that are specified in the **Connect to these servers** list.

---

## Cellular authentication configuration settings

The following lists the configuration settings for EAP-SIM, EPA-AKA, and EPA-AKA' respectively.

## [EAP-SIM](#tab/eap-sim)

EAP-SIM is defined in [RFC 4186](https://www.rfc-editor.org/rfc/rfc4186). EAP Subscriber Identity Module (SIM) is used for authentication and session key distribution using the 2nd generation mobile network Global System for Mobile Communications (GSM) Subscriber Identity Module (SIM).

The EAP-SIM settings in the UI map to [EapSimConnectionPropertiesV1](/openspecs/windows_protocols/ms-gpwl/e5838db5-8b54-43fa-8a53-5fbc43cf80d0).

| Item | XML element | Description |
|--|--|--|
| **Use strong cipher keys** | **UseStrongCipherKeys** | Specifies that if selected, the profile uses strong encryption. |
| **Don't reveal real identity to server when pseudonym identity is available** | **DontRevealPermanentID** | When enabled, forces the client to fail the authentication if server requests for permanent identity though the client have a pseudonym identity with it. Pseudonym identities are used for identity privacy so that the actual or permanent identity of a user isn't revealed during authentication. |
| | **ProviderName** | Only available in XML, a string that indicates the provider name that is allowed for authentication. |
| **Enable usage of realms** | **Realm**=`true` | Provides a place to type the realm name. If this field is left blank with **Enable usage of realms** selected, the realm is derived from the International Mobile Subscriber Identity (IMSI) using the realm 3gpp.org, as described in the 3rd Generation Partnership Project (3GPP) standard 23.003 V6.8.0. |
| **Specify a realm** | **Realm** | Provides a place to type a realm name. If **Enable usage of realms** is enabled, this string is used. If this field is empty, the derived realm is used. |

## [EAP-AKA](#tab/eap-aka)

EAP-AKA is defined in [RFC 4187](https://www.rfc-editor.org/rfc/rfc4187). EAP Authentication and Key Agreement (AKA) is used for authentication and session key distribution by using the AKA mechanism. AKA is used in the 3rd generation mobile networks Universal Mobile Telecommunications System (UMTS) and CDMA2000. AKA is based on symmetric keys and typically runs in a Subscriber Identity Module (SIM).

The EAP-AKA settings in the UI map to [EapAkaConnectionPropertiesV1](/openspecs/windows_protocols/ms-gpwl/c12544ae-6c0a-4587-8912-688514ad3002).

| Item | XML element | Description |
|--|--|--|
| **Don't reveal real identity to server when pseudonym identity is available** | **DontRevealPermanentID** | When enabled, forces the client to fail the authentication if server requests for permanent identity though the client have a pseudonym identity with it. Pseudonym identities are used for identity privacy so that the actual or permanent identity of a user isn't revealed during authentication. |
| | **ProviderName** | Only available in XML, a string that indicates the provider name that is allowed for authentication. |
| **Enable usage of realms** | **Realm**=`true` | Provides a place to type the realm name. If this field is left blank with **Enable usage of realms** selected, the realm is derived from the International Mobile Subscriber Identity (IMSI) using the realm 3gpp.org, as described in the 3rd Generation Partnership Project (3GPP) standard 23.003 V6.8.0. |
| **Specify a realm** | **Realm** | Provides a place to type a realm name. If **Enable usage of realms** is enabled, this string is used. If this field is empty, the derived realm is used. |

## [EAP-AKA'](#tab/eap-aka-prime)

EAP-AKA' is defined in [RFC 5448](https://www.rfc-editor.org/rfc/rfc5448) and [RFC 9048](https://www.rfc-editor.org/rfc/rfc9048). EAP-AKA Prime (AKA') is a modified version of EAP-AKA that adds a new key derivation function to facilitate access to the 3rd-Generation Partnership Project (3GPP)-based networks by using non-3GPP standards, such as:

- Wi-Fi
- Evolution-Data Optimized (EVDO)
- Worldwide Interoperability for Microwave Access (WiMax)

The EAP-AKA' settings in the UI map to [EapAkaPrimeConnectionPropertiesV1](/openspecs/windows_protocols/ms-gpwl/f0f56906-2776-43df-a9b6-f506d1f20dc5).

| Item | XML element | Description |
|--|--|--|
| **Don't reveal real identity to server when pseudonym identity is available** | **DontRevealPermanentID** | When enabled, forces the client to fail the authentication if server requests for permanent identity though the client have a pseudonym identity with it. Pseudonym identities are used for identity privacy so that the actual or permanent identity of a user isn't revealed during authentication. |
| | **ProviderName** | Only available in XML, a string that indicates the provider name that is allowed for authentication. |
| **Enable usage of realms** | **Realm**=`true` | Provides a place to type the realm name. If this field is left blank with **Enable usage of realms** selected, the realm is derived from the International Mobile Subscriber Identity (IMSI) using the realm 3gpp.org, as described in the 3rd Generation Partnership Project (3GPP) standard 23.003 V6.8.0. |
| **Specify a realm** | **Realm** | Provides a place to type a realm name. If **Enable usage of realms** is enabled, this string is used. If this field is empty, the derived realm is used. |
| **Ignore network name mismatch** | **IgnoreNetworkNameMismatch** | The client compares the name of network known to it, with the name sent by the RADIUS server during authentication. If there's a mismatch, it's ignored if this option is selected. If not selected, authentication fails. |
| **Enable Fast Reauthentication** | **EnableFastReauth** | Specifies that fast reauthentication is enabled. Fast Reauthentication is useful when SIM authentication happens frequently. The encryption keys that are derived from full authentication are reused. As a result, the SIM algorithm isn't required to run for every authentication attempt, and the number of network operations that result from frequent authentication attempts is reduced. |

---

## WPA3-Enterprise 192-bit mode

WPA3-Enterprise 192-bit mode is a special mode for WPA3-Enterprise that enforces certain high security requirements on the wireless connection to provide a minimum of 192 bits of security. These requirements align with the [Commercial National Security Algorithm (CNSA) Suite, CNSSP 15](https://www.cnss.gov/CNSS/issuances/Policies.cfm), which is a set of cryptographic algorithms that is approved to protect classified and top secret information by the United States National Security Agency (NSA). 192-bit mode can sometimes be referred to as "Suite B mode," which is a reference to the NSA Suite B Cryptography specification, which was replaced by CNSA in 2016.

Both WPA3-Enterprise and WPA3-Enterprise 192-bit mode are available starting in Windows 10, version 2004 (build 19041) and Windows Server 2022. However, WPA3-Enterprise was singled out as a separate authentication algorithm in Windows 11. In XML, this is specified in the [authEncryption](/windows/win32/nativewifi/wlan-profileschema-authencryption-security-element) element.

The following table lists the algorithms required by the CNSA Suite.

| Algorithm | Description | Parameters |
| --- | --- | --- |
| Advanced Encryption Standard (AES) | Symmetric block cipher used for encryption | 256-bit key (AES-256) |
| Elliptic Curve Diffie-Hellman (ECDH) Key Exchange | Asymmetric algorithm used to establish a shared secret (key) | 384-bit prime modulus curve (P-384) |
| Elliptic Curve Digital Signature Algorithm (ECDSA) | Asymmetric algorithm used for digital signatures | 384-bit prime modulus curve (P-384) |
| Secure Hash Algorithm (SHA) | Cryptographic hash function | SHA-384 |
| Diffie-Hellman (DH) Key Exchange | Asymmetric algorithm used to establish a shared secret (key) | 3072-bit modulus |
| Rivest-Shamir-Adleman (RSA) | Asymmetric algorithm used for digital signatures or key-establishment | 3072-bit modulus |

Aligning with CNSA, WPA3-Enterprise 192-bit mode requires that EAP-TLS is used with the following cipher suites with restrictions:

- `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384`
  - ECDHE and ECDSA using the 384-bit prime modulus curve P-384
- `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384` / `TLS_DHE_RSA_AES_256_GCM_SHA384`
  - ECDHE using the 384-bit prime modulus curve P-384
  - RSA >= 3072-bit modulus

> [!NOTE]
> P-384 is also known as `secp384r1` or `nistp384`. Other elliptic curves, such as P-521 are not permitted.
>
> SHA-384 is in the SHA-2 family of hash functions. Other algorithms and variants, such as SHA-512 or SHA3-384, are not permitted.

Windows supports only the `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384` and `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384` cipher suites for WPA3-Enterprise 192-bit mode. The `TLS_DHE_RSA_AES_256_GCM_SHA384` cipher suite isn't supported.

TLS 1.3 uses new simplified TLS suites, of which only `TLS_AES_256_GCM_SHA384` is compatible with WPA3-Enterprise 192-bit mode. As TLS 1.3 requires (EC)DHE and allows ECDSA or RSA certificates, along with the AES-256 AEAD and SHA384 hash, `TLS_AES_256_GCM_SHA384` is equivalent to `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384` and `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384`. However, [RFC 8446](https://www.rfc-editor.org/rfc/rfc8446) requires that TLS 1.3-compliant applications support P-256, which is forbidden by CNSA. Therefore, WPA3-Enterprise 192-bit mode can't be fully compliant with TLS 1.3. However, there are no known interoperability issues with TLS 1.3 and WPA3-Enterprise 192-bit mode.

To configure a network for WPA3-Enterprise 192-bit mode, Windows requires EAP-TLS be used with a certificate that meets the requirements described previously.

## Additional resources

- [Managing the New Wireless Network (IEEE 802.11) Policies Settings](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh994701(v=ws.11))
- [Managing the New Wired Network (IEEE 802.3) Policies Settings](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831813(v=ws.11))
- [Advanced Security Settings for Wired and Wireless Network Policies](/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh994696(v=ws.11))
