---
title: Troubleshoot Always On VPN
description: This topic provides instructions for verifying and troubleshooting Always On VPN deployment in Windows Server 2016.
ms.prod: windows-server
ms.technology: networking-ras
ms.topic: article
ms.assetid: 4d08164e-3cc8-44e5-a319-9671e1ac294a
ms.localizationpriority: medium 
ms.date: 06/11/2018
ms.author: lizross
author: eross-msft
---
# Troubleshoot Always On VPN 

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

If your Always On VPN setup is failing to connect clients to your internal network, the cause is likely an invalid VPN certificate, incorrect NPS policies, or issues with the client deployment scripts or in Routing and Remote Access. The first step in troubleshooting and testing your VPN connection is understanding the core components of the Always On VPN infrastructure. 

You can troubleshoot connection issues in several ways. For client-side issues and general troubleshooting, the application logs on client computers are invaluable. For authentication-specific issues, the NPS log on the NPS server can help you determine the source of the problem.

## Error codes

### Error code: 800

- **Error description.** The remote connection was not made because the attempted VPN tunnels failed. The VPN server might be unreachable. If this connection is attempting to use an L2TP/IPsec tunnel, the security parameters required for IPsec negotiation might not be configured properly.

- **Possible cause.** This error occurs when the VPN tunnel type is **Automatic** and the connection attempt fails for all VPN tunnels.

- **Possible solutions:**

    - If you know which tunnel to use for your deployment, set the type of VPN to that particular tunnel type on the VPN client side.

    - By making a VPN connection with a particular tunnel type, your connection will still fail, but it will result in a more tunnel-specific error (for example, “GRE blocked for PPTP”).

    - This error also occurs when the VPN server cannot be reached or the tunnel connection fails.

- **Make sure:**

    - IKE ports (UDP ports 500 and 4500) aren't blocked.

    - The correct certificates for IKE are present on both the client and the server.

### Error code: 809

- **Error description.**  The network connection between your computer and the VPN server could not be established because the remote server is not responding. This could be because one of the network devices (e.g., firewalls, NAT, routers) between your computer and the remote server is not configured to allow VPN connections. Please contact your administrator or your service provider to determine which device may be causing the problem.

- **Possible cause.** This error is caused by blocked UDP 500 or 4500 ports on the VPN server or the firewall.

- **Possible solution.** Ensure that UDP ports 500 and 4500 are allowed through all firewalls between the client and the RRAS server.

### Error code: 812

- **Error description.** Can't connect to Always On VPN. The connection was prevented because of a policy configured on your RAS/VPN server. Specifically, the authentication method the server used to verify your user name and password may not match the authentication method configured in your connection profile. Please contact the administrator of the RAS server and notify him or her of this error.

- **Possible causes:**

    - The typical cause of this error is that the NPS has specified an authentication condition that the client cannot meet. For example, the NPS may specify the use of a certificate to secure the PEAP connection, but the client is attempting to use EAP-MSCHAPv2.

    - Event log 20276 is logged to the event viewer when the RRAS-based VPN server authentication protocol setting doesn't match that of the VPN client computer.

- **Possible solution.** Ensure that your client configuration matches the conditions that are specified on the NPS server.

### Error code: 13806

- **Error description.** IKE failed to find a valid machine certificate. Contact your network security administrator about installing a valid certificate in the appropriate certificate store.

- **Possible cause.** This error typically occurs when no machine certificate or root machine certificate is present on the VPN server.

- **Possible solution.** Ensure that the certificates outlined in this deployment are installed on both the client computer and the VPN server.

### Error code: 13801

- **Error description.** IKE authentication credentials are unacceptable.

- **Possible causes.** This error typically occurs in one of the following cases:

    - The machine certificate used for IKEv2 validation on the RAS server doesn't have **Server Authentication** under **Enhanced Key Usage**.

    - The machine certificate on the RAS server has expired.

    - The root certificate to validate the RAS server certificate isn't present on the client computer.

    - The VPN server name used on the client computer doesn't match the **subjectName** of the server certificate.

- **Possible solution.** Verify that the server certificate includes **Server Authentication** under **Enhanced Key Usage**. Verify that the server certificate is still valid. Verify that the CA used is listed under **Trusted Root Certification Authorities** on the RRAS server. Verify that the VPN client connects by using the FQDN of the VPN server as presented on the VPN server's certificate.

