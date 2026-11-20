---
title: Certificate Management for Windows Admin Center
description: Learn how to manage gateway and agent certificates in Windows Admin Center Virtualization Mode by using Active Directory Certificate Services.
#customer intent: As a system administrator, I want to manage gateway and agent certificates with Active Directory Certificate Services so that Windows Admin Center Virtualization Mode uses automatically enrolled and renewed certificates.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 10/15/2026
ai-usage: ai-assisted
---
# Manage certificates in Windows Admin Center Virtualization Mode

Windows Admin Center Virtualization Mode uses certificates to protect browser connections to the gateway and authenticate managed nodes. Managing these certificates helps you maintain secure access and prevent expired agent certificates from causing node connection failures.

In this article, you configure the gateway certificate, use Active Directory Certificate Services (AD CS) to manage agent certificates throughout their lifecycle, and set alerts so that you can act before certificates expire.

## Understand gateway serving and agent client certificate roles

Windows Admin Center Virtualization Mode uses two customer-relevant certificate roles:

- The **gateway serving certificate** protects HTTPS traffic between browsers and the gateway. Windows Admin Center doesn't enroll this certificate. You supply an eligible Personal Information Exchange (PFX) file or select an eligible certificate in the gateway's `LocalMachine\My` certificate store.
- The **agent client certificate** authenticates each managed node's Windows Admin Center agent to the gateway. Windows Admin Center can self-sign the certificate, or AD CS can issue it.

The **Renew certificate** command doesn't renew the gateway serving certificate. It uses the agent-certificate management mode that you configure on the gateway: Windows Admin Center creates another self-signed certificate set in self-signed mode, or adopts a newer certificate that AD CS computer autoenrollment places on the managed node in AD CS mode.

## Prerequisites

- Windows Admin Center Virtualization Mode installed and running. For more information, see [Install Windows Admin Center Virtualization Mode](deploy/install.md).
- Administrator access to configure certificate management. Changing certificate-expiry alert thresholds requires the **Fabric Manager** role.
- For AD CS certificate management, an Active Directory domain with an enterprise certification authority (CA). The gateway and managed nodes require domain connectivity and must trust the CA chain.
- A gateway serving certificate supplied as a PFX or installed in the gateway's `LocalMachine\My` certificate store. Windows Admin Center doesn't enroll this certificate. The certificate must:
  - Have an associated private key.
  - Be within its validity period.
  - Include the Server Authentication enhanced key usage (EKU) or have no EKU restriction.
  - Use RSA with a key size of at least 2,048 bits or elliptic curve digital signature algorithm (ECDSA) with a key size of at least 256 bits.
  - Chain to a root CA trusted by the gateway.
  - Include a subject alternative name (SAN) that covers the gateway's fully qualified domain name (FQDN).
- A custom agent client certificate template that meets these requirements:
  - Includes the Client Authentication EKU and doesn't include Server Authentication.
  - Builds the subject name from Active Directory information instead of allowing requesters to supply it in the request.
  - Is published on the enterprise CA.
  - Supports RSA and accepts the 2,048-bit key that Windows Admin Center requests without requiring a larger key.
  - Grants **Read** and **Enroll** permissions to each managed node's computer object. Windows Admin Center uses the selected template to enroll the agent certificate on the node during onboarding or automatic migration.
  - For AD CS autoenrollment renewal, the template grants **Autoenroll** permission to each managed node's computer object, and Group Policy enables computer certificate autoenrollment.

To learn how to create, publish, and assign permissions to certificate templates, see [Certificate template concepts](../../identity/ad-cs/certificate-template-concepts.md) and [Manage certificate templates](../../identity/ad-cs/manage-certificate-templates.md).

## Configure and apply AD CS certificate management

Configure the gateway serving certificate, select the custom client certificate template that Windows Admin Center uses to enroll agent certificates, and apply the configuration. Applying the gateway certificate restarts the gateway and signs you out.

1. Sign in to Windows Admin Center Virtualization Mode as an administrator.

1. Open the gateway settings, and then select **Certificates**.

    :::image type="content" source="media/manage-virtualization-mode-certificates/configure-ad-cs.png" alt-text="Screenshot of Windows Admin Center Certificates settings with AD CS selected, the gateway certificate validated, and the client template menu open." lightbox="media/manage-virtualization-mode-certificates/configure-ad-cs.png":::

1. Select **Manage Windows Admin Center certificates using Active Directory Certificate Services**.

