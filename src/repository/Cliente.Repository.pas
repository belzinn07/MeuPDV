unit Cliente.Repository;

interface

uses
  ICliente.Repository, DMConexao.infra, Cliente.Model,
  System.Generics.Collections, FireDAC.Comp.Client, TipoPessoa.Enums.Model;
type
 TClienteRepository = class(TInterfacedObject, IClienteRepository)

   private
    FdmConexao : TdmConexao;
    procedure AtualizarLista;

   public
    constructor Create(AdmConexão : TdmConexao);
    procedure Inserir(const ACliente : TCliente);
    procedure Atualizar(const ACliente: TCliente);
    procedure Excluir(AId: Integer);
    function Listar: TObjectList<TCliente>;
    function BuscarPorId(AId : Integer): TCliente;
    function Pesquisar(const APesquisa : string): TObjectList<TCliente>;

 end;

implementation



{ TClienteRepository }

constructor TClienteRepository.Create(AdmConexão: TdmConexao);
begin
  FdmConexao := AdmConexão;
end;

procedure TClienteRepository.Inserir(const ACliente: TCliente);
var
 Qry : TFDQuery;

begin
 Qry := TFDQuery.Create(nil);
 try

   Qry.Connection := FdmConexao.FDConexao;
   Qry.SQL.Text := 'INSERT INTO CLIENTES (NOME, CPF, CNPJ, TIPOPESSOA, TELEFONE, EMAIL, IE)' +
                    'VALUES(:NOME, :CPF, :CNPJ, :TIPOPESSOA, :TELEFONE, :EMAIL, :IE)';
   Qry.ParamByName('NOME').AsString := ACliente.Nome;
   Qry.ParamByName('CPF').AsString := ACliente.CPF;
   Qry.ParamByName('CNPJ').AsString := ACliente.CNPJ;

   case ACliente.TipoPessoa of
   tpFisica: Qry.ParamByName('TIPOPESSOA').AsString := 'F';
   tpJuridica: Qry.ParamByName('TIPOPESSOA').AsString := 'J';
   end;

   Qry.ParamByName('TELEFONE').AsString := ACliente.Telefone;
   Qry.ParamByName('EMAIL').AsString := ACliente.Email;
   Qry.ParamByName('IE').AsString := ACliente.IE;

   Qry.ExecSQL;

 finally
   Qry.Free;

 end;

end;

procedure TClienteRepository.Atualizar(const ACliente: TCliente);
var
 Qry : TFDQuery;
begin
 Qry := TFDQuery.Create(nil);

 try
  Qry.Connection := FdmConexao.FDConexao;
  Qry.SQL.Text := 'UPDATE CLIENTES SET NOME = :NOME, CPF = :CPF , CNPJ = :CNPJ,' +
                  'TIPOPESSOA = :TIPOPESSOA, TELEFOME = :TELEFONE, EMAIL = :EMAIL, IE  = :IE';
   Qry.ParamByName('NOME').AsString := ACliente.Nome;
   Qry.ParamByName('CPF').AsString := ACliente.CPF;
   Qry.ParamByName('CNPJ').AsString := ACliente.CNPJ;

   case ACliente.TipoPessoa of
   tpFisica: Qry.ParamByName('TIPOPESSOA').AsString := 'F';
   tpJuridica: Qry.ParamByName('TIPOPESSOA').AsString := 'J';
   end;

   Qry.ParamByName('TELEFONE').AsString := ACliente.Telefone;
   Qry.ParamByName('EMAIL').AsString := ACliente.Email;
   Qry.ParamByName('IE').AsString := ACliente.IE;

   Qry.ExecSQL;
 finally
   Qry.Free;
 end;

end;

procedure TClienteRepository.Excluir(AId: Integer);
var
 Qry : TFDQuery;
begin
 Qry := TFDQuery.Create(nil);

 try
   Qry.Connection := FdmConexao.FDConexao;
   Qry.SQL.Text := 'DELETE FROM CLIENTES WHERE ID = :ID';
   Qry.ParamByName('ID').AsInteger := AId;
   Qry.ExecSQL;

 finally
  Qry.Free;

 end;
end;

procedure TClienteRepository.AtualizarLista;
begin
 FdmConexao.qryProdutos.Close;
 FdmConexao.qryProdutos.Open;
