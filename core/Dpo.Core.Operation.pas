unit Dpo.Core.Operation;

interface

uses
  Dpo.Core.Interfaces;

const
  ident: String = '  ';

type
  TMetadata = Class(TInterfacedObject, IMetadata)
  Private
    FFields: string;
    FValues: String;
    FTable: string;
    FPK: String;
    FWhere: String;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IMetadata;

    function Fields: String; overload;
    function Fields(Value: String): IMetadata; overload;
    function Table: String; overload;
    function Table(Value: String): IMetadata; overload;
    function PK: String; overload;
    function PK(Value: String): IMetadata; overload;
    function Where: String; overload;
    function Where(Value: String): IMetadata; overload;
    function Values: String; overload;
    function Values(Value: String): IMetadata; overload;
  End;

implementation

{ TMetadata }

class function TMetadata.New: IMetadata;
begin
  Result := self.Create;
end;

constructor TMetadata.Create;
begin

end;

destructor TMetadata.Destroy;
begin

  inherited;
end;

function TMetadata.Fields: String;
begin
  Result := FFields;
end;

function TMetadata.Fields(Value: String): IMetadata;
begin
  FFields := Value;
end;

function TMetadata.PK(Value: String): IMetadata;
begin
  FPK := Value;
end;

function TMetadata.PK: String;
begin
  Result := FPK;
end;

function TMetadata.Table(Value: String): IMetadata;
begin
  FTable := Value;
end;

function TMetadata.Table: String;
begin
  Result := FTable;
end;

function TMetadata.Values: String;
begin
  Result := FValues;
end;

function TMetadata.Values(Value: String): IMetadata;
begin
  FValues := Value;
end;

function TMetadata.Where: String;
begin
  Result := FWhere;
end;

function TMetadata.Where(Value: String): IMetadata;
begin
  FWhere := Value;
end;

end.
