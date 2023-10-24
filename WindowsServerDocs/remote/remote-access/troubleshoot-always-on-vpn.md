---
title: Troubleshoot Always On VPN
description: This article provides instructions for verifying and troubleshooting Always On VPN deployment in Windows Server 2016.
ms.topic: article
ms.assetid: 4d08164e-3cc8-44e5-a319-9671e1ac294a
ms.date: 08/18/2023
ms.author: inhenkel
author: Teresa-MOTIV
---
# Troubleshoot Always On VPN

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10

If your Always On Virtual Private Network (VPN) setup isn't connecting clients to your internal network, you may have encountered one of the following issues:

- The VPN certificate is invalid
- The Network Policy Server (NPS) policies are incorrect
- Issues with client deployment scripts or Routing and Remote Access

The first step in troubleshooting and testing your VPN connection is understanding the core components of the Always On VPN infrastructure.

You can troubleshoot connection issues in several ways. For client-side issues and general troubleshooting, the application logs on client computers are invaluable. For authentication-specific issues, the NPS log located on the NPS server can help you determine the source of the problem.

## General troubleshooting for Always On VPN connection issues

Always On VPN clients go through several steps before establishing a connection. As a result, there are several places where connections can be blocked, and sometimes it's difficult to figure out where the issue is.

If you're encountering issues, here are some general steps you can take to figure out what's going on:

- Run a **whatismyip** scan to make sure your template machine isn't externally connected. If the machine has a public IP address that doesn't belong to you, then you should change the IP to a private one.

- Go to **Control Panel** > **Network** and **Internet** > **Network Connections**, open the properties for your VPN Profile, and check to make sure the value in the **General** tab can publicly resolve through DNS. If not, the Remote Access server or VPN server being unable to resolve to an IP address is likely the cause of the issue.

- Open the Internet Control Message Protocol (ICMP) to the external interface and ping the VPN server from the remote client. If the ping succeeds, you can remove the ICMP allow rule. If not, then your VPN server being inaccessible is probably causing the issue.

- Check the configuration for the internal and external NICs on your VPN server. In particular, make sure they're on the same subnet and that the external NIC connects to the correct interface on your firewall.

- Check the client firewall, server firewall, and any hardware firewalls to make sure they allow UDP 500 and 4500 port activity through. Also, if you're using UDP port 500, make sure IPSEC isn't disabled or blocked anywhere. If not, the ports not being open from the client to the VPN server external interface is causing the issue.

- Make sure the NPS server has a Server Authentication certificate that can service IKE requests. Also, make sure your NPS client has the correct VPN server IP in its settings. You should only authenticate with PEAP and the PEAP properties should only allow certificate authentication. You can check for authentication issues in the NPS event log. For more information, see [Install and Configure the NPS Server](/windows-server/networking/technologies/nps/nps-manage-install).

- If you can connect but don't have internet or local network access, check your DHCP or VPN server IP pools for configuration issues. Also, make sure your clients can reach those resources. You can use the VPN server to route requests.

## General troubleshooting for VPN_Profile.ps1 script issues

The most common issues when manually running the VPN_Profile.ps1 script include:

- If you use a remote connection tool, make sure you don't use Remote Desktop Protocol (RDP) or other remote connection methods. Remote connections can interfere with the service's ability to detect you when you sign in.

- If the affected user is an administrator on their local machine, make sure they have administrator privileges while running the script.

- If you've enabled other PowerShell security features, make sure your PowerShell execution policy isn't blocking the script. Disable Constrained Language mode before running the script, then reactivate it after the script is finished running.

## Logs

You can also check the application logs and NPS logs for events that can indicate when and where an issue is happening.

### Application logs

The application logs on client machines record higher-level details of VPN connection events.

When you're troubleshooting Always On VPN, look for events labeled *RasClient*. All error messages return the error code at the end of the message. [Error codes](#error-codes) lists some of the more common error codes related to Always On VPN. For a full list of error codes, see [Routing and Remote Access Error Codes](/windows/win32/rras/routing-and-remote-access-error-codes).

### NPS logs

NPS creates and stores the NPS accounting logs. By default, logs are stored in **%SYSTEMROOT%\\System32\\Logfiles\\** in a file named `IN<date of log creation>.txt`.

By default, these logs are in comma-separated values format, but they don't include a heading row. The following code block contains the heading row:

