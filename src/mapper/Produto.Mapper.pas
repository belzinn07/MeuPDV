unit Produto.Mapper;

interface

uses
  Produto.DTO,
  Produto.Model,
  System.SysUtils;

type
  TProdutoMapper = class
  public
    class function ConverterParaDto(AProduto: TProduto): TProdutoDTO;
    class function ConverterParaEntidade(AProdutoDto: TProdutoDTO): TProduto;
  end;

implementation

class function TProdutoMapper.ConverterParaDto(AProduto: TProduto): TProdutoDTO;
begin
  Result := TProdutoDTO.Create;

  Result.Id := AProduto.Id;
  Result.Descricao := AProduto.Descricao;
  Result.Preco := CurrToStr(AProduto.Preco);
  Result.Saldo := FloatToStr(AProduto.Saldo);
end;

class function TProdutoMapper.ConverterParaEntidade(AProdutoDto: TProdutoDTO): TProduto;
begin
  Result := TProduto.Create;

  Result.Id := AProdutoDto.Id;
  Result.Descricao := AProdutoDto.Descricao;
  Result.Preco := StrToCurr(AProdutoDto.Preco);
  Result.Saldo := StrToFloat(AProdutoDto.Saldo);
end;

end.
