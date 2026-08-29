unit uVenda;

interface

type
 TVenda = class

  private
   FId : Integer;
   FIdCliente : Integer;
   FData : TDateTime;
   FTotal : Double;

  public
   property Id : Integer read FId write FId;
   property IdCliente: Integer read FIdCliente write FIdCliente;
   property Data: TDateTime read FData write FData;
   property Total : Double read FTotal write FTotal;

 end;
implementation

end.
