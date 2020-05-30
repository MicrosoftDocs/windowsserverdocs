---
title: Deploy Password-Based 802.1X Authenticated Wireless Access
description: This topic is part of the Windows Server 2016 Networking guide "Deploy Password-Based 802.1X Authenticated Wireless Access"
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: ff06ba23-9c0f-49ec-8f7b-611cf8d73a1b
ms.author: lizross
author: eross-msft
---

# Deploy Password\-Based 802.1X Authenticated Wireless Access

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This is a companion guide to the Windows Server&reg; 2016 Core Network Guide. The Core Network Guide provides instructions for planning and deploying the components required for a fully functioning network and a new Active Directory® domain in a new forest.

This guide explains how to build upon a core network by providing instructions about how to deploy Institute of Electrical and Electronics Engineers \(IEEE\) 802.1X\-authenticated IEEE 802.11 wireless access using Protected Extensible Authentication Protocol – Microsoft Challenge Handshake Authentication Protocol version 2 \(PEAP\-MS\-CHAP v2\).

Because PEAP\-MS\-CHAP v2 requires that users provide password\-based credentials rather than a certificate during the authentication process, it is typically easier and less expensive to deploy than EAP\-TLS or PEAP\-TLS.

>[!NOTE]
>In this guide, IEEE 802.1X Authenticated Wireless Access with PEAP\-MS\-CHAP v2 is abbreviated to “wireless access” and “WiFi access.”

## About this guide
This guide, in combination with the prerequisite guides described below, provides instructions about how to deploy the following WiFi access infrastructure.  

- One or more 802.1X\-capable 802.11 wireless access points \(APs\).

- Active Directory Domain Services \(AD DS\) Users and Computers.

- Group Policy Management.

- One or more Network Policy Server \(NPS\) servers.

- Server certificates for computers running NPS.

- Wireless client computers running Windows&reg; 10, Windows 8.1, or Windows 8.

### Dependencies for this guide

To successfully deploy authenticated wireless with this guide, you must have a network and domain environment with all of the required technologies deployed. You must also have server certificates deployed to your authenticating NPSs.

The following sections provide links to documentation that shows you how to deploy these technologies.

#### Network and domain environment dependencies

This guide is designed for network and system administrators who have followed the instructions in the Windows Server 2016 **Core Network Guide** to deploy a core network, or for those who have previously deployed the core technologies included in the core network, including AD DS, Domain Name System \(DNS\), Dynamic Host Configuration Protocol \(DHCP\), TCP\/IP, NPS, and Windows Internet Name Service \(WINS\).  

The Core Network Guide is available at the following locations:

