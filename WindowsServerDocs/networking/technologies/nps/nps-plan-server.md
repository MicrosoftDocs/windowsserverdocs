---
title: Plan NPS as a RADIUS server
description: This topic provides information about Network Policy Server RADIUS server deployment planning in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 2900dd2c-0f70-4f8d-9650-ed83d51d509a
ms.author: lizross 
author: eross-msft
---

# Plan NPS as a RADIUS server

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

When you deploy Network Policy Server \(NPS\) as a Remote Authentication Dial-In User Service (RADIUS) server, NPS performs authentication, authorization, and accounting for connection requests for the local domain and for domains that trust the local domain. You can use these planning guidelines to simplify your RADIUS deployment.

These planning guidelines do not include circumstances in which you want to deploy NPS as a RADIUS proxy. When you deploy NPS as a RADIUS proxy, NPS forwards connection requests to a server running NPS or other RADIUS servers in remote domains, untrusted domains, or both. 

Before you deploy NPS as a RADIUS server on your network, use the following guidelines to plan your deployment.

- Plan NPS configuration.

- Plan RADIUS clients.

- Plan the use of authentication methods.

- Plan network policies.

- Plan NPS accounting.

## Plan NPS configuration

You must decide in which domain the NPS is a member. For multiple-domain environments, an NPS can authenticate credentials for user accounts in the domain of which it is a member and for all domains that trust the local domain of the NPS. To allow the NPS to read the dial-in properties of user accounts during the authorization process, you must add the computer account of the NPS to the RAS and NPSs group for each domain.

After you have determined the domain membership of the NPS, the server must be configured to communicate with RADIUS clients, also called network access servers, by using the RADIUS protocol. In addition, you can configure the types of events that NPS records in the event log and you can enter a description for the server.

### Key steps

During the planning for NPS configuration, you can use the following steps.

- Determine the RADIUS ports that the NPS uses to receive RADIUS messages from RADIUS clients. The default ports are UDP ports 1812 and 1645 for RADIUS authentication messages and ports 1813 and 1646 for RADIUS accounting messages.

- If the NPS is configured with multiple network adapters, determine the adapters over which you want RADIUS traffic to be allowed.

- Determine the types of events that you want NPS to record in the Event Log. You can log rejected authentication requests, successful authentication requests, or both types of requests.

- Determine whether you are deploying more than one NPS. To provide fault tolerance for RADIUS-based authentication and accounting, use at least two NPSs. One NPS is used as the primary RADIUS server and the other is used as a backup. Each RADIUS client is then configured on both NPSs. If the primary NPS becomes unavailable, RADIUS clients then send Access-Request messages to the alternate NPS.

- Plan the script used to copy one NPS configuration to other NPSs to save on administrative overhead and to prevent the incorrect cofiguration of a server. NPS provides the Netsh commands that allow you to copy all or part of an NPS configuration for import onto another NPS. You can run the commands manually at the Netsh prompt. However, if you save your command sequence as a script, you can run the script at a later date if you decide to change your server configurations.

## Plan RADIUS clients

RADIUS clients are network access servers, such as wireless access points, virtual private network (VPN) servers, 802.1X-capable switches, and dial-up servers. RADIUS proxies, which forward connection request messages to RADIUS servers, are also RADIUS clients. NPS supports all network access servers and RADIUS proxies that comply with the RADIUS protocol as described in RFC 2865, "Remote Authentication Dial-in User Service (RADIUS)," and RFC 2866, "RADIUS Accounting."

>[!IMPORTANT]
>Access clients, such as client computers, are not RADIUS clients. Only network access servers and proxy servers that support the RADIUS protocol are RADIUS clients.

In addition, both wireless access points and switches must be capable of 802.1X authentication. If you want to deploy Extensible Authentication Protocol \(EAP\) or Protected Extensible Authentication Protocol \(PEAP\), access points and switches must support the use of EAP.

To test basic interoperability for PPP connections for wireless access points, configure the access point and the access client to use Password Authentication Protocol (PAP). Use additional PPP-based authentication protocols, such as PEAP, until you have tested the ones that you intend to use for network access.

