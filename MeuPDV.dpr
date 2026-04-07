program MeuPDV;

uses
  Vcl.Forms,
  MeuPDV.FormPrincipal.View in 'src\view\MeuPDV.FormPrincipal.View.pas' {FormPrincipal},
  MeuPDV.DMConexao.infra in 'src\infra\MeuPDV.DMConexao.infra.pas' {dmConexao: TDataModule},
  MeuPDV.FormClientes.View in 'src\view\MeuPDV.FormClientes.View.pas' {FormClientes},
  Estilos in 'src\view\Styles\Estilos.pas',
  MeuPDV.FormProdutos.View in 'src\view\MeuPDV.FormProdutos.View.pas' {FormProdutos},
  MeuPDV.FormBaseListagem.View in 'src\view\MeuPDV.FormBaseListagem.View.pas' {frmBaseListagem},
  MeuPDV.ListaClientes.View in 'src\view\MeuPDV.ListaClientes.View.pas' {frmListaClientes},
  MeuPDV.ListaProdutos.View in 'src\view\MeuPDV.ListaProdutos.View.pas' {frmListaProdutos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TFormProdutos, FormProdutos);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TFormClientes, FormClientes);
  Application.CreateForm(TfrmBaseListagem, frmBaseListagem);
  Application.CreateForm(TfrmListaClientes, frmListaClientes);
  Application.CreateForm(TfrmListaProdutos, frmListaProdutos);
  Application.Run;
end.
