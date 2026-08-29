unit FrmBaseListagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons,
  System.ImageList, Vcl.ImgList, Data.DB, Vcl.Grids, Vcl.DBGrids, uEstilos;

type
  TfrmBaseListagem = class(TForm)
    pnlContainer: TPanel;
    pnlCabecalho: TPanel;
    btnTitulo: TSpeedButton;
    ImageList1: TImageList;
    pnlRodape: TPanel;
    pnlAltera: TPanel;
    Shape2: TShape;
    btnAlterar: TSpeedButton;
    pnlAdicionar: TPanel;
    Shape3: TShape;
    btnAdicionar: TSpeedButton;
    pnlExcluir: TPanel;
    Shape4: TShape;
    btnExcluir: TSpeedButton;
    pnlCentral: TPanel;
    dbgItens: TDBGrid;
    procedure FormCreate(Sender: TObject);
  private
    procedure AplicarEstilos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBaseListagem: TfrmBaseListagem;

implementation

{$R *.dfm}

procedure TfrmBaseListagem.FormCreate(Sender: TObject);
begin
  AplicarEstilos;
end;

procedure TfrmBaseListagem.AplicarEstilos;
begin
  pnlCabecalho.Color := COR_CABECALHO_AZUL;
  pnlContainer.Color := COR_FUNDO_CLARO;
  btnTitulo.Flat := True;
  btnTitulo.Font.Color := COR_TEXTO_BRANCO;
  pnlRodape.Color := COR_CABECALHO_AZUL;
end;

end.
