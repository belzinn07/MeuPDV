unit MeuPDV.Validador.Validation;

interface

uses
  System.SysUtils;

procedure ValidarCampo(Condicao: Boolean; const Mensagem: String);

implementation

procedure ValidarCampo(Condicao: Boolean; const Mensagem: String);
begin
  if not Condicao then
    raise Exception.Create(Mensagem);
end;

end.
