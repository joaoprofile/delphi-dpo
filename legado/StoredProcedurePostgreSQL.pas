unit StoredProcedurePostgreSQL;

interface

uses
  StoredProcedure, Classes;

type
  TStoredProcedurePostgreSQL = class(TStoredProcedure)
  protected
    function getSQL: String; override;
  end;
  
implementation

{ TStoredProcedurePostgreSQL }

function TStoredProcedurePostgreSQL.getSQL: String;
begin
  Result := 'select * from ' +  inherited getSQL;
end;

end.
