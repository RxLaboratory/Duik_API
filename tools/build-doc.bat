@echo off

cd ..
cd src-docs
echo Building docs
REM build doc
mkdocs build
echo Docs built
cd ..
REM build reference
cd tools
echo Building reference
cmd /c jsdoc -c jsdoc_conf.json
xcopy /Y ..\docs\reference\Duik.html ..\docs\reference\index.html
echo Reference built
REM add CSS
xcopy /Y jsdoc.css ..\docs\reference
cd ..
cd docs
REM add 404
echo Adding 404 page
echo " " > 404.md
xcopy /Y ..\src-docs\assets\404.md 404.md
REM add CNAME
echo Creating CNAME
echo duik.rxlab.io > "CNAME"
echo Finished!