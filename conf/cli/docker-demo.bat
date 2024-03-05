@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    @rem Start docker environment
    call %CLI_SHELL_DIRECTORY%\docker-dev-up.bat action
    TIMEOUT /T 10

    @rem Open browser
    call %CLI_SHELL_DIRECTORY%\docker-dev-open.bat action
    TIMEOUT /T 10

    @rem Execute demo code
    docker exec -ti selemium-sdk_%PROJECT_NAME% python docker-demo.py

    @rem Close down environment
    call %CLI_SHELL_DIRECTORY%\docker-dev-down.bat action

    goto end

:args
    goto end

:short
    echo Run demo code
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Run demo code "src/docker-demo.py"
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
