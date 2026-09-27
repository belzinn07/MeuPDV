unit uVendaDTO;

interface

uses
  System.Generics.Collections, uItemVendaDTO, uVendaStatus;

type
 TVendaDTO = class

 public
  Id: Integer;
  IdCliente: Integer;
  Data : TDateTime;
  Total : Currency;
  Status: TVendaStatus;
  NomeCliente: string;
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
