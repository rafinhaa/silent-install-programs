program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {frmInstalador},
  Unit2 in 'Unit2.pas' {frmInstalando},
  Unit3 in 'Unit3.pas' {frmfinalizado};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmInstalador, frmInstalador);
  Application.Run;
end.
