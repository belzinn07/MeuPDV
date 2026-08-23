unit FormProdutos.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, Estilos,
  IProduto.Service, Produto.Service, IProduto.Repository, Produto.Repository,
  DMConexao.infra, Produto.Model, Validador.Utils;

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
    FProduto : TProduto;
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

 edtCodigo.Text := 'Novo';
 edtDescricao.Clear;
 edtPreco.Clear;
 edtEstoque.Clear;

 FProduto.Id := 0;
end;

procedure TfrmProdutos.PrepararEdicao(Aid : Integer);
begin
FProduto := FProdutoService.BuscarPorId(Aid);
edtCodigo.Text := IntToStr(FProduto.Id);
edtDescricao.Text := FProduto.Descricao;
edtPreco.Text := CurrToStr(FProduto.Preco);
edtEstoque.Text := FloatToStr(FProduto.Saldo);

end;

procedure TfrmProdutos.bntSalvarClick(Sender: TObject);
var

Produto : TProduto;

begin
try
Produto := TProduto.Create;

Produto.Descricao := edtDescricao.Text;



Produto.Preco := StrToCurr(edtPreco.Text);
Produto.Saldo := StrToFloat(edtEstoque.Text);
try
  if Assigned(FProduto) then
      Produto.Id := FProduto.Id
    else
      Produto.Id := 0;

FProdutoService.Salvar(Produto);
ShowMessage('Salvo com sucesso!');
ModalResult := mrOk;

except
   on E: Exception do
      begin
        ShowMessage(E.Message);
        Exit;
      end;
end;
finally
  Produto.Free;
end;

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
