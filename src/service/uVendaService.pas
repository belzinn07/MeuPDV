unit uVendaService;

interface

uses
  uIVendaRepository, uVendaDTO, uItemVendaDTO, uIValidador,
  uItemVendaValidador, uLogger, System.SysUtils;

type
 TVendaService = class

  private
   FRepository : IVendaRepository;
   procedure ValidarItens(AVendaDTO : TVendaDTO);

  public
   constructor Create(ARepository : IVendaRepository);
   procedure Salvar(const AVendaDTO: TVendaDTO);

 end;

implementation

{ TVendaService }

constructor TVendaService.Create(ARepository: IVendaRepository);
begin
  FRepository := ARepository;
end;

procedure TVendaService.Salvar(const AVendaDTO: TVendaDTO);
var
 Validador : IValidador<TItemVendaDTO>;
 Venda : TVendaDTO;

begin
TLogger.Info('VendaService.Salvar', Format('Salvando venda. ID = ',[]));


end;

procedure TVendaService.ValidarItens(AVendaDTO: TVendaDTO);
var
  Item: TItemVendaDTO;
  Validador : IValidador<TItemVendaDTO>;

begin
  Validador := TItemVendaValidador.Create;

  for Item in AVendaDTO.Itens do
   Validador.Validar(Item);

end;

end.
