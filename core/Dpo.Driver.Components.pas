unit Dpo.Driver.Components;

interface

uses
  Classes, DB, Variants, Generics.Collections,

  Dpo.Driver.Interfaces, FireDAC.Comp.Client;

type
  TDPOQuery = class(TInterfacedObject, IDPOQuery)
  private
    FConnection : TFDConnection;
    FQuery : TFDQuery;
    FQueryResult : TFDQuery;
    FParams : TParams;
  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;
    class function New(AConnection: TFDConnection): IDPOQuery;

    function SQL : TStrings;
    function Params : TParams; overload;
    function SQLCommand(SQLCommand: string): IDPOQuery;
    function Dataset: TDataSet;
    function Execute: IDPOQuery;
    function ExecuteQuery: TDataset;
    function ExecSQL(SQLCommand: string): IDPOQuery; overload;
    function ExecSQL: IDPOQuery; overload;
  end;

  TDPOTransaction = class(TInterfacedObject, IDPOTransaction)
  private
    FDPOConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    class function New(AConnection: TFDConnection): IDPOTransaction;

    function BeginTransaction: IDPOTransaction;
    procedure Commit;
    procedure Rollback;
  end;

implementation

uses
  System.SysUtils, Dpo.Driver.ConnectionConfig;

{ TDPOQuery }

class function TDPOQuery.New(AConnection: TFDConnection): IDPOQuery;
begin
  Result := Self.Create(AConnection);
end;

constructor TDPOQuery.Create(AConnection: TFDConnection);
begin
  FQuery := TFDQuery.Create(nil);

  FConnection := AConnection;

  FQuery.Connection := FConnection;
  FQuery.FetchOptions.Unidirectional := true;
end;

destructor TDPOQuery.Destroy;
begin
  FreeAndNil(FQuery);
  FreeAndNil(FQueryResult);

  if Assigned(FParams) then
    FreeAndNil(FParams);

  inherited;
end;

function TDPOQuery.Dataset: TDataSet;
begin
  Result := TDataSet(FQuery);
end;

function TDPOQuery.ExecSQL: IDPOQuery;
begin
  FQuery.ExecSQL();
end;

function TDPOQuery.ExecSQL(SQLCommand: string): IDPOQuery;
begin
  FQuery.ExecSQL(SQLCommand);
end;

function TDPOQuery.Execute: IDPOQuery;
begin
  Result := Self;
  FQuery.Close;

  if Assigned(FParams) then
    FQuery.Params.Assign(FParams);

  FQuery.Prepare;
  FQuery.Open;

  if Assigned(FParams) then
    FreeAndNil(FParams);
end;

function TDPOQuery.ExecuteQuery: TDataset;
var
  I: Integer;
begin
  try
    FQueryResult := TFDQuery.Create(nil);
    FQueryResult.Connection := FQuery.Connection;
    FQueryResult.SQL := FQuery.SQL;
    FQueryResult.FetchOptions.Unidirectional := true;

    for I := 0 to FQuery.Params.Count - 1 do
    begin
      FQueryResult.Params[I].DataType := FQuery.Params[I].DataType;
      FQueryResult.Params[I].Value := FQuery.Params[I].Value;
    end;

    FQueryResult.OpenOrExecute;
  except
    FQueryResult.Free;
    raise;
  end;

  Result := FQueryResult;
end;

function TDPOQuery.Params: TParams;
begin
  if not Assigned(FParams) then
  begin
    FParams := TParams.Create(nil);
    FParams.Assign(FQuery.Params);
  end;
  Result := FParams;
end;

function TDPOQuery.SQL: TStrings;
begin
  Result := FQuery.SQL;
end;

function TDPOQuery.SQLCommand(SQLCommand: string): IDPOQuery;
begin
  Result := Self;
  FQuery.SQL.Text := SQLCommand;
end;

{ TDPOTransaction }

class function TDPOTransaction.New(
  AConnection: TFDConnection): IDPOTransaction;
begin
  result := self.Create(AConnection);
end;

constructor TDPOTransaction.Create(AConnection: TFDConnection);
begin
  FDPOConnection := AConnection;
end;

function TDPOTransaction.BeginTransaction: IDPOTransaction;
begin
  Result := self;

  if FDPOConnection = nil then
    Exit(nil);

  FDPOConnection.Connected := true;

  if not FDPOConnection.InTransaction then
    FDPOConnection.StartTransaction;
end;

procedure TDPOTransaction.Commit;
begin
  if (FDPOConnection = nil) then
    Exit;

  FDPOConnection.Commit;
end;

procedure TDPOTransaction.Rollback;
begin
  if (FDPOConnection = nil) then
    Exit;

  FDPOConnection.Rollback;
end;

end.
