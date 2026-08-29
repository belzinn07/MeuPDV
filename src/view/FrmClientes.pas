unit FrmClientes;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Mask, Vcl.StdCtrls,
   System.ImageList, Vcl.ImgList, Vcl.Buttons, uEstilos, uClienteDTO, uIClienteService,
   uTipoPessoa, uDocumentoUtils,
   uServiceFactory;

type
  TFormClientes = class(TForm)
    pnlGeral: TPanel;
    pnlCabecalho: TPanel;
    RadioGroup1: TRadioGroup;
    rbPessoaFisica: TRadioButton;
    rbPessoaJuridica: TRadioButton;
    SpeedButton1: TSpeedButton;
    ImageList1: TImageList;
    pnlPessoaFisica: TPanel;
    lblCPF: TLabel;
    edtCPF: TMaskEdit;
    Label3: TLabel;
    edtTelefone: TMaskEdit;
    Label1: TLabel;
    edtCliente: TEdit;
    lblCliente: TLabel;
    pnlPessoaJuridica: TPanel;
    Label2: TLabel;
    Label5: TLabel;
    edtCNPJ: TMaskEdit;
    Label6: TLabel;
    MaskEdit3: TMaskEdit;
    edtInscricaoEstadual: TEdit;
    edtCodigo: TLabeledEdit;
    bntSalvar: TBitBtn;
    edtEmail: TEdit;
    lblEmail: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure rbPessoaFisicaClick(Sender: TObject);
    procedure rbPessoaJuridicaClick(Sender: TObject);
    procedure bntSalvarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FClienteDTO : TClienteDTO;
    FClienteService: IClienteService;
    procedure AplicarEstilos;
    procedure AtualizarTipoPessoa(ATipo : TTipoPessoa);

  public
    procedure PrepararCadastro;
    procedure PrepararEdicao(Aid : Integer);

  end;

var
  FormClientes: TFormClientes;

implementation

{$R *.dfm}

procedure TFormClientes.FormCreate(Sender: TObject);
begin

    FClienteService := TServiceFactory.ClienteService;
  AplicarEstilos;
  rbPessoaFisica.Checked := true;
  AtualizarTipoPessoa(tpFisica);

end;

procedure TFormClientes.FormDestroy(Sender: TObject);
begin
 FClienteDTO.Free;

end;

procedure TFormClientes.AtualizarTipoPessoa(ATipo: TTipoPessoa);
begin
  case ATipo of

    tpFisica:
      begin
        pnlPessoaFisica.Visible := True;
        pnlPessoaJuridica.Visible := False;
      end;

    tpJuridica:
      begin
        pnlPessoaFisica.Visible := False;
        pnlPessoaJuridica.Visible := True;
      end;

  end;

end;


procedure TFormClientes.bntSalvarClick(Sender: TObject);
var
  Cliente: TClienteDTO;
begin
  Cliente := TClienteDTO.Create;
  try
    if Assigned(FClienteDTO) then
      Cliente.Id := FClienteDTO.Id
    else
      Cliente.Id := 0;

    Cliente.Nome := edtCliente.Text;
    Cliente.Telefone := edtTelefone.Text;
    Cliente.Email := edtEmail.Text;

    if rbPessoaFisica.Checked then
    begin
      Cliente.TipoPessoa := tpFisica;
      Cliente.CPF := Trim(edtCPF.Text);

      if Cliente.Id = 0 then
      begin
        Cliente.CNPJ := '';
        Cliente.IE := '';
      end;
    end
    else
    begin
      Cliente.TipoPessoa := tpJuridica;
      Cliente.CNPJ := Trim(edtCNPJ.Text);
      if Cliente.Id = 0 then
        Cliente.CPF := '';
      Cliente.IE := edtInscricaoEstadual.Text;
    end;

    FClienteService.Salvar(Cliente);

    ShowMessage('Cliente salvo com sucesso!' + sLineBreak +
                'Código: ' + Cliente.Id.ToString);

    ModalResult := mrOk;

  except
    on E: Exception do
      ShowMessage(E.Message);
  end;

  Cliente.Free;
end;



procedure TFormClientes.PrepararCadastro;
begin
  FreeAndNil(FClienteDTO);

  edtCodigo.Text := 'Novo';
  edtCliente.Clear;
  edtCPF.Clear;
  edtCNPJ.Clear;
  edtEmail.Clear;
  edtTelefone.Clear;
  edtInscricaoEstadual.Clear;

  rbPessoaFisica.Checked := True;
  AtualizarTipoPessoa(tpFisica);
end;


procedure TFormClientes.PrepararEdicao(Aid: Integer);
begin
  FreeAndNil(FClienteDTO);

  FClienteDTO := FClienteService.BuscarPorId(Aid);

  if not Assigned(FClienteDTO) then
    raise Exception.Create('Cliente não encontrado.');

  edtCodigo.Text := FClienteDTO.Id.ToString;
  edtCliente.Text := FClienteDTO.Nome;
  edtCPF.Text := FormatarCPF(FClienteDTO.CPF);
  edtCNPJ.Text := FormatarCNPJ(FClienteDTO.CNPJ);
  edtEmail.Text := FClienteDTO.Email;
  edtTelefone.Text := FClienteDTO.Telefone;
  edtInscricaoEstadual.Text := FClienteDTO.IE;

  case FClienteDTO.TipoPessoa of
    tpFisica:
      begin
        rbPessoaFisica.Checked := True;
        AtualizarTipoPessoa(tpFisica);
      end;

    tpJuridica:
      begin
        rbPessoaJuridica.Checked := True;
        AtualizarTipoPessoa(tpJuridica);
      end;
  end;
end;

procedure TFormClientes.rbPessoaFisicaClick(Sender: TObject);
begin
  AtualizarTipoPessoa(tpFisica);
end;

procedure TFormClientes.rbPessoaJuridicaClick(Sender: TObject);
begin
  AtualizarTipoPessoa(tpJuridica);
end;

procedure TFormClientes.AplicarEstilos;
begin
  pnlCabecalho.Color := COR_CABECALHO_AZUL;
  pnlGeral.Color := COR_FUNDO_CLARO;
  SpeedButton1.Flat := True;
  SpeedButton1.Font.Color := COR_TEXTO_BRANCO;
end;

end.