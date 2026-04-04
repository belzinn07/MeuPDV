unit MeuPDV.DMConexao.infra;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet;

type
  TdmConexao = class(TDataModule)
    FDConexao: TFDConnection;
    qryCRUD: TFDQuery;
    qryClientes: TFDQuery;
    qryProdutos: TFDQuery;
    qryVendas: TFDQuery;
    FDTransacao: TFDTransaction;
    dsProdutos: TDataSource;
    dsClientes: TDataSource;
    dsVendas: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
