unit FormClientes.View;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Mask, Vcl.StdCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Buttons,Estilos, Cliente.Model, Cliente.Service,
  DMConexao.infra, TipoPessoa.Enums.Model, Documento.Utils,
  ICliente.Repository, Cliente.Repository;

type
  TfrmClientes = class(TForm)
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
    FCliente : TCliente;
    FClienteService: TClienteService;
    procedure AplicarEstilos;
    procedure AtualizarTipoPessoa(ATipo : TTipoPessoa);

  public
    procedure PrepararCadastro;
    procedure PrepararEdicao(Aid : Integer);

  end;

var
  frmClientes: TfrmClientes;

implementation

{$R *.dfm}

procedure TfrmClientes.FormCreate(Sender: TObject);
var
 ClienteRepository: IClienteRepository;
begin

   ClienteRepository := TClienteRepository.Create(dm);
    FClienteService := TClienteService.Create(ClienteRepository);
  AplicarEstilos;
  rbPessoaFisica.Checked := true;
  AtualizarTipoPessoa(tpFisica);

end;

procedure TfrmClientes.FormDestroy(Sender: TObject);
begin
 FClienteService.Free;
 FCliente.Free;

end;

procedure TfrmClientes.AtualizarTipoPessoa(ATipo: TTipoPessoa);
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


procedure TfrmClientes.bntSalvarClick(Sender: TObject);
begin
  if not Assigned(FCliente) then
    FCliente := TCliente.Create;

  try
    FCliente.Nome := edtCliente.Text;
    FCliente.Telefone := edtTelefone.Text;
    FCliente.Email := edtEmail.Text;

    if rbPessoaFisica.Checked then
    begin
      FCliente.TipoPessoa := tpFisica;
      FCliente.CPF := Trim(edtCPF.Text);

      if FCliente.Id = 0 then
      begin
        FCliente.CNPJ := '';
        FCliente.IE := '';
      end;
    end
    else
    begin
      FCliente.TipoPessoa := tpJuridica;
      FCliente.CNPJ := Trim(edtCNPJ.Text);
      if FCliente.Id = 0 then
        FCliente.CPF := '';
      FCliente.IE := edtInscricaoEstadual.Text;
    end;

    FClienteService.Salvar(FCliente);

    ShowMessage('Cliente salvo com sucesso!' + sLineBreak +
                'Código: ' + FCliente.Id.ToString);

    ModalResult := mrOk;

  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;



procedure TfrmClientes.PrepararCadastro;
begin
  FreeAndNil(FCliente);

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


procedure TfrmClientes.PrepararEdicao(Aid: Integer);
begin
  FreeAndNil(FCliente);

  FCliente := FClienteService.BuscarPorId(Aid);

  if not Assigned(FCliente) then
    raise Exception.Create('Cliente não encontrado.');

  edtCodigo.Text := FCliente.Id.ToString;
  edtCliente.Text := FCliente.Nome;
  edtCPF.Clear;
edtCPF.Text := FormatarCPF(FCliente.CPF);

edtCNPJ.Clear;
edtCNPJ.Text := FormatarCNPJ(FCliente.CNPJ);
  edtEmail.Text := FCliente.Email;
  edtTelefone.Text := FCliente.Telefone;
  edtInscricaoEstadual.Text := FCliente.IE;

  case FCliente.TipoPessoa of
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

procedure TfrmClientes.rbPessoaFisicaClick(Sender: TObject);
begin
  AtualizarTipoPessoa(tpFisica);
end;

procedure TfrmClientes.rbPessoaJuridicaClick(Sender: TObject);
begin
  AtualizarTipoPessoa(tpJuridica);
end;

procedure TfrmClientes.AplicarEstilos;
begin
  pnlCabecalho.Color := COR_CABECALHO_AZUL;
  pnlGeral.Color := COR_FUNDO_CLARO;
  SpeedButton1.Flat := True;
  SpeedButton1.Font.Color := COR_TEXTO_BRANCO;
end;

end.
