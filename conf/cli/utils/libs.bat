@rem ------------------- batch setting -------------------
@echo off

@rem ------------------- execute script -------------------
call :%*
goto end

@rem ------------------- declare function -------------------

:common-up-docker-prepare
    echo ^> Build docker compose environment file
    @rem Create .env for compose
    echo Current Environment %PROJECT_ENV%
    echo PROJECT_NAME=%PROJECT_NAME% > %CONF_FILE_PATH%
    echo SORUCE_PATH=%CLI_DIRECTORY%src >> %CONF_FILE_PATH%

    @rem Setting cache directory
    set TARGET_DIR=%CLI_DIRECTORY%cache\video
    IF NOT EXIST %TARGET_DIR% (
        mkdir %TARGET_DIR%
    )
    echo VIDEO_CACHE_PATH=%TARGET_DIR% >> %CONF_FILE_PATH%

    goto end


:common-docker-build
    set DOCKER_CONF_NAME=%1
    set DOCKER_IMAGE_NAME=%2
    @rem Create docker commit lock cache directory
    set TARGET_DIR=%CLI_DIRECTORY%\cache\docker
    IF NOT EXIST %TARGET_DIR% ( mkdir %TARGET_DIR% )

    @rem Setting git information
    set CONF_DOCKER_ROOT_DIR=%CLI_DIRECTORY%conf\docker
    set CONF_DOCKER_DIR=%CONF_DOCKER_ROOT_DIR%
    set CONF_DOCKER_FILENAME=Dockerfile
    if EXIST %CONF_DOCKER_ROOT_DIR%\%DOCKER_CONF_NAME% (
        set CONF_DOCKER_DIR=%CONF_DOCKER_ROOT_DIR%\%DOCKER_CONF_NAME%
    )
    if EXIST %CONF_DOCKER_ROOT_DIR%\%CONF_DOCKER_FILENAME%.%DOCKER_CONF_NAME% (
        set CONF_DOCKER_FILENAME=%CONF_DOCKER_FILENAME%.%DOCKER_CONF_NAME%
    )
    set GIT_COMMIT_LOCK_FILE=%TARGET_DIR%\%DOCKER_CONF_NAME%
    set GIT_COMMIT_CODE=git rev-list --max-count=1 HEAD -- %CONF_DOCKER_DIR%\%CONF_DOCKER_FILENAME%

    @rem Retrieve current commit code
    for /f %%i in ('%GIT_COMMIT_CODE%') do set CUR_CODE=%%i

    @rem Retrieve lock commit code in cache
    if EXIST %GIT_COMMIT_LOCK_FILE% ( set /p LOCK_CODE=<%GIT_COMMIT_LOCK_FILE% ) else ( set LOCK_CODE=0 )

    @rem Build image
    if NOT %CUR_CODE% == %LOCK_CODE% (
        cd %CONF_DOCKER_DIR%
        docker build --rm ^
            -t %DOCKER_IMAGE_NAME% ^
            -f %CONF_DOCKER_FILENAME% ^
            .
        cd %CLI_DIRECTORY%
        %GIT_COMMIT_CODE% > %GIT_COMMIT_LOCK_FILE%

    )

    goto end


@rem ------------------- End method-------------------

:end
