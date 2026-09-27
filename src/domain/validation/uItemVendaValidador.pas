unit uItemVendaValidador;

interface

uses
  uIValidador, uItemVendaDTO, System.SysUtils, uValidadorUtils;

type
 TItemVendaValidador = class(TInterfacedObject, IValidador<TItemVendaDTO>)

  private
   function PrecoValido(const AValorUnitario: Currency): Boolean;
   function ValorValido(const AQuantidade: Integer): Boolean;

  public
   procedure Validar(AItemVendaDTO : TItemVendaDTO);

 end;
implementation

{ TItemVendaValidator }

function TItemVendaValidador.PrecoValido(const AValorUnitario: Currency): Boolean;
begin
  Result := AValorUnitario > 0;
end;

function TItemVendaValidador.ValorValido(const AQuantidade: Integer): Boolean;
begin
  Result := AQuantidade > 0;
end;

procedure TItemVendaValidador.Validar(AItemVendaDTO: TItemVendaDTO);
begin

 ValidarCampo(ValorValido(AItemVendaDTO.IdProduto), 'Produto inválido' );
 ValidarCampo(PrecoValido(AItemVendaDTO.ValorUnitario), 'Preço inválido');
 ValidarCampo(ValorValido(AItemVendaDTO.Quantidade), 'Quantidade inválida');

end;

end.
