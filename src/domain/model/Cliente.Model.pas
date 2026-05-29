unit Cliente.Model;

interface

type
 TCliente = class

 private
  FId : Integer;
  FNome: string;
  FCpf: string;
  FCnpj: string;
  FTelefone: string;
  FEmail: string;

 public
 property Id: Integer read FId write FId;
 property Nome: string read FNome write FNome;
 property Cpf: string read FCpf write FCpf;
 property Cnpj: string read FCnpj write FCnpj;
 property Telefone: string read FTelefone write FTelefone;
 property Email: string  read FEmail write FEmail;

 end;

implementation

{ TPessoa }

{
procedure TCliente.Validar;
begin

ValidarCampo(Trim(FNome)<> '', 'Nome é um campo obrigatório');
ValidarCampo(EmailValido(Trim(FEmail)), 'Email inválido ou não informado');

end;

function TCliente.EmailValido(const AEmail: string): Boolean;
begin
   if AEmail = '' then
    Exit(False);

Result := TRegEx.IsMatch(AEmail,'^[^\s@]+@[^\s@]+\.[^\s@]+$', [roCompiled]);

end;

  }


end.
