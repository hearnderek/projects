function Invoke-Project
{
  Param(
    [Parameter(Mandatory, ValueFromPipeline)]
    [ValidatePattern('^[\w_-]+$')]
    [ValidateScript({Get-Projects -contains $_})]
    [string] $ProjectName
  )

  
  $optionVals = @(
    "&Select Project",
    "View &Notes",
    "View &Tasks",
    "View D&ocs",
    "&Help/Readme",
    "&Rename Project",
    "Delete Project&!",
    "&Close")
  $continue = $True
  $title = ""
  $smess = "What would you like to do?"
  $options = [System.Management.Automation.Host.ChoiceDescription[]]($optionVals)
  while($continue)
  {
    Write-Host "Project: $ProjectName ---" -ForegroundColor Cyan
    $choice = $host.ui.PromptForChoice($title, $smess, $options, 0) 
    
    switch($choice)
    {
      0{ 
        Select-Project | Invoke-Project
        $continue = $False
      }
      1{ #VIEW NOTES
        Edit-ProjectNotes $ProjectName
      }
      2{ #VIEW TASKS
        Edit-ProjectTasks $ProjectName
      }
      3{ #VIEW TASKS
        Enter-ProjectDocs $ProjectName
      }
      4{ #Readme
        Get-ProjectHelp $ProjectName
      }
      5{ #Rename project
        Rename-Project $ProjectName
      }
      6{ #Delete project
        Remove-Project $ProjectName
        $continue = $False
      }
      7{ #CLOSE PROGRAM / EXIT SCRIPT
        $continue = $False
      }
      #DEFAULT - ask quesiton again
    }
  }
}
