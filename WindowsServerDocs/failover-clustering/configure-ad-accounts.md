---
Title: 'Configuring cluster accounts in Active Directory'
ms.date: 11/12/2012
ms.prod: windows-server-threshold
ms.technology: storage-failover-clustering
author: JasonGerend
manager: elizapo
ms.author: jgerend
---

# Configuring cluster accounts in Active Directory


Applies To: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, and Windows Server 2008

In Windows Server, when you create a failover cluster and configure clustered services or applications, the failover cluster wizards create the necessary Active Directory computer accounts (also called computer objects) and give them specific permissions. The wizards create a computer account for the cluster itself (this account is also called the cluster name object or CNO) and a computer account for most types of clustered services and applications, the exception being a Hyper-V virtual machine. The permissions for these accounts are set automatically by the failover cluster wizards. If the permissions are changed, they will need to be changed back to match cluster requirements. This guide describes these Active Directory accounts and permissions, provides background about why they are important, and describes steps for configuring and managing the accounts.
      

## Overview of Active Directory accounts needed by a failover cluster

This section describes the Active Directory computer accounts (also called Active Directory computer objects) that are important for a failover cluster. These accounts are as follows:

  - **The user account used to create the cluster.** This is the user account used to start the Create Cluster wizard. The account is important because it provides the basis from which a computer account is created for the cluster itself.  
      
  - **The cluster name account.** (the computer account of the cluster itself, also called the cluster name object or CNO). This account is created automatically by the Create Cluster wizard and has the same name as the cluster. The cluster name account is very important, because through this account, other accounts are automatically created as you configure new services and applications on the cluster. If the cluster name account is deleted or permissions are taken away from it, other accounts cannot be created as required by the cluster, until the cluster name account is restored or the correct permissions are reinstated.  
      
    For example, if you create a cluster called Cluster1 and then try to configure a clustered print server called PrintServer1 on your cluster, the Cluster1 account in Active Directory will need to retain the correct permissions so that it can be used to create a computer account called PrintServer1.  
      
    The cluster name account is created in the default container for computer accounts in Active Directory. By default this is the “Computers” container, but the domain administrator can choose to redirect it to another container or organizational unit (OU).  
      
  - **The computer account (computer object) of a clustered service or application.** These accounts are created automatically by the High Availability wizard as part of the process of creating most types of clustered services or application, the exception being a Hyper-V virtual machine. The cluster name account is granted the necessary permissions to control these accounts.  
      
    For example, if you have a cluster called Cluster1 and then you create a clustered file server called FileServer1, the High Availability wizard creates an Active Directory computer account called FileServer1. The High Availability wizard also gives the Cluster1 account the necessary permissions to control the FileServer1 account.  
      

The following table describes the permissions required for these accounts.


<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr class="header">
<th>Account</th>
<th>Details about permissions</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Account used to create the cluster</p></td>
<td><p>Requires administrative permissions on the servers that will become cluster nodes. Also requires <strong>Create Computer objects</strong> and <strong>Read All Properties</strong> permissions in the container that is used for computer accounts in the domain.</p></td>
</tr>
<tr class="even">
<td><p>Cluster name account (computer account of the cluster itself)</p></td>
<td><p>When the Create Cluster wizard is run, it creates the cluster name account in the default container that is used for computer accounts in the domain. By default, the cluster name account (like other computer accounts) can create up to ten computer accounts in the domain.</p>
<p>If you create the cluster name account (cluster name object) before creating the cluster—that is, prestage the account—you must give it the <strong>Create Computer objects</strong> and <strong>Read All Properties</strong> permissions in the container that is used for computer accounts in the domain. You must also disable the account, and give <strong>Full Control</strong> of it to the account that will be used by the administrator who installs the cluster. For more information, see <a href="#steps-for-prestaging-the-cluster-name-account" data-raw-source="[Steps for prestaging the cluster name account](#steps-for-prestaging-the-cluster-name-account)">Steps for prestaging the cluster name account</a>, later in this guide.</p></td>
</tr>
<tr class="odd">
<td><p>Computer account of a clustered service or application</p></td>
<td><p>When the High Availability wizard is run (to create a new clustered service or application), in most cases a computer account for the clustered service or application is created in Active Directory. The cluster name account is granted the necessary permissions to control this account. The exception is a clustered Hyper-V virtual machine: no computer account is created for this.</p>
<p>If you prestage the computer account for a clustered service or application, you must configure it with the necessary permissions. For more information, see <a href="#steps-for-prestaging-an-account-for-a-clustered-service-or-application" data-raw-source="[Steps for prestaging an account for a clustered service or application](#steps-for-prestaging-an-account-for-a-clustered-service-or-application)">Steps for prestaging an account for a clustered service or application</a>, later in this guide.</p></td>
</tr>
</tbody>
</table>


