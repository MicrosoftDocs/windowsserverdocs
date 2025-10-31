---
title: AD FS Troubleshooting - AD FS Endpoints
description: This article describes how to troubleshoot Active Directory Federation Services (AD FS) endpoints.
ms.date: 10/14/2024
ms.topic: troubleshooting-general
ms.custom: sfi-image-nochange
---

# AD FS troubleshooting: AD FS metadata endpoints

Endpoints provide access to the federation server functionality of Active Directory Federation Services (AD FS), such as publishing federation metadata. To verify that the AD FS server is responding to web requests, you can check the various endpoints.

## Federation metadata test

Passive federation refers to scenarios where your browser is redirected to the AD FS sign-in page. By testing the metadata endpoint, you can determine if the AD FS server is responding to web requests in these passive scenarios. Use the following procedure to test the endpoint.

1. Use a web browser to go to your AD FS federation metadata endpoint. An example is `https://sts.contoso.com/FederationMetadata/2007-06/FederationMetadata.xml`. The .xml file downloads locally to your machine.
1. Open the .xml file and verify that it contains information similar to the following image.

   ![Screenshot that shows a passive scenario.](media/ad-fs-tshoot-endpoints/meta2.png)

## WS-MEX test (active test)

WS-MetaDataExchange is a web services protocol and is part of the WS-Federation roadmap. It uses a SOAP message to request metadata. By testing the endpoint, you can determine if the AD FS server is responding to web requests for WS-MetaDataExchange.

To test the endpoint, use a web browser to go to your AD FS federation metadata endpoint. An example is `https://sts.contoso.com/adfs/services/trust/mex`. The .xml file automatically appears in the browser and should look like the following image.

   :::image type="content" source="media/ad-fs-tshoot-endpoints/security-trust-file.png" alt-text="Screenshot that shows the AD FS federation metadata endpoint .xml file.":::

## Related content

- [AD FS troubleshooting](ad-fs-tshoot-overview.md)
