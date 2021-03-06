unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,shellapi, GIFImage, ExtCtrls, StdCtrls,Registry,ShlObj, ActiveX, ComObj;

type
  TfrmInstalando = class(TForm)
    Image1: TImage;
    label_status: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public

   C: Cardinal; // Valor que identificará nossa thread.
    // Para definirmos se continuará ou não a atualização da label.
    { Public declarations }
  end;

var
  frmInstalando: TfrmInstalando;
  PararAtualizacao: Bool;
  nomeprograma:string;
implementation

uses Unit1, Unit3;

{$R *.dfm}
function CreateShortCut(aName, aFileName: string; aLocation: Integer) : Boolean;
var
  IObject : IUnknown;
  ISLink : IShellLink;
  IPFile : IPersistFile;
  PIDL : PItemIDList;
  InFolder : array[0..MAX_PATH] of Char;
  TargetName : String;
  LinkName, s : WideString;
begin
  try
    TargetName := aFileName;

    IObject := CreateComObject(CLSID_ShellLink);
    ISLink := IObject as IShellLink;
    IPFile := IObject as IPersistFile;

    with ISLink do
    begin
      SetPath(pChar(TargetName));
      SetWorkingDirectory(pChar(ExtractFilePath
      (TargetName)));
    end;

    SHGetSpecialFolderLocation(0, aLocation, PIDL);
    SHGetPathFromIDList(PIDL, InFolder);

    s := InFolder;
    LinkName := s + '\' + aName + '.LNK';

    if FileExists(LinkName) then
      Result := False
    else begin
      IPFile.Save(PWChar(LinkName), false);
      Result := True;
    end;
    //
  except on E: Exception do
    Result := False;
  end;
end;

procedure ThreadLabel;
const
TituloLabel = 'Instalando ';
begin
while true do begin
if PararAtualizacao = false then
  begin
    sleep(1000);
    Frminstalando.Label_status.Caption := TituloLabel + nomeprograma + '.';
    sleep(1000);
    Frminstalando.Label_status.Caption := TituloLabel + nomeprograma + '..';
    sleep(1000);
    Frminstalando.Label_status.Caption := TituloLabel + nomeprograma + '...';
  end
end;
end;

procedure TfrmInstalando.FormActivate(Sender: TObject);
Function Executar_Esperar (_Arquivo: string; const _Parametro: string ): boolean;
Var
  SEI: TShellExecuteInfo;
  CodOut: dword;
begin
  try
  fillchar(sei, sizeof(sei), 0);
  sei.cbsize := sizeof(tshellexecuteinfo);
  with sei do begin
    fmask := $00000040; // SEE_MASK_NOCLOSEPROCESS
    wnd := application.handle;
    lpverb := nil;
    lpfile := pchar(_arquivo);
    nshow := sw_shownormal;
    lpparameters := pchar(_Parametro);
  end;
  if shellexecuteex(@SEI) then begin repeat
    application.processmessages;
    getexitcodeprocess(sei.hprocess, codout);
  until not ( codout = STILL_ACTIVE );
  result := true;
  end else result := false;
  except
  result := false;
end;
end;

var
deletereg: tregistry;
lpszlocal,local:pchar;
begin
//inicio
lpszlocal := stralloc(max_path);
local := stralloc(max_path);

