unit FrmListaProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.Buttons, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,


  System.Generics.Collections, uProduto, uIProdutoService,
  FrmProdutos,
  Vcl.StdCtrls, uEstilos, FrmBaseListagem, uProdutoDTO,
  uServiceFactory;

type
  TFormListaProdutos = class(TfrmBaseListagem)
    dsProdutos: TDataSource;
    MemTable: TFDMemTable;
    btnPesquisar: TSpeedButton;
    edtPesquisa: TEdit;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAdicionarProdutoClick(Sender: TObject);
    procedure btnExcluirProdutoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbgProdutosDblClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
  private
    FPodutoService : IProdutoService;
    FListaDeProdutos : TObjectList<TProdutoDTO>;
    procedure ConfigurarMemTable;
    procedure CarregarProdutosNaMemtable;
    procedure RecarregarLista;
    procedure EditarProduto;
    procedure PesquisarProduto;
    procedure AplicarEstilo;
    procedure AjustarColunas;

  public

  end;

var
  FormListaProdutos: TFormListaProdutos;

implementation

{$R *.dfm}

{ TfrmListaProdutos }

procedure TFormListaProdutos.btnAdicionarProdutoClick(Sender: TObject);
var
 FormProdutos : TFrmProdutos;
begin
  inherited;

FormProdutos := TFrmProdutos.Create(nil);
  try

   if FormProdutos.ShowModal = mrOk then  RecarregarLista;

   finally
   FormProdutos.Free;
  end;
end;

procedure TFormListaProdutos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  EditarProduto;
end;

procedure TFormListaProdutos.btnExcluirProdutoClick(Sender: TObject);
var
  Id: Integer;
begin
  inherited;

  if MemTable.IsEmpty then
  begin
    ShowMessage('Nenhum produto selecionado.');
    Exit;
  end;

  if MessageDlg('Deseja realmente excluir este produto?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  Id := MemTable.FieldByName('ID').AsInteger;


  try
    FPodutoService.Excluir(Id);
    RecarregarLista;
    ShowMessage('Produto excluído com sucesso.');
  except
    on E: Exception do
      ShowMessage('Erro ao excluir produto: ' + E.Message);
  end;
end;

procedure TFormListaProdutos.btnPesquisarClick(Sender: TObject);
begin
 PesquisarProduto;
end;

procedure TFormListaProdutos.CarregarProdutosNaMemtable;
var
 ProdutoDTO :  TProdutoDTO;

begin
  if not Assigned(FListaDeProdutos) then
    Exit;

MemTable.DisableControls;

try

  MemTable.EmptyDataSet;

  for ProdutoDTO in FListaDeProdutos do
  begin
   MemTable.Append;
   MemTable.FieldByName('ID').AsInteger := ProdutoDTO.Id;
   MemTable.FieldByName('DESCRICAO').AsString := ProdutoDTO.Descricao;
   MemTable.FieldByName('PRECO').AsString := ProdutoDTO.Preco;
   MemTable.FieldByName('SALDO').AsString := ProdutoDTO.Saldo;
   MemTable.Post;
  end;

finally
 MemTable.EnableControls;

end;

end;


procedure TFormListaProdutos.RecarregarLista;
begin
  FreeAndNil(FListaDeProdutos);
  FListaDeProdutos := FPodutoService.ListarProdutos;
  CarregarProdutosNaMemtable;
end;

procedure TFormListaProdutos.ConfigurarMemTable;
begin
 MemTable.Close;
 MemTable.FieldDefs.Clear;
 dbgItens.Columns.Clear;

 MemTable.FieldDefs.Add('ID', ftInteger);
 MemTable.FieldDefs.Add('DESCRICAO', ftString, 100);
 MemTable.FieldDefs.Add('PRECO', ftCurrency);
 MemTable.FieldDefs.Add('SALDO', ftFloat);

 MemTable.CreateDataSet;

 MemTable.FieldByName('ID').DisplayLabel := 'Código';
  MemTable.FieldByName('DESCRICAO').DisplayLabel := 'Descrição';
  MemTable.FieldByName('PRECO').DisplayLabel := 'Preço';
  MemTable.FieldByName('SALDO').DisplayLabel := 'Saldo  ';

 end;


 procedure TFormListaProdutos.AjustarColunas;
var
  W: Integer;
begin
  if dbgItens.Columns.Count = 0 then
    Exit;

  W := dbgItens.ClientWidth - 20;

  dbgItens.Columns[0].Width := Round(W * 0.08); // ID
  dbgItens.Columns[1].Width := Round(W * 0.57); // DESCRICAO
  dbgItens.Columns[2].Width := Round(W * 0.15); // PRECO
  dbgItens.Columns[3].Width := Round(W * 0.20); // SALDO
end;

procedure TFormListaProdutos.dbgProdutosDblClick(Sender: TObject);
begin
  inherited;
  EditarProduto;
end;

procedure TFormListaProdutos.EditarProduto;
var
  Id: Integer;
  FormProdutos: TFrmProdutos;
begin
  if MemTable.IsEmpty then
  begin
    ShowMessage('Nenhum produto selecionado.');
    Exit;
  end;

  Id := MemTable.FieldByName('ID').AsInteger;

  FormProdutos := TFrmProdutos.Create(nil);

  try
    FormProdutos.PrepararEdicao(Id);

    if FormProdutos.ShowModal = mrOk then
      RecarregarLista;

  finally
    FormProdutos.Free;
  end;
end;

procedure TFormListaProdutos.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

 if Key = VK_RETURN then
  PesquisarProduto;

end;

procedure TFormListaProdutos.FormCreate(Sender: TObject);
begin

  FPodutoService := TServiceFactory.ProdutoService;

  dsProdutos.DataSet := MemTable;

  ConfigurarMemTable;
  AjustarColunas;
  FListaDeProdutos := FPodutoService.ListarProdutos;

  CarregarProdutosNaMemtable;
  AplicarEstilo;

end;



procedure TFormListaProdutos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FListaDeProdutos);
end;

procedure TFormListaProdutos.FormResize(Sender: TObject);
begin
  inherited;
 AjustarColunas;
end;

procedure TFormListaProdutos.PesquisarProduto;
begin
  FreeAndNil(FListaDeProdutos);

  if Trim(edtPesquisa.Text) = '' then
    FListaDeProdutos := FPodutoService.ListarProdutos
  else
    FListaDeProdutos :=
      FPodutoService.PesquisarProdutos(edtPesquisa.Text);

  CarregarProdutosNaMemtable;
end;

procedure TFormListaProdutos.AplicarEstilo;
begin
  pnlCabecalho.Color := COR_CABECALHO_AZUL;
  pnlRodape.Color := COR_CABECALHO_AZUL;

end;

end.