> [!NOTE]
> In earlier versions of Windows Server, there was an account for the Cluster service. Since Windows Server 2008, however, the Cluster service automatically runs in a special context that provides the specific permissions and privileges necessary for the service (similar to the local system context, but with reduced privileges). Other accounts are needed, however, as described in this guide. 
<br>


### How accounts are created through wizards in failover clustering

The following diagram illustrates the use and creation of computer accounts (Active Directory objects) that are described in the previous subsection. These accounts come into play when an administrator runs the Create Cluster wizard and then runs the High Availability wizard (to configure a clustered service or application).

![](media/configure-ad-accounts/Cc731002.e8a7686c-9ba8-4ddf-87b1-175b7b51f65d(WS.10).gif)

Note that the above diagram shows a single administrator running both the Create Cluster wizard and the High Availability wizard. However, this could be two different administrators using two different user accounts, if both accounts had sufficient permissions. The permissions are described in more detail in Requirements related to failover clusters, Active Directory domains, and accounts, later in this guide.

### How problems can result if accounts needed by the cluster are changed

The following diagram illustrates how problems can result if the cluster name account (one of the accounts required by the cluster) is changed after it is automatically created by the Create Cluster wizard.

![](media/configure-ad-accounts/Cc731002.beecc4f7-049c-4945-8fad-2cceafd6a4a5(WS.10).gif)