```text
ComputerName,ServiceName,Record-Date,Record-Time,Packet-Type,User-Name,Fully-Qualified-Distinguished-Name,Called-Station-ID,Calling-Station-ID,Callback-Number,Framed-IP-Address,NAS-Identifier,NAS-IP-Address,NAS-Port,Client-Vendor,Client-IP-Address,Client-Friendly-Name,Event-Timestamp,Port-Limit,NAS-Port-Type,Connect-Info,Framed-Protocol,Service-Type,Authentication-Type,Policy-Name,Reason-Code,Class,Session-Timeout,Idle-Timeout,Termination-Action,EAP-Friendly-Name,Acct-Status-Type,Acct-Delay-Time,Acct-Input-Octets,Acct-Output-Octets,Acct-Session-Id,Acct-Authentic,Acct-Session-Time,Acct-Input-Packets,Acct-Output-Packets,Acct-Terminate-Cause,Acct-Multi-Ssn-ID,Acct-Link-Count,Acct-Interim-Interval,Tunnel-Type,Tunnel-Medium-Type,Tunnel-Client-Endpt,Tunnel-Server-Endpt,Acct-Tunnel-Conn,Tunnel-Pvt-Group-ID,Tunnel-Assignment-ID,Tunnel-Preference,MS-Acct-Auth-Type,MS-Acct-EAP-Type,MS-RAS-Version,MS-RAS-Vendor,MS-CHAP-Error,MS-CHAP-Domain,MS-MPPE-Encryption-Types,MS-MPPE-Encryption-Policy,Proxy-Policy-Name,Provider-Type,Provider-Name,Remote-Server-Address,MS-RAS-Client-Name,MS-RAS-Client-Version
```

If you paste this heading row as the first line of the log file, then import the file into Microsoft Excel, then Excel properly labels the columns.

The NPS logs can help you diagnose policy-related issues. For more information about NPS logs, see [Interpret NPS Database Format Log Files](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771748(v=ws.10)).

## Error codes

The following sections describe how to resolve the most commonly encountered errors.

### Error 800: the remote connection couldn't connect

This issue happens when the service can't make a remote connection because the attempted VPN tunnels failed, often because the VPN server isn't reachable. If your connection is trying to use a Layer 2 Tunneling Protocol (L2TP) or IPsec tunnel, this error means the required security parameters for IPsec negotiation aren't configured properly.

#### Cause: VPN tunnel type

You can encounter this issue when the VPN tunnel type is set to **Automatic** and your connection attempt is unsuccessful in all VPN tunnels.

#### Solution: check your VPN configuration

Because VPN settings cause this issue, you should troubleshoot your VPN settings and connection by trying the following:

- If you know which tunnel to use for your deployment, set the type of VPN to that particular tunnel type on the VPN client side.
- Make sure the Internet Key Exchange (IKE) ports on User Datagram Protocol (UDP) ports 500 and 4500 aren't blocked.
- Make sure both the client and server have correct certificates for IKE.

### Error 809: can't establish a connection between local machine and VPN server

In this issue, the remote server doesn't respond, which prevents your local machine and the VPN server from connecting. This could be because one or more network devices, such as routers, firewalls, or the Network Address Translation (NAT) between your computer and the remote server isn't configured to allow VPN connections. Contact your administrator or your service provider to determine which device may be causing the problem.

#### Error 809 cause

You can encounter this issue when the UDP 500 or 4500 ports on the VPN server or firewall are blocked. Blocking can happen when one of the network devices between your computer and the remote server, such as the firewall, NAT, or routers, aren't configured correctly.

#### Solution: check the ports on devices between your local machine and remote server

To address this issue, you should first contact your administrator or service provider to find out which device is blocked. After that, make sure the firewalls for that device allow the UDP 500 and 4500 ports through. If that doesn't address the issue, check the firewalls on every device between your local machine and the remote server.

### Error 812: can't connect to Always On VPN

This issue occurs when your remote access server (RAS) or VPN server can't connect to Always On VPN. The authentication method the server used to verify your user name and password didn't match the authentication method configured in your connection profile.

Whenever you encounter error 812, we recommend that you contact your RAS server administrator immediately to let them know what happened.

If you're using the Event Viewer to troubleshoot, you can find this issue marked as event log 20276. This event usually appears when a routing and remote access (RRAS)-based VPN server authentication protocol setting doesn't match the settings on the VPN client computer.

