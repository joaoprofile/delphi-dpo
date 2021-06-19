unit Dpo.Driver.Factory;

interface

uses
  Classes, DB, Variants, Generics.Collections,

  Dpo.Driver.Interfaces,
  Dpo.Driver.Components,
  Dpo.Driver.ConnectionConfig,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Stan.Def,
  FireDAC.Stan.Param,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys.Intf,
  FireDAC.Phys,
  FireDAC.Comp.Client,
  FireDAC.UI.Intf,
  FireDac.VCLUI.Wait,
  FireDac.DApt,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef;

type
  TDPOConnectionPool = class(TThreadList<TFDConnection>)
  public
    function Acquire(AConnectionName: string): TFDConnection;
    procedure Release(Connection: TFDConnection);
  end;

  TDPODriverFactory = class(TInterfacedObject, IDPODriverFactory)
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection); overload;
    constructor Create; overload;
    class function New(AConnection: TFDConnection): IDPODriverFactory; overload;
    class function New: IDPODriverFactory; overload;

    function CreateConnection(AConnectionName: string): TFDConnection;
    function CreateTransaction: IDPOTransaction;
    function CreateQuery: IDPOQuery;
  end;

var
  DPOConnectionPool: TDPOConnectionPool;

implementation

uses
  System.SysUtils;

{ TDPOConnectionPool }

function TDPOConnectionPool.Acquire(AConnectionName: string): TFDConnection;
begin
  Result := TDPODriverFactory.new.CreateConnection('App4e');
  DPOConnectionPool.Add(Result);

  if not Result.Connected then
    Result.Connected := true;
end;

procedure TDPOConnectionPool.Release(Connection: TFDConnection);
begin
  DPOConnectionPool.remove(Connection);
  Connection.Free;
end;

{ TDPODriverFactory }

class function TDPODriverFactory.New: IDPODriverFactory;
begin
   result := self.Create;
end;

class function TDPODriverFactory.New(AConnection: TFDConnection): IDPODriverFactory;
begin
  result := self.Create(AConnection);
end;

constructor TDPODriverFactory.Create;
begin

end;

constructor TDPODriverFactory.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TDPODriverFactory.CreateConnection(AConnectionName: string): TFDConnection;
var
  Config: IConnectionConfig;
  Conn: TFDConnection;
begin
  Config := TConnectionConfig.New;

  Conn := TFDConnection.Create(nil);
  Conn.LoginPrompt := False;
  Conn.ConnectionDefName := Config.getConnectionName;

  case Config.getDriverName of
    Firebird:
      begin
        Conn.DriverName  := 'FB';
        Conn.Params.Text := Config.getParamsConnection;
      end;
  end;

  if Conn = nil then
    raise Exception.Create('Invalid connection settings. Cannot connect to database.');

  Result := Conn;
end;

function TDPODriverFactory.CreateTransaction: IDPOTransaction;
begin
  if FConnection = nil then
    Exit(nil);

  result := TDPOTransaction.New(FConnection);
end;

function TDPODriverFactory.CreateQuery: IDPOQuery;
begin
  if FConnection = nil then
    Exit(nil);

  Result := TDPOQuery.Create(FConnection);
end;

initialization
  DPOConnectionPool := TDPOConnectionPool.Create;

finalization
  DPOConnectionPool.Free;

end.
