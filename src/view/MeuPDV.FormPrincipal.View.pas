unit MeuPDV.FormPrincipal.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.Buttons, Vcl.ExtCtrls, Estilos;

type
  TFormPrincipal = class(TForm)
    pnlGeral: TPanel;
    pnlCabecalho: TPanel;
    btnClientes: TSpeedButton;
    ImageList1: TImageList;
    btnProdutos: TSpeedButton;
    btnVendas: TSpeedButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
pnlCabecalho.Color :=  COR_CABECALHO_AZUL;


btnClientes.Font.Color := COR_TEXTO_BRANCO;
btnProdutos.Font.Color := COR_TEXTO_BRANCO;
btnVendas.Font.Color := COR_TEXTO_BRANCO;

end;

end.
