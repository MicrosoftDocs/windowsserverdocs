---
title: Linux Software Repository for Microsoft Products
description: This document describes how to use and install Linux software packages for Microsoft products.
ms.topic: article
ms.assetid: b5387444-595f-4f38-abb7-163a70ea1895
author: victorcheng7
ms.author: vichen
ms.date: 08/14/2020
---

# Linux Software Repository for Microsoft Products

## Overview

Microsoft builds and supports a variety of software products for Linux systems and makes them available via standard APT and YUM package repositories. This document describes how to configure the repository on your Linux system, so that you can then install/upgrade Microsoft's Linux software using your distribution's standard package management tools.

Microsoft's Linux Software Repository is comprised of multiple sub-repositories:

 - prod – The Production sub-repository is designated for packages intended for use in production. These packages are commercially supported by Microsoft under the terms of the applicable support agreement or program that you have with Microsoft.

 - mssql-server - These repositories contain packages for Microsoft SQL Server on Linux - See also: [SQL Server on Linux](/sql/linux/sql-server-linux-overview).

> [!NOTE]
> Packages in the Linux software repositories are subject to the license terms located in the packages. Please read the license terms prior to using the package. Your installation and use of the package constitutes your acceptance of these terms. If you do not agree with the license terms, do not use the package.

## Configuring the repositories

Repositories can be configured automatically by installing the Linux package that applies to your Linux distribution and version. The package will install the repository configuration along with the GPG public key used by tools such as apt/yum/zypper to validate the signed packages and/or repository metadata.

### Enterprise Linux (RHEL and variants)

 - Enterprise Linux 6 (EL6)<p>`sudo rpm -Uvh https://packages.microsoft.com/config/rhel/6/packages-microsoft-prod.rpm`

 - Enterprise Linux 7 (EL7)<p>`sudo rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm`

 - Enterprise Linux 8 (EL8)<p>`sudo rpm -Uvh https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm`

### SUSE

 - SUSE Linux Enterprise Server 12<p>`sudo rpm -Uvh https://packages.microsoft.com/config/sles/12/packages-microsoft-prod.rpm`

 - SUSE Linux Enterprise Server 15<p>`sudo rpm -Uvh https://packages.microsoft.com/config/sles/15/packages-microsoft-prod.rpm`

### Ubuntu

 - Ubuntu 16.04 (Xenial)<p>`curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -`<p>`sudo apt-add-repository https://packages.microsoft.com/ubuntu/16.04/prod`<p>`sudo apt-get update`

 - Ubuntu 18.04 (Bionic)<p>`curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -`<p>`sudo apt-add-repository https://packages.microsoft.com/ubuntu/18.04/prod`<p>`sudo apt-get update`

 - Ubuntu 20.04 (Focal)<p>`curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -`<p>`sudo apt-add-repository https://packages.microsoft.com/ubuntu/20.04/prod`<p>`sudo apt-get update`

## Manual Configuration

The repository configuration files are available from [packages.microsoft.com/config](https://packages.microsoft.com/config/). The name and location of these files can be located using the following URI naming convention:

`https://packages.microsoft.com/config/<Distribution>/<Version>/prod.(repo|list)`

### Package and Repository Signing Key

- Microsoft's GPG public key may be downloaded here: [https://packages.microsoft.com/keys/microsoft.asc](https://packages.microsoft.com/keys/microsoft.asc)
- Public Key ID: Microsoft (Release signing) <gpgsecurity@microsoft.com>
- Public Key Fingerprint: `BC52 8686 B50D 79E3 39D3 721C EB3E 94AD BE12 29CF`

### Examples

 - RHEL/CentOS 7

```
# Install repository configuration
curl -sSL https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft-prod.repo

# Install Microsoft's GPG public key
curl -sSL https://packages.microsoft.com/keys/microsoft.asc > ./microsoft.asc
sudo rpm --import ./microsoft.asc
```

 - Ubuntu 20.04

```
# Install repository configuration
curl -sSL https://packages.microsoft.com/config/ubuntu/20.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft-prod.list

# Install Microsoft GPG public key
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# Update package index files
sudo apt-get update
```

## See Also

- [Frequently Asked Questions about Windows Subsystem for Linux](/windows/wsl/faq)
- [How do I uninstall a WSL Distribution?](/windows/wsl/faq#how-do-i-uninstall-a-wsl-distribution)
- [Windows Subsystem for Linux Installation Guide for Windows 10](/windows/wsl/install-win10)
- [Windows Subsystem for Linux Documentation](/windows/wsl/)