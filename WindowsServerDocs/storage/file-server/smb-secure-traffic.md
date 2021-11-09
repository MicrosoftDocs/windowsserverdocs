---
title: Secure SMB Traffic in Windows Server
description: How to secure SMB Traffic in Windows
ms.topic: article
author: PatAltimore
ms.author: patricka
ms.date: 11/02/2021
ms.prod: windows-server
ms.localizationpriority: medium
# Intent: As a network administrator I want to configure ports to secure SMB Traffic in Windows
---

# Secure SMB Traffic in Windows Server

As a defense in depth measure, you can configure ports to secure SMB traffic and prevent outbound
and lateral network communications.

SMB is used for file sharing, network browsing, printing, and inter-process communication such as named pipes and RPC. Use the following sections to configure SMB traffic segmentation and endpoint isolation between devices on your network to reduce threats.

## Cut inbound SMB access at the corporate firewalls

Block with firewall

## Cut outbound SMB access at the corporate firewall with exceptions for specific IP ranges

## Inventory for SMB usage and shares

## Configure Windows Defender Firewall for inbound and outbound blocks

## Disable SMB Server if truly unused

## Test at a small scale by hand. Deploy in waves, using policy

