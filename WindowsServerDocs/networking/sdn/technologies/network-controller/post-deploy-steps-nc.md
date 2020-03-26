---
title: Post-Deployment Steps for Network Controller
description: This topic provides certificate configuration instructions for non-Kerberos deployments of Network Controller in Windows Server 2016 Datacenter.
manager: brianlic
ms.prod: windows-server
ms.technology: networking-sdn
ms.topic: article
ms.assetid: eea0aca9-8d89-48fb-8068-fca40c90d34b
ms.author: lizross
author: eross-msft
---
# Post-Deployment Steps for Network Controller

When you install Network Controller, you can choose Kerberos or non-Kerberos deployments.

For non\-Kerberos deployments, you must configure certificates.

## Configure certificates for non-Kerberos deployments

If the computers or virtual machines \(VMs\) for Network Controller and the management client are not domain\-joined, you must configure certificate\-based authentication by completing the following steps.

- Create a certificate on the Network Controller for Computer authentication. The certificate subject name must be same as the DNS name of the Network Controller computer or VM.

- Create a certificate on the management client. This certificate must be trusted by the Network Controller.
  
- Enroll a certificate on the Network Controller computer or VM. The certificate must meet the following requirements.
  
    -  Both the Server Authentication purpose and the Client Authentication purpose must be configured in Enhanced Key Usage \(EKU\) or Application Policies extensions. The object identifier for Server Authentication is 1.3.6.1.5.5.7.3.1. The object identifier for Client Authentication is 1.3.6.1.5.5.7.3.2.
  
    - The certificate subject name should resolve to:
  
        - The IP address of the Network Controller computer or VM, if Network Controller is deployed on a single computer or VM.

        - The REST IP address, if Network Controller is deployed on multiple computers, multiple VMs, or both.
  
    - This certificate must be trusted by all the REST clients. The certificate must also be trusted by the Software Load Balancing (SLB) Multiplexer (MUX) and the southbound host computers that are managed by Network Controller.
  
    - The certificate can be enrolled by a Certification Authority (CA) or can be a self-signed certificate. Self-signed certificates are not recommended for production deployments, but are acceptable for test lab environments.
  
    - The same certificate must be provisioned on all the Network Controller nodes. After creating the certificate on one node, you can export the certificate (with private key) and import it on the other nodes.

For more information, see [Network Controller](Network-Controller.md).
