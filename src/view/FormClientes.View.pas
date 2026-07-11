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
    btnPessoaFisica: TRadioButton;
    RadioButton1: TRadioButton;
    Edit1: TEdit;
    lblCpfCnpj: TLabel;
    LabeledEdit1: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    ImageList1: TImageList;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
  private
    procedure AplicarEstilos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClientes: TfrmClientes;

implementation

{$R *.dfm}

uses Estilos;



procedure TfrmClientes.FormCreate(Sender: TObject);
begin
  AplicarEstilos;

end;

procedure TfrmClientes.AplicarEstilos;
begin
  pnlCabecalho.Color := COR_CABECALHO_AZUL;
  pnlGeral.Color := COR_FUNDO_CLARO;
  SpeedButton1.Flat := True;
  SpeedButton1.Font.Color := COR_TEXTO_BRANCO;
end;

end.
