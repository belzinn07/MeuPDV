unit MeuPDV.ListaProdutos.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids,
  MeuPDV.DMConexao.infra, Estilos;

type
  TfrmListaProdutos = class(TForm)
    pnlContainer: TPanel;
    pnlCabecalho: TPanel;
    pnlRodape: TPanel;
    btnTituloProdutos: TSpeedButton;
    ImageList1: TImageList;
    pnlAltera: TPanel;
    pnlAdicionarProduto: TPanel;
    Shape3: TShape;
    pnlExcluirProduto: TPanel;
    Shape4: TShape;
    btnAdicionarProduto: TSpeedButton;
    Shape2: TShape;
    btnAlterar: TSpeedButton;
    btnExcluirProduto: TSpeedButton;
    pnlCentral: TPanel;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListaProdutos: TfrmListaProdutos;

implementation

{$R *.dfm}

procedure TfrmListaProdutos.FormCreate(Sender: TObject);
begin

  pnlCabecalho.Color := COR_CABECALHO_AZUL;
  pnlContainer.Color := COR_FUNDO_CLARO;
  btnTituloProdutos.Flat := True;
  btnTituloProdutos.Font.Color := COR_TEXTO_BRANCO;
  pnlRodape.Color := COR_CABECALHO_AZUL;

end;

end.
