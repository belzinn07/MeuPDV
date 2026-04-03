object dmConexao: TdmConexao
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object FDConexao: TFDConnection
    Params.Strings = (
      'Database=C:\DEV\Delphi\MeuPDV\database\DADOS.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=FB')
    Connected = True
    Left = 464
    Top = 376
  end
  object qryCRUD: TFDQuery
    Connection = FDConexao
    Left = 464
    Top = 480
  end
  object qryClientes: TFDQuery
    Connection = FDConexao
    Left = 464
    Top = 272
  end
  object qryProdutos: TFDQuery
    Connection = FDConexao
    Left = 592
    Top = 280
  end
  object qryVendas: TFDQuery
    Connection = FDConexao
    Left = 312
    Top = 280
  end
  object FDTransacao: TFDTransaction
    Connection = FDConexao
    Left = 568
    Top = 424
  end
end
