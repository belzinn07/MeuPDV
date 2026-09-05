unit uVendaService;

interface

uses
  uIVendaService,
  uVendaDTO,
  uItemVendaDTO,
  uIVendaRepository,
  uIValidador,
  System.Generics.Collections,
  System.SysUtils;

type
  TVendaService = class(TInterfacedObject, IVendaService)

  private
    FRepository : IVendaRepository;
    FValidadorVenda : IValidador<TVendaDTO>;
    procedure ValidarItens(const AVendaDTO: TVendaDTO; var ItemDTO: TItemVendaDTO);
    procedure CalcularTotal(const AVendaDTO: TVendaDTO; var ItemDTO: TItemVendaDTO; var Total: Currency);

  public
    constructor Create(ARepository: IVendaRepository);
    procedure Salvar(const AVendaDTO: TVendaDTO);
  end;

implementation

uses
  uVendaRepository,
  uVenda,
  uItemVenda,
  uVendaMapper,
  uVendaValidador,
  uItemVendaValidador;

{ TVendaService }

constructor TVendaService.Create(ARepository: IVendaRepository);
begin
  FRepository := ARepository;
  FValidadorVenda := TVendaValidador.Create;
end;

procedure TVendaService.Salvar(const AVendaDTO: TVendaDTO);
var
  ItemDTO : TItemVendaDTO;
  Item : TItemVenda;
  Itens : TObjectList<TItemVenda>;
  Venda : TVenda;
  Total : Currency;

begin
  FValidadorVenda.Validar(AVendaDTO);
  ValidarItens(AVendaDTO, ItemDTO);
  CalcularTotal(AVendaDTO, ItemDTO, Total);

  AVendaDTO.Data := Now;
  AVendaDTO.Total := Total;

  Venda := TVendaMapper.ConverterParaEntidade(AVendaDTO);

  try
    try
      Itens := TObjectList<TItemVenda>.Create(True);
      try
        for ItemDTO in AVendaDTO.Itens do
          Itens.Add(TVendaMapper.ConverterItemParaEntidade(ItemDTO));

        FRepository.SalvarVendaComItens(Venda, Itens);
      finally
        Itens.Free;
      end;
    finally
      Venda.Free;
    end;
  except
    on E: Exception do
    begin
      raise Exception.CreateFmt(
        'Erro ao salvar venda, nenhum dado foi gravado: %s', [E.Message]);
    end;
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
      raise Exception.CreateFmt('Item %d da venda inválido: %s', [ItemAtual, Exception(ExceptObject).Message]);
    end;
  end;
end;

end.