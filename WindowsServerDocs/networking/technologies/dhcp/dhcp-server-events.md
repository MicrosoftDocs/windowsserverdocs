---
title: DHCP server events for Windows Server
description: View a summary of DHCP server events for operational, administrative, system, filter, and audit events.
ms.topic: troubleshooting-general
author: meaghanlewis
ms.author: mosagie
ms.date: 03/12/2025
---

# DHCP server events

The following tables summarize Windows DHCP server events. Events are displayed in tables based on their channel.

## DHCP server operational events

<details>
    <summary>To view all server operational events, expand this section.</summary>
<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><strong>Event ID</strong></p></td>
<td><p><strong>Event category</strong></p></td>
<td><p><strong>Event text</strong></p></td>
</tr>
<tr class="even">
<td><p>70</p></td>
<td><p>DHCPv4.ScopeConfigured</p></td>
<td><p>Scope: %1 for IPv4 is Configured by %2.</p></td>
</tr>
<tr class="odd">
<td><p>71</p></td>
<td><p>DHCPv4.ScopeModified</p></td>
<td><p>Scope: %1 for IPv4 is Modified by %2.</p></td>
</tr>
<tr class="even">
<td><p>72</p></td>
<td><p>DHCPv4.ScopeDeleted</p></td>
<td><p>Scope: %1 for IPv4 is Deleted by %2.</p></td>
</tr>
<tr class="odd">
<td><p>73</p></td>
<td><p>DHCPv4.ScopeActivated</p></td>
<td><p>Scope: %1 for IPv4 is Activated by %2.</p></td>
</tr>
<tr class="even">
<td><p>74</p></td>
<td><p>DHCPv4.ScopeDeActivated</p></td>
<td><p>Scope: %1 for IPv4 is Deactivated by %2.</p></td>
</tr>
<tr class="odd">
<td><p>75</p></td>
<td><p>DHCPv4.ScopeLeaseUpdate</p></td>
<td><p>Scope: %1 for IPv4 is Updated with Lease Duration: %2 seconds by %3. The previous configured Lease Duration was: %4 seconds.</p></td>
</tr>
<tr class="even">
<td><p>76</p></td>
<td><p>DHCPv4.ScopeOptionUpdate</p></td>
<td><p>Scope: %1 for IPv4 is Updated with Option Settings: %2 by %3</p></td>
</tr>
<tr class="odd">
<td><p>77</p></td>
<td><p>DHCPv4.ScopeDNSEnable</p></td>
<td><p>Scope: %1 for IPv4 is Enabled for DNS Dynamic updates by %2.</p></td>
</tr>
<tr class="even">
<td><p>78</p></td>
<td><p>DHCPv4.ScopeDNSDisable</p></td>
<td><p>Scope: %1 for IPv4 is Disabled for DNS Dynamic updates by %2.</p></td>
</tr>
<tr class="odd">
<td><p>79</p></td>
<td><p>DHCPv4.ScopeDNSUpdate_Req_by_Client</p></td>
<td><p>Scope: %1 for IPv4 is Updated with DNS Settings by %2: to dynamically update DNS A and PTR records on request by the DHCP Clients .</p></td>
</tr>
<tr class="even">
<td><p>80</p></td>
<td><p>DHCPv4.ScopeDNSUpdate_Always</p></td>
<td><p>Scope: %1 for IPv4 is Updated with DNS Settings by %2: to always dynamically update DNS A and PTR records.</p></td>
</tr>
<tr class="odd">
<td><p>81</p></td>
<td><p>DHCPv4.ScopeDNSEnable_Discard</p></td>
<td><p>Scope: %1 for IPv4 is Enabled for DNS Settings by %2: to discard DNS A and PTR records when lease is deleted.</p></td>
</tr>
<tr class="even">
<td><p>82</p></td>
<td><p>DHCPv4.ScopeDNSDisable_Discard</p></td>
<td><p>Scope: %1 for IPv4 is Disabled for DNS Settings by %2: to discard DNS A and PTR records when lease is deleted.</p></td>
</tr>
<tr class="odd">
<td><p>83</p></td>
<td><p>DHCPv4.ScopeDNSEnable_Update_Client_NoReq</p></td>
<td><p>Scope: %1 for IPv4 is Enabled for DNS Settings by %2: to dynamically update DNS A and PTR records for DHCP Clients that do not request updates.</p></td>
</tr>
<tr class="even">
<td><p>84</p></td>
<td><p>DHCPv4.ScopeDNSDisable_Update_Client_NoReq</p></td>
<td><p>Scope: %1 for IPv4 is Disabled for DNS Settings by %2: to dynamically update DNS A and PTR records for DHCP Clients that do not request updates.</p></td>
</tr>
<tr class="odd">
<td><p>85</p></td>
<td><p>DHCPv4.ScopePBA_DeActivated</p></td>
<td><p>Policy based assignment has been disabled for scope %1.</p></td>
</tr>
<tr class="even">
<td><p>86</p></td>
<td><p>DHCPv4.ScopePBA_Activated</p></td>
<td><p>Policy based assignment has been enabled for scope %1.</p></td>
</tr>
<tr class="odd">
<td><p>87</p></td>
<td><p>DHCPv4.ScopeDHCIDEnable</p></td>
<td><p>Name Protection setting is Enabled on Scope: %1 for IPv4 by %2.</p></td>
</tr>
<tr class="even">
<td><p>88</p></td>
<td><p>DHCPv4.ScopeDHCIDDisable</p></td>
<td><p>Name Protection setting is Disabled on Scope: %1 for IPv4 by %2.</p></td>
</tr>
<tr class="odd">
<td><p>89</p></td>
<td><p>DHCPv4.ScopeSupportType</p></td>
<td><p>Scope: %1 for IPv4 is Updated with support type: %2 by %3. The previous configured state was: %4.</p></td>
</tr>
<tr class="even">
<td><p>90</p></td>
<td><p>DHCPv4.ScopeNAPEnabled</p></td>
<td><p>NAP Enforcement is Enabled on Scope: %1 for IPv4 by %2.</p></td>
</tr>
<tr class="odd">
<td><p>91</p></td>
<td><p>DHCPv4.ScopeNAPDisabled</p></td>
<td><p>NAP Enforcement is Disabled on Scope: %1 for IPv4 by %2.</p></td>
</tr>
<tr class="even">
<td><p>92</p></td>
<td><p>DHCPv4.ScopeNAPProfileConfigured</p></td>
<td><p>NAP Profile is configured on Scope: %1 for IPv4 with the following NAP Profile: %2 by %3.</p></td>
</tr>
<tr class="odd">
<td><p>93</p></td>
<td><p>DHCPv4.ScopeNAPProfileModified</p></td>
<td><p>NAP Profile is Updated on Scope: %1 for IPv4 with the following NAP Profile: %2 by %3. The previous configured NAP Profile was: %4.</p></td>
</tr>
<tr class="even">
<td><p>94</p></td>
<td><p>DHCPv4.ScopeNAPProfileDeleted</p></td>
<td><p>The following NAP Profile: %1 is deleted on Scope: %2 by %3.</p></td>
</tr>
<tr class="odd">
<td><p>95</p></td>
<td><p>DHCPv4.MulticastScopeConfigured</p></td>
<td><p>Scope: %1 for Multicast IPv4 is Configured by %2.</p></td>
</tr>
<tr class="even">
<td><p>96</p></td>
<td><p>DHCPv4.MulticastScopeDeleted</p></td>
<td><p>Scope: %1 for Multicast IPv4 is Deleted by %2.</p></td>
</tr>
<tr class="odd">
<td><p>98</p></td>
<td><p>DHCPv4.SuperScopeConfigured</p></td>
<td><p>SuperScope: %1 for IPv4 is Configured by %2.</p></td>
</tr>
<tr class="even">
<td><p>99</p></td>
<td><p>DHCPv4.SuperScopeDeleted</p></td>
<td><p>SuperScope: %1 for IPv4 is Deleted by %2.</p></td>
</tr>
<tr class="odd">
<td><p>100</p></td>
<td><p>DHCPv4.SuperScopeActivated</p></td>
<td><p>Scope: %1 within SuperScope: %2 for IPv4 is Activated by %3.</p></td>
</tr>
<tr class="even">
<td><p>101</p></td>
<td><p>DHCPv4.SuperScopeDeActivated</p></td>
<td><p>Scope: %1 within SuperScope: %2 for IPv4 is DeActivated by %3.</p></td>
</tr>
<tr class="odd">
<td><p>102</p></td>
<td><p>DHCPv4.SuperScopeDeleteTemp</p></td>
<td><p>Scope: %1 for IPv4 is Removed in Superscope: %2 by %3. However, the Scope exists outside the Superscope.</p></td>
</tr>
<tr class="even">
<td><p>103</p></td>
<td><p>DHCPv4.SuperScopeDeletePerm</p></td>
<td><p>Scope: %1 for IPv4 is Deleted in Superscope: %2 as well as Deleted permanently by %3.</p></td>
</tr>
<tr class="odd">
<td><p>105</p></td>
<td><p>DHCPv4.ServerOptionUpdate</p></td>
<td><p>Server level option %1 for IPv4 has been updated by %2.</p></td>
</tr>
<tr class="even">
<td><p>106</p></td>
<td><p>DHCPv4.ReservationConfigured</p></td>
<td><p>Reservation: %1 for IPv4 is Configured under Scope %2 by %3.</p></td>
</tr>
<tr class="odd">
<td><p>107</p></td>
<td><p>DHCPv4.ReservationDeleted</p></td>
<td><p>Reservation: %1 for IPv4 is Deleted under Scope %2 by %3.</p></td>
</tr>
<tr class="even">
<td><p>108</p></td>
<td><p>DHCPv4.ReservationDNSEnable</p></td>
<td><p>Reservation: %1 for IPv4 under Scope: %2 is Enabled for DNS Dynamic updates by %3.</p></td>
</tr>
<tr class="odd">
<td><p>109</p></td>
<td><p>DHCPv4.ReservationDNSDisable</p></td>
<td><p>Reservation: %1 for IPv4 under Scope: %2 is Disabled for DNS Dynamic updates by %3.</p></td>
</tr>
<tr class="even">
<td><p>110</p></td>
<td><p>DHCPv4.ReservationDNSUpdate_Req_by_Client</p></td>
<td><p>Reservation: %1 for IPv4 under Scope: %2 is Updated with DNS Settings by %3: to dynamically update DNS A and PTR records on request by the DHCP Clients.</p></td>
</tr>
<tr class="odd">
<td><p>111</p></td>
<td><p>DHCPv4.ReservationDNSUpdate_Always</p></td>
<td><p>Reservation: %1 for IPv4 under Scope: %2 is Updated with DNS Settings by %3: to always dynamically update DNS A and PTR records.</p></td>
</tr>
<tr class="even">
<td><p>112</p></td>
<td><p>DHCPv4.ReservationDNSEnable_Discard</p></td>
<td><p>Reservation: %1 for IPv4 under Scope: %2 is Enabled for DNS Settings by %3: to discard DNS A and PTR records when lease is deleted.</p></td>
</tr>
<tr class="odd">
<td><p>113</p></td>
<td><p>DHCPv4.ReservationDNSDisable_Discard</p></td>
<td><p>Reservation: %1 for IPv4 under Scope: %2 is Disabled for DNS Settings by %3: to discard DNS A and PTR records when lease is deleted.</p></td>
</tr>
<tr class="even">
<td><p>114</p></td>
<td><p>DHCPv4.ReservationDNSEnableUpdate_No_Req_by_Client</p></td>
<td><p>Reservation: %1 for IPv4 under Scope: %2 is Enabled for DNS Settings by %3: to dynamically update DNS A and PTR records for DHCP Clients that do not request updates.</p></td>
</tr>
<tr class="odd">
<td><p>115</p></td>
<td><p>DHCPv4.ReservationDNSDisableUpdate_No_Req_by_Client</p></td>
<td><p>Reservation: %1 for IPv4 under Scope: %2 is Disabled for DNS Settings by %3: to dynamically update DNS A and PTR records for DHCP Clients that do not request updates.</p></td>
</tr>
<tr class="even">
<td><p>116</p></td>
<td><p>DHCPv4.ReservationOptionUpdate</p></td>
<td><p>Reservation: %1 for IPv4 under Scope: %2 is Updated with Option Setting: %3 by %4.</p></td>
</tr>
<tr class="odd">
<td><p>117</p></td>
<td><p>DHCPv4.ServerPBA_DeActivated</p></td>
<td><p>Policy based assignment has been disabled at server level.</p></td>
</tr>
<tr class="even">
<td><p>118</p></td>
<td><p>DHCPv4.ServerPBA_Activated</p></td>
<td><p>Policy based assignment has been enabled at server level.</p></td>
</tr>
<tr class="odd">
<td><p>119</p></td>
<td><p>DHCPv4.ScopeExclusionAdded</p></td>
<td><p>Added exclusion IP Address range %1 in the Address Pool for IPv4 under Scope: %2 by %3.</p></td>
</tr>
<tr class="even">
<td><p>120</p></td>
<td><p>DHCPv4.ScopeExclusionDeleted</p></td>
<td><p>Deleted exclusion IP Address range %1 in the Address Pool for IPv4 under Scope: %2 by %3.</p></td>
</tr>
<tr class="odd">
<td><p>121</p></td>
<td><p>DHCPv4.ScopeEnableAllow</p></td>
<td><p>Link Layer based filtering is Enabled in the Allow List of the IPv4 by %1</p></td>
</tr>
<tr class="even">
<td><p>122</p></td>
<td><p>DHCPv4.ScopeDisableAllow</p></td>
<td><p>Link Layer based filtering is Disabled in the Allow List of the IPv4 by %1</p></td>
</tr>
<tr class="odd">
<td><p>123</p></td>
<td><p>DHCPv4.ScopeAllow_AddFilter</p></td>
<td><p>Filter for physical address: %1, hardware type: %3 added to the IPv4 Allow List by %2.</p></td>
</tr>
<tr class="even">
<td><p>124</p></td>
<td><p>DHCPv4.ScopeAllow_DeleteFilter</p></td>
<td><p>Filter for physical address: %1, hardware type: %3 removed from the IPv4 Allow List by %2.</p></td>
</tr>
<tr class="odd">
<td><p>125</p></td>
<td><p>DHCPv4.ScopeEnableDeny</p></td>
<td><p>Link Layer based filtering is Enabled in the Deny List of the IPv4 by %1</p></td>
</tr>
<tr class="even">
<td><p>126</p></td>
<td><p>DHCPv4.ScopeDisableDeny</p></td>
<td><p>Link Layer based filtering is Disabled in the Deny List of the IPv4 by %1</p></td>
</tr>
<tr class="odd">
<td><p>127</p></td>
<td><p>DHCPv4.ScopeDeny_AddFilter</p></td>
<td><p>Filter for physical address: %1, hardware type: %3 added to the IPv4 Deny List by %2.</p></td>
</tr>
<tr class="even">
<td><p>128</p></td>
<td><p>DHCPv4.ScopeDeny_DeleteFilter</p></td>
<td><p>Filter for physical address: %1, hardware type: %3 removed from the IPv4 Deny List by %2.</p></td>
</tr>
<tr class="odd">
<td><p>130</p></td>
<td><p>DHCPv6.ScopeDeleted</p></td>
<td><p>Scope: %1 for IPv6 is Deleted by %2.</p></td>
</tr>
<tr class="even">
<td><p>131</p></td>
<td><p>DHCPv6.ScopeActivated</p></td>
<td><p>Scope: %1 for IPv6 is Activated by %2.</p></td>
</tr>
<tr class="odd">
<td><p>132</p></td>
<td><p>DHCPv6.ScopeDeActivated</p></td>
<td><p>Scope: %1 for IPv6 is DeActivated by %2.</p></td>
</tr>
<tr class="even">
<td><p>133</p></td>
<td><p>DHCPv6.ScopeLeasePreferredUpdate</p></td>
<td><p>Scope: %1 for IPv6 is Updated with Lease Preferred Lifetime: %2 by %3. The previous configured Lease Preferred Lifetime was: %4.</p></td>
</tr>
<tr class="odd">
<td><p>134</p></td>
<td><p>DHCPv6.ScopeLeaseValidUpdate</p></td>
<td><p>Scope: %1 for IPv6 is Updated with Lease Valid Lifetime: %2 by %3. The previous configured Lease Valid Lifetime was: %4.</p></td>
</tr>
<tr class="even">
<td><p>135</p></td>
<td><p>DHCPv6.ScopeOptionUpdate</p></td>
<td><p>Scope: %1 for IPv6 is Updated with Option Setting: %2 by %3.</p></td>
</tr>
<tr class="odd">
<td><p>136</p></td>
<td><p>DHCPv6.ScopeDNSEnable</p></td>
<td><p>Scope: %1 for IPv6 is Enabled for DNS Dynamic updates by %2.</p></td>
</tr>
<tr class="even">
<td><p>137</p></td>
<td><p>DHCPv6.ScopeDNSDisable</p></td>
<td><p>Scope: %1 for IPv6 is Disabled for DNS Dynamic updates by %2.</p></td>
</tr>
<tr class="odd">
<td><p>138</p></td>
<td><p>DHCPv6.ScopeDNSUpdate_Req_by_Client</p></td>
<td><p>Scope: %1 for IPv6 is Updated with DNS Settings by %2: to dynamically update DNS AAAA and PTR records on request by the DHCP Clients.</p></td>
</tr>
<tr class="even">
<td><p>139</p></td>
<td><p>DHCPv6.ScopeDNSUpdate_Always</p></td>
<td><p>Scope: %1 for IPv6 is Updated with DNS Settings by %2: to always dynamically update DNS AAAA and PTR records.</p></td>
</tr>
<tr class="odd">
<td><p>140</p></td>
<td><p>DHCPv6.ScopeDNSEnable_Discard</p></td>
<td><p>Scope: %1 for IPv6 is Enabled for DNS Settings by %2: to discard DNS AAAA and PTR records when lease is deleted.</p></td>
</tr>
<tr class="even">
<td><p>141</p></td>
<td><p>DHCPv6.ScopeDNSDisable_Discard</p></td>
<td><p>Scope: %1 for IPv6 is Disabled for DNS Settings by %2: to discard DNS AAAA and PTR records when lease is deleted.</p></td>
</tr>
<tr class="odd">
<td><p>142</p></td>
<td><p>DHCPv6.ScopeDHCIDEnable</p></td>
<td><p>Name Protection setting is Enabled on Scope: %1 for IPv6 by %2.</p></td>
</tr>
<tr class="even">
<td><p>143</p></td>
<td><p>DHCPv6.ScopeDHCIDDisable</p></td>
<td><p>Name Protection setting is Disabled on Scope: %1 for IPv6 by %2.</p></td>
</tr>
<tr class="odd">
<td><p>145</p></td>
<td><p>DHCPv6.ReservationConfigured</p></td>
<td><p>Reservation: %1 for IPv6 is Configured under Scope %2 by %3.</p></td>
</tr>
<tr class="even">
<td><p>147</p></td>
<td><p>DHCPv6.ReservationDeleted</p></td>
<td><p>Reservation: %1 for IPv6 is Deleted under Scope %2 by %3.</p></td>
</tr>
<tr class="odd">
<td><p>148</p></td>
<td><p>DHCPv6.ReservationDNSEnable</p></td>
<td><p>Reservation: %1 for IPv6 under Scope: %2 is Enabled for DNS Dynamic updates by %3.</p></td>
</tr>
<tr class="even">
<td><p>149</p></td>
<td><p>DHCPv6.ReservationDNSDisable</p></td>
<td><p>Reservation: %1 for IPv6 under Scope: %2 is Disabled for DNS Dynamic updates by %3.</p></td>
</tr>
<tr class="odd">
<td><p>150</p></td>
<td><p>DHCPv6.ReservationDNSUpdate_Req_by_Client</p></td>
<td><p>Reservation: %1 for IPv6 under Scope: %2 is Updated with DNS Settings by %3: to dynamically update DNS AAAA and PTR records on request by the DHCP Clients.</p></td>
</tr>
<tr class="even">
<td><p>151</p></td>
<td><p>DHCPv6.ReservationDNSUpdate_Always</p></td>
<td><p>Reservation: %1 for IPv6 under Scope: %2 is Updated with DNS Settings by %3: to always dynamically update DNS AAAA and PTR records.</p></td>
</tr>
<tr class="odd">
<td><p>152</p></td>
<td><p>DHCPv6.ReservationDNSEnable_Discard</p></td>
<td><p>Reservation: %1 for IPv6 under Scope: %2 is Enabled for DNS Settings by %3: to discard DNS AAAA and PTR records when lease is deleted.</p></td>
</tr>
<tr class="even">
<td><p>153</p></td>
<td><p>DHCPv6.ReservationDNSDisable_Discard</p></td>
<td><p>Reservation: %1 for IPv6 under Scope: %2 is Disabled for DNS Settings by %3: to discard DNS AAAA and PTR records when lease is deleted.</p></td>
</tr>
<tr class="odd">
<td><p>154</p></td>
<td><p>DHCPv6.ReservationOptionUpdate</p></td>
<td><p>Reservation: %1 for IPv6 under Scope: %2 is Updated with Option Setting: %3 by %4.</p></td>
</tr>
<tr class="even">
<td><p>155</p></td>
<td><p>DHCPv6.ScopeExclusionAdded</p></td>
<td><p>Added exclusion IP Address range %1 in the Address Pool for IPv6 under Scope: %2 by %3.</p></td>
</tr>
<tr class="odd">
<td><p>156</p></td>
<td><p>DHCPv6.ScopeExclusionDeleted</p></td>
<td><p>Deleted exclusion IP Address range %1 in the Address Pool for IPv6 under Scope: %2 by %3.</p></td>
</tr>
<tr class="even">
<td><p>157</p></td>
<td><p>DHCPv6.ScopeModified</p></td>
<td><p>Scope: %1 for IPv6 is Modified by %2.</p></td>
</tr>
<tr class="odd">
<td><p>158</p></td>
<td><p>DHCPv6.ScopeStatelessEnabled</p></td>
<td><p>DHCPv6 Stateless client inventory has been enabled for the scope %1.</p></td>
</tr>
<tr class="even">
<td><p>159</p></td>
<td><p>DHCPv6.ScopeStatelessDisabled</p></td>
<td><p>DHCPv6 Stateless client inventory has been disabled for the scope %1.</p></td>
</tr>
<tr class="odd">
<td><p>160</p></td>
<td><p>DHCPv6.ServerStatelessEnabled</p></td>
<td><p>DHCPv6 Stateless client inventory has been enabled for the server.</p></td>
</tr>
<tr class="even">
<td><p>161</p></td>
<td><p>DHCPv6.ServerStatelessDisabled</p></td>
<td><p>DHCPv6 Stateless client inventory has been disabled for the server.</p></td>
</tr>
<tr class="odd">
<td><p>162</p></td>
<td><p>DHCPv6.ScopeStatelessPurgeInterval</p></td>
<td><p>Purge time interval for DHCPv6 stateless client inventory for scope %1 has been set to %2 hours.</p></td>
</tr>
<tr class="even">
<td><p>163</p></td>
<td><p>DHCPv6.ServerStatelessPurgeInterval</p></td>
<td><p>Purge time interval for DHCPv6 stateless client inventory for server has been set to %1 hours.</p></td>
</tr>
<tr class="odd">
<td><p>165</p></td>
<td><p>DHCPv4.ScopeDNSDisable_DisablePtrUpdates</p></td>
<td><p>Scope: %1 for IPv4 is Disabled for DNS Settings by %2: to disable dynamic updates for DNS PTR records.</p></td>
</tr>
<tr class="even">
<td><p>166</p></td>
<td><p>DHCPv6.ServerOptionUpdate</p></td>
<td><p>Server level option %1 for IPv6 has been updated by %2.</p></td>
</tr>
<tr class="odd">
<td><p>20220</p></td>
<td><p>DHCPv4.UpdateServerPolicyState</p></td>
<td><p>Policy %2 for server is %1.</p></td>
</tr>
<tr class="even">
<td><p>20221</p></td>
<td><p>DHCPv4.UpdateScopePolicyState</p></td>
<td><p>Policy %2 for scope %3 is %1.</p></td>
</tr>
<tr class="odd">
<td><p>20222</p></td>
<td><p>DHCPv4.UpdateServerPolicyExpr</p></td>
<td><p>The conditions for server policy %3 have been set to %1. The conditions are grouped by logical operator %2.</p></td>
</tr>
<tr class="even">
<td><p>20223</p></td>
<td><p>DHCPv4.UpdateScopePolicyExpr</p></td>
<td><p>The conditions for scope %4 policy %3 have been set to %1. The conditions are grouped by logical operator %2.</p></td>
</tr>
<tr class="odd">
<td><p>20226</p></td>
<td><p>DHCPv4.DeleteServerPolicy</p></td>
<td><p>Policy %1 was deleted from server.</p></td>
</tr>
<tr class="even">
<td><p>20227</p></td>
<td><p>DHCPv4.DeleteScopePolicy</p></td>
<td><p>Policy %1 was deleted from scope %2.</p></td>
</tr>
<tr class="odd">
<td><p>20228</p></td>
<td><p>DHCPv4.SetScopePolicyRange</p></td>
<td><p>The IP address range from %1 was set for the scope %3 policy %2.</p></td>
</tr>
<tr class="even">
<td><p>20229</p></td>
<td><p>DHCPv4.RemoveScopePolicyRange</p></td>
<td><p>The IP address range from %1 was removed from the scope %3 policy %2.</p></td>
</tr>
<tr class="odd">
<td><p>20230</p></td>
<td><p>DHCPv4.SetServerPolicyOption</p></td>
<td><p>The value %2 was set for the option %1 for the server policy %3.</p></td>
</tr>
<tr class="even">
<td><p>20231</p></td>
<td><p>DHCPv4.SetScopePolicyOption</p></td>
<td><p>The value %2 was set for the option %1 for the scope %4 policy %3.</p></td>
</tr>
<tr class="odd">
<td><p>20232</p></td>
<td><p>DHCPv4.UnsetServerPolicyOption</p></td>
<td><p>The value %2 was removed from the option %1 for the server policy %3.</p></td>
</tr>
<tr class="even">
<td><p>20233</p></td>
<td><p>DHCPv4.UnsetScopePolicyOption</p></td>
<td><p>The value %2 was removed from the option %1 for the scope %4 policy %3.</p></td>
</tr>
<tr class="odd">
<td><p>20234</p></td>
<td><p>DHCPv4.UpdateServerPolicyName</p></td>
<td><p>Server policy %2 has been renamed to %1.</p></td>
</tr>
<tr class="even">
<td><p>20235</p></td>
<td><p>DHCPv4.UpdateScopePolicyName</p></td>
<td><p>Scope %3 policy %2 has been renamed to %1.</p></td>
</tr>
<tr class="odd">
<td><p>20236</p></td>
<td><p>DHCPv4.UpdateServerPolicyDescription</p></td>
<td><p>Description of server policy %2 was set to %1.</p></td>
</tr>
<tr class="even">
<td><p>20237</p></td>
<td><p>DHCPv4.UpdateScopePolicyDescription</p></td>
<td><p>Description of scope %3 policy %2 was set to %1.</p></td>
</tr>
<tr class="odd">
<td><p>20238</p></td>
<td><p>DHCPv4.UpdateServerPolicyProcOrder</p></td>
<td><p>Processing order of server policy %3 was changed to %1 from %2.</p></td>
</tr>
<tr class="even">
<td><p>20239</p></td>
<td><p>DHCPv4.UpdateScopePolicyProcOrder</p></td>
<td><p>Processing order of scope %4 policy %3 was changed to %1 from %2.</p></td>
</tr>
<tr class="odd">
<td><p>20241</p></td>
<td><p>DHCPv4.CreateFailoverRelationshipHotStandby</p></td>
<td><p>A failover relationship has been created between servers %1 and %2 with the following configuration parameters: name: %3, mode: hot standby, maximum client lead time: %4 seconds, reserve address percentage on standby server: %5, auto state switchover interval: %6 seconds, standby server: %7.</p></td>
</tr>
<tr class="even">
<td><p>20242</p></td>
<td><p>DHCPv4.DeleteFailoverRelationship</p></td>
<td><p>Failover relationship %1 between %2 and %3 has been deleted.</p></td>
</tr>
<tr class="odd">
<td><p>20243</p></td>
<td><p>DHCPv4.AddScopeRelationship</p></td>
<td><p>Scope %1 has been added to the failover relationship %2 with server %3.</p></td>
</tr>
<tr class="even">
<td><p>20244</p></td>
<td><p>DHCPv4.DeleteScopeRelationship</p></td>
<td><p>Scope %1 has been removed from the failover relationship %2 with server %3.</p></td>
</tr>
<tr class="odd">
<td><p>20245</p></td>
<td><p>DHCPv4.UpdateRelationshipParamMclt</p></td>
<td><p>The failover configuration parameter MCLT for failover relationship %1 with server %2 has been changed from %3 seconds to %4 seconds.</p></td>
</tr>
<tr class="even">
<td><p>20246</p></td>
<td><p>DHCPv4.UpdateRelationshipParamAutoSwitchOverInterval</p></td>
<td><p>The failover configuration parameter auto switch over interval for failover relationship %1 with server %2 has been changed from %3 seconds to %4 seconds.</p></td>
</tr>
<tr class="odd">
<td><p>20247</p></td>
<td><p>DHCPv4.UpdateRelationshipParamPercentageHS</p></td>
<td><p>The failover configuration parameter reserve address percentage for failover relationship %1 with server %2 has been changed from %3 to %4.</p></td>
</tr>
<tr class="even">
<td><p>20248</p></td>
<td><p>DHCPv4.UpdateRelationshipParamPercentageLB</p></td>
<td><p>The failover configuration parameter load balance percentage for failover relationship %1 with server %2 has been changed from %3 to %4 on this server.</p></td>
</tr>
<tr class="odd">
<td><p>20249</p></td>
<td><p>DHCPv4.UpdateRelationshipParamModeHStoLB</p></td>
<td><p>The failover configuration parameter mode for failover relationship %1 with server %2 has been changed from hot standby to load balance.</p></td>
</tr>
<tr class="even">
<td><p>20250</p></td>
<td><p>DHCPv4.UpdateRelationshipParamModeLBtoHS</p></td>
<td><p>The failover configuration parameter mode for failover relationship %1 with server %2 has been changed from load balance to hot standby.</p></td>
</tr>
<tr class="odd">
<td><p>20311</p></td>
<td><p>DHCPv4.UpdateSharedSecret</p></td>
<td><p>The shared secret for failover relationship %2 with server %1 has been changed.</p></td>
</tr>
<tr class="even">
<td><p>20312</p></td>
<td><p>DHCPv4.EnabledSharedSecret</p></td>
<td><p>Message authentication for failover relationship %2 with server %1 has been enabled.</p></td>
</tr>
<tr class="odd">
<td><p>20313</p></td>
<td><p>DHCPv4.DisabledSharedSecret</p></td>
<td><p>Message authentication for failover relationship %2 with server %1 has been disabled.</p></td>
</tr>
<tr class="even">
<td><p>20315</p></td>
<td><p>DHCPv4.UpdateScopePolicyDNSSuffix</p></td>
<td><p>DNSSuffix of scope %3 policy %2 was set to %1.</p></td>
</tr>
<tr class="odd">
<td><p>20316</p></td>
<td><p>DHCPv4.UpdateServerPolicyDNSSuffix</p></td>
<td><p>DNSSuffix of server policy %2 was set to %1.</p></td>
</tr>
</tbody>
</table>
</details>

