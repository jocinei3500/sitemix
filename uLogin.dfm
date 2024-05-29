object frLogin: TfrLogin
  Left = 615
  Top = 300
  Width = 451
  Height = 225
  Caption = 'Autentica'#231#227'o de Configura'#231#245'es'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 5
    Top = 16
    Width = 409
    Height = 121
    Caption = 'Conectar-se ao sistema SGU'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 88
      Top = 56
      Width = 59
      Height = 20
      Caption = 'Usu'#225'rio:'
    end
    object Label2: TLabel
      Left = 96
      Top = 80
      Width = 51
      Height = 20
      Caption = 'Senha:'
    end
    object edUser: TEdit
      Left = 152
      Top = 48
      Width = 121
      Height = 28
      TabOrder = 0
      Text = 'jocinei'
    end
    object edPassword: TEdit
      Left = 152
      Top = 80
      Width = 121
      Height = 25
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Wingdings'
      Font.Style = []
      ParentFont = False
      PasswordChar = 'l'
      TabOrder = 1
      Text = '123'
    end
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 144
    Width = 89
    Height = 25
    Caption = '<<Detalhes'
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 104
    Top = 144
    Width = 81
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = BitBtn2Click
  end
  object BitBtn3: TBitBtn
    Left = 189
    Top = 144
    Width = 81
    Height = 25
    Caption = 'Limpar'
    TabOrder = 3
  end
  object BitBtn4: TBitBtn
    Left = 277
    Top = 144
    Width = 81
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 4
  end
end