### Key steps

During the planning for RADIUS clients, you can use the following steps.

- Document the vendor-specific attributes (VSAs) you must configure in NPS. If your network access servers require VSAs, log the VSA information for later use when you configure your network policies in NPS. 

- Document the IP addresses of RADIUS clients and your NPS to simplify the configuration of all devices. When you deploy your RADIUS clients, you must configure them to use the RADIUS protocol, with the NPS IP address entered as the authenticating server. And when you configure NPS to communicate with your RADIUS clients, you must enter the RADIUS client IP addresses into the NPS snap-in.

- Create shared secrets for configuration on the RADIUS clients and in the NPS snap-in. You must configure RADIUS clients with a shared secret, or password, that you will also enter into the NPS snap-in while configuring RADIUS clients in NPS.

## Plan the use of authentication methods

NPS supports both password-based and certificate-based authentication methods. However, not all network access servers support the same authentication methods. In some cases, you might want to deploy a different authentication method based on the type of network access.

For example, you might want to deploy both wireless and VPN access for your organization, but use a different authentication method for each type of access: EAP-TLS for VPN connections, due to the strong security that EAP with Transport Layer Security (EAP-TLS) provides, and PEAP-MS-CHAP v2 for 802.1X wireless connections.

PEAP with Microsoft Challenge Handshake Authentication Protocol version 2 (PEAP-MS-CHAP v2) provides a feature named fast reconnect that is specifically designed for use with portable computers and other wireless devices. Fast reconnect enables wireless clients to move between wireless access points on the same network without being reauthenticated each time they associate with a new access point. This provides a better experience for wireless users and allows them to move between access points without having to retype their credentials.
Because of fast reconnect and the security that PEAP-MS-CHAP v2 provides, PEAP-MS-CHAP v2 is a logical choice as an authentication method for wireless connections.

For VPN connections, EAP-TLS is a certificate-based authentication method that provides strong security that protects network traffic even as it is transmitted across the Internet from home or mobile computers to your organization VPN servers.

### Certificate-based authentication methods

Certificate-based authentication methods have the advantage of providing strong security; and they have the disadvantage of being more difficult to deploy than password-based authentication methods.

Both PEAP-MS-CHAP v2 and EAP-TLS are certificate-based authentication methods, but there are many differences between them and the way in which they are deployed.

### EAP-TLS

EAP-TLS uses certificates for both client and server authentication, and requires that you deploy a public key infrastructure (PKI) in your organization. Deploying a PKI can be complex, and requires a planning phase that is independent of planning for the use of NPS as a RADIUS server.

With EAP-TLS, the NPS enrolls a server certificate from a certification authority \(CA\), and the certificate is saved on the local computer in the certificate store. During the authentication process, server authentication occurs when the NPS sends its server certificate to the access client to prove its identity to the access client. The access client examines various certificate properties to determine whether the certificate is valid and is appropriate for use during server authentication. If the server certificate meets the minimum server certificate requirements and is issued by a CA that the access client trusts, the NPS is successfully authenticated by the client.

Similarly, client authentication occurs during the authentication process when the client sends its client certificate to the NPS to prove its identity to the NPS. The NPS examines the certificate, and if the client certificate meets the minimum client certificate requirements and is issued by a CA that the NPS trusts, the access client is successfully authenticated by the NPS.

Although it is required that the server certificate is stored in the certificate store on the NPS, the client or user certificate can be stored in either the certificate store on the client or on a smart card.

For this authentication process to succeed, it is required that all computers have your organization's CA certificate in the Trusted Root Certification Authorities certificate store for the Local Computer and the Current User.

### PEAP-MS-CHAP v2

PEAP-MS-CHAP v2 uses a certificate for server authentication and password-based credentials for user authentication. Because certificates are used only for server authentication, you are not required to deploy a PKI in order to use PEAP-MS-CHAP v2. When you deploy PEAP-MS-CHAP v2, you can obtain a server certificate for the NPS in one of the following two ways:

