unit uCliente;

interface

uses uTipoPessoa;

type

 TCliente = class

 private
  FId : Integer;
  FNome: string;
  FCPF: string;
  FCNPJ: string;
  FTipoPessoa: TTipoPessoa;
  FTelefone: string;
  FEmail: string;
  FInscricaoEstadual: string;

 public
 property Id: Integer read FId write FId;
 property Nome: string read FNome write FNome;
 property CPF: string read FCPF write FCPF;
 property CNPJ: string read FCNPJ write FCNPJ;
 property TipoPessoa: TTipoPessoa read FTipoPessoa write FTipoPessoa;
 property Telefone: string read FTelefone write FTelefone;
 property Email: string  read FEmail write FEmail;
 property IE:string read FInscricaoEstadual write FInscricaoEstadual;

 end;

implementation

{ TPessoa }

end.
