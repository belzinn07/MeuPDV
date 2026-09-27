unit FrmListaVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.Buttons, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  FrmBaseListagem, Vcl.StdCtrls, uIVendaService, uIClienteService,
  System.Generics.Collections, uVendaDTO, uClienteDTO, uVendaStatus,
  uServiceFactory, uEstilos;

type
  TFormListaVendas = class(TfrmBaseListagem)
    dsVendas: TDataSource;
    MemTable: TFDMemTable;
    btnPesquisar: TSpeedButton;
    edtPesquisa: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgItensDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FVendaService : IVendaService;
    FClienteService: IClienteService;
    FListaDeVendas : TObjectList<TVendaDTO>;
    procedure ConfigurarMemTable;
    procedure CarregarVendasNaMemtable;
    procedure RecarregarLista;
    procedure EditarVenda;
    procedure CancelarVenda;
    procedure PesquisarVenda;
    function BuscarVendaPorId(AId: Integer): TVendaDTO;
    procedure AplicarEstilo;
    procedure AjustarColunas;

  public
    { Public declarations }
  end;

var
  FormListaVendas: TFormListaVendas;

implementation

{$R *.dfm}

uses
  FrmVenda, FrmInicialVenda;

{ TFormListaVendas }

procedure TFormListaVendas.FormCreate(Sender: TObject);
begin
  FVendaService := TServiceFactory.VendaService;
  FClienteService := TServiceFactory.ClienteService;

  dsVendas.DataSet := MemTable;

  ConfigurarMemTable;
  AjustarColunas;
  FListaDeVendas := FVendaService.Listar;
  CarregarVendasNaMemtable;
  AplicarEstilo;
end;

procedure TFormListaVendas.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FListaDeVendas);
end;

procedure TFormListaVendas.btnAdicionarClick(Sender: TObject);
var
  FrmNovaVenda: TFormInicialVenda;
begin
  inherited;

  FrmNovaVenda := TFormInicialVenda.Create(nil);
  try
    FrmNovaVenda.ShowModal;
    RecarregarLista;
  finally
    FrmNovaVenda.Free;
  end;
end;

procedure TFormListaVendas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  EditarVenda;
end;

procedure TFormListaVendas.btnExcluirClick(Sender: TObject);
begin
  inherited;
  CancelarVenda;
end;

procedure TFormListaVendas.btnPesquisarClick(Sender: TObject);
begin
  PesquisarVenda;
end;

procedure TFormListaVendas.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    PesquisarVenda;
end;

procedure TFormListaVendas.dbgItensDblClick(Sender: TObject);
begin
  inherited;
  EditarVenda;
end;

procedure TFormListaVendas.FormResize(Sender: TObject);
begin
  inherited;
  AjustarColunas;
end;

procedure TFormListaVendas.ConfigurarMemTable;
begin
  MemTable.Close;
  MemTable.FieldDefs.Clear;
  dbgItens.Columns.Clear;

  MemTable.FieldDefs.Add('ID', ftInteger);
  MemTable.FieldDefs.Add('DATA', ftDateTime);
  MemTable.FieldDefs.Add('CLIENTE', ftString, 100);
  MemTable.FieldDefs.Add('TOTAL', ftCurrency);
  MemTable.FieldDefs.Add('STATUS', ftString, 20);

  MemTable.CreateDataSet;

  MemTable.FieldByName('ID').DisplayLabel := 'Fatura';
  MemTable.FieldByName('DATA').DisplayLabel := 'Data';
  MemTable.FieldByName('CLIENTE').DisplayLabel := 'Cliente';
  MemTable.FieldByName('TOTAL').DisplayLabel := 'Total';
  MemTable.FieldByName('STATUS').DisplayLabel := 'Status';
end;

procedure TFormListaVendas.CarregarVendasNaMemtable;
var
  VendaDTO: TVendaDTO;
begin
  if not Assigned(FListaDeVendas) then
    Exit;

  MemTable.DisableControls;

  try
    MemTable.EmptyDataSet;

    for VendaDTO in FListaDeVendas do
    begin
      MemTable.Append;
      MemTable.FieldByName('ID').AsInteger := VendaDTO.Id;
      MemTable.FieldByName('DATA').AsDateTime := VendaDTO.Data;
      MemTable.FieldByName('CLIENTE').AsString := VendaDTO.NomeCliente;
      MemTable.FieldByName('TOTAL').AsCurrency := VendaDTO.Total;
      MemTable.FieldByName('STATUS').AsString := VendaStatusToStr(VendaDTO.Status);
      MemTable.Post;
    end;

  finally
    MemTable.EnableControls;
  end;
