object Form1: TForm1
  Left = 230
  Top = 149
  Width = 258
  Height = 302
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 47
    Height = 13
    Caption = 'Number A'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 47
    Height = 13
    Caption = 'Number B'
  end
  object Button1: TButton
    Left = 56
    Top = 72
    Width = 121
    Height = 25
    Caption = 'Exit'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 56
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '100'
  end
  object Edit2: TEdit
    Left = 56
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '10'
  end
  object MainMenu1: TMainMenu
    Left = 200
    Top = 16
    object N1: TMenuItem
      Caption = 'Operation'
      object Sum1: TMenuItem
        Caption = 'Sum'
        OnClick = Sum1Click
      end
      object Sub1: TMenuItem
        Caption = 'Sub'
        OnClick = Sub1Click
      end
      object Multiplication1: TMenuItem
        Caption = 'Multiplication'
        OnClick = Multiplication1Click
      end
      object DivisionDiv1: TMenuItem
        Caption = 'DivisionDiv'
        OnClick = DivisionDiv1Click
      end
      object DivisionMod1: TMenuItem
        Caption = 'DivisionMod'
        OnClick = DivisionMod1Click
      end
    end
    object Exit1: TMenuItem
      Caption = 'Exit'
      OnClick = Exit1Click
    end
  end
end
