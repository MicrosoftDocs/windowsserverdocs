---
ms.assetid: 2c76e81a-c2eb-439f-a89f-7d3d70790244
title: Deploy Encryption of Office Files (Demonstration Steps)
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Deploy Encryption of Office Files (Demonstration Steps)

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Contoso's Finance Department has a number of file servers that store their documents. These documents can be general documentation or they can have a high-business impact (HBI). For example, any document that contains confidential information is deemed, by Contoso, to have a high-business impact. Contoso wants to ensure that all their documentation has a minimum amount of protection and that their HBI documentation is restricted to the appropriate people. To accomplish this, Contoso is exploring using the File Classification Infrastructure (FCI) and AD RMS that is available in  Windows Server 2012 . By using FCI, Contoso will classify all of the documents on their file server, based on the content, and then use AD RMS to apply the appropriate rights policy.  
  
In this scenario, you'll perform the following steps:  
  
|Task|Description|  
|--------|---------------|  
|[Enable resource properties](Deploy-Encryption-of-Office-Files--Demonstration-Steps-.md#BKMK_1.1)|Enable the **Impact** and **Personally Identifiable Information** resource properties.|  
|[Create classification rules](Deploy-Encryption-of-Office-Files--Demonstration-Steps-.md#BKMK_2)|Create the following classification rules: **HBI Classification Rule** and **PII Classification Rule**.|  
|[Use file management tasks to automatically protect documents with AD RMS](Deploy-Encryption-of-Office-Files--Demonstration-Steps-.md#BKMK_3)|Create a file management task that automatically used AD RMS to protect documents with high personally identifiable information (PII). Only members of the FinanceAdmin group will have access to documents that contain high PII.|  
|[View the results](Deploy-Encryption-of-Office-Files--Demonstration-Steps-.md#BKMK_4)|Examine the classification of documents and observe how they change as you change the content in the document. Also verify how the document gets protected by AD RMS.|  
|[Verify AD RMS protection](Deploy-Encryption-of-Office-Files--Demonstration-Steps-.md#BKMK_5)|Verify that the document is protected with AD RMS.|  
|||  
  
## <a name="BKMK_1.1"></a>Step 1: Enable resource properties  
  
#### To enable resource properties  
  
1. In Hyper-V Manager, connect to server ID_AD_DC1. Sign in to the server by using Contoso\Administrator with the password <strong>pass@word1</strong>.  
  
2. Open Active Directory Administrative Center, and click **Tree View**.  
  
3. Expand **DYNAMIC ACCESS CONTROL**, and select **Resource Properties**.  
  
4. Scroll down to the **Impact** property in the **Display name** column. Right-click **Impact**, and then click **Enable**.  
  
5. Scroll down to the **Personally Identifiable Information** property in the **Display name** column. Right-click **Personally Identifiable Information**, and then click **Enable**.  
  
6. To publish the resource properties in the **Global Resource List**, in the left pane, click **Resource Property Lists**, and then double-click **Global Resource Property List**.  
  
7. Click **Add**, and then scroll down to and click **Impact** to add it to the list. Do the same for **Personally Identifiable Information**. Click **OK** twice to finish.  
  
![solution guides](media/Deploy-Encryption-of-Office-Files--Demonstration-Steps-/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
Set-ADResourceProperty -Enabled:$true -Identity:"CN=Impact_MS,CN=Resource Properties,CN=Claims Configuration,CN=Services,CN=Configuration,DC=contoso,DC=com"  
Set-ADResourceProperty -Enabled:$true -Identity:"CN=PII_MS,CN=Resource Properties,CN=Claims Configuration,CN=Services,CN=Configuration,DC=contoso,DC=com" 
```  
  
## <a name="BKMK_2"></a>Step 2: Create classification rules  
This step explains how to create the **High Impact** classification rule. This rule will search the content of documents and if the string "Contoso Confidential" is found, it will classify this document as having high-business impact. This classification will override any previously assigned classification of low-business impact.  
  
You will also create a **High PII** rule. This rule searches the content of documents, and if a Social Security number is found, it classifies the document as having high PII.  
  
#### To create the high-impact classification rule  
  
1. In Hyper-V Manager, connect to server ID_AD_FILE1. Sign in to the server by using Contoso\Administrator with the password <strong>pass@word1</strong>.  
  
2. You need to refresh the Global Resource Properties from Active Directory. Open Windows PowerShell and type: `Update-FSRMClassificationPropertyDefinition`, and then press ENTER. Close Windows PowerShell.  
  
3. Open File Server Resource Manager. To open File Server Resource Manager, click **Start**, type **file server resource manager**, and then click **File Server Resource Manager**.  
  
4. In the left pane of File Server Resource Manager, expand **Classification Management**, and then select **Classification Rules**.  
  
5. In the **Actions** pane, click **Configure Classification Schedule**. On the **Automatic Classification** tab, select **Enable fixed schedule**, select a **Day of the week**, and then select the **Allow continuous classification for new files** check box. Click **OK**.  
  
6. In the **Actions** pane, click **Create Classification Rule**. This opens the **Create Classification Rule** dialog box.  
  
7. In the **Rule name** box, type **High Business Impact**.  
  
8. In the **Description** box, type **Determines if the document has a high business impact based on the presence of the string "Contoso Confidential"**  
  
9. On the **Scope** tab, click **Set Folder Management Properties**, select **Folder Usage**, click **Add**, then click **Browse**, browse to D:\Finance Documents as the path, click **OK**, and then choose a property value named **Group Files** and click **Close**. Once management properties are set, on the **Rule Scope** tab select **Group Files**.  
  
10. Click the **Classification** tab.  Under **Choose a method to assign the property to files**, select **Content Classifier** from the drop-down list.  
  
11. Under **Choose a property to assign to files**, select **Impact** from the drop-down list.  
  
12. Under **Specify a value**, select **High** from the drop-down list.  
  
13. Click **Configure** under **Parameters**.  In the **Classification Parameters** dialog box, in the **Expression Type** list, select **String**. In the **Expression** box, type: **Contoso Confidential**, and then click **OK**.  
  
14. Click the **Evaluation Type** tab.  Click **Re-evaluate existing property values**, click **Overwrite**the existing value, and then click **OK** to finish.  
  
![solution guides](media/Deploy-Encryption-of-Office-Files--Demonstration-Steps-/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
Update-FSRMClassificationPropertyDefinition  
$date = Get-Date  
$AutomaticClassificationScheduledTask = New-FsrmScheduledTask -Time $date -Weekly @(3, 2, 4, 5,1,6,0) -RunDuration 0;  
Set-FsrmClassification -Continuous -schedule $AutomaticClassificationScheduledTask  
New-FSRMClassificationRule -Name "High Business Impact" -Property "Impact_MS" -Description "Determines if the document has a high business impact based on the presence of the string 'Contoso Confidential'" -PropertyValue "3000" -Namespace @("D:\Finance Documents") -ClassificationMechanism "Content Classifier" -Parameters @("StringEx=Min=1;Expr=Contoso Confidential") -ReevaluateProperty Overwrite  
```  
  
#### To create the high-PII classification rule  
  
1. In Hyper-V Manager, connect to server ID_AD_FILE1. Sign in to the server by using Contoso\Administrator with the password <strong>pass@word1</strong>.  
  
2. On the desktop, open the folder named **Regular Expressions**, and then open the text document named **RegEx-SSN**. Highlight and copy the following regular expression string:  **^(?!000)([0-7]\d{2}|7([0-7]\d|7[012]))([ -]?)(?!00)\d\d\3(?!0000)\d{4}$**. This string will be used later in this step so keep it on your clipboard.  
  
3. Open File Server Resource Manager. To open File Server Resource Manager, click **Start**, type **file server resource manager**, and then click **File Server Resource Manager**.  
  
4. In the left pane of File Server Resource Manager, expand **Classification Management**, and then select **Classification Rules**.  
  
5. In the **Actions** pane, click **Configure Classification Schedule**. On the **Automatic Classification** tab, select **Enable fixed schedule**, select a **Day of the week**, and then select the **Allow continuous classification for new files** check box. Click OK.  
  
6. In the **Rule name** box, type **High PII**. In the **Description** box, type **Determines if the document has a high PII based on the presence of a Social Security Number.**  
  
7. Click the **Scope** tab, select the **Group Files** check box.  
  
8. Click the **Classification** tab.  Under **Choose a method to assign the property to files**, select **Content Classifier** from the drop-down list.  
  
9. Under **Choose a property to assign to files**, select **Personally Identifiable Information** from the drop-down list.  
  
10. Under **Specify a value**, select **High** from the drop-down list.  
  
11. Click **Configure** under **Parameters**.   
    In the **Classification Parameters**window, in the **Expression Type** list, select **Regular Expression**. In the **Expression** box, paste the text from your clipboard: **^(?!000)([0-7]\d{2}|7([0-7]\d|7[012]))([ -]?)(?!00)\d\d\3(?!0000)\d{4}$**, and then click **OK**.  
  
    > [!NOTE]  
    > This expression will allow invalid Social Security numbers. This allows us to use fictitious Social Security numbers in the demonstration.  
  
12. Click the **Evaluation Type** tab.  Select **Re-evaluate existing property values**, **Overwrite**the existing value, and then click **OK** to finish.  
  
![solution guides](media/Deploy-Encryption-of-Office-Files--Demonstration-Steps-/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
New-FSRMClassificationRule -Name "High PII" -Description "Determines if the document has a high PII based on the presence of a Social Security Number." -Property "PII_MS" -PropertyValue "5000" -Namespace @("D:\Finance Documents") -ClassificationMechanism "Content Classifier" -Parameters @("RegularExpressionEx=Min=1;Expr=^(?!000)([0-7]\d{2}|7([0-7]\d|7[012]))([ -]?)(?!00)\d\d\3(?!0000)\d{4}$") -ReevaluateProperty Overwrite  
```  
  
You should now have two classification rules:  
  
-   High Business Impact  
  
-   High PII  
  
## <a name="BKMK_3"></a>Step 3: Use file management tasks to automatically protect documents with AD RMS  
Now that you've created rules to automatically classify documents based on content, the next step is to create a file management task that uses AD RMS to automatically protect certain documents based on their classification. In this step, you will create a file management task that automatically protects any documents with a high PII. Only members of the FinanceAdmin group will have access to documents that contain high PII.  
  
#### To protect documents with AD RMS  
  
1. In Hyper-V Manager, connect to server ID_AD_FILE1. Sign in to the server by using Contoso\Administrator with the password <strong>pass@word1</strong>.  
  
2. Open File Server Resource Manager. To open File Server Resource Manager, click **Start**, type **file server resource manager**, and then click **File Server Resource Manager**.  
  
3. In the left pane, select **File Management Tasks**. In the **Actions** pane, select **Create File Management Task**.  
  
4. In the **Task name:** field, type **High PII**. In the **Description** field, type **Automatic RMS protection for high PII documents**.  
  
5. Click the **Scope** tab, select the **Group Files** check box.  
  
6. Click the **Action** tab. Under **Type**, select **RMS Encryption**. Click **Browse** to select a template, and then select the **Contoso Finance Admin Only** template.  
  
7. Click the **Condition** tab, and then click **Add**. Under **Property**, select **Personally Identifiable Information**. Under **Operator**, select **Equal**. Under **Value**, select **High**. Click **OK**.  
  
8. Click the **Schedule** tab. In the **Schedule** section, click **Weekly**, and then select **Sunday**. Running the task once-a-week will ensure that you catch any documents that may have been missed due to a service outage or other disruptive event.  
  
9. In the **Continuous operation** section, select **Run task continuously on new files**, and then click **OK**. You should now have a file management task named High PII.  
  
![solution guides](media/Deploy-Encryption-of-Office-Files--Demonstration-Steps-/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
$fmjRmsEncryption = New-FSRMFmjAction -Type 'Rms' -RmsTemplate 'Contoso Finance Admin Only'  
$fmjCondition1 = New-FSRMFmjCondition -Property 'PII_MS' -Condition 'Equal' -Value '5000'  
$date = get-date  
$schedule = New-FsrmScheduledTask -Time $date -Weekly @('Sunday')    
$fmj1=New-FSRMFileManagementJob -Name "High PII" -Description "Automatic RMS protection for high PII documents" -Namespace @('D:\Finance Documents') -Action $fmjRmsEncryption -Schedule $schedule -Continuous -Condition @($fmjCondition1)  
```  
  
## <a name="BKMK_4"></a>Step 4: View the results  
It's time to take a look at your new automatic classification and AD RMS protection rules in action. In this step you will examine the classification of documents and observe how they change as you change the content in the document.  
  
#### To view the results  
  
1. In Hyper-V Manager, connect to server ID_AD_FILE1. Sign in to the server by using Contoso\Administrator with the password <strong>pass@word1</strong>.  
  
2. In Windows Explorer, navigate to D:\Finance Documents.  
  
3. Right-click the Finance Memo document and click **Properties**.Click the **Classification** tab, and notice that the Impact property currently has no value. Click **Cancel**.  
  
4. Right-click the **Request for Approval to Hire document**, and then select **Properties**.  
  
5. Click the **Classification** tab, and notice that **the Personally Identifiable Information property** currently has no value. Click **Cancel**.  
  
6. Switch to CLIENT1. Sign off any user who is signed in, and then sign in as Contoso\MReid with the password <strong>pass@word1</strong>.  
  
7. From the Desktop, open the **Finance Documents** shared folder.  
  
8. Open the **Finance Memo** document. Near the bottom of the document, you will see the word **Confidential**. Modify it to read: **Contoso Confidential**. Save the document and close it.  
  
9. Open the **Request for Approval to Hire** document. In the **Social Security#:** section, type: 777-77-7777. Save the document and close it.  
  
    > [!NOTE]  
    > You may need to wait 30 seconds for the classification to occur.  
  
10. Switch back to ID_AD_FILE1. In Windows Explorer, navigate to D:\Finance Documents.  
  
11. Right-click the Finance Memo document, and click **Properties**. Click the **Classification** tab. Notice that the **Impact** property is now set to **High**. Click **Cancel**.  
  
12. Right-click the Request for Approval to Hire document and click **Properties**.  
  
13. . Click the **Classification** tab. Notice that the **Personally Identifiable Information** property is now set to **High**. Click **Cancel**.  
  
## <a name="BKMK_5"></a>Step 5: Verify protection with AD RMS  
  
#### To verify that the document is protected  
  
1.  Switch back to ID_AD_CLIENT1.  
  
2.  Open the **Request for approval to Hire** document.  
  
3.  Click **OK** to allow the document to connect to your AD RMS server.  
  
4.  You can now see that the document has been protected by AD RMS because it contains a Social Security number.  
  

