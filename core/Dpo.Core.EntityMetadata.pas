unit Dpo.Core.EntityMetadata;

interface

uses
  Dpo.Core.Interfaces;

const
  ident: String = '  ';

type
  TEntityMetadata = Class(TInterfacedObject, IEntityMetadata)
  Private
    FFields: string;
    FValues: String;
    FTable: string;
    FPK: String;
    FWhere: String;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IEntityMetadata;

    function Fields: String; overload;
    function Fields(Value: String): IEntityMetadata; overload;
    function Table: String; overload;
    function Table(Value: String): IEntityMetadata; overload;
    function PK: String; overload;
    function PK(Value: String): IEntityMetadata; overload;
    function Where: String; overload;
    function Where(Value: String): IEntityMetadata; overload;
    function Values: String; overload;
    function Values(Value: String): IEntityMetadata; overload;
  End;

implementation

{ TEntityMetadata }

class function TEntityMetadata.New: IEntityMetadata;
begin
  Result := self.Create;
end;

constructor TEntityMetadata.Create;
begin

end;

destructor TEntityMetadata.Destroy;
begin

  inherited;
end;

function TEntityMetadata.Fields: String;
begin
  Result := FFields;
end;

function TEntityMetadata.Fields(Value: String): IEntityMetadata;
begin
  FFields := Value;
end;

function TEntityMetadata.PK(Value: String): IEntityMetadata;
begin
  FPK := Value;
end;

function TEntityMetadata.PK: String;
begin
  Result := FPK;
end;

function TEntityMetadata.Table(Value: String): IEntityMetadata;
begin
  FTable := Value;
end;

function TEntityMetadata.Table: String;
begin
  Result := FTable;
end;

function TEntityMetadata.Values: String;
begin
  Result := FValues;
end;

function TEntityMetadata.Values(Value: String): IEntityMetadata;
begin
  FValues := Value;
end;

function TEntityMetadata.Where: String;
begin
  Result := FWhere;
end;

function TEntityMetadata.Where(Value: String): IEntityMetadata;
begin
  FWhere := Value;
end;

end.
