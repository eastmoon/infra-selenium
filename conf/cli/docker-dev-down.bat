@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------
if not defined CONF_FILE_PATH ( set CONF_FILE_PATH=%CLI_DIRECTORY%\conf\docker\.env )

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    @rem execute container
    echo ^> Startup docker container instance
    docker-compose -f %CLI_DIRECTORY%\conf\docker\docker-compose-standalone.yml --env-file %CONF_FILE_PATH% down
    goto end

:args
    goto end

:short
    echo Close down docker-compose
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Close down docker-compose
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    echo      --down, -d        Close down develop container.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
