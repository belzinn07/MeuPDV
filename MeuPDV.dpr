program MeuPDV;

uses
  Vcl.Forms,
  FormPrincipal.View in 'src\view\FormPrincipal.View.pas' {FormPrincipal: TFormPrincipal},
  DMConexao.infra in 'src\infra\DMConexao.infra.pas' {dmConexao: TDataModule},
  FormClientes.View in 'src\view\FormClientes.View.pas' {FormClientes: TFormClientes},
  Estilos in 'src\view\Styles\Estilos.pas',
  FormProdutos.View in 'src\view\FormProdutos.View.pas' {FormProdutos: TFormProdutos},
  FormBaseListagem.View in 'src\view\FormBaseListagem.View.pas' {frmBaseListagem: TfrmBaseListagem},
  ListaClientes.View in 'src\view\ListaClientes.View.pas' {frmListaClientes: TfrmListaClientes},
  ListaProdutos.View in 'src\view\ListaProdutos.View.pas' {frmListaProdutos: TfrmListaProdutos},
  FormVenda.View in 'src\view\FormVenda.View.pas' {frmVendas: TfrmVendas},
  FormInicialVenda.View in 'src\view\FormInicialVenda.View.pas' {FormInicialVenda: TFormInicialVenda},
  Produto.Model in 'src\domain\model\Produto.Model.pas',
  Validador.Contracts in 'src\domain\contracts\Validador.Contracts.pas',
  Validador.Utils in 'src\utils\Validador.Utils.pas',
  Produto.Repository in 'src\repository\Produto.Repository.pas',
  IProduto.Repository in 'src\repository\interfaces\IProduto.Repository.pas',
  IProduto.Service in 'src\service\interfaces\IProduto.Service.pas',
  Produto.Service in 'src\service\Produto.Service.pas',
  Cliente.Model in 'src\domain\model\Cliente.Model.pas',
  Produto.Validation in 'src\domain\validation\Produto.Validation.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, frmPrincipal);
  Application.CreateForm(TfrmListaClientes, frmListaClientes);
  Application.CreateForm(TFormClientes, frmClientes);
  Application.CreateForm(TdmConexao, dm);
  Application.CreateForm(TfrmListaProdutos, frmListaProdutos);
  Application.CreateForm(TFormInicialVenda, frmInicialVenda);
  Application.CreateForm(TfrmVendas, frmVendas);
  Application.CreateForm(TFormProdutos, frmProdutos);
  Application.CreateForm(TfrmBaseListagem, frmBaseListagem);
  Application.Run;
end.
