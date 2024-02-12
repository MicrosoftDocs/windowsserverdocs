---
title: Customize WebSocket validation for Windows Admin Center gateway
description: Learn how administrators can customize the WebSocket validation for their Windows Admin Center (Project Honolulu) instance. 
ms.topic: article
author: trungtran-msft
ms.author: wscontent
ms.date: 10/22/2021
---

# Customize WebSocket validation for Windows Admin Center gateway

To protect WebSocket access, WebSocket connection will now validate **origin** state from the browser so not any external application could get access the WebSocket API defined on the gateway.

## Customization of validation

Validation can be adjusted to customize various conditions.

User can configure WebSocket override setting at a Windows Admin Center registry value, `HKLM\Software\Microsoft\ServerManagementGateway\WebSocketValidationOverride`, to specify exceptional **origin host** name and **origin port**. This include wildcard name such as "`*.mydomain.mycompany.net`" or just "`*`" to accept all. Wildcard must be specified single form like "`*.`" and cannot be combined with complex string match condition like "`something*something`". 

Example of accepted formats are as follows:
- Always allows origin host defined on current TLS certificate. (subject name, alternate DNS names)
- Always allows origin port configured to Windows Admin Center
- "`*`" - accept any origin host and origin port
- "`*:9876`" - accept any origin host and origin port 9876
- "`:9876`" - accept origin port 9876
- "*`.my.domain.com`" - accept origin host <any.any.any...>.my.domain.com
- "`*.my.domain.com:9876`" - accept origin host <any.any.any...>.my.domain.com and origin port 9876

## Prevention logic

Gateway adds a session cookie (WAC-SESSION) for user browser. It associates the browser session and username always. It prevents different user attempting using the same browser session.
- When UI starts a WebSocket connection the browser sends the session cookie back to Gateway.
- Gateway validates authenticated username matched with the session cookie always.

Gateway looks for **origin header**, which is endpoint URL that original Windows Admin Center site was loaded.
- Gateway validated **origin host** and **origin port** against current SSL certificate settings which includes list of DNS host names. This tells the UI code is loaded from expected DNS name sites and port.

## RDP enhancement

On RDP TCP connection, Gateway only allows to use port 3389 (RDP) and port 2179 (VM connection), so TCP forwarding feature cannot be used for any other purpose.

## Possible side effect

If user uses Windows Admin Center by IP address or something not described on the SSL certificate, user cannot access WebSocket because it's not trustable. If it needs to support, modify `HKLM\Software\Microsoft\ServerManagementGateway\WebSocketValidationOverride` registry value to set the IP address or just specify "`*`" to ignore validation.
