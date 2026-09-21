unit uVendaStatus;

interface

uses
  System.SysUtils;

type
  TVendaStatus = (vsAberta, vsFechada, vsCancelada);

function VendaStatusToStr(Status: TVendaStatus): string;
function StrToVendaStatus(const S: string): TVendaStatus;

implementation

function VendaStatusToStr(Status: TVendaStatus): string;
begin
  case Status of
    vsFechada:   Result := 'FECHADA';
    vsCancelada: Result := 'CANCELADA';
  end;
end;

function StrToVendaStatus(const S: string): TVendaStatus;
begin
  if SameText(S, 'FECHADA') then
    Result := vsFechada
  else if SameText(S, 'CANCELADA') then
    Result := vsCancelada
  else
    raise Exception.Create('Status de venda inválido: ' + S);
end;

end.

