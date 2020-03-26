---
title: Troubleshooting Authentication Issues
description: This topic is part of the guide Deploy Remote Access with OTP Authentication in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 71307757-f8f4-4f82-b8b3-ffd4fd8c5d6d
ms.author: lizross
author: eross-msft
---
# Troubleshooting Authentication Issues

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic contains troubleshooting information for issues related to problems users may have when attempting to connect to DirectAccess using OTP authentication. DirectAccerss OTP related events are logged on the client computer in Event Viewer under **Applications and Services Logs/Microsoft/Windows/OtpCredentialProvider**. Make sure that this log is enabled when troubleshooting issues with DirectAccess OTP.  
  
## Failed to access the CA that issues OTP certificates  
**Scenario**. User fails to authenticate using OTP with the error: "Authentication failed due to an internal error"  
  
**Error received** (client event log). OTP certificate enrollment for user <username> failed on CA server <CA_name>, request failed, possible reasons for failure: CA server name cannot be resolved, CA server cannot be accessed over the first DirectAccess tunnel or the connection to the CA server cannot be established.  
  
**Cause**  
  
The user provided a valid one-time password and the DirectAccess server signed the certificate request; however, the client computer cannot contact the CA that issues OTP certificates to finish the enrollment process.  
  
**Solution**  
  
On the DirectAccess server, run the following Windows PowerShell commands:  
  
1.  Get the list of configured OTP issuing CAs and check the value of 'CAServer': `Get-DAOtpAuthentication`  
  
2.  Make sure that the CAs are configured as a management servers: `Get-DAMgmtServer -Type All`  
  
3.  Make sure that the client computer has established the infrastructure tunnel: In the Windows Firewall with Advanced Security console, expand **Monitoring/Security Associations**, click **Main Mode**, and make sure that the IPsec security associations appear with the correct remote addresses for your DirectAccess configuration.  
  
## DirectAccess server connectivity issues  
**Scenario**. User fails to authenticate using OTP with the error: "Authentication failed due to an internal error"  
  
**Error received** (client event log)  
  
One of the following errors:  
  
-   A connection cannot be established to Remote Access server <DirectAccess_server_hostname> using base path <OTP_authentication_path> and port <OTP_authentication_port>. Error code: <internal_error_code>.  
  
-   User credentials cannot be sent to Remote Access server <DirectAccess_server_hostname> using base path <OTP_authentication_path> and port <OTP_authentication_port>. Error code: <internal_error_code>.  
  
-   A response was not received from Remote Access server <DirectAccess_server_hostname> using base path <OTP_authentication_path> and port <OTP_authentication_port>. Error code: <internal_error_code>.  
  
**Cause**  
  
The client computer cannot access the DirectAccess server over the Internet, due to either network issues or to a misconfigured IIS server on the DirectAccess server.  
  
**Solution**  
  
Make sure that the Internet connection on the client computer is working, and make sure that the DirectAccess service is running and accessible over the Internet.  
  
## Failed to enroll for the DirectAccess OTP logon certificate  
**Scenario**. User fails to authenticate using OTP with the error: "Authentication failed due to an internal error"  
  
**Error received** (client event log). Certificate enrollment from CA <CA_name> failed. The request was not signed as expected by the OTP signing certificate, or the user does not have permission to enroll.  
  
**Cause**  
  
The one-time password provided by the user was correct, but the issuing certification authority (CA) refused to issue the OTP logon certificate. The certificate request may not be properly signed with the correct EKU (OTP registration authority application policy), or the user does not have the "Enroll" permission on the DA OTP template.  
  
**Solution**  
  
Make sure that DirectAccess OTP users have permission to enroll for the DirectAccess OTP logon certificate and that the proper "Application Policy" is included in the DA OTP registration authority signing template. Also make sure that the DirectAccess registration authority certificate on the Remote Access server is valid. See 3.2 Plan the OTP certificate template and 3.3 Plan the registration authority certificate.  
  
## Missing or invalid computer account certificate  
**Scenario**. User fails to authenticate using OTP with the error: "Authentication failed due to an internal error"  
  
**Error received** (client event log).  OTP authentication cannot be completed because the computer certificate required for OTP cannot be found in local machine certificate store.  
  
**Cause**  
  
DirectAccess OTP authentication requires a client computer certificate to establish an SSL connection with the DirectAccess server; however, the client computer certificate was not found or is not valid, for example, if the certificate expired.  
  
**Solution**  
  
Make sure that the computer certificate exists and is valid:  
  
