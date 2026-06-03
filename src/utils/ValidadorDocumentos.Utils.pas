unit ValidadorDocumentos.Utils;

interface

uses
 System.SysUtils;

type
 TValidadorDocumentos = class
  private
    class function TodosDigitosIguais(const NumDocumento: string): Boolean;
    class procedure SomenteNumeros(var NumDocumento: string; const ADocumento: string);

 public
   class function ValidarDocumento(const ADocumento : string; const ATamanho: Integer): Boolean;
 end;

implementation

{ TValidadorDocumentos }

class function TValidadorDocumentos.ValidarDocumento
(const ADocumento: string; const ATamanho: Integer): Boolean;
var
NumDocumento : string;

begin
 Result:= False;

 NumDocumento := '';


 SomenteNumeros(NumDocumento, ADocumento);

 if (Length(NumDocumento) <> ATamanho) or TodosDigitosIguais(NumDocumento) then Exit(False);

Result := True;
end;

class procedure TValidadorDocumentos.SomenteNumeros(var NumDocumento: string; const ADocumento: string);
var
  Caractere: Char;
begin
  for Caractere in ADocumento do
  begin
    if CharInSet(Caractere, ['0'..'9']) then
      NumDocumento := NumDocumento + Caractere;
  end;
end;

class function TValidadorDocumentos.TodosDigitosIguais
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
