%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoExit -Command "& {
    $containerName = 'noetic-container'
    $status = docker inspect --format '{{.State.Running}}' $containerName 2>$null

    $bashProcesses = docker top $containerName 2>$null | Select-String 'bash'

    if ($bashProcesses.Count -gt 0) {
        docker exec -it $containerName bash
    } else {
        if ($status -eq 'true') {
            docker exec -it $containerName bash
        } elseif ($status -eq 'false') {
            docker start $containerName | Out-Null
            docker exec -it $containerName bash
        }
    }
}"