## DHCP server administrative events

<details>
    <summary>To view all server administrative events, expand this section.</summary>
<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><strong>Event ID</strong></p></td>
<td><p><strong>Event category</strong></p></td>
<td><p><strong>Event text</strong></p></td>
</tr>
<tr class="even">
<td><p>1000</p></td>
<td><p>EVENT_SERVER_UNKNOWN_OPTION</p></td>
<td><p>The DHCP service received the unknown option %1, with a length of %2. The raw option data is given below.</p></td>
</tr>
<tr class="odd">
<td><p>1001</p></td>
<td><p>EVENT_SERVER_FAILED_REGISTER_SC</p></td>
<td><p>The DHCP service failed to register with Service Controller. The following error occurred: %n%1.</p></td>
</tr>
<tr class="even">
<td><p>1002</p></td>
<td><p>EVENT_SERVER_INIT_DATA_FAILED</p></td>
<td><p>The DHCP service failed to initialize its global parameters. The following error occurred: %n%1</p></td>
</tr>
<tr class="odd">
<td><p>1003</p></td>
<td><p>EVENT_SERVER_INIT_REGISTRY_FAILED</p></td>
<td><p>The DHCP service failed to initialize its registry parameters. The following error occurred: %n%1</p></td>
</tr>
<tr class="even">
<td><p>1004</p></td>
<td><p>EVENT_SERVER_INIT_DATABASE_FAILED</p></td>
<td><p>The DHCP service failed to initialize the database. The following error occurred: %n%1</p></td>
</tr>
<tr class="odd">
<td><p>1005</p></td>
<td><p>EVENT_SERVER_INIT_WINSOCK_FAILED</p></td>
<td><p>The DHCP service failed to initialize Winsock startup. The following error occurred: %n%1</p></td>
</tr>
<tr class="even">
<td><p>1006</p></td>
<td><p>EVENT_SERVER_INIT_RPC_FAILED</p></td>
<td><p>The DHCP service failed to start as a RPC server. The following error occurred : %n%1</p></td>
</tr>
<tr class="odd">
<td><p>1007</p></td>
<td><p>EVENT_SERVER_INIT_SOCK_FAILED</p></td>
<td><p>The DHCP service failed to initialize Winsock data. The following error occurred: %n%1</p></td>
</tr>
<tr class="even">
<td><p>1008</p></td>
<td><p>EVENT_SERVER_SHUTDOWN</p></td>
<td><p>The DHCP service is shutting down due to the following error: %n%1</p></td>
</tr>
<tr class="odd">
<td><p>1009</p></td>
<td><p>EVENT_SERVER_CLIENT_CLEANUP</p></td>
<td><p>The DHCP service encountered the following error while cleaning up the pending client records: %n%1</p></td>
</tr>
<tr class="even">
<td><p>1010</p></td>
<td><p>EVENT_SERVER_DATABASE_CLEANUP</p></td>
<td><p>The DHCP service encountered the following error while cleaning up the database: %n%1</p></td>
</tr>
<tr class="odd">
<td><p>1011</p></td>
<td><p>EVENT_SERVER_LEASE_NACK</p></td>
<td><p>The DHCP service issued a NACK (negative acknowledgement message) to the client, %2, for the address, %1.</p></td>
</tr>
<tr class="even">
<td><p>1012</p></td>
<td><p>EVENT_SERVER_LEASE_DECLINED</p></td>
<td><p>The DHCP client, %2, declined the address %1.</p></td>
</tr>
<tr class="odd">
<td><p>1013</p></td>
<td><p>EVENT_SERVER_LEASE_RELEASE</p></td>
<td><p>The DHCP Client, %2, released the address %1.</p></td>
</tr>
<tr class="even">
<td><p>1016</p></td>
<td><p>EVENT_SERVER_DATABASE_BACKUP</p></td>
<td><p>The DHCP service encountered the following error when backing up the database: %n%1</p></td>
</tr>
<tr class="odd">
<td><p>1017</p></td>
<td><p>EVENT_SERVER_CONFIG_BACKUP</p></td>
<td><p>The DHCP service encountered the following error when backing up the registry configuration: %n%1</p></td>
</tr>
<tr class="even">
<td><p>1018</p></td>
<td><p>EVENT_SERVER_DATABASE_RESTORE_FAILED</p></td>
<td><p>The DHCP service failed to restore the database. The following error occurred: %n%1</p></td>
</tr>
<tr class="odd">
<td><p>1019</p></td>
<td><p>EVENT_SERVER_CONFIG_RESTORE_FAILED</p></td>
<td><p>The DHCP service failed to restore the DHCP registry configuration. The following error occurred: %n%1</p></td>
</tr>
<tr class="even">
<td><p>1020</p></td>
<td><p>EVENT_SERVER_LOW_ADDRESS_WARNING</p></td>
<td><p>Scope, %1, is %2 percent full with only %3 IP addresses remaining.</p></td>
</tr>
<tr class="odd">
<td><p>1021</p></td>
<td><p>EVENT_SERVER_LOAD_JET_FAILED</p></td>
<td><p>The DHCP service could not load the JET database library successfully.</p></td>
</tr>
<tr class="even">
<td><p>1022</p></td>
<td><p>EVENT_SERVER_JET_CONV_REQUIRED</p></td>
<td><p>The DHCP service could not use the database. If this service was started for the first time after the upgrade from NT 3.51 or earlier, you need to run the utility, upg351db.exe, on the DHCP database to convert it to the new JET database format. Restart the DHCP service after you have upgraded the database.</p></td>
</tr>
<tr class="odd">
<td><p>1023</p></td>
<td><p>EVENT_SERVER_JET_CONV_IN_PROGRESS</p></td>
<td><p>The DHCP service will now terminate because the existing database needs conversion to Windows 2000 format. The conversion via the jetconv process, has initiated. Do not reboot or stop the jetconv process. The conversion may take up to 10 minutes depending on the size of the database. Terminate DHCP now by clicking OK. This is required for the database conversion to succeed. NOTE: The DHCP service will be restarted automatically when the conversion is completed. To check conversion status, look at the Application event log for the jetconv process.</p></td>
</tr>
<tr class="even">
<td><p>1024</p></td>
<td><p>EVENT_SERVER_INIT_AND_READY</p></td>
<td><p>The DHCP service has initialized and is ready</p></td>
</tr>
<tr class="odd">
<td><p>1025</p></td>
<td><p>EVENT_SERVER_BOOT_FILE_TABLE</p></td>
<td><p>The DHCP service was unable to read the BOOTP file table from the registry. The DHCP service will be unable to respond to BOOTP requests that specify the boot file name.</p></td>
</tr>
<tr class="even">
<td><p>1026</p></td>
<td><p>EVENT_SERVER_BOOT_FILE_NAME</p></td>
<td><p>The DHCP service was unable to read the global BOOTP file name from the registry.</p></td>
</tr>
<tr class="odd">
<td><p>1027</p></td>
<td><p>EVENT_SERVER_AUDIT_LOG_APPEND_FAILED</p></td>
<td><p>The audit log file cannot be appended.</p></td>
</tr>
<tr class="even">
<td><p>1028</p></td>
<td><p>EVENT_SERVER_INIT_AUDIT_LOG_FAILED</p></td>
<td><p>The DHCP service failed to initialize the audit log. The following error occurred: %n%1</p></td>
</tr>
<tr class="odd">
<td><p>1029</p></td>
<td><p>EVENT_SERVER_PING_FAILED</p></td>
<td><p>The DHCP service was unable to ping for a new IP address. The address was leased to the client.</p></td>
</tr>
<tr class="even">
<td><p>1030</p></td>
<td><p>EVENT_SERVER_MOVE_AUDIT_LOG_FAILED</p></td>
<td><p>The audit log file could not be backed up. The following error occurred: %n%1</p></td>
</tr>
<tr class="odd">
<td><p>1031</p></td>
<td><p>EVENT_SERVER_CALLOUT_UNHANDLED_EXCEPTION</p></td>
<td><p>The installed server callout .dll file has caused an exception. The exception was: %n%1. The server has ignored this exception. All further exceptions will be ignored.</p></td>
</tr>
<tr class="even">
<td><p>1032</p></td>
<td><p>EVENT_SERVER_CALLOUT_LOAD_EXCEPTION</p></td>
<td><p>The installed server callout .dll file has caused an exception. The exception was: %n%1. The server has ignored this exception and the .dll file could not be loaded.</p></td>
</tr>
<tr class="odd">
<td><p>1033</p></td>
<td><p>EVENT_SERVER_CALLOUT_LOAD_SUCCESS</p></td>
<td><p>The DHCP service has successfully loaded one or more callout DLLs.</p></td>
</tr>
<tr class="even">
<td><p>1034</p></td>
<td><p>EVENT_SERVER_READ_ONLY_GROUP_ERROR</p></td>
<td><p>The DHCP service has failed to load one or more callout DLLs. The following error occured: %n%1</p></td>
</tr>
<tr class="odd">
<td><p>1035</p></td>
<td><p>EVENT_SERVER_READ_ONLY_GROUP_ERROR</p></td>
<td><p>The DHCP service was unable to create or lookup the DHCP Users local group on this computer. The error code is in the data.</p></td>
</tr>
<tr class="even">
<td><p>1036</p></td>
<td><p>EVENT_SERVER_ADMIN_GROUP_ERROR</p></td>
<td><p>The DHCP server was unable to create or lookup the DHCP Administrators local group on this computer. The error code is in the data.</p></td>
</tr>
<tr class="odd">
<td><p>1037</p></td>
<td><p>EVENT_SERVER_CLEANUP_STARTED</p></td>
<td><p>The DHCP service has started to clean up the database.</p></td>
</tr>
<tr class="even">
<td><p>1038</p></td>
<td><p>EVENT_SERVER_IPCLEANUP_FINISHED</p></td>
<td><p>The DHCP service has cleaned up the database for unicast IP addresses -- %1 leases have been recovered and %2 records have been removed from the database.</p></td>
</tr>
<tr class="odd">
<td><p>1039</p></td>
<td><p>EVENT_SERVER_MCASTCLEANUP_FINISHED</p></td>
<td><p>The DHCP service has cleaned up the database for multicast IP addresses -- %1 leases have expired (been marked for deletion) and %2 records have been removed from the database.</p></td>
</tr>
<tr class="even">
<td><p>1040</p></td>
<td><p>EVENT_SERVER_DATABASE_RESTORE_SUCCEEDED</p></td>
<td><p>The DHCP service successfully restored the database.</p></td>
</tr>
<tr class="odd">
<td><p>1041</p></td>
<td><p>DHCP_ROGUE_EVENT_NO_NETWORK</p></td>
<td><p>The DHCP service is not servicing any DHCPv4 clients because none of the active network interfaces have statically configured IPv4 addresses, or there are no active interfaces.</p></td>
</tr>
<tr class="even">
<td><p>1042</p></td>
<td><p>DHCP_ROGUE_EVENT_UNAUTHORIZED_INFO</p></td>
<td><p>The DHCP/BINL service running on this machine has detected a server on the network. If the server does not belong to any domain, the domain is listed as empty. The IP address of the server is listed in parentheses. %1</p></td>
</tr>
<tr class="odd">
<td><p>1043</p></td>
<td><p>DHCP_ROGUE_EVENT_STARTED</p></td>
<td><p>The DHCP/BINL service on the local machine has determined that it is authorized to start. It is servicing clients now.</p></td>
</tr>
<tr class="even">
<td><p>1044</p></td>
<td><p>DHCP_ROGUE_EVENT_STARTED_DOMAIN</p></td>
<td><p>The DHCP/BINL service on the local machine, belonging to the Windows Administrative domain %2, has determined that it is authorized to start. It is servicing clients now.</p></td>
</tr>
<tr class="odd">
<td><p>1045</p></td>
<td><p>DHCP_ROGUE_EVENT_STOPPED</p></td>
<td><p>The DHCP/BINL service on the local machine has determined that it is not authorized to start. It has stopped servicing clients. The following are some possible reasons for this: %n%tThis machine belongs to a workgroup and has encountered another DHCP Server (belonging to a Windows Administrative Domain) servicing the same network. %n%n%tAn unexpected network error occurred.</p></td>
</tr>
<tr class="even">
<td><p>1046</p></td>
<td><p>DHCP_ROGUE_EVENT_STOPPED_DOMAIN</p></td>
<td><p>The DHCP/BINL service on the local machine, belonging to the Windows Administrative domain %2, has determined that it is not authorized to start. It has stopped servicing clients. The following are some possible reasons for this: %n%tThis machine is part of a directory service enterprise and is not authorized in the same domain. (See help on the DHCP Service Management Tool for additional information). %n%n%tThis machine cannot reach its directory service enterprise and it has encountered another DHCP service on the network belonging to a directory service enterprise on which the local machine is not authorized. %n%n%tSome unexpected network error occurred.</p></td>
</tr>
<tr class="odd">
<td><p>1047</p></td>
<td><p>DHCP_ROGUE_EVENT_JUST_UPGRADED</p></td>
<td><p>The DHCP/BINL service on the local machine has determined that it is authorized to start. It is servicing clients now. %nThe DHCP/BINL service has determined that the machine was recently upgraded. If the machine is intended to belong to a directory service enterprise, the DHCP service must be authorized in the directory service for it to start servicing clients. (See help on DHCP Service Management Tool for authorizing the server).</p></td>
</tr>
<tr class="even">
<td><p>1048</p></td>
<td><p>DHCP_ROGUE_EVENT_JUST_UPGRADED_DOMAIN</p></td>
<td><p>The DHCP/BINL Service on the local machine, belonging to Windows Domain %2, has determined that it is authorized to start. It is servicing clients now. It has determined that the computer was recently upgraded. It has also determined that either there is no directory service enterprise for the domain or that the computer is not authorized in the directory service. All DHCP services that belong to a directory service enterprise should be authorized in the directory service to service clients. (See help on the DHCP Service Management Tool for authorizing a DHCP service in the directory service).</p></td>
</tr>
<tr class="odd">
<td><p>1049</p></td>
<td><p>DHCP_ROGUE_EVENT_CANT_FIND_DOMAIN</p></td>
<td><p>The DHCP/BINL service on the local machine encountered an error while trying to find the domain of the local machine. The error was: %3.</p></td>
</tr>
<tr class="even">
<td><p>1050</p></td>
<td><p>DHCP_ROGUE_EVENT_NETWORK_FAILURE</p></td>
<td><p>The DHCP/BINL service on the local machine encountered a network error. The error was: %3.</p></td>
</tr>
<tr class="odd">
<td><p>1051</p></td>
<td><p>DHCP_ROGUE_EVENT_UNAUTHORIZED</p></td>
<td><p>The DHCP/BINL service has determined that it is not authorized to service clients on this network for the Windows domain: %2. All DHCP services that belong to a directory service enterprise must be authorized in the directory service to service clients. (See help on the DHCP Service Management Tool for authorizing a DHCP server in the directory service).</p></td>
</tr>
<tr class="even">
<td><p>1052</p></td>
<td><p>DHCP_ROGUE_EVENT_OTHER_SERVER</p></td>
<td><p>The DHCP/BINL service on this workgroup server has encountered another server with IP Address, %1, belonging to the domain %2.</p></td>
</tr>
<tr class="odd">
<td><p>1053</p></td>
<td><p>DHCP_ROGUE_EVENT_SAM_OTHER_SERVER</p></td>
<td><p>The DHCP/BINL service has encountered another server on this network with IP Address, %1, belonging to the domain: %2.</p></td>
</tr>
<tr class="even">
<td><p>1054</p></td>
<td><p>DHCP_ROGUE_EVENT_SHUTDOWN</p></td>
<td><p>The DHCP/BINL service on this computer is shutting down. See the previous event log messages for reasons.</p></td>
</tr>
<tr class="odd">
<td><p>1055</p></td>
<td><p>DHCP_EVENT_DNS_REGPARAMS_FAILURE</p></td>
<td><p>The DHCP service was unable to impersonate the credentials necessary for DNS registrations: %n%1. The local system credentials is being used.</p></td>
</tr>
<tr class="even">
<td><p>1056</p></td>
<td><p>DHCP_EVENT_NO_DNSCREDENTIALS_ON_DC</p></td>
<td><p>The DHCP service has detected that it is running on a DC and has no credentials configured for use with Dynamic DNS registrations initiated by the DHCP service. This is not a recommended security configuration. Credentials for Dynamic DNS registrations may be configured using the command line &amp;quot;netsh dhcp server set dnscredentials&amp;quot; or via the DHCP Administrative tool.</p></td>
</tr>
<tr class="odd">
<td><p>1057</p></td>
<td><p>EVENT_SERVER_DATABASE_CONVERSION</p></td>
<td><p>The DHCP service was unable to convert the temporary database to ESE format: %n%1.</p></td>
</tr>
<tr class="even">
<td><p>1058</p></td>
<td><p>EVENT_SERVER_INIT_CONFIG_FAILED</p></td>
<td><p>The DHCP service failed to initialize its configuration parameters. The following error occurred: %n%1</p></td>
</tr>
<tr class="odd">
<td><p>1059</p></td>
<td><p>VENT_SERVER_COULDNT_SEE_DS</p></td>
<td><p>The DHCP service failed to see a directory server for authorization.</p></td>
</tr>
<tr class="even">
<td><p>1060</p></td>
<td><p>EVENT_SERVER_AUDITLOG_PATH_NOT_ACCESSIBLE</p></td>
<td><p>The DHCP service was unable to access path specified for the audit log.</p></td>
</tr>
<tr class="odd">
<td><p>1061</p></td>
<td><p>EVENT_SERVER_BACKUP_PATH_NOT_ACCESSIBLE</p></td>
<td><p>The DHCP service was unable to access path specified for the database backups.</p></td>
</tr>
<tr class="even">
<td><p>1062</p></td>
<td><p>EVENT_SERVER_DB_PATH_NOT_ACCESSIBLE</p></td>
<td><p>The DHCP service was unable to access path specified for the database</p></td>
</tr>
<tr class="odd">
<td><p>1063</p></td>
<td><p>EVENT_SERVER_SCOPE_FULL</p></td>
<td><p>There are no IP addresses available for lease in the scope or superscope &amp;quot;%1&amp;quot;.</p></td>
</tr>
<tr class="even">
<td><p>1064</p></td>
<td><p>EVENT_SERVER_BOOTP_FULL</p></td>
<td><p>There are no IP addresses available for BOOTP clients in the scope or superscope &amp;quot;%1&amp;quot;.</p></td>
</tr>
<tr class="odd">
<td><p>1065</p></td>
<td><p>EVENT_SERVER_ORPHONED_ENTRIES_DELETED</p></td>
<td><p>There were some orphaned entries deleted in the configuration due to the deletion of a class or an option definition. Please recheck the server configuration.</p></td>
</tr>
<tr class="even">
<td><p>1144</p></td>
<td><p>EVENT_SERVER_NEED_STATIC_IP</p></td>
<td><p>This computer has at least one dynamically assigned IP address. For reliable DHCP Server operation, you should use only static IP addresses.</p></td>
</tr>
<tr class="odd">
<td><p>1338</p></td>
<td><p>EVENT_SERVER_OFFER_QUEUE_FULL</p></td>
<td><p>The number of pending DHCPOFFER messages for delayed transmission to the client has exceeded the server&amp;apos;s capacity of 1000 pending messages. The DHCP server will drop all subsequent DHCPDISCOVER messages for which the DHCPOFFER message response needs to be delayed as per the server configuration. The DHCP server will continue to process DHCPDISCOVER messages for which the DHCPOFFER message responses do not need to be delayed. The DHCP server will resume processing all DHCPDISCOVER messages once the number of pending DHCPOFFER messages for delayed transmission to the client is below the server&amp;apos;s capacity.</p></td>
</tr>
<tr class="even">
<td><p>1339</p></td>
<td><p>EVENT_SERVER_OFFER_QUEUE_FUNCTIONAL</p></td>
<td><p>The number pending DHCPOFFER messages for delayed transmission to the client is now below the server&amp;apos;s capacity of 1000. The DHCP server will now resume processing all DHCPDISCOVER messages.</p></td>
</tr>
<tr class="odd">
<td><p>1340</p></td>
<td><p>EVENT_SERVER_DNSDHCID_FAIL</p></td>
<td><p>The DNS registration for DHCPv4 Client IP address %1 , FQDN %2 and DHCID %3 has been denied as there is probably an existing client with same FQDN already registered with DNS.</p></td>
</tr>
<tr class="even">
<td><p>1341</p></td>
<td><p>EVENT_SERVER_POLICY_RANGES_FULL</p></td>
<td><p>There are no IP addresses available for lease in IP address range(s) of the policy %1 in scope %2.</p></td>
</tr>
<tr class="odd">
<td><p>1342</p></td>
<td><p>EVENT_SERVER_RESIDUAL_RANGES_FULL</p></td>
<td><p>IP address range of scope %1 is out of IP addresses.</p></td>
</tr>
<tr class="even">
<td><p>1343</p></td>
<td><p>EVENT_SERVER_POLICY_RANGES_LOW_ADDRESS_WARNING</p></td>
<td><p>Ip address range(s) for the scope %1 policy %2 is %3 percent full with only %4 IP addresses available .</p></td>
</tr>
<tr class="odd">
<td><p>1344</p></td>
<td><p>EVENT_SERVER_DNS_VALIDATION_FAILED</p></td>
<td><p>The DNS IP Address %1 is not a valid DNS Server Address.</p></td>
</tr>
<tr class="even">
<td><p>1376</p></td>
<td><p>EVENT_SERVER_RESIDUAL_RANGES_LOW_ADDRESS_WARNING</p></td>
<td><p>IP address range of scope %1 is %2 percent full with only %3 IP addresses available.</p></td>
</tr>
<tr class="odd">
<td><p>1377</p></td>
<td><p>EVENT_SERVER_SUPERSCOPE_LOW_ADDRESS_WARNING</p></td>
<td><p>SuperScope, %1, is %2 percent full with only %3 IP addresses remaining. This superscope has the following scopes %4</p></td>
</tr>
<tr class="even">
<td><p>10000</p></td>
<td><p>EVENT_DHCPV6_ADDERESS_NACKED</p></td>
<td><p>DHCPv6 confirmation has been declined because the address was not appropriate to the link or DHCPv6 renew request has a Zero lifetime for Client Address %1.</p></td>
</tr>
<tr class="odd">
<td><p>10001</p></td>
<td><p>EVENT_DHCPV6_REQUEST_RECEIVED_FOR_ADDRESSES_NOT_LEASED</p></td>
<td><p>Renew, rebind or confirm received for IPv6 addresses %1 for which there are no active lease available.</p></td>
</tr>
<tr class="even">
<td><p>10002</p></td>
<td><p>EVENT_DHCPV6_SERVER_UNKNOWN_OPTION</p></td>
<td><p>DHCPv6 service received the unknown option %1, with a length of %2. The raw option data is given below.</p></td>
</tr>
<tr class="odd">
<td><p>10003</p></td>
<td><p>EVENT_DHCPV6_SERVER_SCOPE_FULL</p></td>
<td><p>There are no IPv6 addresses available to lease in the scope serving the network with Prefix %1.</p></td>
</tr>
<tr class="even">
<td><p>10004</p></td>
<td><p>EVENT_DHCPV6_SERVER_LEASE_DECLINED</p></td>
<td><p>The DHCPv6 client, %2, declined the address %1.</p></td>
</tr>
<tr class="odd">
<td><p>10005</p></td>
<td><p>EVENT_DHCPV6_SERVER_LOW_ADDRESS_WARNING</p></td>
<td><p>DHCPv6 Scope serving the network with prefix %1, is %2 percent full with only %3 IP addresses remaining.</p></td>
</tr>
<tr class="even">
<td><p>10006</p></td>
<td><p>EVENT_DHCPV6_CLIENT_DELETE</p></td>
<td><p>A DHCPV6 client %1 has been deleted from DHCPV6 database.</p></td>
</tr>
<tr class="odd">
<td><p>10007</p></td>
<td><p>EVENT_DHCPV6_DROP_TIMEOUT</p></td>
<td><p>A DHCPV6 message that was in the queue for more than 30 seconds has been dropped because it is too old to process.</p></td>
</tr>
<tr class="even">
<td><p>10008</p></td>
<td><p>EVENT_DHCPV6_DROP_INVALID</p></td>
<td><p>An invalid DHCPV6 message has been dropped.</p></td>
</tr>
<tr class="odd">
<td><p>10009</p></td>
<td><p>EVENT_DHCPV6_DROP_WRONG_SERVER</p></td>
<td><p>A DHCPV6 message that was not meant for this server has been dropped.</p></td>
</tr>
<tr class="even">
<td><p>10010</p></td>
<td><p>EVENT_DHCPV6_DROP_UNICAST</p></td>
<td><p>DHCV6 message has been dropped because it was received on a Uni-cast address and unicast support is disabled on the server.</p></td>
</tr>
<tr class="odd">
<td><p>10011</p></td>
<td><p>EVENT_DHCPV6_SERVER_AUDIT_LOG_APPEND_FAILED</p></td>
<td><p>DHCPV6 audit log file cannot be appended, Error Code returned %1.</p></td>
</tr>
<tr class="even">
<td><p>10012</p></td>
<td><p>EVENT_DHCPV6_DROP_UNAUTH</p></td>
<td><p>A DHCPV6 message has been dropped because the server is not authorized to process the message.</p></td>
</tr>
<tr class="odd">
<td><p>10013</p></td>
<td><p>EVENT_DHCPv6_SERVER_INIT_AUDIT_LOG_FAILED</p></td>
<td><p>The DHCPv6 service failed to initialize the audit log. The following error occurred: %n%1</p></td>
</tr>
<tr class="even">
<td><p>10014</p></td>
<td><p>EVENT_DHCPV6_SERVER_MOVE_AUDIT_LOG_FAILED</p></td>
<td><p>DHCPv6 audit log file could not be backed up. Error code %1</p></td>
</tr>
<tr class="odd">
<td><p>10015</p></td>
<td><p>EVENT_DHCPV6_SERVER_AUDITLOG_PATH_NOT_ACCESSIBLE</p></td>
<td><p>The DHCPv6 service was unable to access path specified for the audit log.</p></td>
</tr>
<tr class="even">
<td><p>10016</p></td>
<td><p>EVENT_DHCPV6_SERVER_INIT_WINSOCK_FAILED</p></td>
<td><p>The DHCPv6 service failed to initialize Winsock startup. The following error occurred %1.</p></td>
</tr>
<tr class="odd">
<td><p>10017</p></td>
<td><p>EVENT_DHCPV6_NO_DNSCREDENTIALS_ON_DC</p></td>
<td><p>The DHCPv6 service has detected that it is running on a DC and has no credentials configured for use with Dynamic DNS registrations initiated by the DHCPv6 service. This is not a recommended security configuration.</p></td>
</tr>
<tr class="even">
<td><p>10018</p></td>
<td><p>EVENT_DHCPV6_SERVER_INTERFACE_NOTIFICATION</p></td>
<td><p>The DHCPv6 Server failed to receive a notification of interface list changes. Some of the interfaces will not be enabled in the DHCPv6 service.</p></td>
</tr>
<tr class="odd">
<td><p>10019</p></td>
<td><p>EVENT_DHCPV6_SERVER_INIT_CONFIG_FAILED</p></td>
<td><p>The DHCPv6 service failed to initialize its configuration parameters. The following error occurred: %n%1.</p></td>
</tr>
<tr class="even">
<td><p>10020</p></td>
<td><p>EVENT_DHCPV6_SERVER_NEED_STATIC_IP</p></td>
<td><p>This computer has at least one dynamically assigned IPv6 address. For reliable DHCPv6 server operation, you should use only static IPv6 addresses.</p></td>
</tr>
<tr class="odd">
<td><p>10021</p></td>
<td><p>EVENT_DHCPV6_SERVER_INIT_DATABASE_FAILED</p></td>
<td><p>DHCPv6 service failed to initialize the database. The following error occurred: %n%1.</p></td>
</tr>
<tr class="even">
<td><p>10022</p></td>
<td><p>EVENT_DHCPV6_SERVER_INIT_AND_READY</p></td>
<td><p>The DHCPv6 service has initialized and is ready to serve.</p></td>
</tr>
<tr class="odd">
<td><p>10023</p></td>
<td><p>EVENT_DHCPV6_PORT_UNAVAILABLE</p></td>
<td><p>DHCPv6 Server is unable to bind to UDP port number %1 as it is used by another application. This port must be made available to DHCPv6 Server to start servicing the clients.</p></td>
</tr>
<tr class="even">
<td><p>10024</p></td>
<td><p>ERROR_LAST_DHCPV6_SERVER_ERROR</p></td>
<td><p>ERROR_LAST_DHCPV6_SERVER_ERROR</p></td>
</tr>
<tr class="odd">
<td><p>10025</p></td>
<td><p>EVENT_DHCPV6_DNSDHCID_FAIL</p></td>
<td><p>The DNS registration for DHCPv6 Client IPv6 address %1, FQDN %2 and DHCID %3 has been denied as there is probably an existing client with same FQDN already registered with DNS.</p></td>
</tr>
<tr class="even">
<td><p>20090</p></td>
<td><p>EVENT_DHCP_PORT_UNAVAILABLE</p></td>
<td><p>DHCP Server is unable to bind to UDP port number %1 as it is used by another application. This port must be made available to DHCP Server to start servicing the clients.</p></td>
</tr>
<tr class="odd">
<td><p>20098</p></td>
<td><p>EVENT_FILTER_EMPTY_ALLOW_LIST</p></td>
<td><p>No DHCP clients are being served, as the Allow list is empty and the server was configured to provide DHCP services, to clients whose hardware addresses are present in the Allow List.</p></td>
</tr>
<tr class="even">
<td><p>20251</p></td>
<td><p>DHCPv4.ChangeFailoverRelationState</p></td>
<td><p>The failover state of server: %1 for failover relationship: %2 changed from: %3 to %4.</p></td>
</tr>
<tr class="odd">
<td><p>20252</p></td>
<td><p>DHCPv4.ChangeFailoverRelationStateError</p></td>
<td><p>The failover state of server: %1 for failover relationship: %2 changed from: %3 to %4.</p></td>
</tr>
<tr class="even">
<td><p>20253</p></td>
<td><p>DHCPv4.FailoverServerTimeSync</p></td>
<td><p>The server detected that it is out of time synchronization with partner server: %1 for failover relationship: %2. The time is out of sync by: %3 seconds .</p></td>
</tr>
<tr class="odd">
<td><p>20254</p></td>
<td><p>DHCPv4.FailoverCommUp</p></td>
<td><p>Server has established contact with failover partner server %1 for relationship %2 .</p></td>
</tr>
<tr class="even">
<td><p>20255</p></td>
<td><p>DHCPv4.FailoverCommDown</p></td>
<td><p>Server has lost contact with failover partner server %1 for relationship %2 .</p></td>
</tr>
<tr class="odd">
<td><p>20256</p></td>
<td><p>DHCPv4.AuthFailedBndUpdMsgDigestFailedToCompare</p></td>
<td><p>Failover protocol message BINDING-UPDATE from server %1 for failover relationship %2 was rejected because message digest failed to compare.</p></td>
</tr>
<tr class="even">
<td><p>20257</p></td>
<td><p>DHCPv4.AuthFailedBndUpdMsgDigestNotConfigured</p></td>
<td><p>Failover protocol message BINDING-UPDATE from server %1 for failover relationship %2 was rejected because message digest was not configured.</p></td>
</tr>
<tr class="odd">
<td><p>20258</p></td>
<td><p>DHCPv4.AuthFailedBndUpdMsgDigestNotPresent</p></td>
<td><p>Failover protocol message BINDING-UPDATE from server %1 for failover relationship %2 is rejected because message digest was not present.</p></td>
</tr>
<tr class="even">
<td><p>20259</p></td>
<td><p>DHCPv4.ChangeFailoverRelationStateNoPrevState</p></td>
<td><p>The failover state of server: %1 for failover relationship: %2 changed to : %3.</p></td>
</tr>
<tr class="odd">
<td><p>20260</p></td>
<td><p>DHCPv4.ChangeFailoverRelationStateErrorNoPrevState</p></td>
<td><p>The failover state of server: %1 for failover relationship: %2 changed to: %3.</p></td>
</tr>
<tr class="even">
<td><p>20261</p></td>
<td><p>DHCPv4.AuthFailedBndAckMsgDigestFailedToCompare</p></td>
<td><p>Failover protocol message BINDING-ACK from server %1 for failover relationship %2 was rejected because message digest failed to compare.</p></td>
</tr>
<tr class="odd">
<td><p>20262</p></td>
<td><p>DHCPv4.AuthFailedBndAckMsgDigestNotConfigured</p></td>
<td><p>Failover protocol message BINDING-ACK from server %1 for failover relationship %2 was rejected because message digest was not configured.</p></td>
</tr>
<tr class="even">
<td><p>20263</p></td>
<td><p>DHCPv4.AuthFailedBndAckMsgDigestNotPresent</p></td>
<td><p>Failover protocol message BINDING-ACK from server %1 for failover relationship %2 is rejected because message digest was not present.</p></td>
</tr>
<tr class="odd">
<td><p>20264</p></td>
<td><p>DHCPv4.AuthFailedConnectMsgDigestFailedToCompare</p></td>
<td><p>Failover protocol message CONNECT from server %1 for failover relationship %2 was rejected because message digest failed to compare.</p></td>
</tr>
<tr class="even">
<td><p>20265</p></td>
<td><p>DHCPv4.AuthFailedConnectMsgDigestNotConfigured</p></td>
<td><p>Failover protocol message CONNECT from server %1 for failover relationship %2 was rejected because message digest was not configured.</p></td>
</tr>
<tr class="odd">
<td><p>20266</p></td>
<td><p>DHCPv4.AuthFailedConnectMsgDigestNotPresent</p></td>
<td><p>Failover protocol message CONNECT from server %1 for failover relationship %2 is rejected because message digest was not present.</p></td>
</tr>
<tr class="even">
<td><p>20267</p></td>
<td><p>DHCPv4.AuthFailedConnectAckMsgDigestFailedToCompare</p></td>
<td><p>Failover protocol message CONNECTACK from server %1 for failover relationship %2 was rejected because message digest failed to compare.</p></td>
</tr>
<tr class="odd">
<td><p>20268</p></td>
<td><p>DHCPv4.AuthFailedConnectAckMsgDigestNotConfigured</p></td>
<td><p>Failover protocol message CONNECTACK from server %1 for failover relationship %2 was rejected because message digest was not configured.</p></td>
</tr>
<tr class="even">
<td><p>20269</p></td>
<td><p>DHCPv4.AuthFailedConnectAckMsgDigestNotPresent</p></td>
<td><p>Failover protocol message CONNECTACK from server %1 for failover relationship %2 is rejected because message digest was not present.</p></td>
</tr>
<tr class="odd">
<td><p>20270</p></td>
<td><p>DHCPv4.AuthFailedUpdReqAllMsgDigestFailedToCompare</p></td>
<td><p>Failover protocol message UPDREQALL from server %1 for failover relationship %2 was rejected because message digest failed to compare.</p></td>
</tr>
<tr class="even">
<td><p>20271</p></td>
<td><p>DHCPv4.AuthFailedUpdReqAllMsgDigestNotConfigured</p></td>
<td><p>Failover protocol message UPDREQALL from server %1 for failover relationship %2 was rejected because message digest was not configured.</p></td>
</tr>
<tr class="odd">
<td><p>20272</p></td>
<td><p>DHCPv4.AuthFailedUpdReqAllMsgDigestNotPresent</p></td>
<td><p>Failover protocol message UPDREQALL from server %1 for failover relationship %2 is rejected because message digest was not present.</p></td>
</tr>
<tr class="even">
<td><p>20273</p></td>
<td><p>DHCPv4.AuthFailedUpdDoneMsgDigestFailedToCompare</p></td>
<td><p>Failover protocol message UPDDONE from server %1 for failover relationship %2 was rejected because message digest failed to compare.</p></td>
</tr>
<tr class="odd">
<td><p>20274</p></td>
<td><p>DHCPv4.AuthFailedUpdDoneMsgDigestNotConfigured</p></td>
<td><p>Failover protocol message UPDDONE from server %1 for failover relationship %2 was rejected because message digest was not configured.</p></td>
</tr>
<tr class="even">
<td><p>20275</p></td>
<td><p>DHCPv4.AuthFailedUpdDoneMsgDigestNotPresent</p></td>
<td><p>Failover protocol message UPDDONE from server %1 for failover relationship %2 is rejected because message digest was not present.</p></td>
</tr>
<tr class="odd">
<td><p>20276</p></td>
<td><p>DHCPv4.AuthFailedUpdReqMsgDigestFailedToCompare</p></td>
<td><p>Failover protocol message UPDREQ from server %1 for failover relationship %2 was rejected because message digest failed to compare.</p></td>
</tr>
<tr class="even">
<td><p>20277</p></td>
<td><p>DHCPv4.AuthFailedUpdReqMsgDigestNotConfigured</p></td>
<td><p>Failover protocol message UPDREQ from server %1 for failover relationship %2 was rejected because message digest was not configured.</p></td>
</tr>
<tr class="odd">
<td><p>20278</p></td>
<td><p>DHCPv4.AuthFailedUpdReqMsgDigestNotPresent</p></td>
<td><p>Failover protocol message UPDREQ from server %1 for failover relationship %2 is rejected because message digest was not present.</p></td>
</tr>
<tr class="even">
<td><p>20279</p></td>
<td><p>DHCPv4.AuthFailedStateMsgDigestFailedToCompare</p></td>
<td><p>Failover protocol message STATE from server %1 for failover relationship %2 was rejected because message digest failed to compare.</p></td>
</tr>
<tr class="odd">
<td><p>20280</p></td>
<td><p>DHCPv4.AuthFailedStateMsgDigestNotConfigured</p></td>
<td><p>Failover protocol message STATE from server %1 for failover relationship %2 was rejected because message digest was not configured.</p></td>
</tr>
<tr class="even">
<td><p>20281</p></td>
<td><p>DHCPv4.AuthFailedStateMsgDigestNotPresent</p></td>
<td><p>Failover protocol message STATE from server %1 for failover relationship %2 is rejected because message digest was not present.</p></td>
</tr>
<tr class="odd">
<td><p>20282</p></td>
<td><p>DHCPv4.AuthFailedContactMsgDigestFailedToCompare</p></td>
<td><p>Failover protocol message CONTACT from server %1 for failover relationship %2 was rejected because message digest failed to compare.</p></td>
</tr>
<tr class="even">
<td><p>20283</p></td>
<td><p>DHCPv4.AuthFailedContactMsgDigestNotConfigured</p></td>
<td><p>Failover protocol message CONTACT from server %1 for failover relationship %2 was rejected because message digest was not configured.</p></td>
</tr>
<tr class="odd">
<td><p>20284</p></td>
<td><p>DHCPv4.AuthFailedContactMsgDigestNotPresent</p></td>
<td><p>Failover protocol message CONTACT from server %1 for failover relationship %2 is rejected because message digest was not present.</p></td>
</tr>
<tr class="even">
<td><p>20285</p></td>
<td><p>DHCPv4.InvalidAlgorithmProvider</p></td>
<td><p>An invalid cryptographic algorithm %1 was specified for failover message authentication in FailoverCryptoAlgorithm under registry key HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DHCPServer\Parameters\Failover. The operation is halted.</p></td>
</tr>
<tr class="odd">
<td><p>20286</p></td>
<td><p>DHCPv4.FailoverClientLeaseDropped</p></td>
<td><p>BINDING UPDATE message for IP address %1 could not be replicated to the partner server %2 of failover relation %3 as the internal BINDING UPDATE queue is full.</p></td>
</tr>
<tr class="even">
<td><p>20287</p></td>
<td><p>DHCPv4.ClientRequestDropped</p></td>
<td><p>DHCP client request from %1 was dropped since the applicable IP address ranges in scope/superscope %2 are out of available IP addresses. This could be because of IP address ranges of a policy being out of available IP addresses.</p></td>
</tr>
<tr class="odd">
<td><p>20291</p></td>
<td><p>DHCPv4.SendBndAckMessageRejectReason</p></td>
<td><p>A BINDING-ACK message with transaction id: %1 was sent for IP address: %2 with reject reason: (%3) to partner server: %4 for failover relationship: %5.</p></td>
</tr>
<tr class="even">
<td><p>20292</p></td>
<td><p>DHCPv4.RecvBndAckMessageRejectReason</p></td>
<td><p>A BINDING-ACK message with transaction id: %1 was received for IP address: %2 with reject reason: (%3 ) from partner server: %4 for failover relationship: %5.</p></td>
</tr>
</tbody>
</table>
</details>

