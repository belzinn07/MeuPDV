unit FrmProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList,   Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, uEstilos,
  uIProdutoService, uProduto, uValidadorUtils, uProdutoDTO,
  uServiceFactory;

type
  TFrmProdutos = class(TForm)
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
  FormProdutos: TFrmProdutos;

implementation

{$R *.dfm}

procedure TFrmProdutos.PrepararCadastro;
begin
  FreeAndNil(FProdutoDTO);
  FProdutoDTO := TProdutoDTO.Create;

 edtCodigo.Text := 'Novo';
 edtDescricao.Clear;
 edtPreco.Clear;
 edtEstoque.Clear;

 FProdutoDTO.Id := 0;
end;

procedure TFrmProdutos.PrepararEdicao(Aid : Integer);
begin
FProdutoDTO := FProdutoService.BuscarPorId(Aid);
edtCodigo.Text := IntToStr(FProdutoDTO.Id);
edtDescricao.Text := FProdutoDTO.Descricao;
edtPreco.Text :=  FProdutoDTO.Preco;
edtEstoque.Text := FProdutoDTO.Saldo;

end;

procedure TFrmProdutos.bntSalvarClick(Sender: TObject);
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
                'C�digo : ' + Produto.Id.ToString);

    ModalResult := mrOk;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;

  Produto.Free;
end;
procedure TFrmProdutos.FormCreate(Sender: TObject);
begin

  FProdutoService := TServiceFactory.ProdutoService;
  AplicarEstilos;

end;

procedure TFrmProdutos.AplicarEstilos;
begin
  pnlCabecalho.Color := COR_CABECALHO_AZUL;
  pnlGeral.Color := COR_FUNDO_CLARO;
  SpeedButton1.Flat := True;
  SpeedButton1.Font.Color := COR_TEXTO_BRANCO;
end;

end.