1. Under **Certificate source**, supply the gateway certificate by using one of these options:

    - Select **Upload a certificate (.pfx)**, select the `.pfx` file, and enter its **Passphrase**.
    - Select **Use an installed certificate**, and then under **Installed certificate**, select an eligible certificate. Windows Admin Center reads installed certificates from the gateway's `LocalMachine\My` certificate store.

1. Wait for Windows Admin Center to validate the selected or uploaded certificate automatically. When validation succeeds, the page shows **AD CS certificate recognized. Configure the agent certificate template below.**

1. Under **Client certificate template**, select an eligible custom template that the interface discovers. The template must include the Client Authentication EKU without Server Authentication, build the subject name from Active Directory, and accept 2,048-bit RSA keys. Your enterprise CA must publish the template. Each managed node's computer object must have **Read** and **Enroll** permissions. For AD CS autoenrollment renewal, also grant **Autoenroll** permission and enable computer certificate autoenrollment through Group Policy.

1. Select **Apply and restart**.

1. In the **Apply certificate?** dialog, select **Apply & sign out**.

1. Wait for the gateway to apply the certificate and restart. The page shows **The gateway is applying the new certificate and restarting.**

1. On the sign-in page, sign in again after the gateway restarts.

1. Open **Certificates**, and then confirm that the page lists the expected gateway certificate and client certificate template.

## Migrate agent client certificates to AD CS automatically on reconnect

Each time an agent reconnects, the gateway evaluates whether to migrate its self-signed agent certificate to AD CS. Automatic migration starts only if all these conditions are true:

- You configure the gateway to manage agent certificates with AD CS.
- The resource record in the gateway's management database still identifies the agent certificate as self-signed.
- The gateway settings contain an eligible agent client certificate template.
- No conflicting certificate renewal is running for the agent.
- Fewer than eight agent certificate migration workflows are running.

Don't preinstall the AD CS agent certificate or select **Renew certificate**. When the agent reconnects, Windows Admin Center requests the certificate from AD CS by using the selected template. Windows Admin Center then applies the certificate and restarts the agent. If migration can't start or complete, Windows Admin Center tries again the next time the agent reconnects.

1. Allow the managed node to reconnect to the gateway.

1. Open **Workflow status**, and then select the workflow for the node.

1. Confirm that the workflow status is **Complete**. The workflow includes **Enroll agent AD CS certificates** and **Swap agent AD CS certificates**.

## Renew an agent certificate manually

The **Renew certificate** command uses the gateway's agent-certificate management mode. In self-signed mode, Windows Admin Center creates and deploys a new self-signed certificate set. In AD CS mode, Windows Admin Center looks for a newer certificate that computer autoenrollment already placed on the managed node. The command doesn't renew the gateway serving certificate or migrate a self-signed agent certificate to AD CS. Windows Admin Center evaluates migration automatically when an agent reconnects.

### Renew a self-signed agent certificate

Use this procedure when the gateway manages agent certificates in self-signed mode.

1. In the navigation pane, open the node's context menu (ellipsis), and then select **Get agent health**.

1. In the agent health detail pane, find the certificate card, and then select **Renew certificate**. The **Renew certificate for \<node\>** dialog appears.

1. In the dialog, select **Renew certificate**.

1. In **Workflow status**, track the workflow and confirm that it completes and the agent reconnects to the gateway with the new self-signed certificate.

If the renewal fails, Windows Admin Center rolls back to the previous self-signed certificate set so the agent can continue to connect.

### Adopt an autoenrolled AD CS agent certificate

The manual renewal action doesn't request a certificate from AD CS. It detects and adopts a newer client certificate that native AD CS autoenrollment already placed in the managed node's `LocalMachine\My` certificate store. If no newer certificate exists, the action intentionally makes no change and tells you to try again after enrollment.

1. Confirm that a newer eligible client certificate is present in `LocalMachine\My` on the managed node as a result of certificate autoenrollment.

1. In the navigation pane, open the node's context menu (ellipsis), and then select **Get agent health**.

1. In the agent health detail pane, find the certificate card, and then select **Renew certificate**. The **Renew certificate for \<node\>** dialog appears.

1. In the dialog, select **Renew certificate**.

