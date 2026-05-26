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
    pnlContainer: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure btnClientesClick(Sender: TObject);
  private
    procedure AbrirForm(FormClass: TFormClass; var Formulario: TForm);
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

procedure TFormPrincipal.AbrirForm(FormClass: TFormClass; var Formulario: TForm);
begin
if Assigned(Formulario) then
  begin
    Formulario.Close;
    FreeAndNil(Formulario);
  end;

  Formulario.Create(Self);
  Formulario.BorderStyle := bsNone;
  Formulario.Align := alClient;
  Formulario.Parent := pnlContainer;
  Formulario.Show;

end;

procedure TFormPrincipal.btnClientesClick(Sender: TObject);
begin

AbrirForm(TfrmListaClientes, TForm(frmListaClientes));

end;

procedure TFormPrincipal.btnProdutosClick(Sender: TObject);
begin

AbrirForm(TfrmListaProdutos, TForm(frmListaProdutos));

end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
pnlCabecalho.Color :=  COR_CABECALHO_AZUL;
btnClientes.Font.Color := COR_TEXTO_BRANCO;
btnProdutos.Font.Color := COR_TEXTO_BRANCO;
btnVendas.Font.Color := COR_TEXTO_BRANCO;


end;

end.
