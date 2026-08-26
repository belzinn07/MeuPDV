unit FormProdutos.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, Estilos,
  IProduto.Service, Produto.Service, IProduto.Repository, Produto.Repository,
  DMConexao.infra, Produto.Model, Validador.Utils, Produto.DTO;

type
  TfrmProdutos = class(TForm)
    pnlGeral: TPanel;
    pnlCabecalho: TPanel;
    SpeedButton1: TSpeedButton;
    ImageList1: TImageList;
    edtDescricao: TLabeledEdit;
    edtPreco: TLabeledEdit;
    edtEstoque: TLabeledEdit;
    bntSalvar: TBitBtn;
    edtCodigo: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure bntSalvarClick(Sender: TObject);

  private
    FProdutoDTO : TProdutoDTO;
    FProdutoService : IProdutoService;
    procedure AplicarEstilos;

    { Private declarations }
  public
    procedure PrepararEdicao(Aid : Integer);
    procedure PrepararCadastro;
  end;

var
  frmProdutos: TfrmProdutos;

implementation

{$R *.dfm}

procedure TfrmProdutos.PrepararCadastro;
begin
  FreeAndNil(FProdutoDTO);
  FProdutoDTO := TProdutoDTO.Create;

 edtCodigo.Text := 'Novo';
 edtDescricao.Clear;
 edtPreco.Clear;
 edtEstoque.Clear;

 FProdutoDTO.Id := 0;
end;

procedure TfrmProdutos.PrepararEdicao(Aid : Integer);
begin
FProdutoDTO := FProdutoService.BuscarPorId(Aid);
edtCodigo.Text := IntToStr(FProdutoDTO.Id);
edtDescricao.Text := FProdutoDTO.Descricao;
edtPreco.Text :=  FProdutoDTO.Preco;
edtEstoque.Text := FProdutoDTO.Saldo;

end;

procedure TfrmProdutos.bntSalvarClick(Sender: TObject);
var
  Produto: TProdutoDTO;
begin
  Produto := TProdutoDTO.Create;
  try
    Produto.Descricao := edtDescricao.Text;
    Produto.Preco := edtPreco.Text;
    Produto.Saldo := edtEstoque.Text;

    if Assigned(FProdutoDTO) then
      Produto.Id := FProdutoDTO.Id
    else
      Produto.Id := 0;

    FProdutoService.Salvar(Produto);

    ShowMessage('Salvo com sucesso!' + sLineBreak +
                'Código : ' + Produto.Id.ToString);

    ModalResult := mrOk;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;

  Produto.Free;
end;
procedure TfrmProdutos.FormCreate(Sender: TObject);
var
 Repository: IProdutoRepository;

begin

  Repository := TProdutoRepository.Create(dm);
  FProdutoService := TProdutoService.Create(Repository);
  AplicarEstilos;

end;

procedure TfrmProdutos.AplicarEstilos;
begin
  pnlCabecalho.Color := COR_CABECALHO_AZUL;
  pnlGeral.Color := COR_FUNDO_CLARO;
  SpeedButton1.Flat := True;
  SpeedButton1.Font.Color := COR_TEXTO_BRANCO;
end;

end.
