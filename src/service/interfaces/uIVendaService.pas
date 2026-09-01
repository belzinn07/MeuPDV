unit uIVendaService;

interface

uses
  uVendaDTO;

type
 IVendaService = interface
   ['{D7FB3891-CE6A-446F-99F9-66C0485633A2}']

   procedure Salvar(const AVendaDTO: TVendaDTO);

 end;

implementation

end.
