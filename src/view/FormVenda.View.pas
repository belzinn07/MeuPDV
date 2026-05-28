unit FormVenda.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,
  DMConexao.infra, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmVendas = class(TForm)
    pnlContainer: TPanel;
    pnlCabecalho: TPanel;
    pnlRodape: TPanel;
    Label1: TLabel;
    pnlLateral: TPanel;
    DBGrid1: TDBGrid;
    pnlTotalCompra: TPanel;
    Shape4: TShape;
    lblTotalCompra: TLabel;
    lblPrecoTotalCompra: TLabel;
    pnledtTotalCompra: TPanel;
    pnlSubtotal: TPanel;
    Shape2: TShape;
    lblSubTotal: TLabel;
    pnledtSubtotal: TPanel;
    lblPrecoSubTotal: TLabel;
    pnlQuantidade: TPanel;
    Shape3: TShape;
    lblQuantidade: TLabel;
    pnledtQuantidade: TPanel;
    Edit1: TEdit;
    pnlPreco: TPanel;
    Shape5: TShape;
    lblPreco: TLabel;
    pnledtPreco: TPanel;
    edtPreco: TEdit;
    pnlProduto: TPanel;
    Shape6: TShape;
    lblProduto: TLabel;
    pnledtProduto: TPanel;
    edtProduto: TEdit;
    pnlFecharVenda: TPanel;
    Shape1: TShape;
    btnFecharVenda: TSpeedButton;
    pnlCancelarVenda: TPanel;
    Shape7: TShape;
    btnCancelarVenda: TSpeedButton;
    pnlConfirmarProduto: TPanel;
    Shape8: TShape;
    btnConfirmarProduto: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVendas: TfrmVendas;

implementation

{$R *.dfm}

end.