If the type of problem shown in the diagram occurs, a certain event (1193, 1194, 1206, or 1207) is logged in Event Viewer. For more information about these events, see [http://go.microsoft.com/fwlink/?LinkId=118271](http://go.microsoft.com/fwlink/?linkid=118271).

Note that a similar problem with creating an account for a clustered service or application can occur if the domain-wide quota for creating computer objects (by default, 10) has been reached. If it has, it might be appropriate to consult with the domain administrator about increasing the quota, although this is a domain-wide setting and should be changed only after careful consideration, and only after confirming that the preceding diagram does not describe your situation. For more information, see [Steps for troubleshooting problems caused by changes in cluster-related Active Directory accounts](#steps-for-troubleshooting-problems-caused-by-changes-in-cluster-related-active-directory-accounts), later in this guide.

## Requirements related to failover clusters, Active Directory domains, and accounts

As described in the preceding three sections, certain requirements must be met before clustered services and applications can be successfully configured on a failover cluster. The most basic requirements concern the location of cluster nodes (within a single domain) and the level of permissions of the account of the person who installs the cluster. If these requirements are met, the other accounts required by the cluster can be created automatically by the failover cluster wizards. The following list provides details about these basic requirements.

  - **Nodes:** All nodes must be in the same Active Directory domain. (The domain cannot be based on Windows NT 4.0, which does not include Active Directory.)  
      
  - **Account of the person who installs the cluster:** The person who installs the cluster must use an account with the following characteristics:  
      
      - The account must be a domain account. It does not have to be a domain administrator account. It can be a domain user account if it meets the other requirements in this list.  
          
      - The account must have administrative permissions on the servers that will become cluster nodes. The simplest way to provide this is to create a domain user account, and then add that account to the local Administrators group on each of the servers that will become cluster nodes. For more information, see [Steps for configuring the account for the person who installs the cluster](#steps-for-configuring-the-account-for-the-person-who-installs-the-cluster), later in this guide.  
          
      - The account (or the group that the account is a member of) must be given the **Create Computer objects** and **Read All Properties** permissions in the container that is used for computer accounts in the domain. Another alternative is to make the account a domain administrator account. For more information, see [Steps for configuring the account for the person who installs the cluster](#steps-for-configuring-the-account-for-the-person-who-installs-the-cluster), later in this guide.  
          
      - If your organization chooses to prestage the cluster name account (a computer account with the same name as the cluster), the prestaged cluster name account must give “Full Control” permission to the account of the person who installs the cluster. For other important details about how to prestage the cluster name account, see [Steps for prestaging the cluster name account](#steps-for-prestaging-the-cluster-name-account), later in this guide.  
          

### Planning ahead for password resets and other account maintenance

The administrators of failover clusters might sometimes need to reset the password of the cluster name account. This action requires a specific permission, the **Reset password** permission. Therefore, it is a best practice to edit the permissions of the cluster name account (by using the Active Directory Users and Computers snap-in) to give the administrators of the cluster the **Reset password** permission for the cluster name account. For more information, see [Steps for troubleshooting password problems with the cluster name account](#steps-for-troubleshooting-password-problems-with-the-cluster-name-account), later in this guide.

## Steps for configuring the account for the person who installs the cluster

The account of the person who installs the cluster is important because it provides the basis from which a computer account is created for the cluster itself.

The minimum group membership required to complete the following procedure depends on whether you are creating the domain account and assigning it the required permissions in the domain, or whether you are only placing the account (created by someone else) into the local **Administrators** group on the servers that will be nodes in the failover cluster. If the former, membership in **Account Operators** or **Domain Admins**, or equivalent, is the minimum required to complete this procedure. If the latter, membership in the local **Administrators** group on the servers that will be nodes in the failover cluster, or equivalent, is all that is required. Review details about using the appropriate accounts and group memberships at [http://go.microsoft.com/fwlink/?LinkId=83477](http://go.microsoft.com/fwlink/?linkid=83477).

#### To configure the account for the person who installs the cluster

1.  Create or obtain a domain account for the person who installs the cluster. This account can be a domain user account or a domain administrator account (in **Domain Admins** or an equivalent group).

2.  If the account that was created or obtained in step 1 is a domain user account, or the domain administrator accounts in your domain are not automatically included in the local **Administrators** group on computers in the domain, add the account to the local **Administrators** group on the servers that will be nodes in the failover cluster:
    
    1.  Click **Start**, click **Administrative Tools**, and then click **Server Manager**.  
          
    2.  In the console tree, expand **Configuration**, expand **Local Users and Groups**, and then expand **Groups**.  
          
    3.  In the center pane, right-click **Administrators**, click **Add to Group**, and then click **Add**.  
          
    4.  Under **Enter the object names to select**, type the name of the user account that was created or obtained in step 1. If prompted, enter an account name and password with sufficient permissions for this action. Then click **OK**.  
          
    5.  Repeat these steps on each server that will be a node in the failover cluster.  
          
    

> [!IMPORTANT]
> These steps must be repeated on all servers that will be nodes in the cluster. 
<br>


3. If the account that was created or obtained in step 1 is a domain administrator account, skip the rest of this procedure. Otherwise, give the account the **Create Computer objects** and **Read All Properties** permissions in the container that is used for computer accounts in the domain:
    
   1.  On a domain controller, click **Start**, click **Administrative Tools**, and then click **Active Directory Users and Computers**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
          
   2.  On the **View** menu, make sure that **Advanced Features** is selected.  
          
       When **Advanced Features** is selected, you can see the **Security** tab in the properties of accounts (objects) in **Active Directory Users and Computers**.  
          
   3.  Right-click the default **Computers** container or the default container in which computer accounts are created in your domain, and then click **Properties**. **Computers** is located in <b>Active Directory Users and Computers/</b><i>domain-node</i><b>/Computers</b>.  
          
   4.  On the **Security** tab, click **Advanced**.  
          
   5.  Click **Add**, type the name of the account that was created or obtained in step 1, and then click **OK**.  
          
   6.  In the **Permission Entry for***container* dialog box, locate the **Create Computer objects** and **Read All Properties** permissions, and make sure that the **Allow** check box is selected for each one.  
          
       ![](media/configure-ad-accounts/Cc731002.0a863ac5-2024-4f9f-8a4d-a419aff32fa0(WS.10).gif)

## Steps for prestaging the cluster name account

It is usually simpler if you do not prestage the cluster name account, but instead allow the account to be created and configured automatically when you run the Create Cluster wizard. However, if it is necessary to prestage the cluster name account because of requirements in your organization, use the following procedure.

Membership in the **Domain Admins** group, or equivalent, is the minimum required to complete this procedure. Review details about using the appropriate accounts and group memberships at [http://go.microsoft.com/fwlink/?LinkId=83477](http://go.microsoft.com/fwlink/?linkid=83477). Note that you can use the same account for this procedure as you will use when creating the cluster.

#### To prestage a cluster name account

1.  Make sure that you know the name that the cluster will have, and the name of the user account that will be used by the person who creates the cluster. (Note that you can use that account to perform this procedure.)

2.  On a domain controller, click **Start**, click **Administrative Tools**, and then click **Active Directory Users and Computers**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.

3.  In the console tree, right-click **Computers** or the default container in which computer accounts are created in your domain. **Computers** is located in <b>Active Directory Users and Computers/</b><i>domain-node</i><b>/Computers</b>.

4.  Click **New** and then click **Computer**.

5.  Type the name that will be used for the failover cluster, in other words, the cluster name that will be specified in the Create Cluster wizard, and then click **OK**.

6.  Right-click the account that you just created, and then click **Disable Account**. If prompted to confirm your choice, click **Yes**.
    
    The account must be disabled so that when the **Create Cluster** wizard is run, it can confirm that the account it will use for the cluster is not currently in use by an existing computer or cluster in the domain.

7.  On the **View** menu, make sure that **Advanced Features** is selected.
    
    When **Advanced Features** is selected, you can see the **Security** tab in the properties of accounts (objects) in **Active Directory Users and Computers**.

8.  Right-click the folder that you right-clicked in step 3, and then click **Properties**.

9.  On the **Security** tab, click **Advanced**.

10. Click **Add**, click **Object Types** and make sure that **Computers** is selected, and then click **OK**. Then, under **Enter the object name to select**, type the name of the computer account you just created, and then click **OK**. If a message appears, saying that you are about to add a disabled object, click **OK**.

11. In the **Permission Entry** dialog box, locate the **Create Computer objects** and **Read All Properties** permissions, and make sure that the **Allow** check box is selected for each one.
    
    ![](media/configure-ad-accounts/Cc731002.f5977c4d-a62e-4b17-81e3-8c19ddca2078(WS.10).gif)

12. Click **OK** until you have returned to the **Active Directory Users and Computers** snap-in.

13. If you are using the same account to perform this procedure as will be used to create the cluster, skip the remaining steps. Otherwise, you must configure permissions so that the user account that will be used to create the cluster has full control of the computer account you just created:
    
    1.  On the **View** menu, make sure that **Advanced Features** is selected.  
          
    2.  Right-click the computer account you just created, and then click **Properties**.  
          
    3.  On the **Security** tab, click **Add**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
          
    4.  Use the **Select Users, Computers, or Groups** dialog box to specify the user account that will be used when creating the cluster. Then click **OK**.  
          
    5.  Make sure that the user account that you just added is selected, and then, next to **Full Control**, select the **Allow** check box.  
          
        ![](media/configure-ad-accounts/Cc731002.fffaafe2-a494-498b-974c-8f9d70f7103b(WS.10).gif)

## Steps for prestaging an account for a clustered service or application

It is usually simpler if you do not prestage the computer account for a clustered service or application, but instead allow the account to be created and configured automatically when you run the High Availability wizard. However, if it is necessary to prestage accounts because of requirements in your organization, use the following procedure.

Membership in the **Account Operators** group, or equivalent, is the minimum required to complete this procedure. Review details about using the appropriate accounts and group memberships at [http://go.microsoft.com/fwlink/?LinkId=83477](http://go.microsoft.com/fwlink/?linkid=83477).

#### To prestage an account for a clustered service or application

1.  Make sure that you know the name of the cluster and the name that the clustered service or application will have.

2.  On a domain controller, click **Start**, click **Administrative Tools**, and then click **Active Directory Users and Computers**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.

3.  In the console tree, right-click **Computers** or the default container in which computer accounts are created in your domain. **Computers** is located in <b>Active Directory Users and Computers/</b><i>domain-node</i><b>/Computers</b>.

4.  Click **New** and then click **Computer**.

5.  Type the name that you will use for the clustered service or application, and then click **OK**.

6.  On the **View** menu, make sure that **Advanced Features** is selected.
    
    When **Advanced Features** is selected, you can see the **Security** tab in the properties of accounts (objects) in **Active Directory Users and Computers**.

7.  Right-click the computer account you just created, and then click **Properties**.

8.  On the **Security** tab, click **Add**.

9.  Click **Object Types** and make sure that **Computers** is selected, and then click **OK**. Then, under **Enter the object name to select**, type the cluster name account, and then click **OK**. If a message appears, saying that you are about to add a disabled object, click **OK**.

10. Make sure that the cluster name account is selected, and then, next to **Full Control**, select the **Allow** check box.
    
    ![](media/configure-ad-accounts/Cc731002.2e614376-87a6-453a-81ba-90ff7ebc3fa2(WS.10).gif)

## Steps for troubleshooting problems related to accounts used by the cluster

As described earlier in this guide, when you create a failover cluster and configure clustered services or applications, the failover cluster wizards create the necessary Active Directory accounts and give them the correct permissions. If a needed account is deleted, or necessary permissions are changed, problems can result. The following subsections provide steps for troubleshooting these issues.

  - [Steps for troubleshooting password problems with the cluster name account](#steps-for-troubleshooting-password-problems-with-the-cluster-name-account)
      
  - [Steps for troubleshooting problems caused by changes in cluster-related Active Directory accounts](#steps-for-troubleshooting-problems-caused-by-changes-in-cluster-related-active-directory-accounts)
      

### Steps for troubleshooting password problems with the cluster name account

Use this procedure if there is an event message about computer objects or about the cluster identity that includes the following text. Note that this text will be within the event message, not at the beginning of the event message:

`Logon failure: unknown user name or bad password.`

Event messages that fit the previous description indicate that the password for the cluster name account and the corresponding password stored by the clustering software no longer match.

For information about ensuring that cluster administrators have the correct permissions to perform the following procedure as needed, see Planning ahead for password resets and other account maintenance, earlier in this guide.

Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure. In addition, your account must be given **Reset password** permission for the cluster name account (unless your account is a **Domain Admins** account or is the Creator Owner of the cluster name account). The account that was used by the person who installed the cluster can be used for this procedure. Review details about using the appropriate accounts and group memberships at [http://go.microsoft.com/fwlink/?LinkId=83477](http://go.microsoft.com/fwlink/?linkid=83477).

#### To troubleshoot password problems with the cluster name account

1.  To open the failover cluster snap-in, click **Start**, click **Administrative Tools**, and then click **Failover Cluster Management**. (If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.)

2.  In the Failover Cluster Management snap-in, if the cluster you want to configure is not displayed, in the console tree, right-click **Failover Cluster Management**, click **Manage a Cluster**, and select or specify the cluster you want.

3.  In the center pane, expand **Cluster Core Resources**.

4.  Under **Cluster Name**, right-click the **Name** item, point to **More Actions**, and then click **Repair Active Directory Object**.

### Steps for troubleshooting problems caused by changes in cluster-related Active Directory accounts

If the cluster name account is deleted or if permissions are taken away from it, problems will occur when you try to configure a new clustered service or application. To troubleshoot a problem where this might be the cause, use the Active Directory Users and Computers snap-in to view or change the cluster name account and other related accounts. For information about the events that are logged when this type of problem occurs (event 1193, 1194, 1206, or 1207), see [http://go.microsoft.com/fwlink/?LinkId=118271](http://go.microsoft.com/fwlink/?linkid=118271).

Membership in the **Domain Admins** group, or equivalent, is the minimum required to complete this procedure. Review details about using the appropriate accounts and group memberships at [http://go.microsoft.com/fwlink/?LinkId=83477](http://go.microsoft.com/fwlink/?linkid=83477).

#### To troubleshoot problems caused by changes in cluster-related Active Directory accounts

1.  On a domain controller, click **Start**, click **Administrative Tools**, and then click **Active Directory Users and Computers**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.

2.  Expand the default **Computers** container or the folder in which the cluster name account (the computer account for the cluster) is located. **Computers** is located in <b>Active Directory Users and Computers/</b><i>domain-node</i><b>/Computers</b>.

3.  Examine the icon for the cluster name account. It must not have a downward-pointing arrow on it, that is, the account must not be disabled. If it appears to be disabled, right-click it and look for the command **Enable Account**. If you see the command, click it.

4.  On the **View** menu, make sure that **Advanced Features** is selected.
    
    When **Advanced Features** is selected, you can see the **Security** tab in the properties of accounts (objects) in **Active Directory Users and Computers**.

5.  Right-click the default **Computers** container or the folder in which the cluster name account is located.

6.  Click **Properties**.

7.  On the **Security** tab, click **Advanced**.

8.  In the list of accounts with permissions, click the cluster name account, and then click **Edit**.
    

> [!NOTE]
> If the cluster name account is not listed, click <STRONG>Add</STRONG> and add it to the list. 
<br>


9. For the cluster name account (also known as the cluster name object or CNO), ensure that **Allow** is selected for the **Create Computer objects** and **Read All Properties** permissions.
    
   ![](media/configure-ad-accounts/Cc731002.f5977c4d-a62e-4b17-81e3-8c19ddca2078(WS.10).gif)

10. Click **OK** until you have returned to the **Active Directory Users and Computers** snap-in.

11. Review domain policies (consulting with a domain administrator if applicable) related to the creation of computer accounts (objects). Ensure that the cluster name account can create a computer account each time you configure a clustered service or application. For example, if your domain administrator has configured settings that cause all new computer accounts to be created in a specialized container rather than the default **Computers** container, make sure that these settings allow the cluster name account to create new computer accounts in that container also.

12. Expand the default **Computers** container or the container in which the computer account for one of the clustered services or applications is located.

13. Right-click the computer account for one of the clustered services or applications, and then click **Properties**.

14. On the **Security** tab, confirm that the cluster name account is listed among the accounts that have permissions, and select it. Confirm that the cluster name account has **Full Control** permission (the **Allow** check box is selected). If it does not, add the cluster name account to the list and give it **Full Control** permission.
    
   ![](media/configure-ad-accounts/Cc731002.2e614376-87a6-453a-81ba-90ff7ebc3fa2(WS.10).gif)

15. Repeat steps 13-14 for each clustered service and application configured in the cluster.

16. Check that the domain-wide quota for creating computer objects (by default, 10) has not been reached (consulting with a domain administrator if applicable). If the previous items in this procedure have all been reviewed and corrected, and if the quota has been reached, consider increasing the quota. To change the quota:
    
   1.  Open a command prompt as an administrator and run **ADSIEdit.msc**.  
          
   2.  Right-click **ADSI Edit**, click **Connect to**, and then click **OK**. The **Default naming context** is added to the console tree.  
          
   3.  Double-click **Default naming context**, right-click the domain object underneath it, and then click **Properties**.  
          
   4.  Scroll to **ms-DS-MachineAccountQuota**, select it, click **Edit**, change the value, and then click **OK**.

