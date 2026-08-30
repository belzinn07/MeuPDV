unit uVendaDTO;

interface

uses
  System.Generics.Collections, uItemVendaDTO;

type
 TVendaDTO = class

 public
  Id: Integer;
  IdCliente: string;
  Data : TDateTime;
  Total : Currency;
  Itens: TObjectList<TItemVendaDTO>;

 end;

implementation

end.
