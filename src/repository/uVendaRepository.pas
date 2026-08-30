unit uVendaRepository;

interface

uses
  uIVendaRepository, uDMConexao, uVenda, uItemVenda, FireDAC.Comp.Client,
  System.Generics.Collections;

 type
  TVendaRepository = class(TInterfacedObject, IVendaRepository)

   private
    FDmConexao: Tdm;
    procedure InserirVenda(AVenda: TVenda);
    procedure InserirItensVendas(AIdVenda: Integer; AItens: TObjectList<TItemVenda>);

   public
    constructor Create(ADmConexao: Tdm);
    procedure SalvarVendaComItens(AVenda: TVenda; AItens: TObjectList<TItemVenda>);

  end;

implementation

{ TVendaRepository }

constructor TVendaRepository.Create(ADmConexao: Tdm);
begin
  FDmConexao := ADmConexao;
end;

procedure TVendaRepository.InserirVenda(AVenda: TVenda);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FDmConexao.FDConexao;
    Qry.SQL.Text := 'INSERT INTO VENDAS (ID_CLIENTE, DATA, TOTAL)' +
                    'VALUES (:ID_CLIENTE, :DATA, :TOTAL) RETURNING ID';
    Qry.ParamByName('ID_CLIENTE').AsInteger := AVenda.IdCliente;
    Qry.ParamByName('DATA').AsDate := AVenda.Data;
    Qry.ParamByName('TOTAL').AsCurrency := AVenda.Total;
    Qry.Open;

    AVenda.Id := Qry.FieldByName('ID').AsInteger;
  finally
    Qry.Free;
  end;
end;

procedure TVendaRepository.InserirItensVendas(AIdVenda: Integer;
  AItens: TObjectList<TItemVenda>);
var
  Qry: TFDQuery;
  Item: TItemVenda;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FDmConexao.FDConexao;
    Qry.SQL.Text := 'INSERT INTO ITENS_VENDAS (ID_VENDA, ID_PRODUTO, QUANTIDADE, VALOR_UNITARIO)' +
                    'VALUES (:ID_VENDA, :ID_PRODUTO, :QUANTIDADE, :VALOR_UNITARIO)';

    for Item in AItens do
    begin
      Qry.ParamByName('ID_VENDA').AsInteger := AIdVenda;
      Qry.ParamByName('ID_PRODUTO').AsInteger := Item.IdProduto;
      Qry.ParamByName('QUANTIDADE').AsInteger := Item.Quantidade;
      Qry.ParamByName('VALOR_UNITARIO').AsCurrency := Item.ValorUnitario;
      Qry.ExecSQL;
    end;
  finally
    Qry.Free;
  end;
end;

procedure TVendaRepository.SalvarVendaComItens(AVenda: TVenda;
  AItens: TObjectList<TItemVenda>);
begin
  FDmConexao.FDTransacao.StartTransaction;
  try
    InserirVenda(AVenda);
    InserirItensVendas(AVenda.Id, AItens);
    FDmConexao.FDTransacao.Commit;
  except
    FDmConexao.FDTransacao.Rollback;
    raise;
  end;
end;

end.