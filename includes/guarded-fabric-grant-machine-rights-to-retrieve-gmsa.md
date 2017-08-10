1. Have a directory services admin add the computer account for your new node to the security group containing all of your HGS servers that is permissioned to allow those servers to use the HGS gMSA account.

2. Reboot the new node to obtain a new Kerberos ticket that includes the computer's membership in that security group. After the reboot completes, sign in with a domain identity that belongs to the local administrators group on the computer.

3. Install the HGS group managed service account on the node.

   ```powershell
   Install-ADServiceAccount -Identity <HGSgMSAAccount>
   ```
