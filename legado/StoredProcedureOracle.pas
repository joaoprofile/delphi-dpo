unit StoredProcedureOracle;

interface

uses
  StoredProcedure, Variants, DB;

type
  TStoredProcedureOracle = class(TStoredProcedure)
  protected
    function getSQL: String; override;
  public
    function executar(getMetadata: Boolean = True): String; override;
  end;

implementation

{ TStoredProcedureOracle }

function TStoredProcedureOracle.executar(getMetadata: Boolean): String;
begin
  if getMetadata then
    addParametro('REC', null, ftCursor, ptResult);
  Result := inherited executar(getMetadata);
end;

function TStoredProcedureOracle.getSQL: String;
begin
  Result := 'begin'  + #13#10 +
    getTableSapace + '.' + getPackageName + '.' + inherited getSQL + ';' +
    #13#10 + 'end;';
end;

end.
