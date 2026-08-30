unit uVendaValidador;

interface

uses
  uIValidador, uVendaDTO, uValidadorUtils, System.SysUtils;

type

 TVendaValidador = class(TInterfacedObject, IValidador<TVendaDTO>)

   private
    function ClienteValido( const AIdCliente : string): Boolean;

   public
    procedure Validar(AVenda : TVendaDTO);

 end;

implementation

{ TVendaValidador }


function TVendaValidador.ClienteValido(const AIdCliente: string): Boolean;
var
 IdCliente : Integer;

begin
 Result := TryStrToInt(AIdCliente, IdCliente) and (IdCliente > 0);
end;

procedure TVendaValidador.Validar(AVenda: TVendaDTO);
begin
  ValidarCampo(Trim(AVenda.IdCliente) <> '', 'Selecione um cliente');
  ValidarCampo(ClienteValido(AVenda.IdCliente), 'Cliente selecionado é inválido');

end;

end.
