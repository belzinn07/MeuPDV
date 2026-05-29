unit Produto.Validation;

interface

uses
  Validador.Contracts, Validador.Utils, Produto.Model, System.SysUtils;
type
 TProdutoValidador = class(TInterfacedObject, IValidador<TProduto>)

 public
   procedure Validar(AProduto: TProduto);
   function PrecoValido(const APreco :Currency): Boolean;

 end;

implementation



{ TProdutoValidador }

function TProdutoValidador.PrecoValido(const APreco: Currency): Boolean;
begin
 Result := APreco > 0;
end;

procedure TProdutoValidador.Validar(AProduto : TProduto);
begin
 ValidarCampo(PrecoValido(AProduto.Preco), 'Preço inválido ou não informado');
 ValidarCampo(Trim(AProduto.Descricao)<>'', 'Descrição é obrigatória');

end;

end.
