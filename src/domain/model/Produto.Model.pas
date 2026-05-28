unit Produto.Model;

interface

uses
  Validador.Contracts, Validador.Utils, System.SysUtils;

type
  TProduto = class(TInterfacedObject, IValidador)

   private
    FId : Integer;
    FDescricao: string;
    FPreco : Currency;
    FSaldo : Double;

   public

    procedure Validar;
    property Id : Integer read FId write FId;
    property Descricao : string read FDescricao write FDescricao;
    property Preco : Currency read FPreco write FPreco;
    property Saldo : Double read FSaldo write FSaldo;

  end;

implementation

{ TProduto }


procedure TProduto.Validar;
begin

ValidarCampo(Trim(FDescricao)<> '', 'Descrição é obrigatória');
ValidarCampo(FPreco > 0 , 'Preço deve ser maior que zero' );

end;


end.
