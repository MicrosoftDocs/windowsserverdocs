---
title: 2 Goals
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b8be9f34-878d-4b93-9c9c-6a7585f4b88b
robots: noindex,nofollow
---
# 2 Goals
As a cloud service provider or enterprise private cloud administrator, you can provide a secure “hardware rooted” or “Administrative trusted” environment for tenant VMs where:  
  
1.  You are assured that Windows Server has built-in breach hardening capabilities spanning from secure and measured boot, code integrity and protection for high value operating system security secrets and operations from malicious code on the Hyper-V host, and    
2.  You are assured that you can provide a secure hardware trusted environment for tenant VMs where the VM data is protected from malicious host administrators and malware.  
  
From the scenario validation point of view:  
  
1.  You can build an infrastructure for guarded hosts and “shielded VMs”.    
2.  Tenants can create new or use existing VMs and be able to convert them to shielded VMs.    
3.  Hosts can build a cloud service and offer shielded VM functionality using the Windows Azure Pack Portal.    
4.  Tenants can use Windows Azure Pack to create and manage shielded VMs in Windows Azure Pack.    
5.  Tenants can export VMs and grant permission to either a cloud service provider or an enterprise cloud operator to be guardian, and are assured of security and data-at-rest encryption.    
6.  Tenants can create new VMs from a VMM template and be assured that the base images used for template creation are trusted and have not been tampered with.    
7.  During VM creation from a VMM template, tenants can provide input for computer names and administrator passwords in secure manner without exposing sensitive information to fabric administrators.    
8.  Cloud service providers and enterprise administrators can use Live Migrate or Live (VSM) virtual machines between guarded hosts in the same way they as they did prior to deploying the Guarded Fabric solution.    
9.  Cloud service providers and enterprise administrators can back up, checkpoint and restore shielded VMs as per normal procedure.