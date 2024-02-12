> [!Note] 
> When running the Guarded Fabric diagnostics tool (Get-HgsTrace -RunDiagnostics), incorrect status may be returned claiming that the HTTPS configuration is broken when it is, in fact, not broken or not being used. This error can be returned regardless of HGS' attestation mode. The possible root-causes are as follows:
>
> - HTTPS is indeed improperly configured/broken<br>
> - You're using admin-trusted attestation and the trust relationship is broken<br>
> &nbsp;&nbsp;&nbsp;&nbsp;- This is irrespective of whether HTTPS is configured properly, improperly, or not in use at all.<br>
>
> Note that the diagnostics will only return this incorrect status when targeting a Hyper-V host. If the diagnostics are targeting the Host Guardian Service, the status returned will be correct.

<!-- Appears in guarded-fabric-setting-up-the-host-guardian-service-hgs.md and guarded-fabric-troubleshoot-diagnostics.md
-->