end;

function TClienteRepository.BuscarPorId(AId: Integer): TCliente;
var
 Qry: TFDQuery;


begin
 Qry := TFDQuery.Create(nil);
 Result := nil;

try
 Qry.Connection := FdmConexao.FDConexao;

 Qry.SQL.Text := 'SELECT * FROM CLIENTES WHERE ID = :ID';
 Qry.ParamByName('ID').AsInteger := AId;
 Qry.Open;

 if not Qry.IsEmpty then
 begin
   Result.Id := Qry.FieldByName('ID').AsInteger;
   Result.Nome := Qry.FieldByName('NOME').AsString;
   Result.CPF := Qry.FieldByName('CPF').AsString;
   Result.CNPJ := Qry.FieldByName('CNPJ').AsString;
   case Qry.FieldByName('TIPOPESSOA').AsString[1] of
    'F': Result.TipoPessoa := tpFisica;
    'J': Result.TipoPessoa := tpJuridica;
   end;
   Result.Telefone := Qry.FieldByName('TELEFONE').AsString;
   Result.Email := Qry.FieldByName('EMAIL').AsString;
   Result.IE := QRY.FieldByName('IE').AsString;
 end;

finally
 Qry.Free;

end;

end;

function TClienteRepository.Listar: TObjectList<TCliente>;
var
 Qry: TFDQuery;
 Cliente: TCliente;

begin
 Qry := TFDQuery.Create(nil);
 Result := TObjectList<TCliente>.Create(True);

 try
   Qry.Connection := FdmConexao.FDConexao;
   Qry.SQL.Text := 'SELECT ID, NOME, CPF, CNPJ, TELEFONE, EMAIL' +
                   'FROM CLIENTES ORDER BY ID';
   Qry.Open;

   while not Qry.Eof do
   begin
     Cliente := TCliente.Create;

     Cliente.Id := Qry.FieldByName('ID').AsInteger;
     Cliente.Nome := Qry.FieldByName('NOME').AsString;
     Cliente.CPF := Qry.FieldByName('CNPJ').AsString;
     Cliente.Telefone := Qry.FieldByName('TELEFONE').AsString;
     Cliente.Email := Qry.FieldByName('EMAIL').AsString;

     Result.Add(Cliente);

     Qry.Next;
   end;

 finally

 end;

end;

function TClienteRepository.Pesquisar(
  const APesquisa: string): TObjectList<TCliente>;
var
 Qry: TFDQuery;
 Cliente : TCliente;

begin
 Qry := TFDQuery.Create(nil);
 Result := TObjectList<TCliente>.Create(True);

 try
   Qry.Connection := FdmConexao.FDConexao;
   Qry.SQL.Text := 'SELECT ID, NOME,CPF, CNPJ, TELEFONE, EMAIL FROM CLIENTES' +
                   'WHERE CAST(ID AS VARCHAR(20)) LIKE :VALOR_PESQUISA' +
                   'OR UPPER(NOME) LIKE UPPER (:VALOR_PESQUISA)' +
                   'OR CPF LIKE :VALOR_PESQUISA' +
                   'OR CNPJ LIKE :VALOR_PESQUISA' +
                   'OR TELEFONE LIKE :VALOR_PESQUISA' +
                   'OR EMAIL LIKE :VALOR_PESQUISA' +
                   'ORDER BY ID';
   Qry.ParamByName('VALOR_PESQUISA').AsString := '%' + APesquisa + '%';
   Qry.Open;

   while not Qry.Eof do
   begin
    Cliente := TCliente.Create;

    Cliente.Id := Qry.FieldByName('ID').AsInteger;
    Cliente.Nome := Qry.FieldByName('NOME').AsString;
    Cliente.CPF := Qry.FieldByName('CPF').AsString;
    Cliente.CNPJ := Qry.FieldByName('CNPJ').AsString;
    Cliente.Telefone := Qry.FieldByName('TELEFONE').AsString;
    Cliente.Email := Qry.FieldByName('EMAIL').AsString;

    Result.Add(Cliente);
    Qry.Next
   end;


 except
    Qry.Free;
    Result.Free;
    raise;
 end;

end;

end.
