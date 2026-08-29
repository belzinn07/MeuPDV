unit uClienteService;

interface

uses
  uIClienteService,
  uClienteRepository,
  System.Generics.Collections,
  uCliente, uDMConexao, uClienteValidador, System.SysUtils,
  uLogger, System.Character, uIClienteRepository, uClienteDTO, uIValidador,
  uClienteMapper;

type
  TClienteService = class(TInterfacedObject, IClienteService)

  private
   FRepository : IClienteRepository;

  public
   constructor Create(ARepository: IClienteRepository);
   procedure Salvar(const ACliente : TClienteDTO);
   procedure Excluir(AId : Integer);
   function Listar : TObjectList<TClienteDTO>;
   function BuscarPorId(AId : Integer) : TClienteDTO;
   function Pesquisar(const APesquisa : string) : TObjectList<TClienteDTO>;
   function SomenteNumeros(const ATexto: string): string;

  end;

implementation

{ TClienteService }

constructor TClienteService.Create(ARepository: IClienteRepository);
begin
  FRepository := ARepository;
end;

procedure TClienteService.Salvar(const ACliente: TClienteDTO);
var
  Validador : IValidador<TClienteDTO>;
  Cliente : TCliente;

begin
 TLogger.Info('ClienteService.Salvar',
  Format('Iniciando processo de salvamento. ID = %d | Cliente = %s ',
  [ACliente.Id, ACliente.Nome]));

 try
  Validador := TClienteValidador.Create;

  ACliente.CPF := SomenteNumeros(ACliente.CPF);
  ACliente.CNPJ := SomenteNumeros(ACliente.CNPJ);
  ACliente.Telefone := SomenteNumeros(ACliente.Telefone);

  TLogger.Debug('ClienteService.Salvar', 'Executando validação do cliente');
  Validador.Validar(ACliente);
  TLogger.Debug('ClienteService.Salvar', 'Cliente validado com sucesso');

  Cliente := TClienteMapper.ConverterParaEntidade(ACliente);

  try
    if Cliente.Id = 0 then
    begin
       TLogger.Info('ClienteService.Salvar', 'Operação identificada: Cadastro de Cliente');
       FRepository.Inserir(Cliente);
       ACliente.Id := Cliente.Id;
       TLogger.Info('ClienteService.Salvar', 'Cliente cadastrado com sucesso no banco de dados ' +
       'ID gerado: ' + ACliente.Id.ToString );
    end
    else
    begin
       TLogger.Info('ClienteService.Salvar', 'Operação identificada: Edição de Cliente');
       FRepository.Atualizar(Cliente);
       TLogger.Info('ClienteService.Salvar',
       Format('Cliente ID = %d atualizado com sucesso',
       [ACliente.Id]));
    end;
  finally
    Cliente.Free;
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
  TLogger.Warning('ClienteService.Excluir','Erro: ID ' + AId.ToString + ' é inválido');
  raise Exception.Create('ID inválido');
  end;

 TLogger.Info('ClienteService.Excluir','Iniciando exclusão do cliente ' + AId.ToString);
 FRepository.Excluir(AId);
 TLogger.Info( 'ClienteService.Excluir','Cliente de código ' + AId.ToString +' excluído com sucesso');
end;

function TClienteService.BuscarPorId(AId: Integer): TClienteDTO;
var
  Cliente : TCliente;
begin
  TLogger.Debug('ClienteService.BuscarPorId',
    'Buscando cliente pelo ID ' + AId.ToString);

  Cliente := FRepository.BuscarPorId(AId);

  if not Assigned(Cliente) then
  begin
    TLogger.Warning('ClienteService.BuscarPorId',
      'Nenhum cliente encontrado para o ID ' + AId.ToString);
    Result := nil;
    Exit;
  end;

  try
    Result := TClienteMapper.ConverterParaDto(Cliente);

    TLogger.Debug('ClienteService.BuscarPorId',
      'Cliente encontrado com sucesso. ID=' + AId.ToString);
  finally
    Cliente.Free;
  end;
end;

function TClienteService.Listar: TObjectList<TClienteDTO>;
var
  Clientes : TObjectList<TCliente>;
  Cliente : TCliente;
begin
  TLogger.Debug('ClienteService.Listar','Iniciando listagem de clientes');

  Clientes := FRepository.Listar;

  Result := TObjectList<TClienteDTO>.Create(True);

  try
    for Cliente in Clientes do
      Result.Add(TClienteMapper.ConverterParaDto(Cliente));

    TLogger.Debug('ClienteService.Listar',
      Format('Total de %d clientes disponíveis no sistema', [Result.Count]));
  finally
    Clientes.Free;
  end;
end;

function TClienteService.Pesquisar(
  const APesquisa: string): TObjectList<TClienteDTO>;
var
  Clientes : TObjectList<TCliente>;
  Cliente : TCliente;
begin
  if APesquisa.Trim.IsEmpty then
     raise Exception.Create('Digite algo para pesquisar');

  Clientes := FRepository.Pesquisar(APesquisa);

  Result := TObjectList<TClienteDTO>.Create(True);

  try
    for Cliente in Clientes do
      Result.Add(TClienteMapper.ConverterParaDto(Cliente));

    TLogger.Debug('ClienteService.Pesquisar',
      Format('Pesquisa por "%s" retornou %d resultado(s)',
      [APesquisa, Result.Count]));
  finally
    Clientes.Free;
  end;
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