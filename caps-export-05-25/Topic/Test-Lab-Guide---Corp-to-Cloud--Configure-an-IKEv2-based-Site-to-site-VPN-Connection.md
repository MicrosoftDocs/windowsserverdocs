---
title: Test Lab Guide : Corp to Cloud: Configure an IKEv2-based Site-to-site VPN Connection
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6080a107-19ec-4ff2-9371-50dfeb867a5b
author: coreyp
---
# Test Lab Guide : Corp to Cloud: Configure an IKEv2-based Site-to-site VPN Connection
Test Lab Guides \(TLGs\) allow you to get hands\-on experience with new products and technologies using a pre\-defined and tested methodology that results in a working configuration. When you use a TLG to create a test lab, instructions tell you what servers to create, how to configure the operating systems and platform services, and how to install and configure any additional products or technologies. A TLG experience enables you to see all of the components and the configuration steps on both the front\-end and back\-end that go into a single\- or multi\-product or technology solution.  
  
Depending on how you deploy your test lab environment, you can image the drives for the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Corp\-to\-cloud test lab if you are using physical computers or you can create snapshots of the Corp\-to\-cloud test lab virtual machines. This enables you to easily return to baseline configuration where most of the routine client, server, and networking services have already been configured so that you can focus on building out a test lab for the products or technologies of interest. For this reason, make sure that you perform a disk image on each computer if you’re using physical computers, or perform virtual machine snapshots if you are using virtual machines after completing all the steps in this TLG.  
  
## About this guide  
This document contains instructions for setting up the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Corp\-to\-cloud test lab by deploying six server computers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and one client computer running [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)]. The resulting configuration simulates a private intranet \(contoso\) connected to another private intranet \(fabrikam\) over the Internet.  
  
> [!IMPORTANT]  
> The following instructions are for configuring the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Corp\-to\-cloud test lab. Individual computers are needed to separate the services provided on the network and to clearly show the desired functionality. This configuration is neither designed to reflect best practices nor does it reflect a desired or recommended configuration for a production network. The configuration, including IP addresses and all other configuration parameters, is designed only to work on a separate test lab network.  
  
> [!WARNING]  
> If you are able to work from a computer\-based copy of this document during the lab exercises, and you are running virtual machines in Hyper\-V, leverage the Hyper\-V clipboard integration feature to paste commands. This will minimize potential errors with mistyped command strings.  
>   
> 1.  Highlight and right\-click a command from this document listed in **bold** text  
> 2.  Click **Copy**.  
> 3.  From the virtual machine menu bar, click **Clipboard**, and then click **Type clipboard text**.  
  
