unit DMConexao.infra;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, System.IniFiles, Vcl.Dialogs;

type
  Tdm = class(TDataModule)
    FDConexao: TFDConnection;
    qryCRUD: TFDQuery;
    qryClientes: TFDQuery;
    qryProdutos: TFDQuery;
    qryVendas: TFDQuery;
    FDTransacao: TFDTransaction;
    dsClientes: TDataSource;
    dsVendas: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
      procedure CarregarConfiguracoes;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}



procedure Tdm.CarregarConfiguracoes;
var
  Ini: TIniFile;
  CaminhoBanco: string;
begin
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
  try
    CaminhoBanco := Ini.ReadString('Banco', 'Database', '');
    FDConexao.Params.Values['Database'] := CaminhoBanco;
  finally
    Ini.Free;
  end;
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
 CarregarConfiguracoes;
 FDConexao.Connected := True;
end;

end.
