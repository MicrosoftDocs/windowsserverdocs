---
title: Configure SMB over QUIC client access control in Windows Insider (preview)
description: Learn how to use SMB over QUIC client access control in Windows Insider
ms.topic: how-to
author: gswashington
ms.author: nedpyle
ms.date: 02/29/2024

---

# Configure SMB over QUIC client access control in Windows Insider (preview)

>Applies to: Windows and Windows Server Insider builds

> [!IMPORTANT]
> Windows Insider and Windows Server Insider builds are in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Server Message Block protocol (SMB) over the QUIC transport layer network protocol introduces an alternative to the Transmission Control Protocol (TCP) network transport, providing secure, reliable connectivity to edge file servers over untrusted networks like the Internet. QUIC is an Internet Engineering Task Force (IETF)-standardized protocol with many benefits when compared with TCP.

+This article explains how to configure SMB over QUIC Client Access Control (CAC) in Windows and Windows Server Insider builds. For more detailed information, see [SMB over QUIC](../file-server/smb-over-quic.md).

>[!IMPORTANT]
>SMB over QUIC isn't enabled by default. A file server administrator must opt in to enable SMB over QUIC. A client can't force a file server to enable SMB over QUIC.

## SMB over QUIC Client Access Control

SMB over QUIC CAC controls access by making any client trying to access a server require a shared root authority key. The admin issues this certificate to the client and adds its hash to an allow list maintained by the server. When the client tries to connect to the server, the server compares its certificate info against the allow list. If the certificate is valid, the server certificate creates a TLS 1.3-encrypted tunnel over UDP port 443 and grants the client access to the share.

SMB over QUIC CAC supports using certificates with subject alternative names, not just a single subject. This means the client access control feature supports using a Microsoft AD Certificate Authority and multiple endpoint names, just like the currently released version of SMB over QUIC. You can evaluate the feature using the recommended options and not require self-signed test certificates.

You can also configure SMB over QUIC to block access by revoking certificates or explicitly denying certain devices or users access. For example, you can configure SMB over QUIC to block connection requests from third-party users or unsupported devices that use earlier, less secure SMB dialects.

## Prerequisites

Before you can configure SMB over QUIC CAC, you need the following things:

- An SMB QUIC server running on one of the following operating systems:
  - A machine running Windows Server Insiders build 25075 or later.
  - A virtual machine (VM) running Windows Server vNext Azure Edition Preview Build 25977 or later.
    - You can run Windows Server Azure Edition outside of Azure IaaS and Azure Stack HCI for evaluation and testing purposes.
- - A client running Windows 11 Insider Preview Build 25977 (Canary Channel) or later.
- Administrative privileges for the network you're configuring.
- If you're using Group Policy on a domain, you need privileges to create or edit a Group Policy object (GPO) and link it to the appropriate organizational unit (OU).

> [!NOTE]
> We recommended using SMB over QUIC with Active Directory domains, however it isn't required. You can also use SMB over QUIC on a workgroup-joined server with local user credentials and NTLM.

## Configure SMB over QUIC CAC using PowerShell

To configure SMB over QUIC CAC using PowerShell:

# [PowerShell](#tab/powershell)

1. Download the [Microsoft Server Operating System Preview](https://aka.ms/ws2022ae) and use it to deploy Windows Server 2022 Datacenter: Azure Edition.

1. Install the latest version of Windows Admin Center on a management PC or the file server.

1. When you first open Windows Admin Center, go to **Settings** > **Extensions** and make sure you have **Automatically update extensions** enabled.

1. Join your Windows Server 2022 Datacenter: Azure Edition file server to your Active Directory domain and make it accessible to Windows Insider clients on the Azure public interface by adding a firewall allow rule for the inbound UDP 443 port.

#### [Windows Server](#tab/windows-server)

<!--- Hi Robin, instructions on how to do this should go here. Attempting to find some guidance on this but have found nothing satisfactory; do you know of anything usable? Or do you think it's necessary for this article to explain how to do this?-->

   >[!NOTE]
   >Don't allow the inbound TCP 445 port access to the file server. The file server must have access to at least one domain controller for authentication, but no domain controller requires any internet access.

#### [PowerShell](#tab/powershell)

1. Connect to the server with Windows Admin Center and select the **Settings** icon in the lower left corner of the window.

1. In the **File shares (SMB server)** section, under **File sharing across the internet with SMB over QUIC**, select **Configure**.

1. Go to **Select a computer certificate for this file server** and select the certificate you want to use. 

1. After that, select the server addresses clients you want to allow clients to use this certificate to connect to. If you want this certificate to connect to any address, select **Select all**, as shown in the following screenshot.

    :::image type="content" source="./media/smb-over-quic-cac/wac1.png" alt-text="image showing the steps for configure SMB over QUIC1":::

1. When you're finished, select **Enable**.

1. Ensure that the certificate and SMB over QUIC report are healthy.
<!-- Robin, can more specific guidance on how to verify be provided here or linked to? Heidi has asked a very good question. -->

    :::image type="content" source="./media/smb-over-quic-cac/wac2.png" alt-text="image showing the steps for configure SMB over QUIC2":::

1. Select **Files and File Sharing**. If you have existing SMB shares, write down their names for later. If not, create a new one.

For a demonstration of configuring and using SMB over QUIC, watch this video:

> [!VIDEO https://www.youtube.com/embed/OslBSB8IkUw]

<!-- Heidi observes that it feels disruptive to suddenly pivot to video and I think she has a point; that's something a blog can do without too much awkwardness but -- is there a Learn article we can link to here? Searching ... -->

1. From an elevated PowerShell prompt on the SMB over QUIC server, run the following commands to 

1. Obtain client certificate SHA256 hash by running certutil to examine the Cert Hash(sha256) field:

```powershell
Export-Certificate -Cert $clientCert -FilePath path\clientCert.cer
```

```powershell
certutil.exe path\clientCert.cer | findstr /i /c:"Cert Hash(sha256)"
```

---

1. When you're finished, test whether you can connect to the server by running one of the following commands:

<!-- Thanks Heidi; I am not clear on why two commands are provided and what drives using one over the other.  -->

```powershell
NET USE \\server DNS name\share /TRANSPORT:QUIC
```

or, 

```powershell
New-SmbMapping -RemotePath \\server DNS name\share -TransportType QUIC
```

---

SMB over QUIC CAC is configured.

## Related content

- [SMB over QUIC](/file-server/smb-over-quic)

- [Storage at Microsoft blog](https://aka.ms/FileCab)

- [QUIC Working Group homepage](https://quicwg.org/)

- [Microsoft MsQuic GitHub homepage](https://github.com/microsoft/msquic)

- [QUIC Wikipedia](https://en.wikipedia.org/wiki/QUIC)

- [TLS 1.3 Working Group homepage](https://tlswg.org/)