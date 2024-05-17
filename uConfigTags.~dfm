object frConfigTags: TfrConfigTags
  Left = 563
  Top = 181
  Width = 615
  Height = 347
  Caption = 'Configura'#231#245'es de TAGS'
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
  object GroupBox2: TGroupBox
    Left = 16
    Top = 8
    Width = 537
    Height = 73
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object edNome: TLabeledEdit
      Left = 40
      Top = 40
      Width = 121
      Height = 24
      EditLabel.Width = 37
      EditLabel.Height = 16
      EditLabel.Caption = 'Nome'
      TabOrder = 0
    end
    object edValor: TLabeledEdit
      Left = 192
      Top = 40
      Width = 121
      Height = 24
      EditLabel.Width = 81
      EditLabel.Height = 16
      EditLabel.Caption = 'Mem'#243'ria CLP'
      TabOrder = 1
    end
    object btCadastrar: TBitBtn
      Left = 320
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Cadastrar'
      TabOrder = 2
      OnClick = btCadastrarClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 16
    Top = 104
    Width = 537
    Height = 185
    TabOrder = 1
    object dbgConfig: TDBGrid
      Left = 8
      Top = 16
      Width = 513
      Height = 153
      DataSource = dsConfig
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = dbgConfigDblClick
    end
  end
  object qConfig: TZQuery
    Connection = dmData.zConnLocal
    Params = <>
    Left = 560
    Top = 88
  end
  object tConfig: TZTable
    Connection = dmData.zConnLocal
    Left = 560
    Top = 120
  end
  object dsConfig: TDataSource
    DataSet = tConfig
    Left = 560
    Top = 56
  end
end
