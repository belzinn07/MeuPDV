unit FrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.Buttons, Vcl.ExtCtrls, uEstilos, Vcl.Imaging.pngimage,
  FrmListaProdutos, FrmListaClientes, FrmVenda, FrmBaseListagem,
  FrmInicialVenda;

type
  TFormPrincipal = class(TForm)
    pnlGeral: TPanel;
    pnlCabecalho: TPanel;
    btnClientes: TSpeedButton;
    ImageList1: TImageList;
    btnProdutos: TSpeedButton;
    btnVendas: TSpeedButton;
    pnlContainer: TPanel;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure btnClientesClick(Sender: TObject);
    procedure btnVendasClick(Sender: TObject);
  private
    procedure AbrirForm(FormClass: TFormClass);
    procedure AplicarEstilos;
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

procedure TFormPrincipal.AbrirForm(FormClass: TFormClass);
var
  Formulario: TForm;
begin
  Formulario := FormClass.Create(Self);

  Formulario.BorderStyle := bsNone;
  Formulario.Align := alClient;
  Formulario.Parent := pnlContainer;
  Formulario.Show;
end;

procedure TFormPrincipal.AplicarEstilos;
begin
  pnlCabecalho.Color := COR_CABECALHO_AZUL;
  btnClientes.Font.Color := COR_TEXTO_BRANCO;
  btnProdutos.Font.Color := COR_TEXTO_BRANCO;
  btnVendas.Font.Color := COR_TEXTO_BRANCO;
end;

procedure TFormPrincipal.btnClientesClick(Sender: TObject);

begin

AbrirForm(TFormListaClientes);

end;

procedure TFormPrincipal.btnProdutosClick(Sender: TObject);
begin

AbrirForm(TFormListaProdutos);

end;

procedure TFormPrincipal.btnVendasClick(Sender: TObject);
var
 FormInicialVenda : TFormInicialVenda;

begin
 FormInicialVenda := TFormInicialVenda.Create(Self);
 try
 FormInicialVenda.ShowModal;

 finally
   FormInicialVenda.Free;
 end;

end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  AplicarEstilos;

end;

end.
