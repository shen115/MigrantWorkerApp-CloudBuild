@echo off
echo ============================================
echo   MigrantWorkerApp Github ���ù���
echo ============================================
echo.

setlocal enabledelayedexpansion

:: ����Ƿ�����ȷ��Ŀ¼
echo �����Ŀ�ṹ...
if not exist "config.xml" (
    echo ����: δ�ҵ�config.xml�ļ�����ȷ����MigrantWorkerAppĿ¼�����д˽ű�
    pause
    exit /b 1
)

if not exist ".github\workflows\build-apk.yml" (
    echo ����: δ�ҵ�Github Actions�������ļ�
    pause
    exit /b 1
)

echo ? ��Ŀ�ṹ��֤ͨ��

:: ��ȡ�û�����
set /p REPO_URL="����������Github�ֿ�URL (����: https://github.com/username/MigrantWorkerApp.git): "

:: ��֤URL��ʽ
echo %REPO_URL% | findstr /i "github.com.*\.git" >nul
if errorlevel 1 (
    echo ����: URL��ʽ���ܲ���ȷ�������ʽ: https://github.com/username/repository.git
    set /p CONFIRM="�Ƿ����? (Y/N): "
    if /i not "!CONFIRM!"=="Y" (
        echo ������ȡ��
        pause
        exit /b 1
    )
)

echo.
echo ��ʼ����Github�ֿ�...
echo.

:: ��ʼ��Git�ֿ�
echo [1/8] ��ʼ��Git�ֿ�...
if exist ".git" (
    echo Git�ֿ��Ѵ��ڣ�������ʼ��
) else (
    git init
    if errorlevel 1 (
        echo ����: Git��ʼ��ʧ��
        pause
        exit /b 1
    )
)

:: ���Git����
echo [2/8] ���Git����...
git config user.name >nul 2>&1
if errorlevel 1 (
    echo ��⵽Git�û�����ȱʧ
    set /p GIT_NAME="����������Git�û���: "
    git config user.name "!GIT_NAME!"
)

git config user.email >nul 2>&1
if errorlevel 1 (
    echo ��⵽Git��������ȱʧ
    set /p GIT_EMAIL="����������Git����: "
    git config user.email "!GIT_EMAIL!"
)

:: ����ļ�
echo [3/8] ����ļ���Git...
git add .
if errorlevel 1 (
    echo ����: ����ļ�ʧ��
    pause
    exit /b 1
)

:: ����Ƿ����ļ���Ҫ�ύ
git status --porcelain | findstr /r /c:"." >nul
if errorlevel 1 (
    echo û���ļ���Ҫ�ύ�������ύ����
) else (
    :: �ύ�ļ�
    echo [4/8] �ύ�ļ�...
    git commit -m "Initial commit: MigrantWorkerApp with Github Actions"
    if errorlevel 1 (
        echo ����: �ύʧ��
        pause
        exit /b 1
    )
)

:: ���Զ�ֿ̲�
echo [5/8] ���Զ�ֿ̲�...
git remote remove origin 2>nul
git remote add origin %REPO_URL%
if errorlevel 1 (
    echo ����: ���Զ�ֿ̲�ʧ��
    pause
    exit /b 1
)

:: ����֧
echo [6/8] ����֧...
git branch -M main
if errorlevel 1 (
    echo ����: ��������֧ʧ�ܣ�������������
)

:: ���ʹ���
echo [7/8] ���ʹ��뵽Github...
echo �������Ҫ������ʱ�䣬�����ĵȴ�...
git push -u origin main
if errorlevel 1 (
    echo.
    echo ����ʧ�ܣ����ܵ�ԭ��
    echo 1. �ֿ�URL����ȷ
    echo 2. ������������
    echo 3. ��Ҫ�����֤
    echo.
    echo ���ֶ�ִ��: git push -u origin main
    pause
    exit /b 1
)

:: ��֤����
echo [8/8] ��֤����...
git ls-remote origin >nul 2>&1
if errorlevel 1 (
    echo ����: �޷���֤Զ�ֿ̲�����
) else (
    echo ? Զ�ֿ̲���������
)

echo.
echo ============================================
echo   ?? Github�ֿ�������ɣ�
echo ============================================
echo.
echo ��һ��������
echo 1. �������Ĳֿ�ҳ��: %REPO_URL%
echo 2. ��� "Actions" ��ǩҳ�鿴��������
echo 3. �ȴ�������ɣ�Լ5-10���ӣ�
echo 4. �������ɵ�APK�ļ�
echo.
echo ?? ��ϸָ��: �鿴 GITHUB_ACTIONS_GUIDE.md
echo ?? ����ǩ��: �鿴 APK_SIGNING_GUIDE.md
echo.
pause