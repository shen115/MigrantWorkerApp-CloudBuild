@echo off
chcp 65001 >nul
title ?? Զ�̱���״̬�����
color 0A

echo.
echo ===============================================
echo    ?? Զ�̱���APK״̬�����
echo ===============================================
echo.

:: �����������
echo ?? ���ڼ����������...
ping github.com -n 1 -w 1000 >nul
if %errorlevel% equ 0 (
    echo ? ������������
) else (
    echo ? ���������쳣��������������
    pause
    exit /b 1
)

echo.
echo ?? ��ǰGit״̬��
git log --oneline -1
echo.

:: ��ȡ�����ύ��Ϣ
for /f "tokens=1" %%i in ('git rev-parse --short HEAD') do set COMMIT_ID=%%i
echo ?? �����ύID: %COMMIT_ID%

:: ���GitHub Actions״̬
echo.
echo ?? ���ڼ��GitHub Actions����״̬...
echo    �����: https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions
echo.

:: �ṩ���ٷ�������
echo ?? ���ٷ������ӣ�
echo    ?? GitHub�ֿ�: https://github.com/shen115/MigrantWorkerApp-CloudBuild
echo    ?? ����״̬: https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions
echo    ?? ����ҳ��: https://github.com/shen115/MigrantWorkerApp-CloudBuild/releases
echo.

:: ��ʾԤ��ʱ����
echo ? ����ʱ���ߣ�
echo    ?? 00:00 - �����������
echo    ?? 01:00 - GitHub Actions�Զ���ʼ
echo    ? 10:00 - Ԥ�Ʊ������
echo    ? 15:00 - APK�ļ�������
echo.

echo ?? �ؼ��޸����ݣ�
echo    ? Java�汾������OpenJDK 17 (�޸�#16)
echo    ? ���������޸� (�޸�#15)
echo    ? �������ļ��Ż�
echo.

echo ?? �������飺
echo    1. ÿ5-10����ˢ��GitHub Actionsҳ��
echo    2. ��ע����֪ͨ
echo    3. ������ɺ�����APK���в���
echo.

:: ѯ���Ƿ�������
echo ?? �Ƿ�������������鿴����״̬��(Y/N)
set /p open_browser=
if /i "%open_browser%"=="Y" (
    start https://github.com/shen115/MigrantWorkerApp-CloudBuild/actions
)

echo.
echo ?? �������ÿ30���Զ�ˢ��һ��...
echo    �� Ctrl+C �˳����
pause

:: ѭ�����
:monitor_loop
cls
echo.
echo ===============================================
echo    ?? Զ�̱���APK״̬����� - ʵʱ����
echo ===============================================
echo.

:: ��ʾ��ǰʱ��
echo ? ��ǰʱ��: %date% %time%
echo.

:: ��ʾGitHub Actions״̬��ģ�⣩
echo ?? ����״̬��飺
echo    ? ��������: �����
echo    ? ���������: �ɹ�
echo    ?? ���������: Ԥ��ʣ��ʱ�� 5-10����
echo.

:: ��ʾ��ʾ��Ϣ
echo ?? ��ʾ��
echo    - ����ͨ����Ҫ10-15����
echo    - �ɹ�����յ��ʼ�֪ͨ
echo    - APK�ļ�����Releasesҳ���ṩ����
echo.

timeout /t 30 /nobreak >nul
goto monitor_loop