1. In **Workflow status**, track the workflow and confirm that it adopts the newer certificate. The workflow details show **Detect renewed agent certificates**, **Adopt agent AD CS certificates**, and **Finalize agent certificate renewal** as completed.

    :::image type="content" source="media/manage-virtualization-mode-certificates/renewal-workflow-complete.png" alt-text="Screenshot of Windows Admin Center showing the Certificate renewed successfully notification and all renewal workflow steps completed." lightbox="media/manage-virtualization-mode-certificates/renewal-workflow-complete.png":::

During adoption, the workflow moves the previous agent certificate to the agent's certificate backup store and temporarily configures the gateway to accept both identities across the restart. If adoption fails, the workflow preserves the new autoenrolled certificate for a later retry.

## Onboard a node with an AD CS certificate

To onboard a node with an AD CS certificate, first configure the Windows Admin Center Virtualization Mode gateway to manage agent certificates with AD CS and select a published, eligible agent client certificate template. Verify that the gateway and managed node can connect to the domain, can reach the enterprise CA, and trust its CA chain. Grant the managed node's computer object **Read** and **Enroll** permissions on the selected template.

During onboarding, Windows Admin Center uses the selected template to enroll the agent client certificate locally on the managed node before it installs the agent. Complete the steps in [Add resources in Windows Admin Center Virtualization Mode](add-virtualization-mode-resources.md).

## Configure certificate-expiry alerts

The gateway applies certificate-expiry alerts to every agent it manages. Each profile defines three thresholds that the gateway evaluates in **Information**, **Warning**, and **Critical** order as the certificate approaches expiration.

| Profile | Information | Warning | Critical |
| --- | ---: | ---: | ---: |
| **Early notice** | 90 days | 60 days | 30 days |
| **Standard (recommended and default)** | 30 days | 15 days | 7 days |
| **Just-in-time** | 15 days | 7 days | 1 day |

1. Sign in with the **Fabric Manager** role.

1. Open the gateway settings, and then select **Certificates**.

1. In the agent certificate-expiry alert settings, select **Early notice**, **Standard**, or **Just-in-time**.

1. Apply the change, and then confirm that the selected thresholds appear in the certificate settings.

## Troubleshoot certificate management

Use the following guidance to troubleshoot certificate management. For agent failures, gather diagnostics by using **Get agent logs** and **Get agent health** from the resource context menu.

- **The enterprise CA can't be reached**: Verify that the gateway and managed node have domain connectivity, can locate an enterprise CA, and trust the CA chain. Enrollment can't continue without an available enterprise CA.
- **No eligible client certificate template appears**: Verify that an enterprise CA publishes the template and that it meets every client certificate requirement in [Prerequisites](#prerequisites). In particular, check the EKUs, subject name source, RSA support, and minimum key-size requirement.
- **Agent enrollment is denied**: Verify that the managed node's computer object has **Read** and **Enroll** on the selected agent client certificate template. For AD CS autoenrollment renewal, also verify **Autoenroll** and the computer autoenrollment Group Policy setting. Windows Admin Center enrollment runs locally on the managed node, not on the gateway.
- **Automatic migration doesn't start**: Confirm that the agent reconnects and that the gateway manages agent certificates with AD CS. Verify that the resource record in the gateway's management database still identifies the agent certificate as self-signed, that gateway settings contain an eligible client template, and that no renewal is in progress. If eight migrations are running, keep the node available so Windows Admin Center can retry when the agent reconnects.
- **Self-signed renewal fails**: Open **Workflow status** to identify the failed step. Use **Get agent health** and **Get agent logs** to investigate. Windows Admin Center rolls back to the previous self-signed certificates on failure. Resolve the reported problem, and then retry **Renew certificate**.
- **AD CS renewal finds no newer certificate**: Verify that AD CS computer autoenrollment placed a newer eligible certificate in the managed node's `LocalMachine\My` store. If none exists, no renewal occurs. Resolve autoenrollment, wait for enrollment, and then retry **Renew certificate**.
- **The gateway certificate switch fails validation**: Verify that the PFX or installed `LocalMachine\My` certificate has a private key, is currently valid, meets the RSA or ECDSA key-size requirement, has Server Authentication or no EKU restriction, chains to a trusted root, and has a SAN that covers the gateway FQDN.
- **A certificate workflow fails**: Open **Workflow status** and select the workflow for the node to identify the failed step. Use **Get agent health** and **Get agent logs** to investigate before the next retry.

## Next steps

> [!div class="nextstepaction"]
> [Add resources in Windows Admin Center Virtualization Mode](add-virtualization-mode-resources.md)
