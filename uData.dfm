object dmData: TdmData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 362
  Top = 188
  Height = 423
  Width = 872
  object zConnLocal: TZConnection
    ControlsCodePage = cGET_ACP
    AutoCommit = False
    OnLost = zConnLocalLost
    DisableSavepoints = False
    Port = 0
    Left = 24
    Top = 16
  end
  object qParceiro: TZQuery
    Connection = zConnLocal
    Params = <>
    Left = 24
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
    AutoCommit = False
    OnLost = zConnRemoteLost
    DisableSavepoints = False
    Port = 0
    Left = 568
    Top = 8
  end
  object tProducao: TZTable
    Connection = zConnLocal
    Left = 216
    Top = 72
  end
  object DataSource1: TDataSource
    DataSet = tProducao
    Left = 216
    Top = 128
  end
  object qProducao: TZQuery
    Connection = zConnLocal
    Params = <>
    Left = 288
    Top = 72
  end
  object qCadProdRemote: TZQuery
    Connection = zConnRemote
    Params = <>
    Left = 568
    Top = 64
  end
  object qCadProdLocal: TZQuery
    Connection = zConnLocal
    Params = <>
    Left = 24
    Top = 200
  end
end
