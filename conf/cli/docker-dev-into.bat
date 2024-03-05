@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    if defined INTO_CONTAINER (
        docker exec -ti %INTO_CONTAINER%_%PROJECT_NAME% bash
    ) else (
        echo choose target container with options.
    )
    goto end

:args
    set COMMON_ARGS_KEY=%1
    set COMMON_ARGS_VALUE=%2
    if "%COMMON_ARGS_KEY%"=="--target" (set INTO_CONTAINER=%COMMON_ARGS_VALUE%)
    if "%COMMON_ARGS_KEY%"=="-t" (set INTO_CONTAINER=%COMMON_ARGS_VALUE%)
    goto end

:short
    echo Into container
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Into container with target name.
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    echo      --target, -t      Target container name.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
