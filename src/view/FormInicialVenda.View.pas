unit FormInicialVenda.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Buttons;

type
  TFormInicialVenda = class(TForm)
    pnlContainer: TPanel;
    pnlCabecalho: TPanel;
    cbxSelecionarCliente: TComboBox;
    edtFatura: TLabeledEdit;
    Label1: TLabel;
    btnConfirmar: TBitBtn;
    btnCancelar: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormInicialVenda: TFormInicialVenda;

implementation

{$R *.dfm}

end.
