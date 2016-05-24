---
title: Verify the Availability of the Operations Masters
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 311d56ac-8887-4c16-b9bc-ee5b5555dbf4
author: Femila
---
# Verify the Availability of the Operations Masters
  You can use this procedure to verify that the domain controllers that hold the operations master \(also known as flexible single master operations or FSMO\) roles can be located and that they are online and responding.  
  
 You can use the tests in this procedure before you install Active Directory Domain Services \(AD DS\) as well as afterward. However, if you perform this procedure before you install AD DS, you must do the following:  
  
-   First, use Server Manager to add the Active Directory Domain Services server role. This part of the installation procedure installs the Dcdiag.exe command line tool. Perform this procedure after you add the server role but before you run Dcpromo.exe.  
  
-   Use the **\/s** command option to indicate the name of an existing domain controller in the domain of the new domain controller. This domain controller is required to verify the ability of the server to connect to operations master role holders in the domain and forest.  
  
 You do not have to use the **\/s** option if you perform the test in this procedure after you install AD DS. The test automatically runs on the local domain controller where you are performing the test. The commands in this procedure show the **\/s** option. If you are performing this test after you install AD DS, omit the **\/s** option. For a more detailed response from this command, you can use the verbose option by adding **\/v** to the end of the command.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To verify the availability of the operations masters  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, type the following command to ensure that the operations masters can be located, and then press ENTER:  
  
     `dcdiag /s:<DomainControllerName> /test:knowsofroleholders /v`  
  
     where `<DomainControllerName>` is the name of an existing domain controller in the domain in which you want to add the new domain controller. The verbose option provides a detailed list of the operations masters that were tested. Near the bottom of the screen, a message confirms that the test succeeded. If you use the verbose option, look carefully at the bottom part of the displayed output. The test confirmation message appears immediately after the list of operations masters.  
  
3.  Type the following command to ensure that the operations masters are functioning properly and available on the network, and then press ENTER:  
  
     `dcdiag /s:<DomainControllerName> /test:fsmocheck`  
  
     where `<DomainControllerName>` is the name of a domain controller in the domain in which you want to add the new domain controller. The verbose option provides a detailed list of the operations masters that were tested as well as other important servers, such as global catalog servers and time servers. Near the bottom of your screen, a message confirms that the test succeeded.  
  
     If these tests fail, do not attempt any additional steps until you fix the problem that prevents the location of operations masters and you can verify that they are functioning properly.  
  
  