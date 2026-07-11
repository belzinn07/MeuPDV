unit MeuPDV.Logger;

interface

uses
  MeuPDV.LogTipo;

type
  TLogger = class

   private
     class procedure Log( ATipo: TLogTipo; const AContexto : string; const AMensagem : string );

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
begin

end;

end.
