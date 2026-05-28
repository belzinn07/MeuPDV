unit MeuPDV.Pessoa.Model;

interface

uses
  MeuPDV.Validador.Contracts, MeuPDV.Validador.Utils, System.SysUtils;
type
 TPessoa = class(TInterfacedObject, IValidador)

 private
  FId : Integer;
  FNome: string;

 public
 procedure Validar;
 property Id: Integer read FId write FId;
 property Nome: string read FNome write FNome;

 end;

implementation

{ TPessoa }

procedure TPessoa.Validar;
begin

ValidarCampo(Trim(FNome)<> '', 'Nome é um campo obrigatório');

end;

end.
