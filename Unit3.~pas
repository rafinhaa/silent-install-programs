unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  Tfrmfinalizado = class(TForm)
    btnsair: TButton;
    btnreiniciar: TButton;
    Label1: TLabel;
    Timer1: TTimer;
    procedure btnsairClick(Sender: TObject);
    procedure btnreiniciarClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmfinalizado: Tfrmfinalizado;
  i:integer;


implementation

uses Unit2, Unit1;

{$R *.dfm}

procedure Tfrmfinalizado.btnsairClick(Sender: TObject);
var
x:integer;
begin
for x:= 1 to screen.formcount -1 do
  begin
    if screen.Forms[x] <> self then
      screen.Forms[x].Close;
  end;


end;

procedure Tfrmfinalizado.btnreiniciarClick(Sender: TObject);
function DesligarMeuWindows(RebootParam: Longword): Boolean;
var
TTokenHd: THandle;
TTokenPvg: TTokenPrivileges;
cbtpPrevious: DWORD;
rTTokenPvg: TTokenPrivileges;
pcbtpPreviousRequired: DWORD;
tpResult: Boolean;
const
SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
begin
if Win32Platform = VER_PLATFORM_WIN32_NT then
begin
tpResult := OpenProcessToken(GetCurrentProcess(),
TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
TTokenHd);
if tpResult then
begin
tpResult := LookupPrivilegeValue(nil, SE_SHUTDOWN_NAME,
TTokenPvg.Privileges[0].Luid);
TTokenPvg.PrivilegeCount := 1;
TTokenPvg.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
cbtpPrevious := SizeOf(rTTokenPvg);
pcbtpPreviousRequired := 0;
if tpResult then
Windows.AdjustTokenPrivileges(TTokenHd, False, TTokenPvg, cbtpPrevious,
rTTokenPvg, pcbtpPreviousRequired);
end;
end;
Result := ExitWindowsEx(RebootParam, 0);
end;

begin
DesligarMeuWindows(EWX_REBOOT);
end;


procedure Tfrmfinalizado.Timer1Timer(Sender: TObject);
begin
btnreiniciar.Caption:='Reiniciar Agora (' + inttostr(i) + ')';
label1.caption:=  'Aguarde ' + inttostr(i) + ' segundos ou Clique em Reiniciar Agora ou Exit para sair sem Reiniciar ';
dec(i);
if i = 0 then
  begin
    Timer1.Enabled:=False;
    btnreiniciar.Click;
  end;
end;

procedure Tfrmfinalizado.FormCreate(Sender: TObject);
begin
i:= 30;
timer1.enabled:= true;
end;

end.
