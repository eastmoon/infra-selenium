@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- declare variable -------------------

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:action
    @rem Declare variable
    set VENV=%cd%\cache\venv

    @rem Create python virtual environment
    python -m venv %VENV%

    @rem Install packaga
    %VENV%\Scripts\pip install -r requirements.txt
    %VENV%\Scripts\pip list

    @rem Execute demo script with python virtual environment
    %VENV%\Scripts\python %cd%\src\local-demo.py

    goto end


:args
    goto end

:short
    echo Run demo code
    goto end

:help
    echo This is a Command Line Interface with project %PROJECT_NAME%
    echo Run demo code "src/local-demo.py"
    echo.
    echo Options:
    echo      --help, -h        Show more information with command.
    call %CLI_SHELL_DIRECTORY%\utils\tools.bat command-description %~n0
    goto end

:end
