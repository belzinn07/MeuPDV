unit Cliente.Service;

interface

uses
  ICliente.Service,
  Cliente.Repository,
  System.Generics.Collections,
  Cliente.Model, DMConexao.infra, Cliente.Validation, System.SysUtils,
  MeuPDV.Logger;

type
  TClienteService = class(TInterfacedObject, IClienteService)

  private
   FRepository : TClienteRepository;

  public
   constructor Create(Adm : Tdm);
   procedure Salvar(const ACliente : TCliente);
   procedure Excluir(AId : Integer);
   function Listar : TObjectList<TCliente>;
   function BuscarPorId(AId : Integer) : TCliente;
   function Pesquisar(const APesquisa : string) : TObjectList<TCliente>;

  end;

implementation

{ TClienteService }

constructor TClienteService.Create(Adm: Tdm);
begin
  FRepository := TClienteRepository.Create(Adm);
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
     TLogger.Info('ClienteService.Salvar', 'Operação identificada: Edição de Cliente');
     FRepository.Atualizar(ACliente);
     TLogger.Info('ClienteService.Salvar',
     Format('Cliente ID = %d atualizado com sucesso',
     [ACliente.Id.ToString]));

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
  TLogger.Warning('ClienteService.Excluir','Erro: ID ' + AId.ToString + ' è inválido');
  raise Exception.Create('ID inválido');

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

end.
