# GitHub�ƶ˱�������
# ���д˽ű�ǰ���뽫USERNAME�滻Ϊ����GitHub�û���

$USERNAME = "shen115"  # ���滻Ϊ����GitHub�û���
$REPO = "MigrantWorkerApp-CloudBuild"

Write-Host "?? GitHub�ƶ˱���״̬���" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green
Write-Host ""

# �������URLs
$repoUrl = "https://github.com/$USERNAME/$REPO"
$actionsUrl = "https://github.com/$USERNAME/$REPO/actions"
$releasesUrl = "https://github.com/$USERNAME/$REPO/releases"

Write-Host "?? �����Ϣ:" -ForegroundColor Yellow
Write-Host "�ֿ��ַ: $repoUrl"
Write-Host "����״̬: $actionsUrl"
Write-Host "APK����: $releasesUrl"
Write-Host ""

Write-Host "? �ƶ˱�������:" -ForegroundColor Cyan
Write-Host "1. ������ (30��)"
Write-Host "2. �������� (2����)"
Write-Host "3. ������װ (3����)"
Write-Host "4. APK���� (4����)"
Write-Host "5. �Զ����� (30��)"
Write-Host ""

Write-Host "?? �ɹ�ָ��:" -ForegroundColor Green
Write-Host "? Actionsҳ����ʾ��ɫ����"
Write-Host "? Releasesҳ����APK�ļ�"
Write-Host "? APK�ļ���С: 15-25MB"
Write-Host ""

Write-Host "?? �������:" -ForegroundColor Yellow
Write-Host "# ��������д�״̬ҳ��"
Write-Host "start $actionsUrl"
Write-Host "start $releasesUrl"
Write-Host ""

Write-Host "??  Ԥ�����ʱ��: 10-15����" -ForegroundColor Magenta
Write-Host ""
Write-Host "?? ��ʾ: �ϴ�������ƶ˱��뽫�Զ���ʼ"
Write-Host "?? ÿ5����ˢ��һ��Actionsҳ��鿴����"
Write-Host ""

# �Զ��򿪼��ҳ��
Start-Process $actionsUrl
Start-Sleep 2
Start-Process $releasesUrl

Write-Host "?? ���ҳ���Ѵ򿪣���ȴ��������..." -ForegroundColor Green