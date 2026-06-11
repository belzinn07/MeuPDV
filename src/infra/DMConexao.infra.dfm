object dm: Tdm
  OnCreate = DataModuleCreate
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object FDConexao: TFDConnection
    Params.Strings = (
      'User_Name=SYSDBA'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=FB')
    Transaction = FDTransacao
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
    SQL.Strings = (
      'SELECT * FROM CLIENTES')
    Left = 456
    Top = 176
  end
  object qryProdutos: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'SELECT ID, DESCRICAO, PRECO FROM PRODUTOS;')
    Left = 584
    Top = 176
  end
  object qryVendas: TFDQuery
    Connection = FDConexao
    Left = 313
    Top = 176
  end
  object FDTransacao: TFDTransaction
    Connection = FDConexao
    Left = 408
    Top = 384
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
