object frmfinalizado: Tfrmfinalizado
  Left = 234
  Top = 550
  BorderStyle = bsSingle
  Caption = 'Finalizado'
  ClientHeight = 91
  ClientWidth = 315
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 297
    Height = 41
    AutoSize = False
    BiDiMode = bdLeftToRight
    Caption = 
      'Aguarde 30 segundos ou Clique em Reiniciar Agora ou Exit para sa' +
      'ir sem Reiniciar '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
    WordWrap = True
  end
  object btnsair: TButton
    Left = 232
    Top = 64
    Width = 75
    Height = 25
    Caption = '&Exit'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnsairClick
  end
  object btnreiniciar: TButton
    Left = 96
    Top = 64
    Width = 123
    Height = 25
    Caption = 'Reiniciar Agora (30)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnreiniciarClick
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 8
    Top = 56
  end
end
