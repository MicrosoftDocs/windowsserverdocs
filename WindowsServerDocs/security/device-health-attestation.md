---
title: Device Health Attestation
H1: na
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.technology: techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8e7b77a4-1c6a-4c21-8844-0df89b63f68d
author: brianlic-msft
ms.date: 10/12/2016
---
# Device Health Attestation

>Applies To: Windows Server 2016

Introduced in Windows 10, version 1507, Device Health Attestation (DHA) included the following:

-	Integrates with Windows 10 Mobile Device Management (MDM) framework in alignment with  [Open Mobile Alliance (OMA) standards](http://openmobilealliance.org/).

-	Supports devices that have a Trusted Module Platform (TPM) provisioned in a firmware or discrete format.

-	Enables enterprises to raise the security bar of their organization to hardware monitored and attested security, with minimal or no impact on operation cost.

Starting with Windows Server 2016, you can now run the DHA service as a server role within your organization. Use this topic to learn how to install and configure the Device Health Attestation server role.

## Overview

You can use DHA to assess device health for:
  
-	Windows 10 and Windows 10 Mobile devices that support TPM 1.2 or 2.0.  
-	On-premises devices that are managed by using Active Directory with Internet access, devices that are managed by using Active Directory without Internet access, devices managed by Azure Active Directory , or a hybrid deployment using both Active Directory and Azure Active Directory.


### DHA service

The DHA service validates the TPM and PCR logs for a device and then issues a DHA report. Microsoft offers the DHA service in three ways:

- **DHA cloud service**  A Microsoft-managed DHA service that is free, geo-load-balanced, and optimized for access from different regions of the world.

- **DHA on-premises service** A new server role introduced in Windows Server 2016. It's available for free to customers that have a Windows Server 2016 license.

- **DHA Azure cloud service** A virtual host in Microsoft Azure. To do this, you need a virtual host and licenses for the DHA on-premises service.

The DHA service integrates with MDM solutions and provides the following: 

-	Combine the info they receive from devices (through existing device management communication channels) with the DHA report
-	Make a more secure and trusted security decision, based on hardware attested and protected data

Here's an example that shows how you can use DHA to help raise the security protection bar for your organization's assets.

1. You create a policy that checks the following boot configuration/attributes:
   - Secure Boot
   - BitLocker
   - ELAM
2. The MDM solution enforces this policy and triggers a corrective action based on the DHA report data.  For example, it could verify the following:
   - Secure Boot was enabled, the device loaded trusted code that is authentic, and the Windows boot loader was not tampered with.
   - Trusted Boot successfully verified the digital signature of the Windows kernel and the components that were loaded while the device started.
   - Measured Boot created a TPM-protected audit trail that could be verified remotely.
   - BitLocker was enabled and that it protected the data when the device was turned off.
   - ELAM was enabled at early boot stages and is monitoring the runtime.
  
#### DHA cloud service

The DHA cloud service provides the following benefits:

-	Reviews the TCG and PCR device boot logs it receives from a device that is enrolled with an MDM solution. 
-	Creates a tamper resistant and tamper evident report (DHA report) that describes how the device started based on data that is collected and protected by a device's TPM chip. 
-	Delivers the DHA report to the MDM server that requested the report in a protected communication channel.

#### DHA on-premises service

The DHA on-premises service offer all the capabilities that are offered by DHA cloud service.  It also enables customers to:

 - Optimize performance by running DHA service in your own data center
 - Ensure that the DHA report does not leave your network

#### DHA Azure cloud service

This service provides the same functionality as the DHA on-premises service, except that the DHA Azure cloud service runs as a virtual host in Microsoft Azure.

### DHA validation modes

You can set up the DHA on-premises service to run in either EKCert or AIKCert validation mode. When the DHA service issues a report, it indicates if it was issued in AIKCert or EKCert validation mode. AIKCert and EKCert validation modes offer the same security assurance as long as the EKCert chain of trust is kept up-to-date.

#### EKCert validation mode

EKCert validation mode is optimized for devices in organizations that are not connected to the Internet. Devices connecting to a DHA service running in EKCert validation mode do **not** have direct access to the Internet.

When DHA is running in EKCert validation mode, it relies on an enterprise managed chain of trust that needs to updated occasionally (approximately 5 - 10 times per year). 

Microsoft publishes aggregated packages of trusted Roots and intermediate CA's for approved TPM manufacturers (as they become available) in a publicly accessible archive in .cab archive. You need to download the feed, validate its integrity, and install it on the server running Device Health Attestation.

An example archive is [https://go.microsoft.com/fwlink/?linkid=2097925](https://go.microsoft.com/fwlink/?linkid=2097925).

#### AIKCert validation mode

AIKCert Validation Mode is optimized for operational environments that do have access to the Internet. Devices connecting to a DHA service running in AIKCert validation mode must have direct access to the Internet and are able to get an AIK certificate from Microsoft. 

## Install and configure the DHA service on Windows Server 2016

Use the following sections to get DHA installed and configured on Windows Server 2016.

### Prerequisites

In order to set up and verify a DHA on-premises service, you need:

- A server running Windows Server 2016.
- One (or more) Windows 10 client devices with a TPM (either 1.2 or 2.0) that is in a clear/ready state running the latest Windows Insider build.
- Decide if you are going to run in EKCert or AIKCert validation mode.
- The following certificates:
  - **DHA SSL certificate** An x.509 SSL certificate that chains to an enterprise trusted root with an exportable private key. This certificate protects DHA data communications in transit including server to server (DHA service and MDM server) and server to client (DHA service and a Windows 10 device) communications.
  - **DHA signing certificate** An x.509 certificate that chains to an enterprise trusted root with an exportable private key. The DHA service uses this certificate for digital signing. 
  - **DHA encryption certificate** An x.509 certificate that chains to an enterprise trusted root with an exportable private key. The DHA service also uses this certificate for encryption. 


### Install Windows Server 2016

Install Windows Server 2016 using your preferred installation method, such as Windows Deployment Services, or running the installer from bootable media, a USB drive, or the local file system. If this is the first time you are configuring the DHA on-premises service, you should install Windows Server 2016 using the **Desktop Experience** installation option.

### Add the Device Health Attestation server role

You can install the Device Health Attestation server role and its dependencies by using Server Manager. 

After you've installed Windows Server 2016, the device restarts and opens Server Manager. If Server manager doesn't start automatically, click **Start**, and then click **Server Manager**.

1.	Click **Add roles and features**.
2.	On the **Before you begin** page, click **Next**.
3.	On the **Select installation type** page, click **Role-based or feature-based installation**, and then click **Next**.
4.	On the **Select destination server** page, click **Select a server from the server pool**, select the server, and then click **Next**.
5.	On the **Select server roles** page, select the **Device Health Attestation** check box.
6.	Click **Add Features** to install other required role services and features.
7.	Click **Next**.
8.	On the **Select features** page, click **Next**.
9.	On the **Web Server Role (IIS)** page, click **Next**.
10.	On the **Select role services** page, click **Next**.
11.	On the **Device Health Attestation Service** page, click **Next**.
12.	On the **Confirm installation selections** page, click **Install**.
13.	When the installation is done, click **Close**.

### Install the signing and encryption certificates

Using the following Windows PowerShell script to install the signing and encryption certificates. For more information about the thumbprint, see [How to: Retrieve the Thumbprint of a Certificate](https://msdn.microsoft.com/library/ms734695.aspx).

```
$key = Get-ChildItem Cert:\LocalMachine\My | Where-Object {$_.Thumbprint -like "<thumbprint>"}
$keyname = $key.PrivateKey.CspKeyContainerInfo.UniqueKeyContainerName
$keypath = $env:ProgramData + "\Microsoft\Crypto\RSA\MachineKeys\" + $keyname
icacls $keypath /grant <username>`:R
  
#<thumbprint>: Certificate thumbprint for encryption certificate or signing certificate
#<username>: Username for web service app pool, by default IIS_IUSRS
```

### Install the trusted TPM roots certificate package

To install the trusted TPM roots certificate package, you must extract it, remove any trusted chains that are not trusted by your organization, and then run setup.cmd.

#### Download the trusted TPM roots certificate package

Before you install the certificate package, you can download the latest list of trusted TPM roots from
[https://go.microsoft.com/fwlink/?linkid=2097925](https://go.microsoft.com/fwlink/?linkid=2097925).

> **Important:** Before installing the package, verify that it is digitally signed by Microsoft.

#### Extract the trusted certificate package
Extract the trusted certificate package by running the following commands.
```
mkdir .\TrustedTpm
expand -F:* .\TrustedTpm.cab .\TrustedTpm
```

#### Remove the trust chains for TPM vendors that are *not* trusted by your organization (Optional)

Delete the folders for any TPM vendor trust chains that are not trusted by your organization.

> **Note:** If using AIK Certificate mode, the Microsoft folder is required to validate Microsoft issued AIK certificates.

#### Install the trusted certificate package
Install the trusted certificate package by running the setup script from the .cab file.

```
.\setup.cmd
```

### Configure the Device Health Attestation service

You can use Windows PowerShell to configure the DHA on-premises service.

```
Install-DeviceHealthAttestation -EncryptionCertificateThumbprint <encryption> -SigningCertificateThumbprint <signing> -SslCertificateStoreName My -SslCertificateThumbprint <ssl> -SupportedAuthenticationSchema "<schema>"

#<encryption>: Thumbprint of the encryption certificate
#<signing>: Thumbprint of the signing certificate
#<ssl>: Thumbprint of the SSL certificate
#<schema>: Comma-delimited list of supported schemas including AikCertificate, EkCertificate, and AikPub
```

### Configure the certificate chain policy

Configure the certificate chain policy by running the following Windows PowerShell script.

```
$policy = Get-DHASCertificateChainPolicy
$policy.RevocationMode = "NoCheck"
Set-DHASCertificateChainPolicy -CertificateChainPolicy $policy
```

## DHA management commands

Here are some Windows PowerShell examples that can help you manage the DHA service.

### Configure the DHA service for the first time

```
Install-DeviceHealthAttestation -SigningCertificateThumbprint "<HEX>" -EncryptionCertificateThumbprint "<HEX>" -SslCertificateThumbprint "<HEX>" -Force
```

### Remove the DHA service configuration

```
Uninstall-DeviceHealthAttestation -RemoveSslBinding -Force
```
### Get the active signing certificate

```
Get-DHASActiveSigningCertificate
```
### Set the active signing certificate

```
Set-DHASActiveSigningCertificate -Thumbprint "<hex>" -Force
```

> **Note:** This certificate must be deployed on the server running the DHA service in the **LocalMachine\My** certificate store. When the active signing certificate is set, the existing active signing certificate is moved to the list of inactive signing certificates.

### List the inactive signing certificates
```
Get-DHASInactiveSigningCertificates
```

### Remove any inactive signing certificates
```
Remove-DHASInactiveSigningCertificates -Force
Remove-DHASInactiveSigningCertificates  -Thumbprint "<hex>" -Force
```

> **Note:** Only *one* inactive certificate (of any type) may exist in the service at any time. Certificates should be removed from the list of inactive certificates once they are no longer required.

### Get the active encryption certificate

```
Get-DHASActiveEncryptionCertificate
```

### Set the active encryption certificate

```
Set-DHASActiveEncryptionCertificate -Thumbprint "<hex>" -Force
```

The certificate must be deployed on the device in the **LocalMachine\My** certificate store. 

When the active encryption certificate is set, the existing active encryption certificate is moved to the list of inactive encryption certificates.

### List the inactive encryption certificates

```
Get-DHASInactiveEncryptionCertificates
```
### Remove any inactive encryption certificates

```
Remove-DHASInactiveEncryptionCertificates -Force
Remove-DHASInactiveEncryptionCertificates -Thumbprint "<hex>" -Force 
```

### Get the X509ChainPolicy configuration 

```
Get-DHASCertificateChainPolicy
```
### Change the X509ChainPolicy configuration

```
$certificateChainPolicy = Get-DHASInactiveEncryptionCertificates
$certificateChainPolicy.RevocationFlag = <X509RevocationFlag>
$certificateChainPolicy.RevocationMode = <X509RevocationMode>
$certificateChainPolicy.VerificationFlags = <X509VerificationFlags>
$certificateChainPolicy.UrlRetrievalTimeout = <TimeSpan>
Set-DHASCertificateChainPolicy = $certificateChainPolicy
```

## DHA service reporting

The following are a list of messages that are reported by the DHA service to the MDM solution: 

- **200** HTTP OK. The certificate is returned.
- **400** Bad request. Invalid request format, invalid health certificate, certificate signature does not match, invalid Health Attestation Blob, or an invalid Health Status Blob. The response also contains a message, as described by the response schema, with an error code and an error message that can be used for diagnostics.
- **500** Internal server error. This can happen if there are issues that prevent the service from issuing certificates.
- **503** Throttling is rejecting requests to prevent server overloading. 
