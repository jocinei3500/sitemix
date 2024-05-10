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
    Left = 72
    Top = 72
  end
  object dsParceiro: TDataSource
    DataSet = tParceiro
    Left = 72
    Top = 120
  end
  object zQueryX: TZQuery
    Connection = zConnLocal
    Params = <>
    Left = 72
    Top = 16
  end
  object dsX: TDataSource
    DataSet = zQueryX
    Left = 120
    Top = 16
  end
  object qBUsca: TZQuery
    Connection = zConnLocal
    Params = <>
    Left = 168
    Top = 16
  end
end
