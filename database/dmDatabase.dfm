object Dm: TDm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 367
  Width = 564
  object FDC_MySQL: TFDConnection
    LoginPrompt = False
    Left = 16
    Top = 8
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 528
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 528
    Top = 48
  end
  object FDT_MySQL: TFDTransaction
    Connection = FDC_MySQL
    Left = 16
    Top = 56
  end
  object FDQ_Cliente: TFDQuery
    Connection = FDC_MySQL
    SQL.Strings = (
      'select * from tbClientes'
      'where nome LIKE :nome')
    Left = 520
    Top = 104
    ParamData = <
      item
        Name = 'NOME'
        ParamType = ptInput
      end>
  end
  object DS_Cliente: TDataSource
    DataSet = FDQ_Cliente
    Left = 520
    Top = 152
  end
end
