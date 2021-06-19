unit Dpo.Core.EntityManager;

interface

uses
  Dpo.Core.Interfaces;

type
  TDpoSQL = Class(TInterfacedObject, IDPOSQL)
  Private
    FInsert: IInsert;
    FUpdate: IUpdate;
    FRemove: IRemove;
    FFind: IFind;
    FCreateTable: ICreateTable;
    FDropTable: IDropTable;
  Public
    constructor Create(ADriveName: TDriverName);
    destructor Destroy; override;
    class function New(ADriveName: TDriverName): IDPOSQL;

    function Insert: IInsert;
    function Update: IUpdate;
    function Remove: IRemove;
    function Find: IFind;
    function CreateTable: ICreateTable;
    function DropTable: IDropTable;
  End;

implementation

uses
  Dpo.Operation.CreateTable;

{ TDpoSQL }

class function TDpoSQL.New(ADriveName: TDriverName): IDPOSQL;
begin
  Result := self.Create(ADriveName);
end;

constructor TDpoSQL.Create(ADriveName: TDriverName);
begin
  FCreateTable  := TCreateTable.New(ADriveName);
end;

destructor TDpoSQL.Destroy;
begin

  inherited;
end;

function TDpoSQL.Insert: IInsert;
begin
  Result := FInsert;
end;

function TDpoSQL.Update: IUpdate;
begin
  Result := FUpdate;
end;

function TDpoSQL.Remove: IRemove;
begin
  Result := FRemove;
end;

function TDpoSQL.CreateTable: ICreateTable;
begin
  Result := FCreateTable;
end;

function TDpoSQL.DropTable: IDropTable;
begin
  Result := FDropTable;
end;

function TDpoSQL.Find: IFind;
begin
  Result := FFind;
end;

end.
