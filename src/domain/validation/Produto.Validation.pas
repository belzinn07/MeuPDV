unit Produto.Validation;

interface

uses
  Validador.Contracts, Validador.Utils, System.SysUtils,
  Produto.DTO;
type
 TProdutoValidador = class(TInterfacedObject, IValidador<TProdutoDTO>)

 private
    function PrecoValido(const APreco :string): Boolean;

 public
   procedure Validar(AProduto: TProdutoDTO);


 end;

implementation



{ TProdutoValidador }

function TProdutoValidador.PrecoValido(const APreco: string): Boolean;
var
 Valor: Currency;

begin
 Result := TryStrToCurr(APreco, Valor) and (Valor > 0);
end;

procedure TProdutoValidador.Validar(AProduto : TProdutoDTO);
begin
 ValidarCampo(PrecoValido(AProduto.Preco), 'Preço inválido ou não informado');
 ValidarCampo(Trim(AProduto.Descricao)<>'', 'Descrição é obrigatória');

end;

end.
