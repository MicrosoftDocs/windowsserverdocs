---
title: Deploy Windows Admin Center with High Availability
description: Deploy Windows Admin Center with High Availability (Project Honolulu)
ms.technology: manage
ms.topic: article
author: jwwool
ms.author: jeffrew
ms.localizationpriority: medium
ms.prod: windows-server-threshold
---

# Deploy Windows Admin Center with high availability

>Applies To: Windows Admin Center, Windows Admin Center Preview

You can deploy Windows Admin Center in a failover cluster to provide high availability for your Windows Admin Center gateway service. The solution provided is an active-passive solution, where only one instance of Windows Admin Center is active. If one of the nodes in the cluster fails, Windows Admin Center gracefully fails over to another node, letting you continue managing the servers in your environment seamlessly. 

[Learn about other Windows Admin Center deployment options.](../plan/installation-options.md)

## Prerequisites

- A failover cluster of 2 or more nodes on Windows Server 2016 or 2019. [Learn more about deploying a Failover Cluster](../../../failover-clustering/failover-clustering-overview.md).
- A cluster shared volume (CSV) for Windows Admin Center to store persistent data that can be accessed by all the nodes in the cluster. 10 GB will be sufficient for your CSV.
- High-availability deployment script from [Windows Admin Center HA Script zip file](https://aka.ms/WACHAScript). Download the .zip file containing the script to your local machine and then copy the script as needed based on the guidance below.
- Recommended, but optional: a signed certificate .pfx & password. You don't need to have already installed the certificate on the cluster nodes - the script will do that for you. If you don't supply one, the installation script generates a self-signed certificate, which expires after 60 days.

## Install Windows Admin Center on a failover cluster

1. Copy the ```Install-WindowsAdminCenterHA.ps1``` script to a node in your cluster. Download or copy the Windows Admin Center .msi to the same node.
2. Connect to the node via RDP and run the ```Install-WindowsAdminCenterHA.ps1``` script from that node with the following parameters:
    - `-clusterStorage`: the local path of the Cluster Shared Volume to store Windows Admin Center data.
    - `-clientAccessPoint`: choose a name that you will use to access Windows Admin Center. For example, if you run the script with the parameter `-clientAccessPoint contosoWindowsAdminCenter`, you will access the Windows Admin Center service by visiting `https://contosoWindowsAdminCenter.<domain>.com`
    - `-staticAddress`: Optional. One or more static addresses for the cluster generic service. 
    - `-msiPath`: The path for the Windows Admin Center .msi file.
    - `-certPath`: Optional. The path for a certificate .pfx file.
    - `-certPassword`: Optional. A SecureString password for the certificate .pfx provided in `-certPath`
    - `-generateSslCert`: Optional. If you don't want to provide a signed certificate, include this parameter flag to generate a self-signed certificate. Note that the self-signed certificate will expire in 60 days.
    - `-portNumber`: Optional. If you don't specify a port, the gateway service is deployed on port 443 (HTTPS). To use a different port specify in this parameter. Note that if you use a custom port (anything besides 443), you'll access the Windows Admin Center by going to https://\<clientAccessPoint\>:\<port\>.

> [!NOTE]
> The ```Install-WindowsAdminCenterHA.ps1``` script supports ```-WhatIf ``` and ```-Verbose``` parameters

### Examples

#### Install with a signed certificate:

```powershell
$certPassword = Read-Host -AsSecureString
.\Install-WindowsAdminCenterHA.ps1 -clusterStorage "C:\ClusterStorage\Volume1" -clientAccessPoint "contoso-ha-gateway" -msiPath ".\WindowsAdminCenter.msi" -certPath "cert.pfx" -certPassword $certPassword -Verbose
```

#### Install with a self-signed certificate:

```powershell
.\Install-WindowsAdminCenterHA.ps1 -clusterStorage "C:\ClusterStorage\Volume1" -clientAccessPoint "contoso-ha-gateway" -msiPath ".\WindowsAdminCenter.msi" -generateSslCert -Verbose
```

## Update an existing high availability installation

Use the same ```Install-WindowsAdminCenterHA.ps1``` script to update your HA deployment, without losing your connection data.

### Update to a new version of Windows Admin Center

When a new version of Windows Admin Center is released, simply run the ```Install-WindowsAdminCenterHA.ps1``` script again with only the ```msiPath``` parameter:

```powershell
.\Install-WindowsAdminCenterHA.ps1 -msiPath '.\WindowsAdminCenter.msi' -Verbose
```

### Update the certificate used by Windows Admin Center

You can update the certificate used by a HA deployment of Windows Admin Center at any time by providing the new certificate's .pfx file and password.

```powershell
$certPassword = Read-Host -AsSecureString
.\Install-WindowsAdminCenterHA.ps1 -certPath "cert.pfx" -certPassword $certPassword -Verbose
```

You may also update the certificate at the same time you update the Windows Admin Center platform with a new .msi file.

```powershell
$certPassword = Read-Host -AsSecureString
.\Install-WindowsAdminCenterHA.ps1 -msiPath ".\WindowsAdminCenter.msi" -certPath "cert.pfx" -certPassword $certPassword -Verbose
``` 

## Uninstall

To uninstall the HA deployment of Windows Admin Center from your failover cluster, pass the ```-Uninstall``` parameter to the ```Install-WindowsAdminCenterHA.ps1``` script.

```powershell
.\Install-WindowsAdminCenterHA.ps1 -Uninstall -Verbose
```

## Troubleshooting

Logs are saved in the temp folder of the CSV (for example, C:\ClusterStorage\Volume1\temp).