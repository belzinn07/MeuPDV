program MeuPDV;

uses
  Vcl.Forms,
  FormPrincipal.View in 'src\view\FormPrincipal.View.pas' {frmPrincipal: TFormPrincipal},
  DMConexao.infra in 'src\infra\DMConexao.infra.pas' {dm: TDataModule},
  FormClientes.View in 'src\view\FormClientes.View.pas' {frmClientes: TFormClientes},
  Estilos in 'src\view\Styles\Estilos.pas',
  FormProdutos.View in 'src\view\FormProdutos.View.pas' {frmProdutos: TFormProdutos},
  FormBaseListagem.View in 'src\view\FormBaseListagem.View.pas' {frmBaseListagem: TfrmBaseListagem},
  ListaClientes.View in 'src\view\ListaClientes.View.pas' {frmListaClientes: TfrmListaClientes},
  ListaProdutos.View in 'src\view\ListaProdutos.View.pas' {frmListaProdutos: TfrmListaProdutos},
  FormVenda.View in 'src\view\FormVenda.View.pas' {frmVendas: TfrmVendas},
  FormInicialVenda.View in 'src\view\FormInicialVenda.View.pas' {frmInicialVenda: TFormInicialVenda},
  Produto.Model in 'src\domain\model\Produto.Model.pas',
  Validador.Contracts in 'src\domain\contracts\Validador.Contracts.pas',
  Validador.Utils in 'src\utils\Validador.Utils.pas',
  Produto.Repository in 'src\repository\Produto.Repository.pas',
  IProduto.Repository in 'src\repository\interfaces\IProduto.Repository.pas',
  IProduto.Service in 'src\service\interfaces\IProduto.Service.pas',
  Produto.Service in 'src\service\Produto.Service.pas',
  Cliente.Model in 'src\domain\model\Cliente.Model.pas',
  Produto.Validation in 'src\domain\validation\Produto.Validation.pas',
  Cliente.Validation in 'src\domain\validation\Cliente.Validation.pas',
  ValidadorDocumentos.Utils in 'src\utils\ValidadorDocumentos.Utils.pas',
  TipoPessoa.Enums.Model in 'src\domain\model\enums\TipoPessoa.Enums.Model.pas',
  ICliente.Repository in 'src\repository\interfaces\ICliente.Repository.pas',
  Cliente.Repository in 'src\repository\Cliente.Repository.pas',
  ICliente.Service in 'src\service\interfaces\ICliente.Service.pas',
  Cliente.Service in 'src\service\Cliente.Service.pas',
  MeuPDV.Logger in 'src\utils\Logger\MeuPDV.Logger.pas',
  MeuPDV.LogTipo in 'src\utils\Logger\MeuPDV.LogTipo.pas',
  Documento.Utils in 'src\utils\Documento.Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmListaClientes, frmListaClientes);
  Application.CreateForm(TfrmClientes, frmClientes);
  Application.CreateForm(TfrmListaProdutos, frmListaProdutos);
  Application.CreateForm(TfrmInicialVenda, frmInicialVenda);
  Application.CreateForm(TfrmVendas, frmVendas);
  Application.CreateForm(TfrmProdutos, frmProdutos);
  Application.CreateForm(TfrmBaseListagem, frmBaseListagem);
  Application.Run;
end.
