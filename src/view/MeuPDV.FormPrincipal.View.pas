unit MeuPDV.FormPrincipal.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.Buttons, Vcl.ExtCtrls, Estilos, Vcl.Imaging.pngimage,
  MeuPDV.ListaProdutos.View, MeuPDV.ListaClientes.View;

type
  TFormPrincipal = class(TForm)
    pnlGeral: TPanel;
    pnlCabecalho: TPanel;
    btnClientes: TSpeedButton;
    ImageList1: TImageList;
    btnProdutos: TSpeedButton;
    btnVendas: TSpeedButton;
    pnlRodape: TPanel;
    pnlCental: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure btnClientesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

procedure TFormPrincipal.btnClientesClick(Sender: TObject);
begin

frmListaClientes.ShowModal;

end;

procedure TFormPrincipal.btnProdutosClick(Sender: TObject);
begin

frmListaProdutos.ShowModal;

end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
pnlCabecalho.Color :=  COR_CABECALHO_AZUL;
btnClientes.Font.Color := COR_TEXTO_BRANCO;
btnProdutos.Font.Color := COR_TEXTO_BRANCO;
btnVendas.Font.Color := COR_TEXTO_BRANCO;
pnlRodape.Color :=  COR_CABECALHO_AZUL;
pnlCental.Color := COR_FUNDO_CLARO;

end;

end.
