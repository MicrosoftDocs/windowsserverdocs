---
title: Deploy Conditional Access root certificates to on-premises AD
description: ''
services: active-directory
ms.prod: windows-server-threshold
ms.technology: networking-ras
documentationcenter: ''
ms.assetid: 
ms.workload: identity
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 05/25/2018
ms.author: pashort
author: shortpatti
ms.localizationpriority: medium 
ms.reviewer: deverette
---


# Step 7.4. Deploy conditional access root certificates to on-premises AD

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

In this step, you deploy the conditional access root certificate as trusted root certificate for VPN authentication to your on-premises AD.

&#171; [**Previous:** Step 7.3. Configure the Conditional Access policy](vpn-config-conditional-access-policy.md)<br>
&#187; [**Next:** Step 7.5. Create OMA-DM based VPNv2 Profiles to Windows 10 devices](vpn-create-oma-dm-based-vpnv2-profiles.md)

1. On the **VPN connectivity** page, click **Download certificate**. 
   
    ![Download certificate for conditional access](../../media/Always-On-Vpn/06.png)

    >[!NOTE]
    >The **Download base64 certificate** option is available for some configurations that require base64 certificates for deployment. 

2. Log on to a domain-joined computer with Enterprise Admin rights and run these commands from an Administrator command prompt to add the cloud root certificate(s) into the *Enterprise NTauth* store:

    >[!NOTE]
    >For environments where the VPN server is not joined to the Active Directory domain, the cloud root certificates must be added to the _Trusted Root Certification Authorities_ store manually.

    |Command  |Description  |  
    |---------|-------------| 
    |`certutil -dspublish -f VpnCert.cer RootCA`     |Creates two **Microsoft VPN root CA gen 1** containers under the **CN=AIA** and **CN=Certification Authorities** containers, and publishes each root certificate as a value on the _cACertificate_ attribute of both **Microsoft VPN root CA gen 1** containers.|  
    |`certutil -dspublish -f VpnCert.cer NTAuthCA`   |Creates one **CN=NTAuthCertificates** container under the **CN=AIA** and **CN=Certification Authorities** containers, and publishes each root certificate as a value on the _cACertificate_ attribute of the **CN=NTAuthCertificates** container. |  
    |`gpupdate /force`     |Expedites adding the root certificates to the Windows server and client computers.  |

3.  Verify that the root certificates are present in the Enterprise NTauth store and show as trusted:

    a.  Log on to a server with Enterprise Admin rights that has the **Certificate Authority Management Tools** installed.

    >[!NOTE]
    >By default the **Certificate Authority Management Tools** are installed Certificate Authority servers. They can be installed on other members servers as part of the **Role Administration Tools** in Server Manager.

    b.  On the VPN server, in the Start menu, type **pkiview.msc** to open the Enterprise PKI dialog.

    c.  From the Start menu, type **pkiview.msc** to open the Enterprise PKI dialog.

    d.  Right-click **Enterprise PKI** and select **Manage AD Containers**.

    d.  Verify that each Microsoft VPN root CA gen 1 certificate is present under:<ul><li>NTAuthCertificates</li><li>AIA Container</li><li>Certificate Authorities Container</li></ul>

    
## Next step
[Step 7.5. Create OMA-DM based VPNv2 Profiles to Windows 10 devices](vpn-create-oma-dm-based-vpnv2-profiles.md): In this step, you can create OMA-DM based VPNv2 profiles using Intune to deploy a VPN Device Configuration policy. If you want to SCCM or PowerShell Script to create VPNv2 profiles, see [VPNv2 CSP settings](https://docs.microsoft.com/windows/client-management/mdm/vpnv2-csp) for more details.

---
