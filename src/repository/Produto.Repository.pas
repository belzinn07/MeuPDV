unit Produto.Repository;

interface

uses IProduto.Repository,
 DMConexao.infra,
 Produto.Model,
 System.SysUtils,
 System.Generics.Collections, FireDAC.Comp.Client;

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
  function Listar: TObjectList<TProduto>;
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
var
 Qry: TFDquery;

begin
Qry := TFDQuery.Create(nil);

try
  Qry.Connection := FdmConexao.FDConexao;
  Qry.SQL.Text := 'INSERT INTO PRODUTOS (DESCRICAO, PRECO, SALDO) ' +
                   'VALUES (:DESCRICAO, :PRECO, :SALDO)';
  Qry.ParamByName('DESCRICAO').AsString := AProduto.Descricao;
  Qry.ParamByName('PRECO').AsCurrency := AProduto.Preco;
  Qry.ParamByName('SALDO').AsFloat := AProduto.Saldo;
  Qry.ExecSQL;

  AtualizarLista;
finally
  Qry.Free;

end;

end;

procedure TProdutoRepository.Atualizar(AProduto: TProduto);
var
 Qry: TFDQuery;

begin
Qry := TFDQuery.Create(nil);

try
  Qry.Connection := FdmConexao.FDConexao;
  Qry.SQL.Text := 'UPDATE PRODUTOS SET DESCRICAO = :DESCRICAO,'+
                  'PRECO = :PRECO, SALDO = :SALDO WHERE ID = :ID';
  Qry.ParamByName('DESCRICAO').AsString := AProduto.Descricao;
  Qry.ParamByName('PRECO').AsCurrency := AProduto.Preco;
  Qry.ParamByName('SALDO').AsFloat := AProduto.Saldo;
  Qry.ParamByName('ID').AsInteger := AProduto.Id;
  Qry.ExecSQL;

  AtualizarLista;
finally
  Qry.Free;
end;

end;

procedure TProdutoRepository.Excluir(AId: Integer);
var
 Qry: TFDQuery;
begin
 Qry := TFDQuery.Create(nil);

try
 Qry.Connection := FdmConexao.FDConexao;
 Qry.SQL.Text := 'DELETE FROM PRODUTOS WHERE ID = :ID';
 Qry.ParamByName('ID').AsInteger :=  AId;
 Qry.ExecSQL;

AtualizarLista;

finally
 Qry.Free;
end;

end;


function TProdutoRepository.BuscarPorId(AId: Integer): TProduto;
var
 Qry: TFDQuery;

begin
 Qry := TFDQuery.Create(nil);
 Result := nil;

  try
  Qry.Connection := FdmConexao.FDConexao;

  Qry.SQL.Text := 'SELECT * FROM PRODUTOS WHERE ID = :ID';
  Qry.ParamByName('ID').AsInteger := AId;
  Qry.Open;

  if not  Qry.IsEmpty then
  begin
    Result := TProduto.Create;

   Result.Id := Qry.FieldByName('ID').AsInteger;
   Result.Descricao := Qry.FieldByName('DESCRICAO').AsString;
   Result.Preco := Qry.FieldByName('PRECO').AsCurrency;
   Result.Saldo := Qry.FieldByName('SALDO').AsFloat;

  end;

  finally
   Qry.Free;
  end;

end;



function TProdutoRepository.Listar: TObjectList<TProduto>;
var
 Qry :TFDQuery;
 Produto : TProduto;

begin
  Qry := TFDQuery.Create(nil);
  Result := TObjectList<TProduto>.Create(True);

try
 Qry.Connection := FdmConexao.FDConexao;
 Qry.SQL.Text:= 'SELECT ID, DESCRICAO, PRECO, SALDO FROM PRODUTOS ORDER BY ID';
 Qry.Open;

 while not Qry.Eof do
  begin
    Produto := TProduto.Create;

   Produto.Id := Qry.FieldByName('ID').AsInteger;
   Produto.Descricao := Qry.FieldByName('DESCRICAO').AsString;
   Produto.Preco := Qry.FieldByName('PRECO').AsCurrency;
   Produto.Saldo := Qry.FieldByName('SALDO').AsFloat;

    Result.Add(Produto);

    Qry.Next;
  end;

finally
  Qry.Free;

 end;
end;

function TProdutoRepository.PesquisarProdutos(APesquisa: String): TObjectList<TProduto>;
var
  Qry : TFDQuery;
  Produto : TProduto;

begin
  Qry := TFDQuery.Create(nil);
  Result := TObjectList<TProduto>.Create(True);

  try
   Qry.Connection := FdmConexao.FDConexao;
   Qry.SQL.Text := 'SELECT ID, DESCRICAO, PRECO, SALDO ' +
                                   'FROM PRODUTOS ' +
                                   'WHERE CAST(ID AS VARCHAR(20)) LIKE :VALOR_PESQUISA ' +
                                   '   OR UPPER(DESCRICAO) LIKE UPPER(:VALOR_PESQUISA) ' +
                                   '   OR CAST(PRECO AS VARCHAR(20)) LIKE :VALOR_PESQUISA ' +
                                   'ORDER BY DESCRICAO';

    Qry.ParamByName('VALOR_PESQUISA').AsString := '%' + APesquisa + '%';
    Qry.Open;

    while not Qry.Eof do
    begin
      Produto := TProduto.Create;

      Produto.Id        := Qry.FieldByName('ID').AsInteger;
      Produto.Descricao := Qry.FieldByName('DESCRICAO').AsString;
      Produto.Preco     := Qry.FieldByName('PRECO').AsCurrency;
      Produto.Saldo     := Qry.FieldByName('SALDO').AsFloat;

      Result.Add(Produto);

      Qry.Next;
    end;

  except
    Qry.Free;
    Result.Free;
    raise;
  end;
end;
end.
