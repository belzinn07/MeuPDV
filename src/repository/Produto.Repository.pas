unit Produto.Repository;

interface

uses IProduto.Repository,
 DMConexao.infra,
 Produto.Model,
 System.SysUtils,
 System.Generics.Collections;

type
TProdutoRepository = class (TInterfacedObject, IProdutoRepository)

 private
  FdmConexao: TdmConexao;
  procedure AtualizarLista;

 public
  constructor Create(AdmConexão : TdmConexao);
  procedure Inserir(AProduto: TProduto);
  procedure Atualizar(AProduto : TProduto);
  procedure Excluir(AId : Integer);
  function ListarProdutos: TObjectList<TProduto>;
  function BuscarPorId(AId: Integer): TProduto;
  function PesquisarProdutos(APesquisa: String): TObjectList<TProduto>;
end;


implementation

{ TProdutoRepository }

constructor TProdutoRepository.Create(AdmConexão: TdmConexao);
begin

FdmConexao := AdmConexão;
end;

procedure TProdutoRepository.AtualizarLista;
begin
FdmConexao.qryProdutos.Close;
FdmConexao.qryProdutos.Open;
end;

procedure TProdutoRepository.Inserir(AProduto: TProduto);
begin
FdmConexao.FDTransacao.StartTransaction;

try
  FdmConexao.qryCRUD.SQL.Clear;
  FdmConexao.qryCRUD.SQL.Text := 'INSERT INTO PRODUTOS (DESCRICAO, PRECO, SALDO) VALUES (:DESCRICAO, :PRECO, :SALDO)';

  FdmConexao.qryCRUD.ParamByName('DESCRICAO').AsString := AProduto.Descricao;
  FdmConexao.qryCRUD.ParamByName('PRECO').AsCurrency := AProduto.Preco;
  FdmConexao.qryCRUD.ParamByName('SALDO').AsFloat := AProduto.Saldo;
  FdmConexao.qryCRUD.ExecSQL;

  FdmConexao.FDTransacao.Commit;
  AtualizarLista;
except
  FdmConexao.FDTransacao.Rollback;
  raise;
end;

end;

procedure TProdutoRepository.Atualizar(AProduto: TProduto);
begin
FdmConexao.FDTransacao.StartTransaction;

try
FdmConexao.qryCRUD.SQL.Clear;
FdmConexao.qryCRUD.SQL.Text := 'UPDATE PRODUTOS SET DESCRICAO = :DESCRICAO, PRECO = :PRECO, SALDO = :SALDO WHERE ID = :ID';

FdmConexao.qryCRUD.ParamByName('DESCRICAO').AsString := AProduto.Descricao;
FdmConexao.qryCRUD.ParamByName('PRECO').AsCurrency := AProduto.Preco;
FdmConexao.qryCRUD.ParamByName('SALDO').AsFloat := AProduto.Saldo;
FdmConexao.qryCRUD.ParamByName('ID').AsInteger := AProduto.Id;
FdmConexao.qryCRUD.ExecSQL;
FdmConexao.FDTransacao.Commit;
AtualizarLista;
except
FdmConexao.FDTransacao.Rollback;
raise;

end;

end;

procedure TProdutoRepository.Excluir(AId: Integer);
begin

FdmConexao.FDTransacao.StartTransaction;

try
FdmConexao.qryCRUD.SQL.Clear;
FdmConexao.qryCRUD.SQL.Text := 'DELETE FROM PRODUTOS WHERE ID = :ID';
FdmConexao.qryCRUD.ParamByName('ID').AsInteger :=  AId;
FdmConexao.qryCRUD.ExecSQL;

FdmConexao.FDTransacao.Commit;
AtualizarLista;

except
FdmConexao.FDTransacao.Rollback;
raise;

end;

end;


function TProdutoRepository.BuscarPorId(AId: Integer): TProduto;
var
 Produto: TProduto;

begin
 Produto := TProduto.Create;

  FdmConexao.qryCRUD.Close;
  FdmConexao.qryCRUD.SQL.Text := 'SELECT * FROM PRODUTOS WHERE ID = :ID';
  FdmConexao.qryCRUD.ParamByName('ID').AsInteger := AId;
  FdmConexao.qryCRUD.Open;

  if not FdmConexao.qryCRUD.IsEmpty then
  begin
   Produto.Id := FdmConexao.qryCRUD.FieldByName('ID').AsInteger;
   Produto.Descricao := FdmConexao.qryCRUD.FieldByName('DESCRICAO').AsString;
   Produto.Preco := FdmConexao.qryCRUD.FieldByName('PRECO').AsCurrency;
   Produto.Saldo := FdmConexao.qryCRUD.FieldByName('SALDO').AsFloat;

  end;

  Result := Produto;

end;



function TProdutoRepository.ListarProdutos: TObjectList<TProduto>;
var
 Produto : TProduto;

 begin
Result := TObjectList<TProduto>.Create(True);
 try
 FdmConexao.qryCRUD.Close;
 FdmConexao.qryCRUD.SQL.Text:= 'SELECT ID, DESCRICAO, PRECO, SALDO FROM PRODUTOS ORDER BY ID';
 FdmConexao.qryCRUD.Open;

 while not FdmConexao.qryCRUD.Eof do
  begin
    Produto := TProduto.Create;

   Produto.Id := FdmConexao.qryCRUD.FieldByName('ID').AsInteger;
   Produto.Descricao := FdmConexao.qryCRUD.FieldByName('DESCRICAO').AsString;
   Produto.Preco := FdmConexao.qryCRUD.FieldByName('PRECO').AsCurrency;
   Produto.Saldo := FdmConexao.qryCRUD.FieldByName('SALDO').AsFloat;

    Result.Add(Produto);

    FdmConexao.qryCRUD.Next;
  end;

 except
    Result.Free;
    raise;

 end;
end;

function TProdutoRepository.PesquisarProdutos(APesquisa: String): TObjectList<TProduto>;
var
  Produto : TProduto;
begin
  Result := TObjectList<TProduto>.Create(True);

  try
    FdmConexao.qryCRUD.Close;
    FdmConexao.qryCRUD.SQL.Text := 'SELECT ID, DESCRICAO, PRECO, SALDO ' +
                                   'FROM PRODUTOS ' +
                                   'WHERE CAST(ID AS VARCHAR(20)) LIKE :VALOR_PESQUISA ' +
                                   '   OR UPPER(DESCRICAO) LIKE UPPER(:VALOR_PESQUISA) ' +
                                   '   OR CAST(PRECO AS VARCHAR(20)) LIKE :VALOR_PESQUISA ' +
                                   'ORDER BY DESCRICAO';

    FdmConexao.qryCRUD.ParamByName('VALOR_PESQUISA').AsString := '%' + APesquisa + '%';
    FdmConexao.qryCRUD.Open;

    while not FdmConexao.qryCRUD.Eof do
    begin
      Produto := TProduto.Create;


      Produto.Id        := FdmConexao.qryCRUD.FieldByName('ID').AsInteger;
      Produto.Descricao := FdmConexao.qryCRUD.FieldByName('DESCRICAO').AsString;
      Produto.Preco     := FdmConexao.qryCRUD.FieldByName('PRECO').AsCurrency;
      Produto.Saldo     := FdmConexao.qryCRUD.FieldByName('SALDO').AsFloat;

      Result.Add(Produto);

      FdmConexao.qryCRUD.Next;
    end;

  except
    Result.Free;
    raise;
  end;
end;
end.                         v
