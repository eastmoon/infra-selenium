@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    start chrome --incognito "http://localhost:4444"
    start chrome --incognito "http://localhost:7900?autoconnect=1&resize=scale&password=secret"
    goto end

:args
    goto end

:short
    echo Open Chrome browser
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Open Chrome browser with selenium grid and VNC.
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
