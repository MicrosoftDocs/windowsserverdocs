
$MeasureCommand = Get-Command -Module Microsoft.PowerShell.Utility -Name Measure-Command
$Stopwatch = [System.Diagnostics.Stopwatch]::new()

class MeasureScriptOutput
{
    [string]$Message
    [double]$ElapsedMilliseconds
    [double]$IterationsPerSecond
}

function Measure-Script
{
    param([scriptblock]$ScriptBlock,
          [string]$Message,
          [int] $Iterations = 100)

    $Benchmark = [scriptblock]::Create(@'
param($Iterations)
for (${{ i}} = 0; ${{ i}} -lt $Iterations; ${{ i}}++) {{
{0}
}}
'@ -f $ScriptBlock.ToString())

    # Prime the script block - this should cause
    # it to get JIT compiled
    $null = & $Benchmark -Iterations ([math]::Min(32, $Iterations))

    # Sleep a tiny bit to hopefully wait for the
    # JIT to finish
    Start-Sleep -Milliseconds 10

    $Stopwatch.Restart()
    $null = & $Benchmark -Iterations $Iterations
    $Stopwatch.Stop()
    $elapsed = $Stopwatch.Elapsed.TotalMilliseconds
    [MeasureScriptOutput]@{
        Message = $Message
        ElapsedMilliseconds = $elapsed
        IterationsPerSecond = 1000 / $elapsed * $Iterations
    }
}

& {
    Write-Host "Suppressing output of a single object"
    Measure-Script { $null = 1 }    -Iterations 100kb -Message '$null = ...'
    Measure-Script { [void]1 }      -Iterations 100kb -Message '[void]...'
    Measure-Script { 1 > $null }    -Iterations 100kb -Message '... > $null'
    Measure-Script { 1 | Out-Null } -Iterations 10kb  -Message '... | Out-Null'
} | Format-Table Message,IterationsPerSecond

& {
    Write-Host "Suppressing output of many objects"
    Measure-Script { $null = for ($i = 0; $i -lt 100kb; $i++) { $i } }       -Iterations 10 -Message '$null = ...'
    Measure-Script { [void] $(for ($i = 0; $i -lt 100kb; $i++) { $i }) }     -Iterations 10 -Message '[void]...'
    Measure-Script { $(for ($i = 0; $i -lt 100kb; $i++) { $i }) > $null }    -Iterations 10 -Message '... > $null'
    Measure-Script { $(for ($i = 0; $i -lt 100kb; $i++) { $i }) | Out-Null } -Iterations 1  -Message '... | Out-Null'
} | Format-Table Message,IterationsPerSecond