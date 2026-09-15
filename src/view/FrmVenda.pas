unit FrmVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,
  uDMConexao, Data.DB, Vcl.Grids, Vcl.DBGrids, uClienteDTO, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uIVendaService, uServiceFactory, uIProdutoService,
  uProdutoDTO;

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
    edtQuantidade: TEdit;
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
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmarProdutoClick(Sender: TObject);
  private
    FProximaFaturaVenda: Integer;
    FClienteSelecionado: TClienteDTO;
    FVendaService: IVendaService;
    FProdutoService: IProdutoService;
    FIdProduto: Integer;
    FDescricao: string;
    procedure ConfiguraMemtable;
    procedure AjustarColunas;
    procedure CarregarTotal;

  public
    property ProximaFaturaVenda: Integer read FProximaFaturaVenda write FProximaFaturaVenda;
    property ClienteSelecionado: TClienteDTO read FClienteSelecionado write FClienteSelecionado;

  end;

var
  FormVendas: TFormVendas;

implementation

{$R *.dfm}

procedure TFormVendas.FormCreate(Sender: TObject);
var
    W: Integer;
begin
 FVendaService := TServiceFactory.VendaService;
 FProdutoService := TServiceFactory.ProdutoService;
 ConfiguraMemtable;
 AjustarColunas;


end;

procedure TFormVendas.FormResize(Sender: TObject);
begin
 AjustarColunas;
end;

procedure TFormVendas.FormShow(Sender: TObject);
begin
 Caption := Format('Venda nº %d - Cliente: %s',
                    [FProximaFaturaVenda, FClienteSelecionado.Nome]);
 edtProduto.Clear;
 edtPreco.Clear;
 edtQuantidade.Clear;
 CarregarTotal;
 edtProduto.SetFocus;


end;

procedure TFormVendas.AjustarColunas;
var
  W: integer;
begin
  if dbgItensVenda.Columns.Count = 0 then
    Exit;

  W := dbgItensVenda.ClientWidth - 20;

dbgItensVenda.Columns[0].Width := Round(W * 0.10);
dbgItensVenda.Columns[1].Width := Round(W * 0.50);
dbgItensVenda.Columns[2].Width := Round(W * 0.10);
dbgItensVenda.Columns[3].Width := Round(W * 0.15);
dbgItensVenda.Columns[4].Width := Round(W * 0.15);

end;

procedure TFormVendas.ConfiguraMemtable;
begin
  mtItens.Close;
  mtItens.FieldDefs.Clear;
  dbgItensVenda.Columns.Clear;
  mtItens.FieldDefs.Add('CODIGO', ftInteger);
  mtItens.FieldDefs.Add('DESCRICAO', ftString, 100);
  mtItens.FieldDefs.Add('QUANTIDADE', ftInteger);
  mtItens.FieldDefs.Add('PRECO', ftCurrency);
  mtItens.FieldDefs.Add('TOTAL', ftCurrency);
  mtItens.CreateDataSet;
  mtItens.FieldByName('CODIGO').DisplayLabel := 'Código';
  mtItens.FieldByName('DESCRICAO').DisplayLabel := 'Descrição';
  mtItens.FieldByName('QUANTIDADE').DisplayLabel := 'Quantidade';
  mtItens.FieldByName('PRECO').DisplayLabel := 'Preço';
  mtItens.FieldByName('TOTAL').DisplayLabel := 'Total';
end;

procedure TFormVendas.edtProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
 Produto : TProdutoDTO;
begin
 if Key <>  VK_RETURN then  Exit;
 Key := 0;

 FIdProduto := StrToIntDef(Trim(edtProduto.Text), -1);
 if FIdProduto <= 0 then
 begin
   ShowMessage('Código do produto inválido');
   Exit;
 end;

 Produto := FProdutoService.BuscarPorId(FIdProduto);
 try
   if Produto = nil then
   begin
     ShowMessage('Produto não encontrado');
     edtProduto.Clear;
     Exit;
   end;

   edtPreco.Text := FormatFloat('0.00', StrToFloatDef(Produto.Preco, 0));
   edtQuantidade.Text := '1';
   edtQuantidade.SetFocus;

   FDescricao := Produto.Descricao;

 finally
   Produto.Free;
 end;

end;

procedure TFormVendas.btnConfirmarProdutoClick(Sender: TObject);
var
  Quantidade: Integer;
  Preco: Currency;
  TotalItem: Currency;

begin
  if not TryStrToInt(Trim(edtQuantidade.Text), Quantidade)   or (Quantidade <= 0) then
  begin
    ShowMessage('Quantidade Inválida');
    edtQuantidade.SetFocus;
    Exit;
  end;

    if not TryStrToCurr(Trim(edtPreco.Text), Preco) or (Preco <= 0) then
  begin
    ShowMessage('Preço inválido.');
    edtPreco.SetFocus;
    Exit;
  end;

  TotalItem := Quantidade * Preco;

  mtItens.Append;
  mtItens.FieldByName('CODIGO').AsInteger := FIdProduto;
  mtItens.FieldByName('DESCRICAO').AsString := FDescricao;
  mtItens.FieldByName('QUANTIDADE').AsInteger :=  Quantidade;
  mtItens.FieldByName('PRECO').AsCurrency := Preco;
  mtItens.FieldByName('TOTAL').AsCurrency := TotalItem;
  mtItens.Post;

  CarregarTotal;
  edtProduto.Clear;
  edtPreco.Clear;
  edtQuantidade.Clear;
  edtPreco.SetFocus;

end;

procedure TFormVendas.CarregarTotal;
var
  Total: Currency;

begin
  Total := 0;
  mtItens.First;

  while not mtItens.Eof do
  begin
    Total:= Total + mtItens.FieldByName('TOTAL').AsCurrency;
    mtItens.Next;
  end;

  lblPrecoSubTotal.Caption := FormatCurr('R$ 0.00', Total);
  lblPrecoTotalCompra.Caption := FormatCurr('R$ 0.00', Total);
end;

end.
