program MeuPDV;

uses
  Vcl.Forms,
  MeuPDV.FormPrincipal.View in 'src\view\MeuPDV.FormPrincipal.View.pas' {FormPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
