---
title: Verify Readiness of Domain Controllers
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 17af89a6-c699-4a28-ac9a-84b096845254
author: Femila
---
# Verify Readiness of Domain Controllers
  You can use this procedure to verify the readiness of domain controllers for a domain rename operation. In this procedure, you run a preparatory check on every domain controller in the forest to verify that the directory database at each domain controller in the forest is in a good state and ready to perform the directory modifications that are dictated by the domain rename instructions. You perform the verification by using the Rendom.exe tool to issue a remote procedure call \(RPC\) individually to each domain controller in the forest that is tracked by the state file Dclist.xml. The RPC causes each domain controller to verify that its directory replica is in a good state to perform the changes that are dictated by the domain rename instructions. For each domain controller that is successfully verified for readiness, Rendom updates the state field in the corresponding domain controller entry in the state file Dclist.xml to Prepared \(\<State\>Prepared\<\/State\>\).  
  
> [!IMPORTANT]  
>  All domain controllers must be in the Prepared state before domain rename instructions can be run.  
  
 Ensure that the following conditions are in effect before you use Rendom.exe to verify that your domain controllers are ready for the domain rename operation:  
  
-   The preparatory changes that are made to the Partitions container of the forest’s domain naming operations master during the generation of domain rename instructions must have replicated to every domain controller in the forest. This status is checked for and enforced by Rendom.exe during this step.  
  
-   Service \(SRV\) resource records, which are required for domain controller location of the renamed domains, must be registered in Domain Name System \(DNS\) and they must have replicated to all DNS servers.  
  
 Membership in the **Enterprise Admins** group in the target forest \(with write access to the Partitions container object and the cross\-reference objects that are its children in the configuration directory partition\) and the **Local Administrators** group \(or write access to the domain rename C:\\domren working directory\) on the control station computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
> [!NOTE]  
>  You can use credentials other than the credentials with which you are currently logged on. To use alternative credentials, use the **\/user** and **\/pwd** command\-line switches of **rendom**, as described in [Appendix A: Command-Line Syntax for the Rendom Tool](../Topic/Appendix-A--Command-Line-Syntax-for-the-Rendom-Tool.md).  
  
### To verify the readiness of domain controllers in the forest  
  
1.  On the control station, click **Start**, click **Run**, type **cmd**, and then click **OK**.  
  
2.  At the command prompt, type the following command to change to the working directory, and then press ENTER:  
  
    ```  
    C:\domren  
    ```  
  
3.  From within the working directory, type the following command, and then press ENTER:  
  
    ```  
    rendom /prepare  
    ```  
  
4.  After the command finishes, examine the state file Dclist.xml to determine whether all domain controllers achieved the Prepared state. If not, repeat step 2 in this procedure until all domain controllers achieve the Prepared state.  
  
    > [!NOTE]  
    >  Each time that it runs, the Rendom tool consults the Dclist.xml state file and, it does not connect to and verify the domain controllers that are already in the Prepared state. Therefore, no redundant operations are performed when you run this command repeatedly.  
  
 In a large forest with a large number of domain controllers, it is very likely that all domain controllers cannot be reached from the control station at the same time. In other words, it is not likely that all domain controllers that are tracked by the state file Dclist.xml will reach the Prepared state in a single running of the **rendom \/prepare** command. Therefore, multiple invocations of this command might be necessary to make incremental progress with groups of domain controllers that reach the Prepared state at the same time. If you determine that—for any reason—it is impossible to make any further progress with a specific domain controller, you can remove the entry for that domain controller \(bounded by the \<DC\>\<\/DC\> tags\) from the Dclist.xml file by simply editing the state file with a text editor. Remember that, when a domain controller is removed in this manner from participating in the domain rename procedure, it must be retired \(that is, Active Directory Domain Services \(AD DS\) must be removed from domain controller\) in the new forest after the domain rename operation is complete.  
  
> [!NOTE]  
>  Make sure that you save a copy of the state file Dclist.xml every time before you edit by using a text editor. This makes an easy fallback and recovery possible in case you make an error in editing the file.  
  
 As Rendom.exe executes the various command\-line options, the command execution log is cumulatively captured in a log file named Rendom.log \(the default name\) in the current working directory \(C:\\domren\). When execution of a Rendom.exe command fails, examination of this log file can yield valuable information about the actual tasks that the tool performed, and at what stage or on which domain controller a problem occurred.  
  
  