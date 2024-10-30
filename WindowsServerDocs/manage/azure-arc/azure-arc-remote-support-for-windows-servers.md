---
title: How to configure remote support for Arc-enabled Windows servers (preview)
description: 
ms.topic: how-to
ms.author: alalve
author: trungtran
ms.date: 10/30/2024
---

# Configure Remote Support for Arc-enabled Windows servers

By enabling Remote Support (preview), you allow a Microsoft Support professional to resolve your issue faster by accessing your device remotely for troubleshooting. You have complete control over the level of access that Microsoft support professionals have, the duration of access, and your consent is required to access your device. Microsoft support can only access your device after you have submitted a support request. To learn how to create a request, see [Create an Azure support request](/azure/azure-portal/supportability/how-to-create-azure-support-request).

Once remote support is activated, Microsoft Support gains temporary access to your device. Access is made through a secure, audited, and compliant channel that uses HTTPS over port 443 with TLS 1.2 encrypted traffic. The actions Microsoft support professionals can perform are limited to what you allow, using [Just Enough Administration](/powershell/scripting/security/remoting/jea/overview) (JEA). This process involves authenticated access between you and Microsoft support for diagnostics, troubleshooting, and remediation actions.

To streamline setup and improve support issue resolution, the remote support arc extension can pre-install the remote support agent on all cluster nodes and support the configuration of scheduled tasks for JEA.

![The Just Enough Administrator remote support workflow.]()

## Prerequisites

- Your device must be running an Arc-enabled on-premises Windows Server 2016 or later operating system with a minimum of 4 GB of memory.
- If you’re new to Azure Arc, your device must be onboarded. To learn more, see [Quickstart: Connect hybrid machines with Azure Arc-enabled servers](/azure/azure-arc/servers/learn/quick-enable-hybrid-vm).

### Request remote support



## Remote support terms and conditions

The following terms and conditions outline how data will be handled during remote support sessions. Read them carefully before granting access.

1. By approving this request, you are granting the Microsoft support organization or the Azure engineering team supporting this feature ("Microsoft Support Engineer") direct access to your device for the purpose of troubleshooting and/or resolving the technical issue described in the Microsoft support case.

1. During a remote support session, a Microsoft Support Engineer may need to collect logs. By enabling remote support, you agree to allow a Microsoft Support Engineer to collect diagnostics logs to address a support case. You also acknowledge and consent to the upload and retention of those logs in an Azure storage account managed and controlled by Microsoft. These logs may be accessed by Microsoft for the purposes of a support case and to improve the health of Azure Stack HCI.

1. The data collected will only be used to troubleshoot failures that are subject to a support ticket and will not be used for marketing, advertising, or any other commercial purposes without your consent. Data retention is held up ninety (90) days and will be handled in accordance with our standard privacy practices.

1. Revoking your permission will not affect any data previously collected with your consent.

For more information about how Microsoft processes personal data, including what data is processed and for what purposes, please refer to the [Microsoft Privacy Statement](https://www.microsoft.com/privacy/privacystatement).
