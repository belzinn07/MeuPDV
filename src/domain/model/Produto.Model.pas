unit Produto.Model;

interface

uses
  Validador.Contracts, Validador.Utils, System.SysUtils;

type
  TProduto = class

   private
    FId : Integer;
    FDescricao: string;
    FPreco : Currency;
    FSaldo : Double;

   public

    property Id : Integer read FId write FId;
    property Descricao : string read FDescricao write FDescricao;
    property Preco : Currency read FPreco write FPreco;
    property Saldo : Double read FSaldo write FSaldo;

  end;

implementation

{ TProduto }

end.
