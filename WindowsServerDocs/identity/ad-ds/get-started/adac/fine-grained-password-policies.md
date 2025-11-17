---
description: Learn how to create, view, edit, and delete fine grained password policies in Active Directory Domain Services on Windows Server.
title: Configure fine grained password policies for Active Directory Domain Services in Windows Server
ms.author: daknappe
author: orin-thomas
ms.date: 06/16/2025
ms.topic: how-to
#customer intent: As an Active Directory administrator, I want to configure fine grained password policies so that I can apply different password and account lockout policies to different sets of users in a domain.
---

# Configure fine grained password policies for Active Directory Domain Services

Fine Grained Password Policies provide you with a way to define different password and account lockout policies for different sets of users in a domain. You can use fine grained password policies to specify multiple password policies within a single domain. You can also apply different restrictions for password and account lockout policies to different sets of users in a domain. For example, you can apply stricter settings to privileged accounts and less strict settings to the accounts of other users.

Fine-grained password policies apply only to global security groups and user objects. By default, only members of the Domain Admins group can set fine grained password policies. However, you can also delegate the ability to set these policies to other users.

## Prerequisites

Before you can create fine grained password policies, you need to complete the following prerequisites.

- The domain functional level must be Windows Server 2012 or higher.

- You must be a member of the Domain Admins group.

- You must have either of the following Remote Server Administration Tools (RSAT) installed:

  - Active Directory Administrative Center (ADAC), **or** Active Directory module for Windows PowerShell.

## Create a fine grained password policy

To create a new fine grained password policy, perform the following steps:

### [Active Directory Administrative Center](#tab/adac)

Here's how to create a fine grained password policy using ADAC:

1. Open Active Directory Administrative Center, either from the **Tools** menu of the Server Manager console or by running an elevated PowerShell session and typing **dsac.exe**.

1. If the appropriate target domain isn't selected, choose **Manage**, choose **Add Navigation Nodes**, and select the appropriate target domain in the **Add Navigation Nodes** dialog box and then choose **OK**.

1. In the ADAC navigation pane, open the **System** container, and then choose **Password Settings Container**.

1. In the **Tasks** pane, choose **New**, and then choose **Password Settings**.

1. Fill in or edit fields inside the property page to create a new **Password Settings** object. The **Name** and **Precedence** fields are required.

1. Under **Directly Applies To**, choose **Add**, type the name of the group to which the fine grained password policy, and then choose **OK**.

1. Choose **OK** to submit the creation.

### [PowerShell](#tab/powershell)

Here's how to create a fine grained password policy using the [New-ADFineGrainedPasswordPolicy](/powershell/module/activedirectory/new-adfinegrainedpasswordpolicy) cmdlet.

1. To open an elevated PowerShell session, right-click on the _Start_ button, choose **Windows PowerShell (Admin)**.

1. To create a new fine grained password policy named `PasswordPolicy`, use the following example. Adjust the settings as needed and run the command:

   ```powershell
   $policyParams = @{
       Name = "PasswordPolicy"
       ComplexityEnabled = $true
       LockoutDuration = "00:30:00"
       LockoutObservationWindow = "00:30:00"
       LockoutThreshold = "0"
       MaxPasswordAge = "42.00:00:00"
       MinPasswordAge = "1.00:00:00"
       MinPasswordLength = "7"
       PasswordHistoryCount = "24"
       Precedence = "1"
       ReversibleEncryptionEnabled = $false
       ProtectedFromAccidentalDeletion = $true
   }
   
   New-ADFineGrainedPasswordPolicy @policyParams
   ```

1. Assign the new policy to a group using the [Add-ADFineGrainedPasswordPolicySubject](/powershell/module/activedirectory/add-adfinegrainedpasswordpolicysubject) cmdlet. For example, to assign the `PasswordPolicy` policy to the `group1` group, run the following command:

   ```powershell
   Add-ADFineGrainedPasswordPolicySubject PasswordPolicy -Subjects group1
   ```

---

## View a resultant set of policies for a user

To view the resultant policy that applies to a specific user, perform the following steps:

### [Active Directory Administrative Center](#tab/adac)

Here's how to view the resultant policy that applies to a specific user using ADAC:

1. Open Active Directory Administrative Center, either from the Tools menu of the Server Manager console or by running an elevated PowerShell session and typing **dsac.exe**.

