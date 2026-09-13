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
  constructor Create;
  destructor Destroy;

 end;

implementation

{ TVendaDTO }

constructor TVendaDTO.Create;
begin
 inherited;
 Itens := TObjectList<TItemVendaDTO>.Create(True);
end;

destructor TVendaDTO.Destroy;
begin
 Itens.Free;
 inherited;
end;

end.
