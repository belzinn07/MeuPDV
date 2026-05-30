unit ValidadorDocumentos.Utils;

interface

uses
 System.SysUtils;

type
 TValidadorDocumentos = class
  private
    function TodosDigitosIguais(const NumDocumento: string): Boolean;

 public
    function ValidarDocumento(const ADocumento : string; const ATamanho: Integer): Boolean;
 end;

implementation

{ TValidadorDocumentos }

function TValidadorDocumentos.ValidarDocumento
(const ADocumento: string; const ATamanho: Integer): Boolean;
var
NumDocumento : string;
Caractere: Char;

begin
 Result:= False;

 NumDocumento := '';

 for Caractere in ADocumento do
 begin
    if CharInSet(Caractere, ['0'..'9']) then
    NumDocumento := NumDocumento + Caractere;
 end;

 if (Length(NumDocumento) <> ATamanho) or TodosDigitosIguais(NumDocumento) then Exit(False);

Result := True;
end;

function TValidadorDocumentos.TodosDigitosIguais
(const NumDocumento: string): Boolean;
var
  I: Integer;
begin
  if NumDocumento = '' then Exit(False);

Result := True;

   for I := 2 to Length(NumDocumento) do
   begin
    if NumDocumento[I] <> NumDocumento[1] then Exit(False);
   end;
end;

end.
