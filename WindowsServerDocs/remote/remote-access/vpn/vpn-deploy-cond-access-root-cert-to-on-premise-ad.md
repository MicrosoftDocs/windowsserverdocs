---
title: Configure your Conditional Access policy
description: 'After a root certificate has been created, the 'VPN connectivity' triggers the creation of the 'VPN Server' cloud application in the customer's tenant.'
services: active-directory
ms.prod: windows-server-threshold
ms.technology: networking-ras
documentationcenter: ''
ms.assetid: 
ms.service: active-directory
ms.workload: identity
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 05/15/2018
ms.author: pashort
author: shortpatti
manager: elizapo
ms.reviewer: jairoc
---


# Deploy Conditional Access root certificates to on-premise AD

1. On the **VPN connectivity** page, click **Download certificate**. 
   
    ![Download certificate for conditional access](../../media/Always-On-Vpn/06.png)

    >[!NOTE]
    >The **Download base64 certificate** option is available for some configurations that require base64 certificates for deployment. 

2. On your VPN server, add the downloaded certificate as a *trusted root CA for VPN authentication*.

3. (Optional) For Windows RRAS-based deployments, on your NPS server, add the root certificate into the *Enterprise NTauth* store by running the following commands:

    1.  `certutil -dspublish <CACERT> RootCA`

    2.  `certutil -dspublish <CACERT> NtAuthCA`

4. On the VPN Server, sign in as **Enterprise Administrator**, open Windows PowerShell as **Administrator**, and run the following commands to import the root certificates to the VPN server and VPN clients:

    |Command  |Description  |  
    |---------|-------------| 
    |`certutil -dspublish -f VpnCert.cer RootCA`     |Creates two **Microsoft VPN root CA gen 1** containers under the **CN=AIA** and **CN=Certification Authorities** containers, and publishes each root certificate as a value on the _cACertificate_ attribute of both **Microsoft VPN root CA gen 1** containers.|  
    |`certutil -dspublish -f VpnCert.cer NTAuthCA`   |Creates one **CN=NTAuthCertificates** container under the **CN=AIA** and **CN=Certification Authorities** containers, and publishes each root certificate as a value on the _cACertificate_ attribute of the **CN=NTAuthCertificates** container. |  
    |`gpupdate /force`     |Expedites adding the root certificates to the Windows server and client computers.  |
    
    These commands publish the root certificate to the **CN=Certification Authorities** and **CN=AIA** containers in the Configuration naming context. Once the CN=Configuration naming context has replicated to all domain controllers in the forest, Windows 10 clients add the root certificate to their trusted root authorities container when Group Policy refreshes.

5.  Verify that the root certificates are present and show as trusted:

    1.  On the VPN server, in the Start menu, type **pkiview.msc** to open the Enterprise PKI dialog.

    2.  Right-click **Enterprise PKI** and select **Manage AD Containers**.

    3.  Verify that each Microsoft VPN root CA gen 1 certificate is present under:

        -   NTAuthCertificates

        -   AIA Container

        -   Certificate Authorities Container

## Next step

