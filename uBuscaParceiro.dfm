object frBuscaParceiro: TfrBuscaParceiro
  Left = 343
  Top = 202
  Width = 422
  Height = 261
  Caption = 'Parceiros'
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
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 86
    Height = 16
    Caption = 'Digite o Nome'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object edBuscaParceiro: TEdit
    Left = 16
    Top = 40
    Width = 377
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = edBuscaParceiroChange
    OnKeyDown = edBuscaParceiroKeyDown
  end
  object dbgParceiros: TDBGrid
    Left = 16
    Top = 64
    Width = 377
    Height = 145
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dbgParceirosDblClick
    OnKeyDown = dbgParceirosKeyDown
    Columns = <
      item
        Expanded = False
        Title.Caption = 'ID'
        Width = 49
        Visible = True
      end
      item
        Expanded = False
        Title.Caption = 'NOME DO PARCEIRO'
        Width = 309
        Visible = True
      end>
  end
end
