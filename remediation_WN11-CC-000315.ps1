<#
.SYNOPSIS
    This PowerShell script disables the Windows Installer feature 'Always install with elevated privileges'.
.NOTES
    Author          : Symone-Marie Priester
    LinkedIn        : linkedin.com/in/symone-mariepriester
    GitHub          : github.com/Symone-Marie
    Date Created    : 2025-02-08
    Last Modified   : 2025-02-08
    Version         : Microsoft Windows [Version 10.0.26200.7623]
    CVEs            : N/A
    Vuln-ID         : V-253411
    STIG-ID         : WN11-CC-000315
.TESTED ON
    Date(s) Tested  : 2025-02-08
    Tested By       : Symone-Marie Priester
    Systems Tested  : Windows 11 Pro OS
    PowerShell Ver. : 5.1
    Manual Test     : Yes, remediated via Registry Editor (regedit) with screenshot documentation
.USAGE
    Disables the 'Always install with elevated privileges' Windows Installer feature to prevent privilege escalation.
    Example syntax:
    PS C:\> .\remediation_WN11-CC-000315.ps1 
#>

# Define registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
$regName = "AlwaysInstallElevated"
$regValue = 0

# Create registry path if it doesn't exist
if (!(Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
    Write-Host "Created registry path: $regPath"
}

# Set the registry value
Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord
Write-Host "Set $regName to $regValue"

# Verify the change
$currentValue = Get-ItemProperty -Path $regPath -Name $regName -ErrorAction SilentlyContinue
if ($currentValue.$regName -eq $regValue) {
    Write-Host "SUCCESS: WN11-CC-000315 remediated - 'Always install with elevated privileges' is disabled"
} else {
    Write-Host "ERROR: Failed to set registry value"
}
