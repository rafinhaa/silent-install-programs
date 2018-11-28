unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Registry;

type
  TfrmInstalador = class(TForm)
    GroupBox1: TGroupBox;
    btnInstalar: TButton;
    chkavast: TCheckBox;
    chkcodec: TCheckBox;
    chknero: TCheckBox;
    chkoffice2003: TCheckBox;
    chkAdobe: TCheckBox;
    chkmalware: TCheckBox;
    chkwinrar: TCheckBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    btnsair: TButton;
    chkgoogle: TCheckBox;
    Label1: TLabel;
    chkoffice2007: TCheckBox;
    chkoffice2010: TCheckBox;
    chkskype: TCheckBox;
    procedure btnInstalarClick(Sender: TObject);
    procedure btnsairClick(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkoffice2003Click(Sender: TObject);
    procedure chkoffice2007Click(Sender: TObject);
    procedure chkoffice2010Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInstalador: TfrmInstalador;
  startinstall:boolean;
  caminho:string;

implementation

uses Unit2;

{$R *.dfm}
procedure click0ff(vAval1, vAval2 : TCheckBox);
begin
if vAval1.Checked then
begin
vAval2.Checked := false;
end;
end;

procedure click0ff3(vAval1, vAval2,vAval3 : TCheckBox);
begin
if vAval1.Checked then
begin
vAval2.Checked := false;
vAval3.Checked := false;
end;
end;


procedure TfrmInstalador.btnInstalarClick(Sender: TObject);
var
i: Integer;
pronto:boolean;
begin
pronto:= false;
for i := 0 to ComponentCount - 1 do
  begin
      if Components[i].ClassType = TCheckBox then
        begin
          if (TCheckBox(Components[i]).Checked = True) then
            begin
              pronto:= true;
            end
        end;
  end;
  inherited;

if pronto = true then
  begin
    startinstall:= true;
    If (Frminstalando = Nil) Then // Verifica se o formulário está vazio (Nil).
      begin
        Frminstalador.Visible:= false;
        Frminstalando := TFrminstalando.Create(Application); // Cria o formulário.
        Frminstalando.WindowState := wsNormal; // Se o usuario maximizou ou minizou o formulário, ele volta para o tamanho nornal.
        Frminstalando.Showmodal; //ou Form1.ShowModal - Mostra o formulário na tela.
       End;
  end
else
  //Showmessage('Selecione pelo menos um Programa');
  messagedlg('Selecione um programa para Iniciar a Instalação!',mtwarning,[mbyes],0);




end;

procedure TfrmInstalador.btnsairClick(Sender: TObject);
begin
frmInstalador.Close;
end;






procedure TfrmInstalador.RadioButton1Click(Sender: TObject);
var
a: Integer;

begin

for a := 0 to ComponentCount - 1 do
  begin
      if Components[a].ClassType = TCheckBox then
        begin
          if (TCheckBox(Components[a]).Checked = false) then
            begin
              TCheckBox(Components[a]).Checked := true;
            end
          end;
   chkskype.Checked := true;
   chkoffice2007.Checked := true;
   chknero.Checked := false;   
  end;
  inherited;

end;

procedure TfrmInstalador.RadioButton2Click(Sender: TObject);
var
a: Integer;

begin

for a := 0 to ComponentCount - 1 do
  begin
      if Components[a].ClassType = TCheckBox then
        begin
          if (TCheckBox(Components[a]).Checked = true) then
            begin
              TCheckBox(Components[a]).Checked := false;
            end
        end;
  end;
  inherited;

end;

procedure TfrmInstalador.FormCreate(Sender: TObject);
begin
caminho:=ExtractFilePath(Application.ExeName);
end;

procedure TfrmInstalador.chkoffice2003Click(Sender: TObject);
begin
click0ff3(chkoffice2003, chkoffice2007,chkoffice2010);
end;

procedure TfrmInstalador.chkoffice2007Click(Sender: TObject);
begin
click0ff3(chkoffice2007, chkoffice2003,chkoffice2010);
end;

procedure TfrmInstalador.chkoffice2010Click(Sender: TObject);
begin
click0ff3(chkoffice2010, chkoffice2003,chkoffice2007);
end;

end.