#### Error 812 cause

You typically encounter this error when the NPS specified an authentication condition the client can't meet. For example, if the NPS specifies it needs a certificate to secure the Protected Extensible Authentication Protocol (PEAP) connection, then it can't authenticate if the client is trying to use EAP-MSCHAPv2 instead.

#### Solution: check your client and NPS server authentication settings

To resolve this issue, make sure the authentication requirements for your client and the NPS server match. If not, change them accordingly.

### Error 13806: IKE can't find a valid machine certificate

This issue occurs when IKE can't find a valid machine certificate.

#### Error 13806 cause

You usually encounter this error when the VPN server doesn't have the required machine or root machine certificate.

#### Solution: install a valid certificate in the relevant certificate store

To resolve this issue, make sure the required certificates are installed on both the client machine and the VPN server. If not, contact your network security administrator and ask them to install valid certificates in the relevant certificate store.

### Error 13801: the IKE authentication credentials are invalid

You encounter this issue when either the server or client can't accept the IKE authentication credentials.

#### Error 13801 cause

This error can occur due to the following:

- The machine certificate used for IKEv2 validation on the RAS server doesn't have **Server Authentication** enabled under **Enhanced Key Usage**.
- The machine certificate on the RAS server expired.
- The client machine doesn't have the root certificate for validating the RAS server certificate.
- The client machine's VPN server name doesn't match the *subjectName* value on the server certificate.

#### Solution 1: verify the server certificate settings

If the issue is the RAS server machine certificate, make sure the certificate includes **Server Authentication** under **Enhanced Key Usage**.

#### Solution 2: make sure the machine certificate is still valid

If the issue is that the RAS machine certificate expired, make sure it's still valid. If it isn't, install a valid certificate.

#### Solution 3: make sure the client machine has a root certificate

If the issue is related to the client machine not having a root certificate, first check the **Trusted Root Certification Authorities** on the RRAS server to make sure the certification authority you're using is there. If it isn't there, install a valid root certificate.

#### Solution 4: make the client machine's VPN server name matches the server certificate

First, make sure the VPN client connects by using the same fully qualified domain name (FQDN) that the VPN server certificate uses. If not, change the client name to match the server certificate name.

### Error 0x80070040: server certificate doesn't have Server Authentication in its usage entries

This issue occurs when the server certificate doesn't have **Server Authentication** as one of its certificate usage entries.

#### Error 0x80070040 cause

This error occurs when the RAS server doesn't have a server authentication certificate installed.

#### Solution: make sure the machine certificate has the required certificate usage entry

To address this issue, make sure the machine certificate the RAS server uses for IKEv2 validation includes **Server Authentication** in its list of certificate usage entries.

### Error 0x800B0109: a certificate chain processed but terminated in a root certificate

The full error description is, "A certificate chain processed but terminated in a root certificate that the trust provider doesn't trust."

Generally, the VPN client machine is joined to an Active Directory (AD)-based domain. If you use domain credentials to sign in to the VPN server, the service automatically installs the certificate in the Trusted Root Certification Authorities store. You may encounter this issue if the computer isn't joined to an AD domain or you use an alternative certificate chain.

#### Error 0x800B0109 cause

You may encounter this error if the client computer doesn't have an appropriate trusted root CA certificate installed in its Trusted Root Certification Authorities store.

#### Solution: install the trusted root certificate

To resolve this issue, make sure the client machine has a trusted root certificate installed in its Trusted Root Certification Authorities store. If not, install an appropriate root certificate.

### Error: Oops, you can't get to this yet

This error message is associated with Microsoft Entra Conditional Access connection issues. When this issue appears, the Conditional Access policy isn't satisfied, blocking the VPN connection but then connecting after the user closes the dialog window. If the user selects **OK**, it starts another authentication attempt that also doesn't succeed and prompts an identical error message. The client's Microsoft Entra Operational Event log records these events.

<a name='azure-ad-conditional-access-error-cause'></a>

#### Microsoft Entra Conditional Access error cause

There are a few reasons why this issue can happen:

- The user has a client authentication certificate in their Personal Certificate store that's valid but didn't come from Microsoft Entra ID.

