function Get-HighLevelTasks
{
  $hash = @{}
  Select-String -Path (ls "$PSScriptRoot\..\Projects\*\tasks.ls") -Pattern '- \[[ -]\]' | group path | %{ 
    $name = ($_.Name -replace '.+\\Projects\\|\\tasks.ls','')
    $topTask = $_.group |? { $_.Line -NotMatch '\[\d*/\d*\]'} | select -first 1 | %{($_.Line).trim()}
    
    $hash[$name] = $topTask
  }

  
  $prioritized = Get-Priority |? {$hash[$_]}
  
  $prioritized | % {
    Write-Host $_ -ForegroundColor Yellow
    Write-Host $hash[$_] -ForegroundColor White
  }

  $projectName = ''
  $currentTask = ''

  $prioritized | select -first 1 | % {
    $projectName = "$_  " 
    $currentTask = $(($hash[$_] -replace '- \[ \]','').Trim())
  }

  $dashes = ($projectName + $CurrentTask) -replace '.','~' 

  #~~~~~~~~~~~~~~~~~~~~~~~~~
  #Current Task:
  #<Project Name> <Top Task>
  #~~~~~~~~~~~~~~~~~~~~~~~~~
  Write-Host ''
  Write-Host $dashes         -ForegroundColor Red
  Write-Host "Current Task:" -ForegroundColor Yellow
  Write-Host $projectName    -ForegroundColor Green  -NoNewline
  Write-Host $currentTask    -ForegroundColor Cyan
  Write-Host $dashes         -ForegroundColor Red
}
