unit uVenda;

interface

uses
  System.Generics.Collections, uItemVenda, uVendaStatus;

type
 TVenda = class

  private
   FId : Integer;
   FIdCliente : Integer;
   FData : TDateTime;
   FTotal : Currency;
   FItens: TObjectList<TItemVenda>;
   FStatus: TVendaStatus;


  public
   constructor Create;
   destructor Destroy; override;

   property Id : Integer read FId write FId;
   property IdCliente: Integer read FIdCliente write FIdCliente;
   property Data: TDateTime read FData write FData;
   property Total : Currency read FTotal write FTotal;
   property Status: TVendaStatus read FStatus write FStatus;
   property Itens: TObjectList<TItemVenda> read FItens;

 end;
implementation

{ TVenda }

constructor TVenda.Create;
begin
  inherited;
  FItens:= TObjectList<TItemVenda>.Create(True);
end;

destructor TVenda.Destroy;
begin
  FItens.Free;
  inherited;
end;

end.