- The VPN profile `<TLSExtensions>` section is either missing or doesn't contain the `<EKUName>AAD Conditional Access</EKUName><EKUOID>1.3.6.1.4.1.311.87</EKUOID><EKUName>AAD Conditional Access</EKUName><EKUOID>1.3.6.1.4.1.311.87</EKUOID>` entries. The `<EKUName>` and `<EKUOID>` entries tell the VPN client which certificate to retrieve from the user's certificate store when passing the certificate to the VPN server. Without the  `<EKUName>` and `<EKUOID>` entries, the VPN client uses whatever valid Client Authentication certificate is in the user's certificate store and authentication succeeds.

- The RADIUS server (NPS) hasn't been configured to only accept client certificates that contain the **Microsoft Entra Conditional Access** object identifier (OID).

#### Solution: use PowerShell to determine certificate status

To escape this loop:

1. In Windows PowerShell, run the `Get-WmiObject` cmdlet to dump the VPN profile configuration.
1. Verify that the `<TLSExtensions>`, `<EKUName>`, and `<EKUOID>` variables exist and their output shows the correct name and OID.

  The following code is an example output of the `Get-WmiObject` command.

  ```powershell
  PS C:\> Get-WmiObject -Class MDM_VPNv2_01 -Namespace root\cimv2\mdm\dmmap

  __GENUS                 : 2
  __CLASS                 : MDM_VPNv2_01
  __SUPERCLASS            :
  __DYNASTY               : MDM_VPNv2_01
  __RELPATH               : MDM_VPNv2_01.InstanceID="AlwaysOnVPN",ParentID="./Vendor/MSFT/VPNv2"
  __PROPERTY_COUNT        : 10
  __DERIVATION            : {}
  __SERVER                : DERS2
  __NAMESPACE             : root\cimv2\mdm\dmmap
  __PATH                  : \\DERS2\root\cimv2\mdm\dmmap:MDM_VPNv2_01.InstanceID="AlwaysOnVPN",ParentID="./Vendor/MSFT/VP
                              Nv2"
  AlwaysOn                :
  ByPassForLocal          :
  DnsSuffix               :
  EdpModeId               :
  InstanceID              : AlwaysOnVPN
  LockDown                :
  ParentID                : ./Vendor/MSFT/VPNv2
  ProfileXML              : <VPNProfile><RememberCredentials>false</RememberCredentials><DeviceCompliance><Enabled>true</
                              Enabled><Sso><Enabled>true</Enabled></Sso></DeviceCompliance><NativeProfile><Servers>derras2.corp.deverett.info;derras2.corp.deverett.info</Servers><RoutingPolicyType>ForceTunnel</RoutingPolicyType><NativeProtocolType>Ikev2</NativeProtocolType><Authentication><UserMethod>Eap</UserMethod><MachineMethod>Eap</MachineMethod><Eap><Configuration><EapHostConfigxmlns="https://www.microsoft.com/provisioning/EapHostConfig"><EapMethod><Typexmlns="https://www.microsoft.com/provisioning/EapCommon">25</Type><VendorIdxmlns="https://www.microsoft.com/provisioning/EapCommon">0</VendorId><VendorTypexmlns="https://www.microsoft.com/provisioning/EapCommon">0</VendorType><AuthorIdxmlns="https://www.microsoft.com/provisioning/EapCommon">0</AuthorId></EapMethod><Configxmlns="https://www.microsoft.com/provisioning/EapHostConfig"><Eap xmlns="https://www.microsoft.com/provisioning/BaseEapConnectionPropertiesV1"><Type>25</Type><EapType xmlns="https://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV1"><ServerValidation><DisableUserPromptForServerValidation>true</DisableUserPromptForServerValidation><ServerNames></ServerNames></ServerValidation><FastReconnect>true</FastReconnect><InnerEapOptional>false</InnerEapOptional><Eap xmlns="https://www.microsoft.com/provisioning/BaseEapConnectionPropertiesV1"><Type>13</Type>
                              <EapType xmlns="https://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV1"><CredentialsSource><CertificateStore><SimpleCertSelection>true</SimpleCertSelection></CertificateStore></CredentialsSource><ServerValidation><DisableUserPromptForServerValidation>true</DisableUserPromptForServerValidation><ServerNames></ServerNames><TrustedRootCA>5a 89 fe cb 5b 49 a7 0b 1a 52 63 b7 35 ee d7 1c c2 68 be 4b </TrustedRootCA></ServerValidation><DifferentUsername>false</DifferentUsername><PerformServerValidation xmlns="https://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV2">true</PerformServerValidation><AcceptServerName xmlns="https://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV2">false</AcceptServerName><TLSExtensionsxmlns="https://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV2"><FilteringInfo xml ns="https://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV3"><EKUMapping><EKUMap><EKUName>AAD Conditional Access</EKUName><EKUOID>1.3.6.1.4.1.311.87</EKUOID></EKUMap></EKUMapping><ClientAuthEKUListEnabled="true"><EKUMapInList><EKUName>AAD Conditional Access</EKUName></EKUMapInList></ClientAuthEKUList></FilteringInfo></TLSExtensions></EapType></Eap><EnableQuarantineChecks>false</EnableQuarantineChecks><RequireCryptoBinding>false</RequireCryptoBinding><PeapExtensions><PerformServerValidation xmlns="https://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV2">false</PerformServerValidation><AcceptServerName xmlns="https://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV2">false</AcceptServerName></PeapExtensions></EapType></Eap></Config></EapHostConfig></Configuration></Eap></Authentication></NativeProfile></VPNProfile>
  RememberCredentials     : False
  TrustedNetworkDetection :
  PSComputerName          : DERS2
  ```

