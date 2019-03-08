function Get-Priority
{
  cat (Get-PriorityFile) |? {$_ -Match '^\s*[^#\s]'}
}