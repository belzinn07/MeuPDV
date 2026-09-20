unit uVendaService;

interface

uses
  uIVendaService,
  uVendaDTO,
  uItemVendaDTO,
  uIVendaRepository,
  uIValidador,
  System.Generics.Collections,
  System.SysUtils,
  uVendaRepository,
  uVenda,
  uItemVenda,
  uVendaMapper,
  uVendaValidador,
  uItemVendaValidador;

type
  TVendaService = class(TInterfacedObject, IVendaService)

  private
    FRepository : IVendaRepository;
    FValidadorVenda : IValidador<TVendaDTO>;
    procedure ValidarItens(const AVendaDTO: TVendaDTO; var ItemDTO: TItemVendaDTO);
    procedure CalcularTotal(const AVendaDTO: TVendaDTO; var ItemDTO: TItemVendaDTO; var Total: Currency);

  public
    constructor Create(ARepository: IVendaRepository);
    procedure Salvar(AVendaDTO: TVendaDTO);
    function BuscarProximaFatura: Integer;
    function BuscarPorId(AId: Integer): TVendaDTO;

  end;

implementation

{ TVendaService }

constructor TVendaService.Create(ARepository: IVendaRepository);
begin
  FRepository := ARepository;
  FValidadorVenda := TVendaValidador.Create;
end;

function TVendaService.BuscarProximaFatura: Integer;
begin
  Result := FRepository.BuscarProximaFatura;
end;

procedure TVendaService.Salvar( AVendaDTO: TVendaDTO);
var
  ItemDTO : TItemVendaDTO;
  Itens : TObjectList<TItemVenda>;
  Venda : TVenda;
  Total : Currency;

begin
  FValidadorVenda.Validar(AVendaDTO);
  ValidarItens(AVendaDTO, ItemDTO);
  CalcularTotal(AVendaDTO, ItemDTO, Total);
  AVendaDTO.Total := Total;

  if AVendaDTO.Id = 0 then
    AVendaDTO.Data := Now;

  Venda := TVendaMapper.ConverterParaEntidade(AVendaDTO);
  try
    try
      Itens := TObjectList<TItemVenda>.Create(True);
      try
        for ItemDTO in AVendaDTO.Itens do
          Itens.Add(TVendaMapper.ConverterItemParaEntidade(ItemDTO));

        if AVendaDTO.Id = 0 then
        begin
          FRepository.SalvarVendaComItens(Venda, Itens);
          AVendaDTO.Id := Venda.Id;
        end
        else
          FRepository.AtualizarVendaComItens(Venda, Itens);

      finally
        Itens.Free;
      end;
    finally
      Venda.Free;
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt('Erro ao salvar venda, nenhum dado foi gravado: %s', [E.Message]);
  end;
end;

procedure TVendaService.CalcularTotal(const AVendaDTO: TVendaDTO; var ItemDTO: TItemVendaDTO; var Total: Currency);
var
  Local_ItemDTO: TItemVendaDTO;
begin
  Total := 0;
  for Local_ItemDTO in AVendaDTO.Itens do
    Total := Total + (StrToInt(Local_ItemDTO.Quantidade) * StrToFloat(Local_ItemDTO.ValorUnitario));
end;

procedure TVendaService.ValidarItens(const AVendaDTO: TVendaDTO; var ItemDTO: TItemVendaDTO);
var
  ItemValidador: uIValidador.IValidador<TItemVendaDTO>;
  ItemAtual: Integer;
  Local_ItemDTO: TItemVendaDTO;
begin
  ItemValidador := TItemVendaValidador.Create;
  ItemAtual := 0;
  for Local_ItemDTO in AVendaDTO.Itens do
  begin
    Inc(ItemAtual);
    try
      ItemValidador.Validar(Local_ItemDTO);
    except
      on E: Exception do
      raise Exception.CreateFmt('Item %d da venda inválido: %s', [ItemAtual, E.Message]);
end;
  end;
end;

function TVendaService.BuscarPorId(AId: Integer): TVendaDTO;
var
  Venda: TVenda;
begin
  Result := nil;

  Venda := FRepository.BuscarPorId(AId);
  if Venda = nil then
    Exit;

  try
    Result := TVendaMapper.ConverterParaDto(Venda);
  finally
    Venda.Free;
  end;
end;
end.