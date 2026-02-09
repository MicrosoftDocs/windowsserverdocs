---
title: Enable DNS over HTTPS in DNS Server on Windows Server 
description: Secure DNS traffic with DNS over HTTPS (DoH) for DNS Server on Windows Server. Learn how to configure and verify DoH in this guide.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.reviewer: canasjorge,sruthytv
ms.date: 02/03/2026
#customer intent: As a network administrator, I want to enable DNS over HTTPS on my DNS Server so that I can encrypt DNS traffic between clients and the server.
ai-usage: ai-assisted
---

# Enable DNS over HTTPS in DNS Server (preview)

> [!IMPORTANT]
> DNS over HTTPS (DoH) for DNS Server on Windows Server is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

This article explains how to enable DNS over HTTPS (DoH) in the DNS Server service running on Windows Server.

Traditional DNS traffic is unencrypted, which exposes DNS queries to eavesdropping, interception, and manipulation by attackers on your network. If you need to protect DNS communication between clients and your DNS server, enabling DoH encrypts that traffic using HTTPS, preventing unauthorized observation or tampering.

For more information about how DoH works, see [DNS encryption using DNS over HTTPS](dns-encryption-dns-over-https.md).

## Prerequisites

Before you begin, ensure you have:

- Windows Server 2025 with the 2026-02 Security Update [KB5075899](https://support.microsoft.com/help/5075899) or later installed

- Access to a certification authority (CA):

  - Microsoft Enterprise Certificate Authority with published certificate templates

  Or

  - Third-party certificate provider such as DigiCert, Let's Encrypt, or Verisign

- Firewall rules configured to allow inbound connections on TCP port 443 for DoH

- Administrative or equivalent access to the Windows Server hosting the DNS Server service

- To enable DNS over HTTPS on the DNS Server service, request access by using [DoH on Windows DNS Server: Public Preview Registration](https://aka.ms/doh-preview). Once requested, follow the instructions you receive before continuing.

DoH certificates must meet the following requirements:

- **Enhanced Key Usage extension**: Must include Server Authentication (1.3.6.1.5.5.7.3.1) object identifier

- **Subject or Subject Alternative Name**: A signed certificate with a Subject Alternative Name (SAN) with the fully qualified domain name or IP address that matches your configured DoH URI template

- **Private key**: Must be present in the Local Computer's store, correctly associated with the certificate, and must not have strong private key protection enabled

- **Trust chain**: Must be issued by a CA that both the DNS server and DNS clients trust

For more complex certificate setups, see [Certificates and Public Keys](/windows/win32/seccrypto/certificates-and-public-keys) and [Working with Certificates](/dotnet/framework/wcf/feature-details/working-with-certificates).

## Import the certificate

If you already have a certificate on the server, go to [Bind the certificate](#bind-the-certificate). Otherwise, import your certificate to the server.

1. Place the certificate's `.pfx` file (containing both certificate and private key) on the server hosting the DNS Server.

1. Open PowerShell as an administrator and run the following command to import the certificate, making sure to replace `<pfxpath>` with the path to your `.pfx` file and `<pfxpassword>` with the password for the `.pfx` file:

   ```powershell
   Import-PfxCertificate `
       -FilePath "<pfxpath>" `
       -CertStoreLocation "Cert:\LocalMachine\My" `
       -Password (Read-Host -AsSecureString "<pfxpassword>")
   ```

1. When prompted, enter the password for your certificate.

1. To verify that the certificate was imported successfully, run the following command, replacing `yourcertsubject` with the subject of your certificate:

   ```powershell
   Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object { $_.Subject -like "yourcertsubject" }
   ```

## Bind the certificate

After importing the certificate, bind it to the server port so the DNS Server can use it for HTTPS connections.

1. Generate a new GUID and store it in a variable by running the following command:

   ```powershell
   $guid = New-Guid
   ```

1. Retrieve your certificate and store it in a variable by running the following command. Replace `<subject-name>` with the subject of your certificate:

   ```powershell
   $cert = Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object { $_.Subject -match "<subject-name>" }
   ```

1. Bind the certificate to the server port by running the following command:

   ```powershell
   netsh http add sslcert ipport=0.0.0.0:443 certhash=$($cert.Thumbprint) appid="{$guid}"
   ```

> [!TIP]
> To have the DNS Server service respond to DoH traffic on a specific IP address instead of all addresses, replace `0.0.0.0` with your desired IP address. The IP address must either be or resolve to the host contained in the SAN of your certificate. You can also replace `443` with a different port number.

## Verify the certificate binding

Confirm that your certificate is properly bound to the correct IP address and port.

1. Run the following command to display the SSL certificate bindings:

   ```powershell
   netsh http show sslcert
   ```

1. Verify the output shows your IP address and port, and that the certificate hash matches your thumbprint.

## Configure firewall rules

DoH uses a different TCP port than unencrypted DNS, so you need to configure your firewall to allow inbound traffic on the port you specified when binding the certificate. By default, DoH uses TCP port 443 unless you specified a different port in the URI template and certificate binding steps.

Configure Windows Firewall to allow inbound connections on the configured DoH port using the following steps:

1. To create a firewall rule that allows inbound DoH traffic, run the following command:

   ```powershell
   New-NetFirewallRule -DisplayName "DNS over HTTPS" -Direction Inbound -Protocol TCP -LocalPort 443 -Action Allow
   ```

1. Verify the firewall rule was created by running the following command:

   ```powershell
   Get-NetFirewallRule -DisplayName "DNS over HTTPS"
   ```

> [!NOTE]
> If you configured DoH to use a different port, replace `443` with your custom port number. If you're using a hardware firewall or network security group, ensure it also allows inbound TCP traffic on the same port.

## Enable the DoH

After you bind the certificate and configure firewall rules, enable the DoH on your DNS Server.

1. Enable DoH and set the URI template using the [Set-DnsServerEncryptionProtocol](/powershell/module/dnsserver/Set-DnsServerEncryptionProtocol) command. Replace `dns.contoso.com` with the hostname (or IP address) contained in the SAN on your certificate:

   ```powershell
   Set-DnsServerEncryptionProtocol -EnableDoh $true -UriTemplate "https://dns.contoso.com:443/dns-query"
   ```

   > [!NOTE]
   > Ensure the port number in the URI template matches the port number you used when binding the certificate.

1. Restart the DNS service to apply the changes:

   ```powershell
   Restart-Service -Name DNS
   ```

## Verify DoH configuration

Test that DoH is working correctly by verifying the configuration and testing from a client.

1. Verify the DoH configuration on the server using the [Get-DnsServerEncryptionProtocol](/powershell/module/dnsserver/Get-DnsServerEncryptionProtocol) command:

   ```powershell
   Get-DnsServerEncryptionProtocol
   ```

1. Open **Event Viewer** on the server and navigate to **Applications and Services Logs > DNS Server**.

1. Check for event ID `822`, which indicates that the DoH service started successfully.

### Test DoH from a client

To confirm that DoH is functioning correctly, test DNS resolution from a DoH-capable client.

1. Configure a DoH client to use encryption for your DNS server with the same URI template you configured. For client configuration steps, see [Secure DNS Client over HTTPS (DoH)](doh-client-support.md).

1. From the configured DoH client, test DNS resolution using the [Resolve-DnsName](/powershell/module/dnsclient/Resolve-DnsName) command. Replace `contoso.com` with a domain you want to resolve:

   ```powershell
   Resolve-DnsName -Name contoso.com -Type A
   ```

1. The DNS query resolves successfully.

To further verify DoH activity, follow the next steps article to monitor DoH on your DNS Server.

## Next steps

> [!div class="nextstepaction"]
> [Monitor DNS over HTTPS in DNS Server](monitor-dns-over-https.md)