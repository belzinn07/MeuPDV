unit FrmInicialVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Buttons, FrmVenda, uIVendaService, uServiceFactory, uIClienteService,
  uClienteDTO, System.Generics.Collections, uVendaDTO, uVendaStatus;

type
  TFormInicialVenda = class(TForm)
    pnlBox: TPanel;
    pnlCabecalho: TPanel;
    cbxSelecionarCliente: TComboBox;
    edtFatura: TLabeledEdit;
    lblCodigoCliente: TLabel;
    btnConfirmar: TBitBtn;
    btnCancelar: TBitBtn;
    pnlContainer: TPanel;
    edtIdCliente: TEdit;
    lblCliente: TLabel;
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbxSelecionarClienteChange(Sender: TObject);
    procedure edtIdClienteExit(Sender: TObject);
    procedure edtIdClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtFaturaExit(Sender: TObject);
    procedure edtFaturaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    FService : IVendaService;
    FClienteService: IClienteService;
    FIdFaturaEmEdicao: Integer;
    procedure SincronizarClienteSelecionado(const AIdCliente: Integer);
    function BuscarFatura: Boolean;
    procedure ResetarParaNovaVenda(const AProxima: Integer);
    procedure CarregarClientes;

  public
    { Public declarations }
  end;

var
  FormInicialVenda: TFormInicialVenda;

implementation

{$R *.dfm}

procedure TFormInicialVenda.FormCreate(Sender: TObject);
begin
   FService := TServiceFactory.VendaService;
   FClienteService := TServiceFactory.ClienteService;

end;

procedure TFormInicialVenda.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Key := #0;
end;

procedure TFormInicialVenda.FormShow(Sender: TObject);
begin
  FIdFaturaEmEdicao := 0;
  edtFatura.Text := IntToStr(FService.BuscarProximaFatura);

  cbxSelecionarCliente.Items.Clear;
  CarregarClientes;

end;

procedure TFormInicialVenda.CarregarClientes;
var
  Lista: System.Generics.Collections.TObjectList<TClienteDTO>;
  Cliente: TClienteDTO;
begin
  Lista := FClienteService.Listar;

  try
    for Cliente in Lista do
      cbxSelecionarCliente.Items.AddObject(Cliente.Nome, TObject(Cliente.Id));
  finally
    Lista.Free;
  end;
end;


procedure TFormInicialVenda.cbxSelecionarClienteChange(Sender: TObject);
begin
 if cbxSelecionarCliente.ItemIndex >= 0 then
    edtIdCliente.Text :=
      IntToStr(Integer(cbxSelecionarCliente.Items.Objects[cbxSelecionarCliente.ItemIndex]));
end;

procedure TFormInicialVenda.edtIdClienteExit(Sender: TObject);
var
  IdDigitado: Integer;
begin
  if Trim(edtIdCliente.Text) = '' then
    Exit;

  IdDigitado := StrToIntDef(edtIdCliente.Text, -1);
  SincronizarClienteSelecionado(IdDigitado);

  if cbxSelecionarCliente.ItemIndex = -1 then
  begin
    ShowMessage('Cliente não encontrado.');
    cbxSelecionarCliente.ItemIndex := -1;
  end;

end;


procedure TFormInicialVenda.edtIdClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_RETURN then
  begin
    Key := 0;
    edtIdClienteExit(Sender);
    btnConfirmar.SetFocus;
  end;
end;

procedure TFormInicialVenda.btnCancelarClick(Sender: TObject);
begin
 Release;
end;

procedure TFormInicialVenda.btnConfirmarClick(Sender: TObject);
var
  FormVendas : TFormVendas;
  ClienteDto: TClienteDTO;
  IdCliente: Integer;
begin

  if Trim(edtIdCliente.Text) = '' then
  begin
    ShowMessage('Informe o código do cliente ou selecione um cliente.');
    Exit;
  end;

  if not BuscarFatura then Exit;

  IdCliente := StrToIntDef(edtIdCliente.Text, -1);
  if IdCliente = -1 then
  begin
    ShowMessage('Código do cliente inválido.');
    Exit;
  end;

  ClienteDto := FClienteService.BuscarPorId(IdCliente);

  if ClienteDto = nil then
  begin
    ShowMessage('Nenhum cliente encontrado com esse código.');
    Exit;
  end;

  FormVendas := TFormVendas.Create(Self);
  try
    FormVendas.IdVendaEmEdicao   := FIdFaturaEmEdicao;
    FormVendas.ClienteSelecionado  := ClienteDto;
    FormVendas.ProximaFaturaVenda  := StrToIntDef(edtFatura.Text, FService.BuscarProximaFatura);
    FormVendas.ShowModal;
    if FormVendas.ModalResult = mrOk then
      edtFatura.Text := IntToStr(FService.BuscarProximaFatura)
    else if FormVendas.ModalResult = mrCancel then
      ResetarParaNovaVenda(FService.BuscarProximaFatura);

  finally
    FormVendas.Free;
    ClienteDto.Free;
    FIdFaturaEmEdicao := 0;
  end;
end;


procedure TFormInicialVenda.SincronizarClienteSelecionado(const AIdCliente: Integer);
var
  I: Integer;
begin
  for I := 0 to cbxSelecionarCliente.Items.Count - 1 do
    if Integer(cbxSelecionarCliente.Items.Objects[I]) = AIdCliente then
    begin
      cbxSelecionarCliente.ItemIndex := I;
      Exit;
    end;

end;

function TFormInicialVenda.BuscarFatura: Boolean;
var
  Numero: Integer;
  Proxima: Integer;
  Venda: TVendaDTO;
begin
  Result := False;
  Numero := StrToIntDef(Trim(edtFatura.Text), -1);
  Proxima := FService.BuscarProximaFatura;

  if Numero = -1 then
  begin
    ShowMessage('Fatura inválida.');
    ResetarParaNovaVenda(Proxima);
    Exit;
  end;

  if Numero > Proxima then
  begin
    ShowMessage('Fatura ou venda não encontrada!');
    ResetarParaNovaVenda(Proxima);
    Exit;
  end;

  Venda := FService.BuscarPorId(Numero);

  if Venda = nil then
  begin
    if Numero = Proxima then
    begin
      ResetarParaNovaVenda(Proxima);
      Result := True;
    end
    else
    begin
      ShowMessage(Format('Fatura %d não encontrada.', [Numero]));
      ResetarParaNovaVenda(Proxima);
    end;
    Exit;
  end;

  try

    if Venda.Status = vsCancelada then
    begin
      ShowMessage('Esta venda está cancelada.');
      ResetarParaNovaVenda(Proxima);
      Exit;
    end;

    FIdFaturaEmEdicao := Numero;
    edtIdCliente.Text := Venda.IdCliente;
    SincronizarClienteSelecionado(StrToInt(Venda.IdCliente));
    Result := True;

  finally
    Venda.Free;
  end;
end;



procedure TFormInicialVenda.ResetarParaNovaVenda(const AProxima: Integer);
begin
  if FIdFaturaEmEdicao > 0 then
  begin
    edtIdCliente.Text := '';
    cbxSelecionarCliente.ItemIndex := -1;
  end;

  FIdFaturaEmEdicao := 0;
  edtFatura.Text := IntToStr(AProxima);
end;

procedure TFormInicialVenda.edtFaturaExit(Sender: TObject);
begin
  BuscarFatura;
end;

procedure TFormInicialVenda.edtFaturaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    BuscarFatura;
    edtIdCliente.SetFocus;
  end;

end;

end.
