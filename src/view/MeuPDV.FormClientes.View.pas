unit MeuPDV.FormClientes.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Mask, Vcl.StdCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Buttons;

type
  TFormClientes = class(TForm)
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
    procedure FormCreate(Sender: TObject);
  private
    procedure AplicarEstilos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormClientes: TFormClientes;

implementation

{$R *.dfm}

uses Estilos;



procedure TFormClientes.FormCreate(Sender: TObject);
begin
  AplicarEstilos;

end;

procedure TFormClientes.AplicarEstilos;
begin
  pnlCabecalho.Color := COR_CABECALHO_AZUL;
  pnlGeral.Color := COR_FUNDO_CLARO;
  SpeedButton1.Flat := True;
  SpeedButton1.Font.Color := COR_TEXTO_BRANCO;
end;

end.
