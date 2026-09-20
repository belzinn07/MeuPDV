unit FrmInicialVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Buttons, FrmVenda, uIVendaService, uServiceFactory, uIClienteService,
  uClienteDTO, System.Generics.Collections;

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

  private
    FService : IVendaService;
    FClienteService: IClienteService;
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
  begin
    Key := #0;
    edtIdClienteExit(edtIdCliente);
  end;
end;

procedure TFormInicialVenda.FormShow(Sender: TObject);
begin
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
  I: Integer;
begin
  if Trim(edtIdCliente.Text) = '' then
    Exit;

  IdDigitado := StrToIntDef(edtIdCliente.Text, -1);

  for I := 0 to cbxSelecionarCliente.Items.Count - 1 do
  begin
    if Integer(cbxSelecionarCliente.Items.Objects[I]) = IdDigitado then
    begin
      cbxSelecionarCliente.ItemIndex := I;
      Exit;
    end;
  end;

  ShowMessage('Cliente não encontrado.');
  cbxSelecionarCliente.ItemIndex := -1;
end;


procedure TFormInicialVenda.edtIdClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_RETURN then
  begin
    Key := 0;
    edtIdClienteExit(Sender);
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
    FormVendas.ClienteSelecionado  := ClienteDto;
    FormVendas.ProximaFaturaVenda  := StrToIntDef(edtFatura.Text, FService.BuscarProximaFatura);
    FormVendas.ShowModal;
    if FormVendas.ModalResult = mrOk then
      edtFatura.Text := IntToStr(FService.BuscarProximaFatura);

  finally
    FormVendas.Free;
    ClienteDto.Free;
  end;
end;



end.