- You can install Active Directory Certificate Services (AD CS), and then autoenroll certificates to NPSs. If you use this method, you must also enroll the CA certificate to client computers connecting to your network so that they trust the certificate issued to the NPS.

- You can purchase a server certificate from a public CA such as VeriSign. If you use this method, make sure that you select a CA that is already trusted by client computers. To determine whether client computers trust a CA, open the Certificates Microsoft Management Console (MMC) snap-in on a client computer, and then view the Trusted Root Certification Authorities store for the Local Computer and for the Current User. If there is a certificate from the CA in these certificate stores, the client computer trusts the CA and will therefore trust any certificate issued by the CA.

During the authentication process with PEAP-MS-CHAP v2, server authentication occurs when the NPS sends its server certificate to the client computer. The access client examines various certificate properties to determine whether the certificate is valid and is appropriate for use during server authentication. If the server certificate meets the minimum server certificate requirements and is issued by a CA that the access client trusts, the NPS is successfully authenticated by the client.

User authentication occurs when a user attempting to connect to the network types password-based credentials and tries to log on. NPS receives the credentials and performs authentication and authorization. If the user is authenticated and authorized successfully, and if the client computer successfully authenticated the NPS, the connection request is granted.

### Key steps

During the planning for the use of authentication methods, you can use the following steps.

- Identify the types of network access you plan to offer, such as wireless, VPN, 802.1X-capable switch, and dial-up access.

- Determine the authentication method or methods that you want to use for each type of access. It is recommended that you use the certificate-based authentication methods that provide strong security; however, it might not be practical for you to deploy a PKI, so other authentication methods might provide a better balance of what you need for your network.

- If you are deploying EAP-TLS, plan your PKI deployment. This includes planning the certificate templates you are going to use for server certificates and client computer certificates. It also includes determining how to enroll certificates to domain member and non-domain member computers, and determining whether you want to use smart cards.

- If you are deploying PEAP-MS-CHAP v2, determine whether you want to install AD CS to issue server certificates to your NPSs or whether you want to purchase server certificates from a public CA, such as VeriSign.

### Plan network policies

Network policies are used by NPS to determine whether connection requests received from RADIUS clients are authorized. NPS also uses the dial-in properties of the user account to make an authorization determination.

Because network policies are processed in the order in which they appear in the NPS snap-in, plan to place your most restrictive policies first in the list of policies. For each connection request, NPS attempts to match the conditions of the policy with the connection request properties. NPS examines each network policy in order until it finds a match. If it does not find a match, the connection request is rejected.

### Key steps

During the planning for network policies, you can use the following steps.

- Determine the preferred NPS processing order of network policies, from most restrictive to least restrictive.

- Determine the policy state. The policy state can have the value of enabled or disabled. If the policy is enabled, NPS evaluates the policy while performing authorization. If the policy is not enabled, it is not evaluated.

- Determine the policy type. You must determine whether the policy is designed to grant access when the conditions of the policy are matched by the connection request or whether the policy is designed to deny access when the conditions of the policy are matched by the connection request. For example, if you want to explicitly deny wireless access to the members of a Windows group, you can create a network policy that specifies the group, the wireless connection method, and that has a policy type setting of Deny access.

- Determine whether you want NPS to ignore the dial-in properties of user accounts that are members of the group on which the policy is based. When this setting is not enabled, the dial-in properties of user accounts override settings that are configured in network policies. For example, if a network policy is configured that grants access to a user but the dial-in properties of the user account for that user are set to deny access, the user is denied access. But if you enable the policy type setting Ignore user account dial-in properties, the same user is granted access to the network.

- Determine whether the policy uses the policy source setting. This setting allows you to easily specify a source for all access requests. Possible sources are a Terminal Services Gateway (TS Gateway), a remote access server (VPN or dial-up), a DHCP server, a wireless access point, and a Health Registration Authority server. Alternatively, you can specify a vendor-specific source.

- Determine the conditions that must be matched in order for the network policy to be applied.

- Determine the settings that are applied if the conditions of the network policy are matched by the connection request.

- Determine whether you want to use, modify, or delete the default network policies.

## Plan NPS accounting

