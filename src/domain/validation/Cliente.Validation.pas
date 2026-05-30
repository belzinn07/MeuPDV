unit Cliente.Validation;

interface

uses
  Validador.Contracts, Cliente.Model, System.RegularExpressions, Validador.Utils, System.SysUtils;
type
  TClienteValidador = class(TInterfacedObject, IValidador<TCliente>)

    private
     function EmailValido(const AEmail: string): Boolean;
     function CPFValido(const ACpf : string): Boolean;
    public
      procedure Validar(ACliente: TCliente);

  end;

implementation

{ TClienteValidador }

function TClienteValidador.CPFValido(const ACpf: string): Boolean;
var
 NumCPF: string;
 CPF: Char;

begin
Result:= False;

  NumCPF := StringReplace(ACPF, '.', '', [rfReplaceAll]);
  NumCPF := StringReplace(NumCPF, '-', '', [rfReplaceAll]);
  NumCPF := StringReplace(NumCPF, '/', '', [rfReplaceAll]);

  if Length(NumCPF) <> 11 then Exit(False);

  for CPF in NumCPF  do
  begin
     if not CharInSet(CPF, ['0'..'9']) then Exit(False)
  end;

Result := True;
end;

function TClienteValidador.EmailValido(const AEmail: string): Boolean;
begin

   if AEmail = '' then
    Exit(False);

Result := TRegEx.IsMatch(AEmail,'^[^\s@]+@[^\s@]+\.[^\s@]+$', [roCompiled]);

end;

procedure TClienteValidador.Validar(ACliente: TCliente);
begin
   ValidarCampo(Trim(ACliente.Nome)<> '', 'Nome é obrigatório');
   ValidarCampo(Trim(ACliente.CPF)<> '', 'CPF é obrigatório');
   ValidarCampo(CPFValido((ACliente.CPF)), 'CPF inválido');
   ValidarCampo(EmailValido(Trim(ACliente.Email)), 'Email inválido ou não informado');

end;

end.
