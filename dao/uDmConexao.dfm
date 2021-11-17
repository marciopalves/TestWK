object DMConexao: TDMConexao
  OldCreateOrder = False
  Height = 305
  Width = 527
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    Left = 56
    Top = 104
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 56
    Top = 176
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=wktech'
      'User_Name=root'
      'Password=123456'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 64
    Top = 40
  end
end
