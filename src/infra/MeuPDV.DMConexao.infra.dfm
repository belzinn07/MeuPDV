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
    Left = 520
    Top = 384
  end
  object qryCRUD: TFDQuery
    Connection = FDConexao
    Left = 464
    Top = 264
  end
  object qryClientes: TFDQuery
    Connection = FDConexao
    Left = 456
    Top = 176
  end
  object qryProdutos: TFDQuery
    Active = True
    Connection = FDConexao
    SQL.Strings = (
      'SELECT * FROM PRODUTOS;')
    Left = 584
    Top = 176
  end
  object qryVendas: TFDQuery
    Connection = FDConexao
    Left = 312
    Top = 176
  end
  object FDTransacao: TFDTransaction
    Connection = FDConexao
    Left = 408
    Top = 384
  end
  object dsProdutos: TDataSource
    DataSet = qryProdutos
    Left = 351
    Top = 528
  end
  object dsClientes: TDataSource
    DataSet = qryClientes
    Left = 471
    Top = 528
  end
  object dsVendas: TDataSource
    DataSet = qryVendas
    Left = 591
    Top = 528
  end
end
