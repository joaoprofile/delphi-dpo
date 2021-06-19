unit Dpo.Core.EntitySQL;

interface

uses
  Dpo.Core.Interfaces;

type
  TEntitySQL = Class(TInterfacedObject, IEntitySQL)
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
    class function New(ADriveName: TDriverName): IEntitySQL;

    function Insert: IInsert;
    function Update: IUpdate;
    function Remove: IRemove;
    function Find: IFind;
    function CreateTable: ICreateTable;
    function DropTable: IDropTable;
  End;

implementation

uses
  Dpo.Operation.CreateTable, Vcl.Dialogs;

{ TDpoSQL }

class function TEntitySQL.New(ADriveName: TDriverName): IEntitySQL;
begin
  Result := self.Create(ADriveName);
end;

constructor TEntitySQL.Create(ADriveName: TDriverName);
begin
  FCreateTable  := TCreateTable.New(ADriveName);
  showmessage('CRIOU TEntitySQL')
end;

destructor TEntitySQL.Destroy;
begin

  inherited;
end;

function TEntitySQL.Insert: IInsert;
begin
  Result := FInsert;
end;

function TEntitySQL.Update: IUpdate;
begin
  Result := FUpdate;
end;

function TEntitySQL.Remove: IRemove;
begin
  Result := FRemove;
end;

function TEntitySQL.CreateTable: ICreateTable;
begin
  Result := FCreateTable;
end;

function TEntitySQL.DropTable: IDropTable;
begin
  Result := FDropTable;
end;

function TEntitySQL.Find: IFind;
begin
  Result := FFind;
end;

end.
