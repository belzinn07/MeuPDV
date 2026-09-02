unit uServiceFactory;

interface

uses
  uIProdutoService, uIClienteService, uIVendaService, uDMConexao;

type
  TServiceFactory = class
  private
    class var FProdutoService: IProdutoService;
    class var FClienteService: IClienteService;
    class var FVendaService: IVendaService;
    class var FInicializado: Boolean;
  public
    class procedure Inicializar(ADM: Tdm);
    class procedure Release;
    class function ProdutoService: IProdutoService;
    class function ClienteService: IClienteService;
    class function VendaService: IVendaService;
  end;

implementation

uses
  uProdutoService, uProdutoRepository,
  uClienteService, uClienteRepository,
  uVendaService, uVendaRepository;

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

  FVendaService := TVendaService.Create(
    TVendaRepository.Create(ADM)
  );

  FInicializado := True;
end;

class procedure TServiceFactory.Release;
begin
  FProdutoService := nil;
  FClienteService := nil;
  FVendaService := nil;
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

class function TServiceFactory.VendaService: IVendaService;
begin
  Result := FVendaService;
end;

end.
