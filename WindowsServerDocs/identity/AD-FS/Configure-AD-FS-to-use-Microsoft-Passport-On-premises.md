---
title: Configure AD FS to use Microsoft Passport On-premises
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1f67f11b-b96c-4aa0-98fb-9302f1dd23fe
author: billmath
---
# Configure AD FS to use Microsoft Passport On-premises

  
  
    
The following document describes how to configure AD FS to use Microsoft Passport accounts for authentication on-premises.

## Prerequisites
The following prerequisites are required before attempting the the steps in this doc.

* The schema for Active Directory must be upgraded to Windows Server 2016
* Forest functional-level for AD FS must be Windows Server 2016.
## Step 1:  Configure AD FS and Device Registration 
Enable device registration by doing the following:

>[!NOTE] Enterprise Administrator permissions are required to complete this step.

1. Launch **AD FS Management.**
2. Navigate to **Service** > **Device Registration.**
3. Under Status, select the **Configure Device Registration** link. 

![Configure Device Registrationmedia/ADFS_PASS_1.png)

4. Click **OK**.

![Click OKmedia/ADFS_PASS_2.png)

5. Device registration should now  be configured and a green status bar should be present.

![Green statusmedia/ADFS_PASS_3.png)

## Step 2:  Configure Group Policy for Automatic registration of domain joined devices.
 Follow the instructions below to create and link a Group Policy to computers in your domains:
1.	Open **Server Manager** and navigate to **Tools** > **Group Policy Management**. 
2.	From **Group Policy Management**, navigate to your domain node and expand it.
3.	Right-click **Group Policy Objects** and select **New**. 

![ADFS_PASS_8media/ADFS_PASS_4.png)

4. Give your Group Policy object a **name**, for example, Automatic Registration. Click **OK**. 

![ADFS_PASS_8media/ADFS_PASS_5.png)

5.	Right-click on your new **Group Policy object** and then select **Edit**. 

![ADFS_PASS_8media/ADFS_PASS_6.png)

6.	Navigate to **Computer Configuration/Policies/Administrative Templates/Windows Components/Device Registration.** 

![ADFS_PASS_8media/ADFS_PASS_7.png)

6.	Right-click **Register domain joined computers as devices** and select **Edit**.

![ADFS_PASS_8media/ADFS_PASS_8.png)

7.	Select the **Enabled** radio button and then click **Apply**. Click **OK**.

![ADFS_PASS_8media/ADFS_PASS_9.png)

8.	Navigate to Computer **Configuration/Policies/Administrative Templates/Windows Components/Microsoft Passport for Work**.

![ADFS_PASS_8media/ADFS_PASS_10.png)

9.	Right-click **Use Microsoft Passport for Work** and select **Edit**.

![ADFS_PASS_8media/ADFS_PASS_11.png)

10.	Select the **Enabled** radio button and then click **Apply**. Click **OK**.

![ADFS_PASS_8media/ADFS_PASS_12.png)


11.	You may now link the Group Policy object to a location of your choice. To enable this policy for all of the domain joined devices at your organization, link the Group Policy to the domain. 


## Step 3:  Configure Kerberos with a root KDC 
The instructions below illustrate how to use a Microosft Enterprise PKI to deploy the KDC certificate to domain controllers and clients. Most PKI solutions can also be used for this task.
### (Optional) Install and configure a Microsoft Enterprise CA
If you need an Enterprise CA and your environment does not currently have one, you can install a Microsoft Enterprise CA using the following steps:

1.  Select a server that will be used as your Enteprise CA.
2.  Open **Server Manager** and click **Add roles and features**

![Server Managermedia/ADFS_PASS_13.png)

3.  On the **Add roles and features wizard** click **Next.**
4.  On the **Select installation type** screen keep the default of R**ole-based or feature-based installation** and click **Next**.
5.  On the **Select destination server** screen click **Next.**
6.  On the **Select server role** screen, place a check in **Active Directory Certificate Services**.
7. On the pop-up, click **Add Features.**

![Server Managermedia/ADFS_PASS_14.png)

8. Click **Next.**

![Server Managermedia/ADFS_PASS_15.png)

9. On the **Select features** screen, click **Next.**
10. On the **Active Directory Certificate Services** screen, click **Next.**
11. On the **Select role services** screen, click **Next.**
12. On the **Confirmation installation selections** screen, click **Install.**
13.  Once that completes, click **Close.**
14.  In **Server Manager**, at the top, click on the yellow triangle and select **Configure Active Directory Certificate Services on the destination server**.

![Server Managermedia/ADFS_PASS_16.png)

15.  On the **Credentials** screen, click **Next**.

![Server Managermedia/ADFS_PASS_17.png)

16.  On the **Role Services** screen, place a check in the box next to **Certificate Authority** and click **Next**.

![Server Managermedia/ADFS_PASS_18.png)

17. On the **Setup Type** screen, leave Enterprise CA and click **Next.**
18.  On the **CA Type** screen, click **Next**.
19.  On the **Private Key** screen, click **Next**.
20.  On the **Cryptography** screen, click **Next**.
21.  On the **CA Name** screen, click **Next**.
22. On the **Validity Period** screen, click **Next**.
23. on the **Certificate Database** screen, click **Next**.
24. On the **Confirmation** screen, click **Configure**.
25.  Once the configuration completes, click **Close**.

### Enroll in a KDC root certificate
Now on each domain controller, you must enroll in a KDC root certificate.  Use the following steps to enroll.

1.  Open an MMC by going to **Start** -> **Run**, type **mmc** and hit **.**
2.  Go to **File** -> **Add\Remove Snap-ins** -> select **Certificates** -> click **Add** -> select **Computer Account** -> click **Next** -> leave **Local computer** selected -> click **Finish.**

![MMCmedia/ADFS_PASS_19.png)

3.  Click **OK.**

![Add Removemedia/ADFS_PASS_20.png)

4.  In left-hand tree view, drill down to **Personal** -> **Certificates**, then right-click anhd select **All Tasks** -> **Request New Certificate.** 

![Request New Certmedia/ADFS_PASS_21.png)

5.  Click **Next.**
6.  On **Select Certificate Enrollment Policy** screen , click **Next.**
7.  On **Request Certificates** page, select **Kerberos Authentication**, then click **Enroll**.

![Add Removemedia/ADFS_PASS_22.png)

8.  Once that completes, click **Finish**.
8.  Now reboot your client computers. The KDC root certificate will be installed when the computer Group Policy is applied.