1. If the appropriate target domain isn't selected, choose **Manage**, choose **Add Navigation Nodes**, and select the appropriate target domain in the **Add Navigation Nodes** dialog box and then choose **OK**.

1. Navigate to the user for whom you wish to view the resultant policy settings.

1. Choose **View Resultant Password Settings** in the **Tasks** pane.

1. Examine the password setting policy and then choose **Cancel**.

### [PowerShell](#tab/powershell)

Here's how to use the [Get-ADUserResultantPasswordPolicy](/powershell/module/activedirectory/get-aduserresultantpasswordpolicy) cmdlet to view the policy that applies to a specific user.

1. To open an elevated PowerShell session, right-click on the _Start_ button, choose **Windows PowerShell (Admin)**.

1. To view the resultant policy that applies to `user1`, run the command. Replace `user1` with the desired user.

   ```powershell
   Get-ADUserResultantPasswordPolicy -Identity test1
   ```

---

## Edit a fine grained password policy

Edit a fine grained password policy using the following steps:

### [Active Directory Administrative Center](#tab/adac)

Here's how to edit a fine grained password policy using ADAC:

1. Open Active Directory Administrative Center, either from the Tools menu of the Server Manager console or by running an elevated PowerShell session and typing **dsac.exe**.

1. If the appropriate target domain isn't selected, choose **Manage**, choose **Add Navigation Nodes**, and select the appropriate target domain in the **Add Navigation Nodes** dialog box and then choose **OK**.

1. In the ADAC **Navigation Pane**, expand **System** and then expand the **Password Settings Container**.

1. Select the fine grained password policy you wish to edit and choose **Properties** in the **Tasks** pane.

1. Modify the settings that you wish to change and choose **OK**.

### [PowerShell](#tab/powershell)

Here's how to use the [Set-ADFineGrainedPasswordPolicy](/powershell/module/activedirectory/set-adfinegrainedpasswordpolicy) cmdlet to modify an existing policy.

1. Open an elevated PowerShell session, right-click on the _Start_ button. Choose **Windows PowerShell (Admin)**.

1. To change the password history setting of the `PasswordPolicy` policy, run the following command. Replace `PasswordPolicy` with the desired policy name.

   ```powershell
   Set-ADFineGrainedPasswordPolicy PasswordPolicy -PasswordHistoryCount:"30"
   ```

1. You can change other settings in the same way. For more information, review the [Set-ADFineGrainedPasswordPolicy](/powershell/module/activedirectory/set-adfinegrainedpasswordpolicy) reference article.

---

## Delete a fine grained password policy

Perform the following steps to delete a fine grained password policy:

### [Active Directory Administrative Center](#tab/adac)

Here's how to delete a fine grained password policy using ADAC:

1. Open Active Directory Administrative Center, either from the Tools menu of the Server Manager console or by running an elevated PowerShell session and typing **dsac.exe**.

1. If the appropriate target domain isn't selected, choose **Manage**, choose **Add Navigation Nodes**, and select the appropriate target domain in the **Add Navigation Nodes** dialog box and then choose **OK**.

1. In the ADAC Navigation Pane, expand **System** and then expand **Password Settings Container**.

1. Select the fine grained password policy you wish to remove and in the **Tasks** pane choose **Properties**.

1. Clear the **Protect from accidental deletion** checkbox and choose **OK**.

1. Select the fine grained password policy, and in the **Tasks** pane choose **Delete**.

1. Choose **OK** in the confirmation dialog to delete the policy.

### [PowerShell](#tab/powershell)

Here's how to use the [Remove-ADFineGrainedPasswordPolicy](/powershell/module/activedirectory/remove-adfinegrainedpasswordpolicy) cmdlet to delete a fine grained password policy.

1. Open an elevated PowerShell session by right-clicking on the _Start_ button and choosing **Windows PowerShell (Admin)**.

1. Remove deletion protection from the policy by running the following command. Replace `PasswordPolicy` with the desired policy name.

   ```powershell
   Set-ADFineGrainedPasswordPolicy -Identity PasswordPolicy -ProtectedFromAccidentalDeletion $False
   ```

1. To remove the policy, run the following command. Replace `PasswordPolicy` with the desired policy name.

   ```powershell
   Remove-ADFineGrainedPasswordPolicy PasswordPolicy
   ```

---

