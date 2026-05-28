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
  MeuPDV.ListaProdutos.View in 'src\view\MeuPDV.ListaProdutos.View.pas' {frmListaProdutos},
  MeuPDV.FormVenda.View in 'src\view\MeuPDV.FormVenda.View.pas' {frmVendas},
  MeuPDV.FormInicialVenda.View in 'src\view\MeuPDV.FormInicialVenda.View.pas' {FormInicialVenda},
  MeuPDV.Produto.Model in 'src\domain\model\MeuPDV.Produto.Model.pas',
  MeuPDV.Validador.Contracts in 'src\domain\contracts\MeuPDV.Validador.Contracts.pas',
  MeuPDV.Validador.Utils in 'src\utils\MeuPDV.Validador.Utils.pas',
  MeuPDV.Produto.Repository in 'src\repository\MeuPDV.Produto.Repository.pas',
  MeuPDV.IProduto.Repository in 'src\repository\interfaces\MeuPDV.IProduto.Repository.pas',
  MeuPDV.IProduto.Service in 'src\service\interfaces\MeuPDV.IProduto.Service.pas',
  MeuPDV.Produto.Service in 'src\service\MeuPDV.Produto.Service.pas',
  MeuPDV.Pessoa.Model in 'src\domain\model\MeuPDV.Pessoa.Model.pas',
  MeuPDV.PessoaFisica.Model in 'src\domain\model\MeuPDV.PessoaFisica.Model.pas';

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
