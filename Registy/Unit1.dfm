object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 226
  ClientWidth = 625
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 89
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Read&Save'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 89
    Top = 27
    Width = 520
    Height = 167
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object Button2: TButton
    Left = 8
    Top = 71
    Width = 75
    Height = 25
    Caption = 'LoadSave'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 169
    Width = 75
    Height = 25
    Caption = 'saveTest'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 39
    Width = 75
    Height = 25
    Caption = 'KeyDelete'
    TabOrder = 4
    OnClick = Button4Click
  end
end
