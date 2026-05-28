unit MeuPDV.PessoaFisica.Model;

interface

uses
  MeuPDV.Pessoa.Model, MeuPDV.Validador.Contracts, MeuPDV.Validador.Utils, System.SysUtils;
type
 TPessoaFisica= class(TPessoa,IValidador)

 private
  FCpf: string;
 public
  procedure Validar;

  property Cpf : string read FCpf write FCpf;
 end;

implementation

{ TPessoaFisica }

procedure TPessoaFisica.Validar;
begin
    ValidarCampo(Trim(FCpf)<> '', 'CPF é obrigatório');
    ValidarCampo(Length(FCpf)<>'', '')
end;



end.