### Error code: 0x80070040

- **Error description.** The server certificate does not have **Server Authentication** as one of its certificate usage entries.

- **Possible cause.** This error may occur if no server authentication certificate is installed on the RAS server.

- **Possible solution.** Make sure that the machine certificate the RAS server uses for **IKEv2** has **Server Authentication** as one of the certificate usage entries.

### Error code: 0x800B0109

Generally, the VPN client machine is joined to the Active Directory–based domain. If you use domain credentials to log on to the VPN server, the certificate is automatically installed in the Trusted Root Certification Authorities store. However, if the computer is not joined to the domain or if you use an alternative certificate chain, you may experience this issue.

- **Error description.** A certificate chain processed but terminated in a root certificate that the trust provider does not trust.

- **Possible cause.** This error may occur if the appropriate trusted root CA certificate is not installed in the Trusted Root Certification Authorities store on the client computer.

- **Possible solution.** Make sure that the root certificate is installed on the client computer in the Trusted Root Certification Authorities store.

## Logs

### Application logs

The application logs on client computers record most of the higher-level details of VPN connection events.

Look for events from source RasClient. All error messages return the error code at the end of the message. Some of the more common error codes are detailed below, but a full list is available in [Routing and Remote Access Error Codes](https://msdn.microsoft.com/library/windows/desktop/bb530704.aspx).

## NPS logs

NPS creates and stores the NPS accounting logs. By default, these are stored in %SYSTEMROOT%\\System32\\Logfiles\\ in a file named IN*XXXX*.txt, where *XXXX* is the date the file was created.

By default, these logs are in comma-separated values format, but they don't include a heading row. The heading row is:

```
ComputerName,ServiceName,Record-Date,Record-Time,Packet-Type,User-Name,Fully-Qualified-Distinguished-Name,Called-Station-ID,Calling-Station-ID,Callback-Number,Framed-IP-Address,NAS-Identifier,NAS-IP-Address,NAS-Port,Client-Vendor,Client-IP-Address,Client-Friendly-Name,Event-Timestamp,Port-Limit,NAS-Port-Type,Connect-Info,Framed-Protocol,Service-Type,Authentication-Type,Policy-Name,Reason-Code,Class,Session-Timeout,Idle-Timeout,Termination-Action,EAP-Friendly-Name,Acct-Status-Type,Acct-Delay-Time,Acct-Input-Octets,Acct-Output-Octets,Acct-Session-Id,Acct-Authentic,Acct-Session-Time,Acct-Input-Packets,Acct-Output-Packets,Acct-Terminate-Cause,Acct-Multi-Ssn-ID,Acct-Link-Count,Acct-Interim-Interval,Tunnel-Type,Tunnel-Medium-Type,Tunnel-Client-Endpt,Tunnel-Server-Endpt,Acct-Tunnel-Conn,Tunnel-Pvt-Group-ID,Tunnel-Assignment-ID,Tunnel-Preference,MS-Acct-Auth-Type,MS-Acct-EAP-Type,MS-RAS-Version,MS-RAS-Vendor,MS-CHAP-Error,MS-CHAP-Domain,MS-MPPE-Encryption-Types,MS-MPPE-Encryption-Policy,Proxy-Policy-Name,Provider-Type,Provider-Name,Remote-Server-Address,MS-RAS-Client-Name,MS-RAS-Client-Version
```

If you paste this heading row as the first line of the log file, then import the file into Microsoft Excel, the columns will be properly labeled.

The NPS logs can be helpful in diagnosing policy-related issues. For more information about NPS logs, see [Interpret NPS Database Format Log Files](https://technet.microsoft.com/library/cc771748.aspx).

## VPN_Profile.ps1 script issues

The most common issues when manually running the VPN_ Profile.ps1 script include:

- Do you use a remote connection tool?  Make sure not to use RDP or another remote connection method as it messes with user login detection.

- Is the user an administrator of that local machine?  Make sure that while running the VPN_Profile.ps1 script that the user has administrator privileges.

- Do you have additional PowerShell security features enabled? Make sure that the PowerShell execution policy is not blocking the script. You might consider turning off Constrained Language mode, if enabled, before running the script. You can activate Constrained Language mode after the script completes successfully.

## Always On VPN client connection issues

A small misconfiguration can cause the client connection to fail and can be challenging to find the cause.  An Always On VPN client goes through several steps before establishing a connection. When troubleshooting client connection issues, go through the process of elimination with the following:

1. Is the template machine externally connected? A **whatismyip** scan should show a public IP address that does not belong to you.

2. Can you resolve the Remote Access/VPN server name to an IP address? In **Control Panel** > **Network** and **Internet** > **Network Connections**, open the properties for your VPN Profile. The value in the **General** tab should be publicly resolvable through DNS.

3. Can you access the VPN server from an external network? Consider opening Internet Control Message Protocol (ICMP) to the external interface and pinging the name from the remote client. After a ping is successful, you can remove the ICMP allow rule.

4. Do you have the internal and external NICs on the VPN server configured correctly? Are they in different subnets? Does the external NIC connect to the correct interface on your firewall?

5. Are UDP 500 and 4500 ports open from the client to the VPN server's external interface? Check the client firewall, server firewall, and any hardware firewalls. IPSEC uses UDP port 500, so make sure that you do not have IPEC disabled or blocked anywhere.

6. Is certificate validation failing? Verify the NPS server has a Server Authentication certificate that can service IKE requests. Make sure that you have the correct VPN server IP specified as an NPS client. Make sure that you are authenticating with PEAP, and the Protected EAP properties should only allow authentication with a certificate. You can check the NPS event logs for authentication failures. For more details, see [Install and Configure the NPS Server](vpn-deploy-nps.md)

7. Are you connecting but do not have Internet/local network access? Check your DHCP/VPN server IP pools for configuration issues.

8. Are you connecting and have a valid internal IP but do not have access to local resources?  Verify that clients know how to get to those resources. You can use the VPN server to route requests.

## Azure AD Conditional Access connection issues

### Oops - You can't get to this yet

- **Error description.** When the Conditional Access policy is not satisfied, blocking the VPN connection, but connects after the user selects **X** to close the message.  Selecting **OK** causes another authentication attempt, which ends in another "Oops" message. These events are recorded in the AAD Operational Event log of the client.

- **Possible cause**

  - The user has a valid client authentication certificate in their Personal Certificate store that was not issued by Azure AD.

  - The VPN profile \<TLSExtensions\> section is either missing or does not contain the **\<EKUName\>AAD Conditional Access\</EKUName\>\<EKUOID\>1.3.6.1.4.1.311.87</EKUOID\>\<EKUName>AAD Conditional Access</EKUName\>\<EKUOID\>1.3.6.1.4.1.311.87</EKUOID\>** entries. The \<EKUName> and \<EKUOID> entries tell the VPN client which certificate to retrieve from the user's certificate store when passing the certificate to the VPN server. Without this, the VPN client uses whatever valid Client Authentication certificate is in the user's certificate store and authentication succeeds. 

  - The RADIUS server (NPS) has not been configured to only accept client certificates that contain the **AAD Conditional Access** OID.

- **Possible solution.** To escape this loop, do the following:

  1. In Windows PowerShell, run the **Get-WmiObject** cmdlet to dump the VPN profile configuration. 
  2. Verify that the **\<TLSExtensions>**, **\<EKUName>**, and **\<EKUOID>** sections exist and shows the correct name and OID.
      
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
                                  Enabled><Sso><Enabled>true</Enabled></Sso></DeviceCompliance><NativeProfile><Servers>derras2.
                                  corp.deverett.info;derras2.corp.deverett.info</Servers><RoutingPolicyType>ForceTunnel</Routin
                                  gPolicyType><NativeProtocolType>Ikev2</NativeProtocolType><Authentication><UserMethod>Eap</Us
                                  erMethod><MachineMethod>Eap</MachineMethod><Eap><Configuration><EapHostConfig
                                  xmlns="https://www.microsoft.com/provisioning/EapHostConfig"><EapMethod><Type
                                  xmlns="https://www.microsoft.com/provisioning/EapCommon">25</Type><VendorId
                                  xmlns="https://www.microsoft.com/provisioning/EapCommon">0</VendorId><VendorType
                                  xmlns="https://www.microsoft.com/provisioning/EapCommon">0</VendorType><AuthorId
                                  xmlns="https://www.microsoft.com/provisioning/EapCommon">0</AuthorId></EapMethod><Config
                                  xmlns="https://www.microsoft.com/provisioning/EapHostConfig"><Eap xmlns="https://www.microsoft.
                                  com/provisioning/BaseEapConnectionPropertiesV1"><Type>25</Type><EapType xmlns="https://www.mic
                                  rosoft.com/provisioning/MsPeapConnectionPropertiesV1"><ServerValidation><DisableUserPromptFor
                                  ServerValidation>true</DisableUserPromptForServerValidation><ServerNames></ServerNames></Serv
                                  erValidation><FastReconnect>true</FastReconnect><InnerEapOptional>false</InnerEapOptional><Ea
                                  p xmlns="https://www.microsoft.com/provisioning/BaseEapConnectionPropertiesV1"><Type>13</Type>
                                  <EapType xmlns="https://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV1"><Credenti
                                  alsSource><CertificateStore><SimpleCertSelection>true</SimpleCertSelection></CertificateStore
                                  ></CredentialsSource><ServerValidation><DisableUserPromptForServerValidation>true</DisableUse
                                  rPromptForServerValidation><ServerNames></ServerNames><TrustedRootCA>5a 89 fe cb 5b 49 a7 0b
                                  1a 52 63 b7 35 ee d7 1c c2 68 be 4b </TrustedRootCA></ServerValidation><DifferentUsername>fal
                                  se</DifferentUsername><PerformServerValidation xmlns="https://www.microsoft.com/provisioning/E
                                  apTlsConnectionPropertiesV2">true</PerformServerValidation><AcceptServerName xmlns="https://ww
                                  w.microsoft.com/provisioning/EapTlsConnectionPropertiesV2">false</AcceptServerName><TLSExtens
                                  ions
                                  xmlns="https://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV2"><FilteringInfo xml
                                  ns="https://www.microsoft.com/provisioning/EapTlsConnectionPropertiesV3"><EKUMapping><EKUMap><
                                  EKUName>AAD Conditional
                                  Access</EKUName><EKUOID>1.3.6.1.4.1.311.87</EKUOID></EKUMap></EKUMapping><ClientAuthEKUList
                                  Enabled="true"><EKUMapInList><EKUName>AAD Conditional Access</EKUName></EKUMapInList></Client
                                  AuthEKUList></FilteringInfo></TLSExtensions></EapType></Eap><EnableQuarantineChecks>false</En
                                  ableQuarantineChecks><RequireCryptoBinding>false</RequireCryptoBinding><PeapExtensions><Perfo
                                  rmServerValidation xmlns="https://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV2"
                                  >false</PerformServerValidation><AcceptServerName xmlns="https://www.microsoft.com/provisionin
                                  g/MsPeapConnectionPropertiesV2">false</AcceptServerName></PeapExtensions></EapType></Eap></Co
                                  nfig></EapHostConfig></Configuration></Eap></Authentication></NativeProfile></VPNProfile>
      RememberCredentials     : False
      TrustedNetworkDetection :
      PSComputerName          : DERS2
      ```

  3. To determine if there are valid certificates in the user's certificate store, run the **Certutil** command:

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
     >If a certificate from Issuer **CN=Microsoft VPN root CA gen 1** is present in the user's Personal store, but the user gained access by selecting **X** to close the Oops message, collect CAPI2 event logs to verify the certificate used to authenticate was a valid Client Authentication certificate that was not issued from the Microsoft VPN root CA.

  4. If a valid Client Authentication certificate exists in the user's Personal store, the connection fails (as it should) after the user selects the **X** and  if the **\<TLSExtensions>**, **\<EKUName>**, and **\<EKUOID>** sections exist and contain the correct information.
   
     An error message that says "A certificate could not be found that can be used with the Extensible Authenticate Protocol" appears.

### Unable to delete the certificate from the VPN connectivity blade

- **Error description.** Certificates on the VPN connectivity blade cannot be deleted.

- **Possible cause.** The certificate is set to **Primary**.

- **Possible solution.**

    1. In the VPN connectivity blade, select the certificate.
    2. Under **Primary**, select **No**, then select **Save**.
    3. In the VPN connectivity blade, select the certificate again.
    4. Select **Delete**.
