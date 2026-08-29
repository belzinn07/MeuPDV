unit uLogger;

interface

uses
  uLogTipo,
  System.SysUtils, System.Classes;

type
  TLogger = class

   private
     class procedure Log( ATipo: TLogTipo; const AContexto : string; const AMensagem : string );
     class function ObterPastaLogs : string;
     class function ObterPastaMes(const APastaBase:string) : string;
     class function ObterArquivoLog(const APastaBase:string) : string;
     class function TipoParaTexto(ATipo: TLogTipo): string;

   public
     class procedure Info(const AContexto, AMensagem: string);
     class procedure Warning(const AContexto, AMensagem: string);
     class procedure Erro(const AContexto, AMensagem: string);
     class procedure Debug(const AContexto, AMensagem: string);
  end;


implementation

{ TLogger }

class procedure TLogger.Info(const AContexto, AMensagem: string);
begin
 Log(ltInfo, AContexto, AMensagem);
end;

class procedure TLogger.Warning(const AContexto, AMensagem: string);
begin
 Log(ltWarning, AContexto, AMensagem);
end;

class procedure TLogger.Erro(const AContexto, AMensagem: string);
begin
 Log(ltErro, AContexto, AMensagem);
end;


class procedure TLogger.Debug(const AContexto, AMensagem: string);
begin
 Log(ltDebug, AContexto, AMensagem);
end;

class procedure TLogger.Log(ATipo: TLogTipo; const AContexto, AMensagem: string);
var
 PastaLogs : string;
 PastaMes : string;
 CaminhoArquivoLogs : string;
 LinhaDoLog :string;
 Writer : TStreamWriter;

begin
  PastaLogs := ObterPastaLogs();
  PastaMes := ObterPastaMes(PastaLogs);
  CaminhoArquivoLogs := ObterArquivoLog(PastaMes);

  LinhaDoLog := Format('[%s] [%s] [%s] %s',
                     [
                      FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', Now),
                      TipoParaTexto(ATipo),
                      AContexto,
                      AMensagem
                      ]);

  try
   Writer := TStreamWriter.Create(CaminhoArquivoLogs,True, TEncoding.UTF8);
    try
     Writer.WriteLine(LinhaDoLog);
    finally
     Writer.Free;
    end;
  except

  end;

end;

class function TLogger.ObterPastaLogs: string;
var
 CaminhoExecutavel : string;

begin
 CaminhoExecutavel := ExtractFilePath(ParamStr(0));
 Result := IncludeTrailingPathDelimiter(CaminhoExecutavel) + 'Logs';
end;

class function TLogger.ObterPastaMes(const APastaBase: string): string;
var
  Mes: string;
begin
  Mes := FormatDateTime('yyyy-mm', Date);
  Result := IncludeTrailingPathDelimiter(APastaBase) + Mes;
  ForceDirectories(Result);
end;

class function TLogger.ObterArquivoLog(const APastaBase: string): string;
var
  Arquivo: string;
begin
  Arquivo := FormatDateTime('dd', Date) + '.txt';
  Result := IncludeTrailingPathDelimiter(APastaBase) + Arquivo;
end;

class function TLogger.TipoParaTexto(ATipo: TLogTipo): string;
begin
 case ATipo of
   ltInfo : Result := 'INFO';
   ltWarning : Result := 'WARNING';
   ltErro : Result := 'ERRO' ;
   ltDebug : Result := 'DEBUG';

   else
    Result := 'DESCONHECIDO';

 end;

end;

end.
