function New-Project
{
  param(
    [Parameter(Mandatory)]
    [ValidatePattern('^[\w_-]+$')]
    [ValidateScript({!(@(Get-Projects) -contains $_)})]
    [string] $ProjectName
  )
  
  mkdir "$PSScriptRoot\..\..\Projects\$ProjectName"
}