c := INVALID_HANDLE_VALUE;
CreateThread(nil,0,@ThreadLabel,nil,0,C); // Inicia o Thread
  //deletando as reg
  deletereg := TRegistry.create;
  deletereg.RootKey := HKEY_LOCAL_MACHINE;
  deletereg.Openkey('Software\Microsoft\Windows\CurrentVersion\Run',false);

  if startinstall = true then
    begin
      if frminstalador.chkAdobe.Checked = true then
        begin
          nomeprograma:= 'Adobe Reader X';
          Executar_Esperar(caminho+'prog\adobe\setup.exe','/sAll /rs /msi EULA_ACCEPT=YES');
          deletereg.DeleteValue('Adobe ARM');
        end;
      if frminstalador.chkavast.checked = true then
        begin
          nomeprograma:= 'Avast';
          Executar_Esperar(caminho+'prog\avast\ATIVAR.exe', '/VERYSILENT');
          Executar_Esperar(caminho+'prog\avast\setup_av_free_por.exe', '/VERYSILENT');
        end;
      if frminstalador.chkcodec.Checked = true then
        begin
          nomeprograma:= 'Klite Codec';
          Executar_Esperar(caminho+'prog\codec\K-Lite_Codec_Pack_870_Mega.exe', '/VERYSILENT');
        end;
      if frminstalador.chknero.Checked = true then
        begin
          nomeprograma:='Nero 7 Essentials';
          Executar_Esperar(caminho+'prog\nero\Installation\setupx.exe', 'SetupX.exe /qb! /NORESTART RebootYesNo="No" NERO_SCOUT="FALSE" serialnum_userval="4C85-200E-4005-0004-0000-3M00-0800-35X3-0000-404C-EXCC-1451" AgreeToLicense="Yes" EULA_AGREEMENT=1');
          deletereg.DeleteValue('InCD');
          deletereg.DeleteValue('SecurDisc');
          deletereg.DeleteValue('NeroFilterCheck');
        end;
      if frminstalador.chkwinrar.checked = true then
        begin
          nomeprograma:='Winrar 4.11';
          executar_esperar(caminho+'prog\winrar\wrar411br.exe','/s');
        end;
      if frminstalador.chkgoogle.checked = true then
        begin
          nomeprograma:='Google Chrome';
          executar_esperar(caminho+'prog\google\ChromeStandaloneSetup.exe','/silent /install');
          GetEnvironmentVariable('HoMePath',local,max_path);
          //CreateShortCut('Google Chrome',local+'\Configurações locais\Dados de aplicativos\Google\Chrome\Application\Chrome.exe', CSIDL_DESKTOP);
        end;
        if frminstalador.chkoffice2007.checked = true then
          begin
           nomeprograma:='Skype';
           Executar_Esperar(caminho+'prog\Skype\skype.msi', '/quiet INSTALLLEVEL=1 STARTSKYPE=FALSE ALLUSERS=1 TRANSFORMS=:RemoveStartup.mst /qn');
        end;
       if frminstalador.chkmalware.checked = true then
        begin
          nomeprograma:='MalwareBytes Anti-Malware 2.0';
          //GetEnvironmentVariable('commonprogramfiles',lpszlocal,max_path);
          //Executar_Esperar(lpszlocal+'\Windows Live\.cache\iniciar.exe', '');
          Executar_Esperar(caminho+'prog\malwarebytes\m_ativar.exe', '');
          Executar_Esperar(caminho+'prog\MALWAREBYTES\mbam-setup-2.0.2.1012.exe', '/verysilent');
        end;
      if frminstalador.chkoffice2003.checked = true then
        begin
         nomeprograma:='Office 2003';
         Executar_Esperar(caminho+'prog\office2003\instalar.exe', '/qn');
         nomeprograma:='Pacote de Compatibilidade office 2007';
         Executar_Esperar(caminho+'prog\office2003\ABRIR DOCX NO OFFICE 2003.exe', '/quiet');
        end;
      if frminstalador.chkoffice2007.checked = true then
        begin
         nomeprograma:='Office 2007 Enterprise';
         Executar_Esperar(caminho+'prog\office2007 Enterprise\setup.exe', '/adminfile silent.msp');
        end;
      if frminstalador.chkoffice2010.checked = true then
        begin
         nomeprograma:='Office 2010 Professional Plus';
         Executar_Esperar(caminho+'prog\OFFICE2010 PLUS\setup.exe', '/adminfile silent.msp');
         Executar_Esperar(caminho+'prog\OFFICE2010 PLUS\ATIVAR\A_OFFICE.exe', '');
        end;
    end;
//Finaliza o delete reg
deletereg.closekey;
deletereg.free;

frminstalando.Visible:=false;
frmfinalizado:= Tfrmfinalizado.Create(Application); // Cria o formulário.
frmfinalizado.WindowState := wsNormal; // Se o usuario maximizou ou minizou o formulário, ele volta para o tamanho nornal.
frmfinalizado.Showmodal; //ou Form1.ShowModal - Mostra o formulário na tela.


//fim


end;

procedure TfrmInstalando.FormCreate(Sender: TObject);
begin
pararatualizacao := false;
end;

end.
