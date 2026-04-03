unit MeuPDV.FormProdutos.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, Estilos;

type
  TFormProdutos = class(TForm)
    pnlGeral: TPanel;
    pnlCabecalho: TPanel;
    SpeedButton1: TSpeedButton;
    ImageList1: TImageList;
    edtDescricao: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormProdutos: TFormProdutos;

implementation

{$R *.dfm}

procedure TFormProdutos.FormCreate(Sender: TObject);
begin

    pnlCabecalho.Color := COR_CABECALHO_AZUL;
  pnlGeral.Color := COR_FUNDO_CLARO;
  SpeedButton1.Flat := True;
  SpeedButton1.Font.Color := COR_TEXTO_BRANCO;


end;

end.