## DHCP server system events

<details>
    <summary>To view all server system events, expand this section.</summary>

</details>

## DHCP server filter notification events

<details>
    <summary>To view all server filter notification events, expand this section.</summary>
<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><strong>Event ID</strong></p></td>
<td><p><strong>Event category</strong></p></td>
<td><p><strong>Event text</strong></p></td>
</tr>
<tr class="even">
<td><p>20035</p></td>
<td><p>EVENT_SERVER_INTERFACE_NOTIFICATION</p></td>
<td><p>%1 %3</p></td>
</tr>
<tr class="odd">
<td><p>20058</p></td>
<td><p>DHCPv4HA.BndUpd</p></td>
<td><p>%1 %3</p></td>
</tr>
<tr class="even">
<td><p>20059</p></td>
<td><p>DHCPv4HA.BndAck</p></td>
<td><p>%1 %3</p></td>
</tr>
<tr class="odd">
<td><p>20060</p></td>
<td><p>DHCPv4HA.Connect</p></td>
<td><p>%1 %3</p></td>
</tr>
<tr class="even">
<td><p>20061</p></td>
<td><p>DHCPv4HA.ConnectAck</p></td>
<td><p>%1 %3</p></td>
</tr>
<tr class="odd">
<td><p>20062</p></td>
<td><p>DHCPv4HA.UpdReqAll</p></td>
<td><p>%1 %3</p></td>
</tr>
<tr class="even">
<td><p>20063</p></td>
<td><p>DHCPv4HA.UpdDone</p></td>
<td><p>%1 %3</p></td>
</tr>
<tr class="odd">
<td><p>20064</p></td>
<td><p>DHCPv4HA.UpdReq</p></td>
<td><p>%1 %3</p></td>
</tr>
<tr class="even">
<td><p>20065</p></td>
<td><p>DHCPv4HA.State</p></td>
<td><p>%1 %3</p></td>
</tr>
<tr class="odd">
<td><p>20066</p></td>
<td><p>DHCPv4HA.Contact</p></td>
<td><p>%1 %3</p></td>
</tr>
<tr class="even">
<td><p>20067</p></td>
<td><p>DHCPv4HA.Disconnect</p></td>
<td><p>%1 %3</p></td>
</tr>
<tr class="odd">
<td><p>20068</p></td>
<td><p>DHCPv4HA.ScavengerStart</p></td>
<td><p>Scavenger started.</p></td>
</tr>
<tr class="even">
<td><p>20069</p></td>
<td><p>DHCPv4HA.ScavengerEnd</p></td>
<td><p>Scavenger ended.</p></td>
</tr>
<tr class="odd">
<td><p>20161</p></td>
<td><p>DHCPv4HA.AddrAllocationTriggered</p></td>
<td><p>Address allocation triggered for the failover relationship %1.</p></td>
</tr>
<tr class="even">
<td><p>20163</p></td>
<td><p>DHCPv4Stateless.ScavengerEnd</p></td>
<td><p>Scavenger finished purging stateless entries.</p></td>
</tr>
<tr class="odd">
<td><p>20164</p></td>
<td><p>DHCPv4HA.TotalLeasesDeleted</p></td>
<td><p>The total leases deleted in scavenger are %1</p></td>
</tr>
<tr class="even">
<td><p>20165</p></td>
<td><p>DHCPv4HA.FailoverScopeDeleted</p></td>
<td><p>Scope %1 which was part of failover relationship %2 was not found in DHCP server database. Please restore the DHCP server database.</p></td>
</tr>
</tbody>
</table>

