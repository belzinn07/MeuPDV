unit FrmListaClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.Buttons, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  FrmBaseListagem, FrmClientes, Vcl.StdCtrls, uIClienteService,
  System.Generics.Collections, uClienteDTO,
  uServiceFactory, uEstilos;

type
  TFormListaClientes = class(TfrmBaseListagem)
    dsClientes: TDataSource;
    MemTable: TFDMemTable;
    btnPesquisar: TSpeedButton;
    edtPesquisa: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbgClientesDblClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
  private
    FClienteService : IClienteService;
    FListaDeClientes : TObjectList<TClienteDTO>;
    procedure ConfigurarMemTable;
    procedure CarregarClientesNaMemtable;
    procedure RecarregarLista;
    procedure EditarCliente;
    procedure PesquisarCliente;
    procedure AplicarEstilo;
    procedure AjustarColunas;

  public

  end;

var
  FormListaClientes: TFormListaClientes;

implementation

{$R *.dfm}

{ TFormListaClientes }

procedure TFormListaClientes.btnAdicionarClick(Sender: TObject);
var
  FormClientes : TFormClientes;
begin
  inherited;

  FormClientes := TFormClientes.Create(nil);
  try
    if FormClientes.ShowModal = mrOk then
      RecarregarLista;
  finally
    FormClientes.Free;
  end;
end;

procedure TFormListaClientes.btnAlterarClick(Sender: TObject);
begin
  inherited;
  EditarCliente;
end;

procedure TFormListaClientes.btnExcluirClick(Sender: TObject);
var
  Id: Integer;
begin
  inherited;

  if MemTable.IsEmpty then
  begin
    ShowMessage('Nenhum cliente selecionado.');
    Exit;
  end;

  if MessageDlg('Deseja realmente excluir este cliente?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  Id := MemTable.FieldByName('ID').AsInteger;

  try
    FClienteService.Excluir(Id);
    RecarregarLista;
    ShowMessage('Cliente excluído com sucesso.');
  except
    on E: Exception do
      ShowMessage('Erro ao excluir cliente: ' + E.Message);
  end;
end;

procedure TFormListaClientes.btnPesquisarClick(Sender: TObject);
begin
  PesquisarCliente;
end;

procedure TFormListaClientes.CarregarClientesNaMemtable;
var
  ClienteDTO : TClienteDTO;
begin
  if not Assigned(FListaDeClientes) then
    Exit;

  MemTable.DisableControls;

  try
    MemTable.EmptyDataSet;

    for ClienteDTO in FListaDeClientes do
    begin
      MemTable.Append;
      MemTable.FieldByName('ID').AsInteger := ClienteDTO.Id;
      MemTable.FieldByName('NOME').AsString := ClienteDTO.Nome;
      MemTable.FieldByName('CPF').AsString := ClienteDTO.CPF;
      MemTable.FieldByName('CNPJ').AsString := ClienteDTO.CNPJ;
      MemTable.FieldByName('TELEFONE').AsString := ClienteDTO.Telefone;
      MemTable.FieldByName('EMAIL').AsString := ClienteDTO.Email;
      MemTable.Post;
    end;

  finally
    MemTable.EnableControls;
  end;
end;

procedure TFormListaClientes.RecarregarLista;
begin
  FreeAndNil(FListaDeClientes);
  FListaDeClientes := FClienteService.Listar;
  CarregarClientesNaMemtable;
end;

procedure TFormListaClientes.ConfigurarMemTable;
begin
  MemTable.Close;
  MemTable.FieldDefs.Clear;
  dbgItens.Columns.Clear;

  MemTable.FieldDefs.Add('ID', ftInteger);
  MemTable.FieldDefs.Add('NOME', ftString, 60);
  MemTable.FieldDefs.Add('CPF', ftString, 20);
  MemTable.FieldDefs.Add('CNPJ', ftString, 20);
  MemTable.FieldDefs.Add('TELEFONE', ftString, 20);
  MemTable.FieldDefs.Add('EMAIL', ftString, 50);

  MemTable.CreateDataSet;

  MemTable.FieldByName('ID').DisplayLabel := 'Código';
  MemTable.FieldByName('NOME').DisplayLabel := 'Nome';
  MemTable.FieldByName('CPF').DisplayLabel := 'CPF';
  MemTable.FieldByName('CNPJ').DisplayLabel := 'CNPJ';
  MemTable.FieldByName('TELEFONE').DisplayLabel := 'Telefone';
  MemTable.FieldByName('EMAIL').DisplayLabel := 'E-mail';
end;

procedure TFormListaClientes.AjustarColunas;
var
  W: Integer;
begin
  if dbgItens.Columns.Count = 0 then
    Exit;

  W := dbgItens.ClientWidth - 20;

  dbgItens.Columns[0].Width := Round(W * 0.08);  // ID
  dbgItens.Columns[1].Width := Round(W * 0.27);  // NOME
  dbgItens.Columns[2].Width := Round(W * 0.16);  // CPF
  dbgItens.Columns[3].Width := Round(W * 0.16);  // CNPJ
  dbgItens.Columns[4].Width := Round(W * 0.13);  // TELEFONE
  dbgItens.Columns[5].Width := Round(W * 0.20);  // EMAIL
end;

procedure TFormListaClientes.dbgClientesDblClick(Sender: TObject);
begin
  inherited;
  EditarCliente;
end;

procedure TFormListaClientes.EditarCliente;
var
  Id: Integer;
  FormClientes: TFormClientes;
begin
  if MemTable.IsEmpty then
  begin
    ShowMessage('Nenhum cliente selecionado.');
    Exit;
  end;

  Id := MemTable.FieldByName('ID').AsInteger;

  FormClientes := TFormClientes.Create(nil);

  try
    FormClientes.PrepararEdicao(Id);

    if FormClientes.ShowModal = mrOk then
      RecarregarLista;
  finally
    FormClientes.Free;
  end;
end;

procedure TFormListaClientes.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    PesquisarCliente;
end;

procedure TFormListaClientes.FormCreate(Sender: TObject);
begin
  FClienteService := TServiceFactory.ClienteService;

  dsClientes.DataSet := MemTable;

  ConfigurarMemTable;
  AjustarColunas;
  FListaDeClientes := FClienteService.Listar;

  CarregarClientesNaMemtable;
  AplicarEstilo;
end;

procedure TFormListaClientes.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FListaDeClientes);
end;

procedure TFormListaClientes.FormResize(Sender: TObject);
begin
  inherited;
  AjustarColunas;
end;

procedure TFormListaClientes.PesquisarCliente;
begin
  FreeAndNil(FListaDeClientes);

  if Trim(edtPesquisa.Text) = '' then
    FListaDeClientes := FClienteService.Listar
  else
    FListaDeClientes := FClienteService.Pesquisar(edtPesquisa.Text);

  CarregarClientesNaMemtable;
end;

procedure TFormListaClientes.AplicarEstilo;
begin
  pnlCabecalho.Color := COR_CABECALHO_AZUL;
  pnlRodape.Color := COR_CABECALHO_AZUL;
end;

end.