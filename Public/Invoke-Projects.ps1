<#
.SYNOPSIS
CLI for project/task management
#>
function Invoke-Projects
{
  Param(
    [switch] $tasks,
    [switch] $projects,
    [switch] $select,
    [switch] $new,
    [switch] $priority,
    [switch] $first
  )

  if($tasks -or $projects -or $select -or $new -or $priority -or $first) {
    if($tasks) {
      Get-HighLevelTasks
    }
    if($projects) {
      Write-Projects
    }
    if($select) {
      Select-Project | Invoke-Project
    }
    if($new) {
      New-Project
    }
    if($priority) {
      Read-Priority
    }
    if($first) {
      Get-ProjectsByPriority | select -first 1 | Invoke-Project
    }

    return
  }

  $functions = @(
    "&Tasks",         # 0
    "&List Projects", # 1
    "&Select Project",# 2 
    "&New Project",   # 3
    "Set &Priority",  # 4
    "&Close"          # 5
  ) 

  $continue = $True
  $title = "Projects ---"
  $smess = "What would you like to do?"
  $options = [System.Management.Automation.Host.ChoiceDescription[]]($functions)
  while($continue)
  {
    $choice = $host.ui.PromptForChoice($title, $smess, $options, 0) 

    switch($choice)
    {
      0{
        Get-HighLevelTasks
      }
      1{
        Write-Projects
      }
      2{
        Select-Project | Invoke-Project
      }
      3{ #NEW Project
        New-Project
      }
      4{
        Read-Priority
      }
      5{ #CLOSE PROGRAM / EXIT SCRIPT
        $continue = $False
      }
      #DEFAULT - ask quesiton again
    }

    $choice = $null
  }

  " ________________________________ "
  "(    See you space cowboy...     )"
  " -------------------------------- "
  "        \   ^__^                  "
  "         \  (oo)\_______          "
  "            (__)\       )\/\'     "
  "                ||----w |         "
  "                ||     ||         "
}

Set-Alias projects Invoke-Projects
Set-Alias p Invoke-Projects
