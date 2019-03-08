function Remove-Project
{
  param(
    [Parameter(Mandatory)] 
    [ValidatePattern('^[\w_-]+$')]
    [ValidateScript({@(Get-Projects) -contains $_})]
    [string] $ProjectName
  )

  mv "$PSScriptRoot\..\..\Projects\$ProjectName\" "$PSScriptRoot\..\..\Archive\$ProjectName\"
}