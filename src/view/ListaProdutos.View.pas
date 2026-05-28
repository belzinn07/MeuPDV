unit ListaProdutos.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.Buttons, DMConexao.infra, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,


  System.Generics.Collections, Produto.Model, IProduto.Service,
  Produto.Service, Produto.Repository, FormProdutos.View,
  Vcl.StdCtrls, Estilos, FormBaseListagem.View;

type
  TfrmListaProdutos = class(TfrmBaseListagem)
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
    ListaDeProdutos : TObjectList<TProduto>;
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
  frmListaProdutos: TfrmListaProdutos;

implementation

{$R *.dfm}

{ TfrmListaProdutos }

procedure TfrmListaProdutos.btnAdicionarProdutoClick(Sender: TObject);
var
 FormProdutos : TFormProdutos;
begin
  inherited;

FormProdutos := TFormProdutos.Create(nil);
  try

   if FormProdutos.ShowModal = mrOk then  RecarregarLista;

   finally
   FormProdutos.Free;
  end;
end;

procedure TfrmListaProdutos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  EditarProduto;
end;

procedure TfrmListaProdutos.btnExcluirProdutoClick(Sender: TObject);
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

procedure TfrmListaProdutos.btnPesquisarClick(Sender: TObject);
begin
 PesquisarProduto;
end;

procedure TfrmListaProdutos.CarregarProdutosNaMemtable;
var
 Produto :  TProduto;

begin
  if not Assigned(ListaDeProdutos) then
    Exit;

MemTable.DisableControls;

try

  MemTable.EmptyDataSet;

  for Produto in ListaDeProdutos do
  begin
   MemTable.Append;
   MemTable.FieldByName('ID').AsInteger := Produto.Id;
   MemTable.FieldByName('DESCRICAO').AsString := Produto.Descricao;
   MemTable.FieldByName('PRECO').AsCurrency := Produto.Preco;
   MemTable.FieldByName('SALDO').AsFloat := Produto.Saldo;
   MemTable.Post;
  end;

finally
 MemTable.EnableControls;

end;

end;


procedure TfrmListaProdutos.RecarregarLista;
begin
  FreeAndNil(ListaDeProdutos);
  ListaDeProdutos := FPodutoService.ListarProdutos;
  CarregarProdutosNaMemtable;
end;
procedure TfrmListaProdutos.ConfigurarMemTable;
begin
 MemTable.Close;
 MemTable.FieldDefs.Clear;
 dbgProdutos.Columns.Clear;

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


 procedure TfrmListaProdutos.AjustarColunas;
var
  W: Integer;
begin
  if dbgProdutos.Columns.Count = 0 then
    Exit;

  W := dbgProdutos.ClientWidth - 20;

  dbgProdutos.Columns[0].Width := Round(W * 0.08); // ID
  dbgProdutos.Columns[1].Width := Round(W * 0.57); // DESCRICAO
  dbgProdutos.Columns[2].Width := Round(W * 0.15); // PRECO
  dbgProdutos.Columns[3].Width := Round(W * 0.20); // SALDO
end;

procedure TfrmListaProdutos.dbgProdutosDblClick(Sender: TObject);
begin
  inherited;
  EditarProduto;
end;

procedure TfrmListaProdutos.EditarProduto;
var
  Id: Integer;
  FormProdutos: TFormProdutos;
begin
  if MemTable.IsEmpty then
  begin
    ShowMessage('Nenhum produto selecionado.');
    Exit;
  end;

  Id := MemTable.FieldByName('ID').AsInteger;

  FormProdutos := TFormProdutos.Create(nil);

  try
    FormProdutos.PrepararEdicao(Id);

    if FormProdutos.ShowModal = mrOk then
      RecarregarLista;

  finally
    FormProdutos.Free;
  end;
end;

procedure TfrmListaProdutos.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

 if Key = VK_RETURN then
  PesquisarProduto;

end;

procedure TfrmListaProdutos.FormCreate(Sender: TObject);
begin


FPodutoService := TProdutoService.Create(TProdutoRepository.Create(DMConexao.infra.dmConexao));

  dsProdutos.DataSet := MemTable;

  ConfigurarMemTable;
  AjustarColunas;
  ListaDeProdutos := FPodutoService.ListarProdutos;

  CarregarProdutosNaMemtable;
  AplicarEstilo;

end;



procedure TfrmListaProdutos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ListaDeProdutos);
end;

procedure TfrmListaProdutos.FormResize(Sender: TObject);
begin
  inherited;
 AjustarColunas;
end;

procedure TfrmListaProdutos.PesquisarProduto;
begin
  FreeAndNil(ListaDeProdutos);

  if Trim(edtPesquisa.Text) = '' then
    ListaDeProdutos := FPodutoService.ListarProdutos
  else
    ListaDeProdutos :=
      FPodutoService.PesquisarProdutos(edtPesquisa.Text);

  CarregarProdutosNaMemtable;
end;

procedure TfrmListaProdutos.AplicarEstilo;
begin
  pnlCabecalho.Color := COR_CABECALHO_AZUL;
  pnlRodape.Color := COR_CABECALHO_AZUL;

end;

end.
