unit Documento.Utils;

interface

uses
  System.SysUtils;

function FormatarCPF(const ACPF: string): string;
function FormatarCNPJ(const ACNPJ: string): string;

implementation

function FormatarCPF(const ACPF: string): string;
var
  N: string;
begin
  N := ACPF.Trim.Replace('.', '').Replace('-', '');

  if Length(N) = 11 then
    Result := Format('%s.%s.%s-%s',
      [Copy(N, 1, 3),
       Copy(N, 4, 3),
       Copy(N, 7, 3),
       Copy(N, 10, 2)])
  else
    Result := ACPF;
end;

function FormatarCNPJ(const ACNPJ: string): string;
var
  N: string;
begin
  N := ACNPJ.Trim.Replace('.', '').Replace('-', '').Replace('/', '');

  if Length(N) = 14 then
    Result := Format('%s.%s.%s/%s-%s',
      [Copy(N, 1, 2),
       Copy(N, 3, 3),
       Copy(N, 6, 3),
       Copy(N, 9, 4),
       Copy(N, 13, 2)])
  else
    Result := ACNPJ;
end;

end.

