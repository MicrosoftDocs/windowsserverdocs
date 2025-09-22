---
description: "Learn more about: Review prerequisites for the Host Guardian Service"
title: Review HGS prerequisites
ms.topic: concept-article
author: dknappettmsft
ms.author: daknappe
ms.date: 08/29/2018
---

# Review prerequisites for the Host Guardian Service


This topic covers HGS prerequisites and initial steps to prepare for the HGS deployment.

## Prerequisites

-   **Hardware**: HGS can be run on physical or virtual machines, but physical machines are recommended.

    If you want to run HGS as a three-node physical cluster (for availability), you must have three physical servers. (As a best practice for clustering, the three servers should have very similar hardware.)

-   **Operating system**: Host key attestation requires Windows Server 2019 Standard or Datacenter edition operating with [v2 attestation](guarded-fabric-tpm-trusted-attestation-capturing-hardware.md#versioned-attestation-policies). For TPM-based attestation, HGS can run Windows Server 2019 or Windows Server 2016, Standard or Datacenter edition.

-   **Server Roles**: Host Guardian Service and supporting server roles.

-   **Configuration permissions/privileges for the fabric (host) domain**: You will need to configure DNS forwarding between the fabric (host) domain and the HGS domain.

## Upgrading HGS

If you've already deployed HGS and want to upgrade its operating system, follow the [upgrade guidance](guarded-fabric-upgrade-to-2019.md) to upgrade your HGS and Hyper-V servers to the latest OS.

## Next step

> [!div class="nextstepaction"]
> [Obtain certificates for HGS](guarded-fabric-obtain-certs.md)


