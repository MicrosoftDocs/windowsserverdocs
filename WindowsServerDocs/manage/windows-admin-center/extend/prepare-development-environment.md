---
title: Prepare your development environment
description: Preparing your development environment Windows Admin Center SDK (Project Honolulu)
ms.topic: how-to
author: davannaw-msft
ms.author: dawhite
ms.localizationpriority: medium
ms.date: 08/17/2026
---

# Prepare your development environment

Let's get started developing extensions with the Windows Admin Center SDK!  In this document, we'll cover the process to get your environment up and running to build and test an extension for Windows Admin Center.

> [!NOTE]
> New to the Windows Admin Center SDK?  Learn more about [Extensions for Windows Admin Center](extensibility-overview.md)

> [!TIP]
> Create a folder to store all your Windows Admin Center extension development files to reduce command execution.

To prepare your development environment, perform the following steps:

## Install prerequisites

To begin developing with the SDK, download and install the following prerequisites:

- [Windows Admin Center](../overview.md) (GA or preview version)
- Visual Studio or [Visual Studio Code](https://code.visualstudio.com)
- [Node.js version 24.18.1](https://nodejs.org/en/download) (download and install the LTS version)
- [Node Package Manager](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm) (6.14.5 or later)
- [NuGet](https://www.nuget.org/downloads) (for publishing extensions)
- [Git for Windows](https://git-scm.com/install/windows) (includes OpenSSL for generating self-signed certificates)

To bypass signature validation which occurs during extension installation in Windows Admin Center versions running with .NET 8, you should also switch your Windows Admin Center operation mode to "Development." To configure development mode, you must:
- Open your Windows Admin Center instance's ```appsettings.json``` file. This can be found by default at ```C:\Program Files\WindowsAdminCenter\service\appsettings.json```.
- Modify the ```OperationMode``` field under the ```WindowsAdminCenter/System``` section to read "Development" instead of "Production."

## Install global dependencies

Next, install or update dependencies required for your projects by using Node Package Manager. Install these dependencies globally so all projects can access them.

```powershell
npm install -g @angular/cli@20.3.25

npm install -g gulp
npm install -g typescript
npm install -g eslint
npm install -g @microsoft/windows-admin-center-sdk@latest
```

>[!NOTE]
> You can install a later version of `@angular/cli`. However, if you install a version greater than 20.3.25, you see a warning during the gulp build step that the local CLI version doesn't match the installed version.

## Prepare your environment for sideloading

After you create your extension, you want to sideload it in Windows Admin Center for testing. To do so, perform the following one-time steps for your extension development directory:

1. Open PowerShell **as an administrator** and create a certificate directory:
   ```powershell
   New-Item -ItemType Directory -Path "C:<path>\certificate"
   ```
1. Generate a self-signed certificate by using Git's OpenSSL:
   ```powershell
   & "C:\Program Files\Git\usr\bin\openssl.exe" req -x509 -newkey rsa:2048 -nodes -keyout C:\<path-to-extension-directory>\certificate\localhost.key -out C:\<path-to-extension-directory>\certificate\localhost.cert -days 365 -subj "/CN=localhost" -addext "subjectAltName=DNS:localhost"
   ```
1. Import the new certificate into your Trusted Root:
   ```powershell
    Import-Certificate -FilePath "C:\<path-to-extension-directory>\certificate\localhost.cert" -CertStoreLocation "Cert:\LocalMachine\Root"
   ```
1. Open `C:\Program Files\WindowsAdminCenter\Service\appsettings.json` in Visual Studio Code as administrator.
1. Find the `corsSites` array and add the sideloading URL (port 4200 is the default).
   ```json
    "CorsSites": [
      "https://localhost:4200"
    ]
   ```
1. Find the `CSPFrameAncestors` array and add the sideloading URL (port 4200 is the default).
   ```json
    "CSPFrameAncestors": [
      "'self'",
      ... existing entries ...
      "https://localhost:4200"
    ]
   ```
1. Save the file, and then restart the Windows Admin Center service in your administrator PowerShell window by running:
   ```powershell
     Restart-Service WindowsAdminCenter
   ```

> [!IMPORTANT]
> These instructions reference self-signed certificates for development and testing. Don't use self-signed certificates on production machines for production workloads.

### Sideloading by using fully qualified domain name

To sideload your Windows Admin Center extension through a URL that includes your machine's fully qualified domain name (FQDN), follow these additional configuration steps:

1. Use Git's OpenSSL to generate a self-signed certificate that contains subject alternate names for both `localhost` and the FQDN:
   ```powershell
   & "C:\Program Files\Git\usr\bin\openssl.exe" req -x509 -newkey rsa:2048 -nodes -keyout C:\<path-to-extension-directory>\certificate\localhost.key -out C:\<path-to-extension-directory>\certificate\localhost.cert -days 365 -subj "/CN=localhost" -addext "subjectAltName=DNS:localhost,DNS:<FQDN>"
   ```
1. Import the new certificate into your Trusted Root:
   ```powershell
    Import-Certificate -FilePath "C:\<path-to-extension-directory>\certificate\localhost.cert" -CertStoreLocation "Cert:\LocalMachine\Root"
   ```
1. Update `C:\Program Files\WindowsAdminCenter\Service\appsettings.json` to include URLs with the FQDN origin:
   ```json
    "CorsSites": [
      "https://localhost:4200",
      "https://<FQDN>:4200"
    ],
    "CSPFrameAncestors": [
      "'self'",
      ... existing entries ...
      "https://localhost:4200",
      "https://<FQDN>:4200"
    ]
   ```
1. Save the file, and then restart the Windows Admin Center service in your administrator PowerShell window by running:
   ```powershell
     Restart-Service WindowsAdminCenter
   ```

## Next steps

Now that your environment is prepared, you are ready to start creating content.

- Create a [tool](develop-tool.md) extension
- Create a [solution](develop-solution.md) extension
- Create a [gateway plugin](develop-gateway-plugin.md)
- Learn more with our [guides](guides.md)

## SDK design toolkit

Check out our Windows Admin Center [SDK design toolkit](https://github.com/Microsoft/windows-admin-center-sdk/blob/master/WindowsAdminCenterDesignToolkit.zip)! This toolkit is designed to help you rapidly mock up extensions in PowerPoint using Windows Admin Center styles, controls, and page templates. See what your extension can look like in Windows Admin Center before you start coding!
