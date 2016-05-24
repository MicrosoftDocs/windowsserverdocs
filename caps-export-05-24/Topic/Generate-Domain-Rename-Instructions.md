---
title: Generate Domain Rename Instructions
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 893dd70e-0e61-4b65-a652-48e7171b700f
author: Femila
---
# Generate Domain Rename Instructions
  You can use this procedure to generate domain rename instructions. In this procedure, you use the Rendom.exe tool to generate the domain rename instructions that are required to make your new target forest structure effective. Rendom.exe translates the new forest structure as specified in the edited forest description file that you prepared in [Specify the New Forest Description](../Topic/Specify-the-New-Forest-Description.md) into a sequence of directory update instructions that are run individually and remotely on each domain controller in the forest. The XML\-encoded script that contains the domain rename instructions is written to the single\-valued, octet\-string attribute **msDS\-UpdateScript** on the Partitions container object \(cn\=partitions,cn\=configuration,dc\=ForestRootDomain\) in the configuration directory partition on the domain naming operations master. For more information about the exact directory changes that occur on the domain naming master, see “Preparing Domain Controllers for Domain Rename” in How Domain Rename Works \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=124104](http://go.microsoft.com/fwlink/?LinkId=124104)\). Rendom.exe also generates a state file called Dclist.xml \(the default name\) and stores this file in the control station's working directory. The Dclist.xml state file is used to track the progress and state of each domain controller in the forest for the rest of the domain rename operation.  
  
 The following is a sample Dclist.xml file that is generated for the two\-domain forest in which there are two domain controllers named DC1 and DC2 in the cohovineyard.com domain and two domain controllers named DC3 and DC4 in the sales.cohovineyard.com domain.  
  
```  
<?xml version = “1.0”?>  
<DcList>  
  <Hash>zzzzzzzz</Hash>  
  <Signature>zzzzzzzz</Signature>  
  
  <DC>  
    <Name>DC1.cohovineyard.com</Name>  
    <State>Initial</State>  
    <LastError>0</LastError>  
    <Password />  
    <LastErrorMsg />  
    <FatalErrorMsg />  
    <Retry></Retry>  
  </DC>  
  <DC>  
    <Name>DC2.cohovineyard.com</Name>  
    <State>Initial</State>  
    <LastError>0</LastError>  
    <Password />  
    <LastErrorMsg />  
    <FatalErrorMsg />  
    <Retry></Retry>  
  </DC>  
  <DC>  
    <Name>DC3.sales.cohovineyard.com</Name>  
    <State>Initial</State>  
    <LastError>0</LastError>  
    <Password />  
    <LastErrorMsg />  
    <FatalErrorMsg />  
    <Retry></Retry>  
  </DC>  
  <DC>  
    <Name>DC4.sales.cohovineyard.com</Name>  
    <State>Initial</State>  
    <LastError>0</LastError>  
    <Password />  
    <LastErrorMsg />  
    <FatalErrorMsg />  
    <Retry></Retry>  
  </DC>  
</DcList>  
```  
  
 Notice that there is an entry for every domain controller in the forest in the Dclist.xml state file, and the state of each domain controller entry \(the field that is bounded by the \<State\>\<\/State\> tags\) is set to “Initial” at this step. This state will change independently for each domain controller as it progresses through the rest of the domain rename operation.  
  
 Ensure that the following conditions are in effect before you generate domain rename instructions:  
  
-   The source domain controller must be available and reachable. Rendom contacts one arbitrarily chosen domain controller in each domain \(or the domain controller that is designated for each domain in the \<DCname\>\<\/DCname\> field in the Domainlist.xml file\) to gather the information that is necessary to generate the domain rename instructions. The command might fail if a designated domain controller in a domain is unavailable or unreachable from the control station \(or if a designated domain controller was not specified, if no domain controller in a domain is reachable from the control station\).  
  
-   The domain naming master must be available and reachable. Rendom writes the domain rename instructions to the Partitions container in the Configuration directory partition on the domain naming master, and Rendom gathers the information that is necessary to generate the state file Dclist.xml. The command might fail if the domain naming master is unavailable or unreachable from the control station.  
  
 Membership in the **Enterprise Admins** group in the target forest \(with a write access to the Partitions container object and the cross\-reference objects that are its children in the configuration directory partition\) and the **Local Administrators** group \(or a write access to the domain rename C:\\domren working directory\) on the control station computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
> [!NOTE]  
>  You can use credentials other than the credentials with which you are currently logged on. To use alternative credentials, use the **\/user** and **\/pwd** command\-line switches of **rendom**, as described in [Appendix A: Command-Line Syntax for the Rendom Tool](../Topic/Appendix-A--Command-Line-Syntax-for-the-Rendom-Tool.md).  
  
### To generate the domain rename instructions and upload them to the domain naming master  
  
1.  On the control station, click **Start**, click **Run**, type **cmd**, and then click **OK**.  
  
2.  At the command prompt, type the following to change to the working directory, and then press ENTER:  
  
    ```  
    C:\domren  
    ```  
  
3.  From within the working directory, type the following command, and then press ENTER:  
  
    ```  
    rendom /upload  
    ```  
  
4.  Verify that the state file Dclist.xml is created in the working directory and that it contains an entry for every domain controller in your forest.  
  
  