#! /usr/bin/env pwsh
<#PSScriptInfo

.VERSION 0.1.0.0

.GUID 9eec3193-01fd-4107-8736-d059ed608595

.AUTHOR Skye Soss

.COMPANYNAME

.COPYRIGHT MIT

.TAGS AdventOfCode

.LICENSEURI https://github.com/Skyb0rg007/Advent-of-Code/blob/master/LICENSE

.PROJECTURI https://github.com/Skyb0rg007/Advent-of-Code

.ICONURI

.EXTERNALMODULEDEPENDENCIES

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES

.PRIVATEDATA

#>
<#

.DESCRIPTION
Advent of Code 2024 Day 2 solution

#>

[CmdletBinding()]
param(
    [Parameter(Mandatory, Position=0)]
    [ValidateScript({ Test-Path $_ })]
    [String]$InputPath
)

Write-Output "Day 2"
Write-Verbose "Hello from PowerShell"
Write-Verbose "InputPath = $InputPath"

Get-Content $InputPath | Foreach-Object {
    Write-Verbose "Line = '$_'"
}

$List = [System.Collections.Generic.List[int]]::new()
$List.Add(1)
$List.Add(2)
$List.Add(3)
Write-Output $List