1.  On the client computer, in the MMC certificates console, for the Local Computer account, open **Personal/Certificates**.  
  
2.  Make sure that there is a certificate issued that matches the computer name and double-click the certificate.  
  
3.  On the **Certificate** dialog box, on the **Certificate Path** tab, under **Certificate status**, make sure that it says "This certificate is OK."  
  
If a valid certificate is not found, delete the invalid certificate (if it exists) and re-enroll for the computer certificate by either running `gpupdate /Force` from an elevated command prompt or restarting the client computer.  
  
## Missing CA that issues OTP certificates  
**Scenario**. User fails to authenticate using OTP with the error: "Authentication failed due to an internal error"  
  
**Error received** (client event log). OTP authentication cannot be completed because the DA server did not return an address of an issuing CA.  
  
**Cause**  
  
Either there are no CAs that issue OTP certificates configured, or all of the configured CAs that issue OTP certificates are unresponsive.  
  
**Solution**  
  
1.  Use the following command to get the list of CAs that issue OTP certificates (the CA name is shown in CAServer): `Get-DAOtpAuthentication`.  
  
2.  If no CAs are configured:  
  
    1.  Use either the command `Set-DAOtpAuthentication` or the Remote Access Management console to configure the CAs that issue the DirectAccess OTP logon certificate.  
  
    2.  Apply the new configuration and force the clients to refresh the DirectAccess GPO settings by running `gpupdate /Force` from an elevated command prompt or restarting the client machine.  
  
3.  If there are CAs configured, make sure they're online and responding to enrollment requests.  
  
## Misconfigured DirectAccess server address  
**Scenario**. User fails to authenticate using OTP with the error: "Authentication failed due to an internal error"  
  
**Error received** (client event log). OTP authentication cannot complete as expected. The name or address of the Remote Access server cannot be determined.  Error code: <error_code>. DirectAccess settings should be validated by the server administrator.  
  
**Cause**  
  
The address of the DirectAccess server is not configured properly.  
  
**Solution**  
  
Check the configured DirectAccess server address using `Get-DirectAccess` and correct the address if it is misconfigured.  
  
Make sure the latest settings are deployed on the client computer by running `gpupdate /force` from an elevated command prompt or restart the client machine.  
  
## Failed to generate the OTP logon certificate request  
**Scenario**. User fails to authenticate using OTP with the error: "Authentication failed due to an internal error"  
  
**Error received** (client event log). The certificate request for OTP authentication cannot be initialized. Either a private key cannot be generated, or user <username> cannot access certificate template <OTP_template_name> on the domain controller.  
  
**Cause**  
  
There are two possible causes for this error:  
  
-   The user doesn't have permission to read the OTP logon template.  
  
-   The user's computer can't access the domain controller because of network issues.  
  
**Solution**  
  
-   Review the permissions setting on the OTP logon template and make sure that all users provisioned for DirectAccess OTP have 'Read' permission.  
  
-   Make sure that the domain controller is configured as a management server and that the client machine can reach the domain controller over the infrastructure tunnel. See 3.2 Plan the OTP certificate template.  
  
## No connection to the domain controller  
**Scenario**. User fails to authenticate using OTP with the error: "Authentication failed due to an internal error"  
  
**Error received** (client event log). A connection with the domain controller for the purpose of OTP authentication cannot be established. Error code: <error_code>.  
  
**Cause**  
  
There are two possible causes for this error:  
  
-   The user's computer has no network connectivity.  
  
-   The domain controller isn't accessible over the infrastructure tunnel.  
  
**Solution**  
  
-   Make sure that the domain controller is configured as a management server by running the following command from a PowerShell prompt: `Get-DAMgmtServer -Type All`.  
  
-   Make sure that the client computer can reach the domain controller over the infrastructure tunnel.  
  
## OTP provider requires challenge/response  
**Scenario**. User fails to authenticate using OTP with the error: "Authentication failed due to an internal error"  
  
**Error received** (client event log). OTP authentication with Remote Access server (<DirectAccess_server_name>) for user (<username>) required a challenge from the user.  
  
**Cause**  
  
The OTP provider used requires the user to provide additional credentials in the form of a RADIUS challenge/response exchange, which is not supported by  Windows Server 2012  DirectAccess OTP.  
  
**Solution**  
  
Configure the OTP provider to not require challenge/response in any scenario.  
  
## Incorrect OTP logon template used  
**Scenario**. User fails to authenticate using OTP with the error: "Authentication failed due to an internal error"  
  
