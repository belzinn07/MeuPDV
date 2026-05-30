unit Produto.Validation;

interface

uses
  Validador.Contracts, Validador.Utils, Produto.Model, System.SysUtils;
type
 TProdutoValidador = class(TInterfacedObject, IValidador<TProduto>)

 private
    function PrecoValido(const APreco :Currency): Boolean;

 public
   procedure Validar(AProduto: TProduto);


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
