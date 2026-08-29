unit uServiceFactory;

interface

uses
  uIProdutoService, uIClienteService, uDMConexao;

type
  TServiceFactory = class
  private
    class var FProdutoService: IProdutoService;
    class var FClienteService: IClienteService;
    class var FInicializado: Boolean;
  public
    class procedure Inicializar(ADM: Tdm);
    class procedure Release;
    class function ProdutoService: IProdutoService;
    class function ClienteService: IClienteService;
  end;

implementation

uses
  uProdutoService, uProdutoRepository,
  uClienteService, uClienteRepository;

class procedure TServiceFactory.Inicializar(ADM: Tdm);
begin
  if FInicializado then
    Exit;

  FProdutoService := TProdutoService.Create(
    TProdutoRepository.Create(ADM)
  );

  FClienteService := TClienteService.Create(
    TClienteRepository.Create(ADM)
  );

  FInicializado := True;
end;

class procedure TServiceFactory.Release;
begin
  FProdutoService := nil;
  FClienteService := nil;
  FInicializado := False;
end;

class function TServiceFactory.ProdutoService: IProdutoService;
begin
  Result := FProdutoService;
end;

class function TServiceFactory.ClienteService: IClienteService;
begin
  Result := FClienteService;
end;

end.
