unit FrmInicialVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Buttons, FrmVenda;

type
  TFormInicialVenda = class(TForm)
    pnlContainer: TPanel;
    pnlCabecalho: TPanel;
    cbxSelecionarCliente: TComboBox;
    edtFatura: TLabeledEdit;
    Label1: TLabel;
    btnConfirmar: TBitBtn;
    btnCancelar: TBitBtn;
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormInicialVenda: TFormInicialVenda;

implementation

{$R *.dfm}

procedure TFormInicialVenda.btnConfirmarClick(Sender: TObject);
var
 FormVendas : TFormVendas;
begin
 FormVendas := TFormVendas.Create(Self);

 try
   FormVendas.ShowModal;
 finally
   FormVendas.Free;
 end;

end;

end.
