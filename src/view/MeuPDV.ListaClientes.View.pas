unit MeuPDV.ListaClientes.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MeuPDV.FormBaseListagem.View, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.Buttons, MeuPDV.DMConexao.infra;

type
  TfrmListaClientes = class(TfrmBaseListagem)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListaClientes: TfrmListaClientes;

implementation

{$R *.dfm}

end.
