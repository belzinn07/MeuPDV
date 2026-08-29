unit uClienteValidador;

interface

uses
  uIValidador, uCliente, System.RegularExpressions, uValidadorUtils, System.SysUtils,
  uValidadorDocumentos, uTipoPessoa, uClienteDTO;
type
  TClienteValidador = class(TInterfacedObject, IValidador<TClienteDTO>)

    private
     function EmailValido(const AEmail: string): Boolean;
    public
      procedure Validar(ACliente: TClienteDTO);

  end;

implementation

{ TClienteValidador }

function TClienteValidador.EmailValido(const AEmail: string): Boolean;
begin

Result := TRegEx.IsMatch(AEmail,'^[^\s@]+@[^\s@]+\.[^\s@]+$', [roCompiled]);

end;

procedure TClienteValidador.Validar(ACliente: TClienteDTO);
begin
   ValidarCampo(Trim(ACliente.Nome)<> '', 'Nome � obrigat�rio');
   ValidarCampo(EmailValido(Trim(ACliente.Email)), 'Email inv�lido');

   case ACliente.TipoPessoa of

   tpFisica:
   begin
      ValidarCampo(Trim(ACliente.CPF)<> '', 'CPF � obrigat�rio');
      ValidarCampo(TValidadorDocumentos.ValidarDocumento(Trim(ACliente.CPF), 11) , 'CPF inv�lido');
   end;

   tpJuridica:
   begin
      ValidarCampo(Trim(ACliente.CNPJ)<> '', 'CNPJ � obrigat�rio' );
      ValidarCampo(TValidadorDocumentos.ValidarDocumento(Trim(ACliente.CNPJ),14), 'CNPJ inv�lido');
      ValidarCampo(TValidadorDocumentos.ValidarDocumento(Trim(ACliente.IE), 9), 'IE do cliente inv�lida');
   end;
   end;

end;

end.