## DHCP Server Filter Notification Events

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><strong>Event ID</strong></p></td>
<td><p><strong>Event category</strong></p></td>
<td><p><strong>Event text</strong></p></td>
</tr>
<tr class="even">
<td><p>20096</p></td>
<td><p>EVENT_FILTER_DENIED_IN_DENY_LIST</p></td>
<td><p>DHCP Services were denied to machine with hardware address %1, hardware type %4 and FQDN/Hostname %2 because it matched entry %3 in the Deny List.</p></td>
</tr>
<tr class="odd">
<td><p>20097</p></td>
<td><p>EVENT_FILTER_DENIED_NOT_IN_ALLOW_LIST</p></td>
<td><p>DHCP Services were denied to machine with hardware address %1, hardware type %3 and FQDN/Hostname %2 because it did not match any entry in the Allow List.</p></td>
</tr>
<tr class="even">
<td><p>20099</p></td>
<td><p>EVENT_FILTER_DENIED_IN_DENY_LIST_UNSPECIFIED</p></td>
<td><p>DHCP Services were denied to machine with hardware address %1, hardware type %4 and unspecified FQDN/Hostname%2 because it matched entry %3 in the Deny List.</p></td>
</tr>
<tr class="odd">
<td><p>20100</p></td>
<td><p>EVENT_FILTER_DENIED_NOT_IN_ALLOW_LIST_UNSPECIFIED</p></td>
<td><p>DHCP Services were denied to machine with hardware address %1, hardware type %3 and unspecified FQDN/Hostname%2 because it did not match any entry in the Allow List.</p></td>
</tr>
</tbody>
</table>
</details>

