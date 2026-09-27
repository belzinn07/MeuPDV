unit uVendaRepository;

interface

uses
  uIVendaRepository, uDMConexao, uVenda, uItemVenda, FireDAC.Comp.Client,
  System.Generics.Collections, uVendaStatus, System.SysUtils;

 type
  TVendaRepository = class(TInterfacedObject, IVendaRepository)

   private
    FDmConexao: Tdm;
    procedure InserirVenda(AVenda: TVenda);
    procedure InserirItensVendas(AIdVenda: Integer; AItens: TObjectList<TItemVenda>);
    procedure AtualizarVenda(AVenda :TVenda);

   public
    constructor Create(ADmConexao: Tdm);
    procedure SalvarVendaComItens(AVenda: TVenda; AItens: TObjectList<TItemVenda>);
    function BuscarProximaFatura: Integer;
    function BuscarPorId(AId: Integer): TVenda;
    procedure AtualizarVendaComItens(AVenda: TVenda; AItens: TObjectList<TItemVenda>);
    procedure ExcluirVenda(AId: Integer);
    function Listar: TObjectList<TVenda>;
    function Pesquisar(const APesquisa: string): TObjectList<TVenda>;

  end;

implementation

{ TVendaRepository }

function TVendaRepository.BuscarProximaFatura: Integer;
var
 Qry: TFDQuery;

begin
 Qry := TFDQuery.Create(nil);

 try
   Qry.Connection := FDmConexao.FDConexao;
   Qry.SQL.Text := 'SELECT GEN_ID(SEQ_PEDIDO, 0) + 1 AS ProximoId FROM RDB$DATABASE';
   Qry.Open;

   Result := Qry.FieldByName('ProximoId').AsInteger;
 finally
   Qry.Free;
 end;
end;

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
    Qry.SQL.Text := 'INSERT INTO VENDAS (ID, ID_CLIENTE, DATA, TOTAL, STATUS)' +
                    'VALUES (NEXT VALUE FOR SEQ_PEDIDO, :ID_CLIENTE, :DATA, :TOTAL, :STATUS) RETURNING ID';
    Qry.ParamByName('ID_CLIENTE').AsInteger := AVenda.IdCliente;
    Qry.ParamByName('DATA').AsDate := AVenda.Data;
    Qry.ParamByName('TOTAL').AsCurrency := AVenda.Total;
    Qry.ParamByName('STATUS').AsString := VendaStatusToStr(vsFechada);
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

function TVendaRepository.BuscarPorId(AId: Integer): TVenda;
var
  Qry: TFDQuery;
  Item : TItemVenda;

begin
  Result := nil;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FDmConexao.FDConexao;

    Qry.SQL.Text := 'SELECT * FROM VENDAS WHERE ID = :ID';
    Qry.ParamByName('ID').AsInteger := AId;
    Qry.Open;

    if not Qry.IsEmpty then
    begin
      Result := TVenda.Create;
      Result.Id := Qry.FieldByName('ID').AsInteger;
      Result.IdCliente := Qry.FieldByName('ID_CLIENTE').AsInteger;
      Result.Data := Qry.FieldByName('DATA').AsDateTime;
      Result.Total := Qry.FieldByName('TOTAL').AsCurrency;
      Result.Status := StrToVendaStatus(Qry.FieldByName('STATUS').AsString);
    end;

    if Result = nil then
      Exit;

    Qry.Close;
    Qry.SQL.Text := 'SELECT * FROM ITENS_VENDAS WHERE ID_VENDA = :ID';
    Qry.ParamByName('ID').AsInteger := AId;
    Qry.Open;

    while not Qry.Eof do
    begin
      Item := TItemVenda.Create;
      Item.Id := Qry.FieldByName('ID').AsInteger;
      Item.IdVenda := Qry.FieldByName('ID_VENDA').AsInteger;
      Item.IdProduto := Qry.FieldByName('ID_PRODUTO').AsInteger;
      Item.Quantidade := Qry.FieldByName('QUANTIDADE').AsInteger;
      Item.ValorUnitario := Qry.FieldByName('VALOR_UNITARIO').AsCurrency;
      Result.Itens.Add(Item);

      Qry.Next;
    end;
  finally
    Qry.Free;
  end;

end;

procedure TVendaRepository.AtualizarVendaComItens(AVenda: TVenda; AItens: TObjectList<TItemVenda>);
var
  Qry : TFDQuery;
begin
  FDmConexao.FDTransacao.StartTransaction;
  Qry := TFDQuery.Create(nil);
  try
    try
      Qry.Connection := FDmConexao.FDConexao;
      AtualizarVenda(AVenda);
      Qry.SQL.Text := 'DELETE FROM ITENS_VENDAS WHERE ID_VENDA = :ID';
      Qry.ParamByName('ID').AsInteger := AVenda.Id;
      Qry.ExecSQL;
      InserirItensVendas(AVenda.Id, AItens);
      FDmConexao.FDTransacao.Commit;
    except
      FDmConexao.FDTransacao.Rollback;
      raise;
    end;
  finally
    Qry.Free;
  end;
