unit ListaClientes.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.Buttons, DMConexao.infra, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FormBaseListagem.View, FormClientes.View, Vcl.StdCtrls, ICliente.Service,
  System.Generics.Collections, Cliente.Model, Cliente.Service,
  ICliente.Repository, Cliente.Repository;

type
  TfrmListaClientes = class(TfrmBaseListagem)
    btnPesquisar: TSpeedButton;
    edtPesquisa: TEdit;
    dsClientes: TDataSource;
    MemTable: TFDMemTable;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FClienteService : IClienteService;
    FListaDeClientes : TObjectList<TCliente>;
    procedure ConfigurarMemtable;
    procedure CarregarClientes;


  end;

var
  frmListaClientes: TfrmListaClientes;

implementation

{$R *.dfm}

{ TfrmListaClientes }

procedure TfrmListaClientes.FormCreate(Sender: TObject);
var
  ClienteRepository: IClienteRepository;
begin
  ConfigurarMemtable;

  ClienteRepository := TClienteRepository.Create(dm);

  FClienteService := TClienteService.Create(ClienteRepository);

  FListaDeClientes := FClienteService.Listar;

  CarregarClientes;
end;

procedure TfrmListaClientes.FormDestroy(Sender: TObject);
begin
  inherited;
 FListaDeClientes.Free;
end;

procedure TfrmListaClientes.ConfigurarMemtable;
begin
  MemTable.Close;
  MemTable.FieldDefs.Add('ID', ftInteger);
  MemTable.FieldDefs.Add('NOME', ftString, 60);
  MemTable.FieldDefs.Add('CPF', ftString, 20);
  MemTable.FieldDefs.Add('CNPJ', ftString, 20);
  MemTable.FieldDefs.Add('TELEFONE', ftString, 20);
  MemTable.FieldDefs.Add('EMAIL', ftString, 50);

  MemTable.CreateDataSet;

  dsClientes.DataSet := MemTable;
  dbgItens.DataSource := dsClientes;

end;

procedure TfrmListaClientes.CarregarClientes;
var
 Cliente :TCliente;

begin
  if not Assigned(FListaDeClientes) then Exit;

  MemTable.DisableControls;

  try
    MemTable.EmptyDataSet;

    for Cliente in FListaDeClientes do
    begin
      MemTable.Append;
      MemTable.FieldByName('ID').AsInteger := Cliente.Id;
      MemTable.FieldByName('NOME').AsString := Cliente.Nome;
      MemTable.FieldByName('CPF').AsString := Cliente.CPF;
      MemTable.FieldByName('CNPJ').AsString := Cliente.CNPJ;
      MemTable.FieldByName('TELEFONE').AsString := Cliente.Telefone;
      MemTable.FieldByName('EMAIL').AsString := Cliente.Email;
      MemTable.Post;
    end;

  finally
   MemTable.EnableControls;

  end;

end;

end.
