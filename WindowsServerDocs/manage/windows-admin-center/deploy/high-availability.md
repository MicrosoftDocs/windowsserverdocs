---
title: Deploy Windows Admin Center High Availability
description: Learn how to deploy a highly available Windows Admin Center Administration Mode gateway on a failover cluster for resilient server management.
ms.topic: install-set-up-deploy
author: davannaw-msft
ms.author: dawhite
ms.date: 06/23/2025
ai-usage: ai-assisted
---

# Deploy Windows Admin Center in Administration Mode with high availability

You can deploy a Windows Admin Center Administration Mode gateway in a failover cluster to provide high availability. This article applies to Administration Mode deployments and doesn't provide high availability guidance for Virtualization Mode. This solution is active-passive, where only one instance of Windows Admin Center is active. If one of the nodes in the cluster fails, Windows Admin Center fails over to another node so that you can continue managing the servers in your environment.

Learn about [other Windows Admin Center deployment options](../plan/installation-options.md).

> [!IMPORTANT]
> Windows Admin Center versions 2311 and older don't support direct upgrades from high-availability deployments to versions 2410 and newer because of architectural changes. To upgrade, you must uninstall and reinstall Windows Admin Center.

## Prerequisites for Windows Admin Center high availability

- High-availability deployment scripts from the [Windows Admin Center HA Script zip file](https://aka.ms/WACHAScript). Download the .zip file containing the scripts to your local machine. Then copy the deployment script as needed based on the guidance in this article.
- A failover cluster of two or more nodes running on Windows Server 2016 or later. Learn more about [how to deploy a failover cluster](../../../failover-clustering/failover-clustering-overview.md).
- A cluster shared volume (CSV) for Windows Admin Center to store persistent data that all the nodes in the cluster can access. Your CSV needs only 10 GB.
- A certificate thumbprint from a certificate from a valid certificate authority (CA) with the private key installed on every node.

> [!NOTE]
> The `Deploy-GatewayV2Ha.zip` file contains the following scripts:
>
> - `Deploy-GatewayV2Ha.Deploy.ps1`
> - `Deploy-GatewayV2Ha.Validate.ps1`
> - `Deploy-GatewayV2Ha.Inspect.ps1`
> - `Deploy-GatewayV2Ha.Uninstall.ps1`

## Install Windows Admin Center on a failover cluster

1. Copy the `Deploy-GatewayV2Ha.Deploy.ps1` script to a node in your cluster. Download or copy the Windows Admin Center `.exe` file to the same node.
1. Connect to the node via Remote Desktop Protocol, go to the folder that contains the script, and run the `Deploy-GatewayV2Ha.Deploy.ps1` script as an administrator with the following parameters:
    - `-clusterStorage`: The local path of the CSV to store Windows Admin Center data.
    - `-clientAccessPoint`: The name that you use to access Windows Admin Center. For example, if you run the script with the parameter `-clientAccessPoint contosoWindowsAdminCenter`, you access the Windows Admin Center service by visiting `https://contosoWindowsAdminCenter.<domain>.com`.
    - `-staticAddress`: Optional. One or more static addresses for the cluster generic service.
    - `-InstallerPath`: The path for the Windows Admin Center `.exe` file.
    - `-CertificateThumbprint`: A Transport Layer Security certificate thumbprint present on every node.
    - `-generateSslCert`: Optional. If you don't want to provide a signed certificate, include this parameter flag to generate a self-signed certificate. The self-signed certificate expires in 60 days.
    - `-HttpsPort`: Optional. If you don't specify a port, the gateway service is deployed on port 443 (HTTPS). To use a different port, specify in this parameter. If you use a custom port instead of 443, you access the Windows Admin Center by going to `https://\<clientAccessPoint\>:<port>`.

> [!NOTE]
> The `Deploy-GatewayV2Ha.Deploy.ps1` script supports `-WhatIf` and `-Verbose` parameters.

To perform further lifecycle operations on your high-availability installation, ensure that all scripts from the `Deploy-GatewayV2Ha.zip` file are present on all nodes.

### Example deployment script for a highly available Windows Admin Center gateway

```powershell
$parameters = @{
  ClusterStorage = "C:\ClusterStorage\Volume1\Gateway"
  ClientAccessPoint = gateway-ha
  StaticAddress = '10.0.0.50'
  InstallerPath = "C:\Installers\WindowsAdminCenter2511.exe"
  CertificateThumbprint = "AA11BB22CC33DD44EE55FF66AA77BB88CC99DD00"
}
Deploy-GatewayV2Ha.Deploy @parameters
```

## Update an existing high-availability installation

Use the same `Deploy-GatewayV2Ha.Deploy.ps1` script to update your high-availability deployment, without losing your connection data.

### Update to a new version of Windows Admin Center

When a new version of Windows Admin Center is released, run the `Deploy-GatewayV2Ha.Deploy.ps1` script again with the updated executable specified in the `-InstallerPath` parameter:

```powershell
$parameters = @{
  ClusterStorage = "C:\ClusterStorage\Volume1\Gateway"
  ClientAccessPoint = gateway-ha
  StaticAddress = '10.0.0.50'
  InstallerPath = "C:\Installers\WindowsAdminCenter2511new.exe"
  CertificateThumbprint = "AA11BB22CC33DD44EE55FF66AA77BB88CC99DD00"
}
Deploy-GatewayV2Ha.Deploy @parameters
```

You can also update the certificate when you update the Windows Admin Center platform by using a new `.exe` file.

### Update the certificate used by Windows Admin Center

You can update the certificate used by a high-availability deployment of Windows Admin Center at any time by using the `-UpdateCertificate` flag.

```powershell
$parameters = @{
  UpdateCertificate = $true
  ClusterStorage = "C:\ClusterStorage\Volume1\Gateway"
  ClientAccessPoint = gateway-ha
  CertificateThumbprint = "AA11BB22CC33DD44EE55FF66AA77BB88CC99DD00"
}
Deploy-GatewayV2Ha.Deploy @parameters
```

## Uninstall the high-availability deployment

To uninstall the high-availability deployment of Windows Admin Center from your failover cluster, run the `Deploy-GatewayV2Ha.Uninstall.ps1` script.

```powershell
$parameters = @{
  ClusterStorage = "C:\ClusterStorage\Volume1\Gateway"
  ClientAccessPoint = gateway-ha
}
Deploy-GatewayV2Ha.Uninstall @parameters
```

## Troubleshoot a highly available Windows Admin Center gateway

Logs are saved in the temp folder of the CSV. An example is `C:\ClusterStorage\Volume1\temp`.

If needed, you can run diagnostics by passing `Diagnostics` by using the `-Mode` flag in the `Deploy-GatewayV2Ha.Inspect.ps1` script. The following example shows running the diagnostic collection for the last 24 hours on a cluster:

```powershell
$parameters = @{
  Mode = Diagnostics
  ClusterStorage = "C:\ClusterStorage\Volume1\Gateway"
  ClientAccessPoint = gateway-ha
  DiagnosticLookbackHours = 24
  DiagnosticsOutputPath = "C:\Temp\wac-ha-diag"
}
Deploy-GatewayV2Ha.Inspect @parameters
```
