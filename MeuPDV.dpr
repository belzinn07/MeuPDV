program MeuPDV;

uses
  Vcl.Forms,
  MeuPDV.FormPrincipal.View in 'src\view\MeuPDV.FormPrincipal.View.pas' {FormPrincipal},
  MeuPDV.DMConexao.infra in 'src\infra\MeuPDV.DMConexao.infra.pas' {dmConexao: TDataModule},
  MeuPDV.FormClientes.View in 'src\view\MeuPDV.FormClientes.View.pas' {FormClientes},
  Estilos in 'src\view\Styles\Estilos.pas',
  MeuPDV.FormProdutos.View in 'src\view\MeuPDV.FormProdutos.View.pas' {FormProdutos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormProdutos, FormProdutos);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TFormClientes, FormClientes);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
