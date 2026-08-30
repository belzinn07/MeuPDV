unit uItemVendaValidador;

interface

uses
  uIValidador, uItemVendaDTO, System.SysUtils, uValidadorUtils;

type
 TItemVendaValidador = class(TInterfacedObject, IValidador<TItemVendaDTO>)

  private
   function PrecoValido(const AValorUnitario : string) : Boolean;
   function ValorValido(const AQuantidade : string) : Boolean;

  public
   procedure Validar(AItemVendaDTO : TItemVendaDTO);

 end;
implementation

{ TItemVendaValidator }

function TItemVendaValidador.PrecoValido(const AValorUnitario: string): Boolean;
var
 ValorUnitario : Currency;

begin
  Result := TryStrToCurr(AValorUnitario, ValorUnitario) and (ValorUnitario > 0);
end;

function TItemVendaValidador.ValorValido(const AQuantidade: string): Boolean;
var
 Quantidade : Integer;

begin
 Result := TryStrToInt(AQuantidade, Quantidade) and (Quantidade > 0);
end;

procedure TItemVendaValidador.Validar(AItemVendaDTO: TItemVendaDTO);
begin

 ValidarCampo(ValorValido(AItemVendaDTO.IdProduto), 'Produto inválido' );
 ValidarCampo(PrecoValido(AItemVendaDTO.ValorUnitario), 'Preço inválido');
 ValidarCampo(ValorValido(AItemVendaDTO.Quantidade), 'Quantidade inválida');

end;

end.