end;

procedure TFormListaVendas.RecarregarLista;
begin
  FreeAndNil(FListaDeVendas);
  FListaDeVendas := FVendaService.Listar;
  CarregarVendasNaMemtable;
end;

procedure TFormListaVendas.PesquisarVenda;
begin
  FreeAndNil(FListaDeVendas);

  if Trim(edtPesquisa.Text) = '' then
    FListaDeVendas := FVendaService.Listar
  else
    FListaDeVendas := FVendaService.Pesquisar(edtPesquisa.Text);

  CarregarVendasNaMemtable;
end;

function TFormListaVendas.BuscarVendaPorId(AId: Integer): TVendaDTO;
var
  VendaDTO: TVendaDTO;
begin
  Result := nil;

  if not Assigned(FListaDeVendas) then
    Exit;

  for VendaDTO in FListaDeVendas do
    if VendaDTO.Id = AId then
    begin
      Result := VendaDTO;
      Break;
    end;
end;

procedure TFormListaVendas.EditarVenda;
var
  Id: Integer;
  VendaDTO: TVendaDTO;
  Cliente: TClienteDTO;
  FormVendas: TFormVendas;
begin
  if MemTable.IsEmpty then
  begin
    ShowMessage('Nenhuma venda selecionada.');
    Exit;
  end;

  Id := MemTable.FieldByName('ID').AsInteger;

  if MemTable.FieldByName('STATUS').AsString = VendaStatusToStr(vsCancelada) then
  begin
    ShowMessage('Esta venda está cancelada.');
    Exit;
  end;

  VendaDTO := BuscarVendaPorId(Id);
  if VendaDTO = nil then
    Exit;

  Cliente := FClienteService.BuscarPorId(VendaDTO.IdCliente);
  if Cliente = nil then
  begin
    ShowMessage('Cliente da venda não encontrado.');
    Exit;
  end;

  FormVendas := TFormVendas.Create(nil);
  try
    FormVendas.IdVendaEmEdicao := Id;
    FormVendas.ClienteSelecionado := Cliente;
    FormVendas.ProximaFaturaVenda := FVendaService.BuscarProximaFatura;

    FormVendas.ShowModal;

    if FormVendas.ModalResult = mrOk then
      RecarregarLista;
  finally
    FormVendas.Free;
    Cliente.Free;
  end;
end;

procedure TFormListaVendas.CancelarVenda;
var
  Id: Integer;
begin
  if MemTable.IsEmpty then
  begin
    ShowMessage('Nenhuma venda selecionada.');
    Exit;
  end;

  Id := MemTable.FieldByName('ID').AsInteger;

  if MemTable.FieldByName('STATUS').AsString = VendaStatusToStr(vsCancelada) then
  begin
    ShowMessage('Esta venda já está cancelada.');
    Exit;
  end;

  if MessageDlg(Format('Deseja cancelar a venda nº %d? Os itens serão descartados.', [Id]),
                mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  try
    FVendaService.ExcluirVenda(Id);
    RecarregarLista;
    ShowMessage('Venda cancelada com sucesso.');
  except
    on E: Exception do
      ShowMessage('Erro ao cancelar venda: ' + E.Message);
  end;
end;

procedure TFormListaVendas.AplicarEstilo;
begin
  pnlCabecalho.Color := COR_CABECALHO_AZUL;
  pnlRodape.Color := COR_CABECALHO_AZUL;
end;

procedure TFormListaVendas.AjustarColunas;
var
  W: Integer;
begin
  if dbgItens.Columns.Count = 0 then
    Exit;

  W := dbgItens.ClientWidth - 20;

  dbgItens.Columns[0].Width := Round(W * 0.08);
  dbgItens.Columns[1].Width := Round(W * 0.18);
  dbgItens.Columns[2].Width := Round(W * 0.44);
  dbgItens.Columns[3].Width := Round(W * 0.15);
  dbgItens.Columns[4].Width := Round(W * 0.15);
end;

end.