## DHCP server audit events

<details>
    <summary>To view all server audit events, expand this section.</summary>
<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><strong>Event ID</strong></p></td>
<td><p><strong>Event category</strong></p></td>
<td><p><strong>Event text</strong></p></td>
</tr>
<tr class="even">
<td><p>20289</p></td>
<td><p>DHCPv4.SendBndUpdMessage</p></td>
<td><p>A BINDING-UPDATE message with transaction id: %1 was sent for IP address: %2 with binding status: %3 to partner server: %4 for failover relationship: %5.</p></td>
</tr>
<tr class="odd">
<td><p>20290</p></td>
<td><p>DHCPv4.RecvBndUpdMessage</p></td>
<td><p>A BINDING-UPDATE message with transaction id: %1 was received for IP address: %2 with binding status: %3 from partner server: %4 for failover relationship: %5.</p></td>
</tr>
<tr class="even">
<td><p>20293</p></td>
<td><p>DHCPv4.SendUpdReqMessage</p></td>
<td><p>A UPDREQ message with transaction id: %1 was sent to partner server: %2 for failover relationship: %3.</p></td>
</tr>
<tr class="odd">
<td><p>20294</p></td>
<td><p>DHCPv4.RecvUpdReqMessage</p></td>
<td><p>A UPDREQ message with transaction id: %1 was received from partner server: %2 for failover relationship: %3</p></td>
</tr>
<tr class="even">
<td><p>20295</p></td>
<td><p>DHCPv4.SendUpdDoneMessage</p></td>
<td><p>A UPDDONE message with transaction id: %1 was sent to partner server: %2 for failover relationship: %3.</p></td>
</tr>
<tr class="odd">
<td><p>20296</p></td>
<td><p>DHCPv4.RecvUpdDoneMessage</p></td>
<td><p>A UPDDONE message with transaction id: %1 was received from partner server: %2 for failover relationship: %3.</p></td>
</tr>
<tr class="even">
<td><p>20297</p></td>
<td><p>DHCPv4.SendUpdReqAllMessage</p></td>
<td><p>A UPDREQALL message with transaction id: %1 was sent to partner server: %2 for failover relationship: %3</p></td>
</tr>
<tr class="odd">
<td><p>20298</p></td>
<td><p>DHCPv4.RecvUpdReqAllMessage</p></td>
<td><p>A UPDREQALL message with transaction id: %1 was received from partner server: %2 for failover relationship: %3</p></td>
</tr>
<tr class="even">
<td><p>20299</p></td>
<td><p>DHCPv4.SendContactMessage</p></td>
<td><p>A CONTACT message with transaction id: %1 was sent to partner server: %2 for failover relationship: %3.</p></td>
</tr>
<tr class="odd">
<td><p>20300</p></td>
<td><p>DHCPv4.RecvContactMessage</p></td>
<td><p>A CONTACT message with transaction id: %1 was received from partner server: %2 for failover relationship: %3.</p></td>
</tr>
<tr class="even">
<td><p>20301</p></td>
<td><p>DHCPv4.SendConnectMessage</p></td>
<td><p>A CONNECT message with transaction id: %1 was sent to partner server: %2 for failover relationship: %3.</p></td>
</tr>
<tr class="odd">
<td><p>20302</p></td>
<td><p>DHCPv4.RecvConnectMessage</p></td>
<td><p>A CONNECT message with transaction id: %1 was received from partner server: %2 for failover relationship: %3.</p></td>
</tr>
<tr class="even">
<td><p>20303</p></td>
<td><p>DHCPv4.SendStateMessage</p></td>
<td><p>A STATE message with transaction id: %1 was sent to partner server : %2 for failover relationship %3 with state: %4 and start time of state: %5.</p></td>
</tr>
<tr class="odd">
<td><p>20304</p></td>
<td><p>DHCPv4.RecvStateMessage</p></td>
<td><p>A STATE message with transaction id: %1 was received from partner server : %2 for failover relationship %3 with state: %4 and start time of state %5.</p></td>
</tr>
<tr class="even">
<td><p>20305</p></td>
<td><p>DHCPv4.SendConnectAckMessage</p></td>
<td><p>A CONNECTACK message with transaction id %1 was sent to partner server : %2 for failover relationship: %3.</p></td>
</tr>
<tr class="odd">
<td><p>20306</p></td>
<td><p>DHCPv4.RecvConnectAckMessage</p></td>
<td><p>A CONNECTACK message with transaction id %1 was received from partner server : %2 for failover relationship: %3.</p></td>
</tr>
<tr class="even">
<td><p>20307</p></td>
<td><p>DHCPv4.SendBndAckMessageNoRejectReason</p></td>
<td><p>A BINDING-ACK message with transaction id: %1 was sent for IP address: %2 to partner server: %3 for failover relationship: %4.</p></td>
</tr>
<tr class="odd">
<td><p>20308</p></td>
<td><p>DHCPv4.RecvBndAckMessageNoRejectReason</p></td>
<td><p>A BINDING-ACK message with transaction id: %1 was received for IP address: %2 from partner server: %3 for failover relationship: %4.</p></td>
</tr>
<tr class="even">
<td><p>20309</p></td>
<td><p>DHCPv4.SendConnectAckMessageRejectReason</p></td>
<td><p>A CONNECTACK message with transaction id %1 was sent to partner server : %2 for failover relationship: %3 with reject reason: %4.</p></td>
</tr>
<tr class="odd">
<td><p>20310</p></td>
<td><p>DHCPv4.RecvConnectAckMessageRejectReason</p></td>
<td><p>A CONNECTACK message with transaction id %1 was received from partner server : %2 for failover relationship: %3 with reject reason: %4.</p></td>
</tr>
</tbody>
</table>
</details>