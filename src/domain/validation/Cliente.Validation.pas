unit Cliente.Validation;

interface

uses
  Validador.Contracts, Cliente.Model, System.RegularExpressions, Validador.Utils, System.SysUtils,
  ValidadorDocumentos.Utils, TipoPessoa.Enums.Model;
type
  TClienteValidador = class(TInterfacedObject, IValidador<TCliente>)

    private
     function EmailValido(const AEmail: string): Boolean;
    public
      procedure Validar(ACliente: TCliente);

  end;

implementation

{ TClienteValidador }

function TClienteValidador.EmailValido(const AEmail: string): Boolean;
begin

Result := TRegEx.IsMatch(AEmail,'^[^\s@]+@[^\s@]+\.[^\s@]+$', [roCompiled]);

end;

procedure TClienteValidador.Validar(ACliente: TCliente);
begin
   ValidarCampo(Trim(ACliente.Nome)<> '', 'Nome é obrigatório');
   ValidarCampo(EmailValido(Trim(ACliente.Email)), 'Email inválido');

   case ACliente.TipoPessoa of

   tpFisica:
   begin
      ValidarCampo(Trim(ACliente.CPF)<> '', 'CPF é obrigatório');
      ValidarCampo(TValidadorDocumentos.ValidarDocumento(Trim(ACliente.CPF), 11) , 'CPF inválido');
   end;

   tpJuridica:
   begin
      ValidarCampo(Trim(ACliente.CNPJ)<> '', 'CNPJ é obrigatório');
      ValidarCampo(TValidadorDocumentos.ValidarDocumento(Trim(ACliente.CNPJ),14), 'CNPJ inválido');
      ValidarCampo(TValidadorDocumentos.ValidarDocumento(Trim(ACliente.IE), 9), 'IE do cliente inválida');
   end;
   end;



end;

end.
