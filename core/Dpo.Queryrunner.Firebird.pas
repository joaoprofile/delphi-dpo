unit Dpo.Queryrunner.Firebird;

interface

uses
  Classes, SysUtils, Dpo.Core.Interfaces;

type
  TRunner = (qrCreateTable, qrDropTable);
  TQueryRunnerFirebird = Class(TInterfacedObject, IQueryRunner)
  Private
    FTable: String;
    FSQL: String;
    FDDL: String;
    FRunner: TRunner;
  Public
    constructor Create;
    destructor Destroy; override;
    class function New: IQueryRunner;

    function CreateTable: IQueryRunner;
    function DropTable: IQueryRunner;

    function Table: string; overload;
    function Table(value: string): IQueryRunner; overload;

    function DDL(value: string): IQueryRunner; overload;
    function DDL: String; overload;

    function Execute: Boolean;
  End;

implementation

{ TMigrationFirebird }

class function TQueryRunnerFirebird.New: IQueryRunner;
begin
   result := self.create()
end;

constructor TQueryRunnerFirebird.Create;
begin

end;

destructor TQueryRunnerFirebird.Destroy;
begin

  inherited;
end;

function TQueryRunnerFirebird.CreateTable: IQueryRunner;
begin
  result := Self;
  FRunner := qrCreateTable;
end;

function TQueryRunnerFirebird.DropTable: IQueryRunner;
begin
  result := Self;
  FRunner := qrCreateTable;
end;

function TQueryRunnerFirebird.Table(value: string): IQueryRunner;
begin
  result := self;
  FTable := Value;
end;

function TQueryRunnerFirebird.Table: string;
begin
  result := FTable;
end;

function TQueryRunnerFirebird.DDL(value: string): IQueryRunner;
var
  Cmd: string;
  ident: string;
  B, E: string;
begin
  Result := Self;
  ident := ' ';
  b := '(';
  E := ')';

  case FRunner of
    qrCreateTable: Cmd := 'CREATE TABLE' + ident + self.Table + B;
    qrDropTable: Cmd := 'DROP TABLE' + ident + Self.Table;
  end;

  FDDL := Cmd + value + E;
end;

function TQueryRunnerFirebird.DDL: String;
begin
  Result := FDDL;
end;

function TQueryRunnerFirebird.Execute: Boolean;
begin

end;

end.

