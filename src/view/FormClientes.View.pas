unit FormClientes.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Mask, Vcl.StdCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Buttons;

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
    edtEmail: TEdit;
    lblEmail: TLabel;
    Label3: TLabel;
    edtTelefone: TMaskEdit;
    Label1: TLabel;
    edtCliente: TEdit;
    lblCliente: TLabel;
    Edit1: TEdit;
    lblCodigo: TLabel;
    pnlPessoaJuridica: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    MaskEdit1: TMaskEdit;
    Edit2: TEdit;
    Label6: TLabel;
    MaskEdit3: TMaskEdit;
    Edit3: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure rbPessoaFisicaClick(Sender: TObject);
    procedure rbPessoaJuridicaClick(Sender: TObject);
  private
    procedure AplicarEstilos;
    procedure AtualizarCampos;

  public
    { Public declarations }
  end;

var
  frmClientes: TfrmClientes;

implementation

{$R *.dfm}

uses Estilos;



procedure TfrmClientes.AtualizarCampos;
begin
   pnlPessoaFisica.Visible := rbPessoaFisica.Checked;
   pnlPessoaJuridica.Visible := rbPessoaJuridica.Checked;
end;

procedure TfrmClientes.FormCreate(Sender: TObject);
begin
  AplicarEstilos;
  rbPessoaFisica.Checked := true;
  AtualizarCampos;
end;

procedure TfrmClientes.rbPessoaFisicaClick(Sender: TObject);
begin
  AtualizarCampos;
end;

procedure TfrmClientes.rbPessoaJuridicaClick(Sender: TObject);
begin
  AtualizarCampos;
end;

procedure TfrmClientes.AplicarEstilos;
begin
  pnlCabecalho.Color := COR_CABECALHO_AZUL;
  pnlGeral.Color := COR_FUNDO_CLARO;
  SpeedButton1.Flat := True;
  SpeedButton1.Font.Color := COR_TEXTO_BRANCO;
end;

end.
