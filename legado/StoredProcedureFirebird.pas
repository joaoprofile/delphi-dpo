unit StoredProcedureFirebird;

interface

uses
  StoredProcedure, Classes;

type
  TStoredProcedureFirebird = class(TStoredProcedure)
  protected
    function getSQL: String; override;
  end;
  
implementation

{ TStoredProcedureFirebird }

function TStoredProcedureFirebird.getSQL: String;
begin
  Result := 'select * from ' +  inherited getSQL;
end;

end.
