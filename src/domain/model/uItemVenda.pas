unit uItemVenda;

interface

type
 TItemVenda = class

  private
   FId : Integer;
   FIdVenda: Integer;
   FIdProduto: Integer;
   FQuantidade : Integer;
   FValorUnitario : Currency;

  public
   property Id : Integer read FId write FId;
   property IdVenda : Integer read FIdVenda write FIdVenda;
   property IdProduto : Integer read FIdProduto write FIdProduto;
   property Quantidade: Integer read FQuantidade write FQuantidade;
   property ValorUnitario : Currency read FValorUnitario write FValorUnitario;

 end;
implementation

end.
