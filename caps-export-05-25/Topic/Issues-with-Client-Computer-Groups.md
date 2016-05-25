---
title: Issues with Client Computer Groups
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a8ffffb5-d980-4a0d-a02a-aee6fbd01f2a
author: coreyp
---
# Issues with Client Computer Groups
Use the information in this section to troubleshoot issues with client computer groups.  
  
## Troubleshoot client computers that appear in the wrong groups  
Using Group Policy or registry settings to move computers into target groups is called *client\-side targeting*. For information about how to set up client\-side targeting, see the [Windows Server Update Services 3.0 SP2 Deployment Guide](http://go.microsoft.com/fwlink/?LinkId=139832). There are a number or reasons why computers might not appear in groups when you are using client\-side targeting. Use the following information to try to resolve this problem.  
  
#### Verify that the WSUS console is set to use client\-side targeting  
By default the WSUS server is set to use server\-side targeting. If you are using client\-side targeting, you need to set an option on the WSUS server. For information about how to set up client\-side targeting, see the [Windows Server Update Services 3.0 SP2 Deployment Guide](http://go.microsoft.com/fwlink/?LinkId=139832).  
  
#### Verify that target computer group names match groups on the WSUS server  
Make sure that the name of the target computer group matches the name of the computer group on the WSUS server. Check the Group Policy Object \(GPO\) or the registry setting where you enabled client\-side targeting. Make sure that there are no discrepancies between the name of the computer group that is used in Group Policy and the name of the group used on the server. If WSUS cannot find a computer group on the server that is reported by a client computer, the computer will appear in the **Unassigned Computers** group.  
  
#### Reset Automatic Update  
If you make a change to group membership by using client\-side targeting, you can reset Automatic Update with the wuauclt utility.  
  
###### To reset Automatic Update  
  
1.  Open a Command Prompt window.  
  
2.  Type **wuauclt.exe \/resetauthorization \/detectnow**.  
  
3.  Wait 10 minutes for the detection cycle to finish.  
  
