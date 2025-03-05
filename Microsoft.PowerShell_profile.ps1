function noetic {
    param (
        [string]$containerName = "noetic-container"
    )

    $status = docker inspect --format '{{.State.Running}}' $containerName 2>$null
    if ($status -eq "true") {
        docker exec -it $containerName bash | Out-Null
    } else {
        docker start $containerName
        docker exec -it $containerName bash | Out-Null
    }
}

function stop-noetic {
    param (
        [string]$containerName = "noetic-container"
    )

    docker stop $containerName | Out-Null
}
