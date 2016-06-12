---
title: Display a Custom URL Message When Users Try to Run a Blocked Application
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 50525670-f64f-47e6-a0bc-e2726d6a4416
---
# Display a Custom URL Message When Users Try to Run a Blocked Application
This topic describes the steps for displaying a customized message to users when an applocker policy denies access to an application in  Windows Server 2012  and Windows 8.

Using Group Policy, applocker can be configured to display a message with a custom URL. You can use this URL to redirect users to a support site that contains information about why the user received the error and which applications are allowed. If you do not display a custom message when an application is blocked, the default access denied message is displayed.

To complete this procedure, you must have Edit Setting permission to edit a GPO. By default, members of the **Domain Admins** group, the **Enterprise Admins** group, and the **Group Policy Creator Owners** group have this permission.

#### To display a custom URL message when users try to run a blocked application

1.  On the **Start** screen, type**gpmc.msc** to open the Group Policy Management Console \(GPMC\).

2.  Navigate to the Group Policy Object \(GPO\) that you want to edit.

3.  Right\-click the GPO, and then click **Edit**.

4.  In the console tree under **Policies\\Administrative Templates\\Windows Components**, click **Windows Explorer**.

5.  In the details pane, double\-click **Set a support web page link**.

6.  Click **Enabled**, and then type the URL of the custom Web page in the **Support Web page URL** box.

7.  Click **OK** to apply the setting.


