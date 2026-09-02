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
  ItemValidador : IValidador<TItemVendaDTO>;
  ItemDTO : TItemVendaDTO;
  Item : TItemVenda;
  Itens : TObjectList<TItemVenda>;
  Venda : TVenda;
  Total : Currency;
  ItemAtual : Integer;

begin
  FValidadorVenda.Validar(AVendaDTO);

  ItemValidador := TItemVendaValidador.Create;
  ItemAtual := 0;
  for ItemDTO in AVendaDTO.Itens do
  begin
    Inc(ItemAtual);
    try
      ItemValidador.Validar(ItemDTO);
    except
      raise Exception.CreateFmt('Item %d da venda inválido: %s',
        [ItemAtual, Exception(ExceptObject).Message]);
    end;
  end;

  Total := 0;
  for ItemDTO in AVendaDTO.Itens do
    Total := Total +
      (StrToInt(ItemDTO.Quantidade) * StrToFloat(ItemDTO.ValorUnitario));

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

end.