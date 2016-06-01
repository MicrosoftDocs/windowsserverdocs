---
title: Create a Rule That Uses a File Hash Condition
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7019a8e7-4c65-4598-8d8c-97b05bd81d65
---
# Create a Rule That Uses a File Hash Condition
This topic shows how to create an AppLocker rule with a file hash condition in [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)].

File hash rules use a system\-computed cryptographic hash of the identified file.

For information about the file hash condition, see [Understanding the File Hash Rule Condition in AppLocker](http://technet.microsoft.com/library/ee460945(v=WS.10).aspx).

You can perform this task by using the Group Policy Management Console for an AppLocker policy in a Group Policy Object \(GPO\) or by using the Local Security Policy snap\-in for an AppLocker policy on a local computer or in a security template. For information how to use these MMC snap\-ins to administer AppLocker, see [Using the MMC snap\-ins to administer AppLocker](Administer-AppLocker.md#BKMK_Using_Snapins).

### <a name="BKMK_CreatHashCondforGPO"></a>To create a new rule with a file hash condition

1.  Open the snap\-in, and in the console tree, double\-click **Application Control Policies**, double\-click **AppLocker**, and then click the rule collection that you want to create the rule for.

2.  On the **Action** menu, click **Create New Rule**.

3.  On the **Before You Begin** page, click **Next**.

4.  On the **Permissions** page, select the action \(allow or deny\) and the user or group that the rule should apply to, and then click **Next**.

5.  On the **Conditions** page, select the **File hash** rule condition, and then click **Browse Files** to locate the targeted application file.

    > [!NOTE]
    > You can also click **Browse Folders** which calculates the hash for all the appropriate files relative to the rule collection. To remove hashes individually, click the **Remove** button.

6.  Click **Next**.

7.  On the **Name and Description** page, either accept the automatically generated rule name or type a new rule name, and then click **Create**.


