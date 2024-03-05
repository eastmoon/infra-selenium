@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------
if not defined CONF_FILE_PATH ( set CONF_FILE_PATH=%CLI_DIRECTORY%\conf\docker\.env )

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    goto help

:args
    goto end

:short
    echo Use docker environment
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Use docker environment with selenium grid
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
