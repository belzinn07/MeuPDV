unit uClienteMapper;

interface

uses
  uClienteDTO,
  uCliente;

type
  TClienteMapper = class
  public
    class function ConverterParaDto(ACliente: TCliente): TClienteDTO;
    class function ConverterParaEntidade(AClienteDto: TClienteDTO): TCliente;
  end;

implementation

class function TClienteMapper.ConverterParaDto(ACliente: TCliente): TClienteDTO;
begin
  Result := TClienteDTO.Create;

  Result.Id := ACliente.Id;
  Result.Nome := ACliente.Nome;
  Result.CPF := ACliente.CPF;
  Result.CNPJ := ACliente.CNPJ;
  Result.TipoPessoa := ACliente.TipoPessoa;
  Result.Telefone := ACliente.Telefone;
  Result.Email := ACliente.Email;
  Result.IE := ACliente.IE;
end;

class function TClienteMapper.ConverterParaEntidade(AClienteDto: TClienteDTO): TCliente;
begin
  Result := TCliente.Create;

  Result.Id := AClienteDto.Id;
  Result.Nome := AClienteDto.Nome;
  Result.CPF := AClienteDto.CPF;
  Result.CNPJ := AClienteDto.CNPJ;
  Result.TipoPessoa := AClienteDto.TipoPessoa;
  Result.Telefone := AClienteDto.Telefone;
  Result.Email := AClienteDto.Email;
  Result.IE := AClienteDto.IE;
end;

end.