program MeuPDV;

uses
  Vcl.Forms,
  FrmPrincipal in 'src\view\FrmPrincipal.pas' {FormPrincipal: TFormPrincipal},
  uDMConexao in 'src\infra\uDMConexao.pas' {dm: TDataModule},
  FrmClientes in 'src\view\FrmClientes.pas' {FormClientes: TFormClientes},
  uEstilos in 'src\view\Styles\uEstilos.pas',
  FrmProdutos in 'src\view\FrmProdutos.pas' {FormProdutos: TFormProdutos},
  FrmBaseListagem in 'src\view\FrmBaseListagem.pas' {frmBaseListagem: TfrmBaseListagem},
  FrmListaClientes in 'src\view\FrmListaClientes.pas' {FormListaClientes: TfrmListaClientes},
  FrmListaProdutos in 'src\view\FrmListaProdutos.pas' {FormListaProdutos: TfrmListaProdutos},
  FrmVenda in 'src\view\FrmVenda.pas' {frmVendas: TfrmVendas},
  FrmInicialVenda in 'src\view\FrmInicialVenda.pas' {FormInicialVenda: TFormInicialVenda},
  uProduto in 'src\domain\model\uProduto.pas',
  uIValidador in 'src\domain\contracts\uIValidador.pas',
  uValidadorUtils in 'src\utils\uValidadorUtils.pas',
  uProdutoRepository in 'src\repository\uProdutoRepository.pas',
  uIProdutoRepository in 'src\repository\interfaces\uIProdutoRepository.pas',
  uIProdutoService in 'src\service\interfaces\uIProdutoService.pas',
  uProdutoService in 'src\service\uProdutoService.pas',
  uCliente in 'src\domain\model\uCliente.pas',
  uProdutoValidador in 'src\domain\validation\uProdutoValidador.pas',
  uClienteValidador in 'src\domain\validation\uClienteValidador.pas',
  uValidadorDocumentos in 'src\utils\uValidadorDocumentos.pas',
  uTipoPessoa in 'src\domain\model\enums\uTipoPessoa.pas',
  uIClienteRepository in 'src\repository\interfaces\uIClienteRepository.pas',
  uClienteRepository in 'src\repository\uClienteRepository.pas',
  uIClienteService in 'src\service\interfaces\uIClienteService.pas',
  uClienteService in 'src\service\uClienteService.pas',
  uLogger in 'src\utils\Logger\uLogger.pas',
  uLogTipo in 'src\utils\Logger\uLogTipo.pas',
  uDocumentoUtils in 'src\utils\uDocumentoUtils.pas',
  uProdutoDTO in 'src\dto\uProdutoDTO.pas',
  uProdutoMapper in 'src\mapper\uProdutoMapper.pas',
  uServiceFactory in 'src\service\uServiceFactory.pas',
  uClienteDTO in 'src\dto\uClienteDTO.pas',
  uClienteMapper in 'src\mapper\uClienteMapper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  TServiceFactory.Inicializar(dm);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
