object dmData: TdmData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 348
  Top = 179
  Height = 423
  Width = 582
  object zConnLocal: TZConnection
    ControlsCodePage = cGET_ACP
    DisableSavepoints = False
    Port = 0
    Left = 16
    Top = 16
  end
  object qParceiro: TZQuery
    Connection = zConnLocal
    Params = <>
    Left = 16
    Top = 72
  end
  object tParceiro: TZTable
    Connection = zConnLocal
    Left = 128
    Top = 72
  end
  object dsParceiro: TDataSource
    DataSet = tParceiro
    Left = 128
    Top = 128
  end
  object zQueryX: TZQuery
    Connection = zConnLocal
    Params = <>
    Left = 72
    Top = 72
  end
  object dsX: TDataSource
    DataSet = zQueryX
    Left = 72
    Top = 128
  end
  object qBUsca: TZQuery
    Connection = zConnLocal
    Params = <>
    Left = 80
    Top = 16
  end
  object dsProdutro: TDataSource
    DataSet = qProduto
    Left = 176
    Top = 128
  end
  object qProduto: TZQuery
    Connection = zConnLocal
    Params = <>
    Left = 176
    Top = 72
  end
  object zConnRemote: TZConnection
    ControlsCodePage = cGET_ACP
    DisableSavepoints = False
    Port = 0
    Left = 328
    Top = 16
  end
end
