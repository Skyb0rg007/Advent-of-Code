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

using namespace System.Collections.Generic

[CmdletBinding()]
param(
    [Parameter(Mandatory, Position=0)]
    [ValidateScript({ Test-Path $_ })]
    [String]$InputPath
)

Write-Output "Day 2"

Write-Verbose "Parsing $_"

$Levels = [List[List[int]]]::new()

Get-Content $InputPath | Foreach-Object {
    $Level = [List[int]]::new()
    $Level.AddRange([int[]]($_ -split " "))
    $Levels.Add($Level)
}

function IsSafe {
    param(
        [List[int]]$Reports
    )

    Write-Verbose "Checking $Reports"

    $Inc = $true
    $Dec = $true

    $Prev = $null
    foreach ( $Report in $Reports ) {
        if ( $null -eq $Prev ) {
        } elseif ( [Math]::Abs($Report - $Prev) -gt 3 ) {
            return $false
        } elseif ( $Report -lt $Prev ) {
            $Inc = $false
            if (-not $Dec) {
                return $false
            }
        } elseif ( $Report -gt $Prev ) {
            $Dec = $false
            if (-not $Inc) {
                return $false
            }
        } else {
            return $false
        }
        $Prev = $Report
    }
    return $true
}

$Safe = 0
$TolSafe = 0
foreach ( $Level in $Levels ) {
    if ( IsSafe $Level ) {
        Write-Verbose "$Level : Safe"
        $Safe += 1
        $TolSafe += 1
    } else {
        foreach ( $i in 0 .. ($Level.Count - 1) ) {
            $Mod = $Level.Slice(0, $Level.Count)
            $Mod.RemoveAt($i)
            if (IsSafe $Mod) {
                Write-Verbose "$Level -> $Mod : Safe"
                $TolSafe += 1
                break
            }
        }
    }
}

Write-Output "Part 1: $Safe"
Write-Output "Part 2: $TolSafe"