**Error received** (client event log). The CA template from which user <username> requested a certificate is not configured to issue OTP certificates.  
  
**Cause**  
  
The DirectAccess OTP logon template was replaced and the client computer is attempting to authenticate using an older template.  
  
**Solution**  
  
Make sure the client computer is using the latest OTP configuration by performing one of the following:  
  
-   Force a Group Policy update by running the following command from an elevated command prompt: `gpupdate /Force`.  
  
-   Restart the client machine.  
  
## Missing OTP signing certificate  
**Scenario**. User fails to authenticate using OTP with the error: "Authentication failed due to an internal error"  
  
**Error received** (client event log). An OTP signing certificate cannot be found. The OTP certificate enrollment request cannot be signed.  
  
**Cause**  
  
The DirectAccess OTP signing certificate cannot be found on the Remote Access server; therefore, the user certificate request can't be signed by the Remote Access server. Either there is no signing certificate, or the signing certificate has expired and was not renewed.  
  
**Solution**  
  
Perform these steps on the Remote Access server.  
  
1.  Check the configured OTP signing certificate template name by running the PowerShell cmdlet `Get-DAOtpAuthentication` and inspect the value of `SigningCertificateTemplateName`.  
  
2.  Use the Certificates MMC snap-in to make sure that a valid certificate enrolled from this template exists on the computer.  
  
3.  If no such certificate exists, delete the expired certificate (if one exists) and enroll for a new certificate based on this template.  
  
To create the OTP signing certificate template see 3.3 Plan the registration authority certificate.  
  
## Missing or incorrect UPN/DN for the user  
**Scenario**. User fails to authenticate using OTP with the error: "Authentication failed due to an internal error"  
  
**Error received** (client event log)  
  
One of the following errors:  
  
-   User <username> cannot be authenticated with OTP. Ensure that a UPN is defined for the user name in Active Directory. Error code: <error_code>.  
  
-   User <username> cannot be authenticated with OTP. Ensure that a DN is defined for the user name in Active Directory. Error code: <error_code>.  
  
**Error received** (server event log)  
  
The user name <username> specified for OTP authentication does not exist.  
  
**Cause**  
  
The user does not have the User Principal Name (UPN) or Distinguished Name (DN) attributes properly set in the user account, these properties are required for proper functioning of DirectAccess OTP.  
  
**Solution**  
  
Use the Active Directory Users and Computers console on the domain controller to verify that both of these attributes are properly set for the authenticating user.  
  
## OTP certificate is not trusted for login  
**Scenario**. User fails to authenticate using OTP with the error: "Authentication failed due to an internal error"  
  
**Cause**  
  
The CA that issues OTP certificates is not in the enterprise NTAuth store; therefore, enrolled certificates can't be used for logon. This can occur in multi domain and multiforest environments where cross domain CA trust is not established.  
  
**Solution**  
  
Make sure that the certificate of the root of the CA hierarchy that issues OTP certificates is installed in the enterprise NTAuth Certificate store of the domain to which the user is attempting to authenticate.  
  
## Windows could not verify user credentials  
**Scenario**. User fails to authenticate using OTP with the error: "Authentication failed due to an internal error"  
  
**Error received** (Client computer). Something went wrong while Windows was verifying your credentials. Try again, or ask your administrator for help.  
  
**Cause**  
  
The Kerberos authentication protocol does not work when the DirectAccess OTP logon certificate does not include a CRL. The DirectAccess OTP logon certificate does not include a CRL because either:  
  
-   The DirectAccess OTP logon template was configured with the option **Do not include revocation information in issued certificates**.  
  
-   The CA is configured not to publish CRLs.  
  
**Solution**  
  
1.  To confirm the cause for this error, in the Remote Access Management console, in **Step 2 Remote Access Server**, click **Edit**, and then in the **Remote Access Server Setup** wizard, click **OTP Certificate Templates**. Make a note of the certificate template used for the enrollment of certificates that are issued for OTP authentication. Open the Certification Authority console, in the left pane, click **Certificate Templates**, double-click the OTP logon certificate to view the certificate template properties.  
  
    To solve this issue, configure a certificate for the OTP logon certificate and do not select the **Do not include revocation information in issued certificates** check box on the **Server** tab of the template properties dialog box.  
  
2.  On the CA server, open the Certification Authority MMC, right click the issuing CA and click **Properties**. On the **Extensions** tab make sure that CRL publishing is correctly configured.  
  


