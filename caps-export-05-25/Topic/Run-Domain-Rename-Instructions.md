---
title: Run Domain Rename Instructions
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: c64b2ac7-7091-423b-86ea-77d5249c2c82
author: Femila
---
# Run Domain Rename Instructions
  You can use this procedure to execute domain rename instructions. In this procedure, you execute the domain rename instructions that are contained in the special script that is uploaded to the **msDS\-UpdateScript** attribute on the Partitions container on every domain controller in the forest. To execute the script, the control station computer issues a remote procedure call \(RPC\) to each domain controller in the forest individually, which causes each domain controller to execute the domain rename instructions and then restart automatically after it runs the instructions successfully. At the end of this procedure, every domain controller that is tracked by the state file **dclist.xml** will be in one of two final states:  
  
-   Done, which means that the domain controller successfully completed the domain rename operation.  
  
-   Error, which means that the domain controller encountered an irrecoverable error and did not complete the domain rename operation.  
  
 In other words, if a domain controller successfully executes the domain rename instructions, it restarts automatically and its corresponding state for the domain controller entry in the state file is updated to read \<State\>Done\<\/State\>. But, if a fatal or irrecoverable error is encountered on a domain controller while you attempt to execute the domain rename instructions, its corresponding state for the domain controller entry in the state file is updated to read \<State\>Error\<\/State\>. For the Error state, the error code is written to the last error field \<LastError\>\<\/LastError\> and a corresponding error message is written to the \<FatalErrorMsg\>\<\/FatalErrorMsg\> field.  
  
 The **rendom** command must be repeated until all domain controllers have either successfully executed the domain rename or you have established that one or more domain controllers are unreachable and will be removed from the forest.  
  
> [!IMPORTANT]  
>  This step will cause a temporary disruption in service while the domain controllers are running the domain rename instructions and restarting after they run the instructions successfully. The Active Directory Domain Services \(AD DS\) service in the forest has not been disrupted up to this point in the domain rename operation.  
  
> [!IMPORTANT]  
>  All domain controllers in the forest must be in the Prepared state, as indicated by the state field \(\<State\>Prepared\<\/State\>\) in the state file Dclist.xml. This state is checked for and enforced by **rendom** at this step.  
  
 Membership in the **Enterprise Admins** group in the target forest \(with write access to the Partitions container object and the cross\-reference objects that are its children in the configuration directory partition\) and the **Local Administrators** group \(or write access to the domain rename C:\\domren working directory\) on the control station computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
> [!NOTE]  
>  You can use credentials other than the credentials with which you are currently logged on. To use alternative credentials, use the **\/user** and **\/pwd** command\-line switches of **rendom**, as described in [Appendix A: Command-Line Syntax for the Rendom Tool](../Topic/Appendix-A--Command-Line-Syntax-for-the-Rendom-Tool.md).  
  
### To run the domain rename instructions on all domain controllers  
  
1.  On the control station, click **Start**, click **Run**, type **cmd**, and then click **OK**.  
  
2.  At the command prompt, type the following command to change to the working directory, and then press ENTER:  
  
    ```  
    C:\domren  
    ```  
  
3.  From within the working directory, type the following command, and then press ENTER:  
  
    ```  
    rendom /execute  
    ```  
  
4.  When the command has finished running, examine the state file Dclist.xml to determine whether all domain controllers have reached either the Done state or the Error state.  
  
5.  If the Dclist.xml file shows any domain controllers as remaining in the Prepared state, repeat step 2 in this procedure as many times as necessary until the stopping criterion is met.  
  
    > [!IMPORTANT]  
    >  The stopping criterion for the domain rename operation is that every domain controller in the forest has reached one of the two final states of Done or Error in the Dclist.xml state file.  
  
    > [!NOTE]  
    >  Each time that you run it, the **rendom \/execute** command consults the Dclist.xml state file and skips connecting to the domain controllers that are already in the Done or Error state. Therefore, no redundant operations are performed if you repeatedly attempt this command.  
  
 If you determine that an error that has caused a domain controller to reach the Error state in the Cclist.xml file is actually a recoverable error and you think that progress can be made on that domain controller by trying to run the domain rename instructions again, you can force the **rendom \/execute** command to run again by issuing the RPC to that domain controller \(instead of skipping it\) as described in the following procedure.  
  
### To force rendom \/execute to reissue the RPC to a domain controller in the Error state  
  
1.  On the control station, navigate to the working directory C:\\domren, and using a simple text editor, such as Notepad.exe, open the Dclist.xml file.  
  
2.  In the Dclist.xml file, locate the \<Retry\>\<\/Retry\> field in the domain controller entry for the domain controller that you think should be reissued the RPC, and then edit the Dclist.xml file so that the field reads \<Retry\>yes\<\/Retry\> for that entry.  
  
3.  On the control station, click **Start**, click **Run**, type **cmd**, and then click **OK**.  
  
4.  At the command prompt, type the following command to change to the working directory, and then press ENTER:  
  
    ```  
    C:\domren  
    ```  
  
5.  From within the working directory, type the following command, and then press ENTER:  
  
    ```  
    rendom /execute  
    ```  
  
     Running the **rendom \/execute** command reissues the execute\-specific RPC to that domain controller.  
  
 When all the domain controllers are in either the Done or Error state \(there should be no domain controller in the Prepared state\), declaring the execution of the domain rename instructions to be complete is at your discretion. You can continue to retry execution attempts on domain controllers that are in the Error state if you think that they will eventually succeed. However, when you declare that the execution of the domain rename instructions is:  
  
 Complete, and you will not retry the **rendom \/execute** command, you must remove AD DS from all domain controllers that are still in the Error state. For detailed step\-by\-step instructions to remove the AD DS server role, see the Step\-by\-Step Guide for Windows Server 2008 Active Directory Domain Services Installation and Removal \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=86716](http://go.microsoft.com/fwlink/?LinkID=86716)\).  
  
> [!NOTE]  
>  The Domain Name System \(DNS\) host names of the domain controllers in the renamed domains do not change automatically as a result of the domain rename operation. In other words, the DNS suffix in the fully qualified DNS host name of a domain controller in the renamed domain will continue to reflect the old domain name. You can use a special domain controller rename procedure, which you run as a separate post\-domain\-rename task, to change the DNS host name of a domain controller so that it conforms to the DNS name of the domain to which it is joined. For information about renaming domain controllers, see [Renaming a Domain Controller](../Topic/Renaming-a-Domain-Controller.md).  
  
  