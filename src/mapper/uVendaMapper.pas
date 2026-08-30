unit uVendaMapper;

interface

uses
  uVendaDTO,
  uItemVendaDTO,
  uVenda,
  uItemVenda,
  System.SysUtils;

type
  TVendaMapper = class
  public
    class function ConverterParaDto(AVenda: TVenda): TVendaDTO;
    class function ConverterParaEntidade(AVendaDto: TVendaDTO): TVenda;

    class function ConverterItemParaDto(AItemVenda: TItemVenda): TItemVendaDTO;
    class function ConverterItemParaEntidade(AItemVendaDto: TItemVendaDTO): TItemVenda;
  end;

implementation

class function TVendaMapper.ConverterParaDto(AVenda: TVenda): TVendaDTO;
begin
  Result := TVendaDTO.Create;

  Result.Id := AVenda.Id;
  Result.IdCliente := IntToStr(AVenda.IdCliente);
  Result.Data := AVenda.Data;
  Result.Total := AVenda.Total;
end;

class function TVendaMapper.ConverterParaEntidade(AVendaDto: TVendaDTO): TVenda;
begin
  Result := TVenda.Create;

  Result.Id := AVendaDto.Id;
  Result.IdCliente := StrToInt(AVendaDto.IdCliente);
  Result.Data := AVendaDto.Data;
  Result.Total := AVendaDto.Total;
end;

class function TVendaMapper.ConverterItemParaDto(AItemVenda: TItemVenda): TItemVendaDTO;
begin
  Result := TItemVendaDTO.Create;

  Result.Id := AItemVenda.Id;
  Result.IdVenda := AItemVenda.IdVenda;
  Result.IdProduto := IntToStr(AItemVenda.IdProduto);
  Result.Quantidade := IntToStr(AItemVenda.Quantidade);
  Result.ValorUnitario := CurrToStr(AItemVenda.ValorUnitario);
end;

class function TVendaMapper.ConverterItemParaEntidade(AItemVendaDto: TItemVendaDTO): TItemVenda;
begin
  Result := TItemVenda.Create;

  Result.Id := AItemVendaDto.Id;
  Result.IdVenda := AItemVendaDto.IdVenda;
  Result.IdProduto := StrToInt(AItemVendaDto.IdProduto);
  Result.Quantidade := StrToInt(AItemVendaDto.Quantidade);
  Result.ValorUnitario := StrToCurr(AItemVendaDto.ValorUnitario);
end;

end.