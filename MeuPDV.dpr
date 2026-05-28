program MeuPDV;

uses
  Vcl.Forms,
  FormPrincipal.View in 'src\view\FormPrincipal.View.pas' {FormPrincipal},
  DMConexao.infra in 'src\infra\DMConexao.infra.pas' {dmConexao: TDataModule},
  FormClientes.View in 'src\view\FormClientes.View.pas' {FormClientes},
  Estilos in 'src\view\Styles\Estilos.pas',
  FormProdutos.View in 'src\view\FormProdutos.View.pas' {FormProdutos},
  FormBaseListagem.View in 'src\view\FormBaseListagem.View.pas' {frmBaseListagem},
  ListaClientes.View in 'src\view\ListaClientes.View.pas' {frmListaClientes},
  ListaProdutos.View in 'src\view\ListaProdutos.View.pas' {frmListaProdutos},
  FormVenda.View in 'src\view\FormVenda.View.pas' {frmVendas},
  FormInicialVenda.View in 'src\view\FormInicialVenda.View.pas' {FormInicialVenda},
  Produto.Model in 'src\domain\model\Produto.Model.pas',
  Validador.Contracts in 'src\domain\contracts\Validador.Contracts.pas',
  Validador.Utils in 'src\utils\Validador.Utils.pas',
  Produto.Repository in 'src\repository\Produto.Repository.pas',
  IProduto.Repository in 'src\repository\interfaces\IProduto.Repository.pas',
  IProduto.Service in 'src\service\interfaces\IProduto.Service.pas',
  Produto.Service in 'src\service\Produto.Service.pas',
  Pessoa.Model in 'src\domain\model\Pessoa.Model.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TfrmListaClientes, frmListaClientes);
  Application.CreateForm(TFormClientes, FormClientes);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TfrmListaProdutos, frmListaProdutos);
  Application.CreateForm(TFormInicialVenda, FormInicialVenda);
  Application.CreateForm(TfrmVendas, frmVendas);
  Application.CreateForm(TFormProdutos, FormProdutos);
  Application.CreateForm(TfrmBaseListagem, frmBaseListagem);
  Application.Run;
end.
