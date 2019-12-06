---
ms.assetid: 01988844-df02-4952-8535-c87aefd8a38a
title: Deploy Automatic File Classification (Demonstration Steps)
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Deploy Automatic File Classification (Demonstration Steps)

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic explains how to enable resource properties in Active Directory, create classification rules on the file server, and then assign values to the resource properties for files on the file server. For this example, the following classification rules are created:  
  
-   A content classification rule that searches a set of files for the string 'Contoso Confidential.' If the string is found in a file, the Impact resource property is set to High on the file.  
  
-   A content classification rule that searches a set of files for a regular expression that matches a social security number at least 10 times in one file. If the pattern is found, the file is classified as having personally identifiable information and the Personally Identifiable Information resource property is set to High.  
  
**In this document**  
  
-   [Step 1: Create resource property definitions](assetId:///4a96cdaf-0081-4824-aab8-f0d51be501ac#BKMK_Step1)  
  
-   [Step 2: Create a string content classification rule](assetId:///4a96cdaf-0081-4824-aab8-f0d51be501ac#BKMK_Step2)  
  
-   [Step 3: Create a regular expression content classification rule](assetId:///4a96cdaf-0081-4824-aab8-f0d51be501ac#BKMK_Step3)  
  
-   [Step 4: Verify that the files are classified](Deploy-Automatic-File-Classification--Demonstration-Steps-.md#BKMK_Step4)  
  
> [!NOTE]  
> This topic includes sample Windows PowerShell cmdlets that you can use to automate some of the procedures described. For more information, see [Using Cmdlets](https://go.microsoft.com/fwlink/p/?linkid=230693).  
  
## <a name="BKMK_Step1"></a>Step 1: Create resource property definitions  
The Impact and Personally Identifiable Information resource properties are enabled so that File Classification Infrastructure can use these resource properties to tag the files that are scanned on a network shared folder.  
  
[Do this step using Windows PowerShell](assetId:///4a96cdaf-0081-4824-aab8-f0d51be501ac#BKMK_PSstep1)  
  
#### To create resource property definitions  
  
1.  On the domain controller, sign in to the server as a member of the Domain Admins security group.  
  
2.  Open Active Directory Administrative Center. In Server Manager, click **Tools**, and then click **Active Directory Administrative Center**.  
  
3.  Expand **Dynamic Access Control**, and then click **Resource Properties**.  
  
4.  Right-click **Impact**, and then click **Enable**.  
  
5.  Right-click **Personally Identifiable Information**, and then click **Enable**.  
  
![solution guides](media/Deploy-Automatic-File-Classification--Demonstration-Steps-/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
Set-ADResourceProperty '"Enabled:$true '"Identity:'CN=Impact_MS,CN=Resource Properties,CN=Claims Configuration,CN=Services,CN=Configuration,DC=contoso,DC=com'   
Set-ADResourceProperty '"Enabled:$true '"Identity:'CN=PII_MS,CN=Resource Properties,CN=Claims Configuration,CN=Services,CN=Configuration,DC=contoso,DC=com'  
```  
  
## <a name="BKMK_Step2"></a>Step 2: Create a string content classification rule  
A string content classification rule scans a file for a specific string. If the string is found, the value of a resource property can be configured. In this example, we will scan each file on a network shared folder and look for the string 'Contoso Confidential.' If the string is found, the associated file is classified as having high business impact.  
  
[Do this step using Windows PowerShell](assetId:///4a96cdaf-0081-4824-aab8-f0d51be501ac#BKMK_PSstep2)  
  
#### To create a string content classification rule  
  
1.  Log on to the file server as a member of the Administrators security group.  
  
2.  From the Windows PowerShell command prompt, type **Update-FsrmClassificationPropertyDefinition** and then press ENTER. This will synchronize the property definitions created on the domain controller to the file server.  
  
3.  Open File Server Resource Manager. In Server Manager, click **Tools**, and then click **File Server Resource Manager**.  
  
4.  Expand **Classification Management**, right-click **Classification Rules**, and then click **Configure Classification Schedule**.  
  
5.  Select the **Enable fixed schedule** check box, select the **Allow continuous classification for new files** check box, choose a day of the week to run the classification, and then click **OK**.  
  
6.  Right-click **Classification Rules**, and then click **Create Classification Rule**.  
  
7.  On the **General** tab, in the **Rule name** box, type a rule name such as **Contoso Confidential**.  
  
8.  On the **Scope** tab, click **Add**, and choose the folders that should be included in this rule, such as D:\Finance Documents.  
  
    > [!NOTE]  
    > You can also choose a dynamic name space for the scope. For more information about dynamic name spaces for classification rules, see [What's New in File Server Resource Manager in Windows Server 2012 \[redirected\]](assetId:///d53c603e-6217-4b98-8508-e8e492d16083).  
  
9. On the **Classification** tab, configure the following:  
  
    -   In the **Choose a method to assign a property to files** box, ensure that **Content Classifier** is selected.  
  
    -   In the **Choose a property to assign to files** box, click **Impact**.  
  
    -   In the **Specify a value** box, click **High**.  
  
10. Under the **Parameters** heading, click **Configure**.  
  
11. In the **Expression Type** column, select **String**.  
  
12. In the **Expression** column, type **Contoso Confidential**, and then click **OK**.  
  
13. On the **Evaluation Type** tab, select the **Re-evaluate existing property values** check box, click **Overwrite the existing value**, and then click **OK**.  
  
![solution guides](media/Deploy-Automatic-File-Classification--Demonstration-Steps-/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
$date = Get-Date  
$AutomaticClassificationScheduledTask = New-FsrmScheduledTask -Time $date -Weekly @(3, 2, 4, 5,1,6,0) -RunDuration 0;$AutomaticClassificationScheduledTask  
Set-FsrmClassification -Continuous -schedule $AutomaticClassificationScheduledTask  
New-FSRMClassificationRule -Name 'Contoso Confidential' -Property "Impact_MS" -PropertyValue "3000" -Namespace @('D:\Finance Documents') -ClassificationMechanism "Content Classifier" -Parameters @("StringEx=Min=1;Expr=Contoso Confidential") -ReevaluateProperty Overwrite  
```  
  
## <a name="BKMK_Step3"></a>Step 3: Create a regular expression content classification rule  
A regular expression classification rule scans a file for a pattern that matches the regular expression. If a string that matches the regular expression is found, the value of a resource property can be configured. In this example, we will scan each file on a network shared folder and look for a string that matches the pattern of a social security number (XXX-XX-XXXX). If the pattern is found, the associated file is classified as having personally identifiable information.  
  
[Do this step using Windows PowerShell](assetId:///4a96cdaf-0081-4824-aab8-f0d51be501ac#BKMK_PSstep3)  
  
#### To create a regular expression content classification rule  
  
1.  Sign in to the file server as a member of the Administrators security group.  
  
2.  From the Windows PowerShell command prompt, type **Update-FsrmClassificationPropertyDefinition**, and then press ENTER. This will synchronize the property definitions that are created on the domain controller to the file server.  
  
3.  Open File Server Resource Manager. In Server Manager, click **Tools**, and then click **File Server Resource Manager**.  
  
4.  Right-click **Classification Rules**, and then click **Create Classification Rule**.  
  
5.  On the **General** tab, in the **Rule name** box, type a name for the classification rule, such as PII Rule.  
  
6.  On the **Scope** tab, click **Add**, and then choose the folders that should be included in this rule, such as D:\Finance Documents.  
  
7.  On the **Classification** tab, configure the following:  
  
    -   In the **Choose a method to assign a property to files** box, ensure that **Content Classifier** is selected.  
  
    -   In the **Choose a property to assign to files** box, click **Personally Identifiable Information**.  
  
    -   In the **Specify a value** box, click **High**.  
  
8.  Under the **Parameters** heading, click **Configure**.  
  
9. In the **Expression Type** column, select **Regular expression**.  
  
10. In the **Expression** column, type **^(?!000)([0-7]\d{2}|7([0-7]\d|7[012]))([ -]?)(?!00)\d\d\3(?!0000)\d{4}$**  
  
11. In the **Minimum Occurrences** column, type **10**, and then click **OK**.  
  
12. On the **Evaluation Type** tab, select the **Re-evaluate existing property values** check box, click **Overwrite the existing value**, and then click **OK**.  
  
![solution guides](media/Deploy-Automatic-File-Classification--Demonstration-Steps-/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
New-FSRMClassificationRule -Name "PII Rule" -Property "PII_MS" -PropertyValue "5000" -Namespace @('D:\Finance Documents') -ClassificationMechanism "Content Classifier" -Parameters @("RegularExpressionEx=Min=10;Expr=^(?!000)([0-7]\d{2}|7([0-7]\d|7[012]))([ -]?)(?!00)\d\d\3(?!0000)\d{4}$") -ReevaluateProperty Overwrite  
```  
  
## <a name="BKMK_Step4"></a>Step 4: Verify that the files are classified correctly  
You can verify that the files are properly classified by viewing the properties of a file that was created in the folder specified in the classification rules.  
  
#### To verify that the files are classified correctly  
  
1.  On the file server, run the classification rules by using File Server Resource Manager.  
  
    1.  Click **Classification Management**, right-click **Classification Rules**, and then click **Run Classification With All Rules Now**.  
  
    2.  Click the **Wait for classification to complete** option, and then click **OK**.  
  
    3.  Close the Automatic Classification Report.  
  
    4.  You can do this by using Windows PowerShell with the following command: **Start-FSRMClassification '"RunDuration 0 -Confirm:$false**  
  
2.  Navigate to the folder that was specified in the classification rules, such as D:\Finance Documents.  
  
3.  Right-click a file in that folder, and then click **Properties**.  
  
4.  Click the **Classification** tab, and verify that the file is classified correctly.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Scenario: Get Insight into Your Data by Using Classification](Scenario--Get-Insight-into-Your-Data-by-Using-Classification.md)  
  
-   [Plan for Automatic File Classification](https://docs.microsoft.com/previous-versions/orphan-topics/ws.11/jj574209(v%3dws.11))  

  
-   [Dynamic Access Control: Scenario Overview](Dynamic-Access-Control--Scenario-Overview.md)  
  

