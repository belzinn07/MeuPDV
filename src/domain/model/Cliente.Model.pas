unit Cliente.Model;

interface

type
 TCliente = class

 private
  FId : Integer;
  FNome: string;
  FCPF: string;
  FCNPJ: string;
  FTelefone: string;
  FEmail: string;

 public
 property Id: Integer read FId write FId;
 property Nome: string read FNome write FNome;
 property CPF: string read FCPF write FCPF;
 property Cnpj: string read FCNPJ write FCNPJ;
 property Telefone: string read FTelefone write FTelefone;
 property Email: string  read FEmail write FEmail;

 end;

implementation

{ TPessoa }

end.
