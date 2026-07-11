unit Cliente.Service;

interface

uses
  ICliente.Service,
  Cliente.Repository,
  System.Generics.Collections,
  Cliente.Model, DMConexao.infra, Cliente.Validation, System.SysUtils;

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
 Validador := TClienteValidador.Create;

 try
  Validador.Validar(ACliente);

  if ACliente.Id = 0 then
     FRepository.Inserir(ACliente)
  else
     FRepository.Atualizar(ACliente);

 except
  on E: Exception do
     raise Exception.CreateFmt('Erro ao salvar Cliente: %s', [E.Message]);

 end;

end;

procedure TClienteService.Excluir(AId: Integer);
begin
  if AId <= 0 then
  raise Exception.Create('ID inválido');

 FRepository.Excluir(AId);
end;

function TClienteService.BuscarPorId(AId: Integer): TCliente;
begin
  Result := FRepository.BuscarPorId(AId);
end;

function TClienteService.Listar: TObjectList<TCliente>;
begin
   Result := FRepository.Listar;
end;

function TClienteService.Pesquisar(
  const APesquisa: string): TObjectList<TCliente>;
begin

  if APesquisa.Trim.IsEmpty then
     raise Exception.Create('Digite algo para pesquisar');

  Result := FRepository.Pesquisar(APesquisa);
end;

end.
