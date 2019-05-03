object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 145
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Service_Finder'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 89
    Top = 8
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button2: TButton
    Left = 8
    Top = 72
    Width = 75
    Height = 25
    Caption = 'SendMessage'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 96
    Top = 8
  end
end
