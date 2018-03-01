---
title: AD FS Troubleshooting - Fiddler
description:  This document describes what Fiddler is and how to install and configure Fiddler to troubleshoot AD FS claims issues
author: billmath
ms.author: billmath
manager: mtillman
ms.date: 01/18/2018
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---

# AD FS Troubleshooting - Fiddler
Fiddler is a tool that can be used to capture HTTP/HTTPS web traffic.  This tool can be used to assist in troubleshooting the claim issuance process.  By looking at the traffic we can get a better understanding of where the interaction is breaking down.  This document will describe how to install and setup Fiddler to capture AD FS traffic.  Subsequent documents will provide information on what to look for when troubleshooting SAML, WS-Federation, and OAuth request/responses.

## Download and install Fiddler
You can download Fiddler [here](https://www.telerik.com/download/fiddler).  Once you have downloaded it go ahead and install it.

## Configure Fiddler to capture AD FS traffic
There are a couple of things that you need to do in order to capture the traffic to the AD FS server.  These are:

- Configure the Fiddler SSL certificate
- Grant Fiddler access to the session key 

### Configure the Fiddler SSL certificate

### Grant Fiddler access to the session key
