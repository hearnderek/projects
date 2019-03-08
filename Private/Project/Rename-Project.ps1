function Rename-Project
{
  param(
    [Parameter(Mandatory)] 
    [ValidatePattern('^[\w_-]+$')]
    [ValidateScript({@(Get-Projects) -contains $_})]
    [string] $ProjectName,

    [Parameter(Mandatory)] 
    [ValidatePattern('^[\w_-]+$')]
    [ValidateScript({!(@(Get-Projects) -contains $_)})]
    [string] $NewProjectName
  )
  
  Move-Item "$PSScriptRoot\..\..\Projects\$ProjectName" "$PSScriptRoot\..\..\Projects\$NewProjectName"
}