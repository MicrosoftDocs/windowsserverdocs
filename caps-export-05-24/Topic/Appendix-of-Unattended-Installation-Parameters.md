---
title: Appendix of Unattended Installation Parameters
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: bcd89659-402d-46fb-8535-8da1feb8d411
author: Femila
---
# Appendix of Unattended Installation Parameters
  The tables in this appendix provide the information that you need to create an answer file for automating the installation or removal of AD DS:  
  
 [Promotion Operation](../Topic/Promotion-Operation.md)  
  
 [CreateDCAccount Operation](../Topic/CreateDCAccount-Operation.md)  
  
 [UseExistingAccount Operation](../Topic/UseExistingAccount-Operation.md)  
  
 [Demotion Operation](../Topic/Demotion-Operation.md)  
  
 [Unattended Installation Return Codes](../Topic/Unattended-Installation-Return-Codes.md)  
  
 Dcpromo.exe accepts these parameters either directly from the command line or as entered in a text file that is formatted in standard .INI format. The text file must contain a section heading \[DCINSTALL\] followed by AD DS \(domain controller\) server role unattended installation parameters.  
  
 Create a text file that contains the \[DCINSTALL\] heading and in which each line in the file contains an option and its value in the form *option*\=*value*. To use the options directly from the command line, precede each *option:value* pair with a forward slash \(\/\) and separate each \/*option*\=*value* pair with a space. At the command line, you can also use a colon \(:\) to separate the option and the value \(\/*option*:*value*\).  
  
 The following are example lines in an answer text file:  
  
 \[DCINSTALL\]  
  
 UserName\=Jsmith  
  
 Password\=\*  
  
 SiteName\=NorthRegion  
  
 The following is an example set of the same options as typed in the Dcpromo.exe command line:  
  
 `dcpromo /unattend /username:Jsmith /password:* /sitename:NorthRegion ...`  
  
  