NPS provides the ability to log RADIUS accounting data, such as user authentication and accounting requests, in three formats: IAS format, database-compatible format, and Microsoft SQL Server logging. 

IAS format and database-compatible format create log files on the local NPS in text file format. 

SQL Server logging provides the ability to log to a SQL Server 2000 or SQL Server 2005 XML-compliant database, extending RADIUS accounting to leverage the advantages of logging to a relational database.

### Key steps

During the planning for NPS accounting, you can use the following steps.

- Determine whether you want to store NPS accounting data in log files or in a SQL Server database.

### NPS accounting using local log files

Recording user authentication and accounting requests in log files is used primarily for connection analysis and billing purposes, and is also useful as a security investigation tool, providing you with a method for tracking the activity of a malicious user after an attack.

### Key steps

During the planning for NPS accounting using local log files, you can use the following steps.

- Determine the text file format that you want to use for your NPS log files.

- Choose the type of information that you want to log. You can log accounting requests, authentication requests, and periodic status.

- Determine the hard disk location where you want to store your log files.

- Design your log file backup solution. The hard disk location where you store your log files should be a location that allows you to easily back up your data. In addition, the hard disk location should be protected by configuring the access control list (ACL) for the folder where the log files are stored.

- Determine the frequency at which you want new log files to be created. If you want log files to be created based on the file size, determine the maximum file size allowed before a new log file is created by NPS.

- Determine whether you want NPS to delete older log files if the hard disk runs out of storage space.

- Determine the application or applications that you want to use to view accounting data and produce reports.

### NPS SQL Server logging

NPS SQL Server logging is used when you need session state information, for report creation and data analysis purposes, and to centralize and simplify management of your accounting data.

NPS provides the ability to use SQL Server logging to record user authentication and accounting requests received from one or more network access servers to a data source on a computer running the Microsoft SQL Server Desktop Engine \(MSDE 2000\), or any version of SQL Server later than SQL Server 2000.

Accounting data is passed from NPS in XML format to a stored procedure in the database, which supports both structured query language \(SQL\) and XML \(SQLXML\). Recording user authentication and accounting requests in an XML-compliant SQL Server database enables multiple NPSs to have one data source.

### Key steps

During the planning for NPS accounting by using NPS SQL Server logging, you can use the following steps.

- Determine whether you or another member of your organization has SQL Server 2000 or SQL Server 2005 relational database development experience and you understand how to use these products to create, modify, administer, and manage SQL Server databases.

- Determine whether SQL Server is installed on the NPS or on a remote computer.

- Design the stored procedure that you will use in your SQL Server database to process incoming XML files that contain NPS accounting data.

- Design the SQL Server database replication structure and flow.

- Determine the application or applications that you want to use to view accounting data and produce reports.

- Plan to use network access servers that send the Class attribute in all accounting-requests. The Class attribute is sent to the RADIUS client in an Access-Accept message, and is useful for correlating Accounting-Request messages with authentication sessions. If the Class attribute is sent by the network access server in the accounting request messages, it can be used to match the accounting and authentication records. The combination of the attributes Unique-Serial-Number, Service-Reboot-Time, and Server-Address must be a unique identification for each authentication that the server accepts.

- Plan to use network access servers that support interim accounting.

- Plan to use network access servers that send Accounting-on and Accounting-off messages.

- Plan to use network access servers that support the storing and forwarding of accounting data. Network access servers that support this feature can store accounting data when the network access server cannot communicate with the NPS. When the NPS is available, the network access server forwards the stored records to the NPS, providing increased reliability in accounting over network access servers that do not provide this feature.

- Plan to always configure the Acct-Interim-Interval attribute in network policies. The Acct-Interim-Interval attribute sets the interval (in seconds) between each interim update that the network access server sends. According to RFC 2869, the value of the Acct-Interim-Interval attribute must not be smaller than 60 seconds, or one minute, and should not be smaller than 600 seconds, or 10 minutes. For more information, see RFC 2869, "RADIUS Extensions."

- Ensure that logging of periodic status is enabled on your NPSs.