- The Windows Server 2016 [Core Network Guide](https://technet.microsoft.com/windows-server-docs/networking/core-network-guide/core-network-guide) is available in the Windows Server 2016 Technical Library. 

- The [Core Network Guide](https://gallery.technet.microsoft.com/Core-Network-Guide-for-9da2e683) is also available in Word format at TechNet Gallery, at [https://gallery.technet.microsoft.com/Core-Network-Guide-for-9da2e683](https://gallery.technet.microsoft.com/Core-Network-Guide-for-9da2e683).

#### Server certificate dependencies
There are two available options for enrolling authentication servers with server certificates for use with 802.1X authentication - deploy your own public key infrastructure by using Active Directory Certificate Services \(AD CS\) or use server certificates that are enrolled by a public certification authority \(CA\).

##### AD CS
Network and system administrators deploying authenticated wireless must follow the instructions in the Windows Server 2016 Core Network Companion Guide, **Deploy Server Certificates for 802.1X Wired and Wireless Deployments**. This guide explains how to deploy and use AD CS to autoenroll server certificates to computers running NPS.

This guide is available at the following location.

- The Windows Server 2016 Core Network Companion Guide [Deploy Server Certificates for 802.1X Wired and Wireless Deployments](https://technet.microsoft.com/windows-server-docs/networking/core-network-guide/cncg/server-certs/deploy-server-certificates-for-802.1x-wired-and-wireless-deployments?f=255&MSPPError=-2147217396) in HTML format in the Technical Library. 

##### Public CA
You can purchase server certificates from a public CA, such as VeriSign, that client computers already trust. 

A client computer trusts a CA when the CA certificate is installed in the Trusted Root Certification Authorities certificate store. By default, computers running Windows have multiple public CA certificates installed in their Trusted Root Certification Authorities certificate store.  

It is recommended that you review the design and deployment guides for each of the technologies that are used in this deployment scenario. These guides can help you determine whether this deployment scenario provides the services and configuration that you need for your organization's network.

### Requirements
Following are the requirements for deploying a wireless access infrastructure by using the scenario documented in this guide:

- Before deploying this scenario, you must first purchase 802.1X\-capable wireless access points to provide wireless coverage in the desired locations at your site. The planning section of this guide assists in determining the features your APs must support.

- Active Directory Domain Services \(AD DS\) is installed, as are the other required network technologies, according to the instructions in the Windows Server 2016 Core Network Guide.  

- AD CS is deployed, and server certificates are enrolled to NPSs. These certificates are required when you deploy the PEAP\-MS\-CHAP v2 certificate\-based authentication method that is used in this guide.

- A member of your organization is familiar with the IEEE 802.11 standards that are supported by your wireless APs and the wireless network adapters that are installed in the client computers and devices on your network. For example, someone in your organization is familiar with radio frequency types, 802.11 wireless authentication \(WPA2 or WPA\), and ciphers \(AES or TKIP\).

## What this guide does not provide  
Following are some items this guide does not provide:

### Comprehensive guidance for selecting 802.1X\-capable wireless access points

Because many differences exist between brands and models of 802.1X\-capable wireless APs, this guide does not provide detailed information about:  

- Determining which brand or model of wireless AP is best suited to your needs.

- The physical deployment of wireless APs on your network.

- Advanced wireless AP configuration, such as for wireless virtual Local Area Networks \(VLANs\).

- Instructions on how to configure wireless AP vendor\-specific attributes in NPS.

Additionally, terminology and names for settings vary between wireless AP brands and models, and might not match the generic setting names that are used in this guide. For wireless AP configuration details, you must review the product documentation provided by the manufacturer of your wireless APs.

### Instructions for deploying NPS certificates
  
There are two alternatives for deploying NPS certificates. This guide does not provide comprehensive guidance to help you determine which alternative will best meet your needs. In general, however, the choices you face are:

- Purchasing certificates from a public CA, such as VeriSign, that are already trusted by Windows\-based clients. This option is typically recommended for smaller networks.

- Deploying a Public Key Infrastructure \(PKI\) on your network by using AD CS. This is recommended for most networks, and the instructions for how to deploy server certificates with AD CS are available in the previously mentioned deployment guide.

### NPS network policies and other NPS settings

Except for the configuration settings made when you run the **Configure 802.1X** wizard, as documented in this guide, this guide does not provide detailed information for manually configuring NPS conditions, constraints or other NPS settings.

### DHCP

This deployment guide does not provide information about designing or deploying DHCP subnets for wireless LANs.

## Technology overviews
Following are technology overviews for deploying wireless access:

### IEEE 802.1X
The IEEE 802.1X standard defines the port\-based network access control that is used to provide authenticated network access to Ethernet networks. This port\-based network access control uses the physical characteristics of the switched LAN infrastructure to authenticate devices attached to a LAN port. Access to the port can be denied if the authentication process fails. Although this standard was designed for wired Ethernet networks, it has been adapted for use on 802.11 wireless LANs.

### 802.1X\-capable wireless access points \(APs\)
This scenario requires the deployment of one or more 802.1X\-capable wireless APs that are compatible with the Remote Authentication Dial\-In User Service \(RADIUS\) protocol.

802.1X and RADIUS\-compliant APs, when deployed in a RADIUS infrastructure with a RADIUS server such as an NPS, are called *RADIUS clients*.

### Wireless clients
This guide provides comprehensive configuration details to supply 802.1X authenticated access for domain\-member users who connect to the network with wireless client computers running Windows 10, Windows 8.1, and Windows 8. Computers must be joined to the domain in order to successfully establish authenticated access.

>[!NOTE]
>You can also use computers that are running Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012 as wireless clients.

### Support for IEEE 802.11 Standards
Supported Windows and Windows Server operating systems provide built\-in support for 802.11 wireless networking. In these operating systems, an installed 802.11 wireless network adapter appears as a wireless network connection in Network and Sharing Center. 

Although there is built\-in support for 802.11 wireless networking, the wireless components of Windows are dependent upon the following:

- The capabilities of the wireless network adapter. The installed wireless network adapter must support the wireless LAN or wireless security standards that you require. For example, if the wireless network adapter does not support Wi\-Fi Protected Access \(WPA\), you cannot enable or configure WPA security options.

- The capabilities of the wireless network adapter driver. To allow you to configure wireless network options, the driver for the wireless network adapter must support the reporting of all of its capabilities to Windows. Verify that the driver for your wireless network adapter is written for the capabilities of your operating system. Also ensure that the driver is the most current version by checking Microsoft Update or the Web site of the wireless network adapter vendor.

The following table shows the transmission rates and frequencies for common IEEE 802.11 wireless standards.

|Standards|Frequencies|Bit Transmission Rates|Usage|
|-------------|---------------|--------------------------|---------|  
|802.11|S\-Band Industrial, Scientific, and Medical \(ISM\) frequency range \(2.4 to 2.5 GHz\)|2 megabits per second \(Mbps\)|Obsolete. Not commonly used.|  
|802.11b|S\-Band ISM|11 Mbps|Commonly used.|  
|802.11a|C\-Band ISM \(5.725 to 5.875 GHz\)|54 Mbps|Not commonly used due to expense and limited range.|  
|802.11g|S\-Band ISM|54 Mbps|Widely used. 802.11g devices are compatible with 802.11b devices.|  
|802.11n \2.4 and 5.0 GHz|C\-Band and S\-Band ISM|250 Mbps|Devices based on the pre\-ratification IEEE 802.11n standard became available in August 2007. Many 802.11n devices are compatible with 802.11a, b, and g devices.|
|802.11ac |5 GHz |6.93 Gbps |802.11ac, approved by the IEEE in 2014, is more scalable and faster than 802.11n, and is deployed where APs and wireless clients both support it.|

### Wireless network security methods
**Wireless network security methods** is an informal grouping of wireless authentication \(sometimes referred to as wireless security\) and wireless security encryption. Wireless authentication and encryption are used in pairs to prevent unauthorized users from accessing the wireless network, and to protect wireless transmissions. 

When configuring wireless security settings in the Wireless Network Policies of Group Policy, there are multiple combinations to choose from. However, only the WPA2\-Enterprise, WPA\-Enterprise, and Open with 802.1X authentication standards are supported for 802.1X Authenticated wireless deployments.

>[!NOTE]
>While configuring Wireless Network Policies, you must select **WPA2\-Enterprise**, **WPA\-Enterprise**, or **Open with 802.1X** in order to gain access to the EAP settings that are required for 802.1X authenticated wireless deployments.  

#### Wireless authentication
This guide recommends the use of the following wireless authentication standards for 802.1X authenticated wireless deployments.  

**Wi\-Fi Protected Access – Enterprise \(WPA\-Enterprise\)** WPA is an interim standard developed by the WiFi Alliance to comply with the 802.11 wireless security protocol. The WPA protocol was developed in response to a number of severe flaws that were discovered in the preceding Wired Equivalent Privacy \(WEP\) protocol.

WPA\-Enterprise provides improved security over WEP by:  

1. Requiring authentication that uses the 802.1X EAP framework as part of the infrastructure that ensures centralized mutual authentication and dynamic key management  

2. Enhancing the Integrity Check Value \(ICV\) with a Message Integrity Check \(MIC\), to protect the header and payload  

3. Implementing a frame counter to discourage replay attacks  

**Wi\-Fi Protected Access 2 – Enterprise \(WPA2\-Enterprise\)** Like the WPA\-Enterprise standard, WPA2\-Enterprise uses the 802.1X and EAP framework. WPA2\-Enterprise provides stronger data protection for multiple users and large managed networks. WPA2\-Enterprise is a robust protocol that is designed to prevent unauthorized network access by verifying network users through an authentication server.  

#### Wireless security encryption
Wireless security encryption is used to protect the wireless transmissions that are sent between the wireless client and the wireless AP. Wireless security encryption is used in conjunction with the selected network security authentication method. By default, computers running Windows 10, Windows 8.1, and Windows 8 support two encryption standards:

1. **Temporal Key Integrity Protocol** \(TKIP\) is an older encryption protocol that was originally designed to provide more secure wireless encryption than what was provided by the inherently weak Wired Equivalent Privacy \(WEP\) protocol. TKIP was designed by the IEEE 802.11i task group and the Wi\-Fi Alliance to replace WEP without requiring the replacement of legacy hardware. TKIP is a suite of algorithms that encapsulates the WEP payload, and allows users of legacy WiFi equipment to upgrade to TKIP without replacing hardware. Like WEP, TKIP uses the RC4 stream encryption algorithm as its basis. The new protocol, however, encrypts each data packet with a unique encryption key, and the keys are much stronger than those by WEP. Although TKIP is useful for upgrading security on older devices that were designed to use only WEP, it does not address all of the security issues facing wireless LANs, and in most cases is not sufficiently robust to protect sensitive government or corporate data transmissions.  

2. **Advanced Encryption Standard** \(AES\) is the preferred encryption protocol for the encryption of commercial and government data. AES offers a higher level of wireless transmission security than either TKIP or WEP. Unlike TKIP and WEP, AES requires wireless hardware that supports the AES standard. AES is a symmetric\-key encryption standard that uses three block ciphers, AES\-128, AES\-192 and AES\-256.

In Windows Server 2016, the following AES\-based wireless encryption methods are available for configuration in wireless profile properties when you select an authentication method of WPA2\-Enterprise, which is recommended.

1. **AES\-CCMP**. Counter Mode Cipher Block Chaining Message Authentication Code Protocol \(CCMP\) implements the 802.11i standard and is designed for higher security encryption than that provided by WEP, and uses 128 bit AES encryption keys.
2. **AES\-GCMP**. Galois Counter Mode Protocol \(GCMP\) is supported by 802.11ac, is more efficient than AES\-CCMP and provides better performance for wireless clients. GCMP uses 256 bit AES encryption keys.

> [!IMPORTANT]
> Wired Equivalency Privacy \(WEP\) was the original wireless security standard that was used to encrypt network traffic. You should not deploy WEP on your network because there are well\-known vulnerabilities in this outdated form of security.

### Active Directory Doman Services \(AD DS\)
AD DS provides a distributed database that stores and manages information about network resources and application\-specific data from directory\-enabled applications. Administrators can use AD DS to organize elements of a network, such as users, computers, and other devices, into a hierarchical containment structure. The hierarchical containment structure includes the Active Directory forest, domains in the forest, and organizational units \(OUs\) in each domain. A server that is running AD DS is called a *domain controller*.  

AD DS contains the user accounts, computer accounts, and account properties that are required by IEEE 802.1X and PEAP\-MS\-CHAP v2 to authenticate user credentials and to evaluate authorization for wireless connections.

### Active Directory Users and Computers
Active Directory Users and Computers is a component of AD DS that contains accounts that represent physical entities, such as a computer, a person, or a security group. A *security group* is a collection of user or computer accounts that administrators can manage as a single unit. User and computer accounts that belong to a particular group are referred to as *group members*.  

### Group Policy Management
Group Policy Management enables directory\-based change and configuration management of user and computer settings, including security and user information. You use Group Policy to define configurations for groups of users and computers. With Group Policy, you can specify settings for registry entries, security, software installation, scripts, folder redirection, remote installation services, and Internet Explorer maintenance. The Group Policy settings that you create are contained in a Group Policy object \(GPO\). By associating a GPO with selected Active Directory system containers — sites, domains, and OUs — you can apply the GPO's settings to the users and computers in those Active Directory containers. To manage Group Policy objects across an enterprise, you can use the Group Policy Management Editor Microsoft Management Console \(MMC\).  

This guide provides detailed instructions about how to specify settings in the Wireless Network \(IEEE 802.11\) Policies extension of Group Policy Management. The Wireless Network \(IEEE 802.11\) Policies configure domain\-member wireless client computers with the necessary connectivity and wireless settings for 802.1X authenticated wireless access.

### Server certificates
This deployment scenario requires server certificates for each NPS that performs 802.1X authentication.  

A server certificate is a digital document that is commonly used for authentication and to secure information on open networks. A certificate securely binds a public key to the entity that holds the corresponding private key. Certificates are digitally signed by the issuing CA, and they can be issued for a user, a computer, or a service.  

A certification authority \(CA\) is an entity responsible for establishing and vouching for the authenticity of public keys belonging to subjects \(usually users or computers\) or other CAs. Activities of a certification authority can include binding public keys to distinguished names through signed certificates, managing certificate serial numbers, and revoking certificates.  

Active Directory Certificate Services \(AD CS\) is a server role that issues certificates as a network CA. An AD CS certificate infrastructure, also known as a *public key infrastructure \(PKI\)*, provides customizable services for issuing and managing certificates for the enterprise.

### EAP, PEAP, and PEAP\-MS\-CHAP v2
Extensible Authentication Protocol \(EAP\) extends Point\-to\-Point Protocol \(PPP\) by allowing additional authentication methods that use credential and information exchanges of arbitrary lengths. With EAP authentication, both the network access client and the authenticator \(such as the NPS\) must support the same EAP type for successful authentication to occur. Windows Server 2016 includes an EAP infrastructure, supports two EAP types, and the ability to pass EAP messages to NPSs. By using EAP, you can support additional authentication schemes, known as *EAP types*. The EAP types that are supported by Windows Server 2016 are:  

- Transport Layer Security \(TLS\)

- Microsoft Challenge Handshake Authentication Protocol version 2 \(MS\-CHAP v2\)

>[!IMPORTANT]
>Strong EAP types \(such as those that are based on certificates\) offer better security against brute\-force attacks, dictionary attacks, and password guessing attacks than password\-based authentication protocols \(such as CHAP or MS\-CHAP version 1\).

Protected EAP \(PEAP\) uses TLS to create an encrypted channel between an authenticating PEAP client, such as a wireless computer, and a PEAP authenticator, such as an NPS or other RADIUS servers. PEAP does not specify an authentication method, but it provides additional security for other EAP authentication protocols \(such as EAP\-MS\-CHAP v2\) that can operate through the TLS encrypted channel provided by PEAP. PEAP is used as an authentication method for access clients that are connecting to your organization's network through the following types of network access servers \(NASs\):

- 802.1X\-capable wireless access points

- 802.1X\-capable authenticating switches

- Computers running Windows Server 2016 and the Remote Access Service \(RAS\) that are configured as virtual private network \(VPN\) servers, DirectAccess Servers, or both

- Computers running Windows Server 2016 and Remote Desktop Services

PEAP\-MS\-CHAP v2 is easier to deploy than EAP\-TLS because user authentication is performed by using password\-based credentials \(user name and password\), instead of certificates or smart cards. Only NPS or other RADIUS servers are required to have a certificate. The NPS certificate is used by the NPS during the authentication process to prove its identity to PEAP clients.

This guide provides instructions to configure your wireless clients and your NPS\(s\) to use PEAP\-MS\-CHAP v2 for 802.1X authenticated access.

### Network Policy Server
Network Policy Server \(NPS\) allows you to centrally configure and manage network policies by using Remote Authentication Dial\-In User Service \(RADIUS\) server and RADIUS proxy. NPS is  required when you deploy 802.1X wireless access.

When you configure your 802.1X wireless access points as RADIUS clients in NPS, NPS processes the connection requests sent by the APs. During connection request processing, NPS performs authentication and authorization. Authentication determines whether the client has presented valid credentials. If NPS successfully authenticates the requesting client, then NPS determines whether the client is authorized to make the requested connection, and either allows or denies the connection. This is explained in more detail as follows:

#### Authentication

Successful mutual PEAP\-MS\-CHAP v2 authentication has two main parts:

1.  The client authenticates the NPS.  During this phase of mutual authentication, the NPS sends its server certificate to the client computer so that the client can verify the NPS's identity with the certificate. To successfully authenticate the NPS, the client computer must trust the CA that issued the NPS certificate. The client trusts this CA when the CA's certificate is present in the Trusted Root Certification Authorities certificate store on the client computer.

    If you deploy your own private CA, the CA certificate is automatically installed in the Trusted Root Certification Authorities certificate store for the Current User and for the Local Computer when Group Policy is refreshed on the domain member client computer. If you decide to deploy server certificates from a public CA, ensure that the public CA certificate is already in the Trusted Root Certification Authorities certificate store.  

2.  The NPS authenticates the user. After the client successfully authenticates the NPS, the client sends the user's password\-based credentials to the NPS, which verifies the user's credentials against the user accounts database in Active Directory Doman Services \(AD DS\).

If the credentials are valid and authentication succeeds, the NPS begins the authorization phase of processing the connection request. If the credentials are not valid and authentication fails, NPS sends an Access Reject message and the connection request is denied.  

#### Authorization

The server running NPS performs authorization as follows:  

1. NPS checks for restrictions in the user or computer account dial\-in properties in AD DS. Every user and computer account in Active Directory Users and Computers includes multiple properties, including those found on the **Dial\-in** tab. On this tab, in **Network Access Permission**, if the value is **Allow access**, the user or computer is authorized to connect to the network. If the value is **Deny access**, the user or computer is not authorized to connect to the network. If the value is **Control access through NPS Network Policy**, NPS evaluates the configured network policies to determine whether the user or computer is authorized to connect to the network. 

2. NPS then processes its network policies to find a policy that matches the connection request. If a matching policy is found, NPS either grants or denies the connection based on that policy's configuration.  

If both authentication and authorization are successful, and if the matching network policy grants access, NPS grants access to the network, and the user and computer can connect to network resources for which they have permissions.  

>[!NOTE]
>To deploy wireless access, you must configure NPS policies. This guide provides instructions to use the **Configure 802.1X wizard** in NPS to create NPS policies for 802.1X authenticated wireless access.  

### Bootstrap profiles
In 802.1X\-authenticated wireless networks, wireless clients must provide security credentials that are authenticated by a RADIUS server in order to connect to the network. For Protected EAP \[PEAP\]\-Microsoft Challenge Handshake Authentication Protocol version 2 \[MS\-CHAP v2\], the security credentials are a user name and password. For EAP\-Transport Layer Security \[TLS\] or PEAP\-TLS, the security credentials are certificates, such as client user and computer certificates or smart cards.

When connecting to a network that is configured to perform PEAP\-MS\-CHAP v2, PEAP\-TLS, or EAP\-TLS authentication, by default, Windows wireless clients must also validate a computer certificate that is sent by the RADIUS server. The computer certificate that is sent by the RADIUS server for every authentication session is commonly referred to as a server certificate.

As mentioned previously, you can issue your RADIUS servers their server certificate in one of two ways: from a commercial CA \(such as VeriSign, Inc.,\), or from a private CA that you deploy on your network. If the RADIUS server sends a computer certificate that was issued by a commercial CA that already has a root certificate installed in the client's Trusted Root Certification Authorities certificate store, then the wireless client can validate the RADIUS server's computer certificate, regardless of whether the wireless client has joined the Active Directory domain. In this case the wireless client can connect to the wireless network, and then you can join the computer to the domain.

>[!NOTE]
>The behavior requiring the client to validate the server certificate can be disabled, but disabling server certificate validation is not recommended in production environments.

Wireless bootstrap profiles are temporary profiles that are configured in such a way as to enable wireless client users to connect to the 802.1X\-authenticated wireless network before the computer is joined to the domain, and\/or before the user has successfully logged on to the domain by using a given wireless computer for the first time.  This section summarizes what problem is encountered when trying to join a wireless computer to the domain, or for a user to use a domain\-joined wireless computer for the first time to log on to the domain.

For deployments in which the user or IT administrator cannot physically connect a computer to the wired Ethernet network to join the computer to the domain, and the computer does not have the necessary issuing root CA certificate installed in its **Trusted Root Certification Authorities** certificate store, you can configure wireless clients with a temporary wireless connection profile, called a *bootstrap profile*, to connect to the wireless network.

A *bootstrap profile* removes the requirement to validate the RADIUS server's computer certificate. This temporary configuration enables the wireless user to join the computer to the domain, at which time the Wireless Network \(IEEE 802.11\) Policies are applied and the appropriate root CA certificate is automatically installed on the computer.

When Group Policy is applied, one or more wireless connection profiles that enforce the requirement for mutual authentication are applied on the computer; the bootstrap profile is no longer required and is removed. After joining the computer to the domain and restarting the computer, the user can use a wireless connection to log on to the domain.

For an overview of the wireless access deployment process using these technologies, see [Wireless Access Deployment Overview](b-wireless-access-deploy-overview.md).
