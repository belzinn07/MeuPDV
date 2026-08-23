unit Cliente.Service;

interface

uses
  ICliente.Service,
  Cliente.Repository,
  System.Generics.Collections,
  Cliente.Model, DMConexao.infra, Cliente.Validation, System.SysUtils,
  MeuPDV.Logger,
    System.Character, ICliente.Repository;

type
  TClienteService = class(TInterfacedObject, IClienteService)

  private
   FRepository : IClienteRepository;

  public
   constructor Create(ARepository: IClienteRepository);
   procedure Salvar(const ACliente : TCliente);
   procedure Excluir(AId : Integer);
   function Listar : TObjectList<TCliente>;
   function BuscarPorId(AId : Integer) : TCliente;
   function Pesquisar(const APesquisa : string) : TObjectList<TCliente>;
   function SomenteNumeros(const ATexto: string): string;

  end;

implementation

{ TClienteService }

constructor TClienteService.Create(ARepository: IClienteRepository);
begin
  FRepository := ARepository;
end;

procedure TClienteService.Salvar(const ACliente: TCliente);
var
 Validador : TClienteValidador;

begin
 TLogger.Info('ClienteService.Salvar',
  Format('Iniciando processo de salvamento. ID = %d | Cliente = %s ',
  [ACliente.Id, ACliente.Nome]));
 Validador := TClienteValidador.Create;

 try
  ACliente.CPF := SomenteNumeros(ACliente.CPF);
  ACliente.CNPJ := SomenteNumeros(ACliente.CNPJ);
  ACliente.Telefone := SomenteNumeros(ACliente.Telefone);

  TLogger.Debug('ClienteService.Salvar', 'Executando validação do cliente');
  Validador.Validar(ACliente);
  TLogger.Debug('ClienteService.Salvar', 'Cliente validado com sucesso');

  if ACliente.Id = 0 then
  begin
     TLogger.Info('ClienteService.Salvar', 'Operação identificada: Cadastro de Cliente');
     FRepository.Inserir(ACliente);
     TLogger.Info('ClienteService.Salvar', 'Cliente cadastrado com sucesso no banco de dados ' +
     'ID gerado: ' + ACliente.Id.ToString );

  end
  else
  begin
     TLogger.Info('ClienteService.Salvar', 'Operação identificada: Edição de Cliente');
     FRepository.Atualizar(ACliente);
     TLogger.Info('ClienteService.Salvar',
     Format('Cliente ID = %d atualizado com sucesso',
     [ACliente.Id]));
  end;

 except
  on E: Exception do
  begin
     TLogger.Erro('ClienteService.Salvar',
     Format('Erro ao salvar Cliente %s | ID = %d | Erro: %s' ,
     [ACliente.Nome, ACliente.Id, E.Message]));
     raise Exception.CreateFmt('Erro ao salvar Cliente: %s', [E.Message]);
  end
 end;

end;

procedure TClienteService.Excluir(AId: Integer);
begin
  if AId <= 0 then
  begin
  TLogger.Warning('ClienteService.Excluir','Erro: ID ' + AId.ToString + ' è inválido');
  raise Exception.Create('ID inválido');
  end;

 TLogger.Info('ClienteService.Excluir','Iniciando exclusão do cliente ' + AId.ToString);
 FRepository.Excluir(AId);
 TLogger.Info( 'ClienteService.Excluir','Cliente de código ' + AId.ToString +' excluído com sucesso');
end;

function TClienteService.BuscarPorId(AId: Integer): TCliente;
begin
  Result := FRepository.BuscarPorId(AId);
end;

function TClienteService.Listar: TObjectList<TCliente>;
begin
   TLogger.Debug('ClienteService.Listar','Iniciando listagem de clientes');
   Result := FRepository.Listar;
   TLogger.Debug('ProdutoService.ListarProdutos',Format('Total de %d produtos dispóníveis no sistema', [Result.Count] ));
end;

function TClienteService.Pesquisar(
  const APesquisa: string): TObjectList<TCliente>;
begin

  if APesquisa.Trim.IsEmpty then
     raise Exception.Create('Digite algo para pesquisar');

  Result := FRepository.Pesquisar(APesquisa);
end;

function TClienteService.SomenteNumeros(const ATexto: string): string;
var
  C: Char;
begin
  Result := '';

  for C in ATexto do
    if C.IsDigit then
      Result := Result + C;
end;


end.