1. Next, run the `Certutil` command to determine if there are valid certificates in the user's certificate store:

  ```powershell
  C:\>certutil -store -user My

  My "Personal"
  ================ Certificate 0 ================
  Serial Number: 32000000265259d0069fa6f205000000000026
  Issuer: CN=corp-DEDC0-CA, DC=corp, DC=deverett, DC=info
    NotBefore: 12/8/2017 8:07 PM
    NotAfter: 12/8/2018 8:07 PM
  Subject: E=winfed@deverett.info, CN=WinFed, OU=Users, OU=Corp, DC=corp, DC=deverett, DC=info
  Certificate Template Name (Certificate Type): User
  Non-root Certificate
  Template: User
  Cert Hash(sha1): a50337ab015d5612b7dc4c1e759d201e74cc2a93
    Key Container = a890fd7fbbfc072f8fe045e680c501cf_5834bfa9-1c4a-44a8-a128-c2267f712336
    Simple container name: te-User-c7bcc4bd-0498-4411-af44-da2257f54387
    Provider = Microsoft Enhanced Cryptographic Provider v1.0
  Encryption test passed

  ================ Certificate 1 ================
  Serial Number: 367fbdd7e6e4103dec9b91f93959ac56
  Issuer: CN=Microsoft VPN root CA gen 1
    NotBefore: 12/8/2017 6:24 PM
    NotAfter: 12/8/2017 7:29 PM
  Subject: CN=WinFed@deverett.info
  Non-root Certificate
  Cert Hash(sha1): 37378a1b06dcef1b4d4753f7d21e4f20b18fbfec
    Key Container = 31685cae-af6f-48fb-ac37-845c69b4c097
    Unique container name: bf4097e20d4480b8d6ebc139c9360f02_5834bfa9-1c4a-44a8-a128-c2267f712336
    Provider = Microsoft Software Key Storage Provider
  Private key is NOT exportable
  Encryption test passed
  ```

  >[!NOTE]
  >If a certificate from Issuer **CN=Microsoft VPN root CA gen 1** is present in the user's Personal store, but the user gained access by selecting **X** to close the Oops message, collect CAPI2 event logs to verify the certificate used to authenticate was a valid Client Authentication certificate that wasn't issued from the Microsoft VPN root CA.

1. If a valid Client Authentication certificate exists in the user's personal store and the *TLSExtensions*, *EKUName*, and *EKUOID* values are configured correctly, the connection shouldn't succeed after the user closes the dialog box.

  An error message should appear that says, "A certificate couldn't be found that can be used with the Extensible Authenticate Protocol."

### Unable to delete the certificate from the VPN connectivity tab

This issue is when you can't delete certificates on the VPN connectivity tab.

#### Cause

This issue occurs when the certificate is set to **Primary**.

#### Solution: change certificate settings

To delete certificates:

1. In the **VPN connectivity** tab, select the certificate.
1. Under **Primary**, select **No**, then select **Save**.
1. In the **VPN connectivity** tab, select the certificate again.
1. Select **Delete**.
