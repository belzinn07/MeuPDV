unit uProdutoValidador;

interface

uses
  uIValidador, uValidadorUtils, System.SysUtils,
  uProdutoDTO;
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
 ValidarCampo(PrecoValido(AProduto.Preco), 'Pre�o inv�lido ou n�o informado');
 ValidarCampo(Trim(AProduto.Descricao)<>'', 'Descri��o � obrigat�ria');
 ValidarCampo(Trim(AProduto.Saldo)<>'', 'Saldo n�o informado');
 ValidarCampo(StrToFloat(AProduto.Saldo) > 0, 'Saldo Inv�lido' )

end;

end.
