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
end
