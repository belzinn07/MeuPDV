unit uVendaValidador;

interface

uses
  uIValidador, uVendaDTO, uValidadorUtils, System.SysUtils;

type

 TVendaValidador = class(TInterfacedObject, IValidador<TVendaDTO>)

   private
    function ClienteValido(AIdCliente: Integer): Boolean;

   public
    procedure Validar(AVenda : TVendaDTO);

 end;

implementation

{ TVendaValidador }


function TVendaValidador.ClienteValido(AIdCliente: Integer): Boolean;
begin
 Result := AIdCliente > 0;
end;

procedure TVendaValidador.Validar(AVenda: TVendaDTO);
begin
  ValidarCampo(AVenda.IdCliente > 0, 'Selecione um cliente');
  ValidarCampo(ClienteValido(AVenda.IdCliente), 'Cliente selecionado é inválido');

end;

end.
