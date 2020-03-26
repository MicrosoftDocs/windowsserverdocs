---
title: Steps for Configuring the Test Lab
description: This topic is part of the Test Lab Guide - Demonstrate DirectAccess with OTP Authentication and RSA SecurID for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0a40183c-afd1-43ca-b306-05745640a37d
ms.author: lizross
author: eross-msft
---
# Steps for Configuring the Test Lab

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

The following steps describe how to configure the Remote Access infrastructure, configure the Remote Access server and client, and test DirectAccess connectivity from the Homenet and Internet subnets.  
  
In this test lab guide you will build a Remote Access with OTP environment by performing the following steps:  
  
-   [STEP 1: Complete the DirectAccess Configuration](assetId:///4dbf877f-02fb-439b-907a-f5b3f1d8afa6). Complete all the steps in the [Test Lab Guide: Demonstrate DirectAccess Single Server Setup with Mixed IPv4 and IPv6](https://go.microsoft.com/fwlink/p/?LinkId=237004).  
  
-   [STEP 2: Configure APP1](assetId:///c1bb590f-91d4-4ed5-bceb-b0e36eabd4ff). Configure APP1 with OTP certificate templates for use by EDGE1.  
  
-   [STEP 3: Configure DC1](assetId:///904a6edc-a771-45ed-9630-a34a680bb522). Verify User Principal Name defined on DC1.  
  
-   [STEP 7: Install and configure RSA](assetId:///baa4c28c-add7-42e2-8afd-ccc7a559406a). Install and Configure RSA, a RADIUS and OTP server, and configure EDGE1 for OTP.  
  
-   [STEP 11: Verify OTP Health on EDGE1](assetId:///3b397a4a-8478-47f2-a932-9e8e048c14ba). Make sure that the status of OTP is healthy on the Remote Access server.  
  
-   [STEP 8: Test DirectAccess connectivity from the Homenet subnet](assetId:///ba1652a6-0692-4add-91ca-34a84956ba14). Test DirectAccess OTP functionality from behind a NAT device.  
  
-   [STEP 10: Test DirectAccess connectivity from the Internet](assetId:///321149eb-5f23-4a0b-b8fb-1244540126e9). Test DirectAccess client connectivity from the Internet.  
  
-   [STEP 12: Snapshot the configuration](assetId:///8a51ed3c-9c32-402f-85d1-617ce46845b4). After completing the test lab, take a snapshot of the working DirectAccess with OTP configuration so that you can return to it later to test additional scenarios.  
  


