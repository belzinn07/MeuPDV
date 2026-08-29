unit uClienteDTO;

interface

uses
  uTipoPessoa;

type
  TClienteDTO = class
  public
    Id: Integer;
    Nome: string;
    CPF: string;
    CNPJ: string;
    TipoPessoa: TTipoPessoa;
    Telefone: string;
    Email: string;
    IE: string;
  end;

implementation

end.
