unit FrmVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,
  uDMConexao, Data.DB, Vcl.Grids, Vcl.DBGrids, uClienteDTO, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uIVendaService, uServiceFactory, uIProdutoService;

type
  TFormVendas = class(TForm)
    pnlContainer: TPanel;
    pnlCabecalho: TPanel;
    pnlRodape: TPanel;
    lblTitulo: TLabel;
    pnlLateral: TPanel;
    dbgItensVenda: TDBGrid;
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
    dsItens: TDataSource;
    mtItens: TFDMemTable;
    procedure FormCreate(Sender: TObject);
  private
    FProximaFaturaVenda: Integer;
    FClienteSelecionado: TClienteDTO;
    FVendaService: IVendaService;
    FProdutoService: IProdutoService;

  public
    property ProximaFaturaVenda: Integer read FProximaFaturaVenda write FProximaFaturaVenda;
    property ClienteSelecionado: TClienteDTO read FClienteSelecionado write FClienteSelecionado;

  end;

var
  FormVendas: TFormVendas;

implementation

{$R *.dfm}

procedure TFormVendas.FormCreate(Sender: TObject);
begin
 FVendaService := TServiceFactory.VendaService;
 FProdutoService := TServiceFactory.ProdutoService;

 mtItens.Close;
 mtItens.FieldDefs.Clear;

 mtItens.FieldDefs.Add('CODIGO', ftInteger);
 mtItens.FieldDefs.Add('DESCRICAO',ftString, 100);
 mtItens.FieldDefs.Add('QUANTIDADE', ftInteger);
 mtItens.FieldDefs.Add('PRECO', ftCurrency);
 mtItens.FieldDefs.Add('TOTAL', ftCurrency);

 mtItens.CreateDataSet;

end;

end.
