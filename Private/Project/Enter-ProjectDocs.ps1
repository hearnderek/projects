Function Enter-ProjectDocs {
  param(
    [Parameter(Mandatory)] 
    [ValidatePattern('^[\w_-]+$')]
    [ValidateScript({@(Get-Projects) -contains $_})]
    [string] $ProjectName
  )

  $docsPath = "$PSScriptRoot\..\..\Projects\$ProjectName\docs"
  if(!(Test-Path $docsPath)) {
    mkdir $docsPath | out-null
  }

  explorer $docsPath

}
