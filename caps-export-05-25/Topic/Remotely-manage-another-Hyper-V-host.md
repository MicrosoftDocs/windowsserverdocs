---
title: Remotely manage another Hyper-V host
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 37af9ec5-97ad-43f2-9c51-b67302671cb5
author: jpjofre
robots: noindex,nofollow
---
# Remotely manage another Hyper-V host
**This is preliminary content and subject to change.**  
  
<delegateComputer> \- Computer name needs to be the fully\-qualified domain name  For example, the computer Computer 2 in the  
  
```  
enable-wsmancredssp -role client -delegatecomputer server02.accounting.fabrikam.com  
```  
  
You can also use the “\*” to give access to all machines in a designated domain:  
  
```  
enable-wsmancredssp -role client -delegatecomputer *.accounting.fabrikam.com  
```  
  
Now, I also need to make a change on the remote server to permit it to use delegated credentials. This command is shown here.  
  
```  
Enable-WSMaCredSSP -Role Server –Force  
```  
  
