unit uIVendaService;

interface

uses
  uVendaDTO;

type
  IVendaService = interface
    ['{8C4E9A2B-3F1D-4C7A-9B0E-D5A8F21C6B3D}']

    procedure Salvar(const AVendaDTO: TVendaDTO);

  end;

implementation

end.