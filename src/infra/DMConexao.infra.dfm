object dmConexao: TdmConexao
  Height = 600
  Width = 800
  object FDConexao: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Sup-09\Documents\Belmiro\DELPHI\MeuPDV\databas' +
        'e\DADOS.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'DriverID=FB')
    Transaction = FDTransacao
    Left = 416
    Top = 307
  end
  object qryCRUD: TFDQuery
    Connection = FDConexao
    Left = 371
    Top = 211
  end
  object qryClientes: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'SELECT * FROM CLIENTES')
    Left = 365
    Top = 141
  end
  object qryProdutos: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'SELECT ID, DESCRICAO, PRECO FROM PRODUTOS;')
    Left = 467
    Top = 141
  end
  object qryVendas: TFDQuery
    Connection = FDConexao
    Left = 250
    Top = 141
  end
  object FDTransacao: TFDTransaction
    Connection = FDConexao
    Left = 326
    Top = 307
  end
  object dsClientes: TDataSource
    DataSet = qryClientes
    Left = 377
    Top = 422
  end
  object dsVendas: TDataSource
    DataSet = qryVendas
    Left = 473
    Top = 422
  end
end
