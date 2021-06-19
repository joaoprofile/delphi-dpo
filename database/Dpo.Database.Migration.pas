unit Dpo.Database.Migration;

interface

uses
  Classes, SysUtils, Dpo.Core.Interfaces;

type
  TDatabaseMigration = Class(TInterfacedObject, IMigration)
  Private
    FTable: string;
  Public
    constructor Create;
    destructor Destroy; override;
    class function New: IMigration;

    function Up(queryRunner: IQueryRunner): IMigration;
    function Down(queryRunner: IQueryRunner): IMigration;
  End;

implementation

{ TMigrationFirebird }

class function TDatabaseMigration.New: TDatabaseMigration;
begin
   result := self.create()
end;

constructor TDatabaseMigration.Create;
begin

end;

destructor TDatabaseMigration.Destroy;
begin

  inherited;
end;

end.