end;

procedure TVendaRepository.AtualizarVenda(AVenda: TVenda);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FDmConexao.FDConexao;

    Qry.SQL.Text :=
      'UPDATE VENDAS SET ID_CLIENTE = :ID_CLIENTE, TOTAL = :TOTAL, STATUS = :STATUS WHERE ID = :ID';

    Qry.ParamByName('ID').AsInteger := AVenda.Id;
    Qry.ParamByName('ID_CLIENTE').AsInteger := AVenda.IdCliente;
    Qry.ParamByName('TOTAL').AsCurrency := AVenda.Total;
    Qry.ParamByName('STATUS').AsString := VendaStatusToStr(AVenda.Status);

    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;


procedure TVendaRepository.ExcluirVenda(AId: Integer);
var
  Qry: TFDQuery;

begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FDmConexao.FDConexao;

    Qry.SQL.Text := 'DELETE FROM ITENS_VENDAS WHERE ID_VENDA = :ID';
    Qry.ParamByName('ID').AsInteger := AId;
    Qry.ExecSQL;

    Qry.Close;
    Qry.SQL.Text := 'UPDATE VENDAS SET STATUS = :STATUS WHERE ID = :ID';
    Qry.ParamByName('ID').AsInteger := AId;
    Qry.ParamByName('STATUS').AsString := VendaStatusToStr(vsCancelada);
    Qry.ExecSQL;

  finally
    Qry.Free;
  end;
end;

function TVendaRepository.Listar: TObjectList<TVenda>;
var
  Qry: TFDQuery;
  Venda: TVenda;

begin
  Qry := TFDQuery.Create(nil);
  Result := TObjectList<TVenda>.Create(True);

  try
    try
      Qry.Connection := FDmConexao.FDConexao;
      Qry.SQL.Text := 'SELECT V.ID, V.ID_CLIENTE, V.DATA, V.TOTAL, V.STATUS, ' +
                      'COALESCE(C.NOME, '''') AS NOME_CLIENTE ' +
                      'FROM VENDAS V LEFT JOIN CLIENTES C ON C.ID = V.ID_CLIENTE ' +
                      'ORDER BY V.ID';
      Qry.Open;

      while not Qry.Eof do
      begin
        Venda := TVenda.Create;

        Venda.Id := Qry.FieldByName('ID').AsInteger;
        Venda.IdCliente := Qry.FieldByName('ID_CLIENTE').AsInteger;
        Venda.Data := Qry.FieldByName('DATA').AsDateTime;
        Venda.Total := Qry.FieldByName('TOTAL').AsCurrency;
        Venda.Status := StrToVendaStatus(Qry.FieldByName('STATUS').AsString);
        Venda.NomeCliente := Qry.FieldByName('NOME_CLIENTE').AsString;

        Result.Add(Venda);

        Qry.Next;
      end;
    except
      FreeAndNil(Result);
      raise;
    end;

  finally
    Qry.Free;

  end;
end;

function TVendaRepository.Pesquisar(
  const APesquisa: string): TObjectList<TVenda>;
var
  Qry: TFDQuery;
  Venda: TVenda;

begin
  Qry := TFDQuery.Create(nil);
  Result := TObjectList<TVenda>.Create(True);

  try
    try
      Qry.Connection := FDmConexao.FDConexao;
      Qry.SQL.Text := 'SELECT V.ID, V.ID_CLIENTE, V.DATA, V.TOTAL, V.STATUS, ' +
                      'COALESCE(C.NOME, '''') AS NOME_CLIENTE ' +
                      'FROM VENDAS V LEFT JOIN CLIENTES C ON C.ID = V.ID_CLIENTE ' +
                      'WHERE CAST(V.ID AS VARCHAR(20)) LIKE :VALOR_PESQUISA ' +
                      'OR UPPER(C.NOME) LIKE UPPER(:VALOR_PESQUISA) ' +
                      'OR UPPER(V.STATUS) LIKE UPPER(:VALOR_PESQUISA) ' +
                      'ORDER BY V.ID';
      Qry.ParamByName('VALOR_PESQUISA').AsString := '%' + APesquisa + '%';
      Qry.Open;

      while not Qry.Eof do
      begin
        Venda := TVenda.Create;

        Venda.Id := Qry.FieldByName('ID').AsInteger;
        Venda.IdCliente := Qry.FieldByName('ID_CLIENTE').AsInteger;
        Venda.Data := Qry.FieldByName('DATA').AsDateTime;
        Venda.Total := Qry.FieldByName('TOTAL').AsCurrency;
        Venda.Status := StrToVendaStatus(Qry.FieldByName('STATUS').AsString);
        Venda.NomeCliente := Qry.FieldByName('NOME_CLIENTE').AsString;

        Result.Add(Venda);

        Qry.Next;
      end;
    except
      FreeAndNil(Result);
      raise;
    end;

  finally
    Qry.Free;

  end;
end;

end.