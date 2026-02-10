---
title: Deploy Windows Admin Center with High Availability
description: Deploy Windows Admin Center with High Availability (Project Honolulu)
ms.topic: install-set-up-deploy
author: davannaw-msft
ms.author: dawhite
ms.date: 06/23/2025
---

# Deploy Windows Admin Center with high availability

You can deploy Windows Admin Center in a failover cluster to provide high availability for your Windows Admin Center gateway service. The solution provided is an active-passive solution, where only one instance of Windows Admin Center is active. If one of the nodes in the cluster fails, Windows Admin Center gracefully fails over to another node, letting you continue managing the servers in your environment seamlessly.

[Learn about other Windows Admin Center deployment options.](../plan/installation-options.md)

> [!IMPORTANT]
> Direct upgrades from high availability deployments in Windows Admin Center versions 2311 and older to versions 2410 and newer are not supported due to architectural changes. To upgrade, you must uninstall and reinstall Windows Admin Center. 

## Prerequisites

- High-availability deployment script from [Windows Admin Center HA Script zip file](https://aka.ms/WACHAScript). Download the .zip file containing the script to your local machine and then copy the script as needed based on the guidance in this article.
- A failover cluster of 2 or more nodes on Windows Server 2016, 2019, 2022 or 2025. [Learn more about deploying a Failover Cluster](../../../failover-clustering/failover-clustering-overview.md).
- A cluster shared volume (CSV) for Windows Admin Center to store persistent data that can be accessed by all the nodes in the cluster. 10 GB is sufficient for your CSV.
- A certificate thumbprint from a certificate from a valid certificate authority (CA). You don't need to have already installed the certificate on the cluster nodes - the script does that for you. 

## Install Windows Admin Center on a failover cluster

1. Copy the ```Install-WindowsAdminCenterHA.ps1``` script to a node in your cluster. Download or copy the Windows Admin Center .exe to the same node.
2. Connect to the node via RDP and run the ```Deploy-GatewayV2Ha.ps1``` script from that node with the following parameters:
    - `-clusterStorage`: the local path of the Cluster Shared Volume to store Windows Admin Center data.
    - `-clientAccessPoint`: choose a name that you'll use to access Windows Admin Center. For example, if you run the script with the parameter `-clientAccessPoint contosoWindowsAdminCenter`, you access the Windows Admin Center service by visiting `https://contosoWindowsAdminCenter.<domain>.com`
    - `-staticAddress`: Optional. One or more static addresses for the cluster generic service.
    - `-InstallerPath`: The path for the Windows Admin Center .exe file.
    - `-CertificateThumbprint`: TLS certificate thumbprint present on every node.
    - `-generateSslCert`: Optional. If you don't want to provide a signed certificate, include this parameter flag to generate a self-signed certificate. The self-signed certificate expires in 60 days.
    - `-HttpsPort`: Optional. If you don't specify a port, the gateway service is deployed on port 443 (HTTPS). To use a different port, specify in this parameter. If you use a custom port besides 443, you'll access the Windows Admin Center by going to https://\<clientAccessPoint\>:\<port\>.

> [!NOTE]
> The ```Deploy-GatewayV2Ha.ps1``` script supports ```-WhatIf``` and ```-Verbose``` parameters

### Example

```powershell
.\Deploy-GatewayV2Ha.ps1 -ClusterStorage "C:\ClusterStorage\Volume1\Gateway" -ClientAccessPoint gateway-ha
-StaticAddress '10.0.0.50' -InstallerPath "C:\Installers\ServerManagementGateway.exe"
-CertificateThumbprint "0123456789ABCDEF0123456789ABCDEF01234567"
```

## Update an existing high availability installation

Use the same ```Deploy-GatewayV2Ha.ps1``` script to update your HA deployment, without losing your connection data.

### Update to a new version of Windows Admin Center

When a new version of Windows Admin Center is released, run the ```Deploy-GatewayV2Ha.ps1``` script again with the updated executable specified in the ```InstallerPath``` parameter:

```powershell
.\Deploy-GatewayV2Ha.ps1 -Upgrade -ClusterStorage "C:\ClusterStorage\Volume1\Gateway" -ClientAccessPoint gateway-ha
-InstallerPath "C:\Installers\ServerManagementGateway.exe" -CertificateThumbprint "0123..." -Verbose
```

You may also update the certificate at the same time you update the Windows Admin Center platform with a new .exe file.

### Update the certificate used by Windows Admin Center

You can update the certificate used by a HA deployment of Windows Admin Center at any time by using the ```-UpdateCertificate``` flag.

```powershell
.\Deploy-GatewayV2Ha.ps1 -UpdateCertificate -ClusterStorage "C:\ClusterStorage\Volume1\Gateway"
-ClientAccessPoint gateway-ha -CertificateThumbprint "0123..." -Verbose
```

## Uninstall the high availability deployment

To uninstall the HA deployment of Windows Admin Center from your failover cluster, pass the ```-Uninstall``` parameter to the ```Deploy-GatewayV2Ha.ps1``` script.

```powershell
.\Deploy-GatewayV2Ha.ps1 -Uninstall -ClusterStorage "C:\ClusterStorage\Volume1\Gateway" -ClientAccessPoint gateway-ha
```

## Troubleshooting

Logs are saved in the temp folder of the CSV. For example, `C:\ClusterStorage\Volume1\temp`.

You can also manually run diagnostics by passing the ```-CollectDiagnostics``` parameter.

```powershell
.\Deploy-GatewayV2Ha.ps1 -CollectDiagnostics -ClusterStorage "C:\ClusterStorage\Volume1\Gateway"
-ClientAccessPoint "gateway-ha" -DiagnosticsLookbackHours 24 -DiagnosticsOutputPath "C:\Temp\wac-ha-diag"
```
