object dm: Tdm
  Height = 480
  Width = 640
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 64
    Top = 16
  end
  object FDPhysMSAccessDriverLink1: TFDPhysMSAccessDriverLink
    Left = 232
    Top = 16
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=MSAcc')
    Left = 64
    Top = 96
  end
  object TbUsers: TFDQuery
    Connection = FDConnection1
    Left = 224
    Top = 96
  end
end
